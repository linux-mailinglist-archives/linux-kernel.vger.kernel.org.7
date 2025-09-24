Return-Path: <linux-kernel+bounces-831125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DDBB9B9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C31F2E62DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E525CC6C;
	Wed, 24 Sep 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IRuWZS8N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AED2586C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741062; cv=none; b=e9crRlcbakPeYQ+zX6vJoMC3eLnmoH6nGzIIf2d7j7inQkcG1ONBiWBpVC8iUF37aizcml+x8LddA384YphiNmNp5XLs3l062I+3cxzDKCfcA981/PnGCWCONNURZ72a4pSAAqxTosxsAIeIyeavQAh/chsxpixuKpCFtQg7ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741062; c=relaxed/simple;
	bh=6m6czYpY+d/dx9feMOO9MhlLcLMSowru/MvPLbBglLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aum4t77gD3XLKs4ElzskgLIas2+/prKmPBynr/pYYlN5F/EpAB4qHkZcN0lWumSz3ExMjGsXd1BqujPwVRsdrjxyWEkjumePaB0KM+YyuOqfkBenpRi/wpfwmM9ols7DGgl5J0C0RzgWCDnb/3dem90xuIelMNQY+IgSllasEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IRuWZS8N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCoh9R027782
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gStCkt/BoSYEmirqxpf4aupt
	Sr4no9aDnWgPhyHC9mc=; b=IRuWZS8NerPXaF9QsvZ4So1O+3CYZ/fEgZ44Z5O5
	IzATCWJ1GkG6Yc4QbClhAzV4sOpQ3gkFZpFOeE6SQjoIgOptProGW4h24U2FJ5I7
	9vM9kO1jfJYXgDi2X22VYV/L+MxHBJaq+b7DUmhTMVKQziNSZl1LGdNWMdQbdiFL
	RSOvRGwQnJYT8h4wjKLmgaHPPBDuk26Dd6PXjDqyFZW8VCDhMEYOuksaTe7lbFfB
	EOciyHZIDyIK26I+9iLOsNPsGVD6Sz6Wg8TYvSsogOkN3qEFlKQc/mjEAqco7r1k
	ovYZzorP012bnVTz7yULavERIdssV9BbA+NKTlwbs1qDTg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnwunp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:10:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b47b4d296eso4284391cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758741057; x=1759345857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gStCkt/BoSYEmirqxpf4auptSr4no9aDnWgPhyHC9mc=;
        b=wzN1n36VTNlfuhdzMm39ZKECljCgeRai1LR3WdD+7elsxGVf6BEKRt0i2uxFYtrJjK
         EKtrHt34eJAKjUIp0DsKpqE/mVWJGDnPvA3h1WoCLZEAjQZ2ePg2ggfi2cIiJolNNUdz
         TaDVNncMG1q3ZbQsnzb98o+B2ObRYqjxRlg7Gg/pTeyLea3Szbcc8faGr6FEmn3H3Eaf
         jwnfS8puTF4jp3jr5IqwySWR8RCPGIE5XFK8HpQWh7/R4Yloeadx3ATRpN6dXsRb7pc3
         mhq4oyw9brNAWgNadftM9FcdFccupbwP6qc5mvDK32/9LDk9ZPeD84wECAfazC0ydxkn
         yPMg==
X-Forwarded-Encrypted: i=1; AJvYcCXFY2LmEorHxPM0uM6judw1s6ionN9ZSdEpTSbFmmceiXDFk0J5/ugJ1Kc055T2B6y5dpdhJVxXlt1MOgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53ZfCDhoFQxYdCOZRYFrY/L93G58p1/e+tSx2PrxcFscIV4Wz
	EaIu0PExP5+gjqLLp54Hei3oikb8GdIVc0TanPmjmmC40DRw7tLcI71P74Iom4zw4p4bdqMZ97S
	Cul3jUC+uU34u+CwmSRTE/0eKjWDynyyYnnqdr52uQcPcWa6T5P7IS1ANcVPvLfbXEYg=
