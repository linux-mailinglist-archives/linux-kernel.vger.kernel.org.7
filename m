Return-Path: <linux-kernel+bounces-723675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7518AFE9D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7038B642CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E683A22F01;
	Wed,  9 Jul 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nvrEl5s7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05019944F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066910; cv=none; b=CmnjaJKE0wJm+KwiKhci41UzTvU/eaGHRWwRW4xjMEq4lK5Xd2F3i7Fa5/UWQEh7+mg/yC5J2MZf8MRs+CyJAjhuMFQ0rFqsBiGVwLBC9MCRifCP8OoYuTUcOM0Qu2S2ygmMwf7hwFrCGUljFu4V+qgy4b5TJz4kss8LFfqpHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066910; c=relaxed/simple;
	bh=qF5/J/fKeoC6YmWBNQFQm1tBXQuS+Li1RwOwwDSZj0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F1UfxsLJnS9zDLULZD8J68iyFn54m2X14OTgp+8ESMW0N7uTejYzkVjG+oJG4SL5UBIrgnYDhewpYCTNODsikRIGMnVcLkxIgNWMjCTgHzEoXoUvCHl/vM08v1mtLIx493Q9NROxBmax1MaOV4qDb6ut7ayccUhBhaeRNAO2V7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nvrEl5s7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so918811666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752066905; x=1752671705; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GGKxqD4X4hA6oFFeMi+EohfBOVWp9WodiRasOeHtbtI=;
        b=nvrEl5s7k4T7CeYHMNhe1IWmUAkfMTC8brJtejbXBO1VWIwyQWIorvOFFU7XrvA91n
         O3uTKrKxnIBGKyv5jnSW6L0KctG/Fgn7NEhExS2WAGIBkleCd8iBZgrMRnBlnOsCWPj5
         V6LLYjrtEVeVNyymR722269MwdBHyejlyTnL3bKwYZxXfIraOTORBsKY7S9VOJ2fAlUt
         7hmqJmzkvgv1R0uwslTvrNVW5aA/A/zUW7i4r2Q2KE96KtTpQBFcGCuBLJdk/16v4mu3
         LV7bDcmVgJeUwpLFTSUhd/YKWIUMO1Z9g3eitzZez+AbLOGdStiVUquacJQbqYmB5VU1
         dkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066905; x=1752671705;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGKxqD4X4hA6oFFeMi+EohfBOVWp9WodiRasOeHtbtI=;
        b=Du7C+jXADgXYkqUFkmapc89A4iDyt1KCGW4UDQOTLLm7w240BJuM7LO0UVsr7Tx/bQ
         GWJe7DsCr0EXMMr7gMjhwQjzWpCuQUsOgNqXEWO4db0Jwvcy4cmDpRneC4cGMOwHFPR+
         hVuVpEwV8BB7ojpdXUDPkipRqciXRPWzw4w5hElq9kxrkVVnJSAzqAABodCrFcm1J/7c
         puOEIRUrDknC7Vr4jilUh8dmMlfyhEkvUYghCvC5AeQ0mIwL9h/NNBOX4jD4EtEB0ERr
         TIv+R/BlTP8PS3XYN6hpggWq6H8etvjgWKmp0x7/mTmmkgANp9kWsaEtAL7slL+q8XIa
         KTFg==
X-Forwarded-Encrypted: i=1; AJvYcCV8oI0JdmdcfmgHkaUNJHYQJ0yA8trm7KuhX4ZLr8Z7pUPOQ1Av1x/rFjU7T9B5Lb+nlkL/H/M9QBASZ3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOblU6SquVU7+dwQ7ZlDtjqypM1fojWEyynx4/XjQMabIKOQP
	Kx3wHa57RJ0/L4t951zpPJOk0npouJIsu2VD0aAqa7CS1cBjvJaPA5TWMUfp8BSXWcQ=
