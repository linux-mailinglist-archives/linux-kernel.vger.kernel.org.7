Return-Path: <linux-kernel+bounces-749437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F4B14E67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55F81894672
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469FC29D0D;
	Tue, 29 Jul 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSxBakmP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73C79C0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795846; cv=none; b=Spoaqsz05HRIN33PFFKLiyXH6lKTeDdEBy8mi0he/wlga4Yg9yJVkp6khxV/H6qwN1l5G596GXClVXg35EQbzSkT99a9/A7KiDUBfmNxxOrGktxERxkGGSj68zVIidlityxbKPHrzpH434wogwUkkodJivf0G5uznVP4yRQActk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795846; c=relaxed/simple;
	bh=VT0BBySfU+tF++/5RtcHSfwTueRpJY9UlmQzxDI6Xhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C+Hp/CllhSTayjOIH2/xEj7kE9YTrB63QdQiYk9PvB8biUnceREAjqGLDAQgKqIppH5D08ewVQ8qdCIhxcPqBSGeWvekwbtD6bFYoY3mJUvqPysdmcv5lpgYwNBCwYgdd5JJ/YbZECurZkPwPjt2d+JEOyYdlGc5s9DNCZAM+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CSxBakmP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9lCFW032102
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Pwd1Uen4tLsiNQA5gsPz+U
	2GfwJQb2ufYXc1ajWUN9E=; b=CSxBakmP/PTlEy/xsnBBFGXuhnKoget3Rj3OZC
	g57G2P4woMrQGZNTalO1OEJ5hrlnQJi8BvRbFhSXJql1rBoC4/rTgX054SFlmsID
	UV92el4Wv8tTZQ0xRODmpkqN2PoaLO93MDx7PqU+vKYN+KorwzbBZALK2kTqRyy9
	mV4Az8xMzcZB6Dmd8Pr23Q4i7hHUXcRYJhj3nxaru3//6RCad/ElH85ucw4Vo13o
	PPtiyfVepcyLN8I1zbhTmdFM4fZskehHRPinWpeAvsXUVUrlSbVD0A6pT48weWnY
	dgNUIrPZ/6wnfoGzWjsoRdWZMdqlH1qjS/vY5fy79945qBXw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1ag6gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:30:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2400b28296fso33765645ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753795842; x=1754400642;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pwd1Uen4tLsiNQA5gsPz+U2GfwJQb2ufYXc1ajWUN9E=;
        b=fiP3knIXnCoD2ajQrFkgdiVQhTbKvY/yuXHKglZkT1WUJhPmKXZfvnam3rPCp2xVT+
         /G77D7l3FX7n0+oOdhEmkDWzX/cNXLvf+UxyP41nMldoYJ3iYcQDJfMncFClsKMMjBbh
         O0pudOpbIkMtjoI+UrwCGhE1ZBnO75szex7++WaOyI1h8cKio4zgkcmjyXjuqVF6eDAK
         M4ep5gz6rrJSSIdSAiRWavms+VP0CUECRNTmW0g64QKW8OMUAES4Pl6A40Bnq13OOl8K
         /sHlxn7qriBB7gSMqAycLknRf+Q/rlbPDzdwRJAYucPGW1+/VfoFXpGMP9Wtph91xDN8
         zfrg==
X-Forwarded-Encrypted: i=1; AJvYcCXb1fEsG90MdnPCt+tUXb414wupVkosgZzC0Sndt3qk1xA0VeO9YFGflwzeHfQOn3VUCUauZ9e/gCQggJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMu6AKusoBy8sV9tjgWvGZGyVUYX3zaIjVkJ1xfmw+o2n9cPvt
	3ROCHgoEmch5CR3tU6K9fLHJrJHbZYSmBNX/5lqGLQMOUZc/Slx/YV6SkL1D3WHx3zHzv163+ya
	rodl9h+9ZeQ6h7RLFRDqJ4fanZTXQI8c7ktI8aQ/DFwddAF6nl3YCXitwFhf7VE/UYw==
X-Gm-Gg: ASbGncvu1UDIaGhdFusYijTDl6Wquk2LCVIgYYTc3u6Imv+nJ/WeDfyMgCfcDQpliAo
	+g9OQ8c7gfVOG7eXaWRmR8GPLF63ScQQy4yXoOCQ9yPvIQy3TSLWPqNvp0n/gj4sYmlaML5QB0S
	2nnBSaRpTPifjdOS8M077JTXiet9F5WrXHbLBPlsS5aZVyTxBl7RKKrs8PnZruyL0MfizuMz8O1
	bH3SEU7a4UEtHXN7MFofVCcthN26/R6utZ7OiYacDPCFbeSEN09WLoB0pmA9mNKTiVZL/CT4jS1
	/tOnlCCEV4kKu4PFNB1BmOUpNiDgPg7NsJMSRCpSOhwekEiW2rJOdf8kiVPhKwcCGQ==