X-Gm-Gg: ASbGncs8dSUxs/2LKcMWuhhoUeL1oYpvo0ZO9T5moW7Gbuqt79gsgIAQbjJcrzBaP3k
	salMJt7D3wTSPufsmZyw7QcP3qNuMDf9R+NarBCY1pYt//U6SRMm9ROMmYlFQNUkSzZsetNMKer
	urKAjds8/qI7cjzyU3Rzme/4mt2HJYZMxSp8khIiLUfdIuEJ+nlShcX6Ta9ViPSz84r5o1erpjq
	Ea0mwxEkoQqC5/huIfOO2yacZYveO5FMeEzSRpHsPPADR8AMtDY3EPC8zTTpvKtMfR+BqR50e7R
	F0WFh13JKHGoyj3ZY4QVMncCcsKX17bIkn47tiETFqsgcE6UtZSgVSUGLlbGXErxgzIHSi+gCA4
	qGqJ/7sxAdupDS9zjgGLf0qLuqJsLgqXY2Qw/JvvbTJuiJWJROQOj
X-Received: by 2002:a05:622a:610d:b0:4b5:d932:15d8 with SMTP id d75a77b69052e-4da481d8f8fmr12584641cf.14.1758741057084;
        Wed, 24 Sep 2025 12:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzNGVdhq6dBp/1CJfwzM4ALe/HzWywBrHP1da/RaRRmjp3ldIoFiEOTag9sj83H/4xzDV3xg==
X-Received: by 2002:a05:622a:610d:b0:4b5:d932:15d8 with SMTP id d75a77b69052e-4da481d8f8fmr12584151cf.14.1758741056530;
        Wed, 24 Sep 2025 12:10:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5790a9f0368sm5026655e87.55.2025.09.24.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:10:55 -0700 (PDT)
Date: Wed, 24 Sep 2025 22:10:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v3 1/3] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <5b75dckankcx55gbm734a23rvqxdbprlus3nkvqfry7lz5ksjf@jjmfsbiwqny6>
References: <20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org>
 <20250924-dsi-dual-panel-upstream-v3-1-6927284f1098@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-dsi-dual-panel-upstream-v3-1-6927284f1098@linaro.org>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d44243 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=RAbU-raeAAAA:8 a=KKAkSRfTAAAA:8 a=TDLR0dRR3mayGEnoOkYA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=JiizpSU_mAIq9zsZDqn2:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MNquEI1KItkVmX8qFLAgJU8J8mtpsWw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX8IIGxL36tN3M
 f5o4KruNoQ0bkZgU91dLfgQYy3PkItKVLDQk9gDSZ6KBMy/LRzVw8hieljwNgB+mf90zr75hieN
 XEyMX6DApccuuVv6FDfE14tJkr/7vYetDVb7fYUQJeo6H1AO1pQCurk8zEasCtq4GBUSZKiAmST
 2VjlhSciDQJUO+JKdXJlpttZjb4MiAKLSfPt8Z9q9jm+5or25Iv3YhJ+bzhnwHV0Bffx9gjay7h
 Pm37RBwWCVYfh+PfsFmbOT6kO5yKeZw9FowcO5YkwAagVVmMC58lO4UNDne+KCKfYymdVkoIGXJ
 slYQR9Gb45m/LnbOcy6fBu7Ag22Y3/j8NgyavmNESanKV8luUmXiQtlfGZiGnYJMLJRCzLAu/UD
 BmIJ7pDS
X-Proofpoint-GUID: MNquEI1KItkVmX8qFLAgJU8J8mtpsWw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Wed, Sep 24, 2025 at 11:08:10PM +0800, Jun Nie wrote:
> Some panels support multiple slice to be sent in a single DSC packet. And

s/support/require/

If the panel supports something, then we can omit that and send 1 slice
as we currently do. If the panel requires multiple slices, it's
mandatory.

> this feature is a must for specific panels, such as JDI LPM026M648C. Add a

A panel driver which executes this API is appreciated. Otherwise in a
few months / years somebody will submit a patch 'field foo is not used
by the kernel drivers, drop it'.