X-Gm-Gg: ASbGncs2+b9n32w2Ap0nbOExYGr5+8u0yVLpRKS9GO+u9A9nNtz98JWF00QI5iz/9BE
	QvHFjbffH7ydSHxW/dNZ0VRm+0gyWDguPqjtEFTz4jpjlLB8AA1oOQTGxDyt3oWpwHDBPFWeg2h
	nEB6mF5+grlfhlSnGOFdkptxfTsfrux4PLKkwSBUtV35/nZOGU/xZJYbnY7ebrm1MBqIc/ryRe7
	sF9kl5hWs5Ait5B2d59zChibUSABixwmljxZgIaahAAgwFVj+P0CakanXiyYaviyWDy/7EzYBI1
	6EzjnbEFUDeh6E5d6I/1biw88V90kuCVOugUOPTs9PTTGaRSqa5ORrG2PHfsyT+TATs3Ew2i5r9
	57hNjJIR3qwRNkRis1FpUa4Wj5vYTr6S2VMuLE84XKOQ=
X-Google-Smtp-Source: AGHT+IE6E+JE7jXQBIIII1XxP3gfg7mqCW7aGQ/21aJ9MNh+dRqRpBS4qQwaX/36uvNFjS4QbYI0Nw==
X-Received: by 2002:a17:907:a0d4:b0:ae0:a245:2fef with SMTP id a640c23a62f3a-ae6cf5c2c0bmr268677766b.20.1752066905085;
        Wed, 09 Jul 2025 06:15:05 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d91ffsm1105542766b.14.2025.07.09.06.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:15:04 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/2] Add interconnect driver for Milos
Date: Wed, 09 Jul 2025 15:14:48 +0200
Message-Id: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEhrbmgC/12Qy27DIBBFf8ViXaoBDBiv+h9VFzwmNUptEnDdV
 FH+vcRJlDTLO9K5OneOpGCOWEjfHEnGJZaYphrES0P8YKdPpDHUTDhwCYoDLaNWQtLoPcXWSAR
 UioEhFdhl3MTDWvb+UfMQy5zy79q9sPP1ViMfaxZGgXauNRygZcrB28bGvBvShK8+jeRctfA7r
 qH7h/OKI5NdcDY4bvwzfrqoZdx/13nzxe++rm+et/mv5LeFamVMEKILXui+Cjy+5AYxQTP+pLx
 dVSAIp7lWVpvuSjhbkFaNMc59M+FhptcNooqd/gDc24+ufwEAAA==
X-Change-ID: 20250620-sm7635-icc-e495e0e66109
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752066904; l=4168;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=qF5/J/fKeoC6YmWBNQFQm1tBXQuS+Li1RwOwwDSZj0A=;
 b=a2rdDMuj/zWtBX9Ig4xAZju41zNuBNaJxhYqCmZ3hGaBpcVMQ0dsF37faFlwLK65iyNEs8MzY
 b1cnEDIWMLyBnKDPQIahww6PB9wzKc27Rod0x8ShVj442EabPPVP5XU
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add documentation and driver for the interconnect on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Add "SoC" to dt-bindings title
- Add QoS settings
- Remove empty bcm arrays
- Update spacing around compatible entries
- Link to v2: https://lore.kernel.org/r/20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com

Changes in v2:
- Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
- Fix double colon in dt-bindings
- Specify b4 dependency on gcc patches for dt-bindings example
- Switch to using dynamic ICC IDs
- Have .compatible+.data lines be one line
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com

