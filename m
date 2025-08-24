Return-Path: <linux-kernel+bounces-783429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB78B32D81
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A532080CC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 04:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09F1A5B8D;
	Sun, 24 Aug 2025 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xNe3UfLx"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9C84E07
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 04:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756009107; cv=none; b=VSVEPlObVtUXsvERMPjeZ9MI5h1FI7qdgJY4a5uOX/DRD8ETVO5WFy2DdFsv0K8lnTQ6R4EEZQ3NrORdWx5hKZWLhxwfLAMXZTybKO9lHQ5Sh0W/yqyZsOQUjdFwR9k/VyhhdFr1gu4ohi9nzYR52TDnWu23VYAwisst/QYq+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756009107; c=relaxed/simple;
	bh=wy3Tvp87h9AdcvZytbMvTJRVniWs335eIfh+J3xCN6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwBFT6JfPgbPLl56+IdtMvmg5y56IiZbjpjTLq1h1bVlMWmoFkdwBE4AD1jW4YUymox8nulyA2w1QT5ye/c7Osg1byoqG469eNY5Fvoq2rhtGZGQaH+dHk39bb3YAIDaWHItimbtHlNC2tMVFVH17cSHDG0YPdqBmbG7SEchzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xNe3UfLx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-618076f9545so4876a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 21:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756009104; x=1756613904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDkfim7mr7a4yUojop8vd0ATFOSgpSTb8reNVp1wDps=;
        b=xNe3UfLxcZKk/hKr8/UuP3uqlXrsjaJamK2awMPJI7D2Coe7OOkCJ9AcY3ipxNDxuj
         z7hyG+z+qrqLE+7YKlxchS2EAKKh6SLlhjdu2nc6TpCDxcktMhrlyKj1b0MZ38hR5QjS
         5+ALK1D59GhWpr/WmGIelGNrOIt0EDu9aOXj/jRdNlEmvdXffjRLSHifrSzWjwK5vOOU
         afYtgtf6t7tr7OR4tSwgLC7kzRKmkyxy0+A/GMpkDxOpzucoGzRDCKVajr+sVxJ9LRqg
         vyjw6Ym6Juokhf0QWPyQFLweUsgIQnl8z8Nhv4dMdUy3xitPB5XIuwjgVUPlySQVKNZz
         cW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756009104; x=1756613904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDkfim7mr7a4yUojop8vd0ATFOSgpSTb8reNVp1wDps=;
        b=ISYRD33QkfYsAc/khiSlYLdhDGae9yPyzR9kFLSmK6Qbxojc79fwVrapwI96tEIRXx
         OlPhyvdcNgPIACeNh9D017Z32vlBGdiybHfLiZdvEFjQAlFlt94ndcbuo+u+12J+Nkqp
         umwFo7/BUOFajZ6KGfxVIhAQ/nt9j7oh8RlZUEaY8v4xVI4S2RQhsjYPlqrpegDOXYGQ
         VtPpShQzOp7wHJoN3dizP7MEpS4EuAlCrEz5eviKuOPNpNbYZgPh4EMjJkA3992Dbqgi
         ek4LgjJs4RtxucDDy8VT3PTMXPqZ03zEYSNkabe048XRx/uPEEJb74fXu5+NCSb5bfnc
         tr4w==
X-Forwarded-Encrypted: i=1; AJvYcCXF7iNmkgdtWPymTDkDOVxoPLSkEMGNJk/BDPUmmUDaDvB61jhqosgXLD8BBcQP1HXZgrh3ByKcg1V+fmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRXR/w3OkgW4ExR41JHb3ETvKVBIlPPsEJC+a5VauAkQcxCD+
	lUdsu/Uc6e8pXd6Xbk2BtkAXlhrOTQqIl85naYSIxZX001V3Djr8YmVOlsYJNJuYio5HNvfYvqa
	xZ6ozA1HSMnJeXobfgRl8RazFgWYVZsbkfnCnLGFs