> dsc_slice_per_pkt member into struct mipi_dsi_device and support the
> feature in msm mdss driver.
> 
> Co-developed-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
>  include/drm/drm_mipi_dsi.h         |  2 ++
>  2 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index f297e3de8c3dc4e1326e70c78c046b5a19568cef..de51cb02f267205320c5a94fc4188413e05907e6 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -157,6 +157,7 @@ struct msm_dsi_host {
>  
>  	struct drm_display_mode *mode;
>  	struct drm_dsc_config *dsc;
> +	unsigned int dsc_slice_per_pkt;
>  
>  	/* connected device info */
>  	unsigned int channel;
> @@ -849,17 +850,10 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>  	slice_per_intf = dsc->slice_count;
>  
>  	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
> -	bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
> +	bytes_per_pkt = dsc->slice_chunk_size * msm_host->dsc_slice_per_pkt;
>  
>  	eol_byte_num = total_bytes_per_intf % 3;
> -
> -	/*
> -	 * Typically, pkt_per_line = slice_per_intf * slice_per_pkt.
> -	 *
> -	 * Since the current driver only supports slice_per_pkt = 1,
> -	 * pkt_per_line will be equal to slice per intf for now.
> -	 */
> -	pkt_per_line = slice_per_intf;
> +	pkt_per_line = slice_per_intf / msm_host->dsc_slice_per_pkt;
>  
>  	if (is_cmd_mode) /* packet data type */
>  		reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
> @@ -1008,12 +1002,8 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		else
>  			/*
>  			 * When DSC is enabled, WC = slice_chunk_size * slice_per_pkt + 1.
> -			 * Currently, the driver only supports default value of slice_per_pkt = 1
> -			 *
> -			 * TODO: Expand mipi_dsi_device struct to hold slice_per_pkt info
> -			 *       and adjust DSC math to account for slice_per_pkt.
>  			 */
> -			wc = msm_host->dsc->slice_chunk_size + 1;
> +			wc = msm_host->dsc->slice_chunk_size * msm_host->dsc_slice_per_pkt + 1;
>  
>  		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>  			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
> @@ -1623,8 +1613,13 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
>  	msm_host->lanes = dsi->lanes;
>  	msm_host->format = dsi->format;
>  	msm_host->mode_flags = dsi->mode_flags;
> -	if (dsi->dsc)
> +	if (dsi->dsc) {
>  		msm_host->dsc = dsi->dsc;
> +		msm_host->dsc_slice_per_pkt = dsi->dsc_slice_per_pkt;
> +		/* for backwards compatibility, assume 1 if not set */
> +		if (!msm_host->dsc_slice_per_pkt)
> +			msm_host->dsc_slice_per_pkt = 1;

msm_host->dsc_slice_per_pkt = dsi->dsc_slice_per_pkt ?: 1;

Yes, I think it's more ideomatic.

> +	}
>  
>  	ret = dsi_dev_attach(msm_host->pdev);
>  	if (ret)
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 6d2c08e8110151a97620389197f1ef79c058329d..5a85ba01f402a3866b70828391bb417bb8dd5956 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -182,6 +182,7 @@ struct mipi_dsi_device_info {
>   * be set to the real limits of the hardware, zero is only accepted for
>   * legacy drivers
>   * @dsc: panel/bridge DSC pps payload to be sent
> + * @dsc_slice_per_pkt: number of DSC slices to be sent as in a single packet

s/as //

>   */
>  struct mipi_dsi_device {
>  	struct mipi_dsi_host *host;
> @@ -196,6 +197,7 @@ struct mipi_dsi_device {
>  	unsigned long hs_rate;
>  	unsigned long lp_rate;
>  	struct drm_dsc_config *dsc;
> +	unsigned int dsc_slice_per_pkt;

Why is it a part of the DSI device config? What if a device specifies
dsc_slice_per_pkt, but not DSC config? What are the legit boundaries for
this field?

>  };
>  
>  /**
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