---
Luca Weiss (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm Milos SoC
      interconnect: qcom: Add Milos interconnect provider driver

 .../bindings/interconnect/qcom,milos-rpmh.yaml     |  136 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/milos.c                  | 1837 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,milos-rpmh.h |  141 ++
 5 files changed, 2125 insertions(+)
---
base-commit: b803ad80123e6efccfeeffa7cd37f98f642e37f4
change-id: 20250620-sm7635-icc-e495e0e66109
prerequisite-change-id: 20250620-sm7635-clocks-7699d338dc37:v2
prerequisite-patch-id: 30b56c4075513c2b4a44b32a07f270b5cb08d098
prerequisite-patch-id: 37be728e2df777fedd469f7da865e5a256a54b06
prerequisite-patch-id: 32cc06fb5708d126263bc3ac132126e530f72d4a
prerequisite-patch-id: d200c8de06976d3cfa9f1db896301019ab8a68d9
prerequisite-patch-id: f13af5b3633a7969c35f3c1497c3968ff438aa7b
prerequisite-patch-id: 70cc297fa29e022d4ffa74b0aad59f1ed1671e09
prerequisite-patch-id: fb0950b5ebf9ebdbb4381762362f131544252bc7
prerequisite-patch-id: c6593a406bcb7d9cb35bfa54b6fd8fbcaa58ae99
prerequisite-patch-id: 6b126e92f96a5f2152d8ca296489aaf712bbaa17
prerequisite-patch-id: 728eae32feac9247a5a822343f777ca678cd666c
prerequisite-patch-id: 1c49368327e67c86e9e3523213c2d3f8469c226c
prerequisite-change-id: 20250613-rework-icc-0d3b7276a798:v2
prerequisite-patch-id: cfef14406349a8de35f9a9f52a94c27b9760c98d
prerequisite-patch-id: 2a0f6625a75fc2672c5b5b8838daf4c1b84dae06
prerequisite-patch-id: c43395b7274c6c4866e293378c2784e1ede5796b
prerequisite-patch-id: dc669619c955d963b478e6c5bf691b09a9e87e5c
prerequisite-patch-id: ec455ecaae1134984fab4ee9b0ced416c8388733
prerequisite-patch-id: b610e2d9aab84dd752188235293267130a540363
prerequisite-patch-id: de89fdb08c0e9794ea1c758bb8429cd8648d16e9
prerequisite-patch-id: 50c1ce836eff66d606cb886a6e16ad09aa0c4d07
prerequisite-patch-id: 893d74d96ade5999f853b37b46dbf45c2b602c61
prerequisite-patch-id: 1af362b4eb70298089b1f407119831ed47d0e53a
prerequisite-patch-id: 99fc9ac3f20c10960aeaf8f95fbab2299fc1299c
prerequisite-patch-id: 719eac9c833b38f49f788d1f347f580523464ba5
prerequisite-patch-id: e5897f2ff8c6a908cbf4424fe34782cdfd8e78f7
prerequisite-patch-id: da0770cbea0b965c9cc1593f4f70316c1f06db74
prerequisite-patch-id: 9850436dafbeb49b4046094c7cff430f8b156d18
prerequisite-patch-id: 99f36df03d920c8e0735c6ff49b6ce24c64e1c4e
prerequisite-patch-id: 0e282a1707f7d4daa0f997f0e908248797a085a0
prerequisite-patch-id: a2c334a79e965882258455a9d0eaa90412ed66d4
prerequisite-patch-id: d4ff7d798a7cf3260a91672dbabaca06e663651c
prerequisite-patch-id: b9065de90a016b2cf7edb31a3bd1fe222344d406
prerequisite-patch-id: 5e809c2603fb204d11a2bda4126df60ccbf46206
prerequisite-patch-id: a5f457c883c17a5ea0f7226b4eeabc1354c965b7
prerequisite-patch-id: fe9cbf613cf61082c75dfb358d0e362680849f17
prerequisite-patch-id: 022a649bf46677564390068752121c6acf91cd74
prerequisite-patch-id: 259e32af18576dbe8cff7f20633437a80f9a50f5
prerequisite-patch-id: 76e0ce648c22ecd9e5a96d8c5c7b49d74c96fdb9
prerequisite-patch-id: d39b4a58681c5e5699ba045d3a889d843d768262
prerequisite-patch-id: 8e648304c8a8b21db26f1ae991abeb52a11d6ee8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


