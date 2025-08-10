Return-Path: <linux-kernel+bounces-761296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D6B1F7F9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 03:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4476017AF6A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 01:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B1176ADE;
	Sun, 10 Aug 2025 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="CpwOZce7"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6511547F2
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791000; cv=none; b=IETXPj7q3jChj5Oapgk8+ClqJ7Ygyh+DsfVWJhBoZTUmmcC35bxn3VBQ47AIQwyHxHVGPV1IA4oSowAzeMoyJyul65JxgSs47cLenoddaBSPclrxeWGFbgHCs55YKSsiZywcAf3G6NrnjaoVo9oLVrtiyqmcmFw5M2SUDrX4DOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791000; c=relaxed/simple;
	bh=aMMsFujWtKSiQIx/ai/XRAv59PNOWK7kAkBhpKTKXgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZU7cUYtCwToej8JbIbKl7tBsI//2s1hio54udbOnKri2bmdvy+uOqEpuFj0IAhpUXnZofyi4MVk4d+DMcaFb9WS84z8hacBGUcfr6a80g/ijUGx12ZR38+qu9g4KeQ7HjzVufq+kLXPGN7QsRmgiz7qfUOuvTBZe2qPWudErtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=CpwOZce7; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754790992;
	bh=gk7Rrap6m/JcBi9xp6sWJRJcd7s+2s1ezjCVNiCQhg8=;
	h=From:Subject:Date:Message-ID;
	b=CpwOZce7JBPQwA81+kIG42YUBjACjCTzqPdWn5CNF13XVVC4DSF6AyzSSEuPpbrd8
	 MXgqtqyCvRC4jJ45wHt4TDNg2Vx+2ryBSTIB5E+m8R5SKYgagq28ZBHg/tGDHK/gYo
	 kb27fl5Xcg4mZzkmFPES04awDPol0EguZI4O5GJc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6897FC45000035DC; Sun, 10 Aug 2025 09:56:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6166724457115
X-SMAIL-UIID: 23DC30104ED84353AB622780476B2448-20250810-095623-1
From: Hillf Danton <hdanton@sina.com>
To: "Subrata Nath (Nokia)" <subrata.nath@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: prevent RCU stalls in kswapd by adding cond_resched()
Date: Sun, 10 Aug 2025 09:56:11 +0800
Message-ID: <20250810015612.4133-1-hdanton@sina.com>
In-Reply-To: <AM9PR07MB78119166E41E86BE5E7DDCC0882EA@AM9PR07MB7811.eurprd07.prod.outlook.com>
References: <AM9PR07MB78119166E41E86BE5E7DDCC0882EA@AM9PR07MB7811.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 9 Aug 2025 11:59:16 +0000 Subrata Nath (Nokia) wrote:
> The kswapd0 thread can spend extended time in
> page_vma_mapped_walk() -> queued_spin_lock_slowpath() without
> yielding the CPU. Even with CONFIG_PREEMPTION=3Dy, the rcu_preempt
> kthread cannot preempt kswapd0 because preemption and interrupts
> are disabled while holding the spinlock.
> 
> Example stall report:
>   rcu: INFO: rcu_preempt self-detected stall on CPU
>   rcu: rcu_preempt kthread starved for 65939907 jiffies!
>   Call trace:
>     queued_spin_lock_slowpath
>     page_vma_mapped_walk
>     folio_referenced_one
>     kswapd
> 
> Similar stalls occur in shrink_zones(), where long-running loops
> prevent CPUs from reporting a quiescent state during the RCU grace
> period. Without such reports, RCU stall warnings can escalate to
> soft lockups or OOM kills.
> 
> A quiescent state is reported when a CPU exits an RCU read-side
> critical section, enters idle/user mode, performs a context switch,
> or voluntarily reschedules.
> 
> Fix this by adding cond_resched() after all spinlock release points
> in page_vma_mapped_walk() and in the main loop of shrink_zones().

Given spinlock in calltrace, this fixes nothing at best.

