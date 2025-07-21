Return-Path: <linux-kernel+bounces-738665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E94B0BBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B6318963B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531101A841A;
	Mon, 21 Jul 2025 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqIN5L3k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F70139B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753071461; cv=none; b=kL9CyXw6SSJUBC5W+8QJoLRkONp6BTGizk2nQ2hlUW4p2C8Ol2nqL8vQa9XOciF+9F9pZVttYryErqmWbg9eszuqkLooc0d0Wsg6RKikYlcbWDaJETyl6e4fVY0ncxVThh0UpgWYD3SDdXk6Eil8sMQr0PvTpoqm2PTGD+Y1soQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753071461; c=relaxed/simple;
	bh=C7g3yJAkkhHHCKD/OZ1PORDYE0DNxYNY7RZwd+AT9r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/xd9KnPzhpNeVPEyjzWi2l3wSnpJXmy2uK0LhUgrLvmYQffsv+TW7UfJHMt1vOFeqSxIc4BUpRnrXhn72/5j5N448gldJEovk39IukiA/ybSc7jVo81NlUHQ2HbQUiw6m81a0rXSQBOsf+GuLIwOpIXKW8X6heRpJNJlKXblzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqIN5L3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B943C4AF09
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753071461;
	bh=C7g3yJAkkhHHCKD/OZ1PORDYE0DNxYNY7RZwd+AT9r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DqIN5L3kSRPbZsoAQe4VeajH/w7ohduJysdEihniZ7tqCH5O5DvSY2OF8UjL/r/GJ
	 JuF+xVY7MPf2egklPcNvDyDgN7mrfE9wVHXRDkoQ12HDy2ahIEfxRwi/Mgm3yA1S+p
	 RkZI4sFRH4RAy9Q7xkfgjDJxVuUZsx1zRoSTuqSZmrxBhz/aFYOZRb8bUsojJwE2x6
	 8t9nWJFqaOCMG5CteL9WexOHeRt0UKVWqbtWSLWthLC3rvY71TSp8UMJtCVU7eJO20
	 MrpisOskIAXRcKlqZH4zLekHogIl1LEXtOJEiUlpVrNfusTQAb0e2xh0qJlqElrvzt
	 u81FcTM29iWFQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-555024588a8so3650248e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 21:17:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ZaeS4l36HeDLYBnt8ZL4Y0WugKL/mMSFFryVQbhEvCEtz82lpcpXFF57fUF1Ba5E3T+9uHevjX12EKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjeQ4IP/m84xu5/o1VZ7Y42kG+82CRwZldjAZ4x8NYPu22rORh
	4Nv08D/hob76fdLETZ+E9Yfj4I2rUGrNBDtOVS90hdHTyy1rbZd01CMcw0+B+ZxnHRGGBY1YZGS
	OA3DTfHosLXhRytRR8GPnNvZR3P5wkLs=
X-Google-Smtp-Source: AGHT+IHncNY/j0Km9dwH5qZ8LBQgKu3d1OOjOLpPZOzfOiUFddXVoN5/0QVYlVWnNCzaOA2krknXb26VrBCX439yWXI=
X-Received: by 2002:a05:6512:110a:b0:550:e3de:63bc with SMTP id
 2adb3069b0e04-55a23f1c0e6mr4555955e87.25.1753071459561; Sun, 20 Jul 2025
 21:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175301303546.263023.1426155806374119244.tglx@xen13>
 <175301303889.263023.7762556142250207604.tglx@xen13> <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
 <CAMj1kXF_-d4_VVO+RovbXxoK=Gh72yFvHqEdRJ6rQBpSzB+1Gw@mail.gmail.com> <CAHk-=whvGhNS45F1huUNBpeh4O5yk-P04J1M6ugUedS+CQNakQ@mail.gmail.com>
In-Reply-To: <CAHk-=whvGhNS45F1huUNBpeh4O5yk-P04J1M6ugUedS+CQNakQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Jul 2025 14:17:22 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFQXv0PeJQzKP8vg_BGYFcknbCcHX7-d+6t=LCi=ofU_A@mail.gmail.com>
X-Gm-Features: Ac12FXxnVwJD-Kw_tIgkx-8W0apr76Yszp_557Sm2IEztfVuYg30Q9KxE5TRUiE
Message-ID: <CAMj1kXFQXv0PeJQzKP8vg_BGYFcknbCcHX7-d+6t=LCi=ofU_A@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v6.16-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 13:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 20 Jul 2025 at 20:14, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Just tried this: adding 'noinstr' to the declaration in asm/sev.h
> > makes no difference at all.
>
> Ok, thanks for checking.  It does seem a strange bug.
>
> That said, this area is a mess, and I really do think it's at least
> partly *our* mess.
>
> We should mark not only __sev_es_nmi_complete(), but the
> sev_es_nmi_complete() inline function wrapper as being 'noinstr'.
>
> But we can't do that, because 'noinstr' explicitly includes
> 'noinline', so we cannot do something sane like
>
>   static __always_inline noinstr void sev_es_nmi_complete(void) ..
>
> for the wrapper, because the compiler will very correctly say "I'm
> sorry Dave, I can't do that".
>

I also wonder what the semantics should be in this case, though:
attributes are generally tracked at function granularity or coarser,
and so inlining a noinstr function should either disable
instrumentation for the whole outer function, or disregard the
noinstr, as applying it only to the inlined code is not generally
possible.

