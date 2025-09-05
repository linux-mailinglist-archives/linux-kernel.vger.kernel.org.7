Return-Path: <linux-kernel+bounces-801848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097AB44AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C8C1B210AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1713E2114;
	Fri,  5 Sep 2025 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ANr/enwS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A821FC3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030729; cv=none; b=WZxU5GB8d9jGJ41G1Cc4maORVclVgaXdKE5shZdfKgdtL7YlWYgsiSNZgE1CbqoXmAUfpW5CKVnh3eE8SPV6lwFP7lAzol4pikBH38d2EQSywFXr+99qNMNGIJSCaZA/DSvmxr+LxkcARq8NNkNLlDceFkk3vycDwjXXWo2LxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030729; c=relaxed/simple;
	bh=k0gBJ3jogdj1uP+WEsVSt9XnOlRNVILT17dl4GNHiWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1Qk4/GCh/jBFNKi2Iar1i8T1yAlkopmuOc7OJI72JsNmmoZoW0Ph1YWskri+myyLLyVOWsYBJOIhvKKVYZE7Lf/00vzKqoJ4x+3wwNqJFuythnrTGOXsVVZujqnGlsM9Mo+RYfBBPcJfcp6UdLhKsfzcACXSBYt9HxZr5a7tAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ANr/enwS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584HsaYE031741
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FnmVTYg5qyuC90TtxfAp5dg0
	tH1WOGwDVnnWVDmLEjk=; b=ANr/enwScsWo25ym6A1EbFIwB93CVeITfG6TuTZx
	pQTNyfMDG8Xa7Ezx1E9lXfol9wnfY20WWcZ1cZbJBBou19QgAkT0glyuuZeIOeX4
	a0AUMxBP/GE1bFIpcGJYPUCVVxQk/ijPxwWqETOQFecWo+4FmKDfIATFMBdGst8V
	W28PAhm3PTEduaRGkkrY+HBb19Vq1TAfQ6NLhOd7LSXCmRq9NgZ4SJJcV8x3tDFd
	KYh+Zx/N7Hx78Jd+fhI5Q8Weu1SFTncOM1BU5XYGP44AQRj45IRkTo/HdeWdjqCc
	sAFxdBG1xZQexXDbkXRlAiULQIOCiOTywAEo4UTXGN251g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw09a6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:05:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b3415ddb6aso48462401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757030711; x=1757635511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnmVTYg5qyuC90TtxfAp5dg0tH1WOGwDVnnWVDmLEjk=;
        b=Zr4FKtPgKHpP1s/oD9yVBkJjzmrdnrj5FosN+kigt0c2TySDLPYZJd5bVrxxbtLhMz
         2CVBM0iyjEE8cVwjqHfbX6NtPQsxP+gTvh9atm6j2LCbvv+FXqsvuiKlGl95JpKMudMn
         +PcedZJJ172WWnmb1QGxRzCxs04gtXbjaVYRgI2y4zICIGpALzOvLkI8ETgoV+x/vZNb
         /ByUEAsLqPb73BMfTlK7i1BPMMTGk49TOLmq+QmRAm3ctMdTBiEexWwQcLf6/RTL+lRH
         4X0fzhC53x3zMMyf+/Z/pLJt3ARQKEc31TqSuarv7fuZYsbohg0cx32Ph8BUXLHVxqA2
         wW/A==
X-Forwarded-Encrypted: i=1; AJvYcCULCBlNl1OZQ4kw4PfBwdTe2kk07mdP1ydEE+8KGUGU/0P76KYh7d2wAFgS1WUDS2CEy210uWEtyowLNcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2Ds+q2C5zB7SRa6377loyrrbi0k1TdYwMWwFuvpocd78IFJZ
	FkUp5f3lyjzsbG6zhuZVBtmBxbG73a//+PW1nnIqFsDbu1yDneSJpinJE+kGNLTC/6gyIf9MYKC
	DpOdr08WDG9aKQ/3QggkuEJPGIAnJty335Q7RwZu60U5Zsh/dxjSOrQPCI57b00r3gGc=
X-Gm-Gg: ASbGncv+pdwZyAQk2yqSMMtHNly6NJVfFEIyRE8ozWOHF5sCEGoOJJojwUY6IxWZslc
	d6vrOPR8B4usVfyxik+omeViO9A7I8k2WSZ3dyjFq5D2LE3/05va7To2m8DTzqPPUGL4O31KDWC
	CLw1EQI/TfQ+uYXSa0V9Y6f0481mjExf7+lnT6XQglLTGNKP3MPZYci33pxE5KbasYqjfT+lrie
	STN15gR4YWe+1ImK6caPomL5r26Wl5lA0mOYshICKwUTumgl8zJZwXji37i0I5wCHja1E22LhVP
	JIHznofgNEFfaJ4+77KPM0MNpfBnPfssECvYqODoWTCokrctWw+rrcFeFpYWGibqY4xBRKgXHhp
	E1lbXtz8gvcSWkHY83T/03t3+UJpaNWoLYu/AdAJrFmewwf9bJJX/
X-Received: by 2002:a05:6214:2025:b0:70f:a558:2955 with SMTP id 6a1803df08f44-72bc355d107mr23891016d6.22.1757030710942;
        Thu, 04 Sep 2025 17:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuz7rSIAfCmUlEAAoYDamxMn3kE6MVpgENng2PopXAtvFP/43O0lsMhMkHtfYx9Az0yrIbYA==
X-Received: by 2002:a05:6214:2025:b0:70f:a558:2955 with SMTP id 6a1803df08f44-72bc355d107mr23890406d6.22.1757030710379;
        Thu, 04 Sep 2025 17:05:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4d3efsm1478298e87.146.2025.09.04.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:05:09 -0700 (PDT)
