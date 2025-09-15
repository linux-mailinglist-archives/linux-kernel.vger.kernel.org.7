Return-Path: <linux-kernel+bounces-815977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B4CB56DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63DF1899E62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03B1EE7DC;
	Mon, 15 Sep 2025 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSebP3PF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE411EB9E1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899782; cv=none; b=BssKqKDZ8GJbFR/SzKSW3io5keeEbV+jgH/zzIJI6Q1Fyj46Qrz6hOtdSQMq4ajj6wnpd8/bMlvg1j6pu5CdbCJbZRzJt+J/EKGg3nSdlw5RFUtGIYxy7JTTPLldVsWpbOh7tEvug0soD1NlGTCQXfg2ZQHVzD7SgXu54WlEvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899782; c=relaxed/simple;
	bh=FS4WMqgsqslR4yDWGigWbxBQxto3nkqKf5A+vLEdBrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxtD3cjTalcblzDTmCgJ7asVCvD8Y6gcj5MetAsPYIlSAxGRaNH2Lign54t/L5Gd1qym/3A+cKeHlSWwsj0TJu3ct2GQUz+pfwVnQPrFuchG6MHL5bcUDEFVL8EpOBVgJGbBqkZYsqj4Oeh5XcaQSfjvlClbJLGw6QLRf+dsN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jSebP3PF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EJmtYL016483
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=081Ts4c6Sl0OMTdPbJAM4b0g
	9D+s7Gk4DCZHTNQm25I=; b=jSebP3PF2GJc0EO0CyCoQ4wOUz8FaULrliEErGkQ
	53bCR+QfGjIC52oSR29edinDzljYwO5dgc5IQlOfmjr51eUFBUEpmFO5r2H9/6T7
	M1HnakzrPNf92HLBHgxkDNjpo78pTh4qGDppZ3Y7O7JTlQheWKMdhFW9aPQLO4qF
	tHhiBGCrqaWQkYU4bv0yKec+AmE+M1d5ZMissAW6L4Jgjr5HYU+AdHOJK4ADybIG
	il6/oJH4gu2h4+0YpSMv97Ud28bYsF2zMv5W7x7IjCCFwx3VIhqtu7YnBt0w5W6r
	Zs3GEd3Rok+Y60JR0Z+SDKhiPV/W7bIjQYYTGc3TjtLltw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpsvjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:29:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f818eea9so74852011cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757899779; x=1758504579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=081Ts4c6Sl0OMTdPbJAM4b0g9D+s7Gk4DCZHTNQm25I=;
        b=IBvwscFh1y+MvqIhAjpcE9C7LK+TTHTFHqInGn1edwa5JvS1jvbWlg1wDGDbBSa7IH
         Qx7j+1dsvF7zmGp5LuBftqZuhL2cqMU35UTF5kxY4btFAX/dT/n1kbKT41pZpOabZgjM
         rJ3ASR8Ni3AYJUhKbjsiwON7NfO/3hGCUjVzSPEtlP4xSMqi6ZDgCdLHwXypiXLwhq9s
         TCupdVjotm/DRxv/XEc3+t51KMY/HBh2QwKQzeWiMzMNHU4jAGUZ+dkU946iz+LPGDSQ
         2gMMACx7vUdzaj6uztJrTGpC3sydldblHIiW/DM6VuYi22JAlG2ftIncCLLrtLIqYvT0
         2MvA==
X-Forwarded-Encrypted: i=1; AJvYcCXW11rONbmHlWdCg8tHzZ1pxGqrdoj6+9UzqhhRKXXElBUWhv6v/tEW8L1cTVVH2xAvyZ16ozmeNC2+HOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOOWZL3oUljWLh0EqN1swzkFrVuZvPz+ZTQgtVTqNe1VdUou9
	ReRxd4mattOPbXuEo5K4z2U2p+FfGNuZj27LzDl+bYVvvj9d7TKyZfdOatIOGRG+SuMcPnR7Zj5
	+fYxvhGmAZCX7QrzqJ7gA6O6K05dJ5ESaXaDkrQrVW8/ST/PSpgxExmOCMwhuNHpf75Y=
