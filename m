Return-Path: <linux-kernel+bounces-890419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6ADC4003A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09393A5262
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41AA26A09B;
	Fri,  7 Nov 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFVQbAOa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JQ6zixVc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9086331
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520593; cv=none; b=TFDwDXqDMr1pwpEU4L8c980OI6hjP24qapjCPW5ohTggLzgR+jD7uVB6Dn4oHK6wv5g2RdFq7o+HEeVvU+UEi0jIS8acka5Xv2AVRKPPAp92hg2IpHinr8qOb26fVBjmlms51JBEXjSdObmolZFJntvH40vpYc/Aug7ppCyglKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520593; c=relaxed/simple;
	bh=3o6/h7lfm0wNOd4QIU3s+OjsyRjrNHPqDmP6ixdcEM4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UrdfbmrYPwkiMFZnevjiZEjdzLx5TYnhDXWhzYaU8RDkeDplxr6JwPK2RnOoESvfSqMXQl5lD7IjeGJV68VoKEO8KZlMIKzd4u3EyjR0yJwXqlBWKqOYVXifAlrsZZUQ2DqjF2QTJtnrptKqeLM8MiOTQZ10qQA05XaZOhotV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFVQbAOa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JQ6zixVc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7CTwTm2280821
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 13:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lfUt+Pe8Vkcg5TILyH6ijn
	6N/BCnnj8nV9k1efvvmJc=; b=iFVQbAOaLGnngSi4qCLpu4a1Q4Dk1u1ETE6tO3
	WGjDSDTveSH5bQC64sD+MOji/EzasaBH8JQftSVYnmCrOHGFhmLsBrocf8HUHIPi
	/JD6yS9PPagvjxnnNtqPfCigErUfNxBNw2QZMj9Jak+AG/3InWzyPmo66Me0PI5E
	tpBYXVEtdvmU/XOt8ELqigtw6hLZsoCzFxolqNW/w9+hhB4z4S5C3yBt99rHVNgT
	6y8FgNCoxFYqrUKqTPNuB1YMtfHOR+k2xxiXxUob5W1q9xoo3kY25f2eayx3rmwm
	N8Est9/RvjAJm+T1b9TyAYxj5kfBNiMW28i6raeXbmsvbqhg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9a9shaf0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:03:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-294df925293so9329695ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762520589; x=1763125389; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfUt+Pe8Vkcg5TILyH6ijn6N/BCnnj8nV9k1efvvmJc=;
        b=JQ6zixVc/kb3UNf5Mc/e0ams3wWqC+SZRaNNF7iepgchqrAUw7fq73/VnebfnutHGA
         hwUuvzAvn1DsBsq+zszR3ut+suni1rqi8uAvyl3YXbbHdMrHAwuFirsgB8eU96gXwIAg
         lhrnUB2cOVONJe0gp4w1ERuUDe54iXtUIDuDkieNn5NNefmGIcxwsw/j/oHdSNI7td3U
         x6S3vP6gdmS+hVKlFW5DXNCVRdM4rosFlNqP+6Se2+PhwjiNBGmHNXsWCsLWo7kygulB
         7dGAfq4pSumrnPGqQvEZfoQOuCv2EUKfGeeAdO1+6XM9O+VqwGJgytoYsfUWONTGroIy
         Y8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520589; x=1763125389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfUt+Pe8Vkcg5TILyH6ijn6N/BCnnj8nV9k1efvvmJc=;
        b=wAT6JgEKsefAy9zAhXaD9JZiBJ0ppiRd7VjuoVuGxLEaxrREYVPFTvTy5AoUEuFV3K
         nypAR1qgieIBOiY1BoPyn4bzGzCacPfnpXZqn3Yz6F4r5Hj7g4r3bBbxVmECCyN9rGQl
         N06Zq7l64SIfbjsCBvfMaAxZN3m+7Af9v5x65MQiqiTNPI8+TE422wQT0f6OnAYU7ywR
         jOTtNECvN72g6sGyNWFTaLGR+jQQmT3zjGnx94R4Ka1y4SWg8+IPSUD5MNDN00FT3avF
         TnICvANjVhJBpCiutLfFK8RTu6fJOz41ESaLms9s7x/VZT1czOk8n9Cu4bmceW78CM9z
         lagA==
X-Forwarded-Encrypted: i=1; AJvYcCWzjTN3iI/NCBxNn1aQMWK1CX4RTgWPMD7HTJSpcS/2Jfyqq+XoTrslN8xU11ct1+RAeefOdBceXIxJgiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SkIgXhGCeFmVmzv7wnfeUc8mFv8TkDDHESu3BjS+eVUk0Y4N
	1N+jvhwEMp5O6oYEcvtBxsB4BoOFbLQiS3k/Tfez0ToPEm/IUUVvdjWCwLK3HgdYE9XlGGRZMrB
	AB8AYn0j3FaTHNwSbaGAMCEjQMpiNA6u9pwO1gSUegurwT4X0ikyTywK27l4NPGNSbw==
