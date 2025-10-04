Return-Path: <linux-kernel+bounces-842007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5403CBB8C37
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD8119C2D61
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B607923AB81;
	Sat,  4 Oct 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EHdf8jSy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72899213E6D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759571596; cv=none; b=TSQBhWB1212nk80IRxoPEbepOMD//oq2PIWqhAMdV2IQo+LKimU0v1eIi8V79GvRHxS8BNOeKEwW4oS4zC3QZeWUVIPII4hHrN0X+EYjK0bC65gCBsnLJ5sUntRTpLC2eN0vt2I/UKEvXzoYBXZqAmkuzktN4yVa4gpnbDIhe68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759571596; c=relaxed/simple;
	bh=IcIPtQiWpSeMO818KUlsCLajKwr4Lh2CGTpur3OdmUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcW83KxwktHmuylXmvLMiVP4qwzs4Ye7nyEYVkcr8QM6L4U6+H42gPH/atw8QPX2lauj6VhvzNQfEtIlT0UFFPsSiSfeNqq5WtJQO0NT94hJNgnt7ph7eg81jp63yX6DJyqvYpWID5UdHBaFvChIFXYY8pw53aatnzPClMUvI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EHdf8jSy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5945U5r9027786
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 09:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PEu4XGrNpP8Sls3jA34iE2v0
	JtpnErFtIM1Spm/CEcw=; b=EHdf8jSyX1HVhonHRF51NNtpRt5DKbEgf8KW+kNV
	wsBD/DhcZn7FoP8DyV3mu4ukIp75k48epks5mY/1wBKgHhCCyRXs7EEBaF1/bliu
	E3/HdgznVJjJKWX+M+K1LpJQ97kpCEYf9LyuTI7hTgQ3HHpp+AF3LsizXbqCJaQl
	uN82/3br3CfjIUDDGocP2mDDo07Dasa8ozWzyq0s3PHtAFs6St3F0ij4xm085ZM6
	L252K+lY5vz/iGZfXM7plzUeESq/0V8CgybqLvOtxqXu67WzeKsWWE6X/EqBCFxe
	m5krfjeL9MUPnD0R6dcC73zK2YWV+L/90+50roTsdvwrdg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5x8h2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 09:53:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e56cd1d360so75769481cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 02:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759571592; x=1760176392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEu4XGrNpP8Sls3jA34iE2v0JtpnErFtIM1Spm/CEcw=;
        b=DByftG7kAuleeFd7lCfeF/Pho89lqPMwdFqi/uLGWYbEsRLn23ne+qnOJNHV7cKxZ6
         lTIkjep4vHTgTEaemgO4ms1OeLLO+bRyyypTD2AFx7FveUlVZPouR6cKMoUUdSvtc6Ji
         RmBvzghO/lbf6K8QjfEL0oxoC5xNb1jjYcqYWOQQkHaWnEqSh3RGeF/YIXZTXkG4J5ua
         hbrprzjlqsfGn1G330vdlqlP4nXQe8XQI62bBJlIDzRxwkvURul2Y6j8ScpBOLyFJfpl
         WVHnnhRuXgtRWABOhgRpNud0DldjTTLfDBSrd60pGc1+HkYKJXBh/Yh+HaEcbmxxxPeU
         eR2g==
X-Forwarded-Encrypted: i=1; AJvYcCVo7RCglv+vCZWSgkNoRCOeyyW8AoS44qFZZ6DhVQn5UUgNbhKjSJnkToZ95n4nfGDP1NopxFQWCl2+khE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeA7VYkvXb70ryA3lMp8rtTdYy52lk3dvGB5Xm/0C5T2x3Ww+H
	MQXqXk2MCpG5s69zNwK37h95+naifw1ICCNBb70x1HvjxXsWV12W8+jcxzL54GhpnUOLG31lIdP
	0UuDqxOGoatqcF52N6RJJFQcPeFtaxXaDdj6En7Z1UaLND6HfZFW/DfTJEh6RuQrdtUs=
X-Gm-Gg: ASbGncuF8j6SXZl2zuNXNeFjpWo1fqbaUrjE7m2Wk74cQhW0zSWjAYS1oLp+cQEY3st
	bmQVrt8W1mjVXJ9GnbAxG6/6OHe6nELnP0uWJRdeiHf9YGml8WNPecgYhbrr1LrXZL3W69wkeLq
	ekoAvQmfJw5JjSSo3qAAQu8IzIFwfu27s7Im2clEbdfaAfVh+CsULF1OL6cZQCHzzHhPl0MZpbx
	KDaZs6OHD/XbX7XMSD3uVJDa1vVI6wTPjH7K4CzE86du4fkpof+2jRBjti3o/zPFpbOwxcJlQ86
	lNLn4ofZ6TvUB8bHcRblubcv8dUgRdQLYcfDXBzz9RgJbM28Kb5GS4VDkptBXRRJyJCAdKqfIUe
	ACrRrcE5f/PR6ZmPPZzRLjTGse1T9buI+f3ujRJK7LVeU0rvcdLbq9+blxA==
