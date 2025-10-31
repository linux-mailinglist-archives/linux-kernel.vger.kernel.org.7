Return-Path: <linux-kernel+bounces-881002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9824C272AC
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 00:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3F81B265A5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7E32ABEF;
	Fri, 31 Oct 2025 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkN8RXiA"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9A329E62
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952386; cv=none; b=jKRfetuxKBGfUhCkL+EbxLwPF6xxPkWkIgG5gHPLr5GENuScNB3o+tyPQfrF17xqtyOHHDjKQAZibWxq+EnJa4FMclDijby+3u9M5vYiZtASQSKpbQU23NBCpKTmv2LAITEQPD1WdVValV5m4rt4q6QrKJVoHcdLKvP3/eo1pSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952386; c=relaxed/simple;
	bh=gY82JgAv1A8rYj9MCaiZVHVrEMWrbrCoiDwppP0oGWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkFkUsCG1SjjUyV8dEWLqDEKGjSVnhYnnDpx1vdqxo9dZH5LgaYXMl3y+BON6W7vrD3xU5mJXxwu8PmDjGpwKAOgGw9R0H6WAHSDGHOMYnVJjfoQD2x72wtr+dNpaSXlf+OMzeKa1bdLaRgQI44oyeSf5QLuIwQooFt70AO/kJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkN8RXiA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ea12242d2eso82091cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761952382; x=1762557182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY82JgAv1A8rYj9MCaiZVHVrEMWrbrCoiDwppP0oGWg=;
        b=pkN8RXiAjdXxo7BRN5+terCdOCJFnliS5crjawRNQ5x3UOuShVrfTVS7/ndcHb9rK5
         XPJ77kaAfE9BoNEsCAXr+3d7DjfbmCPZOQqZf+0sLjvImi4VgycqCUfkOtLOAmTdrDqM
         3Bv9NiHCI/pUxNMCL0SOrzD13yYc80M8iJDj/Pn7SZ3hbTAkVzseB+I44xaHwZHA25UG
         b+hXRc179Gp9+IkCuj9XXiHOpqoqvqHp3E5Ukq/gnBpfTc2s78WdqUj0cUM4lPrlaEwI
         mHUfMlzOadgUghqvFM4HClQq/fB5XEAjzx7T87V82BTE+F1ZZ4+GhbaYdFyLbY/HG3NT
         Ad3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761952382; x=1762557182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gY82JgAv1A8rYj9MCaiZVHVrEMWrbrCoiDwppP0oGWg=;
        b=XNrqPSmmg+H9n5JcecM1ZNa8MJjMpQqv+jfMTFoaS6NWNzl/vI7Tj5Cb8OSUpfT2Ld
         WizxECRO3lNjCf6aIxyMSFIFBzb9siIqDhS51LoiDAvz67vLkvbYxVFE62Bq/CjxEK4l
         LlpOjeCH6savdzvNV7nsqAnmW4zTO8njVAZxmolGUJG6siDs7XpArer5MDPI6Z8kv+eQ
         sufk696a/Up8unc7VgqxtGNg9B9XykMLp2spCDVwF3Tn8HeMQsbEVlKriAE0lMyYGP3o
         zd81IneTG3g6pMoV1O91OpS7QI4XLy+SsA3Uje16fNHVefg31RsS4LtN7VUXFMGCyByZ
         fAMw==
X-Forwarded-Encrypted: i=1; AJvYcCW/TphDQpIX+B2f8TYU7buuWmF0gnE4SZmr+dFyn+qEVeqcbnn/rqp1s/ikXF6h6ykY/IvgI9SxfE3P4YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8ulBgyeyh2dX75RrfVG4wNCFtU/b705Xv5JD/YNiGYYBH8BZ
	HOZ96+IMltOKHRhAFN/recS0jRLAh/ZjE4eSOBUT2waaOQZA9bqAkEPP/HgaA/9CpS+HaRgxJNg
	ios/KAxBJWm/nJjpgXdFwN4zNAejU+2oNYtH7LQiY
