Return-Path: <linux-kernel+bounces-820086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18973B7FC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60FD37A8D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D123643E;
	Wed, 17 Sep 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="iGRfUjEX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B5238179
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092395; cv=none; b=uUZDPkMDGguLpd3Brbo983dTGq6D9fGSizGA2ZDWzQ3soNk6th60N7Pm/OkkSu7TTkWy+0inIGu0v2+lMz4yPP0Dqu7AtVdcE2vZD4THAp0erS//3p14zArTeSQtKvJfFzK5otfZLZ9K2HJeez7aJ0bio2nFogam89mFEfKcho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092395; c=relaxed/simple;
	bh=m7A9x62vNaAiuQT4LAU5s422w1g5UkDXyP3ODPgCMv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzoN8bHAbQ3DPqNlb50alkbDwwypG3v62iucO+LHG1oNG+O5buT85JhlCF4mwZKJeRYlAXz6LBsB9/sfy908ClmgMuHCSuC5hiJ1Jol3p3nRmS8lsVeqSP7D3Lb9B9xgsEz3Faqv+T97BUCj37ALHvY5LB4GUuAfpCbIU9GBZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=iGRfUjEX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dae49b117bso4885856f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1758092390; x=1758697190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7h2V7+XLJsHOcDetA21NTfGsO1i/U83vyv69RqPpe0=;
        b=iGRfUjEXQQCMWlg8F6QDinJz/gGJFVZBg0In+KeK4mcqCHqPoBHP1sX/dInYEWjMmx
         1Nqm4MH0TXMcBK3gFomtw/06WjFmsChpDHhwzp1QgPEHKD1nFbMeM/wXX6HJKgG0XSJU
         KV/mMXkZDtE6+L4+/M7la4zMIUQ0pwaw7cJL/LzhkFTLcOtz2BOOrA7WQlZikkgM7Vwy
         8jw1y6zOU8Ck764GFc2ekuaC18V9UaBMG2z1aEjRZi263SW/k2sPWxP7508B6kVO8jzs
         J8YyV4jOBkkP2HvLVXlXm12bkoap/dvM+KcXPCK/cBtsvdtidfcueEzNixlcfs9U7Z/t
         qz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092390; x=1758697190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7h2V7+XLJsHOcDetA21NTfGsO1i/U83vyv69RqPpe0=;
        b=enPRibp7LbgsVt+ZnKvbNEnootjptU6VW1LAzdvnBuCcGSo2IAkIrAFUbAmSmCMHjM
         dddfQ2Nk+FsQia7wt7/OfxzBl6vpU7zmznEWu4VVyv12wPNB0EtFp02L5foYuqS7XuI+
         6A5cDrsB6CkLlr78GPL+UHn2SvYOvL/qbhjfbDTcYUwgfWpBRI+hbrG4yDpZgZc0nVMm
         oEv+lmTQKe7IiICTWG6w9zdeXBvV9AnT68mNk1XR/8zVFayQuEYDDT4A9atrdRqAFXvn
         UUOheiKh6YBjlNt5RtTBAYSq4rCCdw1wFjuZCWluBUTp+OlPnws3tF93t4mWfb3n1LxE
         ZM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoeX45zzEAGY9+RhkDEFGh9vdgXUKj5854cL+fyYGIvy+eKNl6L+0/9mngIS0IqjrYtmiCI5MSlHeDbWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzphPfX2eNqLsgk+IA71UuJnWp81aRTohME37u/QiPyXC9TX3th
	0aZryjCJOfm7ll+FjMGDDGYZXPOCRE4t+nQGrZTgXfogUO2PXiYCLc0M19aaGfOm12Q=
X-Gm-Gg: ASbGncvET9FTsO/wzrQ/8j7mPjaiWTwxf+cNFQiFuFXUPjpZP7Zy2Cx/rSv9PdmSm5+
	LFf+76rJqaUuKTvo+RtnuWq+dC+SW6AqEzUlT5vFhWOuPmDlWWXxve+kTd16rWjXfwj8xlapTrm
	/z8ukkYJCzvQZHxuy92BJpWS62r/z/SgPUXAiHHe6LMHsVk0z8D7AtP4B8RTPoQYkNJJWPV/4Wk
	MSsDgQ86ENBhWvXwkbWERR55TU5vxXbbtC0nx4KM0tQ1Y8ZKP06ItxUJR9SsEtJY3d4renpr2Vb
	ihw2nKgdRugOIUf8s2OFwd+DHX3bayj/yqAuhIXr6EOiR8Yo2jYSXL91RDUdj9bAuXInfdLPKVU
	l9O/dG4Yo+YyPLD80eApLjDlbK/8n6oxMNxVVUzwfJu6PNkJk8ik=
