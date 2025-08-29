Return-Path: <linux-kernel+bounces-792077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB0B3BFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1261886E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5C3431EF;
	Fri, 29 Aug 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b746JEi7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D4342CA7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482570; cv=none; b=KyvpV03uU7bOVjHBt3+6Zn433xvd0fPLLoUmCdytyuJaPaGpYl3iVSJWuHOhikO1i/+xllftsguTok8fOOgXKZHWB9lYyCAbWYnTk9C1MUY56hkBoPTXSWjiLjes5yGom9sJTyKyDm06zKQDiWbWz6mUIoL4jDksfqI+3WV2aQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482570; c=relaxed/simple;
	bh=Rz519K4RzNFN9C7FTifkrc2s4js15D9og5elk9stWlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWsWEHIDz+qKXuXlhQ5Zr1nNDcnSKWmhPTTT7p2P3ML8Tpt2VbKWuDvGobfykgaSuneit5by92Ry22bF0jkTPRE6aZE59KGGmW6UihouiIWS9wjrrBb17Aj5fTzRysKTQl2C7Q/oMSnzClV0XVsbBxue8Kg/Nv4LTl/rbB2yh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b746JEi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA898C4CEF6;
	Fri, 29 Aug 2025 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482570;
	bh=Rz519K4RzNFN9C7FTifkrc2s4js15D9og5elk9stWlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b746JEi7ofbu/Uhds2/RNNzOPXnS7NWLS66+0qFYAYdB06+Utq0poYU59EjL1x1H8
	 dezSaOR27Iq42u6uaWRjc0o/96wwcsMJAiN39CyBlkvhI7CEX4TDv/4c8o1TVSQNuq
	 YJm8ix9mud4MyQuOE04B2Uce5NFehL9MJbWBkyAmP4z3jflL9uWZVMd0fL9MNCMFta
	 ubplVfs0bNlY0fF8820ia4Zf3NegD9Fj7qfeg/9O6tXuRg41IIusMhbt9Tzjb38Soz
	 is41qw93F1ecHTsp+2PGo249tkyHvtYsos2tbi2AkSALvzDsQEUI8XU02jqckILXj8
	 rbZrZMlUlU9Bw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 25/33] sched: Switch the fallback task allowed cpumask to HK_TYPE_DOMAIN
Date: Fri, 29 Aug 2025 17:48:06 +0200
Message-ID: <20250829154814.47015-26-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tasks that have all their allowed CPUs offline don't want their affinity
to fallback on either nohz_full CPUs or on domain isolated CPUs. And
since nohz_full implies domain isolation, checking the latter is enough
to verify both.

Therefore exclude domain isolation from fallback task affinity.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index ac01dc4eb2ce..ed3dd0f3fe19 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -24,7 +24,7 @@ static inline void leave_mm(void) { }
 #ifndef task_cpu_possible_mask
 # define task_cpu_possible_mask(p)	cpu_possible_mask
 # define task_cpu_possible(cpu, p)	true
-# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
+# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_DOMAIN)
 #else
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
-- 
2.51.0


