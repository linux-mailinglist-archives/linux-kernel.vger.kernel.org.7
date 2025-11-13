Return-Path: <linux-kernel+bounces-898475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B981C555CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E460B3A53C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604E29ACDB;
	Thu, 13 Nov 2025 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l8hbQNKt"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0422F616D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998454; cv=none; b=h6gWGU7VGejaAkSnyiOcmRYNHaOCJ58bi0mHaFWVGCusdh7if1bBzUBl2mj0G5wgSAQz8VnP1cdYafOt40m336zn549Fr1+fAX5hpa52/HMAWQ76jeTB0h2KMun7ax6FUad8ThU2IjEqFowKC19sQ+GDNWqW2rIcFQ6m4zY/oZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998454; c=relaxed/simple;
	bh=DpKcrTFSXMeznvqkI5iYlK6aDcUsXzIaprU9WCwGV2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfc2vP9Caj6a/qZAXdnLHCg6ldmIVDGS9pwHfpYLI24VHiY73zXyNlGiucGUEcL+FdU8HuoYa4wz3IVIDpJbYvS3QFyDYUMT6SkAmRsp2cFbFPwKfJsLudHsKhXO2Du01VvevoBYjSc3al2+s7LgNqsGNMrcpvPrDILVcJ/lRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=l8hbQNKt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2955623e6faso2310185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998452; x=1763603252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmm07HI+8fQZ9dsXPTz2+pE8ZdXEYclRtD5hDrzxz+A=;
        b=l8hbQNKtfpr3CcUQrWA4fF+haHAk32uyKO1PUswuVflU3srHyNJ3tC/JfY6ALP6XI2
         icRwY7+2KAl54HQIpdMlm1EJWJPZ9xiPzGLaIJPDkNcoNW69kokmfMNPHsf4FTEqQi8A
         MT88jXftjN7p6dtpujK954AkIoMtCx+J0CzPH0KxHVwBEIM5HplMF83kT7fWPXV00HKy
         6gOTG9wIHZ8O58ZTC15bHXAmbHEJ9S5+IniDC7mmu6lOc1eA/cJkXkzY5kgscHJjIB/Z
         PyjTWcvHrivtlSVjCigZOVVomLonitj3oqb10Z32F/7Bgmyhr74XJQwRu/bQbFSqq8LC
         OqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998452; x=1763603252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hmm07HI+8fQZ9dsXPTz2+pE8ZdXEYclRtD5hDrzxz+A=;
        b=v7WuG+aiRCnam+i8B9gr5MiSNr3KlNiqAfhlq3Qyi35KVjS5vXGm7W48+3qLbloseZ
         saDNXoDyHu4Ct8x6qCmN+V8fdbAieU/FI9NerLnSdzBOVEaQf+f8LFwmJ3r2Z+fCSv0b
         UDPv4+/IssvU3nEcZgzlYcEGsnRg6G7KVVtg0a/H3TxZIIB12N16rHM6OR50Htwvu8YG
         5s3gcwVVRfBk7bUpWnWGCztmFIwD1JsmDQ9BYElV8rj8F/UQxJheZ8HipApX9pz/paJq
         tobkCEx7e2ZAtX85VogibBwS93ac2/wwUhNAdEX/Ov9xmTmRBf6j/6/ViMwrJpzU4Y8t
         jOhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzxjl8xKXfKh5Wbyl8klPJjH2Bdp+InUmtcng/34FAlux2Skujn/WspOk6cmuY9xJkOWBUGFRJi+naLps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdq0V4bLrz+2sIemTH+zUxjq9ifa0h9DyiJA/aJaM8dcAWeh2r
	emyn1ZBDdu+BGVpjfdOxJLVhIKhhptluP5m7LObkt46z36bxaCuqoqtrWnt4xti192Q=
X-Gm-Gg: ASbGncuo7lYhOmNDqDJaLVTuZLcvPFV870qqp3PUffDJ4JXXHL2jCKietlRvsH4ErvH
	9pv/RrL1g4B14tY5J7OlDzNzGH382Ih/6WfL0fjGyOOzos9xjs81EIHsMN76m4cSxuaXbnJ3TLk
	whf7FGiit8w8I+rgtJJbDS8+55v1X7lUvL9UIWpcW9csl4rgdaALbsYDWTCm01PSVDPU/TokmJj
	jNY5xUBQQ0GsBqoCs3aAnU+oyd7YGKIf2RtvFXuf77Y1Sz68e9bJVIWVl74G+e2ZS0M2BosV5Na
	RzRBzMkF+p/I729jOYhh8Ez1rqNLoN5UOhawbRKXCAx/AsxUQt4M9+i3bNuFdZgWP+VVsB2R4Wi
	5zWLGQOEhDMGabs0wUa8rZW81G40ZFDIbRfIkYzr3r94k9YnXiNFgxB9MLVb4C6YNoqb8wulAEK
	GTa+VdBaeFbGAThyRAhTP2pA==
X-Google-Smtp-Source: AGHT+IHJJ32S+3DmD1CuHHRA6pREy7usForarOqF2N3irQZblubt51Eou/L7IV170eSGC/5u/UdVRQ==
X-Received: by 2002:a17:902:e841:b0:295:86a1:5008 with SMTP id d9443c01a7336-2984edec288mr76669175ad.38.1762998452211;
        Wed, 12 Nov 2025 17:47:32 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:31 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 22/22] riscv: dts: eswin: eic7700: Use physical memory ranges for DMA
Date: Wed, 12 Nov 2025 17:45:35 -0800
Message-ID: <20251113014656.2605447-23-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
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

Changes in v3:
 - Fix the entry number of the paired region in the DT

Changes in v2:
 - New patch for v2

 arch/riscv/Kconfig.socs                | 2 ++
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index a8950206fb75..df3ed1d322fe 100644
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
index c3ed93008bca..d566bca4e09e 100644
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
+		<0x0c0 0x00000000 0x010 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY | PMR_ALIAS(0)) 0x0>;
 
 	cpus {
 		#address-cells = <1>;
-- 
2.47.2


