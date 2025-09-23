Return-Path: <linux-kernel+bounces-828172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D1B941A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC543BA005
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114A258CF9;
	Tue, 23 Sep 2025 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VlR3cQxd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43E24E4AF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597982; cv=none; b=Tk8cphUaY0ENklt3v3o6zM3flqJzEoxm5QTwZ3OLJxjEpTjjpaey0jZ51ZxXO2p4gol4DwMqMk0JoiOuFyPzICn5ha+c/D1r65ln5JIqKXKrjefW4mWX3wpyZRvxX5rOiw7rK/eLocf/KwwtgnhjWCEEL7r5AVvRmB9QqndtZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597982; c=relaxed/simple;
	bh=/9okwRIp4AGyHNqa6uQ0KAc8kzAsFvI6jPY28fzJH5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzwMX8mmOIBCL7PHRZe4kGwjxZI21D7KGG+lWk/BxAdwkb8rdcxwvdQ1BBI5XB+CgEYacY91hrRPrkRsWFapWs+p2XMuVk5VOa3kVf2XFeHbLERiY/bHk2tnMz35QkTjrpKlOP+qF9e0gMHV6QjkhKmb9YjsxHtz5ucQk6Fy/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VlR3cQxd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH1hpp007111
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F3GWnZoDTq3sp/K2/e/shKmR
	rtysWnVz2jKe17D2uyM=; b=VlR3cQxdPlnuEF5mkZX+P72kr4YNH4WDaB9XC1Qo
	bAN8xNhhz5t+aHGfs4Mk2mMkHLuPmaUxu1R0HMdWoemoXDTP/nnPiFSh3NdzGQp8
	H+EO7hSdqiGKKaawM+jd9Bx0AOETSHA09WawaBmm0inDYLh9wIn2QnuwSGmx3xpt
	3BTQThiRcXApKYW/dmw/YlsRRvF6xJ/pF2HP0Q7tAVANM6SN7eu1u919ehGrjsUI
	IeHCdu8Po3+yUQJrU4OsG77Lp4I3NnlfXH6TN9QwhlOPBqIZEb/+ogkuqiJHwnFv
	1NmhK8j86qCE0iNNgdzT0X2/NZy/HUDd+Q6Vgo+mU/kDHA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1few3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:26:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78ea15d3583so86763326d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758597978; x=1759202778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3GWnZoDTq3sp/K2/e/shKmRrtysWnVz2jKe17D2uyM=;
        b=CWMrYr8hFEHvLOTNXgJuSljFzvvGJokCtlvxkpOG7kK4EtwiZ0R8AsPgkPwC0xxCoq
         6He5uRAzkM9jb8LDrpE5tBAWlGiZeztvGtIG0eGxTibstbqHnGzKESj+f2AveacgaNaS
         rmW+Sf99U+gPCL6+9xvgdCjoeCxvZagTj6CXsy4AIxaEatN0/2SYVHho3cgPEMMmJXGR
         FfCxQBlx2rqeTmrl4e5xhN3MyY8zwESM+JCLHuuG8YL9olmWw/tpzFAHnGazZlXAeFsV
         aKVX1AFwAnxkXYXdQwB0VFg5SYkX+Yf8+RxqwxYgfrULJjd1Ftnga2+oRqJl4IE9RwFt
         mXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIwfZ+G8kOvQhxTlV8DPpLgIpqcH0ehOcI7XTIiTXsOkx/+BNhZ/J6X/VXpkoRXxsNGZcuAHAF0SEvfUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRLrEU+xRqm3Q2N1NVXK9gasT3IYJLA4dxnBK9qJUB018wgcW
	sOlFSv8G1PGv9IjiPlnzKt1B7nqG6UEK631V/grlL5ZmZfr7/NbriRDqG/Onju4+j72s1AnBkdz
	H4ZcxdXdtxM1f9AQyQAvQVLd0hzW420MMkxSx74D1YnRLEuUMkh0p8maNtHUYf+RvkIE=
X-Gm-Gg: ASbGncv6VYNXqu1zJYp8cE/M6g7EGHTW1ey8kWGQ3D5QFyuk6zuOEirNrSTGzeM9Qdh
	0CzUENWrGZAZmDnNx69M6tK69uuN0K9hueCSXntd8FNmjbwmHC6EQDJdpGDJbn9TS4XbWfySB6S
	VEVpcADoNHZV48kEMb8PDKJNdS6ZiFPF9bctD5ftav+3Iz4J2ke+zB+XelsCQMeVBqP0bj1qcXE
	vHqPfwZUpHWxtmzCLMA7arjW0IxNScDPXNRLgyXPUX2uwbCW6P+weNe+F4Yn4tBLXw2OYn2w/gH
	R3a/CYnKEZi3r5AjGQBgAxCzLyVY7scmq+j9JnoMk1h6N18/wtZFLQuGMhmpZLt5jU3T5vkBOrh
	PUMAkP5ViopBU+NTO3yFwVQRzxPbU7TISntumrMvdFPI7VaenREvE
