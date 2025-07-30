Return-Path: <linux-kernel+bounces-751359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D4B16843
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A4817411C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3422126A;
	Wed, 30 Jul 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="exjKs0fn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6921A433
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910552; cv=none; b=qQkrQuiMaVCrwLGYHsLiTh6ZKv6AGTwj5iLu06TGBkB69eDJD398mq5AYfNgZoINVp1tJw/H2N53oxDLsr4L3Vcv85k/a4Fp72UgsYp+gBM3+4KcqGb1smyE5dyoHn2XBSJHsh2SXzh5wkkXcfBk+JO4SQi1GJWFu47PjGOfOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910552; c=relaxed/simple;
	bh=oWSZ/7n3XM1U75SRkKFqP53PvUqbOWpgllQPKBwt920=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TqOuxY0W0L6+UpOKEd63KpZ8BDV4ErlAD2bfnBR0ZjtkMKha4vaHdZMsvCmHdfQJSZBsjVshuAWfIL+sRos6iIc0P0JoMGR4uD9cuIjORi69yD5h1JiZBUbNN3NTd6ZaVy/FkdysncbamT7RLzQOEjt2G4YDAD5GQ8mbGkiYG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=exjKs0fn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbSnl009959
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sYBqhZDEPeIr5M58HlKZvA0dzkSwUa7YKvUm9mAj+So=; b=exjKs0fnqVaIjwp1
	nO+2maFssKm8yNfs4AmLbURXATlqXBPFpjBUFbVRqF7BTz5KgryfhJak+rUL5a8P
	kFFO77HZZEnFFG/U6tyP82B0Lw7dh3cPE1U6IvZQzu+yfpykMEpi12qvhI71BlIc
	ax33FcVizqf0DmWjelfT94XEb1pA6oqGx2QWIwNsNVxNMoAZvB9csfL5JkXklHS/
	+2OzBE6235dSjtNK7JqF0Fkx3VZAQZ9Ax4UrvfhN/XhEaF8xNJ3iNedfhI12JF9i
	Ya/OMITxbM6191GkMJ71s0/ZLuddBepjweHkkMWMKcSuUxGj7LgrqpvTCMC0l1AE
	iwxO9w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep2r48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:22:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70744318bdfso5198496d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910549; x=1754515349;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYBqhZDEPeIr5M58HlKZvA0dzkSwUa7YKvUm9mAj+So=;
        b=xTfmCsuPSkfgGLLp/m1nGXreRk+ZMjXQlfBsUU8ypPOpsLEE677qYbDTW+hswmVpw3
         I9kDX0dk7P7wO2upnfiguG8uHZysYQZBYr6dIF239kcDFxyImq3P3Yes7NRBgJvo5Cgt
         ifPGsdGlcZKVWZT/+eq1aiI1A+mL8a1mm/dzprtP6IIkICpG56gce7b+5H7cAcZ4n/WW
         7ZvBqCG/GWa0BdFWnojEiLRud4CFf2YihcQeSV9mY7DiCWayv+vgBIsOvr9RiIC2tXZ8
         Pk2E4kufDd0x/HAOsTLk/wnFblYN2VSwEFlHnDUboSWCsMC5VymfICWoovvzHUhDKCu3
         cDsg==
X-Forwarded-Encrypted: i=1; AJvYcCWZyxoEAR1sUfGOJRWdmf80HCqM16gy9D5GrzCeMar4pYWnE4GSCo96ScPuSCLGv0mqSCi2758/tFhSRUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Wj3pOO3bwv9lTutbolfY2tc4Oyl9AQ1lrQzonyVFKGDxHRkD
	oPWALqp75D5E1NB++4El604f1zYf94/cRfQgn+RMyE2qqOWfe8JOBLNvgwydIoMX85SKu4XG371
	W0XXo+sJ22MY2RKWM2uh2tiRA+r6bYT4/EcCWWkwrOKcuzZaJJU4I0VRwRdl3KyRciDo=