X-Received: by 2002:a17:903:2345:b0:23c:7c59:c74e with SMTP id d9443c01a7336-23fb2f04695mr216928065ad.0.1753795842545;
        Tue, 29 Jul 2025 06:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5t4Sc97KxWI2Rca2EtO4U71cyx1Ik2icwdj8jBwYXMK+EryFm+s1oMsxCnZGJ7OrOvhGfRw==
X-Received: by 2002:a17:903:2345:b0:23c:7c59:c74e with SMTP id d9443c01a7336-23fb2f04695mr216927395ad.0.1753795841971;
        Tue, 29 Jul 2025 06:30:41 -0700 (PDT)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa39742dsm59750175ad.101.2025.07.29.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:30:40 -0700 (PDT)
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 19:00:30 +0530
Subject: [PATCH] drm/bridge: lt9611uxc: add support for 4K@30 resolution
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-lt9611uxc-4k30-v1-1-cacab6843f9d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPXMiGgC/03MQQqDMBCF4avIrBvJxMaoq96juIiatqHG1IyKI
 N69QbvoZuAfeN8GZII1BFWyQTCLJeuHGHhJoH3p4WmY7WKD4EJyJUrWT2WOOK8tu74zznJUsmk
 KzaXiEEefYB52PcB7fXYw4xzd6XyCM0T6cKvkp8o/1fnOEFuQIcs1Zg0WWArV3TxROs66b71za
 TxQ7/sX0sibZ74AAAA=
X-Change-ID: 20250729-lt9611uxc-4k30-6175bb8a0570
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Nilesh Laad <nilesh.laad@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753795836; l=1113;
 i=nilesh.laad@oss.qualcomm.com; s=20250718; h=from:subject:message-id;
 bh=VT0BBySfU+tF++/5RtcHSfwTueRpJY9UlmQzxDI6Xhk=;
 b=77XtZgHLyDzirOWORoiop7g1Z7hh0TR8UHq6nGaG3rseh8Ykyi1JSQj3IuHuFFHhpg4QPm0Wu
 ThT6olOUbIYBDsClU/e29rcYn9wL9MTr6tu79dyd+n2/5FpTR9lzcW+
X-Developer-Key: i=nilesh.laad@oss.qualcomm.com; a=ed25519;
 pk=MjLHvGipC16awutyYh0FnLpT1nPxL/Cs1dCevHMrrD4=
X-Proofpoint-ORIG-GUID: t6DQC7v9EN0ZTS2gjbkuzvwB175oYOee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwMyBTYWx0ZWRfX4Rzzy4hoCE68
 OFvTY2O0zWEs8tnotektQbOIhLFvH+GNnhNDpMSAvLKu4RmCUYMk92lOVcwKTKGxc3ow37Omta1
 6I46XAr1DuEYc6LDsOGn4IzQuumiJDMWxF55kGceOZ5TCec1XEdqiOjwVz+ScmZ6kldZK5LUtHm
 USh1fT6kg3ks7/px2cKqRw0UPWRg2dAkJkW42X85OYdQJ1MzmtbyjDvOVzPDAbGcgQlTQXYhv5u
 VsmAlMECKgcvaEWMIzIIzfHSHqWs0rdc4zey4sXjZkmWa5j/t2zJtfrcJZXVK5AfAexGymDpxvK
 U4YLIQrF3suZ/xw2SvEjbEqoS8RXVmlwg0xWOzX9yj4IQby0Vcc6enCfK0xP2i+Q0HRwYTX/fNW
 B2/6BdbKBbZJkqI9uGyCYPIv3wqC9+E5upxuEa6IO6wjjIC8noUpaYa/MbxRR54Gn/p4w3h4
X-Proofpoint-GUID: t6DQC7v9EN0ZTS2gjbkuzvwB175oYOee
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6888cd03 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=J5JMw0DlW5QzuASz7ggA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=903 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290103

Add 3840x2160@30 mode in lt9611uxc modes to add support for
4K@30 resolution.

Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index cfe389b4c25c..ac53da6c9711 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -100,6 +100,7 @@ struct lt9611uxc_mode {
  * Enumerate them here to check whether the mode is supported.
  */
 static struct lt9611uxc_mode lt9611uxc_modes[] = {
+	{ 3840, 4400, 2160, 2250, 30 },
 	{ 1920, 2200, 1080, 1125, 60 },
 	{ 1920, 2200, 1080, 1125, 30 },
 	{ 1920, 2640, 1080, 1125, 25 },

---
base-commit: 9744cbe3603db5dbd6e63da9c3bed8df68a6d3ba
change-id: 20250729-lt9611uxc-4k30-6175bb8a0570
prerequisite-message-id: 20250725-lt9611uxc-modes-v1-1-6a13b181927d@oss.qualcomm.com
prerequisite-patch-id: 6c7107d0c8810b85d722fd32e45f736fff81860b

Best regards,
--  
Nilesh Laad <nilesh.laad@oss.qualcomm.com>