Date: Fri, 5 Sep 2025 03:05:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, mripard@kernel.org, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
        rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
        knaerzche@gmail.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 1/2] drm/rockchip: inno-hdmi: Convert to drm bridge
Message-ID: <u72vkfojufgvuqwuqpvgvnip3wogpgdcuc7bn46zo3bp7ogbu5@fmqotgyahrsn>
References: <20250903110825.776807-1-andyshrk@163.com>
 <20250903110825.776807-2-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903110825.776807-2-andyshrk@163.com>
X-Proofpoint-GUID: s3g86VwSBWXa2OLPEevWI_FPM0RlBjlW
X-Proofpoint-ORIG-GUID: s3g86VwSBWXa2OLPEevWI_FPM0RlBjlW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX6lo6bWlPZ39z
 nyph8uhUJN90xEOf62DsxuUdcHKclKRdw1A0IMLrr8hrtSo97zv7Ht+V90uXi5ahhlNPBY88oFR
 RJDj5mTWKs6OJpU2Dr2felwT8SUQEKid6m3D+QOlg7F9aUGKaGFwDGjfpiVDaa9LmrP/fR5ZgQ+
 y/U5laNFprPYdZdCp+PGd0ZoEVl5+Fj11op5LwkjnrdcHAKOIQcVA4Pgkwk1FwdIo8a3N4CgnS5
 idx0ad28kzuCKmU21o9xDLeKN32gxfyPEiyvQaqAaffjdhu6/GYHTYiQTv/trI0sH6dtWesE9gN
 6YkC4kDTKpdCro2fWryQgXxbQtoftapJbp8C6EUlbfN4CX6RQtsq/4wciOq78KfNVfBEmQ5Rr34
 dp6uH6gf
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68ba2946 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=s8YR1HE3AAAA:8
 a=kdxkXz20giiO-m4nxtAA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Wed, Sep 03, 2025 at 07:07:38PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Convert it to drm bridge driver, it will be convenient for us to
> migrate the connector part to the display driver later.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v7:
> - Rebase on latest drm-misc-next
> 
> Changes in v6:
> - Rebase on latest drm-misc-next
> - Link to V5: https://lore.kernel.org/linux-rockchip/20250512124615.2848731-1-andyshrk@163.com/
> 
> Changes in v5:
> - Split cleanup code to seperate patch
> - Switch to devm_drm_bridge_alloc() API
> - Link to V4: https://lore.kernel.org/linux-rockchip/20250422070455.432666-1-andyshrk@163.com/
> 
> Changes in v4:
> - Do not store colorimetry within inno_hdmi struct
> - Link to V3: https://lore.kernel.org/linux-rockchip/20250402123150.238234-1-andyshrk@163.com/
> 
> Changes in v3:
> - First included in v3
> - Link to V2: https://lore.kernel.org/dri-devel/20250325132944.171111-1-andyshrk@163.com/
> 
>  drivers/gpu/drm/bridge/Kconfig                |   7 +
>  drivers/gpu/drm/bridge/Makefile               |   1 +
>  .../inno_hdmi.c => bridge/inno-hdmi.c}        | 502 +++++-------------
>  drivers/gpu/drm/rockchip/Kconfig              |   1 +
>  drivers/gpu/drm/rockchip/Makefile             |   2 +-
>  drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c | 188 +++++++
>  include/drm/bridge/inno_hdmi.h                |  33 ++
>  7 files changed, 366 insertions(+), 368 deletions(-)
>  rename drivers/gpu/drm/{rockchip/inno_hdmi.c => bridge/inno-hdmi.c} (69%)
>  create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
>  create mode 100644 include/drm/bridge/inno_hdmi.h
> 
> @@ -637,14 +584,13 @@ static void inno_hdmi_init_hw(struct inno_hdmi *hdmi)
>  	hdmi_modb(hdmi, HDMI_STATUS, m_MASK_INT_HOTPLUG, v_MASK_INT_HOTPLUG(1));
>  }
>  
> -static int inno_hdmi_disable_frame(struct drm_connector *connector,
> -				   enum hdmi_infoframe_type type)
> +static int inno_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
> +					    enum hdmi_infoframe_type type)
>  {
> -	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
> +	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
>  
>  	if (type != HDMI_INFOFRAME_TYPE_AVI) {
> -		drm_err(connector->dev,
> -			"Unsupported infoframe type: %u\n", type);
> +		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
>  		return 0;
>  	}
>  
> @@ -653,20 +599,19 @@ static int inno_hdmi_disable_frame(struct drm_connector *connector,
>  	return 0;
>  }
>  
> -static int inno_hdmi_upload_frame(struct drm_connector *connector,
> -				  enum hdmi_infoframe_type type,
> -				  const u8 *buffer, size_t len)
> +static int inno_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
> +					    enum hdmi_infoframe_type type,
> +					    const u8 *buffer, size_t len)
>  {
> -	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
> +	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
>  	ssize_t i;
>  
>  	if (type != HDMI_INFOFRAME_TYPE_AVI) {
> -		drm_err(connector->dev,
> -			"Unsupported infoframe type: %u\n", type);
> +		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
>  		return 0;
>  	}
>  
> -	inno_hdmi_disable_frame(connector, type);
> +	inno_hdmi_bridge_clear_infoframe(bridge, type);
>  
>  	for (i = 0; i < len; i++)
>  		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i, buffer[i]);

It's not an issue for this patch (and I think it can be fixed after this
series is merged). I took a quick glance at frame programming. It feels
like the clear_infoframe should be poking at registers 0x9c / 0x9d. And
write_infoframe then can support HDMI, SPD and Audio infoframes in
addition to the AVI. I don't have hardware to experiment (nor time :-)),
but would there be a chance to improve this?

-- 
With best wishes
Dmitry

