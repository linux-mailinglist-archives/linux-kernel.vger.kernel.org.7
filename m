Return-Path: <linux-kernel+bounces-867133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D3C019DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616AC19A4DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D3632D42E;
	Thu, 23 Oct 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSFnWetu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE832ABC0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228078; cv=none; b=SrAWwTUnQJEE+0XrYCknh/x2efJq0Zz0KSZjiAKTUZJYBvBrSPrpeulB6AwtjH5QEyRcv4yBEW0ZWzWsWiOjU8PyzKAvQbnyg8kMsalrOwp7zEN/AYb8doQQvP7nkrq9Gofacb0N0uhGAhRn/nOX7RNQfk0doJM//bYBtGxF4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228078; c=relaxed/simple;
	bh=2Chy+VwbCxMqclySUz0ufs6zXs5jzdETPAGPGMs0Wf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaTzA/W7Bz55PNZ0sMb8vfmbBn5tYLmKS40VBKPSizpVxEuSs7wEu88GipA42UDCkbI6ArKhqRvZDwLui28PQWcK8laflWl78y6ykxTk/oJrMCbD5gnLOlXiwaKuufh+KQ4aYTVFg/vGV9V8Jhn8SUsALZWC/4Bk7NIBmOdhWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSFnWetu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761228075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6IP4CrvhUC+N+aJ86duEZEGJ5HwVmI6olhQdQ4mkTgo=;
	b=SSFnWetuSpWJ4NIgvYybc32pXnN5Vvj/jMPdR/dRdLJWmmXUUPspRkrQGVAf9ta+wuY3Jv
	OVqgBn3yMGcV+gF++MiUrTJZqFK0FejQRC+m+T4jupk/u3M5XhBPjQRwAiqgG8DqFFk2BM
	yylDe1a58NgIDPtlL72d+ucWPcsZMuY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-pQ-iHVYNN1m5SpxHrRlJ9w-1; Thu, 23 Oct 2025 10:01:12 -0400
X-MC-Unique: pQ-iHVYNN1m5SpxHrRlJ9w-1
X-Mimecast-MFC-AGG-ID: pQ-iHVYNN1m5SpxHrRlJ9w_1761228070
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-472ce95ed1dso5702895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228070; x=1761832870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IP4CrvhUC+N+aJ86duEZEGJ5HwVmI6olhQdQ4mkTgo=;
        b=qf8cup+tMYHqy4UFPab4uSJ8J6JNajmJXgR9sOcAwZyHypl12yqKwHmmzp6KauYh7X
         vyFu/MeF27MsQb//1ZnbCIhXy6rPge4rrOUFFXU9wdU8FEuc6QPZPoSTsaPiihmt/Sik
         RFQaM9oHbytwkmD4UMXq+riE/92ziOgvj7amQaO2/y9fWbjZH2HNozMkNM0rMtT7Ohtm
         cXhegsnYTu/e3GujHEXaiYXqnumTJpsSTNwmZ181MyUXVQh2s4qdbQcURHu+ee20e5G0
         Ky4TAwr/YZB9cb2FJ4arNmpaIq5N6SNPRF6Uaz63qakQgLYrvgq0KliOhhQsmwsgCraM
         T/Cg==
X-Gm-Message-State: AOJu0Ywqu68W+nQuKtsq3PvnAyr7BW48RKf4wOrT3irgAxpInRoeVX4o
	cUcKrn35Im3MiFaPazG9jQRdkQ2fKzn0M+C3+Vip+5bqi1Tx83EUlqHV8wJNIeshfNW7eKEmFVt
	/FakLXP+ywwBgWfou3fk0KW/ONIDnSIxgZzGgTGgIt2+AU79f4e2TJd0ghF/mloRSsqQeaJjkiD
	Esq9JJq8v5cercKXhC5NaWt5C2hqIlwOkF+S2xyAyzy4mFt2oGdDAi
X-Gm-Gg: ASbGncvolICbWwpvWtCMDtJlLBDDc47D4cn8CPZ2VZEUCIM0kZcevwbORllYs16hSSO
	o8x6m66pc1NxQTFzj9Rd2BfauX9cmP/yHKgq0xlezOBB7BTvuLS8qI2LXTrhMcKEy6ZyoJ/84OW
	UXDAHJMkZ2wbmWTh+529HxEg74ISpmZLe5NOP0zphtQ40dKtz+ewXIhGiTHs/J5SSJ4lJGne9vR
	z8sEgoLCEQHhOiRNBhtxtlr1DIXUSM/WQWd7yC8UzIMcYvgIVbIdRfYXONmhlg+0GyTXoe8+LoY
	UAfNKuGV/ShWMf02vMdg/prg1I4u1sJanUMwedTOuwvrUIEBZWsyb15bzgTzG/H26iU/z3nM8ot
	XMww=
X-Received: by 2002:a05:600c:5493:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-475cafcaee8mr17242435e9.17.1761228064941;
        Thu, 23 Oct 2025 07:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU9Vc6znRHA5p61MvlM1lauESPJdCT96hHFW7bW4s6ZjQp41JGsdZDFlOF51ydY6xFUR63lw==
X-Received: by 2002:a05:600c:5493:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-475cafcaee8mr17241025e9.17.1761228062893;
        Thu, 23 Oct 2025 07:01:02 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm4116154f8f.30.2025.10.23.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:01:02 -0700 (PDT)
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
Date: Thu, 23 Oct 2025 15:00:49 +0100
Message-ID: <20251023140057.204439-1-lzampier@redhat.com>
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