X-Gm-Gg: ASbGnctkNA6PkSmWBlU7/4UIgdRNXwudZVt3IVeOA2UXoFlcZ51EK4/xPqu3VUfJ0bw
	T4yZlic0BGiRcsgecrjO3jFyfzc+kZxGEGMpuwYh7kc7/IQr/ynRrRcaDO2Dc4/nBAsx42dF+Rr
	+0VOylcCSAlGrRhuOPNwKiwvz01eHHrB4A7mY6vr9JJDJjvSmHNi6UF36+p7Ml8j3oI2oeYrWLw
	O2Ogel9/9saI+QNsFUfbzULoDywN4fAzo7ujebTbfsd1vI=
X-Google-Smtp-Source: AGHT+IHIKQ3cw094VGjPpaAth752X722oMGWvEZSKC7NcrOHJ/wxzYPnBBhd8NLKWJ383A4CKTort8ybeKLqsLz34bQ=
X-Received: by 2002:a50:8d53:0:b0:618:8198:de66 with SMTP id
 4fb4d7f45d1cf-61c352aac29mr69238a12.2.1756009104038; Sat, 23 Aug 2025
 21:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
In-Reply-To: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Sat, 23 Aug 2025 21:18:11 -0700
X-Gm-Features: Ac12FXwhGKxi7sszb9FQfuKpWK6TDNlDZe7vik_4urMen1Es4eNpzZtoyOAFRuI
Message-ID: <CA+EESO7j4dY3KjBWybTG6uQmXJ8kyhBrid3rTk5XAP7poZOhYQ@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Barry Song <21cnbao@gmail.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:29=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> Hi all,
>
> Currently, some callers of rmap_walk() conditionally avoid try-locking
> non-ksm anon folios. This necessitates serialization through anon_vma
> write-lock elsewhere when folio->mapping and/or folio->index (fields
> involved in rmap_walk()) are to be updated. This hurts scalability due
> to coarse granularity of the lock. For instance, when multiple threads
> invoke userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct p=
ages
> from the same src VMA, they all contend for the corresponding
> anon_vma=E2=80=99s lock. Field traces for arm64 android devices reveal ov=
er
> 30ms of uninterruptible sleep in the main UI thread, leading to janky
> user interactions.
>
> Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> folio_referenced() is the most critical (others are
> page_idle_clear_pte_refs(), damon_folio_young(), and
> damon_folio_mkold()). The relevant code in folio_referenced() is:
>
> if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
>         we_locked =3D folio_trylock(folio);
>         if (!we_locked)
>                 return 1;
> }
>
> It=E2=80=99s unclear why locking anon_vma exclusively (when updating
> folio->mapping, like in uffd MOVE) is beneficial over walking rmap
> with folio locked. It=E2=80=99s in the reclaim path, so should not be a
> critical path that necessitates some special treatment, unless I=E2=80=99=
m
> missing something.
>
> Therefore, I propose simplifying the locking mechanism by ensuring the
> folio is locked before calling rmap_walk(). This helps avoid locking
> anon_vma when updating folio->mapping, which, for instance, will help
> eliminate the uninterruptible sleep observed in the field traces
> mentioned earlier. Furthermore, it enables us to simplify the code in
> folio_lock_anon_vma_read() by removing the re-check to ensure that the
> field hasn=E2=80=99t changed under us.
Hi Harry,

Your comment [1] in the other thread was quite useful and also needed
to be responded to. So bringing it here for continuing discussion.

It seems from your comment that you misunderstood my proposal. I am
not suggesting replacing anon_vma lock with folio lock during rmap
walk. Clearly, it is essential for all the reasons that you
enumerated. My proposal is to lock anon folios during rmap_walk(),
like file and KSM folios.

This helps in improving scalability (and also simplifying code in
folio_lock_anon_vma_read()) as then we can serialize on folio lock
instead of anon_vma lock when moving the folio to a different root
anon_vma in folio_move_anon_rmap() [2].

[1] https://lore.kernel.org/all/aKhIL3OguViS9myH@hyeyoo/
[2] https://lore.kernel.org/all/e5d41fbe-a91b-9491-7b93-733f67e75a54@redhat=
.com/
>
> Thanks,
> Lokesh

