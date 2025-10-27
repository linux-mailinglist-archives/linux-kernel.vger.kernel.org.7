Return-Path: <linux-kernel+bounces-871692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449BC0E16A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9CD18869A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DCC261574;
	Mon, 27 Oct 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FXBlTFkx"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB7253340
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572088; cv=none; b=Vu3JzZuKYr+BYtTQuZAV50BlYGrIXZ/EKDVzdt3zIKK7y1POIKOMljJMjooy4BPCj75P4hP6WPmt1aZk3OnBIzry5N00XsjbmKAQ1DodocrZH32z81kd9iZ6rv8r9G8kBdaC+wwZ+wWResYqhrH5zUJ8gff0VuhsToPQLSxx0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572088; c=relaxed/simple;
	bh=dBeKk1/idDQw0wDoERycwQ2Fq+supEkRK3SBPCdRMJw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=moSXQss44wv+XwyrPzlFwiERCBRoMD3TF11Lg3NVOJR2pHMeKBY7s7NlDCn5XViC0PyN+po9GxH4wZ6WiNj4kHm4cLychtinX6U0u2xNmHWc0HU4AZftZ1qtlokljr3PxwAJ02A606aOaEuoqAloyzAbekoI9FiTEACYfXxAu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FXBlTFkx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3856668a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761572085; x=1762176885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftlerGiLvsqHMKW12Y2m8WjwJauqRh5+By8P2iMxPlE=;
        b=FXBlTFkx2+g+rudCBCMcWp/2tLkqODxx1A4n6QC6byI0EWADXP1oVkrJ5nI9yXlype
         yl2FDIuehpjrEjrs3VPmvoS00pVT70mE+A61oOMPUWOmoXbsnLv2gXqSpEhXMGSDUElP
         T/jkC05I4qmGlSP9DzQbfnF5eSPhDAUYb1o6yXIBkiFXKkgIkWjYpckswMTYmb0dnE5f
         Zc3SUbNIHSKQUfOcaozicoGm31RvPGPM7gYQNuNjmwNmKXVR9WsJgAuDvqXehxAxDrHD
         QYoPvRaI7Mj8LdmBEEKDJURc3alrBaSdFv+uD/PizRIUnJ4R5Ve3QHw2xL8ZJdBhrPjS
         nS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572085; x=1762176885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftlerGiLvsqHMKW12Y2m8WjwJauqRh5+By8P2iMxPlE=;
        b=U1o9o6UMOjFvSpV5W2nuuWipo4IIK2W0gabZn3hjhsrFM5HDTZNwXzoCnxI1LVB+Rg
         UO0F7HmvO4WVAJB30J2OvaxAzQ/F/dKR23a7VBIYOiS/y1nRPkSwiqZSq9PfDqt7EPOd
         pI/MX+t0XNxSz8qq5Vp5rb2MtVEi1VYgIlsqopk5163coxm70geoq/L74BuuG2CiWcbr
         CdC92lJdZz/HeholPv9ZSoHxS38ZQr3b/gYO/hOQI5LBZP8khj4KItRI9LtLhTOvoZwH
         gV6UDIJsDvp/K/nurlJPPMkp9HwWW7dZaDZoaZc3e+PGomPcC1/dqKEIXj4tvyinIgUr
         shjA==
X-Forwarded-Encrypted: i=1; AJvYcCUaFu2f1P/qziiEyIiyGa9Fo5IizT/twxKIvutbsS+Mpi+MKwp2w3uTGMzBwCwXLN427KlGIET1wEF7iSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYGUD4uFiEnEM6zdNZfeL0+HrLvN/Cf0eN9azg1DKGmpDn1sq
	cqhGu+Dgo2w4zIm9hrUzTSW0el0n1c/OQzs9K/MpfYXaVLYZ5E6KSkEyI74De2P6ho4=
