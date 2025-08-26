Return-Path: <linux-kernel+bounces-787028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B41B37073
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5BF1B2540D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2D3164CD;
	Tue, 26 Aug 2025 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsmTrUHG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECC3164D1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226015; cv=none; b=XVaofX3o5fX1BnD+E8E3RNJWi8ATXTrimg0nuh9d/QZrml943korxq5GY3j01p6PiC5uL/353XU5IV7aNw6kFV9ZNJnnvWVIl32ieht9lHX/yCOvq5tf4ZgEh6dQoDGpB8md40WV3lePwQ1/igKYUETMcVfgTNh4TO3iuxAChFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226015; c=relaxed/simple;
	bh=Cnz7D0UPWrRhgGtUPKfg6pk2BWK8ICoo9Tvq1LmKrVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7h+5zDpKMF9lrc4c8P0mZnZRis2PHmLkOjecErtS04x49ZqgcnaWPtbxsikVr4VCiL6WnG/wPTNsFkt5WxFmZm1OX6PRFLvvTb6ikhk6X2zc0SOVLE2snGC4HBJKcuOcKD3aUEyuVe3nqvZN+yks2RB5W5FWPuHSjxHy5JIlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsmTrUHG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QDf7RO031504
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o0JNkVhBc++JdNPVvj2G5Tj3
	VEOgkLl+3jrDv6VD7BE=; b=jsmTrUHGvaBkNoJMv6AJPlvdxeSRoOXScDgdF8H5
	yXOY6bOIi/t8o01fuV9IO9u0u9bMxb1l21mNd+/Jb30e07scPF6cc/eWbSFWLTFd
	Q006RaI322lcHeEaHgQsi0TQBWmN+eszFaZZixyp+V3QvFqEJNb1j3LmONws8q4+
	+VzKEQ3vxORktU3MqJWeQTYwmkY1tNBSC0awih42NN4k7NxJ60O/5t23HT8aLGoO
	rxJiAeDAImklFPUzmy1ZwWGjzgCKlGXzt2h+HZBYdNfcJruN68YReBM2hNG+Ofx+
	LnHV77cIJplKO1g4jyBlcstYoQ3Pj5x1HXx1IfWYWGv1nQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16rnd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:33:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70dd6d2560aso15305076d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226012; x=1756830812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0JNkVhBc++JdNPVvj2G5Tj3VEOgkLl+3jrDv6VD7BE=;
        b=AbsC9qXWpcQODFIyPjhM2kyIL0jv/YZ6HZ/GNzMbuVIE4C4qGwPDRBky6iJTW2NZDw
         P6fRtfdlhXdxCcReu7asgaLbVoCVnNz16blCHsaiWQZtlJhjQIq1T3ly33Rga4pUTKdm
         ZEVgMQeP3chV1ZRD1koW71DkjTzprcMsv7ie4YMhWcuQI0VjiXPF4rshZPBSHaIenzkG
         5H//Fsw21MjGzxTn7W76Bwnorw3/ad9Kew9auUEdYf/J1vOabbzLODveUrZWGpJ+LWYB
         IXXXK12SUE5Lby9rSiaQIFfb71Bmfsh0qzyL1eD2NACpARzSlhp/BmwWQlXEyT2g638D
         +8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUlsC7JRJzHjvKpoF7LLCPeFFmSRcIc+yd6Ri/ksruEAnewSO6Aypdr9Xk87ORGtL9eUEA1P3Q21IYI9CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vpy8le9B/Zxab7R0PqhUqSYXRs9C30eDb/5ECiXQAF8UGZze
	7CHyUwF84YqAGycggJvEQr/mEnYq5SqLzpMYdYnb38piILpNtU1BAl2qBWsad7ajPY1QRuASos2
	bNpaep/nFjE86iEHOQR13nvx3qH42Zo+gdaVcY4ys335pibTmpMDfjaql3BnrEKkpBRw=
X-Gm-Gg: ASbGnctXHL59Il3x4pKH1oRcfw3LgQvQdFUsHhlEh789rn8grhzoHJmUsaih7A72+um
	gQnZLklihA8tKDfpJ2hRBwNuCCCyGdPEV7NcIDYcW0mEH3WytYX+hXe7BerQR/rOChr5Kdev/bI
	uUOMCFOTaks8XbijvosVuMKI3MDmmnDPWWnbxnYhDaggTcGOAyoHbf/GI4F7hwIcREV3ptPwam/
	18x0o9rlnMZ1cRyzgsZchqv9cp+tvdNUXpKejopyw7zFdBvMIw4SGYXBs0GMoMzpYHBPU33rC4o
	rtB0JhqeiXaIC+XilZUjATw4XM3ThBQS/YcoOR9ORDuAkNqiYQ+GmYqXMGNI+6dlIZK+AuHUDNI
	xrs2HVzWEhA02IUBqtENOhiQL/BKhwSbzywoorhfeGM6jmgZagWj4
