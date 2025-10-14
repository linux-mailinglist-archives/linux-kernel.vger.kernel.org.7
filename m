Return-Path: <linux-kernel+bounces-853015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B7CBDA7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4E354497E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002DD3002DD;
	Tue, 14 Oct 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8GU3MLF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308B2D9ED9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456478; cv=none; b=OdaqOr0Mtm0l0NBcgghe5Ilfam7sc/GDWLYjy5cOHquIUuzpkqiJWFtQRNsM7IlcjRRpFn/7DD6irV6b+eRwcQXx2oyxsNn+xABMWaw2IwE7t5CiDCqrg2tb3cvGz6uuNmJR+3rhwiJImfPilBsoU1eGVMlarUZcW4MRZWrLGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456478; c=relaxed/simple;
	bh=pOuuayWNExUaEjiREKno3GIORZyip1/rQdst2hzkbMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOuSI/S/pylKXZNZDVc5QSRpIqoEethsyGkSh4SkYjNHNUWZshxFvudCYSmYXdtALCFJsNs2sqHPBxhg1lTaNjiN4QgR8IAKf1l4yMjMtEkPGgKTyx6RcGPBFIqT+Ik7dkooskCj3s9RtlRraGwLxmBYtTYkIphibcF2kQYVMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8GU3MLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760456475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xN6Ef1sp8hGiQor4Puf+nhx4w4uum6cowYv1M66MvxU=;
	b=J8GU3MLFRlxcPt2V20bcZQRmasGhg4jdJK+k7H/QNTV2KRgq/0yJ7M+MiDFc7Dc/Ser7Yn
	wOp7ExGeSj3d9xaMY7s4x+DLbNOPtz5nh4l46V0yrjbc5vtLCBIX4yAHSimdy5XB3C6Ufj
	gPGRajXeGcwbnagKCLaXzStVuyPBo8k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-3cV0MFsZPuyaHnTmHgjW7Q-1; Tue, 14 Oct 2025 11:41:14 -0400
X-MC-Unique: 3cV0MFsZPuyaHnTmHgjW7Q-1
X-Mimecast-MFC-AGG-ID: 3cV0MFsZPuyaHnTmHgjW7Q_1760456473
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so487017066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456473; x=1761061273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xN6Ef1sp8hGiQor4Puf+nhx4w4uum6cowYv1M66MvxU=;
        b=ai+AtcnIYhf2SHHkBY1sWjKEK9TWARmp85gfEVyCIbMxXEZGwUdhxsLMUKb3FMxDhV
         vJDpCNJL89IxgnxjURuzkxW+u8XdNFSToTe1P82n0zB2p98TlqB3Hz2w8ZxD5UBfr9AK
         Y3XVqBsoubr+OyrcdG4TYwtLDrfv2DNvdzuCCyFeUTZG1TQRC67dmNDSRVlpsVGdoagy
         JqA0wCPuM+dcAT/OPr531uiwDstrGDip9zquTd0B7QiQe1wUUf5QDUsuVhyv10hTLqAS
         +oGFVTQk7r0lJw2gckpOhqQQopdf48z+ZEq6gf8NxuXwh4V0uXSARl4nHvl9tEMa6pqf
         l+uw==
X-Gm-Message-State: AOJu0YwhsG+oVdMbDuAegDWuFLHgS1jPddnp5Zaqo2RvId1YtE9hHDuA
	kNRoLYFL+451kTMZ7N4vVsSizL/F8lk2e7469vl4Uc5jeIhezeiiFWF9jkjuWug86Re6/WaX8sf
	UlV1czRSFw/bNfzQ+doxNYUHZbZdIJ4k6PUPTye/ET3GZnUtA6ZfAezIBoCpWCsPNZNlNlwMxhC
	GHbml6qIRMAq0rz7ku1RVDYQ3jTQm6vN9lC8Eyjvtsfh4DNaq0duHTqnQ=
X-Gm-Gg: ASbGnctonN7QQmPQqHl0re0rh/XH2MnOrQWTTtAQ8ZGB1nlDEqEfTBHkKBDfLVTlirF
	HV+VV8gl9kH1r/nuV6mDnfH9wnvJCXM4hl7NEgnRxti/DKJWGZ370g9FJ6pLN3iy8IosInYILSJ
	nDNPzdIXy2kA8a/5MvzUQpmaTOlOQHAFcqdev6JKLtasno+rKnApWjk+kPP3n/LRoWshpmFANAH
	armtcizQAOLK4WUGuTJ9TsCV9FSlfrEs7qAgfcyxpMBzG24SzV4AaXUqkADuMndlOVP41POt0R9
	atRlRoZf8BEMk5luBFWwoBepQDUctUDcKU5Q/xBLZYnC2Arx1w==
X-Received: by 2002:a17:906:ee85:b0:b4e:f7cc:6346 with SMTP id a640c23a62f3a-b50aa08f852mr2493216466b.15.1760456472726;
        Tue, 14 Oct 2025 08:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7MKAgrKXHfanZDhLxk8qbmij1H4ExOUqyMqzBv4euyBsK4QKZM6PUBQShnN55eCek+WQ0jw==
X-Received: by 2002:a17:906:ee85:b0:b4e:f7cc:6346 with SMTP id a640c23a62f3a-b50aa08f852mr2493212866b.15.1760456472247;
        Tue, 14 Oct 2025 08:41:12 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba45b3cbsm7897866b.40.2025.10.14.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:41:11 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Add UltraRISC DP1000 PLIC support
Date: Tue, 14 Oct 2025 16:40:54 +0100
Message-ID: <20251014154100.168236-1-lzampier@redhat.com>
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


