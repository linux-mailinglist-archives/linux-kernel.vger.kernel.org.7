Return-Path: <linux-kernel+bounces-799643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A85B42E72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6F23B8ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CDB195808;
	Thu,  4 Sep 2025 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na7ElSWr"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2110E0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947156; cv=none; b=E2qM7jTXH3iW/yIMBXANiBQBtV9DuGpS8hF4zqqa7NJXm8Hu6ybTd+PRq0jADC6LdWBcx+1o3xblP1/g5232vyFc5gcFATGxp7SLqNHHUJzUY/oIz49GoEHT7ZFTQK71IvryjUkO3rlRdC2+FUh1UGpIyrsoqe9Kj7bY+34Y/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947156; c=relaxed/simple;
	bh=5XTNI3/h4KK5yNSwQImI1zXfOQGhg/dLep2vpEXezHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfCKgFhm6kSx/K+jomfRsA+aIbhXrYipBmh4yX5nsYlXW/y9M79xdF5Da+TJyXZlMyV2UXVNEBHI55Bljyf7Q89PleD2v/v4c+oCULXYVkj7ziq2XBZ9ZFokjQc3myi2QPwHk2sttkAOj4WJ94MbjZv7yHHJZcRngbiAjrssJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na7ElSWr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso415988b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756947154; x=1757551954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlzHm3Kh9CNZ+/mVoBH+InGWftCSKC7MyW//Z6cIkFM=;
        b=na7ElSWrDRpSpStI2Wsqkx2wszKpIXBXhT1rZvjyesuDGN+DoUna9OSNKON0Nl9u3a
         W1AT5J8myrZBq3b7zmunsDc+k5bXOCMV5b2MLJko0Ktdp4EPfdUmucG72uUl2+mfX7xD
         jgdKv/0uaPtyYUH9PezVGLm56NVu5a/IbMnXX+MU+4MdLTl+VP1rM+MXQxkBUL4RorGO
         3oPZP6Soqws9ETI9NwvgCD+u9yGtSyfl976+82yQRScUZid1m2d1+vMD8U4Cuf19K3oq
         d9kFmzK952ZPb5AtzcCwIYNUygDRBQkJ/8HQRaX8C++5lSzIHQz5CKxxszTVq/f1uaxq
         5ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947154; x=1757551954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlzHm3Kh9CNZ+/mVoBH+InGWftCSKC7MyW//Z6cIkFM=;
        b=orznk840PRV450cS0kdCwElKZ+o2EelPh9oT86x8z2E0WqGeG5xeFW2iGkdSvB4NYX
         uLk3m6WkCikSf6edsfstQTdZvNjFibCaujBf4MG4bj34FEZafvKoBHcwsn7oxz9LCRDB
         6n0ekZ0jJjcHwvgpGGcAi22zHyxjEcKukeXRlCsJFQeduFadRfKkvMDR3Mpv+YWvcAfS
         8kHNbBtCMbKHKD2xdPCEgDMU2c4DFcpQPFLtsIYdW0SYIMQT/xEHP8EsB1jwDMQzHY7f
         TvL0SpmHRKWjiQ8160kqWSf0McQd6MaGS4+fte2crpWRZRxC7c4H+WU4/85qDvjVTEQY
         naxA==
X-Forwarded-Encrypted: i=1; AJvYcCU1lL35UYSBM9rYqG2mWDZUzCRw843VUBPQ5np8LX1nJTQKtMqQmsGEOuKcZor/ICX2yjcotduhtAMzKHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8oZVOOtz0sXK3HL/4gHlIzPijUdcR3NKSZ3Mz1J07IxFKOAb
	//BxnEcCF2n5KWjlB1SblTs1BkM0Lxe84srPlmJd/goNst4J1AGIeqtP
X-Gm-Gg: ASbGncvLNy9Fo2X/BtyIcwBAEqrPhz2busz6QUcvvjLbCTeIWEGuXTeHP0eEjbaQgBl
	5IpuD+tfe00yWQjjmrBef8JcfBGwp9t3K1L2KBI7HFNRq7pNTg7Bsro2VxXwofqvgESPHamjoRW
	Y0AvOFBdq3HupvxBBKOPxy0G8e0Rys25swhJnYPORPqqeHxL+EOGCwTNC1rQZ3+tEeM59hzxq07
	UkfG8Itwb7IB+bNaxXfJ31TxmpBbYw+mB1Ee7b7JJF2FpJgfRxMUdwzChfEF4wC69jenZrPmUIZ
	FjtwSvJLxS+gNAwP+EwdDGYynqRSlLSIsu6t9zwIbQT6xy7UoClAxy7rgSyzILl6Hcztm5seX1l
	+SVOhPIy7OVbZ9G/29vtsGaydQcZTfLrpAYHAWqAirs4Wuyu0sp49ozFDo3Or
X-Google-Smtp-Source: AGHT+IESdzN7NSlqFScq8JWi82u0rrP72/Z26WNaGKK1m4GOUMXTi122NfAezDcYWcVvXHFHb7fKYQ==
X-Received: by 2002:a05:6a20:7484:b0:235:4a12:6adb with SMTP id adf61e73a8af0-243d6f04727mr24529715637.33.1756947154482;
        Wed, 03 Sep 2025 17:52:34 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:882:283c:10f0:c999])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28b3849sm15748931a12.31.2025.09.03.17.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:52:33 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 0/3] Type correctness cleanup for ARM64 MMU initialization
Date: Wed,  3 Sep 2025 17:52:06 -0700
Message-ID: <20250904005209.1494370-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello list,

This is a small series of type correctness and readability improvements for
ARM64's MMU initialization code. When I first encountered this code, the heavy
use of u64 to represent both virtual and physical addresses made it difficult
to understand where the demarcations were. I made most of the changes in this
series while troubleshooting a different problem (fixed in a separate patch) to
make that boundary a little clearer. I am submitting it now in the hopes that
this will improve maintainability and readability for others.

While nothing in this series represents a change in behavior, it is not merely
cosmetic: I believe these changes better align with the kernel's code
standards, type discipline, and common C idioms.

Happy Thursday,
Sam

Changes v1->v2:
- Correct an incorrect comment in map_fdt(), which is only called when the MMU
  has an idmap installed; it casts a static array to a physical address
  ("Stack is idmapped" -> "We're idmapped when called")

Sam Edwards (3):
  arm64: mm: Cast start/end markers to char *, not u64
  arm64: mm: Make map_fdt() return mapped pointer
  arm64: mm: Represent physical memory with phys_addr_t and
    resource_size_t

 arch/arm64/kernel/pi/map_kernel.c | 41 ++++++++++++++++---------------
 arch/arm64/kernel/pi/map_range.c  | 20 +++++++++------
 arch/arm64/kernel/pi/pi.h         |  9 ++++---
 arch/arm64/mm/init.c              |  6 ++---
 arch/arm64/mm/mmu.c               | 17 +++++++------
 5 files changed, 50 insertions(+), 43 deletions(-)

-- 
2.49.1


