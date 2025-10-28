Return-Path: <linux-kernel+bounces-874074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C14C157A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7B45415E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB64340293;
	Tue, 28 Oct 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4vajpdb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3933F8BC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665225; cv=none; b=E3T6pfHxjNETqx5xD2j6/dfkFiMokpslHZ7z9CKHtEwPCgWFF6hC19P9sttNlf+rz3c7BDDqupXKIkLPXb99a77gPIbm7BCnDXl1I+L9YZHCPVoUnDbFUYXqoo0SL77Ur2cjxJ3AeDjdk+h+a+EB9mQbSz+UROuwGfzEluGAX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665225; c=relaxed/simple;
	bh=MCyqHlLWLAE9HlCVFokhUe3kAhu2B1NN6idBdsA21bw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hzKr2W/Q6zrkPFtOd28WCuhQxU8bU7eoimeiltdJXr9M2AlM5PQRBDwZ6OwYTqiE0m2LULyTnqk22lJ214uhu1TddvaqkOeQWik3aYA9SG6xFJpKFcJrX4NgPEBr/PJeRVJCwZDwnoM4lPoCFefYe0kG9Tkc4U0b/jzEFiUysiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4vajpdb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEnddZ1895695
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+Io2duPE2jXMSZ1lsWKrQo
	3etXZ7ayZ7YjOHgmgyHhY=; b=K4vajpdbR7avXycWfIS7WbbNWIEWZ+4KpzdM8V
	pv0I75M7M3VWc5YqzOW0ebdAOhwXfnaUwqOXE8BEmz0tflBhoIHJ7qhU1O5o7QUv
	fLWSz5/aOloo8BalnPdD41zMCtzn43fvBwtfah5C1kYWTWYjnEfWbO+rvwLYpvU6
	h1S6Vb3g7kuRwI/CGqcHZdnHpCv3Bnzn5PrJgyLkGzh5bUFEPAqfP61ys4y8zdlk
	eBK1j+blDYW5dzM321T6L2lX4+/WSPexwdzkb23csCRaIq4bOrGNVHhOIYvIU3aI
	8sN7/bRuVmyFxF59uzmpMzhOr3nfz3ZxHFakBv180OuGhE9Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2q5u9vdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ceba8968dso4451273a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665222; x=1762270022;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Io2duPE2jXMSZ1lsWKrQo3etXZ7ayZ7YjOHgmgyHhY=;
        b=sWw7smI8PjNJ6vzPlE3gml27ezaU1QTgy6X0N0DQOoEOZzcrI75a2Ca8EE0OetYk75
         bdBmCHnoLyoJuDxWWRK0+gMbIjZgKqlLVBBnZtoUFbDX/9LzXxnEKG2RAC06Wg+4MAdQ
         k3/vR04NuwihwGPA5//lDidRptCO4toLwlwYIvsLg+c/UezWyE3vG9lw0lzSjIiZCCT/
         AKGTRNMAvodyQN4yPCGOzJwDjlTYzl6HWzEWgrX6amrFdcdZfT0LS3I1zL2qZVa2uf/z
         DPXkMZtWsQ43vznwQ9qfVmtDp8K+8oOKVIbVPjKmGR9OFTyaog7DEwOo5mHoFChT0CHn
         vMnw==
X-Forwarded-Encrypted: i=1; AJvYcCUE9boszfI21zA24cin1aZ/d+0NKPMICyB5JXPV1Ak2kX3KEdzLlGVp/Yt1HhLVc8p7ys+FaN4mw/Bpjb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9MENAzl5qqk5FBI7W9atlz15PzIfQtAe6s88WH9D/tWy6SFs
	S/Lq1T01j4C7OZlUiPh8sW9Rlkvei6q0jsEnFK7/abc2k4scd7KJYEvBjwWyi6oBMVZlWZU9l4t
	9b7uJVMpQUI8nPAqGQS/OnCOW5/s+raU3XqWI8fq9yUheVDEVz9Vl/LuihDMoE1LZ6tY=
X-Gm-Gg: ASbGncs30Zy2Xj/EVSE1AiLcwvsgmIF+SqvDOlDtl+MSuwY3jZFoQ1p70O3bgZUakuw
	qVDOMP3+W0au+q1fjOY3LG9IK/ve0dQgKIyB7yMAWRz2MRU6uSOBNHvaqLCNryK1hvSMifeA4bh
	Fd+nyxz/Uz7GfslfGzhstAVaRq4TF95tXzrbR7pGhu6o8TGH8gkCZtAiXKuEVJilbtfQDjJN4gD
	ae44CUnaqfoz9mcVia3+ZGJeajAg74k+UeD5xk0Kv8Qb+Bmrd9IRtt1A2KIvdDpHUE/ntKkzQNY
	R3YaX9WJWPzkYIprCKepHo1kVZasNm7TLao1myXx2RmB9XdlnIOzZrSac/X30AaSlNh7kDGrAES
	Bqs2qbOWprGuf07P1zZpVqhqn90SmULEO3TU=
