Return-Path: <linux-kernel+bounces-785357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF37B34988
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FA63A8CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215D2FD1D4;
	Mon, 25 Aug 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qsy62bIg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE98307AD1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144794; cv=none; b=OPK5mpi++c2I3Sbbf4LrKYF4fsZEIU1X0FyEVGdaUbFsBGr4D9zXRDb1dMxCHJog5FZDeGXZVUtV/GJJD4YUghA1kRwcKyK+h0h6fRmLQ6qQ57h7rGlbxtP8MKekgsDtEe5bv3BRGPc8J7aWmLN+sbS61LR3bzQ3d1YaM0ym1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144794; c=relaxed/simple;
	bh=inTp6GsFFayVjZP2E9rvFJ9w1glskw9aa4s2e+AUpOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjmGl/KysxGIGFRqB8XILdeLDRx27M2ac/eqoiAhkL6bmuvHUoTCnexsKZSl/QyAfPQwMjzljF+kQ+8FmnU2qYneeHoheeVMG01UoXQcxH7dMmKZwRAyPN01LPw9hRVGIjQeWd98Nw36D+8LJVEh7lKfTj5W4XTXeYkeCunbFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qsy62bIg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PG3ISj019595
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BT8z0LRDEttEEOkFueZVNvOV
	Eoh74KzB/uLotVsvs+c=; b=Qsy62bIgM6U5BfJ/sNwL+GHDDY8ML6XjM2FOdzej
	FwnANLshgaI1pClWwhCsNVP2V3OrNe03ksN0LhaDkRyj7MViyPWoS8c+yKq4q02r
	KGafA4XIZhuFpWXPvrFJosM/qmX3QXm/UmHQ7kQ5LEyTU4A4Z0w9/9IWsppmYckv
	38qsBRTYIy08oQ4CyfbRg1NTuKkFqWdYHyaBsFlT3dRSasafem07Jpv0v8vnK4Hk
	cNzxdNEdXp9PyZazFp7zOJ+D87+XIsI5N2s13bwnLLkCOfTLI6a+ML/pfqf5+JY2
	vHgXXl0mhFYZDOlGvl55c6FlDR5n3/XqbNuRcGLVfeDnHQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615dxte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:59:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870315c98so1710467385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144790; x=1756749590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT8z0LRDEttEEOkFueZVNvOVEoh74KzB/uLotVsvs+c=;
        b=aixU5VHTIpeyxLsBIbfGqQcHxWuhzzmCLPMsRwbUqcqpuojmEQVhEUaAMRFJX+bp8y
         u4+F0UloG54vDeHEvbHE79zUxJwCyOQKbuD71Feaqma4is/BYFJcLS7Lws4JcCa3zbH7
         SteeSJtEuDre80eNGUhMJ9Zhrtq+ZvWOORRF893/wJPg5lsPgPQN5LyQQJUPEZlbIXlL
         j/KBHSDOUvMI9ktlMR9m6lAl3mKQjspILsjhsVZW1L6zTvHOXt5mRfESWfY8q7kvsyfM
         fLSr1V/aWIfGH6N1VZWrBju25aSgppaAF5RxSZvMWzT+ODKSooDN08dpCEkTapyIpIr7
         8+IA==
X-Forwarded-Encrypted: i=1; AJvYcCXSjw1zbBQxjwVRvkHPY7MizpnKSMTs2h5jKAzT+7EfRsepUpeugKF8vOqF/dECknXdCREPczLZbyEtySk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzz06N5QS/GXidoZZ1thAgq0WFTcar4t3s43zE5tgr/o/CQpNJ
	q+CVxEB11IZ79hBayBjPGkEQ+ePFXbHyBajCSSYDlfszEZCaaMQUWxEVOOu4RyIvsHK15tKB+eG
	D0LPnPAez34Ps3jQ3Q1vu8ybG6I4y086x47oUYdektJPiBmYH8qLcqby0Dz/eQcWMZSg=
X-Gm-Gg: ASbGncv07zZ2/rWkM5TqyeYi9s1tOCk8t//WQaSR8ynUHNDKdxbjKiI94f2+KoMoNrT
	AYf/VrUl80LxtYYnhFq6tAYX1E+JQBIJes9OIotvpT338wVr3sML6hRirXLz7HuhuVtA9TKOx6u
	1tOCzFqolUPRgazNmzpblJHlwZkZIvrFVNMmYGfNx47t5iyP1lIkhpO8UhGs3IVOh774XhZ/HE4
	AjX7biZR+WAS+T5WOEP1oBjgmz0T/PHys43pdtPBrtKD8uwosue2fz7klb9EdLBlcGPYHPHpUGp
	lEpO9o+qHhZByzLMFEapSTEMRcawFu3hITB0c9Xf0aMTMyWZgTUcPfncNBoJbz+HvZPMHbgE7QB
	XLHGBF5ccZEn/poztcy4CT5hK/E6wxUGz/X8DkuCkx/JNKhwS5pjR
