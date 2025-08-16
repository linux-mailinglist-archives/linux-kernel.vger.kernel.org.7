Return-Path: <linux-kernel+bounces-772010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B9B28DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBC07BB310
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA832E5B38;
	Sat, 16 Aug 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzF61BOf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9E284B27
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348077; cv=none; b=U/ZswbaX0JwtYSuS2kecEyU8HRQlGPhAsLU0961lxGjCmRSD4WSv7zp9G5DlR3VPT/qjVxiy2GUlpPe4PFLvpYU7MdppccVax2YcyqVenmteWKJ4dFsMVLo4IH0V8zQgy+iv+B/p4Ltfe7YG9YkaRyIFg9gqVoBv0vpTAqqKLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348077; c=relaxed/simple;
	bh=ics5UJu435PTkR3N2XAnDPkmPWB0LL/sCgBg7ErLZlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVrVqfjZnDySan47sYjI03aW8HLz90/TRNjW5aQJazGsSi66GiL4TyoTR8qEE6Qmt9HKbK9Jl/uPE8ONBREtmBtLgMe3ffzb339TKsPH7LOAva2k398qmMDSr+ZA7sFTa6bbwy7fsOyqmBZXlmuDi1VQeyPLgkFkYxCBi/BOoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzF61BOf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3ZTY2006416
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TBBRBvbZmhS5MEDtIi65bqiX0+TlTd1eeG9t75hRPEA=; b=BzF61BOfHC/Wx1vM
	JMbO+2U9ceQC6hSZZqpe2WMC+JYUUEUgHqmV2su1bxNxoKe47vYUAbfiWfx2acoN
	pZAWVO9TtuTS5hcedjk4ESPa3OPqJqQsWJLC9CKb64lNo8sW2j3qSTCpYDoAInI5
	RTkRAaciWPSackxvFAjSLUACz2fLhcGxoiAcZeGcZuWAxtMtFWl1sTkFIKsdOYEl
	RK2k5a5C4CtUoWYrVc7IoM3RjdE1l9eYP/qtg74Gm6wSsOQ2KV4Qd0nRVL3iUlA+
	iF60U68OWNMLyzMDGvzaU9hJdL7OlT8WU5Tx4BrDyVrdzitRaI6hYqEOs+dAlcu3
	/2476g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj740m9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b1099142e0so77742421cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348069; x=1755952869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBBRBvbZmhS5MEDtIi65bqiX0+TlTd1eeG9t75hRPEA=;
        b=aRRqrgohlvikQY5IygJtrRollJtXP8dMTPkCUfGtMhAWs3BKs2xTqsguUW/1VD7zlj
         PdqWPn7szN56ey8TY41rcn/6UnEj4QizJO7GUyhA2sOt/iYVMCD+MMuUooq8AoAFGuJM
         MfE72AHXXsZ6PT5joXY9z1xARwkfnHUDoYg4w2mJ6QwvrP4GF0V1GM6EtsPC+91TOdrJ
         Qazwk6wOW7SaQJL4IuByhPZViYepY/fCQtDf0JU5QytUZRokSjvGAntLLUIiG2TbHtdI
         4ED5vLxJWZsIN9Tz0dZYKYQO6eSriKv9EjeemsTo0umo0r8J4QIyjBw6LQdj4JJn247v
         PWqg==
X-Forwarded-Encrypted: i=1; AJvYcCUU7Zi7i/pDViiDBRsU6FVX+GiNlp9HWZYbSR+2RR4OE488SzFuNGLGjjtFTvNOfolHUMZIcuQfp+VFcXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhBI1wPEwfNlZ0B7KOaqw+zBm3QBThfJkMpwzfQL3XkwYd87s
	jLfjnR6nsN5xMsD4/HBPlDkILCDg9Cj0/WLucn5DkTM2Uq7g2GyRk/f+3asMbvCjWhVyRb7wQJ/
	Ks4R49WGWZ2amCSQiogso5QD3aPtQwXoIqdtRQZri97Ek4U6VhlZDXhoQa0bdrV01pgQ=
X-Gm-Gg: ASbGnctYt077Oa61GoTPXx1gUZCOhsZn5l9S/gQhRG6pZBboh1BfOywmG4cRSe7apBm
	/pGVvb2h92At29PfoGy9eVrGrjkSp0zB+5hfREyUpbQ+gTiruwiKdoD2bv2tmtdf2VBVYkWGFyn
	dG+HRsXQTthJlk9Gf0zBdXeLUBKkjIFRVXA9NPTs7iN5ObSp0anYOVHkd93OsGfCqBlBAwdnAQZ
	tWh8AwFiSKHy18jwhnCG4waNemXE0VJwceG5qmAQDS8yena0l58AVh9DPBmabhj/HOEkR4voIbK
	EDEn1o+iUjyTAJ4/x7mxXMU+JT3FZ0JRcHimVyLringL3YKT+gHIWKP2thfWdXb19PNPor9Gj55
	PQ4w/Oi2EXUIQaR5FezpA16Lp1sOwLQVv12McXz6ihvcF+1F37WLx
