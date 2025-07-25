Return-Path: <linux-kernel+bounces-745421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE6B119B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C58565180
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910DA2BE7DF;
	Fri, 25 Jul 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dY/CE9Xv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE6192D97
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431530; cv=none; b=HGN4vzFg1vSnOw7taAFf/24+AFz8C2Qob7fTa4TGzwch0kDCwt25n5CtTFKsfv96tYNw4t8EnxdQpVxhuQ5sC5w2kHyKbW0yZ7IikL9cJlOr7hZmTVVQYjfeuwU3PWsiO83Hsg2dk4B9rRwZ7cSVtHwhph1EuoU/I4EoqNgQqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431530; c=relaxed/simple;
	bh=zyhJxPfXpMmi2COtUu9ttkMzXYAuqP7gbFB20nI0k3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HGnDbxH7LT4NK3My5MSdmtzusB0pqi1Jmp7J//ZcMPn9KweA9VSOUs2f/wUG6By9Amn+uD2m2w7lO1A6GxTQt+A5ChM3lcUY1YiTvyS8izpZ3hi3lrhAXzxGqq+UbreZJH5f2XJIBJgJTW0tupxj9QAkGp9WN6n8Y/jOoPA7ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dY/CE9Xv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmQ7K009241
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rOii7MGkkRxuEthlnIkJ3V
	qYWoMw7XRGP6le2MbMdvc=; b=dY/CE9XvZpju1XNLwjq/9bF+oyIIUzXfTgC9u2
	e7GAV2x0pQZq4TL3uUBp6Nhmr3Gi8LY1FqGrHmRr62x+RE3N5i/3y9ldVI7msJTJ
	NxeKMZn7bBxXBnH8qW4/2qFsvPFRfhlaf2lVlPStXGL5usKSYUnv+sg6SPJU3sz+
	cP0BQicWgJWCe25sGidIgkt7j31RapmVLa8jaisBjh9oAW3RLCqb3zQyabMgxuud
	CIZqXGynAwMDqIxBTbuKD1qdopGK2IxKQWksdxT9qOLDYHH+JwS7PvUGyAbLnINS
	TXqJEu/g5sEq2ts6bAgnuwsk/5VYFpjPe1v8HiLLK0kTAR6A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2t1bn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:18:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-754f57d3259so2920208b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431527; x=1754036327;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOii7MGkkRxuEthlnIkJ3VqYWoMw7XRGP6le2MbMdvc=;
        b=Jt9AVW9c6v2KfOF28hzp9Ys3i4ROHp0mIQtGVWaeMem7kOeftQexsBvzSLGF3ysz0A
         vRWkMZUXtQ2X0zDTUhWQ6stR30ve4lX9Dh3O2z50yhdJmoiEhDNSEAO2GB0sbSiC/ElP
         Wkgy+v2f6WXRQP/rrliseVPMukrFT1fe5MzjctVCFNS2bUX01wqV14+t72VZYOVc+Kb4
         m2AVSaKZABan1XKRylDEGuvVJKk29QHbX2Raxat5Ys34Jn1ifecOvv86ppchhC6AZVrq
         2ZIpl6YHYNi0JXIVPqxnK69OVBnLf9I9OVepN7L9FIIZfFcPzTrV2+qNI+IfSFblqKAe
         pbJg==
X-Forwarded-Encrypted: i=1; AJvYcCXnMZ0gJfDgypxGINF5okFxTWW20hIGMPHS1ICGYUbedayecd/30TPjujlN6k5+ccswcm82+A4XaKAlu1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDWu7f0c/842ENho5JZaTvfWZUMOPoC9B94nAZ6VTx2iUI9Ji
	yJxIfjZ5PtWkjcxcd+1xS6Hci6SKNSBns/NYhpufk5BalzupmTLdYHx2tNagOfJa8/fbAwFgIZG
	PcGXrG4S0+/wns6h3c/N1EIvucWQbKMVDRAPG9m0Bvu8abImfMUrAxmLDFSaxA8pfUA==
