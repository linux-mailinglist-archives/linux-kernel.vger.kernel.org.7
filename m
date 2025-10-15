Return-Path: <linux-kernel+bounces-855275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79498BE0B19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43C53B5D75
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097662D2383;
	Wed, 15 Oct 2025 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9qC8cEL"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37D29D279
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561330; cv=none; b=VVf1nTdnAa4AzgQ8g+imUL/dneaY+T/bp1Ra5m6KOfSh5r+obNQqUcBm57AMpGdwFOSpTBgaTcCpLAnqldY+kosBRRMfujvUeMjHSfRrX+XFjkwmlGOV2vhm+3uDrAhnpvxm7gVHWs9cPYxffG+PrSwCRHwMniEqqUaozYjH6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561330; c=relaxed/simple;
	bh=vUIxl7T1aFFY841D6RXR2iY+FLNTTZBIHcabvfZOaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czAhzv+LxIztjkXjonEcKv1V5Q3gOVG4Wa3AhgXZ+BBMyzlDsjVNpcjOpff0MOPH6Ez69YV3IIH9IK2X3FiqDtaQfXqnKwMsg3KrGGG77trXPxLZFGrnnG9Vk8o/xWYXf/KFKGgoA9d+lLl7ACPLhrRVdkFlaS8hD2AVdDWKN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9qC8cEL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so56311a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760561328; x=1761166128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECq6v5kjS4I+m9N3qtX70S6BCp1pZjjE4JAhJFsm0ZM=;
        b=D9qC8cELDPhlVYw3Y7F3s5rpoNnKdmWx2F26H2VbPDXROe+cHmhL/FuwaqlzHFRAsD
         mztOeP84058T75rRNYA4vRBVgOHBItRRqzaUfPo26XWdzx6SVMlrPfagfoHSQnhPVYF1
         R1V06pZyxCfoQXaXKsGEY5TVNwwg5nKCwOSnqAoKsBOrzj/h+IA7A+jv8IhBg3KRxkFu
         xUNLleYeK/0/dnlhpt6+ykqvaYduWneII1Vzk5C6+AFMarbHJMDemqkxVXA1GE7TxQvK
         lAm79ZBLEQ856L2IupQflgBSAZXyeJVhME/InO+LZtOO99inRKQD0+9ndzu29y/U4hre
         s4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561328; x=1761166128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECq6v5kjS4I+m9N3qtX70S6BCp1pZjjE4JAhJFsm0ZM=;
        b=iBQkFkQYw+Gzqs94hJMbl5Qr7ut940kEGDJgoFYP8Ujz/wF5CJ7LdkMARngoEcb8xF
         ajrIMxjb+woZKWVekoAkFd8Vi6clb7rtwN/338r2JVJYuRDhYFd6QSUha47zNH0G8Kol
         5/pvnJ4NYfuqCtgO0if/kHSpGapB90Jr/arTolpL1juJS0al0hAHXLaetIl9BeYdkVW8
         b0KiD3xFrV+YvU8UtkcFvK4OzzOXBtbZR6MXwQTn+TsgrAoYteKhONdTTwbgnkFBwuDM
         H7uE9wK0U9i4DQ6Umdf+I5CqQOQfFKtJ3yPNxUcHuJxNSMk3mOCOuc1M5h0cG8rLmyZ1
         +UXw==
X-Forwarded-Encrypted: i=1; AJvYcCX0QvqslEtYYxpgS/7fqgf7QuE3L9PcR6+yRIY/Se+boS80GUxWRciJioUH3MfjdbPxwdjRA2ee9+kty4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDuxFH9qr175xK6AAd3Q90L5pKZPxB1BrellsCsQQSVA4OTe3
	hVL/JyVRUvteS5YLQ5/PseeeQ2hL+xNUUH3dEdWYgAvWSkUvp7/HGYHK
X-Gm-Gg: ASbGncuZH547CfM/gGAxX17HNKBmMpXZ2IEWmkZtkGDzrJ/hHQiUO8eP859afsmMruV
	j/dI5FaBcbRtyvALLg/MFtbkzMvP9gV7t+MOEnBEP+Jw2iLkWoBvLNsliHJF5rhJVLp8RJz0HrX
	dIIWNUoE1sM8wPM2qir+nmDux5j02BnDm6SUvk1c5hmZ5GvCHGRi+en0rT2JfKv6/Au4q5MsehU
	17/lTnySG6lJweqZgLG2rEsijk9uI15oKQVM+0PbkJL5A9pp6kZqGfINDUgamas7YLrnfRY+iyz
	KpE+VoIIdjbVQyZIoDx2kFkbugvKbC180oSaw4Zn2BbOKghab46lxYFGNh68A6nuruympMPkLQ+
	PtDGzVlYL5sLnWZmJ7u0T4SrEWC4wjAwUoBTu1Xcbd/R69Ak=
X-Google-Smtp-Source: AGHT+IGN+lN9vicyM0JMq1Ocm6RG8YfGzytjeBBr/s+6dWoWkU/VmH7/8zJwDfHCWTW90MulWcmRHw==
X-Received: by 2002:a17:90b:17ca:b0:32b:a332:7a0a with SMTP id 98e67ed59e1d1-33b5114b648mr39129699a91.1.1760561328178;
        Wed, 15 Oct 2025 13:48:48 -0700 (PDT)
Received: from localhost.localdomain.com ([2620:10d:c090:600::1:d6f0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288bd55sm523896a12.9.2025.10.15.13.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:48:47 -0700 (PDT)
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
	Guenter Roeck <linux@roeck-us.net>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: fuji-data64: Enable mac3 controller
Date: Wed, 15 Oct 2025 13:48:37 -0700
Message-ID: <20251015204840.80070-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

"mac3" controller was removed from the initial version of fuji-data64
dts because the rgmii setting is incorrect, but dropping mac3 leads to
regression in the existing fuji platform, because fuji.dts simply
includes fuji-data64.dts.

This patch adds mac3 back to fuji-data64.dts to fix the fuji regression,
and rgmii settings need to be fixed later.

Fixes: b0f294fdfc3e ("ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts")
Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
index aa9576d8ab56..48ca25f57ef6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
@@ -1254,3 +1254,17 @@ &emmc {
 	max-frequency = <25000000>;
 	bus-width = <4>;
 };
+
+/*
+ * FIXME: rgmii delay is introduced by MAC (configured in u-boot now)
+ * instead of PCB on fuji board, so the "phy-mode" should be updated to
+ * "rgmii-[tx|rx]id" when the aspeed-mac driver can handle the delay
+ * properly.
+ */
+&mac3 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
-- 
2.47.3