X-Received: by 2002:a05:6214:4113:b0:70d:aefc:359f with SMTP id 6a1803df08f44-70daefc3b2dmr81038706d6.48.1756144790078;
        Mon, 25 Aug 2025 10:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwVde9x0A7/XKsWMfqa29hD4anw+3k6una9QOlEoqt0TwOaBR72/exCERclaKnCCFGULaXgg==
X-Received: by 2002:a05:6214:4113:b0:70d:aefc:359f with SMTP id 6a1803df08f44-70daefc3b2dmr81038186d6.48.1756144789324;
        Mon, 25 Aug 2025 10:59:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5d2b03sm16959081fa.56.2025.08.25.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:59:48 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:59:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 14/38] drm/msm/dp: Add support for programming
 p1/p2/p3 register blocks
Message-ID: <34he7xawyuq5z4iiyq4y4ehkjhfalx2vxhtejgyxly4zgyqma7@4uqoas4sz3nl>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-14-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-14-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX6GwE7PO5jeLF
 lDhmIlsyOdoUImmAZeJAbC54aUfb2+v1TDGsnqFxxdfkJAKcKN4hka4G8Isz7IHlX7whGwwMaJY
 TbsUehXqfPdUPBgk+bMrBS46ppO7GU0GcbxExNWKIYhK0LXSAlHyLXsuxFPqLuIKJtaY1q21nsW
 oFP/njkRjfiAojYmA7Y5at1dLupT6t62q9i6nB8xq/JHjMzXzVJEvUDSApC+duIA0qnyzIrYh8E
 qD5yAyqx+wqK06mRQ4pC77FUKvvYioMqVt98zCxA0izTpNva2gKXt5WJpPEb3cnd8gv14H7OHVH
 WzuyrloIPSOa9zUKGhF9R0FU3EBnaaVqtUdCf6tuTprVdOrkglgYqHvGPtApsONZnjej39u4SV1
 nko4nElq
X-Proofpoint-GUID: O0hg1AyivgAKb-DnJL8OOIYtkZB0_g3O
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68aca497 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6cDzrhBqED7EB3bCm2sA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: O0hg1AyivgAKb-DnJL8OOIYtkZB0_g3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Mon, Aug 25, 2025 at 10:16:00PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> QCS8300 supports 4-stream MST. This patch adds support for the additional
> pixel register blocks (p1, p2, p3), enabling multi-stream configurations.
> 
> To reduce code duplication, introduce helper functions msm_dp_read_pn and
> msm_dp_write_pn. All pixel clocks (PCLKs) share the same register layout,
> but use different base addresses.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 39 +++++++++++++--------
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 68 ++++++++++++++++++-------------------
>  2 files changed, 59 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 3422f18bdec71a99407edfe943d31957d0e8847a..935a0c57a928b15a1e9a6f1fab2576b7b09acb8e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -84,8 +84,8 @@ struct msm_dp_display_private {
>  	void __iomem *link_base;
>  	size_t link_len;
>  
> -	void __iomem *p0_base;
> -	size_t p0_len;
> +	void __iomem *pixel_base[DP_STREAM_MAX];
> +	size_t pixel_len;
>  
>  	int max_stream;
>  };
> @@ -619,7 +619,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  		goto error_link;
>  	}
>  
> -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
> +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base);

Why do we need to pass pixel base here? Shouldn't it be pixel_base[P0]?

>  	if (IS_ERR(dp->panel)) {
>  		rc = PTR_ERR(dp->panel);
>  		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
> @@ -937,8 +937,8 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>  				    msm_dp_display->aux_base, "dp_aux");
>  	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
>  				    msm_dp_display->link_base, "dp_link");
> -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
> -				    msm_dp_display->p0_base, "dp_p0");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[0], "dp_p0");

This should add all blocks used on this platform.

>  }
>  
>  void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
> @@ -1181,12 +1181,13 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
>  #define DP_DEFAULT_AUX_SIZE	0x0200
>  #define DP_DEFAULT_LINK_OFFSET	0x0400
>  #define DP_DEFAULT_LINK_SIZE	0x0C00
> -#define DP_DEFAULT_P0_OFFSET	0x1000
> -#define DP_DEFAULT_P0_SIZE	0x0400
> +#define DP_DEFAULT_PIXEL_OFFSET	0x1000
> +#define DP_DEFAULT_PIXEL_SIZE	0x0400

No need to touch this. It's only required for legacy bindings.

