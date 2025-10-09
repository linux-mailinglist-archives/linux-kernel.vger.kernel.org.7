Return-Path: <linux-kernel+bounces-846156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102EFBC72B0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC623AE86B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B1214204;
	Thu,  9 Oct 2025 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mosMstHQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DB1C1F02
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975149; cv=none; b=MUmR1BvNt6FyKx3iVhq9W/NTlMU8QYGS8tzwKX7Ou+YWxYlIq/8+sGpXIlcbPUFQsWvi6KG0pGZ9XetYkJd3FZL6izvzzAMxxIj9F4h/dUgcsVJ9xZb0qwXEfe1TkWhZ0x7fhc7AVS7hgHuLuxlrtrApTqGoKS0FUSqPrUlaeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975149; c=relaxed/simple;
	bh=x1sTV0AT4E4iSlIDE/ZiI0pNoMfZnFcc6z+Ujtu3aW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbXjgLQB1jFbdWUea0C2Uiynv4hPw7guzTLkrTN3x9xUenCY3lzv6bZ3pyVm6cTq9Yja5VEFdOyubXMYt0z2jxXRNFWSabra0sQ2sM+cGabgAasy2JWdVkxs6j7GIjWlMTFbegzd3Gngc7WJg3fVzV2G8DIqXg7WnawPX7YZ7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mosMstHQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-791c287c10dso402409b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975142; x=1760579942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n103/Zzy6dOfBxJ4uy1kIK0G1FNuk9TvEmc6PK6Kghg=;
        b=mosMstHQ1iTBb41jMlorrmN2wp3knjLxsKyysgCBLx3gc6xbkh0UyfLkqZ7nF9cH83
         qUK9mBMcm4Oe+2BQSdAYzKk6gN4fLekfORxMxXAdHTEVZINBx7+eEXiu+vhSAcBDGbMn
         PmakDkUr1dHZo+2BSJ0HiR5WQ/A7rRyxT6sJ1ztXqNThfReE8rl2nQaRFgMz6/l9H85l
         LNICufoWbtN1aSdxSi5qF1Zo9mihCk8VEk1albrqkzmPJ6C9kt0KUc6Tnw/cvCIEyPVc
         KFFXPf5g429OBbICCYuzvf0MaXB1VwpVj81cPe4/7z4VM6ReUfJhPBBarr7u/Op6rr1U
         4WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975142; x=1760579942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n103/Zzy6dOfBxJ4uy1kIK0G1FNuk9TvEmc6PK6Kghg=;
        b=AQwbDNtE67QcXNqcLVCwDg/h7bAGFDDw+aRJtXCJ4S2yjrbIPi6F7+4AhD977oJ1sy
         n121PsVzF7FiVZI3sX/5jZw/OziCU0UEphhZAMgCOQa585+ql2FOVqDHTAPnPiG+agbn
         ER51196iuE8vi2e9r0BTktbWLDvHAX4b2MwrGbKv1050mk/ABY1v/kMhJUq+DyUX/FvY
         9kaiWzzz3E5jN/UcYP3LS+tMvBa3pDlkMgz0hphBECapp4A5z3aXAxkelifbdlOAohAM
         sHht5PUUrVBSwiuppqgCf1V5WliJXTQ8Jilzt7P33jAwiTPPCuM1iVlxEkKPo3s+5C9Z
         Q+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV0A+r2T7BIGjIlw5lPyKVwRa6LXqSaR4CWy79gmKAqwwNeHQwS7VwMvtNEoS26JV5ziM888W/bO6xxQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM86LgPNSs+kh+BLn4i9TQTYDlb7jvqyxYsPLH+KR/G5w/GeJJ
	YyEKma2qthsTF9H1ybW7p9bYMTqmuZ3d9QULE4uHBQ7C4wUBDLDKut8CY0kRyY6YDbA=
X-Gm-Gg: ASbGncuCJ7M3JgGqOwvAeOH+HPugYVVYGzT5b2KGakhQ10i5FgenZRpf13k71fo5Tmi
	EVZx7ih3haf+yLkfzcmuoM/uz/aMYwe15faQLqG7rH6FB7iztnQA+C6oTvRfycJmG2P+7cmX3Ml
	wTi4oNfVxyHUS9Wx9OQxsAIWoqgn+wh7CMNE+kG4iYS8QCAGGpgCKQCnXaIpu+t/PL+uV8qG+hg
	pkmMZEQEH+4mghsWLAUL/lGIHJ8slUqR7i5v1FbBuiKL0gx+8r6SqNWR4vFb8i6jQYyeJCjzBv6
	j0YYj6i7ojRB5HTHnahr1J98JUiumadBbnbgJhLUjTu6DorQwtfOPhbSZ0yBoGnCwUD2tspITNe
	aYwNEjD337JLqECzLiNvtkWc7oUL7EflmW/g8Yij2wnavlRmOYpfv8w1IG6DLe7ylW1NT
