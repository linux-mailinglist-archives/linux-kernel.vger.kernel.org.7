Return-Path: <linux-kernel+bounces-754403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5846CB193EB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B1B172D7E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04312309B3;
	Sun,  3 Aug 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQCEe4UB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70F1B043F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222048; cv=none; b=CwG6MBlJ+alXpFRiR2B1qDYYE8dKkvHZ32vPkgP8ioDb82IeGTxgXL8ttthjbbNZDpSnjagAOs7V6uSxEzSXaaRqSabkbokNanZ3BCsDgydmSdqrncBM9RXbyI58lRNLpnAhyjSWglD1ragjAChexZFrjdgOx8kHNOhwk/GuM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222048; c=relaxed/simple;
	bh=8QWEbzhz2HbUL5CsjbPmWgU/3XJPnqot8B2ZA16nFWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UgUJVx/JcQSyaJwyShUcwZJT9hnzzOEfU/VgId1H0kgmcBLUjbVJOEKIFnFnwD0VnTMOmWchOHVPL6ThhZrJ9Lz8Lg6WbmT1Le052c2xJ7AHlVsnsnCuHbWkCEwvvKdZ/1uIRjkCmmhmELsTXP6SZTBq+A2X+MAqLEL/JV0JpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iQCEe4UB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5735SwRR013988
	for <linux-kernel@vger.kernel.org>; Sun, 3 Aug 2025 11:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=13kqIIhvX8G/h4Zyb4Bf0S
	syUcZjDX5f8XV6NFySlbc=; b=iQCEe4UBn+zhy5xKBcGEWlR2jONw9So3CdetpX
	BpfErIOkkwKR3hQkvFA+8niFS1/e73tzuV9Vv5XKDWEnXeM12hoo7HG9ME02InX+
	nrmvch2r0vlubkl96JzBpFqC5ACIvESypeZVz0nNhvjLQp/OQxqKNbFX9/vfWGSH
	vGzTsYCGY3yUN8mg2ZUSQIlIeFCZJkG7yFlYKCHv8UrOgixZah5tM0awNZL4CHzJ
	Hi6h3RlmCX52GZYMlEwaS2CGLcgMjWsb5lRLeR+lmcjWNg68J3xXZbjFZWdfJT/e
	CLr2V27/e1xHmODW/9iIWMjIKcHRfTywKdVxCRasguey/7iQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek2613-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 11:53:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4aedcff08fdso54258391cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222038; x=1754826838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13kqIIhvX8G/h4Zyb4Bf0SsyUcZjDX5f8XV6NFySlbc=;
        b=dI1Ml1frA5es3Fdds62CzhfX08m0NWa+Yyzoyk7GO+U+wuxkeCfD35UzQcVzzvaMUD
         KH4D4S/Z7wggjSgrXFElsxqIrXK8VZyOD/9AAg57hmR/WGZI1kvVZ8JDjiO3La1rnfBP
         ouFUhHa5EPUtE5UeMKSQGA4K/wc/Esw9+u8bV44P56Up2sAVcfNlTUPAz3Wbt37qBZ3X
         7sBlp6s5ejmpwNRI4pNCBzNV1Ld4IV8p2zFnT5q8c1Bfe+aOQTOVcWEtBXWSODVrC7C4
         tYvM2H2hmQXmzDezVg4XrNkBe7+as1YLswh2dhMPqQAD8LfbhokeU4RByDa1ove6CrIN
         CTJw==
X-Forwarded-Encrypted: i=1; AJvYcCUCu/TZkmQSRjkuncF9AlTem0PbCTWDP2VMVkp/SJoB4SRFS7m9Dp59KFyuxFiMgRM0dFzYopXYLxmOnrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gKxi7oZBNYb283d6jHdYKZ5teMruAIU84zIlacFVY8Bz4OUC
	DI9WzlyANp2NiCizFa8lZXtFK54hCBdTH+DkL5M5xGw0zxK58MSZKcBnd2yiU66xR4oc/D6PXq8
	k0ruAZ33lZeMdN5M00gQC7OawiujDBtAIRcSlz7wZ9AHnnK8vQSfuEVZjN8ytD0u+al0=