>  
>  static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  {
>  	struct platform_device *pdev = display->msm_dp_display.pdev;
> +	int i;
>  
>  	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
>  	if (IS_ERR(display->ahb_base))
> @@ -1206,7 +1207,7 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  		 * reg is specified, so fill in the sub-region offsets and
>  		 * lengths based on this single region.
>  		 */
> -		if (display->ahb_len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
> +		if (display->ahb_len < DP_DEFAULT_PIXEL_OFFSET + DP_DEFAULT_PIXEL_SIZE) {
>  			DRM_ERROR("legacy memory region not large enough\n");
>  			return -EINVAL;
>  		}
> @@ -1216,8 +1217,10 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  		display->aux_len = DP_DEFAULT_AUX_SIZE;
>  		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
>  		display->link_len = DP_DEFAULT_LINK_SIZE;
> -		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
> -		display->p0_len = DP_DEFAULT_P0_SIZE;
> +		for (i = DP_STREAM_0; i < display->max_stream; i++)
> +			display->pixel_base[i] = display->ahb_base +
> +						 (i+1) * DP_DEFAULT_PIXEL_OFFSET;
> +		display->pixel_len = DP_DEFAULT_PIXEL_SIZE;
>  
>  		return 0;
>  	}
> @@ -1228,10 +1231,18 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  		return PTR_ERR(display->link_base);
>  	}
>  
> -	display->p0_base = msm_dp_ioremap(pdev, 3, &display->p0_len);
> -	if (IS_ERR(display->p0_base)) {
> -		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
> -		return PTR_ERR(display->p0_base);
> +	display->pixel_base[0] = msm_dp_ioremap(pdev, 3, &display->pixel_len);
> +	if (IS_ERR(display->pixel_base[0])) {
> +		DRM_ERROR("unable to remap p0 region: %pe\n", display->pixel_base[0]);
> +		return PTR_ERR(display->pixel_base[0]);
> +	}
> +
> +	for (i = DP_STREAM_1; i < display->max_stream; i++) {
> +		/* pixels clk reg index start from 3*/
> +		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
> +		if (IS_ERR(display->pixel_base[i]))
> +			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
> +					      display->pixel_base[i]);
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index eae125972934bb2fb3b716dc47ae71cd0421bd1a..e8c1cf0c7dab7217b8bfe7ecd586af33d7547ca9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -26,7 +26,7 @@ struct msm_dp_panel_private {
>  	struct drm_dp_aux *aux;
>  	struct msm_dp_link *link;
>  	void __iomem *link_base;
> -	void __iomem *p0_base;
> +	void __iomem *pixel_base[DP_STREAM_MAX];
>  	bool panel_on;
>  };
>  
> @@ -45,24 +45,24 @@ static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
>  	writel(data, panel->link_base + offset);
>  }
>  
> -static inline void msm_dp_write_p0(struct msm_dp_panel_private *panel,
> +static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
>  			       u32 offset, u32 data)

Is it really multiplexed on the panel level? I'd assume that each panel
is connected to only one stream instance... If that's not the case, such
details must be explained in the commit message.