X-Google-Smtp-Source: AGHT+IFWJLoMlJoGXelrIQt9ocniJALkCftXGohMVp8CEHqCZlMQayonVPQ6X5ZOtEekzhDbe0VYyw==
X-Received: by 2002:a17:903:1a03:b0:269:8059:83ab with SMTP id d9443c01a7336-290272e1ccamr67703105ad.51.1759975141970;
        Wed, 08 Oct 2025 18:59:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:59:01 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 17/18] riscv: dts: starfive: jh7100: Use physical memory ranges for DMA
Date: Wed,  8 Oct 2025 18:57:53 -0700
Message-ID: <20251009015839.3460231-18-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

JH7100 provides a physical memory region which is a noncached alias of
normal cacheable DRAM. Now that Linux can apply PMAs by selecting
between aliases of a physical memory region, any page of DRAM can be
marked as noncached for use with DMA, and the preallocated DMA pool is
no longer needed. This allows portable kernels to boot on JH7100 boards.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Move the JH7100 DT changes from jh7100-common.dtsi to jh7100.dtsi
 - Keep RISCV_DMA_NONCOHERENT and RISCV_NONSTANDARD_CACHE_OPS selected

 arch/riscv/Kconfig.errata                     | 19 ---------------
 arch/riscv/Kconfig.socs                       |  2 ++
 .../boot/dts/starfive/jh7100-common.dtsi      | 24 -------------------
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  4 ++++
 4 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index e318119d570de..62700631a5c5d 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -53,25 +53,6 @@ config ERRATA_SIFIVE_CIP_1200
 
 	  If you don't know what to do here, say "Y".
 
-config ERRATA_STARFIVE_JH7100
-	bool "StarFive JH7100 support"
-	depends on ARCH_STARFIVE
-	depends on !DMA_DIRECT_REMAP
-	depends on NONPORTABLE
-	select DMA_GLOBAL_POOL
-	select RISCV_DMA_NONCOHERENT
-	select RISCV_NONSTANDARD_CACHE_OPS
-	select SIFIVE_CCACHE
-	default n
-	help
-	  The StarFive JH7100 was a test chip for the JH7110 and has
-	  caches that are non-coherent with respect to peripheral DMAs.
-	  It was designed before the Zicbom extension so needs non-standard
-	  cache operations through the SiFive cache controller.
-
-	  Say "Y" if you want to support the BeagleV Starlight and/or
-	  StarFive VisionFive V1 boards.
-
 config ERRATA_THEAD
 	bool "T-HEAD errata"
 	depends on RISCV_ALTERNATIVE
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 848e7149e4435..a8950206fb750 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -50,6 +50,8 @@ config SOC_STARFIVE
 	bool "StarFive SoCs"
 	select PINCTRL
 	select RESET_CONTROLLER
+	select RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
 	select ARM_AMBA
 	help
 	  This enables support for StarFive SoC platform hardware.
diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index ae1a6aeb0aeaa..47d0cf55bfc02 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -42,30 +42,6 @@ led-ack {
 		};
 	};
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		dma-reserved@fa000000 {
-			reg = <0x0 0xfa000000 0x0 0x1000000>;
-			no-map;
-		};
-
-		linux,dma@107a000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x10 0x7a000000 0x0 0x1000000>;
-			no-map;
-			linux,dma-default;
-		};
-	};
-
-	soc {
-		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
-			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
-			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
-	};
-
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio 37 GPIO_ACTIVE_LOW>;
diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 7de0732b8eabe..34ff65d65ac7e 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -7,11 +7,15 @@
 /dts-v1/;
 #include <dt-bindings/clock/starfive-jh7100.h>
 #include <dt-bindings/reset/starfive-jh7100.h>
+#include <dt-bindings/riscv/physical-memory.h>
 
 / {
 	compatible = "starfive,jh7100";
 	#address-cells = <2>;
 	#size-cells = <2>;
+	riscv,physical-memory-regions =
+		<0x00 0x80000000 0x08 0x00000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY) 0x0>,
+		<0x10 0x00000000 0x08 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY | PMR_ALIAS(1)) 0x0>;
 
 	cpus: cpus {
 		#address-cells = <1>;
-- 
2.47.2


