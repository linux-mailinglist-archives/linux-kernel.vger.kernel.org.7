Return-Path: <linux-kernel+bounces-738633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A0B0BB46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03AC1757D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3601EB5F8;
	Mon, 21 Jul 2025 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piIanauV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037B1E515
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067669; cv=none; b=nfgcZTBrmTYXIAxhJ4GXRAMksW2A7/oWQIDh2IlVjpUdgih4WRm0bJSzZDtUoDpzB7v0T3CM07G0EkWdLzJ4vK608lBJNszsjsceJzJjZCa++5M0DD1KCjqPRlRAD6pVRDRY8wdD1t8V2ljkyIQsIK65vXPn6SevSQd/qSuciGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067669; c=relaxed/simple;
	bh=rPZ9ayMN8Cc4EBmBOnIiNRGT5SLNiYAA/yLJOuSayAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqCpOvH3Q72GtE1E2rE/DvEOKFc8BAdQJ+A/4CoOKIjvMJTukItFQMlrFxz7ub47VYWo+nEfaG3qFeq2qz7jl+9su+0lXmZqLFVhRxMEKsvRG/869zBmIO3oTllBkutTevSD6vNNtK96VUTRhWlb4a1r3xAL80hsq7JeyKBkKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piIanauV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773C3C4CEE7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753067668;
	bh=rPZ9ayMN8Cc4EBmBOnIiNRGT5SLNiYAA/yLJOuSayAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=piIanauVRrfkGk2H2fWBoj4mIs8kIgUgdz5S+96eTv4tUrJ+wSP5hCqkmRfUnlq1Q
	 QPShTk4IRvrwOp0Z8hRERXx14pczi3y5C9t6dObfUNH6IfNuBOcgUkJJaMFJ7WXAuK
	 e2tZ2ZyL/Cb/R/wOPOk517o59f1vywIQ5eHkjh3kMnm3vWJBPRUAzs58InGCsvBegy
	 GSAqhkZLFRG5KPU6QMmf+RjkFKJsmzF8a7ye29fHdz/z6DVbtfZhP4z5NhWgQC6GYq
	 kowmtVCakzr0IbCrB+slY0U61qenIM4bzN3KeoakIDPxF5PNP72jbJAoawL+Rtnq2z
	 /NU/QGGUdSz/g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso3940721e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 20:14:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg2B9rx1LbTZH57GD4Paq6/cEWt20lnJCGno3fnraJqL40WRjNUtO7JyIilbUqVWvPCm9rWqTlljmBs1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRGrFlb86HOFQFEEAkjA7/AFAeh6J2DmNnLkg+whQ0YJQAYZX
	p95KM9JUMz4SWYzZyuk0asX+XeUS+5wEGNRHLyinKqxY0IJwDWjZe2yffrup96q9ktEdo58UcA4
	dfp/I5FhPvBxAFUvzbUBo8RY/SZ6qfNI=
X-Google-Smtp-Source: AGHT+IFDMrWPf3hUy4HTrGT5nvv60uOnGnpOEYtMxmHGYhVcwoSqQDVVppFjYvOX0OniEcUgPL4ujGvztnHi6sUf+Ug=
X-Received: by 2002:ac2:42cf:0:b0:553:d7f1:6297 with SMTP id
 2adb3069b0e04-55a3188e89bmr2186884e87.34.1753067666885; Sun, 20 Jul 2025
 20:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175301303546.263023.1426155806374119244.tglx@xen13>
 <175301303889.263023.7762556142250207604.tglx@xen13> <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Jul 2025 13:14:10 +1000
X-Gmail-Original-Message-ID: <CAMj1kXF_-d4_VVO+RovbXxoK=Gh72yFvHqEdRJ6rQBpSzB+1Gw@mail.gmail.com>
X-Gm-Features: Ac12FXzyHkD-5S3v8zdmq0ZiuXj63G0DQI2jW3YUv9pefgWFCDitHXetF885tz8
Message-ID: <CAMj1kXF_-d4_VVO+RovbXxoK=Gh72yFvHqEdRJ6rQBpSzB+1Gw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v6.16-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 04:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 20 Jul 2025 at 05:05, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > A single fix for a GCC wreckage, which emits a KCSAN instrumentation call
> > in __sev_es_nmi_complete() despite the function being annotated with
> > 'noinstr'. As all functions in that source file are noinstr, exclude the
> > whole file from KCSAN in the Makefile to cure it.
>
> Hmm. I'm not entirely sure if this counts as a gcc bug.
>
> In particular, look at the *declaration* of __sev_es_nmi_complete() in
> <asm/sev.h>, and note the complete lack of 'noinstr':
>
>     extern void __sev_es_nmi_complete(void);
>
> and I wonder if it might be the case that gcc might pick up the lack
> of 'noinstr' from the declaration, even if it's there in the
> definition..
>

Just tried this: adding 'noinstr' to the declaration in asm/sev.h
makes no difference at all.

> The fix for this obviously ends up working and is fine regardless, but
> it's _possible_ that this is self-inflicted pain rather than an
> outright compiler bug. Because having a declaration and a definition
> that doesn't match sounds like a bad idea in the first place.
>

Agree with this in principle, and for 'noinstr' in particular, this
may work fine but note that there are __attribute__(()) annotations
that make no sense, or are not permitted on [forward] declarations,
and so having the general rule that declarations and definitions must
have the same annotations may not be feasible in practice.

