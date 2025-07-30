Return-Path: <linux-kernel+bounces-750283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17160B15980
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B2B3A6A03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A846287504;
	Wed, 30 Jul 2025 07:20:38 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A9287502
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860037; cv=none; b=ueMOX38Cjc1NaShO+EAZ+OSiaFU25nApjDqESWJr2SVbhT2qjxA04PepcVIjBhOX0LFkYrnZa9s/3mJdHw5cPvBcK8HxbBQouYQ27qg5bfcUXCsMFmVGNPthLPgXioDeZ4GxHMyJT9qT9EwLfQqwbTtXjFasaDZNZ3g6oG4Rhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860037; c=relaxed/simple;
	bh=w1MAx6s2qy9uq7wOeUHF6qWAYtLHrBBBmhAKDbeM0Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTBLYxkwlmTHNo2PMyk9VUx7SJuJ3i0gTPGXbENp6VuJGj8e6d8EDbRezodkNloKc/84wB1L2m0Vqd8LwQjwfa9XDpcWXObt6r3FoLDGDRznyn0L+xlGsl25esMKJlSSV69ZOkzBeXwcGL2GBW4K0e0P5EdVF6oOY5ZxAQgYhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bsN6x3ypFz9t9W;
	Wed, 30 Jul 2025 08:47:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUXy95aT7_bY; Wed, 30 Jul 2025 08:47:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bsN6D4PRmz9tC6;
	Wed, 30 Jul 2025 08:46:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9260C8B76C;
	Wed, 30 Jul 2025 08:46:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 7zrCXI7WVVQW; Wed, 30 Jul 2025 08:46:28 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 719588B763;
	Wed, 30 Jul 2025 08:46:28 +0200 (CEST)
Message-ID: <7bba99d8-b171-4ac1-a33c-4c086f3684fd@csgroup.eu>
Date: Wed, 30 Jul 2025 08:46:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/qspinlock: Add spinlock contention tracepoint
To: "Nysal Jan K.A." <nysal@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250725081432.1254986-1-nysal@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250725081432.1254986-1-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/07/2025 à 10:14, Nysal Jan K.A. a écrit :
> Add a lock contention tracepoint in the queued spinlock slowpath.
> Also add the __lockfunc annotation so that in_lock_functions()
> works as expected.
> 
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
>   arch/powerpc/lib/qspinlock.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/lib/qspinlock.c b/arch/powerpc/lib/qspinlock.c
> index bcc7e4dff8c3..622e7f45c2ce 100644
> --- a/arch/powerpc/lib/qspinlock.c
> +++ b/arch/powerpc/lib/qspinlock.c
> @@ -9,6 +9,7 @@
>   #include <linux/sched/clock.h>
>   #include <asm/qspinlock.h>
>   #include <asm/paravirt.h>
> +#include <trace/events/lock.h>
>   
>   #define MAX_NODES	4
>   
> @@ -708,8 +709,9 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
>   	qnodesp->count--;
>   }
>   
> -void queued_spin_lock_slowpath(struct qspinlock *lock)
> +void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock)
>   {
> +	trace_contention_begin(lock, LCB_F_SPIN);
>   	/*
>   	 * This looks funny, but it induces the compiler to inline both
>   	 * sides of the branch rather than share code as when the condition
> @@ -718,16 +720,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock)
>   	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) && is_shared_processor()) {
>   		if (try_to_steal_lock(lock, true)) {
>   			spec_barrier();
> -			return;
> +		} else {
> +			queued_spin_lock_mcs_queue(lock, true);

If I read correctly, now all this is single line so you have to drop the 
braces , see 
https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

>   		}
> -		queued_spin_lock_mcs_queue(lock, true);
>   	} else {
>   		if (try_to_steal_lock(lock, false)) {
>   			spec_barrier();
> -			return;
> +		} else {
> +			queued_spin_lock_mcs_queue(lock, false);
>   		}

Same here.

> -		queued_spin_lock_mcs_queue(lock, false);
>   	}
> +	trace_contention_end(lock, 0);
>   }
>   EXPORT_SYMBOL(queued_spin_lock_slowpath);
>   