X-Gm-Gg: ASbGnctH7AZbWjlrytGRf7tLEH3uzWeKT+4+RpesQmgTLpc0khKrJRBjVKYNrdQUEc1
	k9NqDJU/r3Q5FaDD+zfGHzR/WKprO6rVSYWio/0khh9w2edHS5yqCYFcvbG0LZZ+inVfwdpSeYl
	wCI0pIc5JXzoMWAJ2WG8HPVmST/cP27kUQHp6zMd2IYxkiKt+07JlrFswfn/QYpbXK7+OgtvYm7
	Su8FPS4cAguirws5GDIAv3KUd5SseWFpvvlgrfpbICmgaAZ34ZOXQ25dxI=
X-Google-Smtp-Source: AGHT+IENbX2I9QLWCzbGqCz+aeN8c925eFyi708BVOjF22TIfxJHEaH3VCvZrnHqn6i5au9Z3HH9DEYcpuxXzSR6lhg=
X-Received: by 2002:a05:622a:1991:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4ed424d7c14mr1098221cf.11.1761952382100; Fri, 31 Oct 2025
 16:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local> <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local> <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
 <3ae457cd-6c18-4870-a617-7f937b107cb4@suse.cz> <88b72728-fa3f-4a70-9ea2-40ff50673047@lucifer.local>
 <a3bcac19-78b7-4918-81b3-641a65a19a9d@suse.cz>
In-Reply-To: <a3bcac19-78b7-4918-81b3-641a65a19a9d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 31 Oct 2025 16:12:51 -0700
X-Gm-Features: AWmQ_bnVgpHA3Q0hYHvJgIIm_FpBFlpB9mdVzh6mL8zZeBp2jS4PiSvnDoBUG6c
Message-ID: <CAJuCfpEs1JTywfZNPrVmeTHUUyK+7waCU9fqfur2Q_xxx7hacw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pedro Falcato <pfalcato@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:48=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/30/25 20:47, Lorenzo Stoakes wrote:
> > On Thu, Oct 30, 2025 at 07:47:34PM +0100, Vlastimil Babka wrote:
> >> >
> >> > Could we use MADVISE_VMA_READ_LOCK mode (would be actually an improv=
ement
> >> > over the current MADVISE_MMAP_READ_LOCK), together with the atomic f=
lag
> >> > setting? I think the places that could race with us to cause RMW use=
 vma
> >> > write lock so that would be excluded. Fork AFAICS unfortunately does=
n't (for
> >> > the oldmm) and it probably would't make sense to start doing it. May=
be we
> >> > could think of something to deal with this special case...
> >>
> >> During discussion with Pedro off-list I realized fork takes mmap lock =
for
> >> write on the old mm, so if we kept taking mmap sem for read, then vma =
lock
> >> for read in addition (which should be cheap enough, also we'd only nee=
d it
> >> in case VM_MAYBE_GUARD is not yet set), and set the flag atomicaly, pe=
rhaps
> >> that would cover all non-bening races?
> >>
> >>
> >
> > We take VMA write lock in dup_mmap() on each mpnt (old VMA).
>
> Ah yes I thought it was the new one.
>
> > We take the VMA write lock (vma_start_write()) for each mpnt.
> >
> > We then vm_area_dup() the mpnt to the new VMA before calling:
> >
> > copy_page_range()
> > -> vma_needs_copy()
> >
> > Which is where the check is done.
> >
> > So we are holding the VMA write lock, so a VMA read lock should suffice=
 no?
>
> Yeah, even better!
>
> > For belts + braces we could atomically read the flag in vma_needs_copy(=
),
> > though note it's intended VM_COPY_ON_FORK could have more than one flag=
.
> >
> > We could drop that for now and be explicit.
>
> Great!

Overall, I think it should be possible to set this flag atomically
under VMA read-lock. However, if you introduce new vm_flags
manipulation functions, please make sure they can't be used for other
vm_flags. In Android I've seen several "interesting" attempts to
update vm_flags under a read-lock (specifically in the page-fault
path) and had to explain why that's a bad idea.

