Return-Path: <linux-kernel+bounces-737048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A17B0A702
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2793B1B01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C1C1FF603;
	Fri, 18 Jul 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VxzhaWjN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1951D6AA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852076; cv=none; b=BDniBu0/QFTgfDgsemokPeLhhTQlOIZLXPSfrOAdTWdWacJa6w3I/C6SOR/dflXe01XA1GpZE3GLZGhGDWKnOhhetu8tunLyWQgg8UhrqGcPGx1oUo2HtYKd8Q6H9lmuikOlYiIxezn3s2PeRKFLznouFQRREFo5FMemn2GmphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852076; c=relaxed/simple;
	bh=8QWEbzhz2HbUL5CsjbPmWgU/3XJPnqot8B2ZA16nFWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ny+jZj4WVgP9pjcNeyghcZ1WA4BOxfrDmdFHQ4Ndubfcb2K18T17nV3je56AL4c7IK+fI346poZPAqnVMv/HrphK4DiNl7ijBUk3LPdN+tevMEzkIZ2PvumgExKLDPqCKvw+tDSi7CNo+M4b7Qaz+NSbnFJ0SpV8xHENjbrKcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VxzhaWjN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I75KAo015664
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=13kqIIhvX8G/h4Zyb4Bf0S
	syUcZjDX5f8XV6NFySlbc=; b=VxzhaWjNb02Cs8EjdF4CxETxfROq7KxpJOKDej
	O6tpWw34I4DPlGeSwh4Qd1BIo9mDYr1T7gJRVU5YgWJ4kmPPioSGGcjIwDuzpu+I
	1e96n6+vXNBe8nSenamcEpnvcxsicaUPjkA49MnC7yU7PZP/bEuOns5LXepDdje7
	TRVsikGQJVp65LX162On9HMCJB4b6OJuCccRsW2hfP3Kl/qr0UZK1ofmZr+c4Fob
	dFJQmjF1qzZ/8AlltQzUMimLiLZeEfDHc+fuF1V7OdNweBDpW3VyMnn96TO87FiG
	Hcb8gLSt5ZxVeKkV6IWyMwNk2Q6Pu+5TsRfE71zFBMm51W5Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyy0nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:21:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e207330a45so332378385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852073; x=1753456873;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13kqIIhvX8G/h4Zyb4Bf0SsyUcZjDX5f8XV6NFySlbc=;
        b=w5iHfrI7P7lQRn2RP7kHv69p9sgN7l5yRRBOOyGkf9m35F5a79iruIWBvDoywE8DRj
         kZKzBcIa4fgV42rQ5p/INGYymTJ/2byfTcPzQOPcZDvaBVUB1Tm4jjG4voDqDmRmagKe
         GJhFNMn/y9cqQo8Bd9YouSbfCTI0/GXCrioz3ixYzfjYJofgX38v/j1a3V2c+F89kRuy
         R1JWSV4KucXyUexqAyOWwhNGyELs5oOLEmK1EqA8wKrUHJEwMkSrDJE4sayozbT7S9mq
         fJNDaKRuLYLpdO6iyeJiWwB4Ux4d1EZsVtg/SE3jjT+RyocO1oTWDNurtovul2ZSZw/a
         5V8A==
X-Forwarded-Encrypted: i=1; AJvYcCWmlBZi0BIvd/1dPMgfa2TZZU080Atqi8WekcDWey7+/5xjBk4P88m62YELJ9/lXKGVbqa0PyAsWIGFBG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVD0ZFq5xX94MCdsiNG70p2oU4AZEoEXgFzwUqWkAnRq/I+Mp
	Cv772BivFikFuaXwVj5MY8/vFa/PYnawVV2CHcR+GIf8HH67WOVSwX69AdzzjfjjyPc09/1wD/R
	f/G08KreHw/A5QrY3v6w+j82HaUSS105O9baauqy63mGNoowRrTylDBt/IB4MVabiKiw=
X-Gm-Gg: ASbGncu/Vr3j7/1wGmPk/3DkwsOYKPITOGhEbIpwm7ubmExc5Da0QNQAFamNhgdwkGZ
	Szi+NwVZ7zS+dglHqxrQAQnEPidd2RaPtPvS78tOkGpLIysJkOBrv3mlIXrqhjs78NbA3AFnDaO
	MLb5AT2roI/+9RZZ5LteFUE3zsKg6OdWFAv7XKWCO7+J8tCQm9jCEO+AtK3pKA0nQSLWOW0A8N2
	CVvolm1tPMWNl8a7wIk/JV5IjOjJjpJWvmN+cbhSH4DQRzFiXbMt49sGculKj6Bsz3eqLjKYKsQ
	OBkFMjGrNKbJCqMGY4bdatNPUEzAvGwzk7u4qpLE6knrEcN/1+9E5JwZB6a0DyyNeXLUSzgQxga
	3/gKEIF+lLtqL9iRiuBxWIybewca0pCMzCH8ZHlg9rSYI0CsB7Csl