X-Received: by 2002:a05:622a:1108:b0:4b0:ec28:6fee with SMTP id d75a77b69052e-4b11e23aceemr77143001cf.38.1755348069191;
        Sat, 16 Aug 2025 05:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEujKVPrwnqPmVwBrT/6yKZDdIPm7Rj84fddbqZ46SbGO9mqJHM95gjJV/0J1FbKa4y9npTlw==
X-Received: by 2002:a05:622a:1108:b0:4b0:ec28:6fee with SMTP id d75a77b69052e-4b11e23aceemr77142321cf.38.1755348068724;
        Sat, 16 Aug 2025 05:41:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca21sm856554e87.104.2025.08.16.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:41:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 15:41:02 +0300
Subject: [PATCH 2/7] drm/bridge: adv7511: declare supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-drm-limit-infoframes-v1-2-6dc17d5f07e9@oss.qualcomm.com>
References: <20250816-drm-limit-infoframes-v1-0-6dc17d5f07e9@oss.qualcomm.com>
In-Reply-To: <20250816-drm-limit-infoframes-v1-0-6dc17d5f07e9@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Liu Ying <victor.liu@nxp.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=936;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ics5UJu435PTkR3N2XAnDPkmPWB0LL/sCgBg7ErLZlw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooHxfM4SU8e3MmGmakUS5mUvOK2lRk5Rg6pgaF
 Culi/ZbaOyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKB8XwAKCRCLPIo+Aiko
 1WmoB/0R5TBxmhvS4QiRmSEhjsQzSxvsfU1laRFx1oRGjZ1ar4jAOFsu3PQIsiMObIXEZWQYtlt
 Dj93ckAo+pDbud90Fki0EYit+uS7JUpd9EiQbxx96Jg0AkYoYu4KGHxOOUbVAXzULWQ5nEQv1A9
 tUjphXky2tRQvOSKl1/pTUPmRBKOOsESu7sQ6Ies/giG2MuIzwKB5Rx1FdxnfB0kNoxYZG7x/R2
 ETKyAzxVXIvMtGQky1Q8JGRdf90hMN4xz2OPiK4qyyJoz0++r6wWjj1TNzeHLacbKh5IIRzQkje
 GKf1BwdeSqphn8lh67+Vx9V3VP7Kb7S7DfYbHr9aVVy1SIa/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: G2iF25fKzvkJiL6Om3mMet0BsAsWR171
X-Proofpoint-ORIG-GUID: G2iF25fKzvkJiL6Om3mMet0BsAsWR171
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX/KXLlFL3NEWn
 S48iDktIKClz0lOwCY4IJwPU0DMC0SxpoSJ4urSe5t+mNP7hpGRV9jIpwvG4Xx/AHbV3Mit8Fri
 nh27RH7GFSt6HnYKhBTwp4tasHFjBxPpeowr9SkEWRvg6Mr4CB12pGiJvMdG5dR1Wajxnz/3vc3
 WBbKRLa5Zk9Rh8GM4h1dLr8MRn5C2yNZV/m2RnLru7+UlvQ+EBxacV1ITmq6AxEJYMfX90XnSdh
 MuOqdvUJb0yGXSbJnp/EmaB65cINbSWmzOTLejsoanPLqrV6gfiQKrEw4H7Jeviz1F9rKdELG7Z
 7D+e9UDXyITnjiGZSGZbP2CisFkPMTE1+9U6RRHxhc4xdj/uyl3lihXsZSmbmD+QesgyNlhNMpV
 0bNmf8qE
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a07c66 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=BPUVXzEUzielt3HhGKsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface. Audio infoframe is handled separately.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 00d6417c177b430cb1a81118800588b90c692018..a9b2757d7a2cda1064cbc564cdded429056dde0a 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1269,6 +1269,7 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 	adv7511->bridge.vendor = "Analog";
 	adv7511->bridge.product = adv7511->info->name;
+	adv7511->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
 
 #ifdef CONFIG_DRM_I2C_ADV7511_AUDIO
 	adv7511->bridge.ops |= DRM_BRIDGE_OP_HDMI_AUDIO;

-- 
2.47.2


