Return-Path: <linux-kernel+bounces-840151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE70BB3B19
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C123B5B05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD630DD32;
	Thu,  2 Oct 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uxc5uUls"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554630CD84
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759402208; cv=none; b=VGBzonPYXnnRM9+z2NkDulbuZPQUKOdyjB7kxP1bLsHMvPPhlXUAm6EwNybJ838vJ0O5NACzumgkXQPn3ivhdLYgy55axmHkhHn+6RpMluVn+CtDcWIMSQOR66XkB5ZjWHGbG8xojSF2tjvqXcQbtzabGbF5TGLOPD9vCP+ri9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759402208; c=relaxed/simple;
	bh=/Lm1cyHiobRLKFi4pBvNZQIhurIMPdnZN3jXXBu1IUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=psVfWmC/gbhO2QozRKcE7notUPf21V732giLyL6UPkqFldH22ueXFDYK4SIpqIJqrxw0pd80pnzpGIV70t+Rt7AaDBTbnCVLvugDUvEP4z0szzPhok6fZwhdTbluWmIfqK/o1X4UR9lWwrW/d++jEJsmQNL7QivRhXfut/ql5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uxc5uUls; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso4175795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759402205; x=1760007005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWh2ETCCMHfxl02tP/Gv5EZmDDMUXPwjZALfSasBKUg=;
        b=Uxc5uUlsKELIOFFc09SYDQth8wbLY5x07CaBsiOJYFLMAzyHqQvjMn0hvDgOAtNuud
         jOdlAmTUWhKeLkj97ZQeDU24m3PEtYSileSgUjpVzpnzgVMUfzB2kK3OzkwlmiTH91rj
         qv/Lt29DAipI2wqgWOJeb5uW8BD1Fc2W6lY6R9Z4LKUyg0msg73+4bhRxDIDpmzCfA7l
         h7xNHbuxLk72rfKjwRZZOQkNT82rfPJxf56bN2C9KhSij+jpTUgXWt2VQ3fixcPR8n64
         cZJ4F4N+trlORRcjO+FFioYIy5n9aOAuIwdH/HQCa+YIWSTVx6O6ac6mZiP6aQAH2Alw
         Xgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759402205; x=1760007005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWh2ETCCMHfxl02tP/Gv5EZmDDMUXPwjZALfSasBKUg=;
        b=tuQe0XO2Jp/LYAbKVfL5xKAY8s1Jf2ZmfsE78sFijdMC/rUgSZkHsQoq48DTc99L5+
         LQzhl9/2evCCseJBwEl9usJyHLo6HDhuG396v65QiIB/2PaLKoALylLzQX2ryFzdSGKF
         Q8LFecR4aU2l5sxV7q5wYAQquu7oRm5Wa1gSMco0632/zhV3ONPmgVt3RRRUM31/h/vM
         QEWfHxQ/LF+m+qpYzwzDYtul9WujuGhVvpX1vbc3uTSttn/TiAQrjWWI5pyJuKfGoBL4
         7o/oWxYK/sMzjoNekL72/1UR7TWC6Qj/vkGVDK5dN9Jh/4OhNOcsllLLsjYUXspFM49C
         D2TA==
X-Forwarded-Encrypted: i=1; AJvYcCXqbkaSn0Vw7QMh/sGzJrMiZ8zxifrYBs0xxh50b/DRz4kHHXiI5LQSyhk3kkJhMgDmlwyjCygUza6Xq70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfkbct95bvOFOIzHZFBg2po6sCVYw576ME/Nn5EztrHk3MS8H3
	gs43ChW8IlLIs5Tao67ZBKIhNn085ZV8+L6XtPnYPSR/AOGSCwP5HsvSj1QIEcGAbBh+OosXgge
	bpNHXVj1Z6S3tkA==
X-Google-Smtp-Source: AGHT+IGWR9j/Xit9lLgINB4l5JFF1so1I0kGHQeQSHLJdJxwnyVap0eWcLny3Gx9GUUNMzDySaN/LGmTl4dg0g==
X-Received: from wmbz25.prod.google.com ([2002:a05:600c:c099:b0:46d:712:e422])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:458f:b0:46e:39ef:be77 with SMTP id 5b1f17b1804b1-46e6127e030mr54678365e9.14.1759402204756;
 Thu, 02 Oct 2025 03:50:04 -0700 (PDT)
Date: Thu, 02 Oct 2025 10:50:03 +0000
In-Reply-To: <44082771-a35b-4e8d-b08a-bd8cd340c9f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812173109.295750-1-jackmanb@google.com> <44082771-a35b-4e8d-b08a-bd8cd340c9f2@redhat.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD7S12CF1V9G.3KGT3KYBLZ7F2@google.com>
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>, Brendan Jackman <jackmanb@google.com>, <peterz@infradead.org>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>, 
	<tglx@linutronix.de>
Cc: <akpm@linux-foundation.org>, <derkling@google.com>, <junaids@google.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <reijiw@google.com>, 
	<rientjes@google.com>, <rppt@kernel.org>, <vbabka@suse.cz>, <x86@kernel.org>, 
	<yosry.ahmed@linux.dev>, Patrick Roy <roypat@amazon.co.uk>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 2, 2025 at 7:45 AM UTC, David Hildenbrand wrote:
