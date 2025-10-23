Return-Path: <linux-kernel+bounces-866498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8542BFFECE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5804F24B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47262FC866;
	Thu, 23 Oct 2025 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTQUqEOi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889F2EFD89
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208156; cv=none; b=h3mFNRdXjPpyo9HCTr9TaUd+R918tVLDqjUzu/8wjK/XqQgASa6Wn0gcEiZrVXAWhH4wXI6f7CaSv///cU+omjAAFQzPCsm4r/y2GhZrOKDHOaAxqpuweG0yHxS5/WUfSA+OQhfJZrn5yGuNtsZZ49UMdduC2GZJmjgPBSVrrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208156; c=relaxed/simple;
	bh=hWUcRWE8F/J3v++Xj3pnJxnA8SssgzodvNyTl3jUPqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYsX62ow/hjL1auCLlw1M/dc6loXizItodRO33W7fktJIsPjKT6BNmyn7jicEYuNGMLTSO1tquOebt8Cz42JaY0C62PDXvetf0PkxzRbJ2ErN/lfiR5JrxYGD1gL0Jbdtx/t8iJN8gj+XXwoHcSr/3to40HXYo5RotKhHiLMi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTQUqEOi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47495477241so3783315e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761208153; x=1761812953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8217/lDsma24nzsoVUl8HcI8eQcrK7yDi+gF+9xDXDs=;
        b=iTQUqEOi9yw3gxo7kCXcnRaJjLCQSZ0yg9hhCNQhVNN5KXvVL3sjMOh/Y93CYHauBe
         3Et9gfvZCa9kDc3/acx+nbnQXJdzNABou1Frh6AvQbOnZdssw8an/64JXqwqfcSJyg4L
         I5LSRmIQ79P9jCS6uFn8ZIhYuWzSOarP2Eh20rptxH/RFmUIov9gOVYkDKTlb9UFuIE7
         J3qBfMKQEll8teDcKZtlhFp7Msi813rnMtDjozaMokqrgedfxfc8slCoFDhySLaRvoEv
         QzFjHln6A7WaTp5DWNcZt3doCaIKqojXTUv0sakTqeUb62Xb+L/l/u0Lsx+m9x+z8COP
         UM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208153; x=1761812953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8217/lDsma24nzsoVUl8HcI8eQcrK7yDi+gF+9xDXDs=;
        b=DfNFLkSg+dkn6gKDDd0fq675ZldoiKzYMjDwwaz/TbqU40S61GiFj3jJQfoWwD8DWw
         uU3l+EWcD2atZ9484/gTVYoGoIoxmBqw+ur8tFAuqt0Z4pBfkRYKSUH/usezoRxOYNev
         VqkooqD5LzDGEKij0vQbPcrk7Tx4g5/F2cpdH341E7erNA2TlJT2Q0jgNtJIovK2GQrD
         gZ0TPyfyUXk9wf5X3Pv/XZ2YafchphGtY2a9kQlw10StHVY34OE5KvODITA6gbwgF04B
         /KGn86oGQPvYOF/pSv8EgF0A6NMRxd9L00afCIcPvi4wh+IcBJ55A1aSzC1Iz8/6l4y5
         /neA==
X-Forwarded-Encrypted: i=1; AJvYcCWmtCHs1QLjJ5wRxPf8JKxQ/DZPE/2gleeuG8BM0o2w226dBAfRHFae6tST8sNAT4e4ZkWpEW9Jz3dv/UA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LCc2J5vqY3/vclOyLyQ1KhboRlGayGlOAHkK5KM4gHkibAXL
	fJnnJAVNQKeDAWSIS2w9XsXqBHPBhs89DzMJ6o87EjMsCwXG+gGNnM4m
X-Gm-Gg: ASbGnctPtjM6UTZHxDUoOldXCloej5xeQ2JlMw5HZdRHXanq4ni4PyjBVna+YAbiH9L
	pfwrA8ZpsFNTgrvu5Sd9s7gQRmGSU7PMYWvc4JxCsebnszQs+++3DFVmzgsyxgLRxX098kJ+acY
	i9SSXcpnp/bPpAJffiCoeCQZmWHdU/H3tPOArFq14MBufkrVk7qWmWS4D9HT+dbsdlRIjBQZgIW
	Ut5o6IVK3sRHZRl7gJXAVa8sGzMOwXXqCk5Wjjl2aY+JTWuVShzuzcBQkjLsO8mLCfKFTiP8+RJ
	ld0ggtMYmNphUckLdRysTs7vbP0gs3knNkHT0JtFmC5mhHWtKmLBnurI0B1Nd2r+/LD4POP7eV5
	rjwqoISZQuy/WogXavzt5vrjk0n29CoVJkkx5sRl6gZjRk+nfyUnt6FIqAUIJXukwyW941esnWJ
	4vbQycTJX/64uHkmI4tr7r5pVuOUM0lRbc11irQVRtDznei9DEbIzD
X-Google-Smtp-Source: AGHT+IHSgtH949jpIYqvryVHE7ahULmbxvweEBq1Xh1WJbPJkG9goEBlMqfaTmrq4Q942DJtzk78Aw==
X-Received: by 2002:a05:600c:8b35:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-475cb065415mr10429885e9.39.1761208152472;
        Thu, 23 Oct 2025 01:29:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf4642fsm23356135e9.17.2025.10.23.01.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:29:12 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:29:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Jens Axboe <axboe@kernel.dk>, Christian
 Brauner <brauner@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Alexandre Ghiti
 <alex@ghiti.fr>, "H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] uaccess: Add __user_write_access_begin().
Message-ID: <20251023092910.2ed9cf15@pumpkin>
In-Reply-To: <CAHk-=wjXGvUnmN5ZL3nhj_J0cbiVfeHsM9Z54A55rgHRUaVOfA@mail.gmail.com>
References: <20251023000535.2897002-1-kuniyu@google.com>
	<20251023000535.2897002-2-kuniyu@google.com>
	<CAHk-=wjXGvUnmN5ZL3nhj_J0cbiVfeHsM9Z54A55rgHRUaVOfA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 19:37:27 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 22 Oct 2025 at 14:05, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> >
> > unsafe_put_user() can be used to save a stac/clac pair, but
> > masked_user_access_begin() or user_access_begin() introduces
> > an unnecessary address masking or access_ok().
> >
> > Add a low-level helper for such a use case.  
> 
> I really suspect that you cannot actually measure the cost of the
> extra masking, and would be much happier if you just used a regular
> "user_access_begin()" (perhaps the "user_write_access_begin()"
> variant).

Or wait for scoped_user_write_access() to get committed and then use that.

	David

> 
> The masking is very cheap - literally just a couple of ALU
> instructions. And unless you can actually measure some real advantage
> of avoiding it, let's not add another helper to this area.
> 
> We spent a fair amount of time undoing years of "__get_user()" and
> "__put_user()" cases that didn't actually help, and sometimes only
> made it hard to see where the actual user pointer validation was done.
> 
>                Linus
> 


