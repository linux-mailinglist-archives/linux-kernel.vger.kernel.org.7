Return-Path: <linux-kernel+bounces-761133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85892B1F4CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63960189ED73
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F5277031;
	Sat,  9 Aug 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="EvpGBCHd"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4024166E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747520; cv=none; b=cpAiVM7OJvEBXntTq9lLy8u/HmBdP/1gSGwuAhBtOG/HVi8rgZnrSgR3XGgqUhs3TM2sVHT29fr8fvIOvEC8V0oqhkojdq23X9luXmMaTiuS4EBjhy7X/9rCAWWx2HkQKOkFXbUcZnFfibLiNpFFtv+KKkMa6kYTwyxZBCe/3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747520; c=relaxed/simple;
	bh=tjyqMDsgDi7/+p9JXVyraldUe4Vb3gfBUInuu8Tjjwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1mDUm16oNehxkvaSft+tuzdoSpzgcdlVYVhY0VD23M/IdqhMz1b9z6uOlafw618nY9xk/vBlYLdaQ3PJtXcnL9hd32EJnsRUv0BAjvUfBoqjBFMzONA/cBpvWSxazLdXgkomEO9mwDuf1b0WUK1PLQfPvj8CS2NcGXNh0JlIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=EvpGBCHd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso3963523b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1754747517; x=1755352317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jFMFOpY04n7pfsjOLDYFeb6qmDpqp5aExAGmAsyPClc=;
        b=EvpGBCHdr6Tyr0yM8WuDiz3JwGPpXKdNFm8+sm5Wky+G0Mir0O/LTLFEm1PpF0oHtu
         91ikmHaZi0XHHd0c3r3oIxw0jMT3PyqBkGpoWdcENfHaNWThyGEp/WVkBl6KtZzqJiYx
         +II73la7CVtc/2b6NWngG2EpUG10ICurKN+XIc0HvVJLtfvhJJuXkqY5OgfrV9Uk/Knh
         jdrMkPVoLfMBOtrTSz3nnH5h4ZYvrW6GO2BopDvP55RBdSQvdElxAOYRkfpzTHHqQcuf
         SJ41oqp10DT2dJ6aYlzdXoU8wpRvqWVdvkQ+I7qFBdM45TcdRw4VHd+zmRWMWSvqzzpQ
         vc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754747517; x=1755352317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFMFOpY04n7pfsjOLDYFeb6qmDpqp5aExAGmAsyPClc=;
        b=Op9asXMV296cMTTgh9zKm0Mo1RDVvtOGb1IoYlYjWIgZsc/NvIRWA6ldHUVLWrR/4I
         CkH9lv7BM4fFvYi5BfJG8eLSlMFq/oCRrMJePsSRWNsxHrUuS8rQXGcPhQhw0v5wR6wo
         CSo5DxzN60Uzxp01AH9eHL+hrFVqvHvF8YcCKw+uFveHHc0Wg7+POO8ouRPbDxzn8gVo
         45SdsWEXD4L+HtpTw16jp/8FdH5b4miDwSD2o+71UncyKmbciU441sJTafNDEsrIX7nO
         nTChZOXBhHzV5Ucl6zP4R0+O/ptxy+Ixh0D11JSU9kjFm83XygBBwbHx1j+yMKlGNH4J
         AOqw==
X-Forwarded-Encrypted: i=1; AJvYcCXNsV/4S5/MKFPYI6F0usWpCFjvqVwTCIbsJlPKAX8pkPH1hINRd7p5JJ0dV37HNujzXmtHDSuulGVYgnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFfPV9zkTd5qxyQJgwv5EML8d8cqBvf7IswQDXFYkf6V0Jaqb
	8ilJ/YTEB1/6iphvp1yZubPxShyJUX/cRmh9jwxUu4JFxcNCCYxRguGOJqZsJXBTqqWoMMambnM
	+3nrDS1hIEM5GpMPn11OCp/txmEN01Cd+YoLz13/iS0iyhKzYoIcrmxSK1r0=
X-Gm-Gg: ASbGnctURMWxgqXM/iq0a4IM/TVuh8e0tRGn60rFRQUPE8R9CEfz/FyeB3mDKZBtfHd
	uEqDS8VqenFLjvg2DYg4el/dVJWmMNketrQag0ZrY/Lyyb53yrScdHezs1+aS0c337kZ2PDbj/v
	IDJRRb9JSfai9YdRRdidj791F8fkJy7Y1wKXxhIjm5zpLYVwjtPGcoBZ4W+xHOjOWOvmVGv3HrE
	xH1HmshM4zStC9f4kCajYGOQpeCLOEa7h046sM5yWdClmOsj7SJJ+2Rxq4k2Gfj0K/htLmv+gml
	MLlnLXwco+Fn9ho4+gYemmXBNsTB0e6eILlK4OdP+dZx+nDKqDRs+hzm3Y0B6ShwGHQwL3t0cvD
	4Aewltjwjqu9/A4NB0QmGYnk2NWbKyu/hBXh9l9ohYXzzpL3zlq5yIikHGfKFdptZkg==
X-Google-Smtp-Source: AGHT+IEeNgCRS6Ls8b+R2Cf86RDBC5tmWlbLAIMn2W5koGX7pj8yLDZ046+xiBALeYUwG2HzAegNfg==
X-Received: by 2002:a05:6a21:6d94:b0:240:1bdb:bed2 with SMTP id adf61e73a8af0-240551be2a1mr10707896637.32.1754747516856;
        Sat, 09 Aug 2025 06:51:56 -0700 (PDT)
Received: from zenbook (1-162-100-9.dynamic-ip.hinet.net. [1.162.100.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa10sm22538342b3a.52.2025.08.09.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 06:51:56 -0700 (PDT)
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] KVM: arm64: ptdump: Don't test PTE_VALID alongside other attributes
Date: Sat,  9 Aug 2025 21:53:56 +0800
Message-ID: <20250809135356.1003520-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0

The attribute masks and test values in the ptdump code are meant for
individual attributes, however for stage-2 ptdump we included PTE_VALID
while testing for R, W, X, and AF. This led to some confusion and the
flipped output for the executable attribute.

Remove PTE_VALID from all attribute masks and values so that each test
matches only the relevant bits.

Additionally, the executable attribute printing is updated to align with
stage-1 ptdump, printing "NX" for non-executable regions and "x " for
executable ones.

Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---
Tested on QEMU.

Changes in v2, thanks to those listed in the Suggested-by tags:
  - remove PTE_VALID from .mask and .val
  - make executable attribute output format identical to stage-1 ptdump
  - Link to v1: https://lore.kernel.org/kvmarm/20250802104021.3076621-1-r09922117@csie.ntu.edu.tw/
---
 arch/arm64/kvm/ptdump.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 098416d7e5c25..dc5acfb00af91 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -32,23 +32,23 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
 		.set	= " ",
 		.clear	= "F",
 	}, {
-		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
-		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
 		.set	= "R",
 		.clear	= " ",
 	}, {
-		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
-		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
 		.set	= "W",
 		.clear	= " ",
 	}, {
-		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
-		.val	= PTE_VALID,
-		.set	= " ",
-		.clear	= "X",
+		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.set	= "NX",
+		.clear	= "x ",
 	}, {
-		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
-		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
 		.set	= "AF",
 		.clear	= "  ",
 	}, {
-- 
2.50.1


