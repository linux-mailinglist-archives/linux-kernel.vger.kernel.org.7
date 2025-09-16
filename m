Return-Path: <linux-kernel+bounces-818608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4684B593EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853052A470A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE02FFDDA;
	Tue, 16 Sep 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OcRYcPsy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C97237707
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019232; cv=none; b=hiSKcgYneAnzI7ulWqEw7oyP0D0ro+W7HlR3W9WJakSfKeSJkcQqXEz2zn/o2MlZuJ1G2abVUUluQ5j2HOV+VKBRo5bQtBV91SyeC2AKDj+LQjU1bZNvBARabGiz9cnqDc14JLHP91uHSenAlEwvmMIRO2SUpZpNsFxAqNLgaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019232; c=relaxed/simple;
	bh=FFpQWvHT4qHyUa5nuRS1OsInPOcCvEXAZmT03pFavU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8l/RVlWNYMCtJd8H6g9Nh1zp2rddYYOlG/xHffs0z1Ap069SmRZgFPQUfiwXT4KF6hYoWbJIanlzaYXXTvRjz9ts64nKpR3GZH6Levw9h4GhIGFyIpGiuPY33gIOCCVDme+wtrIdUBBc7a6HY8Z1wIjS1Fm89AWOXzFyLL4oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OcRYcPsy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9n2W3001629
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=64UGI9BPuBduKWijNzoL3Z43
	ABN4/p4PZtHx1EJDkxQ=; b=OcRYcPsye6QNZckINK8F4n1XTAupxaUU9ghuaiKJ
	yFDEQdPJhQ4fBqIZDGNlUdHuy24kgNQAd/21THDDbl62ALt+qH5CxOhxEcErmUjw
	6gC8AW1jZZViaQQP5v9TgWUL4Z+3D9ue9k2qdORlnOjeYy1WqHeiW5b1ITV6e5wv
	IFR+m9UyOzy1oGWblFEDB+gmgxJ0MWkHH0xp3D1CeqmnjRcEwh/zrjZHq8krXtQD
	99ItFKCaeSx7qEgZfcBCZS2MuePAPb4rJKptcEm5Rm6GvaY0Wg3Yguo54l++9G2K
	0B9nM3juueEpdymcRy2YCXmHFr4OAOcNwduQsZ+9jnJDXg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpyhhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:40:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-82e5940eef8so1563285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019228; x=1758624028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64UGI9BPuBduKWijNzoL3Z43ABN4/p4PZtHx1EJDkxQ=;
        b=ucDgz87MIDFjFgyGVTvOjenPv2fqAEJM9LzReuL2N9jBdhBjcER6Xoc+4kvmaPRcyh
         SSOj4rG/rx9PlW+Mo1l2A2Fgvcz4jaPJJFrwRmtDaeqL6DOa5ARXkLMxCSCCMEw79pqI
         JdNLuaWRpa8kXPfi+VlC5SGQS/hL1Pp+LEs6ue3C5rAWgaN4P2APLOgLtpwGei5y7/xo
         X0mhi+KbJxZ6bRApq6KAmevxibBaIFJ5zBElhQaEBjFjvc5ZjUftVVkZbtIlWP6Tgjer
         1vaxsNOJcX0yGER0f7X8PJeHXVzNfPcRH5UmIm+z1ytavYwFhVnTRQEFn9MVKfvE7dpx
         BYHA==
X-Forwarded-Encrypted: i=1; AJvYcCX3zZ3J95rMNgy+rLpPjGOHE5CjyMc9exn3GT0Nfbeobau+p2PN0ChbOesBXNZT1pVXg2Dn6+2ppQIhrOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMXkOcXZjvpaTvGI335tAVIXg5AlosxQfvgEYfX99auTatI/u
	YUZBDC/Y1MroQHJrfjeG6MULIWlPVRXtpDn5qfovDiXBSp2pgbl9A7W57E/XYlwJUtmOTB05+s4
	WxUE1SD+ERMPmvXhW9hICHdqOccU553/JDqW8TXQX9/uy3SY9rrAmquKO4K/sWJIc3ok=