X-Received: by 2002:a05:6214:5184:b0:7a2:7dd5:a529 with SMTP id 6a1803df08f44-7e715457b81mr13988506d6.32.1758597978255;
        Mon, 22 Sep 2025 20:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCyCVOG3I8IOeAlxq627lGyS4LI/Q55RrD7NxcdRqumGitid3wdqGpVNnvz0boAGvkOcRioQ==
X-Received: by 2002:a05:6214:5184:b0:7a2:7dd5:a529 with SMTP id 6a1803df08f44-7e715457b81mr13988316d6.32.1758597977705;
        Mon, 22 Sep 2025 20:26:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57a9a81f52asm2683912e87.124.2025.09.22.20.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:26:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:26:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: srini@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.dev,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: wcd934x: fix error handling in
 wcd934x_codec_parse_data()
Message-ID: <unqzejlsp6emzja5ry32smzlinntodgbioyojr5osiqddh2ppi@mtf4e7y4cids>
References: <20250923023828.36647-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923023828.36647-1-make24@iscas.ac.cn>
X-Proofpoint-ORIG-GUID: -rPBL0taAqxon2yO-SBhod4yuiDZUZj_
X-Proofpoint-GUID: -rPBL0taAqxon2yO-SBhod4yuiDZUZj_
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d2135b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=dSz2rv1DY3fttFFokb4A:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX5vnXL3rKOrbS
 yujOFk6GcvfVEjhRdVA7eM2zdXbHyFVqIRm262o5wekQzJzKQ6Qy01wOTsCbblSpIc0D2yM3C8e
 DOqa7LG23IyKJeX5MSfe7mwCX0kdiYwjHPm0bdHstE6Eycvks+D9zNOw2pbb39I0vr96l3lMa0X
 dKpVfaJJtCQrwcbqr5HjMG/JjSBBKSoPu0fpGXFBb5GllVb2MIuGxfWWvfA8xfM5iOrWYq5J071
 c/vdlKeBwqM+p4Q2oUzZyEEcYKQqmfp25bvicjCCsMrAQAubkEBSKmeCqMYqkTJCqOVSll2NdDx
 PK2bXw2afbxIvXU91UTT/QU0CpNrUc5GuTAkXNptBT5AkFLaJoiFZCRXdcJsUTYc6+3ATkMMeB8
 cV0R80Jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Tue, Sep 23, 2025 at 10:38:28AM +0800, Ma Ke wrote:
> wcd934x_codec_parse_data() contains a device reference count leak in
> of_slim_get_device() where device_find_child() increases the reference
> count of the device but this reference is not properly decreased in
> the success path. Add put_device() in wcd934x_codec_parse_data() and
> add devm_add_action_or_reset() in the probe function, which ensures
> that the reference count of the device is correctly managed.
> 
> Memory leak in regmap_init_slimbus() as the allocated regmap is not
> released when the device is removed. Using devm_regmap_init_slimbus()
> instead of regmap_init_slimbus() to ensure automatic regmap cleanup on
> device removal.
> 
> Calling path: of_slim_get_device() -> of_find_slim_device() ->
> device_find_child(). As comment of device_find_child() says, 'NOTE:
> you will need to drop the reference with put_device() after use.'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - added a wrapper function due to the warning report from kernel test robot;
> Changes in v2:
> - modified the handling in the success path and fixed the memory leak for regmap as suggestions.
> ---
>  sound/soc/codecs/wcd934x.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 1bb7e1dc7e6b..d9d8cf64977a 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -5831,6 +5831,15 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
>  	.endianness = 1,
>  };
>  
> +static void wcd934x_put_device_action(void *data)
> +{
> +	struct device *dev = data;
> +
> +	if (dev) {

Can it be NULL here? Can put_device() cope with NULL being passed to it?

> +		put_device(dev);
> +	}
> +}
> +
>  static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
>  {
>  	struct device *dev = &wcd->sdev->dev;
> @@ -5847,11 +5856,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
>  		return dev_err_probe(dev, -EINVAL, "Unable to get SLIM Interface device\n");
>  
>  	slim_get_logical_addr(wcd->sidev);
> -	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
> +	wcd->if_regmap = devm_regmap_init_slimbus(wcd->sidev,
>  				  &wcd934x_ifc_regmap_config);
> -	if (IS_ERR(wcd->if_regmap))
> +	if (IS_ERR(wcd->if_regmap)) {
> +		put_device(&wcd->sidev->dev);
>  		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
>  				     "Failed to allocate ifc register map\n");
> +	}
>  
>  	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
>  			     &wcd->dmic_sample_rate);
> @@ -5893,6 +5904,10 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(dev, wcd934x_put_device_action, &wcd->sidev->dev);
> +	if (ret)
> +		return ret;
> +
>  	/* set default rate 9P6MHz */
>  	regmap_update_bits(wcd->regmap, WCD934X_CODEC_RPM_CLK_MCLK_CFG,
>  			   WCD934X_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