X-Received: by 2002:a05:620a:2145:b0:7e3:5550:22af with SMTP id af79cd13be357-7e3555022ffmr475412785a.16.1752852072336;
        Fri, 18 Jul 2025 08:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGih5HUBirffAz2WZL4QKYwy08DDOZqNQMloXSzP16EApN9OS9U886pytxqNhKO8kzqfu4L4Q==
X-Received: by 2002:a05:620a:2145:b0:7e3:5550:22af with SMTP id af79cd13be357-7e3555022ffmr475405285a.16.1752852071615;
        Fri, 18 Jul 2025 08:21:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91f09a9sm2515041fa.94.2025.07.18.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:21:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/bridge: lontium-lt9611uxc: switch to
 DRM_BRIDGE_OP_HDMI_AUDIO
Date: Fri, 18 Jul 2025 18:21:07 +0300
Message-Id: <20250718-lt9611uxc-hdmi-v1-0-0aa8dd26a57a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNmemgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0ML3ZwSSzNDw9KKZN2MlNxMXeOUFEszYwOz5JS0NCWgpoKi1LTMCrC
 B0bG1tQByS41fYAAAAA==
X-Change-ID: 20250718-lt9611uxc-hdmi-3dd96306cdff
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
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=970;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8QWEbzhz2HbUL5CsjbPmWgU/3XJPnqot8B2ZA16nFWs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoemZmrEL2Zztp1/d85i0Oy9Zc2oZaO+hb0CQUZ
 ZBKX+ii2zqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpmZgAKCRCLPIo+Aiko
 1Rd/CACs4rPc7tst3TZYIDDeEoQX9zKw6b34Lk1QY82wtNiwp1z7kv5KTqL+H5iB5gH9P1UDiSS
 nw3HcHcejQ5xrn5NDQRYCAtIh+Yk8v3MYHW1UHNxSPIHyMS8SbNufXY3ThYqJMcFkJ5OF+mVlVe
 3nQcukkkQUAj59qsqfWFJsN70YCDBUQIe9qu1Y9Sx6orOgASt4ws1mGKpBEx0TTwa/F5j8cSk1v
 y1NqCttIgJc/n5GDXUbDDzKXUJxU16RWjIDq+u8NnSu8N2+u1+mtGdsTKxEh89zBNGgpILUZhTR
 ybERI466cwrPMuVeppkJibCtOrWqkLHbQsc6qCw9J4KcJ+gV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: GukHasE2TYaSnfVy1shAAIamklQjzpoz
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=687a666a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=viR3P9R_XIStfHs_oGYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDExOSBTYWx0ZWRfX29RjZqMD2UbT
 G1Y+r1zYTLp0I+U2nvk8WrwEHAQ694MyUtVrbOr3OLrtqPCuUsrpTzIMTAICfAmvJC22HmBdv8W
 oju+w/u+aUOo67p6JwMwScDKFDLrcWjjn/2B8VTDDXOTy40OIPsgKZOmgBQB5zIvPXjjiP8Dcji
 5f5vbu7zydKvQ6fEW/2McDZ8EFX8XqI0kXFMVsM44eeC7bdSTxB76NwNI6+u5MlVDPBVAsnQBns
 6MjlkkfD92FBump6Ejw/rq72h6dxl5proB+qDWunVpAUJxsLFlSi7566i8SX++XNLqpQh0rf/Gh
 FMN/rqBV/QbOD9o6+DhbodGcZHdGBCZ6HUU3LE4/FPuwLkyI2+2wiYpTDupbXifl1I7bufSPLcI
 0FX/0w8LSK8KzwsXegAub7JSVi2VigSmwBHt5T4extAJQ81+D9FJjydEhS7a9emtc83Y0IBg
X-Proofpoint-GUID: GukHasE2TYaSnfVy1shAAIamklQjzpoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180119

Use DRM HDMI audio helpers in order to implement HDMI audio support for
Lontium LT9611UXC bridge.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      drm/bridge: add connector argument to .hpd_notify callback
      drm/bridge: lontium-lt9611uxc: switch to HDMI audio helpers

 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     | 125 ++++++++++---------------
 drivers/gpu/drm/display/drm_bridge_connector.c |   2 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c            |   3 +-
 drivers/gpu/drm/msm/dp/dp_drm.h                |   3 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |   1 +
 include/drm/drm_bridge.h                       |   1 +
 7 files changed, 57 insertions(+), 79 deletions(-)
---
base-commit: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb
change-id: 20250718-lt9611uxc-hdmi-3dd96306cdff

Best regards,
-- 
With best wishes
Dmitry


