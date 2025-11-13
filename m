Return-Path: <linux-kernel+bounces-899628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425FC58731
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 029B635AA15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7A2F5A0C;
	Thu, 13 Nov 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Lk0F+6Fs"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288B2D190C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047352; cv=none; b=tfI00G9HVClpMh9GoWq+TYJcbhI4v578ij+MQwnJ+DBFYI1b1o8KBkJ6ukYg0jKUWLGh6f4Z2ooPVs/Lhy2p+EkPudM0vejHP/Nxzgl83o5/7vB4Y9tvxQQSuzx7UumMgWb4F5euFXAH2rm/QsCgSvnjJ3oEeUlutDaHtRAfcnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047352; c=relaxed/simple;
	bh=UiRs74nL3rVui3DwRm/btbk1rmkdM56X3uuyrUTBHho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjfOAYgnpL4Ck3DPog/e+uws3jn4z4IX52aNXO6qVjRoa3sNFBSTkK8W9pUs67S2bCSST9f2IDW+XCpmxgzsMV27BPLYVEE+B0MGuw03Roc9Dbffpl3fYxst6VLJj9GYIjuy+SDHliKJDia4t1wiCqmXz8ey2R1GN7bG42l95Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Lk0F+6Fs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b220ddc189so117860685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1763047348; x=1763652148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qew95D3nrCzXmE6HtD3neLe4hinSTQ6wp1uAz5jei/M=;
        b=Lk0F+6Fsys4EjvbRipdzM1hUZbL05PgdU2G6Tvpre1ZeaYujkBtKcZ+yDG0iTQ9PPR
         S83uxrN1NS7+K6O45uz8xvzXONSIzE0g2hxXJsG9LcqiN26K4arzPBRquYWMx2B9FgJ4
         Aw3YJemlb+M2rPVtD6d0uElkgtyMr0Bgy6qUEhnxgft2pCBd4aT2ZJcR5lAE55zI+KEg
         iBxdlauwuQqxdd2i5YGmcUvNqqOxx888xNLu64px4PK1f4oNAByULfynFMqOECRqS4BC
         5wVNTteoACfjElx5yjS4V63IjklGVHUNNjXOGQj/LGwNJcAWCOMBI4L4Ihpk2iM+t+3m
         PF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047348; x=1763652148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qew95D3nrCzXmE6HtD3neLe4hinSTQ6wp1uAz5jei/M=;
        b=UyRMudpDxtf6RsDp+FYOG6pj0h71OMG1mjW5NSnD8UfWuIfZ5vv/GZFS5VQkuDSMDY
         cyzsQtpxrPPra2dHT2C29xPxa7M1e4Jf8WkJ3Osa8a0PG+15jZ28C8qktRJACYtQcGca
         fKfjwPtYd7eYfaAWABzK0N1rGndaZMXiQwkd686DDDVeVFxLVveJMiz8nB2CTvtS1i0P
         PnrejXRvi3BzgkkgjvGyGnj0ZdYRyrJmYlvcv4il9tYhiXwXggQ0/DRK003iqlltRaXp
         IbgqIsUT/W8NgylONBivDscOvXo6RMrucktIvIP4cniVoQKHurJ5KKE982Vq9+u+/DXp
         irBQ==
X-Gm-Message-State: AOJu0Yw4l1NmSC40gpCXDG1R0+FrhpDixdhwVcJ0/YfCZFet8VDZrYzK
	ErzQdYo3cU9fJ71vOuwderP99vKMSUQsS5hqS1Z/AAl5QU94XLk4fu7zFBujOu8iLj6/83RFV1o
	QEpuj
X-Gm-Gg: ASbGnctPPLByJIdLDm7amaP6Jlcom/djbsIXSpx+NtCZ2PSSKhXIb7jYRIiEM1f8FXA
	PI6WUj2ZcGgcdWB6HnSoqNc+FPXZlbTd/DFPb5oYQ2X/gduIfaZ2Y0cS/KRl7Pzhwg8hH0QkKMA
	BedZzq3D96a6easdU7X7Y2DefCdBHT823kheyWUwjcWsxtwEQiFEgccA+/0lK72M/si5n56faLZ
	omQVyaFifT+ma3ZgiZ8WlUbfuM0AtrwGvvmyKqKiqrzMsC/aMBrx4tUVgDDDivZ0DJ+V2RVoT3u
	zpW2OVQb6kbDwReMa+4iqA5a4QaadmTBBjCkKrG49r3yl+GP5WXCs6HlOvuF4quNkwuajIBAbFJ
	QUkFjzTQaWHf/tfN76ziaqyDLxNSxT9bUlF5sFV8UUChEtirFeA6/jVKtHRgalss8Ko7ZNn/A5M
	03A5nb2q2l6Q==