X-Gm-Gg: ASbGncuAm97VgVLczrxmv/jEl8z1WwYejPrFktt3lh3C18+Jw4yIz4Ql75/M3zjNVas
	na7RSVVhRZXaJ8hk6JA16Inhzu1hTJT+XQdP0FFa9qr62ajvPmkrchwrLl0DzZ3rVHJSEmprHHI
	hliFE2741E3UEcEtsUl6uC2NtZhGWxQop87xnSoWIW3ELRB37ryE1OexFLzHlkPzM+s4LXAgKt6
	c+3wZHYZZJLeQRfz+Piz0/n2aFpCu+/wXwgbksuWXOA6iYqf/J9rlBitSDqWBOnVXr+6al6YqOe
	sHTkQj1YfUUf768NrANQIlDFliEXTpoTufTebslmh+BVW9zivEhPqf4HYiR1cpVZxw==
X-Received: by 2002:a05:6a00:bd81:b0:748:de30:d01 with SMTP id d2e1a72fcca58-76332c4b295mr1454106b3a.10.1753431526754;
        Fri, 25 Jul 2025 01:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwq9RW78KPOTGyOg3B3MiT3cL0GSn594TQnnNv61xlterTKWyitgm/YGEoWGVyhP339s9uww==
X-Received: by 2002:a05:6a00:bd81:b0:748:de30:d01 with SMTP id d2e1a72fcca58-76332c4b295mr1454075b3a.10.1753431526247;
        Fri, 25 Jul 2025 01:18:46 -0700 (PDT)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b061b14dsm3322941b3a.117.2025.07.25.01.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:18:45 -0700 (PDT)
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 13:48:38 +0530
Subject: [PATCH] drm/bridge: lt9611uxc: extend mode valid checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-lt9611uxc-modes-v1-1-6a13b181927d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAN49g2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNT3ZwSSzNDw9KKZN3c/JTUYt0UU8ukFJMUE0sTEyMloK6CotS0zAq
 widGxtbUA1qvMJ2EAAAA=
X-Change-ID: 20250725-lt9611uxc-modes-d59bd4d49442
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753431521; l=2557;
 i=nilesh.laad@oss.qualcomm.com; s=20250718; h=from:subject:message-id;
 bh=zyhJxPfXpMmi2COtUu9ttkMzXYAuqP7gbFB20nI0k3o=;
 b=9n09GzXcDXSrR8ET5z6AngkHodMfDku99fU/IXasovqiMd9l7WI3wJs10LWuTOg/ofupW2kMg
 EIvOf0VJEZYDWXhIPuhMyBhOdbSsnKWXUIlRzyiCQ0S5boLKAUWLHht
X-Developer-Key: i=nilesh.laad@oss.qualcomm.com; a=ed25519;
 pk=MjLHvGipC16awutyYh0FnLpT1nPxL/Cs1dCevHMrrD4=
X-Authority-Analysis: v=2.4 cv=BMKzrEQG c=1 sm=1 tr=0 ts=68833de8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=XkeAo-KRTqvWKc-2E_EA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: b7jozU3lLnbnA7u1XsRPGc6jIelRr0Zb
X-Proofpoint-GUID: b7jozU3lLnbnA7u1XsRPGc6jIelRr0Zb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MCBTYWx0ZWRfX7ExrJQ4gdXpe
 LqJzKs2rjOigw+aWLb6WOZIHQeVQE1wrvsvIPasfsab3KppH1zvEK/DG6wRYxRqAKEmCcrugpxJ
 XtsxaZvrMWGhmnYCXTf2JX5GJc2diDlOerwgU/ISZioANOxjst9N0DIEWSOY0gbDLJFmBuhoNfT
 jCH3BTobU8Geqhrb8ao1xWJRNkIn0Vanh0m1YqQ+KlRjImcZwOvuG8ZzlD9i5PQpa6bq20wZrWl
 bgny625QaTsSHMZ+xICDbIGa/cfNFOvIJ8wfl+KBaz5me+ViYmdDw8EFDkb0iZdldVhVc+r73+T
 Gj2CG4N/MjRdzlg084f+a1lYBeC6p2k5B7zSqb54CNSEewiVPg9wRC6JKyDHbUYfEiRYaqtOhzh
 XJgraamtaoY65DqtgalV/TSBrRb66FnwrDg4TP0Or5hs06VKhLyT3S9WkU4qMtFzCcB9uoNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=918 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250070