X-Gm-Gg: ASbGncvmp8M8vzNnzuifpFQ10ka1RESDJvl2VW0DZT+bZ4EIWaxDzNyvrt9nM45X96r
	SysAADNOfbqUcw0cZLQvrW3yUPL8Au1ZMbdyt3N9RxX5LSjtvRa6hYu/QhhaD49A1KJs/YGFa80
	K9BhDtDb59WafuGuIWpdXUyrr5N43h+aLFukP/y2MF+ncaredgGXXpAnJtcla38qBt723ECk7xQ
	nKfejK/JO++DtBeokrTYGFXVBK1Ee6BXKRGfxL2pjESU4XRDrI4zVokSOPDjrPpxiYGKNL+PSVF
	QedP3BcQcdcbZwADRtNA6kxnBZ9mND8VdcSvaFg7sx3mvOm+D3EEdg7Qufk/7HCq/6s7pqunvQE
	qMop48oo3dzNFUiUBwdL7WqHD5DGukWCxnooDmAJJDGlZB2vgpbcN
X-Received: by 2002:ac8:5d92:0:b0:4b7:a68d:6797 with SMTP id d75a77b69052e-4b7a68d6ab9mr85368481cf.11.1758019228334;
        Tue, 16 Sep 2025 03:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbkRuukR9ry8LUt3YkRANVRRqlhV3NS52CfGmXVJby66hPtP8JStsr+hyX+plpsZF6lw064g==
X-Received: by 2002:ac8:5d92:0:b0:4b7:a68d:6797 with SMTP id d75a77b69052e-4b7a68d6ab9mr85368081cf.11.1758019227845;
        Tue, 16 Sep 2025 03:40:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460f138sm4245745e87.111.2025.09.16.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:40:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:40:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 1/5] drm/bridge: it6505: fix link training
 state HW register reset
Message-ID: <4r5c5tbedw2hnkyqybcaxrjcc7lrdgxdbuhkzdvevdv6kmrxlw@5hb2aw6h4row>
References: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
 <20250916-fix-link-training-v3-1-0f55bfdb272a@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-fix-link-training-v3-1-0f55bfdb272a@ite.com.tw>
X-Proofpoint-GUID: CbP1NnFsoJVnYKg8O6Apm4gPGa9o-xCn
X-Proofpoint-ORIG-GUID: CbP1NnFsoJVnYKg8O6Apm4gPGa9o-xCn
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c93e9d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=EUspDBNiAAAA:8 a=pqF_GCezRlaNH4nzlkgA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX2wzBfwFh5xIm
 IxMtFGyHS0gxnqHW2g5nFzXyGNmfwN2x5apUDQpwsh1H5oF0ev/0KHW9wxJcBh/PulgRCT2Ng9E
 6rA7q9EQRW7PjkReUhlZK6g/TeQa3BCK22FNAD5cExktjoe0Oz8+c3rvJR9lsaAhLP9tyTqoa8L
 AfFat70tIq79MBsU6X423OElMSeEqBpysmZCjfMZFtoBMYt+ueuDCgfHtoeSuiGkHF2xOGc0koj
 xsBDNptvUNraOk3lb0ShhbiigubR2dWrMPFfc95obeXWwAKbk/zyrdKLHB/xkFkiDohFhNYaRmA
 aMTZIWFprKW+WwgJFOoD/187eoM99bZbJqjw5dIM7R34aakLApP6n2Gy+dFBdYxa1qWEX4CoBwn
 ZV900fwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Tue, Sep 16, 2025 at 12:47:41PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When connect to a DP-to-HDMI device which does not connect
> to HDMI sink, it will report DPCD 00200h with SINK_COUNT = "0",
> and issue HPD_IRQ when SINK_COUNT change to "1".
> 
> IT6505 can not recive HPD_IRQ before training done and driver will
> force HW enter training done state when connect to such devices.
> 
> When HW is force to training done state and restart link training,
> bits FORCE_RETRAIN and MANUAL_TRAIN at REG_TRAIN_CTRL1 must be set
> at the same time to reset HW state.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

