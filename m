Return-Path: <linux-kernel+bounces-745956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8BB120F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652E41CE633D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC012EE5F2;
	Fri, 25 Jul 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWdS952j"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15972E54BB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457270; cv=none; b=S1C8aqQN6yurDfgDVs3bhYApui4joDRFH/iwG5lx9Q0lpWyqB4sj17uD/7vjkHfUnP2IQXrMy1s5hmREb0u+qwAl5O1GgmhgKRpLxnr8w6aipggvrLRtQ3CuaM1r3VE1BdhfqcCcQ27jcST/ux88sCSKgfUNcqFF2GuTHXCyHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457270; c=relaxed/simple;
	bh=heucYa9tkBbiVjSZTaVAyzcUPy+E2SStTDCL3AW7JpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgRLwHCYOnwrRKyPA7Aj/Y28iLcViGwiLjNhVSZOTaO9+h3yp0+aVGWC6ZeJq7FQ15fsLyNKDjpZ88XMs5b1AFIwJsTL2B4JGUQ8SgSN0H0dnfIm4gzGhlpMMrMX55ncGrM77CAsb618wgrrroccImFcBhon+GWWd/UMQgf0PKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWdS952j; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso11897a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753457267; x=1754062067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heucYa9tkBbiVjSZTaVAyzcUPy+E2SStTDCL3AW7JpY=;
        b=VWdS952jpbwZTd76GZYlT/HNwK2rR3gvZNGAWX1nghyDkyNjQFULg2h/AEfN+WwzO+
         LWnEK/W4vE+Ns/461DPFn+auHyy8Hw8urysgmZB4D57PcWmp2K9y4/NvHPoFmUaOH0Lt
         5Q08z3DUxQGaVaSY5NJ6ZngQPaulIor4S+3XO/E1K340ZBL1+OVCM9SqtXgIO63Q2r4p
         G3gf2ADfpaAvvWJjzctsdBkDxPc+S7YrUttZidsgOxD+Pl1zzlrRF8BBUJdUDdvAg/cP
         ORCp0ckc2zSzFz7gCx0haKG4jsIimnCeno4lT599lCUQBGvHBuaxSb8M6W51yCdHMCrZ
         3U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753457267; x=1754062067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heucYa9tkBbiVjSZTaVAyzcUPy+E2SStTDCL3AW7JpY=;
        b=SlVz7XorZs5PBv4OneDnTm52AV4LZ0svtAacVj9sdYf+mHgUk1iwEhnBGUlA+3wedy
         krOBBSyei5KglTxXT/BrbE1VM+9ufkobeZk30EYW00izd+SWKM4uzrQxy4RyyS1litEN
         V3JoGfpbMabFSJBVOtQKB5lpJ7ZgTNoVBHHe4lhyQAMiOVQk3dzriw4xx27oN6KWVmLx
         AIQaywea6pH07hVSW9tnwb/LmciijoNisUHBwx5LM3abMu6wBsXKGy8OlDlQMyCdj512
         0N1IFSkLCFu4930SQmibixTFZT6imm8U10BbcmNmsfwBV7Wc1BU3WmEU1k9edbOtDyka
         UhOw==
X-Forwarded-Encrypted: i=1; AJvYcCVnXiTeqSUsntaWSR/EouKVfQwXkst6JlVyeNlrMiLY6jCPegMz6Wjphrx4Z0kNN24F+K3721jLbCsd47s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIrT42M4oBToSbf7+JNKKjQH4+gj+ABPDVuphNHkuC4alMMEd
	GgbVgULURwP305dyrXbmqIk9WDZyYWfunFoeKA2DBceUh6IPTVUuan3Bt+4sYH94cT2FuZRR4Vp
	WlDuHBVPQ5H0KCTKiX4eH7Y2uU6dVIjtyjeMjSd+1
X-Gm-Gg: ASbGncv07d4ebfeyfKh/cgQ+ssbHax/0DxPPBQhxzlblyrnsixk+IAmYVseygQZ6LeV
	L1K8S8AV2c6qVmNoCb6BaM9B9SQ/4TEANCOf8OF49ulHXb/PLXKL/Fd8w+yyqb0E8bdxmQecOks
	JavU4kk3c0KQv4G5oF2FXAZYSBslfO9bR5FXK8Q747c6oEefokNr6vS4Bo03GuSesA+oCUpMtZb
	1tIBVKoZuaSj9emcleF2TUPS+4taDa4TEqId45+qpNcEA==
X-Google-Smtp-Source: AGHT+IHmROIehhbYRxV/sAIn+yOhhSoj9REcttU7TNQcIOB5gzW1Kdwc/lbrdBYUHkCFLf9V422ymNC0rUd8uXdmbiw=
X-Received: by 2002:aa7:cd50:0:b0:612:e537:f075 with SMTP id
 4fb4d7f45d1cf-614ea7376b0mr81054a12.7.1753457266917; Fri, 25 Jul 2025
 08:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local> <CAG48ez31aVnoBiMMjUczbmThWnRGmod4yppgMVqf2Nu5-hjU2g@mail.gmail.com>
 <50502c3b-903f-4018-b796-4a158f939593@lucifer.local> <CAG48ez1TOULrpJGsUYvRSsrdWBepCJf9jh-xPpurRUXbMmAkuA@mail.gmail.com>
 <3cfc1146-1b62-4b04-a2e5-997d10ba4124@lucifer.local> <CAG48ez3aiXUmCqu2i7g6qrnVmZ6PRUsA-rQzHX1r8SXeYh2sow@mail.gmail.com>
 <f3e77eed-10b9-4197-b381-91c4ea3fc576@lucifer.local>
In-Reply-To: <f3e77eed-10b9-4197-b381-91c4ea3fc576@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 17:27:09 +0200
X-Gm-Features: Ac12FXxX-E0pa4qnmFlZi3v7jA9BWeiJRqZSsm3ywM6zYCVg5zIWDC8jcXl38BI
Message-ID: <CAG48ez2U5SSpRANKmUHmZkj62tDa3tYA06jem-i0G3pDGMJToA@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:22=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Jul 25, 2025 at 05:15:45PM +0200, Jann Horn wrote:
> > On Fri, Jul 25, 2025 at 5:07=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > Basically CONFIG_SLUB_RCU_DEBUG turns kmem_cache_free() on
> > SLAB_TYPESAFE_BY_RCU slabs into something like kfree_rcu(), and this
> > allows KASAN to catch UAF access.
> >
> > > It's surely only UAF?
> >
> > I mean, "UAF" is kind of vague when talking about SLAB_TYPESAFE_BY_RCU
> > slabs. I am only using the term "UAF" when talking about a situation
> > where accessing the anon_vma object is entirely forbidden because an
> > RCU grace period has passed after it was "freed" with
> > kmem_cache_free().
>
> Could it not be either case? Or are we sure it's been accessed within tha=
t grace
> period?

If there is a bug here, it could be either case. The check covers both
cases in CONFIG_SLUB_RCU_DEBUG builds (as long as the object hasn't
already moved all the way through the KASAN quarantine, the usual
KASAN caveat). Note that atomic_read() implicitly causes KASAN to
check that the object is still accessible.

