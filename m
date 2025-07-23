Return-Path: <linux-kernel+bounces-743356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACADB0FDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0907E5A0872
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58432749ED;
	Wed, 23 Jul 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPeTGHlP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C232E272E4C;
	Wed, 23 Jul 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313430; cv=none; b=hFK+LgOplzTXCKJAxCP0zuvgt0qqzrmkUPEKFoRngODnW4pfNiB4LKFXPHx3d1Y9Sjh2lYwEVdfZPTguRmq8fmOUjp3fgEslWQN6EqjAzzoNgFp5ye6ldBDdBwlIt7nbPjR4AB8uIrpTW1vuLXbU+caZ0WsLetTobJR1urMv2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313430; c=relaxed/simple;
	bh=qQ36SAzOcOlA/cn8BcnszZ0sGKHIQdHIipMwyDsB2ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCLLy+AiVnbAzEZS1LolY09fAbWrDqnTBA3g9sI8nMSngo4Kt+uvUbmIVPD/H3es4Np2C7bzWv9r4debUDq/LCawxLz67vd5nj1AV2aPYYEbBBuFUvvm5Ad6Xdd3ayWTxpDdbF2/rNUOjMX8kKYQt2bKRLWjK6yPxB87Wu6cDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPeTGHlP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23e210ebd5dso11810905ad.1;
        Wed, 23 Jul 2025 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313428; x=1753918228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b72NISK5krV+0Jl86vAJ9RGRsu+nUqF+WjMxoexuWM4=;
        b=BPeTGHlPZNwd/vlfINcLqwmbrtsRSJQ6ZG+3kA0hAb/CSH5gaS2syMCLzjFN70iGCq
         2N/atH9ZDsex1peswSOep3h7wnT9ciLa6a/fVmKkRdKoLHOlHJdCKEU3m54mgjmmMYdB
         pJZ6IdHcv/mbWbP4vNqq2zujijF2cw8Dl6XjAE7zodLn1+/rxidbZ9e7LotL9jiKncxr
         SfhHUcC5hUzCAHQOo33eyJw9L+WgBqcem4VKiIs8d0OcP3+cE/Nf5Kzn/TuyiO8NJBeH
         Ij9zMLdQu5nm80NzLvNMO6ApUDqnvTWmfmrxN1pKmb0oa8foa0hnJBykLccvboDVxLMp
         Lrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313428; x=1753918228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b72NISK5krV+0Jl86vAJ9RGRsu+nUqF+WjMxoexuWM4=;
        b=r8diwdmdf1kH5926hQttDuqxFEbX1GLux1a+6Or5gkYQubvL/uJaVQBILmQcDpJii7
         jyGfxUnxcf1RIxuI9eLrEM3bKlTSGyE0lawPYZ6ByvVaf+JLOaBXtXy2E21tj5nxmE8m
         WB8o7SXoXuky2k63LynXR/3Y4VHC+FazyBm5msyyXnyIgjFh/Dd1nx+NdLB3cU60u+fG
         iQEE05IXzGKhp4xOEcFWUU5595t+Xd1GsEm35VgCLHy8q04OAkVS6g5w5aXpW18qfTck
         +xlIpHXKmh+aBgjt8a8vvsQyQgt8CSNJzdTIkYNpToTqkfMy+dbJHKOecbTi8h8y67z2
         G6tw==
X-Forwarded-Encrypted: i=1; AJvYcCUzsp7dEvaDfdFbcN/46TU01O8NLncs6BrzERkiFCPCml/1rl5491PwHHUkM4YGe26gU28yaEzzoQ+jd2zW@vger.kernel.org, AJvYcCVuKHmaJ7tq2wyWCSwA8kLKiucZxM0+OVkzymWzUtbB0890Yr8LkYTXLS2XuvORduBJPajJdz4OgTKV@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjN64mmWOf1SSgQOaZ9HGnCGe8YxMQ1p8kKFTTCj7If9ocoQi
	pzUxxGLswJzIfKaKm5NMUs+xglw5M0oa4WM37JWtBN3YlV5wTQIV6go7EWyggHN0
X-Gm-Gg: ASbGncs4MI0rhSKamayyvea3KkWmYBCROscp8upnj/HjFXjSjYLRIGic2rBGb1n4zix
	qov5FpOKH+7oVYQ/cUR4wNEBekpDmFCshtOP6b3vTprOk8BCdtEKjpyyd5SdGfqAL9XLfxoay8g
	4cvGMKS8o3aImmL+V7eQIPumxWRxSmYvLdnLjX+37ZLhZVfCTj5BRtkWkTVxbm/cT/dhQs9OyKS
	m/9WXNaoRHT6vhrGZcnlZGzcwtdxQBpSUn+pT2rQvoVXYzLfx1n7GIIRcBF569V03dAWuIYxRr1
	1WJmtAKHy21DixA4UJ/1vqMXRIIQswTaBzi979X5/PLoQgRO9V1GFkRH2mgWh7ILllMoA449GR1
	ehq/DmOCm/4tH58Bq+sep8/8rC4ne0Z24zK/S2jRNNR/9MBe+4T5IGS3feDKkr7xY4WWkxKzAH4
	o=
X-Google-Smtp-Source: AGHT+IFZkg/b8A39QrIJ5oCFTjMCG7sZ1b5Fg6PtXTUqUo1MSR5HSBvGsKpnVVU8z6juoLnGuhsccA==
X-Received: by 2002:a17:902:e54e:b0:234:1e11:95a3 with SMTP id d9443c01a7336-23f8acb17d2mr137494515ad.13.1753313428099;
        Wed, 23 Jul 2025 16:30:28 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:27 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 05/13] ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
Date: Wed, 23 Jul 2025 16:30:01 -0700
Message-ID: <20250723233013.142337-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Add facebook-bmc-flash-layout-128-data64.dts (with 64MB datastore) to be
used by Meta Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2 per Andrew's suggestion).

 .../facebook-bmc-flash-layout-128-data64.dtsi | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

diff --git a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
new file mode 100644
index 000000000000..efd92232cda2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/*
+	 * u-boot partition: 896KB.
+	 */
+	u-boot@0 {
+		reg = <0x0 0xe0000>;
+		label = "u-boot";
+	};
+
+	/*
+	 * u-boot environment variables: 64KB.
+	 */
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x10000>;
+		label = "env";
+	};
+
+	/*
+	 * image metadata partition (64KB), used by Facebook internal
+	 * tools.
+	 */
+	image-meta@f0000 {
+		reg = <0xf0000 0x10000>;
+		label = "meta";
+	};
+
+	/*
+	 * FIT image: 63 MB.
+	 */
+	fit@100000 {
+		reg = <0x100000 0x3f00000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition (64MB) is used by Facebook BMC platforms as
+	 * persistent data store.
+	 */
+	data0@4000000 {
+		reg = <0x4000000 0x4000000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0@0 {
+		reg = <0x0 0x8000000>;
+		label = "flash0";
+	};
+};
-- 
2.47.3