X-Gm-Gg: ASbGncspU0ER89rz3dwrt6qLKWmx2v5rw8QGLBImJe/S/G1FI3oMgsI6KjGS2QcmbRX
	krtnpFQUtPgpXrZqkoZmkwKhkrX8hOoUoqNIaGtCZjSjJ56SBSqzJ8qCcoN9734le1bWs9m3RAV
	FwjKc2JeqQfebfggCzpFI/z/k8W4fiSIVFqf+saTZ25aH/Mjai7e4+6m5X8DwzwQnrBPG9014oz
	lCNuncRwysOutrXIPDXvJXkKIRjvz2IPhxxzzBXuUbVuH7NyHQKXhpFj1tFG3RkUQ9Ee5bgO9wT
	jDMqbMHTHGztEZ6a2RlNLdZxxggclHJMruPRMhwPE4wahjbciNo++UzipK9KIDyLgCI7pHtkA0L
	EIq/7s8ylRilJUUMXS8COTUUC
X-Received: by 2002:a17:903:1111:b0:295:4d97:8503 with SMTP id d9443c01a7336-297c0464908mr45728725ad.30.1762520589222;
        Fri, 07 Nov 2025 05:03:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeHnWcEh2L1n7jfwYkgaWNZ9WVU4d8qKMKl6aIl3glpe3CfGHxreyqN5fPQUGfR/kDgnPPIw==
X-Received: by 2002:a17:903:1111:b0:295:4d97:8503 with SMTP id d9443c01a7336-297c0464908mr45727775ad.30.1762520588466;
        Fri, 07 Nov 2025 05:03:08 -0800 (PST)
Received: from hu-nlaad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509680e5sm62477745ad.1.2025.11.07.05.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:03:07 -0800 (PST)
From: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Subject: [PATCH v2 0/2] This series adds LT9211c bridge driver support.
Date: Fri, 07 Nov 2025 18:32:57 +0530
Message-Id: <20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHuDWkC/32NTQ6CMBCFr0Jm7ZBOgSiuvIdhUfojkwDFFhsN4
 e5WDuDmJd/L+9kg2sA2wrXYINjEkf2cQZ4K0IOaHxbZZAYpZCNaEqiMwXFtJZHGPrDJiUZJcro
 nfREV5OISrOP3MXrvMg8cVx8+x0ein/t3LhES1k5W51o4S4JuPsby+VKj9tNUZoFu3/cv2We/6
 rsAAAA=
X-Change-ID: 20250910-add-lt9211c-bridge-5a21fcb1c803
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        Yi Zhang <zhanyi@qti.qualcomm.com>,
        Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762520582; l=1293;
 i=nilesh.laad@oss.qualcomm.com; s=20250718; h=from:subject:message-id;
 bh=3o6/h7lfm0wNOd4QIU3s+OjsyRjrNHPqDmP6ixdcEM4=;
 b=kZHsSBXd6SQsvPCO/QQLrItK5cFUkDdGBuKgmtLJTb7VA4fPrSSp7u/q0iRYBSRuKGG1Oht1l
 Okx3+359Y9ECUA6V/8mERpMXOSGlmOskpfQrpfT9NBOz1SCLgJFYDo6
X-Developer-Key: i=nilesh.laad@oss.qualcomm.com; a=ed25519;
 pk=MjLHvGipC16awutyYh0FnLpT1nPxL/Cs1dCevHMrrD4=
X-Authority-Analysis: v=2.4 cv=CdgFJbrl c=1 sm=1 tr=0 ts=690dee0e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wg4gmtxcXx2xPSsGLWoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEwNiBTYWx0ZWRfX778pOoE4buni
 afdU50P8eFzdimR9Hou4DWSGfJtlwRLcKrFJ0UikQgH+UMrIyDtm+hU/iTRRq+/xw7jHsk9kXUH
 pJ5286kFalNTF0cWumxvVAHwFKyiiAN1s5Iq6aY//21hL7TSbUGkglAVaF6C6h8ugigb5iR22+J
 u7EOXKWULF8k/foNRjzsn6SLGfI2niFII+n2QDciReG6NfEZU1GMjlcHU7Cr8Jxzg6mTEQqw1vo
 hhCbHDy+oySz26mek7swo8C5eWQU4pr3UyPHCY53HV98ogz1N0PIkUZjSmMgBkdezgO+KxhvsMX
 QDr4Yo8KcPhaS9l53eN1IA4Xnkm9LMYqZ1Es90zFi1A6yq+Do7SAGypZIwLTpYJI7thtjpvmcWh
 uoKsfY9v+G3QYTzhjFuqeZfWDIsfrg==
X-Proofpoint-ORIG-GUID: EJkqUi5goyy8qnRoXzumeetbJDKvrduY
X-Proofpoint-GUID: EJkqUi5goyy8qnRoXzumeetbJDKvrduY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070106

LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
This adds support for DSI to LVDS bridge configuration. Exisitng
lt9211 programming sequence is completely different from lt9211c
hence adding as a seperate driver.

Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
---
Changes in v2:
- Combined driver patch from https://lore.kernel.org/lkml/20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com/ 
- Added MODULE_AUTHOR
- Uppercase to lowercase for hex values
- Link to v1: https://lore.kernel.org/r/20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com

---
Yi Zhang (2):
      dt-bindings: bridge: lt9211c: Add bindings
      drm/bridge: add support for lontium lt9211c bridge

 .../bindings/display/bridge/lontium,lt9211c.yaml   |  113 ++
 drivers/gpu/drm/bridge/Kconfig                     |   13 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/lontium-lt9211c.c           | 1106 ++++++++++++++++++++
 4 files changed, 1233 insertions(+)
---
base-commit: f50b969bafafb2810a07f376387350c4c0d72a21
change-id: 20250910-add-lt9211c-bridge-5a21fcb1c803

Best regards,
--  
Nilesh Laad <nilesh.laad@oss.qualcomm.com>