X-Google-Smtp-Source: AGHT+IGge/PYhWtSCfabX/nrs/mY9m1ICW696JLt4kj2wQMv5DZNSfWYfAOgO/3DRfIWxtWOVhPBTg==
X-Received: by 2002:a05:6000:288a:b0:3ec:4e41:fd97 with SMTP id ffacd0b85a97d-3ecdf9c8a38mr781809f8f.24.1758092389680;
        Tue, 16 Sep 2025 23:59:49 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:1b1a:e580:5909:925c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7e645d1fcsm19202809f8f.48.2025.09.16.23.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:59:49 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v4] riscv: dts: spacemit: add UART pinctrl combinations
Date: Wed, 17 Sep 2025 08:59:07 +0200
Message-ID: <20250917065907.160615-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add UART pinctrl configurations based on the SoC datasheet and the
downstream Bianbu Linux tree. The drive strength values were taken from
the downstream implementation, which uses medium drive strength.
CTS/RTS are moved to separate *-cts-rts-cfg states so boards can enable
hardware flow control conditionally.

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
---
Changes in v4:
- Explicitly use 0 as bias-pull-up value

Changes in v3:
- Added /omit-if-no-ref/ to pinctrl states to reduce DT size

Changes in v2:
- Split cts/rts into separate pinctrl configs as suggested
- Removed options from board DTS files to keep them cleaner
---
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 430 ++++++++++++++++++-
 1 file changed, 428 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 381055737422..44e78764f491 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -11,11 +11,437 @@
 #define K1_GPIO(x)	(x / 32) (x % 32)
 
 &pinctrl {
+	/omit-if-no-ref/
+	uart0_0_cfg: uart0-0-cfg {
+		uart0-0-pins {
+			pinmux = <K1_PADCONF(104, 3)>,	/* uart0_txd */
+				 <K1_PADCONF(105, 3)>;	/* uart0_rxd */
+			power-source = <3300>;
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart0_1_cfg: uart0-1-cfg {
+		uart0-1-pins {
+			pinmux = <K1_PADCONF(108, 1)>,	/* uart0_txd */
+				 <K1_PADCONF(80, 3)>;	/* uart0_rxd */
+			power-source = <3300>;
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+		};
+	};
+
+	/omit-if-no-ref/
 	uart0_2_cfg: uart0-2-cfg {
 		uart0-2-pins {
-			pinmux = <K1_PADCONF(68, 2)>,
-				 <K1_PADCONF(69, 2)>;
+			pinmux = <K1_PADCONF(68, 2)>,	/* uart0_txd */
+				 <K1_PADCONF(69, 2)>;	/* uart0_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart2_0_cfg: uart2-0-cfg {
+		uart2-0-pins {
+			pinmux = <K1_PADCONF(21, 1)>,	/* uart2_txd */
+				 <K1_PADCONF(22, 1)>;	/* uart2_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart2_0_cts_rts_cfg: uart2-0-cts-rts-cfg {
+		uart2-0-pins {
+			pinmux = <K1_PADCONF(23, 1)>,	/* uart2_cts */
+				 <K1_PADCONF(24, 1)>;	/* uart2_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart3_0_cfg: uart3-0-cfg {
+		uart3-0-pins {
+			pinmux = <K1_PADCONF(81, 2)>,	/* uart3_txd */
+				 <K1_PADCONF(82, 2)>;	/* uart3_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart3_0_cts_rts_cfg: uart3-0-cts-rts-cfg {
+		uart3-0-pins {
+			pinmux = <K1_PADCONF(83, 2)>,	/* uart3_cts */
+				 <K1_PADCONF(84, 2)>;	/* uart3_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart3_1_cfg: uart3-1-cfg {
+		uart3-1-pins {
+			pinmux = <K1_PADCONF(18, 2)>,	/* uart3_txd */
+				 <K1_PADCONF(19, 2)>;	/* uart3_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart3_1_cts_rts_cfg: uart3-1-cts-rts-cfg {
+		uart3-1-pins {
+			pinmux = <K1_PADCONF(20, 2)>,	/* uart3_cts */
+				 <K1_PADCONF(21, 2)>;	/* uart3_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart3_2_cfg: uart3-2-cfg {
+		uart3-2-pins {
+			pinmux = <K1_PADCONF(53, 4)>,	/* uart3_txd */
+				 <K1_PADCONF(54, 4)>;	/* uart3_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart3_2_cts_rts_cfg: uart3-2-cts-rts-cfg {
+		uart3-2-pins {
+			pinmux = <K1_PADCONF(55, 4)>,	/* uart3_cts */
+				 <K1_PADCONF(56, 4)>;	/* uart3_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_0_cfg: uart4-0-cfg {
+		uart4-0-pins {
+			pinmux = <K1_PADCONF(100, 4)>,	/* uart4_txd */
+				 <K1_PADCONF(101, 4)>;	/* uart4_rxd */
+			power-source = <3300>;
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_1_cfg: uart4-1-cfg {
+		uart4-1-pins {
+			pinmux = <K1_PADCONF(83, 3)>,	/* uart4_txd */
+				 <K1_PADCONF(84, 3)>;	/* uart4_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_1_cts_rts_cfg: uart4-1-cts-rts-cfg {
+		uart4-1-pins {
+			pinmux = <K1_PADCONF(81, 3)>,	/* uart4_cts */
+				 <K1_PADCONF(82, 3)>;	/* uart4_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_2_cfg: uart4-2-cfg {
+		uart4-2-pins {
+			pinmux = <K1_PADCONF(23, 2)>,	/* uart4_txd */
+				 <K1_PADCONF(24, 2)>;	/* uart4_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_3_cfg: uart4-3-cfg {
+		uart4-3-pins {
+			pinmux = <K1_PADCONF(33, 2)>,	/* uart4_txd */
+				 <K1_PADCONF(34, 2)>;	/* uart4_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_3_cts_rts_cfg: uart4-3-cts-rts-cfg {
+		uart4-3-pins {
+			pinmux = <K1_PADCONF(35, 2)>,	/* uart4_cts */
+				 <K1_PADCONF(36, 2)>;	/* uart4_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_4_cfg: uart4-4-cfg {
+		uart4-4-pins {
+			pinmux = <K1_PADCONF(111, 4)>,	/* uart4_txd */
+				 <K1_PADCONF(112, 4)>;	/* uart4_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4_4_cts_rts_cfg: uart4-4-cts-rts-cfg {
+		uart4-4-pins {
+			pinmux = <K1_PADCONF(113, 4)>,	/* uart4_cts */
+				 <K1_PADCONF(114, 4)>;	/* uart4_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart5_0_cfg: uart5-0-cfg {
+		uart5-0-pins {
+			pinmux = <K1_PADCONF(102, 3)>,	/* uart5_txd */
+				 <K1_PADCONF(103, 3)>;	/* uart5_rxd */
+			power-source = <3300>;
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart5_1_cfg: uart5-1-cfg {
+		uart5-1-pins {
+			pinmux = <K1_PADCONF(25, 2)>,	/* uart5_txd */
+				 <K1_PADCONF(26, 2)>;	/* uart5_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart5_1_cts_rts_cfg: uart5-1-cts-rts-cfg {
+		uart5-1-pins {
+			pinmux = <K1_PADCONF(27, 2)>,	/* uart5_cts */
+				 <K1_PADCONF(28, 2)>;	/* uart5_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart5_2_cfg: uart5-2-cfg {
+		uart5-2-pins {
+			pinmux = <K1_PADCONF(42, 2)>,	/* uart5_txd */
+				 <K1_PADCONF(43, 2)>;	/* uart5_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart5_2_cts_rts_cfg: uart5-2-cts-rts-cfg {
+		uart5-2-pins {
+			pinmux = <K1_PADCONF(44, 2)>,	/* uart5_cts */
+				 <K1_PADCONF(45, 2)>;	/* uart5_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart5_3_cfg: uart5-3-cfg {
+		uart5-3-pins {
+			pinmux = <K1_PADCONF(70, 4)>,	/* uart5_txd */
+				 <K1_PADCONF(71, 4)>;	/* uart5_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart5_3_cts_rts_cfg: uart5-3-cts-rts-cfg {
+		uart5-3-pins {
+			pinmux = <K1_PADCONF(72, 4)>,	/* uart5_cts */
+				 <K1_PADCONF(73, 4)>;	/* uart5_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart6_0_cfg: uart6-0-cfg {
+		uart6-0-pins {
+			pinmux = <K1_PADCONF(86, 2)>,	/* uart6_txd */
+				 <K1_PADCONF(87, 2)>;	/* uart6_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart6_0_cts_rts_cfg: uart6-0-cts-rts-cfg {
+		uart6-0-pins {
+			pinmux = <K1_PADCONF(85, 2)>,	/* uart6_cts */
+				 <K1_PADCONF(90, 2)>;	/* uart6_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart6_1_cfg: uart6-1-cfg {
+		uart6-1-pins {
+			pinmux = <K1_PADCONF(0, 2)>,	/* uart6_txd */
+				 <K1_PADCONF(1, 2)>;	/* uart6_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart6_1_cts_rts_cfg: uart6-1-cts-rts-cfg {
+		uart6-1-pins {
+			pinmux = <K1_PADCONF(2, 2)>,	/* uart6_cts */
+				 <K1_PADCONF(3, 2)>;	/* uart6_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart6_2_cfg: uart6-2-cfg {
+		uart6-2-pins {
+			pinmux = <K1_PADCONF(56, 2)>,	/* uart6_txd */
+				 <K1_PADCONF(57, 2)>;	/* uart6_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart7_0_cfg: uart7-0-cfg {
+		uart7-0-pins {
+			pinmux = <K1_PADCONF(88, 2)>,	/* uart7_txd */
+				 <K1_PADCONF(89, 2)>;	/* uart7_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart7_1_cfg: uart7-1-cfg {
+		uart7-1-pins {
+			pinmux = <K1_PADCONF(4, 2)>,	/* uart7_txd */
+				 <K1_PADCONF(5, 2)>;	/* uart7_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart7_1_cts_rts_cfg: uart7-1-cts-rts-cfg {
+		uart7-1-pins {
+			pinmux = <K1_PADCONF(6, 2)>,	/* uart7_cts */
+				 <K1_PADCONF(7, 2)>;	/* uart7_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart8_0_cfg: uart8-0-cfg {
+		uart8-0-pins {
+			pinmux = <K1_PADCONF(82, 4)>,	/* uart8_txd */
+				 <K1_PADCONF(83, 4)>;	/* uart8_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart8_1_cfg: uart8-1-cfg {
+		uart8-1-pins {
+			pinmux = <K1_PADCONF(8, 2)>,	/* uart8_txd */
+				 <K1_PADCONF(9, 2)>;	/* uart8_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart8_1_cts_rts_cfg: uart8-1-cts-rts-cfg {
+		uart8-1-pins {
+			pinmux = <K1_PADCONF(10, 2)>,	/* uart8_cts */
+				 <K1_PADCONF(11, 2)>;	/* uart8_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart8_2_cfg: uart8-2-cfg {
+		uart8-2-pins {
+			pinmux = <K1_PADCONF(75, 4)>,	/* uart8_txd */
+				 <K1_PADCONF(76, 4)>;	/* uart8_rxd */
+			power-source = <3300>;
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart8_2_cts_rts_cfg: uart8-2-cts-rts-cfg {
+		uart8-2-pins {
+			pinmux = <K1_PADCONF(77, 4)>,	/* uart8_cts */
+				 <K1_PADCONF(78, 4)>;	/* uart8_rts */
+			power-source = <3300>;
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart9_0_cfg: uart9-0-cfg {
+		uart9-0-pins {
+			pinmux = <K1_PADCONF(12, 2)>,	/* uart9_txd */
+				 <K1_PADCONF(13, 2)>;	/* uart9_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart9_1_cfg: uart9-1-cfg {
+		uart9-1-pins {
+			pinmux = <K1_PADCONF(116, 3)>,	/* uart9_txd */
+				 <K1_PADCONF(117, 3)>;	/* uart9_rxd */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart9_1_cts_rts_cfg: uart9-1-cts-rts-cfg {
+		uart9-1-pins {
+			pinmux = <K1_PADCONF(110, 3)>,	/* uart9_cts */
+				 <K1_PADCONF(115, 3)>;	/* uart9_rts */
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
 
+	/omit-if-no-ref/
+	uart9_2_cfg: uart9-2-cfg {
+		uart9-2-pins {
+			pinmux = <K1_PADCONF(72, 2)>,	/* uart9_txd */
+				 <K1_PADCONF(73, 2)>;	/* uart9_rxd */
 			bias-pull-up = <0>;
 			drive-strength = <32>;
 		};
-- 
2.43.0


