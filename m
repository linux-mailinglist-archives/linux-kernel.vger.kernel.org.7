Return-Path: <linux-kernel+bounces-854670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241CCBDF157
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1AD480FED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE31EC01B;
	Wed, 15 Oct 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJj61mCL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF62848A7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538679; cv=none; b=efgNroNGRY0BYDI8rV98ilY0rxptAlOZAnU+E9wm7LhOeJb8aQI5CUEnbJsb1SqAltE54/S4q4mIFHNiTmf8uC6ZawM8Sdkr8wKhM3rer08YPre+6BjF6cLBJcBM6sx/DnrKlvuZJVYwUDPd2KxHY8TXfKYGaYxgssadrlbRVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538679; c=relaxed/simple;
	bh=ZDWsZO0VBNM+JKWzLoQH/nGF8tar0wIZvwPA84ypqx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FV4cFgYj3lp/g/Sd4+eDIjUrQvhndG4+2ji/HFfToy58sAPcdwBR2U4/90kYPFZogM4/TZKRARZvuu4ZULSZTSifKx2EndWyEWniyNxkB2rpV22LqveOoF8LHvrCMIIs6iwR1/AR9gDeOphlzVoYVqyu1tNuCsOT7i8dIlQSzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJj61mCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J5M2mmh4Ds9HKwtTLyTklITpPz82TYqRilJSnlAqd+M=;
	b=RJj61mCLxT2PT7CNAoquBN0aU3y1H/6t2FkvJ2yXaZmGnmM2OFTLC5iF3LQJLSIWNha/vD
	UOPLl3K0qutYAWgDgsbjTazxEfeqqjOVmYL6MXqU/LmRC38yGs2m0nIKcamanK1RGEXZfu
	Xz2kBE9Hc6+1UPV2OnGNC3R8Ql6gJ/I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-UNGW0TWpPZa4yNLYZjPQwg-1; Wed, 15 Oct 2025 10:31:16 -0400
X-MC-Unique: UNGW0TWpPZa4yNLYZjPQwg-1
X-Mimecast-MFC-AGG-ID: UNGW0TWpPZa4yNLYZjPQwg_1760538675
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426d2cd59e4so3977165f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538675; x=1761143475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5M2mmh4Ds9HKwtTLyTklITpPz82TYqRilJSnlAqd+M=;
        b=Oyps6PBXkm5RlV+8S8jb/+LsjhsOQu0bj4U0KPF4q9v8oi+MMljqJIl7OdMZpaZFpu
         J9lpOeA6nQcQBR+EpZW99ERPqq8H1KjBsBte0ZCTB5JxoKqB3kOfQt2nk0VqBnGM7C9t
         s5t8fAHbST4HeT2I8IQwr8FqCwHeyEKATeUrXyOj5wYuLQynd3tC3GS7s3NC9Yv24jC/
         F5C2Vny+icJznqOFDEqjXYEd91gAtVO/pjQfxmNvHa+j7ekcuRm12+24wc1B11/l2S0Z
         0my4IdLoN/7nezY28TWsiOOX5iStF23/DeRqnEZn+y7iIRYgv4rRPzSBH55q8g/Hw1un
         hmDg==
X-Gm-Message-State: AOJu0YxrknvU8Dk6c5nwxsT8f5ZSsni5R/Wrf1RUhDyrj56Xdim280FV
	FjfnuiLg78Qu+GWdSAAlFLKAMPyF6h/pSgiS1UB678PGg4X9G2YjqbkZ8vGiLUKgOnMjtR6+2qd
	bnffE0CQ5ZnBw2HhA3rADNReRRCiq45BP88oAJD1qbJ6CmJhwW3lO+xUPPWhlmN1P1jL4/IAJg4
	WfyFy8o2AjvjNSn9EeMXBxwwU3Rj+4//2g/wSmjq5d+QGsyaKUpmC4
X-Gm-Gg: ASbGncu9GzwMOGFkCUSwvW++rWM4Cx0KIUVxcz3UvYuEjv20WvZ3Q+mMbmxbKYyovx3
	FOcbfD7c8WYdcJy25hV9qrCJt1eY9i/yuD9oogXWScrrGVpNmhYNrz3Bu1jVbYI/80fAv+m7P6A
	MoErLnQHPmlqTB6tDf0WtwO3Qik/gg7xwqZ+3BS5rlI1EJbf1JXRAcnUcYCNWSMWHxxgADzC1U+
	Q0vn5ReNqbJPg1FrE259LppnzITNdizxeOYakcSyDoH0fM+R9/5WKjl4jxYGqEapS37nF4KdE98
	j0YGZqFriOPqvqTVl55pkkR70EW6xEwOQb12pYQ+EeRQICNcRDncix0=
X-Received: by 2002:a05:6000:608:b0:3ee:1125:fb6d with SMTP id ffacd0b85a97d-4266e7ced08mr14869607f8f.9.1760538674729;
        Wed, 15 Oct 2025 07:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmA242wjCu8aNX4QT+rftauK8lKZ1A4bt1SE1thTeCnke23rZ0LcaSiVmzhHvTvt87sNNPuw==
X-Received: by 2002:a05:6000:608:b0:3ee:1125:fb6d with SMTP id ffacd0b85a97d-4266e7ced08mr14869567f8f.9.1760538674014;
        Wed, 15 Oct 2025 07:31:14 -0700 (PDT)
Received: from holism.lzampier.com ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c02377sm32617005e9.6.2025.10.15.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:31:13 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Add UltraRISC DP1000 PLIC support
Date: Wed, 15 Oct 2025 15:31:04 +0100
Message-ID: <20251015143108.441291-1-lzampier@redhat.com>
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

Charles Mirabile (2):
  dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
  irqchip/plic: add support for UltraRISC DP1000 PLIC

Lucas Zampieri (1):
  dt-bindings: vendor-prefixes: add UltraRISC

Changes in v4:
- 0002: Simplified commit message to focus on hardware bug (feedback from Conor Dooley)
- 0002: Added Conor's Acked-by
- 0003: Renamed PLIC_QUIRK_CLAIM_REGISTER to PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM
  to be more specific (feedback from Samuel Holland)
- 0003: Added Samuel's Acked-by

Changes in v3:
- 0002: Updated commit message to clarify that DP1000 is an SoC and CP100
  is a core (feedback from Conor Dooley)
- 0003: Renamed dp1000_* functions to cp100_* and updated commit message to
  clarify the hardware bug is in the UR-CP100 core implementation, not
  specific to the DP1000 SoC
- 0003: Moved quirk check out of hot interrupt path by creating separate
  plic_handle_irq_cp100() function and selecting handler at probe time
- 0003: Use existing handler->enable_save[] array instead of stack allocation
- 0003: Use readl_relaxed()/writel_relaxed() for better performance

Changes in v2:
- 0002: Changed compatible string pattern to SoC+core: ultrarisc,dp1000-plic
  with ultrarisc,cp100-plic fallback (suggested by Krzysztof and Vivian)
- 0003: Driver now matches on ultrarisc,cp100-plic (core) instead of dp1000 (SoC)
- All patches: Added submitter Signed-off-by to complete DCO chain

 .../sifive,plic-1.0.0.yaml                    |  3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/irqchip/irq-sifive-plic.c             | 94 ++++++++++++++++++-
 3 files changed, 98 insertions(+), 1 deletion(-)

-- 
2.51.0


