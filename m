Return-Path: <linux-kernel+bounces-868403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6EDC051F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D26A4560E58
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65A306B11;
	Fri, 24 Oct 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmdrSkcA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C0306490
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295021; cv=none; b=JpZWr72td6Bu73Prp2VW7zgHKwag+kQQ7+jHeHCIqxjYM5pxScPxp/ueP2fkizbjqyHkfSALKYSA2LSJYtYun+fxPcwXyrQFDhlc0xQMTSb9S1pRkiZs2sO7kDH/X8XvIhHx6bYTmpb3IYfEY1NqsFWN0qNxEFQcU349BW3jb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295021; c=relaxed/simple;
	bh=2Chy+VwbCxMqclySUz0ufs6zXs5jzdETPAGPGMs0Wf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tX2S/nGjzmCnGs53Y++gR7XnYE6etwxNj8VRSP33oWvpi0NFyGmHCSyH+r2j6TFj5T2LVWkMuRu3zegIo9qBqaNdhs4IxAXCqRJHio7REkSvqjW0U+wjH5BgyGM3DjHvUQxPlewhE6zwcnS3pjZz/Y4GNGxAQPicjpfhrRPPpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmdrSkcA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761295018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6IP4CrvhUC+N+aJ86duEZEGJ5HwVmI6olhQdQ4mkTgo=;
	b=dmdrSkcAezicadREPwgM+bFDi/ScMp/Brkuiv3usyXIBK0NIQZT9kjH3gF1kPzDaNWXsAD
	bQHgjYb88Qck76K/eibTn2tl1ES1wxDQB2ENPJ05QPmPMSKwGaRYvBoGx9CudWm5T/O5qC
	+5A8IsZan6aTg0Oi1aiHvzdrRMQEv2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Ec6fssDcM-S6b8XG6snlbw-1; Fri, 24 Oct 2025 04:36:57 -0400
X-MC-Unique: Ec6fssDcM-S6b8XG6snlbw-1
X-Mimecast-MFC-AGG-ID: Ec6fssDcM-S6b8XG6snlbw_1761295016
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so1329864f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295015; x=1761899815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IP4CrvhUC+N+aJ86duEZEGJ5HwVmI6olhQdQ4mkTgo=;
        b=d0FRhgkxaJileamuCP+dC/DHtIFXzJyo/DLUX8MpaJcUD20ydUszYkAxk1zuBl8sYm
         86ALedsSsDlem1tSj5fqvNg5uEFHGmYMMn3q+I5hYaWjYUESoXSLrmoP1PQlJB/B3Mm7
         U/bcOpx0638eoXafvCVHpuYh5zjXGSuNRuvztvDh0t0VXS+FDGBLY5bfRqxcz5bmfJSe
         fSvB1pwt/fEzi/a3MpTR1djtGVT5pqa2q4wSiuHhkmjTWJEqIUOyUHvLvlqSK+zUTAg2
         Xgu8V2gEBSpkn099hZswo2/9hlCuQw+3Ld/tCq4V62aGtiL2i2F7/JXvn38MH9KjLHXI
         Wm5w==
X-Gm-Message-State: AOJu0Yxz7jv8YtFNXz68fxZoNXoemfY32fpwhaODvWhsa+iWKS1Sl3CJ
	inl7VjkjxhEwX+/rOLbDzOLOg74FNfTZ0sv9V0VRe9a97SdkA53bfmHsWx1fc53vngvhct3OYCO
	B1fQm/ywjYq5WQHsG2FRcKbsOxfFjU0B4gjEIQzaAHy2Ecj55LuDGNLFqPPXWeMtWU3mhp2S8uZ
	wZBouqMKb1/D1CSyIytYOHDH6b+3+Qp+Rm/w/H4wez4vpsMOiL5DEV
X-Gm-Gg: ASbGncsHutm65c41d07RHs/PngYRBhnZrLd6ef7Yc6za6uerEh64F2WVJmMefKCbfDR
	v1lVEeOLwMJOQ15vRdUT9JCp86z2tsuE6jExcswSsRkxpFOOWZ5vA+WGNO0I166XIR/dVKY4X9B
	Qw5WpOOTX6RH3K2fhlIE8Wtrf+xs2rsNn3CJ5XZ98TLJjsbtAGPS4zrshcv0Fg9Oc1oWbbY5Dgv
	uCC5qkSoqKABBGlJHmtOZ4Sa3ffMUVk/0xz1HwMB6Ay1atayV0l0ZSkRPRPyqhDbmMXfDyDP3oS
	2L/xEvp6mI8bNukVNiXfGPBV8lfmldDmblWHjY+pb8MZwM8UwTOkV7epodmjZnQH2PC65lxC32o
	cRndI4Zx1
