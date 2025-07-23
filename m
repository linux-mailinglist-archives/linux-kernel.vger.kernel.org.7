Return-Path: <linux-kernel+bounces-742830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6096CB0F722
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3661C825F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CF1FA859;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlzQh9sz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7081F3B8A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284963; cv=none; b=TIayObE0Q836HnYrrEcUDNXxNYOZoOS8rn/1Dkhecb7PI2yMELKLJx1Ox6R3logPXmObl51/sGLibI8RzkX46+aawGyTNCJuIPKI5SHOCfSHPYkOnZyZEaB8vcjMZyupodCC2fUPj9DEtDNYYJsuBguxWq7fxpquClE9h8CF7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284963; c=relaxed/simple;
	bh=ZvXKGt+TTpbDKDr6EJ7fxN2C5u+9aqZGHrvGXXcGovU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kLbysPK5sIRgFwTJphaLgFPYxc6JzzD0yx/zh2pTUTqrBnCWYFTH1dR4AuJB3PhNuPt3ZVvazf8TbReCpbJimRXxKyPP/Vzk4XnqoBWja5CSioD5CXMhXTxe7oft59XncWPx4vnHYrFHctOdlFyhj/JG+MWJ8ONsP+uEdTVcqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlzQh9sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7411C4CEF7;
	Wed, 23 Jul 2025 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284962;
	bh=ZvXKGt+TTpbDKDr6EJ7fxN2C5u+9aqZGHrvGXXcGovU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ZlzQh9szu7jpVc+b9G9eMGPueaBi7QbXpil2Zo+swjRepswBtAL9KCvXjwXmdPmq/
	 1lXhMXH8160hDebPOL1/ncv32lPt4EQidaSAE1osq0gr84rAiTW3Ig/YHAQiiBDEt/
	 2FsGbpjgFoJ6Z/ThB/XLjuL1A4hzWA7Gy5BjQgz6+zPvJuhOAVOPguruacoJonu6Z/
	 e6byPyAw+Ueyb6wlX9sVpMdAyx8RNwRijaUpqzgoNFbT423Dr+nahManpKyA0fEjSY
	 tLlqN+1G5ua31Yb5qyhBSzQuxAfPo/XXTeYbr9uo3V4k1BtKXWPIz1n3UhumbOzq5g
	 sLil8w080iDIA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueamd-00000000LQE-47iM;
	Wed, 23 Jul 2025 10:49:27 -0400
Message-ID: <20250723144927.839559500@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Song Chen <chensong_2000@189.cn>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [for-next][PATCH 3/8] kernel: trace: preemptirq_delay_test: use offstack cpu mask
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Arnd Bergmann <arnd@arndb.de>

A CPU mask on the stack is broken for large values of CONFIG_NR_CPUS:

kernel/trace/preemptirq_delay_test.c: In function ‘preemptirq_delay_run’:
kernel/trace/preemptirq_delay_test.c:143:1: error: the frame size of 8512 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Fall back to dynamic allocation here.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Song Chen <chensong_2000@189.cn>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250620111215.3365305-1-arnd@kernel.org
Fixes: 4b9091e1c194 ("kernel: trace: preemptirq_delay_test: add cpu affinity")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/preemptirq_delay_test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 314ffc143039..acb0c971a408 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -117,12 +117,15 @@ static int preemptirq_delay_run(void *data)
 {
 	int i;
 	int s = MIN(burst_size, NR_TEST_FUNCS);
-	struct cpumask cpu_mask;
+	cpumask_var_t cpu_mask;
+
+	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
 
 	if (cpu_affinity > -1) {
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(cpu_affinity, &cpu_mask);
-		if (set_cpus_allowed_ptr(current, &cpu_mask))
+		cpumask_clear(cpu_mask);
+		cpumask_set_cpu(cpu_affinity, cpu_mask);
+		if (set_cpus_allowed_ptr(current, cpu_mask))
 			pr_err("cpu_affinity:%d, failed\n", cpu_affinity);
 	}
 
@@ -139,6 +142,8 @@ static int preemptirq_delay_run(void *data)
 
 	__set_current_state(TASK_RUNNING);
 
+	free_cpumask_var(cpu_mask);
+
 	return 0;
 }
 
-- 
2.47.2



