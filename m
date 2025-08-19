Return-Path: <linux-kernel+bounces-776472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3A8B2CDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1A01C273AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3D322C9A;
	Tue, 19 Aug 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jc6p9mvm"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338B315774
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634614; cv=none; b=LIWUNAeYNJOCudzrhM3xDVgo1aLVfTOihSoFDestn2fzkBs8Zt4VzmN7HFQWna5CSctXJAaaKDk73/uGKmOtjxHaXWVmLQ8XMzOVtVkfaWc3fofUcKVZdPL0PpEgwIdDesnvJ9WlWBA9R8mWMDDeMDKgSBao5J/RasFQrjQ5rwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634614; c=relaxed/simple;
	bh=udgocsjJD41ItoihgnArmiVjyb7mSZD6JjIAaDNQ6Lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cq1g5rdFcsuYXItH/Pscr5RwOAmToRmhN1GoEAbJGlgEG1KyC01o5HL/aP9TK32Bmkf4Yi6ydOJiI17QXRtazqFvsgx+ibEcOb/k8xdGGlPI9jHfzvsb1LPDi6PDnyzPEwq3suphSwpGcB9Kmvcspvfk1ILqMbUW+O01RIwwEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jc6p9mvm; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755634601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqbB3H+IOvqAzvYEg/c7+VdVr8vD6PumH4PG2on0onk=;
	b=jc6p9mvmzAAxtUOk1Rl3nqhHXLTv28gZeOudhcu3Cs/7o0QHDQm830galIumRVJf11TdYU
	MpQhTSYtWIW+fwvpqjeo2YRTOsNkduSprMPk+w3CEXSIF5COP9hRD5+OmtHii7bR32eviT
	BwLcrgjM/id8VJCcmz0+hNbNwbK51GY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  Matt Bobrowski <mattbobrowski@google.com>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/14] mm: introduce bpf_out_of_memory() bpf kfunc
In-Reply-To: <CAJuCfpHTtLQR0NpsbFytaOdEc0KqNv6PxVpxNetYD6Ce4sY9UQ@mail.gmail.com>
	(Suren Baghdasaryan's message of "Mon, 18 Aug 2025 21:09:24 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-7-roman.gushchin@linux.dev>
	<CAJuCfpHTtLQR0NpsbFytaOdEc0KqNv6PxVpxNetYD6Ce4sY9UQ@mail.gmail.com>
Date: Tue, 19 Aug 2025 13:16:30 -0700
Message-ID: <87wm6zysm9.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Suren Baghdasaryan <surenb@google.com> writes:

> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
>> an out of memory events and trigger the corresponding kernel OOM
>> handling mechanism.
>>
>> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
>> as an argument, as well as the page order.
>>
>> If the wait_on_oom_lock argument is not set, only one OOM can be
>> declared and handled in the system at once, so if the function is
>> called in parallel to another OOM handling, it bails out with -EBUSY.
>> This mode is suited for global OOM's: any concurrent OOMs will likely
>> do the job and release some memory. In a blocking mode (which is
>> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
>>
>> The function is declared as sleepable. It guarantees that it won't
>> be called from an atomic context. It's required by the OOM handling
>> code, which is not guaranteed to work in a non-blocking context.
>>
>> Handling of a memcg OOM almost always requires taking of the
>> css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
>> also guarantees that it can't be called with acquired css_set_lock,
>> so the kernel can't deadlock on it.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  mm/oom_kill.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 25fc5e744e27..df409f0fac45 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -1324,10 +1324,55 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_=
control *oc,
>>         return 0;
>>  }
>>
>> +/**
>> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
>> + * @memcg__nullable: memcg or NULL for system-wide OOMs
>> + * @order: order of page which wasn't allocated
>> + * @wait_on_oom_lock: if true, block on oom_lock
>> + * @constraint_text__nullable: custom constraint description for the OO=
M report
>> + *
>> + * Declares the Out Of Memory state and invokes the OOM killer.
>> + *
>> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_o=
om_lock
>> + * is true, the function will wait on it. Otherwise it bails out with -=
EBUSY
>> + * if oom_lock is contended.
>> + *
>> + * Generally it's advised to pass wait_on_oom_lock=3Dtrue for global OO=
Ms
>> + * and wait_on_oom_lock=3Dfalse for memcg-scoped OOMs.
>
> From the changelog description I was under impression that it's vice
> versa, for global OOMs you would not block (wait_on_oom_lock=3Dfalse),
> for memcg ones you would (wait_on_oom_lock=3Dtrue).

Good catch, fixed.

>
>> + *
>> + * Returns 1 if the forward progress was achieved and some memory was f=
reed.
>> + * Returns a negative value if an error has been occurred.
>
> s/has been occurred/has occurred or occured

Same here.

Thanks!