X-Gm-Gg: ASbGncsFQoa/hE2nhU9EQ4WRSFGVndhgxLkdBVBWoPCiSnlcJ5MWDj9LHepUAusY6d3
	Jww4ZLbfsa9nN0SR5Ttyufej+8M7G9W8WFoxLagmm6GP9i1K9YvGX/hd4aqX8oEsTCiMavQTw7K
	JGq6p3imLAVPqGp6qUAgqmhwyDE4l2hi0lSyAgsFdUE+IPz4ILDco71XJ/gGXl6I1ACZRGvJ/tv
	2qxSyP/LjqsiosHeG8mUz7atn+YEosXPU/MeBay0Y27pWLzWVP2Nbn0TGZsew5PFjFUmvA2IBlA
	4lAZrCD1Oy+13hkBtxLoTjzoMSWjwDJNhEGCrSxiWVg7U3/Vv9pMjg+D8KS4chCAW6ZrEBP22Vd
	PKl2rQEI/UA4ng68ZKUvMtHy3f6xowjCep0xzE3PJJHW3zNLl7HXzBbNSCG7feoQHCozSGSsNJo
	A8syYSR94vZaeE9lzvNUW8do3/lVCYBESXHAbPcGDQ3zus
X-Google-Smtp-Source: AGHT+IG6w1KMqpMxHVYtcXLWfWv6qAK46PDDTGlJxfBJd5VbTvHc1tDB2FJNJAj6MmKM6UQUhJNb1w==
X-Received: by 2002:a17:903:19e5:b0:24e:593b:d107 with SMTP id d9443c01a7336-290caf85236mr459702545ad.32.1761572085156;
        Mon, 27 Oct 2025 06:34:45 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42558sm82144935ad.69.2025.10.27.06.34.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 06:34:44 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor@kernel.org,
	cuiyunhui@bytedance.com,
	luxu.kernel@bytedance.com,
	atishp@rivosinc.com,
	cleger@rivosinc.com,
	ajones@ventanamicro.com,
	apatel@ventanamicro.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	songshuaishuai@tinylab.org,
	bjorn@rivosinc.com,
	charlie@rivosinc.com,
	masahiroy@kernel.org,
	valentina.fernandezalanis@microchip.com,
	jassisinghbrar@gmail.com,
	conor.dooley@microchip.com
Subject: [PATCH 0/3] Add NMI Support to RISC-V via SSE
Date: Mon, 27 Oct 2025 21:34:28 +0800
Message-Id: <20251027133431.15321-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We thank Clément Léger (Rivos Inc.) for his foundational SSE
work ([1]), upon which this patch series builds. This series adds
NMI support to RISC-V via SSE, with two key focuses:
1. A PR to the RISC-V SBI spec ([2]) for unknown NMI handling, with
matching Linux kernel changes.
2. Extending NMI usage to all system scenarios where it boosts
robustness—e.g., stopping CPUs during crashes.

[1] https://lore.kernel.org/all/20250908181717.1997461-1-cleger@rivosinc.com/
[2] https://github.com/riscv-non-isa/riscv-sbi-doc/pull/223

Yunhui Cui (3):
  drivers: firmware: riscv: add SSE NMI support
  riscv: crash: move IPI crash handling logic to crash.c
  riscv: crash: use NMI to stop the CPU

 MAINTAINERS                      |   7 ++
 arch/riscv/include/asm/crash.h   |  17 ++++
 arch/riscv/include/asm/sbi.h     |   2 +
 arch/riscv/include/asm/smp.h     |  14 +++
 arch/riscv/kernel/Makefile       |   2 +-
 arch/riscv/kernel/crash.c        | 111 +++++++++++++++++++++++
 arch/riscv/kernel/smp.c          |  99 +-------------------
 drivers/firmware/riscv/Kconfig   |  10 +++
 drivers/firmware/riscv/Makefile  |   1 +
 drivers/firmware/riscv/sse_nmi.c | 150 +++++++++++++++++++++++++++++++
 include/linux/sse_nmi.h          |   8 ++
 11 files changed, 323 insertions(+), 98 deletions(-)
 create mode 100644 arch/riscv/include/asm/crash.h
 create mode 100644 arch/riscv/kernel/crash.c
 create mode 100644 drivers/firmware/riscv/sse_nmi.c
 create mode 100644 include/linux/sse_nmi.h

-- 
2.39.5