X-Received: by 2002:a05:6000:2486:b0:429:8b4a:c3b4 with SMTP id ffacd0b85a97d-4298f50eb44mr1420056f8f.5.1761295015548;
        Fri, 24 Oct 2025 01:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA0nB2sR3hVRzBJN7DXMuBj2PcK0Ip1C+Sl00x3e48btGKdsyMquC1DjN94eGd/K76AwujjA==
X-Received: by 2002:a05:6000:2486:b0:429:8b4a:c3b4 with SMTP id ffacd0b85a97d-4298f50eb44mr1420017f8f.5.1761295015023;
        Fri, 24 Oct 2025 01:36:55 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e77dasm8111636f8f.2.2025.10.24.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:36:54 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 0/4] Add UltraRISC DP1000 PLIC support
Date: Fri, 24 Oct 2025 09:36:39 +0100
Message-ID: <20251024083647.475239-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the PLIC implementation in the UltraRISC
DP1000 SoC. The UR-CP100 cores used in the DP1000 have a hardware bug in
their PLIC claim register where reading it while multiple interrupts are
pending can return the wrong interrupt ID. The workaround temporarily
disables all interrupts except the first pending one before reading the
claim register, then restores the previous state.

The driver matches on "ultrarisc,cp100-plic" (CPU core compatible), allowing
the quirk to apply to all SoCs using UR-CP100 cores (currently DP1000,
potentially future SoCs).

Charles Mirabile (3):
  dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
  irqchip/plic: enable optimization of interrupt enable state
  irqchip/plic: add support for UltraRISC DP1000 PLIC

Lucas Zampieri (1):
  dt-bindings: vendor-prefixes: add UltraRISC

Changes in v6:
- Split enable_save optimization into separate patch 0003
- 0003: New patch - Optimize interrupt enable state tracking by maintaining enable_save
  during normal operation instead of only during suspend/resume
- 0004: Use existing enable_save[] instead of reading enable registers before workaround
- 0004: Return iso_mask from cp100_isolate_pending_irq to use in restore logic
- 0004: Skip writing enable masks that haven't changed during isolation
- 0004: Skip restoring enable masks that haven't changed after claim
- 0004: Skip checking groups with no enabled interrupts in cp100_isolate_pending_irq
- 0004: Updated commit message to clarify dependency on enable_save optimization

Changes in v5:
- 0004: Added brackets around conditional in cp100_isolate_pending_irq (feedback from Thomas Gleixner)
- 0004: Reordered variables in reverse fir tree order in cp100_get_hwirq (feedback from Thomas Gleixner)
- 0004: Replaced raw_spin_lock/unlock with guard(raw_spinlock) (feedback from Thomas Gleixner)
- 0004: Added newline between variable declaration and code in plic_probe (feedback from Thomas Gleixner)
- 0004: Extended generic_handle_domain_irq call to single line (feedback from Thomas Gleixner)

Changes in v4:
- 0002: Simplified commit message to focus on hardware bug (feedback from Conor Dooley)
- 0002: Added Conor's Acked-by
- 0004: Renamed PLIC_QUIRK_CLAIM_REGISTER to PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM
  to be more specific (feedback from Samuel Holland)
- 0004: Added Samuel's Acked-by

Changes in v3:
- 0002: Updated commit message to clarify that DP1000 is an SoC and CP100
  is a core (feedback from Conor Dooley)
- 0004: Renamed dp1000_* functions to cp100_* and updated commit message to
  clarify the hardware bug is in the UR-CP100 core implementation, not
  specific to the DP1000 SoC
- 0004: Moved quirk check out of hot interrupt path by creating separate
  plic_handle_irq_cp100() function and selecting handler at probe time
- 0004: Use existing handler->enable_save[] array instead of stack allocation
- 0004: Use readl_relaxed()/writel_relaxed() for better performance

Changes in v2:
- 0002: Changed compatible string pattern to SoC+core: ultrarisc,dp1000-plic
  with ultrarisc,cp100-plic fallback (suggested by Krzysztof and Vivian)
- 0004: Driver now matches on ultrarisc,cp100-plic (core) instead of dp1000 (SoC)
- All patches: Added submitter Signed-off-by to complete DCO chain

 .../sifive,plic-1.0.0.yaml                    |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/irqchip/irq-sifive-plic.c             | 126 +++++++++++++++++--
 3 files changed, 118 insertions(+), 10 deletions(-)

--
2.51.0


