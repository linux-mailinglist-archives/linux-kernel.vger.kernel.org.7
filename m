Return-Path: <linux-kernel+bounces-792019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91E2B3BF88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F198566C97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E87326D60;
	Fri, 29 Aug 2025 15:35:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942719D8A8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481727; cv=none; b=jRMC+4uVy2peDQ2nzJBVPAn9tM4T3kta5qBnDhjv5Op7he5EmjZjSOO75YZABNl5Cr8eWXazWAgElcPNcO/XAtA/9xnrO19e70moI2rU/EHngkyW8sw+ewBWN8kb0fkWrr5Pu45huqkJsUTVpVnuZlrWo57kIAOFJTQPunv37w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481727; c=relaxed/simple;
	bh=mZaVzM4Fjeh0IbdAfwt6Fmy1k9bU4ewIJyPGwuc7H4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jv+ka3cbuk2jH0PhEnxOzPgdYjXgA2Igqpe+vfZtyVxkyoBgR1Gsr75iw/ZVFBsWWyT/QRZNLwVu9M4xJRLuSMcv3RJLIZaYUABps81ia5CakLRXi+YB3xGb62bwuef4FL8BgXMa829xD75xRce06Nh03Ew3HJW9RLOvBG1lliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C958719F0;
	Fri, 29 Aug 2025 08:35:15 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0483D3F738;
	Fri, 29 Aug 2025 08:35:22 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active on local CPU
Date: Fri, 29 Aug 2025 16:35:06 +0100
Message-ID: <20250829153510.2401161-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This is an RFC for my implementation of an idea from James Morse to avoid
broadcasting TBLIs to remote CPUs if it can be proven that no remote CPU could
have ever observed the pgtable entry for the TLB entry that is being
invalidated. It turns out that x86 does something similar in principle.

The primary feedback I'm looking for is; is this actually correct and safe?
James and I both believe it to be, but it would be useful to get further
validation.

Beyond that, the next question is; does it actually improve performance?
stress-ng's --tlb-shootdown stressor suggests yes; as concurrency increases, we
do a much better job of sustaining the overall number of "tlb shootdowns per
second" after the change:

+------------+--------------------------+--------------------------+--------------------------+
|            |     Baseline (v6.15)     |        tlbi local        |        Improvement       |
+------------+-------------+------------+-------------+------------+-------------+------------+
| nr_threads |     ops/sec |    ops/sec |     ops/sec |    ops/sec |     ops/sec |    ops/sec |
|            | (real time) | (cpu time) | (real time) | (cpu time) | (real time) | (cpu time) |
+------------+-------------+------------+-------------+------------+-------------+------------+
|          1 |        9109 |       2573 |        8903 |       3653 |         -2% |        42% |
|          4 |        8115 |       1299 |        9892 |       1059 |         22% |       -18% |
|          8 |        5119 |        477 |       11854 |       1265 |        132% |       165% |
|         16 |        4796 |        286 |       14176 |        821 |        196% |       187% |
|         32 |        1593 |         38 |       15328 |        474 |        862% |      1147% |
|         64 |        1486 |         19 |        8096 |        131 |        445% |       589% |
|        128 |        1315 |         16 |        8257 |        145 |        528% |       806% |
+------------+-------------+------------+-------------+------------+-------------+------------+

But looking at real-world benchmarks, I haven't yet found anything where it
makes a huge difference; When compiling the kernel, it reduces kernel time by
~2.2%, but overall wall time remains the same. I'd be interested in any
suggestions for workloads where this might prove valuable.

All mm selftests have been run and no regressions are observed. Applies on
v6.17-rc3.

Thanks,
Ryan


Ryan Roberts (2):
  arm64: tlbflush: Move invocation of __flush_tlb_range_op() to a macro
  arm64: tlbflush: Don't broadcast if mm was only active on local cpu

 arch/arm64/include/asm/mmu.h         |  12 +++
 arch/arm64/include/asm/mmu_context.h |   2 +
 arch/arm64/include/asm/tlbflush.h    | 116 ++++++++++++++++++++++++---
 arch/arm64/mm/context.c              |  30 ++++++-
 4 files changed, 145 insertions(+), 15 deletions(-)

--
2.43.0


