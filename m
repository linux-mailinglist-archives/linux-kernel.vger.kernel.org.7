Return-Path: <linux-kernel+bounces-846158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D6BBC72B9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D2C3B2FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE201D435F;
	Thu,  9 Oct 2025 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KGcKbXJu"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305331891AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975152; cv=none; b=bBuFhK7c4BTne4DEfo5L5mKjaO50MhrxONCKrp3iwTbaoO48TNFR2Cu0XOr/2aUmgy+elVBPGhxQIwtiMvGR62bVg/9UCc5Nf4dlr1A8YP0afj4vcwWj84ivarPbX8sLjfEMzx/Gf9d9tCZ/orpih8BO1U9c5HlpHyWe6RAPdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975152; c=relaxed/simple;
	bh=fz/lHHixe+6qbU8BmIUmjqU5K+n2uPZ5xsU+fBDfYsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dztwU9qwg6O9b7RT7fiA6rf3dbMUra3F7PYynCm/cZq9gWDSDWCopCGeeP6nwmrTXftiM+VT1Yzy6QbPloyKPtENYtkgSuyvhDuvnUYsgKYcNSMzVUVHL5RDdouMdToWNvOFAb6ZdgGNArKCxqSCjg79L1nZBoUZDPzkWK430yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KGcKbXJu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28a5b8b12a1so4203295ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975143; x=1760579943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BAMdYf9jYg430LRuIQ/78MgeGFhJjBTPRUD+PdvqOQ=;
        b=KGcKbXJuakwv6Qf/Um0mCf/gxhPgiWA2iQ75foYGAyjEvDDJSviUMwbJQeAEYzx+Xc
         WuF7rFGgOTZnIBBR/oJegcnlUpCCNLmbFkvsmg+F3o/0yw8fgfs9E8RfbgGP+/S89GAB
         n4hBBfDZvEIBZbuY5sqN4r8Tagtr08e/YYJRdqAerufdmqEk6/+3zoKBCUMacCPPSzR+
         K4LQTc3SlFlHVACn/3A+m5NrVmo1QD7Rej6eouEdMZkTvknllAqyzT78/v9CwdT8Mp3Y
         u7dRwu1rveGmmHggwN25ou1ZK/HV669+kN0QLRbs6f4QovyG8msA7dhsYoqMKNE3QauB
         P8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975143; x=1760579943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BAMdYf9jYg430LRuIQ/78MgeGFhJjBTPRUD+PdvqOQ=;
        b=jz9rC0gP+UmTwVTpkxAfFkeUMePBwNA1YaMqAKh5LdgH3JhT6ASyEDDEJ3yBK0rJnE
         K5W2kPJo4laMpjpReTWMyZXDZ0Ewazq2HiHr3pBmQ48I8CeTl4cedtYSK4xTbmYcTynk
         A9EWpxUEQsAQZK9STpUrDeCyvOrLQNzRrrwjralOQ1CQ43PLxjyzRNiMuPj8t+WxKp+U
         /0cO/WDJWDDhG099Tm7BdtqdQuRLHQNQXfFh8bjybZo0s3C4HQIvxEJnmWLAs+7ng4vj
         O9oBJTUt0CCrs49RFlPjdPCnhrEToKAC423QgGSf4ApAMgn6bs7rOh8YfJqK5H2FPWSW
         4+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlMWXqhe/qQR1VsQ0aROpMsOG7d+BTSO0tZCoo0j0J5kyAAW7S+gr1Yxs1r6oy5eEn5zaaTASWEalN2V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwErS5UYON8XFex9tmf3adADXh1iQfWNGf9bjPIVxSKzgNT595N
	SoV6M6BcahzCMWQpU9nzv4j5EuuNVl0SZYE4cLSJvu+zPLJE/rzHZQeeiTcrGWXx0mw=
X-Gm-Gg: ASbGncuAaCr1fo+Oj7PCYgzNHLe7iMCkdAbP4DLu5jza7Ed86JaAJhunAyCYtHwx95Q
	TOxGZg9nWnxAGn9BoC6Qt18hpCQFgXAPDxvKMcMRemdQwQWc0/6sbZcbP8GImvHfvPXyziGlLRJ
	p/KRvxFDIfrp8D++sfp11Wh3bo/AFB9Ch36JZTxaVSjAd1Vy8/V17YJS/C/e8mHF1h+LLMKoqGf
	nXdJQwcgAsadF2uhVHaKTbJ5cqJtQHoiwHTU9c5X7dgS+sCgzOgSHtGhcUu1iKJtIXAb1217TBx
	8A62KfJaSoFTK4umU1WJuga3XIA9nw8pPJ/XXvvNd18OJL6Hh/ZhGzciDSrw0tw1fdcfL6hmcEX
	tXkIdKePNmLK+Wz1b63uGVJBMnoBA10LGtGW0Kmi2MLm5uPnv3FDAjUUSjI9flsyiA+EZpGSYzt
	nZ4W4=
X-Google-Smtp-Source: AGHT+IFH8AKgqsZnk4E4iyKT3yuRTpeHrZ3gNSsclL9XuJ0PoMWOCXT4FRimy04nwWVVyn2iJvf1+Q==
X-Received: by 2002:a17:903:910:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-290273eddc4mr77201595ad.38.1759975143155;
        Wed, 08 Oct 2025 18:59:03 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:59:02 -0700 (PDT)
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
Subject: [PATCH v2 18/18] riscv: dts: eswin: eic7700: Use physical memory ranges for DMA
Date: Wed,  8 Oct 2025 18:57:54 -0700
Message-ID: <20251009015839.3460231-19-samuel.holland@sifive.com>
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

EIC7700 provides a physical memory region which is a noncached alias of
normal cacheable DRAM. Declare this alias in the devicetree so Linux can
allocate noncached pages for noncoherent DMA, and M-mode firmware can
protect the noncached alias with PMPs.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/riscv/Kconfig.socs                | 2 ++
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index a8950206fb750..df3ed1d322fe7 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -9,6 +9,8 @@ config ARCH_ANDES
 
 config ARCH_ESWIN
 	bool "ESWIN SoCs"
+	select RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
 	help
 	  This enables support for ESWIN SoC platform hardware,
 	  including the ESWIN EIC7700 SoC.
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index c3ed93008bca1..09292910065b2 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -5,9 +5,14 @@
 
 /dts-v1/;
 
+#include <dt-bindings/riscv/physical-memory.h>
+
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
+	riscv,physical-memory-regions =
+		<0x000 0x80000000 0x00f 0x80000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY) 0x0>,
+		<0x0c0 0x00000000 0x010 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY | PMR_ALIAS(1)) 0x0>;
 
 	cpus {
 		#address-cells = <1>;
-- 
2.47.2


