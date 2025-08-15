Return-Path: <linux-kernel+bounces-771407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9E0B286AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D28FB62F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D22BE652;
	Fri, 15 Aug 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHDBQ3GY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D029E0F5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287398; cv=none; b=Rgnkn1ep7rc+IrAWO74KskiSmSeC87+Vc+NAaoD75nYbBUeZ05bbCz79EM0Uhk+51wTOgVx45FNN0sWL+ztXKkxCNqWIuZPCWimiit/yCUkKy65EW2fISdEGprvzlhHOIhi8K+Wtt4aJptuEJyHLaFRZTSi4RXRlVu/iQPKmTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287398; c=relaxed/simple;
	bh=j97vdFA9U4QGqEQ1/ye/8M/QyBN+hpLQP2wsUPOYpNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsfdCbeDyJMqTDOdrAannBt09hj+rXeFjGXobu5mkS6ZL5fYNTFuRyiir4J51TP6gnQSOHqf13737aa7aBEGFqNCCCua4dTDx5SjjTFcD+Be3eMnJ0QXiHkveY4VFp6W+mRhlY+Kpxn/lthMjac8IAsN4fFVNH3X7ojYXjv+xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHDBQ3GY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-617ff2c8e5dso2738a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755287395; x=1755892195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UInFe0pIryJwKpyf9V2qNNpiLrOP8TGk1w7yYzwDAIg=;
        b=NHDBQ3GYaMYewgp3DfHRxcborvSNrhKkjxpgtHpkV4nNDfNekgyvh9Dgr4coYUMnML
         FYAFmsKlvnJ/cu8upbBRF9tloBT3PDMcnuo7ZXjtnkzqax86DfsQnTTvVvbBcLgYl3LK
         kflqd2Go5k1RWbtbXEatLOAbUul5eohBImiqJdApghR5sPXnoqvo9Dr9+Da/hunrebOa
         SY2WZwJNaDlOIEA8ufTAIAEQLwuf0fBzlc+eCAFdKTdFLoEtY7Gkd90AOLXtceHHkLZe
         +xfwwvn4iYAuI5w11igmNZmCkEd0O0AdZwWnp107lQgpO2Rgn4Tnye4SQ/lGL45v6caB
         7YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755287395; x=1755892195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UInFe0pIryJwKpyf9V2qNNpiLrOP8TGk1w7yYzwDAIg=;
        b=sHRofdRPbi2pZ0SWMBVpM3VNi2gFiZcvMl7m3xvbCEWbox87H+bC8x5tjFXMjdrmHi
         3vqdQRITs9jDPgAU4YnpturuV2NTsuMJkIYwSZtTpDG59+kjNKbLj6IXMfAyohAuORO9
         1XliXSmQ0LyzODKGHDIOEEHDn96R2nvEENElsYp5Nk4ju0isglKVy2dUStBZ70cRqiGM
         p35gVGhHSuF7OZvZZ63bDoMhmW/iJq8tatKXSf3cUKMeO5XKxLXHXnivbcyFfmk2sNQq
         gjki4Sf9j9s9rDIvgu/CcT1X92zVjFyMcU1/92y4at5Cl08bLtwQ1dCY9bwl2OHRI/vc
         nY6A==
X-Forwarded-Encrypted: i=1; AJvYcCWnqD42FhiNlR2UOQ3VYT3Rh9/zpZfhkY7fa/qJKw1iYbQ66P6ugz4xpcS5sFY2dNTmKB5miejuv8s9N7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxS4tHL3nlah5Jrfo1LyFKNpeE9OAC3hU8xxSr5VNKIa9gaBHw
	006ViJgdBvhbeVDOJl/XmmsXAEA+YBGoOu/Jhb1wlIrWWZvZmMPgrz8p/zhDhyoEmbwZin9zzP6
	rF2sWisS1u9/0uevk8eI8SIMkTwD84rVaLlEWX11MITsLL9xdqxlEg/GU
X-Gm-Gg: ASbGncvyrq9eeCZtDAjNtIxRaR8RhM0fuChYUBohaaGmlaLfCVfhkUZOVgu8EqYYcAI
	TrHS55z5H83LDgksdA9OsLwTHig1VWOk3PXFVANxQvDOiWh88Kxsozw/+cuQppkdxD0PRgZD4KM
	U5fFnSNnBPdYhM1MJOa94r0TSQnNHilVP7y/83PWtITej/7KQfIvyfyqZpoInKYovN3PLoaYHyt
	K3Sl26Uxp5N2eKKTePIbgxTMTVPA6yB25s51wYKw4WFhcrYVl8=
X-Google-Smtp-Source: AGHT+IHxNrlmqZyfYciekU5+d6eaqXM/ov0XqdYnqaC7l+XCzctcBfE4hDpP9zRtYdE4JO88lGZIuEq3KOi95OCNsHA=
X-Received: by 2002:a05:6402:46d4:b0:618:4ac1:e6a3 with SMTP id
 4fb4d7f45d1cf-619908d90c5mr16582a12.4.1755287395136; Fri, 15 Aug 2025
 12:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
In-Reply-To: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 15 Aug 2025 21:49:19 +0200
X-Gm-Features: Ac12FXyQ0zkghdneNsoye3kR5up2ZVBa3nbGq4Ss6rrLOyrAGrNk9qowXO2sZ80
Message-ID: <CAG48ez2FCsKNNaKa5Y0xBJTdtzptoCxM_+XNNg=bUMgoLDyC3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Remove XA_ZERO from error recovery of
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato <pfalcato@suse.de>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> Before you read on, please take a moment to acknowledge that David
> Hildenbrand asked for this, so I'm blaming mostly him :)
>
> It is possible that the dup_mmap() call fails on allocating or setting
> up a vma after the maple tree of the oldmm is copied.  Today, that
> failure point is marked by inserting an XA_ZERO entry over the failure
> point so that the exact location does not need to be communicated
> through to exit_mmap().

Overall: Yes please, I'm in favor of getting rid of that XA_ZERO special ca=
se.

> However, a race exists in the tear down process because the dup_mmap()
> drops the mmap lock before exit_mmap() can remove the partially set up
> vma tree.  This means that other tasks may get to the mm tree and find
> the invalid vma pointer (since it's an XA_ZERO entry), even though the
> mm is marked as MMF_OOM_SKIP and MMF_UNSTABLE.
>
> To remove the race fully, the tree must be cleaned up before dropping
> the lock.  This is accomplished by extracting the vma cleanup in
> exit_mmap() and changing the required functions to pass through the vma
> search limit.

It really seems to me like, instead of tearing down the whole tree on
this failure path, we should be able to remove those entries in the
cloned vma tree that haven't been copied yet and then proceed as
normal. I understand that this is complicated because of maple tree
weirdness; but can't we somehow fix the wr_rebalance case to not
allocate more memory when reducing the number of tree nodes?
Surely there's some way to do that. A really stupid suggestion: As
long as wr_rebalance is guaranteed to not increase the number of
nodes, we could make do with a global-mutex-protected system-global
preallocation of significantly less than 64 maple tree nodes, right?
We could even use that in RCU mode, as long as we are willing to take
a synchronize_rcu() penalty on this "we really want to wipe some tree
elements" slowpath.

It feels like we're adding more and more weird contortions caused by
the kinda bizarre "you can't reliably remove tree elements" property
of maple trees, and I really feel like that complexity should be
pushed down into the maple tree implementation instead.