X-Received: by 2002:ad4:5cc1:0:b0:709:ee07:daaf with SMTP id 6a1803df08f44-70d97102f17mr190928346d6.19.1756226011481;
        Tue, 26 Aug 2025 09:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ7aaOomBumnrq1rhi9jEEdDGg0wr1dDNic05npTTurzd/gV21cCPu8vrLKpDQ36ehil5Qyg==
X-Received: by 2002:ad4:5cc1:0:b0:709:ee07:daaf with SMTP id 6a1803df08f44-70d97102f17mr190927636d6.19.1756226010771;
        Tue, 26 Aug 2025 09:33:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35b27683sm2357303e87.0.2025.08.26.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:33:29 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:33:28 +0300
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
Subject: Re: [PATCH v3 27/38] drm/msm/dp: add dp_display_get_panel() to
 initialize DP panel
Message-ID: <smvfckejheyi7oehubdkhnh6pxokn7yugvlrynraypsu6kssj3@6vinswn4yku4>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-27-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-27-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-GUID: E3FmDMd3xKkjDo0xiM2c5NFtUhcnAS8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfX3OntCsiItxRf
 mOHNgdO1JVKN5ZrTyEvKhbITV57+d/vCI95DsYX9n6JAChVuglPC8130p4BVlc096XA98oeQrsB
 sOagj89yCAVWy+umCliw7KMBFE6tazEItPEkCsePZW0U+xTUPloqqmhFlF0sxRlgGMdRVeThNog
 dLvkLIvBQytP20E3+MpKlkk7h489ltx2u6kJZLf6vW+au4mSG4aymfunC66LopdmowH1igseOtX
 nTKWVeynWENFsDZLaw+H1XUbp7dI85zjVOyJSTjmmXyDewL84h6u2PJo8vX2Xo8bSvBlkjhyGSS
 3InPYXKgV+O8RcIAVBLapIvPkHs2jYmRverH9paqML5gyXbl+qKqOFYgBWz63R62uIsA8oDrPpY
 /wsKrLNP
X-Proofpoint-ORIG-GUID: E3FmDMd3xKkjDo0xiM2c5NFtUhcnAS8b
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68ade1dd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qYs0ZBLfSisuqDwih3YA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120

On Mon, Aug 25, 2025 at 10:16:13PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add an API dp_display_get_panel() to initialize and return a DP
> panel to be used by DP MST module. Since some of the fields of
> DP panel are private, dp_display module needs to initialize these
> parts and return the panel back.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 84df34306fb557341bea288ea8c13b0c81b11919..abcab3ed43b6da5ef898355cf9b7561cd9fe0404 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -632,6 +632,29 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
>  	return 0;
>  }
>  
> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +	struct msm_dp_panel *dp_panel;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
> +			       dp->link_base, dp->mst2link_base, dp->mst3link_base,
> +			       dp->pixel_base);
> +
> +	if (IS_ERR(dp->panel)) {
> +		DRM_ERROR("failed to initialize panel\n");
> +		return NULL;
> +	}
> +
> +	memcpy(dp_panel->dpcd, dp->panel->dpcd, DP_RECEIVER_CAP_SIZE);
> +	memcpy(&dp_panel->link_info, &dp->panel->link_info,
> +	       sizeof(dp->panel->link_info));

Both these lines show that link_info and dpcd belong to msm_dp_display
rather than the panel. The panel should only be describing properties of
the particular sink.

> +
> +	return dp_panel;
> +}
> +
>  static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
>  {
>  	msm_dp_audio_put(dp->audio);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index b1ea027438d952c94f3ae80725c92e46c631bdb2..d5889b801d190b6f33b180ead898c1e4ebcbf8f3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -65,4 +65,6 @@ void msm_dp_display_unprepare(struct msm_dp *dp);
>  
>  int msm_dp_display_get_active_stream_cnt(struct msm_dp *msm_dp_display);
>  
> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display);
> +
>  #endif /* _DP_DISPLAY_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