X-Gm-Gg: ASbGnctz+E1fLkB977KYBR5ngE81ie2RymrZQyZYJ9S1Tlv64ddgNAA5vJ9QJWpPUb1
	wPJC2r+2MvQt8LDBAtXQMu3d/34r23zBmnrRFhaewjd1EShQ601By+1gRlW8NdF/3wCgFIDXbWa
	rDHQYdX/xzFxOPWoTagaCsN7PL7vl7WEfxVPYbSYwZ+rcSQ2nPs03fgAJ2YGSt9I6s1s1vGibHd
	RqVmcYXvoJWVomD9gVivl/sODxmGzdsUNm53izgMKi6R+Fs6hCsAFY/rKkjEl9SfYbBvttH4AFY
	TT3m4DJEeUwUfRbczutaRv8kfbZm3b3huBWeWPnp69H1WYe+6jnjC3cbebAs/Z8ebe8yaOiAzis
	PAzmy/zuQF5IvHW7MQS/VPL7zwrrWRqN+cI+Tpv7sazrba2jIkKk5
X-Received: by 2002:a05:622a:4a0e:b0:4b5:fc2a:f37e with SMTP id d75a77b69052e-4b77d032443mr172471501cf.42.1757899778701;
        Sun, 14 Sep 2025 18:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfUFHnOueB5jfdanjNOkV7FBhYmPgfOM+8RbjwGzLjcGFLk0hmRdyW5v0/zJDOdx5fQLi0Kg==
X-Received: by 2002:a05:622a:4a0e:b0:4b5:fc2a:f37e with SMTP id d75a77b69052e-4b77d032443mr172471171cf.42.1757899778272;
        Sun, 14 Sep 2025 18:29:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65d119eesm3302734e87.141.2025.09.14.18.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:29:37 -0700 (PDT)
Date: Mon, 15 Sep 2025 04:29:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v6 2/3] drm: panel: nt36672a: Add support for novatek
 nt35596s panel
Message-ID: <xi65tabv4sgblzmw52wxci5wsrdahshvos5we5wko4kfcfyozp@y3vw5gt3elwv>
References: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
 <20250913-nt35596s-v6-2-b5deb05e04af@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-nt35596s-v6-2-b5deb05e04af@ixit.cz>
X-Proofpoint-GUID: 1iaGKuzr-0Z0DuMlqFZINnyZFe-9ahJd
X-Proofpoint-ORIG-GUID: 1iaGKuzr-0Z0DuMlqFZINnyZFe-9ahJd
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c76c04 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=KKAkSRfTAAAA:8
 a=UwVoJdtYwaWtV1L1Eu4A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX+ZsGL+Cj6Nhp
 5aPRGZMt4sCm9mePILO55rn1K0g9wi+H2XHQWLd9vDFnDJLK8u9BC5Tvob4pibwYT5ag+bA+uL5
 wKTeiUIwCuq9L8b4ycEXrQDoa/vN/b0JoOtPEFeaAbgQDCSC7ClDBnyB4U8V64Hnjll3Oy2WECG
 Q57pLjuxQdzLtyCEOdqEGjrYH9Kp+ni5R1LLU6zSIOSAogpm1qTNQ3YXyku0gu17+Ky9jh++Bjc
 G4FyK9P9DfCjoZMbbXcvncyvbAnxoQBVuOyWHeA1r9II0F2imHj2Uv7R07/v0NOSPzbGmRJw5Hp
 d+ozBFbjBFk+yIaGdn+T7WRSLURgIP3dLRL7SV4NDlioVFHP0AO/MNqHZ5Q67Xl87rDAtiNfqUF
 BsUBgRJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Sat, Sep 13, 2025 at 09:19:48PM +0200, David Heidelberg via B4 Relay wrote:
> From: Molly Sophia <mollysophia379@gmail.com>
> 
> Novatek NT35596s is a generic DSI IC that drives command and video mode
> panels.
> Currently add support for the LCD panel from JDI connected with this IC,
> as found on Xiaomi Mi Mix 2S phones.

Why are you adding it to the existing driver rather than adding a new
one?

> 
> Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/gpu/drm/panel/Kconfig                  |   7 +-
>  drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 225 ++++++++++++++++++++++++-
>  2 files changed, 222 insertions(+), 10 deletions(-)
> 
>  
>  MODULE_AUTHOR("Sumit Semwal <sumit.semwal@linaro.org>");
> -MODULE_DESCRIPTION("NOVATEK NT36672A based MIPI-DSI LCD panel driver");
> +MODULE_AUTHOR("Molly Sophia <mollysophia379@gmail.com>");

??

> +MODULE_DESCRIPTION("NOVATEK NT36672A/NT35596S based MIPI-DSI LCD panel driver");
>  MODULE_LICENSE("GPL");
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry

