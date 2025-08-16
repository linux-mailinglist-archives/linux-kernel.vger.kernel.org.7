Return-Path: <linux-kernel+bounces-771839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E43CAB28C18
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679281CE4BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB923E350;
	Sat, 16 Aug 2025 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3gHtDgR"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A823D288;
	Sat, 16 Aug 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334096; cv=none; b=Z3gSBuCzBAqH5G5XRlQD3v0gLxwk8I8OO2qfKysFctbf+qeWU8RJVXwbD2Ras6YrWl8JkxLNX140c6KgaeM29EL+CdtnA5vdA6swEb8cqnklkd8+8/NqJwryugX7pwcBVxNtDsMTFbiZfWIciJmvq6MOubN7TkSlbGds0eqAn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334096; c=relaxed/simple;
	bh=3uKkcJFOXgYLabgZa+7XV2eGzSf6Ec9xtil3xuV0aXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axP3zvF9M+mL6eHC7s/D1K3P4fet9W6tn3D2RkkUT1WW5YVDqpIZ85j7YWURf8JJWCGYbhkcFKPNXTnZrTysXKe7BCdW6p3Ewv0lVcJgfwqQ0KSmNhl1BWir+sP+iTh3leZ8VVq1fVj20eqOCLzZF3B+YXYf6A93U2ZOagA0jjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3gHtDgR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456f3f669so27106285ad.1;
        Sat, 16 Aug 2025 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755334093; x=1755938893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZaUVKgFL1lunF4nMqIkLNfN3yrPrabF4vqHbgSjhvc=;
        b=M3gHtDgRAOo2pRpaAjpkEEGk5VkbR5daU9hnCn8HjCv6R/7SBNMl+xL6wqNzEttm2Z
         vS6JqtSJWOjChvMtyH8+nqreBmHkyFASUYc7DQtcWIxvJ8uqZnBybwVPYkeVTbBHSEn0
         jyL6/IRbsKiwxaT2Avalu7fHJR6vtgIiYWUe/ALWM4ltN4FlK2yfjdR68Y7bjEnWvUPO
         q/UpMAgMMIXvGyVrMhKxBP7yyKhU84q5oPzP1+QLJbNHpIli07iA2CwUzI8wjTKsmc62
         ldff6rgIcoBeYWlomlJnF6xnRCKpTxVuhZPAbCMg9IoWixClBZu7C3rU7vbNCtxPV6fV
         ZJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334093; x=1755938893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZaUVKgFL1lunF4nMqIkLNfN3yrPrabF4vqHbgSjhvc=;
        b=FDOMyocnE96BIh1uw+lTpTo3BZf4oC0GkcKdw+M0uvPFVll9NyCXXQBHQUqfwK1pag
         LiGRyS+MFq3g/0hCSFkLjM46zy9otNnVxDs1+bpD7q1yfqG3YQ9lYhCHYOq6HBvn8JWV
         zZSTu4Afc3k4BmyycoZNXEmhR4kNf3xM3kvmHAq9QcWtV6raIyJvZx2GeGnLVNT5Fj3Y
         9+9VhLGuuLsskeF8iLvnPJ0s7x8gJXLOD6gY2WpQ3EVX7pxRsjgBjN/PMGvF449U+gxi
         aKclC3uejPU6bKxBSkM1tOUopSktxoFTSGGJsq2mkvoCzPU4eBRZZFzfT+FOq/LflZa2
         NpNw==
X-Forwarded-Encrypted: i=1; AJvYcCUmsTpqbeHOrwBnReIX39V8CkeDnARCYdTwKOZhZ3wHI7YJtwtBOEM043g0g+UZf8RniQSB+1/aq4s=@vger.kernel.org, AJvYcCV033oFsiW6KDpl1WVLhzl7mopXRHWIQxgWJGVaQbvlDfVHmqnCfcCVO1BK4hrMCZcB4I+wp/4j69D31RAP@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXj8aCCa9mNsE6XwuKDrg73zM3JnKPLbdjS5Dw2tJo4nQgZNN
	MUgylM3+TCEFn5i6ZnhEqGznvv3lsm3l0Pqyvgyomifv1T4TUCf8AyvL
X-Gm-Gg: ASbGncuftE13h/VI6fHk7THKVdjzJ9tx894OTrgdjSDkMTkOp2PP5yKDbrgH0V2fxtJ
	4nrpqHl1LltTYqpHtSh64nP41nnbF2E3AESJ+I5DM1oTg4om1Br+Sg7x0VVmTmQUm1MYeTqT9R/
	K4mh6ykHOFJD2FAC8vLwqzZvc31nIHIhctXdPwo1fRQcSF1+gJglmJB3vZ6VLzD5FOYjNLAb4cD
	o9/tI8oz5GTBZ1Acjqhcm2Bv3GJ3MRjjsEISK5LAR4+Pisb6mlyaQ8OKBsAH9rDM9e+CtRbu4ET
	vup9WRmqLGCCM0fJqMRrbE/bYLTgsS3XooYuX6lgfzYKrO43vfHj4aIPSan9HPWL5Y4yiDzyq8y
	uF80WYiBWglo=
X-Google-Smtp-Source: AGHT+IEeC7TzpwrnZ29EptzNFEC8zZV507GN6tiYHpU7eLNsZcGs71sZYOzt9Mx6896AVTDC5n+jJg==
X-Received: by 2002:a17:903:2d2:b0:23f:75d1:3691 with SMTP id d9443c01a7336-2446bdafa24mr79167475ad.15.1755334092874;
        Sat, 16 Aug 2025 01:48:12 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm31048215ad.157.2025.08.16.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 01:48:12 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 5/7] arm64: dts: allwinner: a523: add USB3.0 phy node
Date: Sat, 16 Aug 2025 16:46:58 +0800
Message-ID: <20250816084700.569524-6-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816084700.569524-1-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

After adding the phy driver, we can also add phy node. In addition to the
clk and reset lines, the power domain PD_PCIE is declared in this node
according to the bsp dtb. So let's mention it. 
Currently, phy driver does not support role selection and only works in
USB3.0 mode.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index e4ed4fa82..233365496 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -606,6 +606,16 @@ mdio0: mdio {
 			};
 		};
 
+		combophy: phy@4f00000 {
+			compatible = "allwinner,sun55i-a523-usb3-pcie-phy";
+			reg = <0x04f00000 0x100000>;
+			clocks = <&ccu CLK_USB3>;
+			resets = <&ccu RST_BUS_PCIE_USB3>;
+			#phy-cells = <0>;
+			power-domains = <&pck600 PD_PCIE>;
+			status = "disabled";
+		};
+
 		ppu: power-controller@7001400 {
 			compatible = "allwinner,sun55i-a523-ppu";
 			reg = <0x07001400 0x400>;
-- 
2.50.1


