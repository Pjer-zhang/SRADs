% author : pjer
% acroding to Nobeyama offical document
% date : 2017-08-01 23:02:35 
% plot .fit data

function [data,info] = srads_plot_norh_img(fname)
    if nargin < 1
        fname = '/Users/jing/Desktop/DATA/norh/ipa050803_024206';
        % for debug just ignore it 
    end
    
    infom = fitsinfo(fname);
    data = fitsread(fname);
    
    key_wd_id = infom.PrimaryData.Keywords(:,1);
    key_wd_val = infom.PrimaryData.Keywords(:,2);
    
    for num = 1:length(key_wd_id)
        word_f = key_wd_id{num};
        news = strrep(word_f,'-','_');
        key_wd_id{num}=news;
        if strcmp(key_wd_id{num},'COMMENT')
            key_wd_id{num}=[];
            key_wd_val{num}=[];
        end
    end
    
    emptyCells = cellfun('isempty', key_wd_id); 
    key_wd_val(all(emptyCells,2),:) = [];
    key_wd_id(all(emptyCells,2),:) = [];
        
    info = cell2struct(key_wd_val,key_wd_id,1);
    th = 0:0.001:2*pi;
    imagesc(data)
    colormap jet
    colorbar
    hold on
    plot(info.SOLR*cos(th)-info.CRVAL1+info.CRPIX1,info.SOLR*sin(th)-info.CRVAL2+info.CRPIX2,'w')
    title([(info.ORIGIN),' ',info.TELESCOP,' ( ',info.OBS_FREQ,' ',info.POLARIZ,' )'],'Fontsize',16)
    text(2,info.NAXIS2*0.98 ,info.PROGNAME,'fontsize',14,'color','w')
end