X-Received: by 2002:a17:902:e547:b0:279:a5bb:54e2 with SMTP id d9443c01a7336-294cb3d58dfmr54120965ad.20.1761665221724;
        Tue, 28 Oct 2025 08:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+8FElnofti5XZ5no/U8MitIwH09GYKVHku6MYV+kxz0l4JCe8MU17KZijSuMMWeZEsBYdcQ==
X-Received: by 2002:a17:902:e547:b0:279:a5bb:54e2 with SMTP id d9443c01a7336-294cb3d58dfmr54120295ad.20.1761665221032;
        Tue, 28 Oct 2025 08:27:01 -0700 (PDT)
Received: from hu-vvalluru-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4113fsm119490755ad.90.2025.10.28.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:27:00 -0700 (PDT)
From: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Subject: [PATCH 0/2] Add enable gpio to display connector
Date: Tue, 28 Oct 2025 20:56:48 +0530
Message-Id: <20251028-enable-gpio-dp-connector-v1-0-2babdf1d2289@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjgAGkC/yWNwQrDIBBEfyXsuYJKmpr8SslB191UaDRVWwoh/
 15pbvMG5s0OhXKgAlO3Q6ZPKCHFBurSAT5sXEgE3xi01FcltREUrXuSWLaQhN8EphgJa8pCUU9
 mUIpQGmjzLROH7199n0/O9Hq3h3qW4GyhJljXUKeu55HZazTSarZy9IjGt9Abje5Gkt3AyAPCf
 Bw/T33KQLYAAAA=
X-Change-ID: 20251028-enable-gpio-dp-connector-1e4e8611ec08
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761665215; l=804;
 i=venkata.valluru@oss.qualcomm.com; s=20251028; h=from:subject:message-id;
 bh=MCyqHlLWLAE9HlCVFokhUe3kAhu2B1NN6idBdsA21bw=;
 b=r/QICjDQytKeoRto/5RkP0cCrHOYyY3L+8H6gep+3uEoIfbft1GTKKNgjQF1t6XRoIQUP0GUf
 LBi2lLWMSyfBpz8k8Gyf3q619QrTddHu0P/+NPg+zdNSe1HEH6oFsEI
X-Developer-Key: i=venkata.valluru@oss.qualcomm.com; a=ed25519;
 pk=KEpJdy7/I8HDmNSf6B83x+sFHUNr+mjMNJ2qe4G/zXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEzMCBTYWx0ZWRfX31vgG+2/NnQi
 XhSHzl4xFjpjRrOf8KpSGMSI+EY7WBDs1G3OoCIQL7zL37PD5s7oD3dsrnqhku2olMrumnitEwB
 44BJ/pJ6Env1ua7nm3SCizQBDph7xxDhbRBmqOOvhvLdp/5RoXXF0GuwOxJZor4VBEE5q2eiZmT
 K8XqJb7pQ1guju0K9o2EH1wHS76MsHjgeHAwMo2Jkq4yAkWo6emX6+sSZXBIAX7hjDxsjKdRFhk
 3YquqW1YCaf7vA1WhLyT1gIkFRdWmNZW5wNNHRJC6tnIrLizCgSilfqtgJXdiPzHS5xtRo232wP
 54n+Pt/Cgm1woD7k5b7jKT6/Ycqil3A2G6d9qI+Ofjjr28xIRvxJkRts25MCsgIjMfMsuXhkw7s
 59WbsSKKk0bQsyP7OjaBT2lKMkzNOw==
X-Proofpoint-ORIG-GUID: 55oidNZPOR2mei2Ijb9cJIdKXvSignci
X-Proofpoint-GUID: 55oidNZPOR2mei2Ijb9cJIdKXvSignci
X-Authority-Analysis: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=6900e0c6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gWnBJZiyT_VVvhjgOPEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280130

In some cases, dp-connectors may need to enable gpios to
select or enable the port. For cases like those, we don't have
any gpio devicetree option.
In this patch, add optional enable gpio to handle them in
display-connector, so that it can be used for any connector.

---
Prahlad Valluru (2):
      dt-bindings: dp-connector: describe enable gpio
      drm: bridge: add enable gpio for display-connector

 .../devicetree/bindings/display/connector/dp-connector.yaml        | 4 ++++
 drivers/gpu/drm/bridge/display-connector.c                         | 7 +++++++
 2 files changed, 11 insertions(+)
---
base-commit: 4f9ffd2c80a2fa09dcc8dfa0482cb7e0fb6fcf6c
change-id: 20251028-enable-gpio-dp-connector-1e4e8611ec08

Best regards,
-- 
Prahlad Valluru <venkata.valluru@oss.qualcomm.com>