X-Gm-Gg: ASbGnctf5JZUfuGTtWj3nk9rh+nvlADiQpbYVj52uSEpb9ljt63jFsZ5tceHrJthFRI
	UQ4Y6w7hijBPhD4J4F1v3P7aDfIy3Pq2RQfaOY0XwJvG32vpBneRdGgB6k50XidFtlcWVnnlMOi
	IeZOH+Vq0Wbl4ZTBETE+5TXftcOvMcWOuAKT8uxAcSm73ShsBsr3TE8aLo0DNLckAvhc9rdHQuX
	8puHjdqy9wugOBSSQ73Q/cb5gFyQ/rMjVEri0XCv2QEmqb/l9CDVy+Kbc0veR2+/y3br6zZM2Tp
	X8X5fDfL1wb1U8DIeYMqWC0Yi1TzhyU/R3gjPBH4Vrf+XmRT58qfSD59O4wYPD1+R3DwtWQzEfk
	Myd9hGtuo60ztv9jY5BUQrrQkyAwjF3DgDshT9bFejsRckH4NuFIa
X-Received: by 2002:ac8:7c50:0:b0:4ab:63f7:9a80 with SMTP id d75a77b69052e-4af1098c10cmr109506151cf.13.1754222038475;
        Sun, 03 Aug 2025 04:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6F1gC3i9qNqPGQ2+U8UnWuUnVr8S0dL9Kp9yI/T0GmDv1re8BD8ymDZkfYLJgECcFcEOVzg==
X-Received: by 2002:ac8:7c50:0:b0:4ab:63f7:9a80 with SMTP id d75a77b69052e-4af1098c10cmr109505841cf.13.1754222037990;
        Sun, 03 Aug 2025 04:53:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a6f74sm13281731fa.20.2025.08.03.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 04:53:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND 0/2] drm/bridge: lontium-lt9611uxc: switch to
 DRM_BRIDGE_OP_HDMI_AUDIO
Date: Sun, 03 Aug 2025 14:53:50 +0300
Message-Id: <20250803-lt9611uxc-hdmi-v1-0-cb9ce1793acf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=970;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8QWEbzhz2HbUL5CsjbPmWgU/3XJPnqot8B2ZA16nFWs=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0a/76XO+afzL5QKXQqM/OCzeVVFxIPW+vrJ85d3iq3S2
 mJucD20k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT2e/PwTDZzds4TCJ3dd13
 K9typZKPcnseh78q7kk6VPCsvHrdXva/obn74nxnev78YTf/W9lKiT7Z061Olr38F3aqXL098ep
 pZcXG5eau1/hnKbfeyjl9dIlqhfsHjisb7SvunUiT7pSwm3e7b4afq/J88xIu2+Aeqy9hscq/Kh
 7JX2LNrvM7wf7rYP5pWX6HM3tdNaclzvMIa9S6brW/+Nu73a9+83ewOyybL1ywbbVSiKq24sk2m
 Y9VXCsP5ptdvmrka7avfYLBe+9HRxZOqeQ+umZ228ME37N6ApLPWtL/KPEpb0pvVug+7nae3fJP
 e5O6RbHJtFSzH5GqLmuzovrMw2bVFT6wunHexnRnlqceAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=688f4dd7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=viR3P9R_XIStfHs_oGYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA4MCBTYWx0ZWRfX/q1kl6iULDLa
 p9FcdSkdGjDsWf4Hzq/CsmofutXrrGNXDHGeq3GIO8Cswelncj/57LU3xyYg2pDNN56HzmB68TL
 230500bz6x5EGkW/ivioRIRMO+zhg6UazShs0LvC73T9j0bRmB+nS178A4zVB8oXZtszwVrjCM8
 aFIGo9iQ7E/9op2/axpzA4IdyRqTCQHUX4NuSNgT631CTD/S90h0ODQrpcPmyXSBzhBfkHsu4V7
 wGusQHsp7HJLtQyIhnqdIx6/leAJqKPvHPBbrcfdiGEzI76Jxvt87JkoDuM4PMK1w7wYro5bYn2
 r0+D1/2Rjl9n0tBB2hGiKn/v8rw7Y5f91Lcp8FZfY5A46udB3NU+NZc9hUNHyWdYJR4+wqwl9Wh
 ROBGyLCGgDKBO5i1gV9SvFPbu1JHwN7u90xOp+STFrI0D095bMjdleS9jqJNIjI48gxAMIk5
X-Proofpoint-ORIG-GUID: uUjewoBiavXzbxiHBGfsvkI7gg07qIUW
X-Proofpoint-GUID: uUjewoBiavXzbxiHBGfsvkI7gg07qIUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508030080

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