X-Gm-Gg: ASbGncuUnTyAO8t+xBg+RJSlUbEgo2dz75gDD24DkcUNzLJly5iwCwUugE8duf5XRsK
	X6DEcf1Y3EmLshEcNHHIdhhFZXv6X3I/lWLUXBsQnPUx416335S2MQvZqVKibDG3uo63O2D9ue1
	6910QSC+oPjLjnJnSp+BJUmOGOQz3maAI8h8ntQBCoTL2xEXh+tlunFj3fdLaX6wExQlSJ3wrjV
	KyuOGpSxEf0kLdqHk4o9MvI691VYayspsqZ7xPT8wVOLqbxvZTv4t7PIoDSqz+7QHCyb1RucPz6
	vfQ+2U2EdKPnpWzwF0vs2Dfw2GPZ/e41SDmOy1vX8XIMQkMka3mrMthWbteQDnerskihaV1oClk
	OGKxvmgbWW+B2WC3HBcSblitieMErQ/BFcG6WVUvTWeHSYdj2+q0x
X-Received: by 2002:a05:6214:e4c:b0:707:885:758e with SMTP id 6a1803df08f44-707671da01cmr58363286d6.24.1753910548971;
        Wed, 30 Jul 2025 14:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5MV+8Iw3dWYCNnckYYEe/diduxsSrHtAVP0wYCv8aNY7TMFFQ0W7hSz7ssk9zenRhkQxqsg==
X-Received: by 2002:a05:6214:e4c:b0:707:885:758e with SMTP id 6a1803df08f44-707671da01cmr58363066d6.24.1753910548547;
        Wed, 30 Jul 2025 14:22:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b876097e2sm32369e87.66.2025.07.30.14.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 14:22:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250730055424.6718-1-clamor95@gmail.com>
References: <20250730055424.6718-1-clamor95@gmail.com>
Subject: Re: [PATCH v7 0/2 RESEND] drm: bridge: add ssd2825 RGB/DSI bridge
 support
Message-Id: <175391054743.2781548.8644345102818194567.b4-ty@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 00:22:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: oUtUUnURVGhleBFw0cWLJs9VDHFjnG6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE1NiBTYWx0ZWRfXwSEJAC1oRyaM
 2E16Dfn7kEqUjmD9X7jUlox+4R/bBuE1cY7H1KV+ErnPsLLtuhJNGn4bUwNae6MWVeM+2X5YC5t
 8GRJzWuaC1ypsK/drvfNNM/RzSzIAciYkEYy9sSLO3LvuA4U2c2POMTKwmdtkZidPCm1nImdA1V
 bBhZca+gl+A0Awgtctq1Nly7O3emrOe5JyLlmNbqkRZvPUHGplo8M6NXbQQeNM3c/X74I39ZIuj
 znJ5coSMT1gZyx93gHbdwbkMugGkhGRGDeEP2IXjexepvDc7utLM/9fZf8CsVvS+a6L8iIBafcP
 p7B0c8m+tBeyKhxVTSV+iuzPJKe777ebDqbPd3MTFx7+TGQgG4CdsnzgVLScWPuZZGCQQLggXJG
 lt2X3EZlD+LPgbOCHbwW7BUd8me9hZvV9JjdkaEWFG7bCZMnOgWSAz6D3ctaXselzL1uNllT
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688a8d16 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=C_mFGjxryTuD8oKKfQ8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: oUtUUnURVGhleBFw0cWLJs9VDHFjnG6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=996
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300156

On Wed, 30 Jul 2025 08:54:22 +0300, Svyatoslav Ryhel wrote:
> Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
> and LG Optimus Vu P895
> 

Applied to drm-misc-next, thanks!

[1/2] dt-bindings: display: bridge: Document Solomon SSD2825
      commit: 784c99331c8d54a51d4f3e772c81f7fb82b7a1f8
[2/2] drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge
      commit: 55023abe6a2921a8916b623c24208e1971b88729

Best regards,
-- 
With best wishes
Dmitry