>  {
>  	/*
>  	 * To make sure interface reg writes happens before any other operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	writel(data, panel->p0_base + offset);
> +	writel(data, panel->pixel_base[panel->msm_dp_panel.stream_id] + offset);
>  }
>  
> -static inline u32 msm_dp_read_p0(struct msm_dp_panel_private *panel,
> +static inline u32 msm_dp_read_pn(struct msm_dp_panel_private *panel,
>  			       u32 offset)
>  {
>  	/*
>  	 * To make sure interface reg writes happens before any other operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	return readl_relaxed(panel->p0_base + offset);
> +	return readl_relaxed(panel->pixel_base[panel->msm_dp_panel.stream_id] + offset);
>  }
>  
>  static void msm_dp_panel_read_psr_cap(struct msm_dp_panel_private *panel)
> @@ -297,33 +297,33 @@ static void msm_dp_panel_tpg_enable(struct msm_dp_panel *msm_dp_panel,
>  	display_hctl = (hsync_end_x << 16) | hsync_start_x;
>  
>  
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_HSYNC_CTL, hsync_ctl);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PERIOD_F0, vsync_period *
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_HSYNC_CTL, hsync_ctl);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PERIOD_F0, vsync_period *
>  			hsync_period);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F0, v_sync_width *
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F0, v_sync_width *
>  			hsync_period);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PERIOD_F1, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F1, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_HCTL, display_hctl);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_HCTL, 0);
> -	msm_dp_write_p0(panel, MMSS_INTF_DISPLAY_V_START_F0, display_v_start);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_V_END_F0, display_v_end);
> -	msm_dp_write_p0(panel, MMSS_INTF_DISPLAY_V_START_F1, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_V_END_F1, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_START_F0, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_END_F0, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_START_F1, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_END_F1, 0);
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_POLARITY_CTL, 0);
> -
> -	msm_dp_write_p0(panel, MMSS_DP_TPG_MAIN_CONTROL,
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PERIOD_F1, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F1, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_HCTL, display_hctl);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_HCTL, 0);
> +	msm_dp_write_pn(panel, MMSS_INTF_DISPLAY_V_START_F0, display_v_start);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_V_END_F0, display_v_end);
> +	msm_dp_write_pn(panel, MMSS_INTF_DISPLAY_V_START_F1, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_V_END_F1, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_START_F0, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_END_F0, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_START_F1, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_END_F1, 0);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_POLARITY_CTL, 0);
> +
> +	msm_dp_write_pn(panel, MMSS_DP_TPG_MAIN_CONTROL,
>  				DP_TPG_CHECKERED_RECT_PATTERN);
> -	msm_dp_write_p0(panel, MMSS_DP_TPG_VIDEO_CONFIG,
> +	msm_dp_write_pn(panel, MMSS_DP_TPG_VIDEO_CONFIG,
>  				DP_TPG_VIDEO_CONFIG_BPP_8BIT |
>  				DP_TPG_VIDEO_CONFIG_RGB);
> -	msm_dp_write_p0(panel, MMSS_DP_BIST_ENABLE,
> +	msm_dp_write_pn(panel, MMSS_DP_BIST_ENABLE,
>  				DP_BIST_ENABLE_DPBIST_EN);
> -	msm_dp_write_p0(panel, MMSS_DP_TIMING_ENGINE_EN,
> +	msm_dp_write_pn(panel, MMSS_DP_TIMING_ENGINE_EN,
>  				DP_TIMING_ENGINE_EN_EN);
>  	drm_dbg_dp(panel->drm_dev, "%s: enabled tpg\n", __func__);
>  }
> @@ -333,9 +333,9 @@ static void msm_dp_panel_tpg_disable(struct msm_dp_panel *msm_dp_panel)
>  	struct msm_dp_panel_private *panel =
>  		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>  
> -	msm_dp_write_p0(panel, MMSS_DP_TPG_MAIN_CONTROL, 0x0);
> -	msm_dp_write_p0(panel, MMSS_DP_BIST_ENABLE, 0x0);
> -	msm_dp_write_p0(panel, MMSS_DP_TIMING_ENGINE_EN, 0x0);
> +	msm_dp_write_pn(panel, MMSS_DP_TPG_MAIN_CONTROL, 0x0);
> +	msm_dp_write_pn(panel, MMSS_DP_BIST_ENABLE, 0x0);
> +	msm_dp_write_pn(panel, MMSS_DP_TIMING_ENGINE_EN, 0x0);
>  }
>  
>  void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable)
> @@ -369,7 +369,7 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel)
>  	struct msm_dp_panel_private *panel =
>  		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>  
> -	msm_dp_write_p0(panel, MMSS_DP_DSC_DTO, 0x0);
> +	msm_dp_write_pn(panel, MMSS_DP_DSC_DTO, 0x0);
>  }
>  
>  static void msm_dp_panel_send_vsc_sdp(struct msm_dp_panel_private *panel, struct dp_sdp *vsc_sdp)
> @@ -559,7 +559,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>  	msm_dp_write_link(panel, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY, width_blanking);
>  	msm_dp_write_link(panel, REG_DP_ACTIVE_HOR_VER, msm_dp_active);
>  
> -	reg = msm_dp_read_p0(panel, MMSS_DP_INTF_CONFIG);
> +	reg = msm_dp_read_pn(panel, MMSS_DP_INTF_CONFIG);
>  	if (wide_bus_en)
>  		reg |= DP_INTF_CONFIG_DATABUS_WIDEN;
>  	else
> @@ -567,7 +567,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>  
>  	drm_dbg_dp(panel->drm_dev, "wide_bus_en=%d reg=%#x\n", wide_bus_en, reg);
>  
> -	msm_dp_write_p0(panel, MMSS_DP_INTF_CONFIG, reg);
> +	msm_dp_write_pn(panel, MMSS_DP_INTF_CONFIG, reg);
>  
>  	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>  		msm_dp_panel_setup_vsc_sdp_yuv_420(msm_dp_panel);
> @@ -673,7 +673,7 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
>  struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
>  			      struct msm_dp_link *link,
>  			      void __iomem *link_base,
> -			      void __iomem *p0_base)
> +			      void __iomem *pixel_base[])
>  {
>  	struct msm_dp_panel_private *panel;
>  	struct msm_dp_panel *msm_dp_panel;
> @@ -692,7 +692,7 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
>  	panel->aux = aux;
>  	panel->link = link;
>  	panel->link_base = link_base;
> -	panel->p0_base = p0_base;
> +	memcpy(panel->pixel_base, pixel_base, sizeof(panel->pixel_base));
>  
>  	msm_dp_panel = &panel->msm_dp_panel;
>  	msm_dp_panel->max_bw_code = DP_LINK_BW_8_1;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

