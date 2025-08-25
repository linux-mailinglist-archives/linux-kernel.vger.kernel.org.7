Return-Path: <linux-kernel+bounces-785352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ED0B3496F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6C7189A221
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934F23002A2;
	Mon, 25 Aug 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZmFEeEtE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8CB3054EE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144580; cv=none; b=C2LowfzER1YHb0vYpoOmS1Nr8GBGHGFNMDrBodebMo9Jyq/37WtKSXvDrv8Dm/lMjiuKY2Nx/BafthfLWUWz5e55+PcjNLchWhSV9uWeWshC326HoxI/5Q3b1OQgSjFtsW8SzS+59fJAo+90LyWEG+JURhXAiqU8Ha460WBcmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144580; c=relaxed/simple;
	bh=USYs8DzwEd5CNXpqe1TdlO6VwgYBKIjtqfccCFD1qv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk5JiDzSS5ykaC9tOlEAA1sLxZfb81RDez6n3bwB+MfbEVyezsmjJRHRktxs/YKpk1EooTDBUk36jB7HycSScvssw5xxzvmRaGiqPYU8UfN8oDrpcTctWhAnTmYE4FSOqRo9MCOiLc3eyXE7+wjPiQlY7H748gPMhFoCV6quMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZmFEeEtE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFmn3g018404
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qZbc+LiP+W9ZiZBK8FOlQwQv
	CJhWGeKmTwDpg9afkms=; b=ZmFEeEtEHL9QS8O5lYBbwW//3Z5kDSkVvUidjwnA
	HwAmWqM8lPuO7Ay82PqQAFq15BFH8p/Pe8T14QetYMWeaLbe8DuuVGmXRajltWsL
	JU917ZPjSDacM02Xkn3wDusb3Xfvj+RC+BvbsX7IKID0RW6TximIPBRm8zNamL1L
	aagz01YHUsC19EXqbfSOK0dbiq4QUQEGM3lImG76Igt79hfAhve8NKtWih8Wch8d
	fNFh1JTJVIlcbC/tLRg62UDkBLtATeuikNmAp2aHyLdqNKqxbYGt6SxsNBFjzcWJ
	Hua46ytpuNScg/PpNmFK/Laj4jnB0w6UZqO5x0meY/xX8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpp4av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:56:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109765d3fso100112571cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144577; x=1756749377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZbc+LiP+W9ZiZBK8FOlQwQvCJhWGeKmTwDpg9afkms=;
        b=s8PacdKPHVsyVcSGh9FpiX1FTlv0FkLfjemYdkXADWuBjQYXYpNbnj6cBr1P/D7TGt
         cW+2UeeFOCvn6sf97ybSxMHwdU1fE+OSgPOjAINvD0oVsUboI8xdOIK9zzwZHRErfz9y
         X9xOcBZRaURKaPBIQ+qTo/tMGnM7csgfrh5CUKfxrWPv6U0OrUYFW2DCF14XmE/jmL2a
         Nzlwf7aofLr9/Vvu2UrBm+Ljf1FptOZusPwdqReMPoz+hX8bCkgqqtAQ6N6lks+aW49v
         B5RyVh+BvyevKbH6L6qN7BYtaWlKTNd9zEPHx7kPRZMbsHJjQaieCC7Tsd7peaukpMDe
         x7KA==
X-Forwarded-Encrypted: i=1; AJvYcCUdXYuwM2AA5udceWE5dEAx5fU4R/gxefWMdTwj1kg2G6bu/c6k0Ts5zBwnp57lJA9dTJXRFBWTMue1kWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMb/rxxFk1LxPZMgrUoPLr1tmswyjFFbPDjjUAU6lIBvFUKDAR
	eHGNXow/LE43boMeJsYng7F8WQ647pMTkfzfPSLkPNxObY4IbY9soC6nSMNnzNAND0/1AFV5tMA
	sCXhfkSKdxJh3sD+kMinOeaafI9NKkRMfB2SjX7HjlkmLYxVgZFBP+R0vhTZnMaFKwfo=
X-Gm-Gg: ASbGncs58m485qG7/Kbmk/MbdGudsyjjC1lAOZjEGrZPi7bYNIgQIisBmw65q1katCh
	xEQ2rrXfq8g2cvhlHVB3K7VrAxGk1zEvuqNWb0gNQPBNatkWzGa++w2wqCExp5RDQ/pYZSq9Nct
	yAQw+gR5r9x5g10q9AHNttsavrSJdkAbq5XpzbVRYemmyZfNmg+Dvh0Xm9D7KP8/rQuXsxnh8CO
	W9E0UDr3kiRcMibqnJ08RLRYGzJwsMRB+qnQc2eNz5iUgbMWzAc000HJ2oeZZK5RJ06LM8rlNky
	8zzHhRmyTuYr2lmcpgJzWnqfZZPf1WyTdWju8g6qZqwOn/Jab5OPOPhrz4m1E6pUtea2el7j69Z
	kjQRJdOVj3Yfs2GRuQYGIPQgyuM42mbqnYIBiiRyGRjgTSd47wYtX