Currently valid mode checks are only for hdisplay and vdisplay,
add htotal and vtotal to filter only specific modes.

Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 36 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 38fb8776c0f4..cfe389b4c25c 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -89,7 +89,9 @@ static const struct regmap_config lt9611uxc_regmap_config = {
 
 struct lt9611uxc_mode {
 	u16 hdisplay;
+	u16 htotal;
 	u16 vdisplay;
+	u16 vtotal;
 	u8 vrefresh;
 };
 
@@ -98,22 +100,22 @@ struct lt9611uxc_mode {
  * Enumerate them here to check whether the mode is supported.
  */
 static struct lt9611uxc_mode lt9611uxc_modes[] = {
-	{ 1920, 1080, 60 },
-	{ 1920, 1080, 30 },
-	{ 1920, 1080, 25 },
-	{ 1366, 768, 60 },
-	{ 1360, 768, 60 },
-	{ 1280, 1024, 60 },
-	{ 1280, 800, 60 },
-	{ 1280, 720, 60 },
-	{ 1280, 720, 50 },
-	{ 1280, 720, 30 },
-	{ 1152, 864, 60 },
-	{ 1024, 768, 60 },
-	{ 800, 600, 60 },
-	{ 720, 576, 50 },
-	{ 720, 480, 60 },
-	{ 640, 480, 60 },
+	{ 1920, 2200, 1080, 1125, 60 },
+	{ 1920, 2200, 1080, 1125, 30 },
+	{ 1920, 2640, 1080, 1125, 25 },
+	{ 1366, 1792, 768, 798, 60 },
+	{ 1360, 1792, 768, 795, 60 },
+	{ 1280, 1688, 1024, 1066, 60 },
+	{ 1280, 1680, 800, 831, 60 },
+	{ 1280, 1650, 720, 750, 60 },
+	{ 1280, 1980, 720, 750, 50 },
+	{ 1280, 3300, 720, 750, 30 },
+	{ 1152, 1600, 864, 900, 60 },
+	{ 1024, 1344, 768, 806, 60 },
+	{ 800, 1056, 600, 628, 60 },
+	{ 720, 864, 576, 625, 50 },
+	{ 720, 858, 480, 525, 60 },
+	{ 640, 800, 480, 525, 60 },
 };
 
 static struct lt9611uxc *bridge_to_lt9611uxc(struct drm_bridge *bridge)
@@ -237,7 +239,9 @@ static struct lt9611uxc_mode *lt9611uxc_find_mode(const struct drm_display_mode
 
 	for (i = 0; i < ARRAY_SIZE(lt9611uxc_modes); i++) {
 		if (lt9611uxc_modes[i].hdisplay == mode->hdisplay &&
+		    lt9611uxc_modes[i].htotal == mode->htotal &&
 		    lt9611uxc_modes[i].vdisplay == mode->vdisplay &&
+		    lt9611uxc_modes[i].vtotal == mode->vtotal &&
 		    lt9611uxc_modes[i].vrefresh == drm_mode_vrefresh(mode)) {
 			return &lt9611uxc_modes[i];
 		}

---
base-commit: e48123c607a0db8b9ad02f83c8c3d39918dbda06
change-id: 20250725-lt9611uxc-modes-d59bd4d49442

Best regards,
--  
Nilesh Laad <nilesh.laad@oss.qualcomm.com>