X-Google-Smtp-Source: AGHT+IGOb53qAedF0ryXQVtSsFmIHGAo9aPpgLIR/pxQdZFloDYrVbrLE1ntPuDuwgX7G86VovvkEg==
X-Received: by 2002:a05:620a:40ca:b0:8a3:cd9e:e3f6 with SMTP id af79cd13be357-8b29b765fd0mr925778385a.7.1763047347768;
        Thu, 13 Nov 2025 07:22:27 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aecd1709sm149008085a.0.2025.11.13.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:22:26 -0800 (PST)
Date: Thu, 13 Nov 2025 10:22:23 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/psi: Streamline the flow in psi_group_change
Message-ID: <20251113152223.GA3465062@cmpxchg.org>
References: <20251113122254.40445-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113122254.40445-1-tvrtko.ursulin@igalia.com>

On Thu, Nov 13, 2025 at 12:22:54PM +0000, Tvrtko Ursulin wrote:
> Given that psi_group_change() can be called rather frequently from the
> scheduler task switching code lets streamline it a bit to reduce the
> number of loops and conditionals on the typical invocation.
> 
> First thing is that we replace the open coded mask walks with the standard
> for_each_set_bit(). This makes the source code a bit more readable and
> also enables usage of the efficient CPU specific zero bit skip
> instructions.
> 
> In doing so we also remove the need to mask out the special TSK_ONCPU bit
> from the set and clear masks, since for_each_set_bit() now directly limits
> the array index to the safe range.
> 
> As the last remaining step we can now easily move the new state mask
> computation to only run when required.
> 
> End result is hopefully more readable code and a very small but measurable
> reduction in task switching CPU overhead.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/psi.c | 48 ++++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 59fdb7ebbf22..fe19aeef8dbd 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -798,39 +798,26 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  			     u64 now, bool wake_clock)
>  {
>  	struct psi_group_cpu *groupc;
> -	unsigned int t, m;
> +	unsigned long t, m;
>  	u32 state_mask;
>  
>  	lockdep_assert_rq_held(cpu_rq(cpu));
>  	groupc = per_cpu_ptr(group->pcpu, cpu);
>  
>  	/*
> -	 * Start with TSK_ONCPU, which doesn't have a corresponding
> -	 * task count - it's just a boolean flag directly encoded in
> -	 * the state mask. Clear, set, or carry the current state if
> -	 * no changes are requested.
> +	 * TSK_ONCPU does not have a corresponding task count - it's just a
> +	 * boolean flag directly encoded in the state mask. Clear, set, or carry
> +	 * the current state if no changes are requested.
> +	 *
> +	 * The rest of the state mask is calculated based on the task counts.
> +	 * Update those first, then construct the mask.
>  	 */
> -	if (unlikely(clear & TSK_ONCPU)) {
> -		state_mask = 0;
> -		clear &= ~TSK_ONCPU;
> -	} else if (unlikely(set & TSK_ONCPU)) {
> -		state_mask = PSI_ONCPU;
> -		set &= ~TSK_ONCPU;
> -	} else {
> -		state_mask = groupc->state_mask & PSI_ONCPU;
> -	}

This doesn't look right. Without PSI_ONCPU in state_mask, the results
of test_states() will be bogus, as well as the PSI_MEM_FULL special
case for an active reclaimer on the CPU.

> -	/*
> -	 * The rest of the state mask is calculated based on the task
> -	 * counts. Update those first, then construct the mask.
> -	 */
> -	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
> -		if (!(m & (1 << t)))
> -			continue;
> -		if (groupc->tasks[t]) {
> +	m = clear;
> +	for_each_set_bit(t, &m, ARRAY_SIZE(groupc->tasks)) {

The current version relies on !!m and doesn't need the range checks
for_each_set_bit() introduces. This seems less efficient. Did you
compare the generated code?

> +		if (likely(groupc->tasks[t])) {
>  			groupc->tasks[t]--;
>  		} else if (!psi_bug) {
> -			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
> +			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%lu tasks=[%u %u %u %u] clear=%x set=%x\n",
>  					cpu, t, groupc->tasks[0],
>  					groupc->tasks[1], groupc->tasks[2],
>  					groupc->tasks[3], clear, set);
> @@ -838,9 +825,9 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		}
>  	}
>  
> -	for (t = 0; set; set &= ~(1 << t), t++)
> -		if (set & (1 << t))
> -			groupc->tasks[t]++;
> +	m = set;
> +	for_each_set_bit(t, &m, ARRAY_SIZE(groupc->tasks))
> +		groupc->tasks[t]++;
>  
>  	if (!group->enabled) {
>  		/*
> @@ -853,6 +840,13 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		if (unlikely(groupc->state_mask & (1 << PSI_NONIDLE)))
>  			record_times(groupc, now);
>  
> +		if (unlikely(clear & TSK_ONCPU))
> +			state_mask = 0;
> +		else if (unlikely(set & TSK_ONCPU))
> +			state_mask = PSI_ONCPU;
> +		else
> +			state_mask = groupc->state_mask & PSI_ONCPU;

You moved it here, but this is the !group->enabled exception
only. What about the common case when the group is enabled?