X-Received: by 2002:ac8:7c48:0:b0:4b2:9883:830d with SMTP id d75a77b69052e-4b2e0845a60mr7129791cf.0.1756144576964;
        Mon, 25 Aug 2025 10:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe/SOgbCIAs7eJLZOpHwdby9mGDyCQ7MxuYmguN5qUnjk/bn2DIS68PMx9r4sIAT4GiA9z/w==
X-Received: by 2002:ac8:7c48:0:b0:4b2:9883:830d with SMTP id d75a77b69052e-4b2e0845a60mr7129441cf.0.1756144576374;
        Mon, 25 Aug 2025 10:56:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f43351382sm971641e87.124.2025.08.25.10.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:56:15 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:56:14 +0300
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
Subject: Re: [PATCH v3 13/38] drm/msm/dp: introduce stream_id for each DP
 panel
Message-ID: <wvctskhoyphicaymbm5b6kermvubhrn5u6uzui3pqf7p3a7ia2@zirqohupflvp>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-13-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-13-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68aca3c2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=esdiVXI3waKZDF_2LzQA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rIzQyq2nRN6lWDNMj8TKwN8fYCDJFJTv
X-Proofpoint-ORIG-GUID: rIzQyq2nRN6lWDNMj8TKwN8fYCDJFJTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXx77uVputuSpl
 DxCsAKIGm5d6YY+nE98PzwOLScF0EHlYSl0xU/epThw/x+X+t4mL8mwKt/N943GcJ+CF9SCSHL3
 VExPnaJXlkg5zaWp3QeyufSYz72cA6Bc4Q36C3NNIhh/eewlgxLXdwjwfrZPb0GlA1P8hUwB0Zs
 TyKLSiUChqW14IMPbcOMVolpCEgy1SGkj3P4RaP9vKtYf2cwJaPjlbBzhWGFKTg+RWs9BWqBh8w
 2BF6+6AfyQ7gafYAZ6rftnqfRIKMBafKO3hid2kmZM8U2xW3tSzRcF0YT9zqP3cofR9hjTzfksw
 FrrU2rgkBy1zqKwhDomHlFU4qjrVrTW30ohdTlzMpN7dKmnv30XrGSI8Yi2+bl9SYoPaMG41B/e
 Q+10sCar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Mon, Aug 25, 2025 at 10:15:59PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, each DP controller can handle multiple streams.
> There shall be one dp_panel for each stream but the dp_display
> object shall be shared among them. To represent this abstraction,
> create a stream_id for each DP panel which shall be set by the
> MST stream. For SST, default this to stream 0.
> 
> Use the stream ID to control the pixel clock of that respective
> stream by extending the clock handles and state tracking of the
> DP pixel clock to an array of max supported streams. The maximum
> streams currently is 4.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 58 ++++++++++++++++++++++---------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
>  5 files changed, 73 insertions(+), 28 deletions(-)

> @@ -2677,10 +2675,11 @@ static const char *ctrl_clks[] = {
>  	"ctrl_link_iface",
>  };
>  
> -static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
> +static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl, int max_stream)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
>  	struct device *dev;
> +	char stream_id_str[15];

A comment would be nice. Or better replace this with the array lookup,
it's much easier than snprintf.

>  	int i, rc;
>  
>  	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> @@ -2710,9 +2709,19 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  	if (rc)
>  		return rc;
>  
> -	ctrl->pixel_clk = devm_clk_get(dev, "stream_pixel");
> -	if (IS_ERR(ctrl->pixel_clk))
> -		return PTR_ERR(ctrl->pixel_clk);
> +	ctrl->pixel_clk[DP_STREAM_0] = devm_clk_get(dev, "stream_pixel");
> +	if (IS_ERR(ctrl->pixel_clk[DP_STREAM_0]))
> +		return PTR_ERR(ctrl->pixel_clk[DP_STREAM_0]);
> +
> +	for (i = DP_STREAM_1; i < max_stream; i++) {
> +		sprintf(stream_id_str, "stream_%d_pixel", i);
> +		ctrl->pixel_clk[i] = devm_clk_get(dev, stream_id_str);
> +
> +		if (IS_ERR(ctrl->pixel_clk[i])) {
> +			DRM_DEBUG_DP("failed to get stream %d pixel clock", i);
> +			break;
> +		}
> +	}
>  
>  	return 0;
>  }

-- 
With best wishes
Dmitry

