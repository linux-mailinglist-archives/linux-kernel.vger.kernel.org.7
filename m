Return-Path: <linux-kernel+bounces-753477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1042CB18388
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C7F5837CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DF25C833;
	Fri,  1 Aug 2025 14:17:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19914F125
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057874; cv=none; b=k0MkN/HRlLnVgysZphKPB2I3N7unp5AWyWIQdyDWYC5Ush4LGeHJoCMWwr50ZH0RyFBi3h0pybbzZtcOJ9BxkbKzMxToAVlo3ctOe/oSJKpQrFSQxMFICOuIrFHIDj0nagTstktha20rV4D8vUBFNFF/mfbpSXnWTANUdM7EUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057874; c=relaxed/simple;
	bh=ig8Ck3SfCH2BcN0AVXhy6BfHt/GRT4cxu3on8MCRK9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zj0EPIkBPbRIP80GJza8VXP9Kn7P5iJLB7QQYsAs4tXECUaFrYSjuTRjRLW3oCLG4h8AovARYzJjZTzSOzTay1DU8lPK3wpXzgtnfKy71trlX1KJQdkiVVk16AnQEYxFGitVkQvqxmvftdn/zlI7e/P8yD/dScWt0yoHCH/rmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 286821515;
	Fri,  1 Aug 2025 07:17:44 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EE1A3F673;
	Fri,  1 Aug 2025 07:17:49 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCH 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Date: Fri,  1 Aug 2025 15:17:38 +0100
Message-Id: <20250801141741.355059-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() currently allows accessing struct rq fields without
holding the associated rq.
It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
scx_tickless. Fortunately it is only ever used to fetch rq->curr.
So provide an alternative scx_bpf_remote_curr() that doesn't expose
struct rq and harden scx_bpf_cpu_rq() by ensuring we hold the rq lock.

This also simplifies scx code from:

rq = scx_bpf_cpu_rq(cpu);
if (!rq)
	return;
p = rq->curr
if (!p)
	return;
/* ... Do something with p */

into:

p = scx_bpf_remote_curr(cpu);
if (!p)
	return;
/* ... Do something with p */


Patch 1 was previously submitted and can be applied independently of
the other two.
https://lore.kernel.org/lkml/43a9cbdc-5121-4dc8-8438-0f01c90a4687@arm.com/
https://lore.kernel.org/lkml/0b8111c6-1b14-41dc-a674-14a6361992b3@arm.com/

Christian Loehle (3):
  sched_ext: Mark scx_bpf_cpu_rq as NULL returnable
  sched_ext: Provide scx_bpf_remote_curr()
  sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()

 kernel/sched/ext.c                       | 21 ++++++++++++++++++---
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

--
2.34.1