X-Received: by 2002:a05:622a:98e:b0:4e2:f1b3:3466 with SMTP id d75a77b69052e-4e576adc4dbmr83002191cf.49.1759571592329;
        Sat, 04 Oct 2025 02:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTbBIG6kyIQSt9ZYaRoA6T3Hag/xgJTs/P9Rv1Tz+gyuxM60ZQciRckMkBxOJAK+a1jNQcgg==
X-Received: by 2002:a05:622a:98e:b0:4e2:f1b3:3466 with SMTP id d75a77b69052e-4e576adc4dbmr83002021cf.49.1759571591862;
        Sat, 04 Oct 2025 02:53:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011ab24fsm2675693e87.120.2025.10.04.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 02:53:10 -0700 (PDT)
Date: Sat, 4 Oct 2025 12:53:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        airlied@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, simona@ffwll.ch,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        jani.nikula@intel.com, praneeth@ti.com, vigneshr@ti.com,
        aradhya.bhatia@linux.dev, s-jain1@ti.com, s-wang12@ti.com,
        r-donadkar@ti.com, h-shenoy@ti.com
Subject: Re: [PATCH] drm/bridge: sii902x: Fix HDMI detection with
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Message-ID: <gc7prlpfdb4zgqtxz5fog2mi4x6vefwcrnuw53i6xbd3vguf3h@gtb3bdy7zogu>
References: <20251003143642.4072918-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003143642.4072918-1-devarsht@ti.com>
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e0ee89 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=sozttTNsAAAA:8 a=KF_ZkVnESvHIPKe9pLAA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: klzylW75fdTC_uxaW6zSJLJcerZo7vfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX0dHMyM7A/0gV
 bYE16kuCH29x5X/M0IcBMPjxKUshKO3yh1je6J/NhxjjFqDZdZUGa0HqGTTopVtUnlJknKQVUfi
 EwjMWDNp4E/NVYbCDtdKZBUkRzhBP7bcDJGxEl41k80Cv7ArPA81Aw2wRRGtxJE923QvylTTS7W
 Tks59dBi6ahv2bOeh1cr2liHZ/87JNDP6QMLk5pDAytAUPByoDEDSOEcWTxWrPKZFyCDucqSmtZ
 YTsrJjWZSu7GwKVHTylI9qvkVyr6R72Dktz6keYPAHn9CL4wLTjW9CfWZb62a1X7MYvH/WMmSFs
 290DUkJGdy01iq/6ZN4Gpl3mZYAtxaEwFUykQuQJkEpwGzkjIeVxn/NRcwljgkHF5ZyaHL7IGol
 MXLp4S37bIpYvmJVgWoFsaT+hVIBDw==
X-Proofpoint-GUID: klzylW75fdTC_uxaW6zSJLJcerZo7vfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On Fri, Oct 03, 2025 at 08:06:42PM +0530, Devarsh Thakkar wrote:
> The SII902x HDMI bridge driver wasn't working properly with drivers that
> use the newer bridge connector architecture with the
> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, like TIDSS.  This caused HDMI audio to
> fail since the driver wasn't properly setting the sink_is_hdmi flag when
> the bridge was attached without a connector since .get_modes() is never
> called in this case. Fix it by setting sink_is_hdmi flag when reading
> the EDID block itself.
> 
> Fixes: 3de47e1309c2 ("drm/bridge: sii902x: use display info is_hdmi")
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index d537b1d036fb..3d169b9fac70 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -292,10 +292,16 @@ static const struct drm_edid *sii902x_edid_read(struct sii902x *sii902x,
>  						struct drm_connector *connector)
>  {
>  	const struct drm_edid *drm_edid;
> +	const struct edid *edid;
>  
>  	mutex_lock(&sii902x->mutex);
>  
>  	drm_edid = drm_edid_read_ddc(connector, sii902x->i2cmux->adapter[0]);
> +	if (drm_edid) {
> +		edid = drm_edid_raw(drm_edid);
> +		if (edid && drm_detect_hdmi_monitor(edid))
> +			sii902x->sink_is_hdmi = true;

Just call drm_edid_connector_update() here. The drm_edid_raw() has a
very nice comment:

 * This is for transition only. Avoid using this like the plague.


And we really need to convert the bridge to the HDMI helpers.

> +	}
>  
>  	mutex_unlock(&sii902x->mutex);
>  
> @@ -315,8 +321,6 @@ static int sii902x_get_modes(struct drm_connector *connector)
>  		drm_edid_free(drm_edid);
>  	}
>  
> -	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
> -
>  	return num;
>  }
>  
> -- 
> 2.39.1
> 

-- 
With best wishes
Dmitry