>> I won't re-hash the details of the problem here (see [1]) but in short: file
>> pages aren't mapped into the physmap as seen from ASI's restricted address space.
>> This causes a major overhead when e.g. read()ing files. The solution we've
>> always envisaged (and which I very hastily tried to describe at LSF/MM/BPF this
>> year) was to simply stop read() etc from touching the physmap.
>> 
>> This is achieved in this prototype by a mechanism that I've called the "ephmap".
>> The ephmap is a special region of the kernel address space that is local to the
>> mm (much like the "proclocal" idea from 2019 [2]). Users of the ephmap API can
>> allocate a subregion of this, and provide pages that get mapped into their
>> subregion. These subregions are CPU-local. This means that it's cheap to tear
>> these mappings down, so they can be removed immediately after use (eph =
>> "ephemeral"), eliminating the need for complex/costly tracking data structures.
>> 
>> (You might notice the ephmap is extremely similar to kmap_local_page() - see the
>> commit that introduces it ("x86: mm: Introduce the ephmap") for discussion).
>> 
>> The ephmap can then be used for accessing file pages. It's also a generic
>> mechanism for accessing sensitive data, for example it could be used for
>> zeroing sensitive pages, or if necessary for copy-on-write of user pages.
>> 
>
> At some point we discussed on how to make secretmem pages movable so we 
> end up having less unmovable pages in the system.
>
> Secretmem pages have their directmap removed once allocated, and 
> restored once free (truncated from the page cache).
>
> In order to migrate them we would have to temporarily map them, and we 
> obviously don't want to temporarily map them into the directmap.
>
> Maybe the ephmap could be user for that use case, too.

The way I've implemented it here, you can only use the ephmap while
preemption is disabled. (A lot about the implementation I posted here is
just stupid prototype stuff, but the preemption-off thing is
deliberate). Does that still work here? I guess it's only needed for the
brief moment while we are actually copying the data, right? In that case
then yeah this seems like a good use case.

> Another, similar use case, would be guest_memfd with a similar approach 
> that secretmem took: removing the direct map. While guest_memfd does not 
> support page migration yet, there are some prototypes that allow 
> migrating pages for non-CoCo (IOW: ordinary) VMs.
>
> Maybe using the ephmap could be used here too.

Yeah, I think overall, the pattern of "I have tried to remove stuff from
my address space, but actuonally I need to exceptionally access it anyway,
we are not actually a microkernel" is gonna be a pretty common one. So
if we can find a way to solve it generically that seems worthwhile. I'm
not confident that this design is a generic solution but it seems like
it might be a reasonable starting point.

> I guess an interesting question would be: which MM to use when we are 
> migrating a page out of random context: memory offlining, page 
> compaction, memory-failure, alloc_contig_pages, ...
>
> [...]
>
>> 
>> Despite my title these numbers are kinda disappointing to be honest, it's not
>> where I wanted to be by now,
>
> "ASI is faster again" :)
>
>> but it's still an order-of-magnitude better than
>> where we were for native FIO a few months ago. I believe almost all of this
>> remaining slowdown is due to unnecessary ASI exits, the key areas being:
>> 
>> - On every context_switch(). Google's internal implementation has fixed this (we
>>    only really need it when switching mms).
>> 
>> - Whenever zeroing sensitive pages from the allocator. This could potentially be
>>    solved with the ephmap but requires a bit of care to avoid opening CPU attack
>>    windows.
>> 
>> - In copy-on-write for user pages. The ephmap could also help here but the
>>    current implementation doesn't support it (it only allows one allocation at a
>>    time per context).
>> 
>
> But only the first point would actually be relevant for the FIO 
> benchmark I assume, right?

Yeah that's a good point, I was thinking more of kernel compile when I
wrote this, I don't remember having a specific theory about the FIO
degradation. The other thing I didn't mention here that might be hitting
FIO is filesystem metadata. For example if you run this on ext4 you
would need to get the superblock into the restricted addres space to
make it fast.  I'm not sure if there would be anything like that in
shmem though...

> So how confident are you that this is really going to be solvable. 

I feel pretty good about solvability right now - the numbers we see now
are kinda where we were at internally 2 or 3 years ago, and then it was
a few optimisation steps from there to GCE prod (IIRC the
context_swith() one was a pretty big one for that usecase, I can't
remember if any of the TLB flushing optimisations made a big
difference). 

I can't deny the risk that these few steps might be much harder for
native workloads than VM ones but it  just seems like a game of
whack-a-mole now, not a "I'm not sure this thing is ever gonna work".
The only question is how many moles there are to whack...

> Or to 
> ask from another angle: long-term how much slowdown do you expect and 
> target?

In the vast majority of cases, we've been able to keep degradations from
ASI below 1% of whatever anyone's measuring. When things go above that
we need to grovel a bit, if anything gets to 5% we don't even bother
asking.

But also, note in lots of these cases we're switching ASI on while
leaving other mitigations in place too. If we had a complete "denylist"
(i.e. the holes in the restricted address space) that we were confident
covered everything, we'd be able to make a lot of these degradataions
negative. So we might just be making life unnecessarily hard for
ourselves by not doing that in the first place. The idea is to retrace
our steps later and start switching off old mitigations and bragging
triumphantly about our perf wins once we are totally certain there's no
security regression.

So yeah I can't be 100% confident for the reasons I mentioned above but
the target, which I think is realistic, is for ASI to be faster than the
existing mitigations in all the interesting cases ("interesting" meaning
we have to do kernel work instead of just flipping a bit in the CPU ).

