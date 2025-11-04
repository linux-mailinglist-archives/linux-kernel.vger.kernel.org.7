Return-Path: <linux-kernel+bounces-885378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF625C32BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FCC189D9D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7633BBB9;
	Tue,  4 Nov 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NtTdbvlW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8D2153D4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283288; cv=none; b=Kf33tasJbnTXeEGCK2LZeAxtA3s3zj9tKbdpOMQFCRagqqKDWxWqLF1fUjJsRAC5MgxIEVQ5MMucFgjjRI7tALmy1eKJeUC+Aa8yc5r60kO1ZlW8KUE1QmK69ZbWUd5nqwk6g5UCOQTMMa32LaDOKsJZ5FrP9DOD6qreAHCeMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283288; c=relaxed/simple;
	bh=9PbXECyM/ppEw73G19W07knzHtFK2i4sPouqb3V9IkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fytGqvsBPrKFfSO07lcY+j6+5jbEcMSWJBLTl+cmC9vDNzhk9m0YxxjGUPbhjd6sFrSjPQawCYuwnk8bQwHRm4miuPBaeqy1bCr43TQWHicTjNZj7aqNgYpZEfw2j0+3mAPdRtdZn4TgiMo4+hzAGmR0yYxSRTGkODbgjgbVuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NtTdbvlW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso254274466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762283283; x=1762888083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q+hzUPNbXmbOEbK0/6dvG/NjDNLu+WmiU1f8ZDEUtyo=;
        b=NtTdbvlWpIMjf3SpD5hYaJ1IrX4hAIfIGJ+BTx6ZIb2JKBtUulVoAHgLgUNa9Iyw1+
         0PYw+VAMYmueH9izFn04danNlhwlp7wO9VVKsOgFAhsFTetPrcWn40JzILmY9+g+P2X9
         xnumXBjrsEGDGO++2cE2RGrwfgBwmfPgSSpFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762283283; x=1762888083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+hzUPNbXmbOEbK0/6dvG/NjDNLu+WmiU1f8ZDEUtyo=;
        b=YFdh7DTvuLGnQLNN+lqszw+2aGU1jigMsGJNS5NsgPkSNUbDhY8qNtPdgs2L8cSxxi
         opf+RBHQXU+zUsC9InKR+cRCedIiO7f0StWfJKJThxIHUhxtlkuY1j5a1+D8gNBwzOVy
         9/F7WTIxfz+jcyi/tWaMDoUntd2j4/TDus9//O3HLEtRUPQG4yFUedzsQ+9MUe5lilj4
         qeg+PbJTZ//UqA8F5LO+ghrdhJicYUmW6EzHiRIW9LaD8K4UVWEYBl9A7xAkwSddw3nX
         sw66yXNUEw6LaUflecls+uBpF6B/+Kk0qH75M/W00OExQeySB0gFXNofVaP0nngmmYFB
         SnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpeX6aNISC7Y3GAobIpBC0WyI8WcNiWfhvmWCkUD/7Di6Sk6aKtjNNdt1PUmYs4f3TWMXNV0VEhi7Pixg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzkppvTHEgk1IjCithq2TDsP7x/ZBDOx6jMeakikG5LLTynA7
	Pk5rZPVvUJlQ2GpClPN6ic2yhEPz9oegZpOKo8aWiSqRdbRNZ75VqSrntINTh4kcn2+U6WXp/sD
	UEb8iUU9pDQ==
X-Gm-Gg: ASbGnctfi3AIBwJgsoMFR+5xu+HnHyag1L5HtHPx7d7dC6frrLakdyw5LnF57utdKat
	D05mEDQNqAB1n7MPngS4dJjPe/HtU7h2Gpyv1dmeC8gDKKI0VonGnqk0J97gf+jsB1xKQ8QwoPP
	0ann/JKqULLHT3q4GyTKGL2Ri4G6c8wsGuV9Hb7duURPFBhmVZTwXf41razfHa2V7X8iQKbMBh1
	pllTetS9Q3sZc+HjEovkk8xl14UcWv8L7iPEwQxu9LmfHhetD4RtnMQ4ZVoiDAJx0/WvZ/VxSBM
	YbzWKyyxLWt80Tv3bl7WfRu4wOtuj8rHfV0zdJt4Aq6p06PisVPn39aI5+7zpu4KBEEX/2GGK+k
	n1EpG2D8tTAsZlil2pT0DwkYl8ZEX0hlTOQs1hx098M0xlz9he0jBPxC6zwohUvAjrR7CJ3/Jtg
	z2Y2Tw+ZxDb4ma61v5OzN4v97arlgc1zCscMJ149VXpuUFqX28kg==
X-Google-Smtp-Source: AGHT+IE+87d921Mkd4U9AR85v63eIjOOusEoxT/EObLG4kNNlcmZoQgpNpgNTKIMV/swSnkfxhl5bQ==
X-Received: by 2002:a17:907:26c8:b0:b71:75bd:cf51 with SMTP id a640c23a62f3a-b7265587b30mr21059566b.38.1762283283565;
        Tue, 04 Nov 2025 11:08:03 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa038e0sm290675466b.54.2025.11.04.11.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:08:02 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4f323cf89bso296983366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrky0r8AjyBNDtoFzgvF9780zyd5rWvi/81sDqEPK7lHNuTucGaNbx9Vnmf/zxzbypI/WtbsfDpq9YTZU=@vger.kernel.org
X-Received: by 2002:a17:907:3d44:b0:b72:5a54:1720 with SMTP id
 a640c23a62f3a-b7265682b6bmr19875966b.57.1762283282425; Tue, 04 Nov 2025
 11:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com> <aQozS2ZHX4x1APvb@google.com>
In-Reply-To: <aQozS2ZHX4x1APvb@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 04:07:44 +0900
X-Gmail-Original-Message-ID: <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnsJnu_LlkWN2ZcU9tBsfAEnxyUDvIiSqWsCKYbcoFT1Otlp3W0KDjsg8g
Message-ID: <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Sean Christopherson <seanjc@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 02:09, Sean Christopherson <seanjc@google.com> wrote:
>
> What exactly is the bug?  Is the problem that module usage of runtime_const_ptr()
> doesn't get patched on module load, and so module code ends up using the
> 0x0123456789abcdef placeholder?

Yes. The runtime-const fixup is intentionally simplistic, because the
ordering concerns with the more generic instruction rewriting was
painful (and architecture-specific).

And as part of being simple and stupid, it doesn't deal with modules,
and only runs early at boot.

> Just to make sure I understand the impact, doesn't this also affect all flavors
> of "nocheck" uaccesses?  E.g. access_ok() + __copy_{from,to}_user()?

The access_ok() issue happens with those too, but I don't think there
was any way to then trigger the speculative leak with non-canonical
addresses that way.  Iirc, you needed a load-load gadget and only had
a few cycles in which to do it.

But in theory, yes.

> Looking at the assembly, I assume get_user() is faster than __get_user() due to
> the LFENCE in ASM_BARRIER_NOSPEC?

The access_ok() itself is also slower than the address masking, with
the whole "add size and check for overflow" dance that a plain
get_user() simply doesn't need.

Of course, at some point it can be advantageous to only check the
address once, and then do multiple __get_user() calls, and that was
obviously the *original* advantage (along with inlining the
single-instruction __get_user).

But with SMAP, the inlining advantage hasn't existed for years, and
the "avoid 3*N cheap ALU instructions by using a much more expensive
access_ok()" is dubious even for somewhat larger values of N.

> Assuming __{get,put}_user() are slower on x86 in all scenarios, would it make
> sense to kill them off entirely for x86?  E.g. could we reroute them to the
> "checked" variants?

Sadly, no. We've wanted to do that many times for various other
reasons, and we really should, but because of historical semantics,
some horrendous users still use "__get_user()" for addresses that
might be user space or might be kernel space depending on use-case.

Maybe we should bite the bullet and just break any remaining cases of
that horrendous historical pattern. There might not be any actual
relevant ones left, and they should all be easyish to fix if we just
*find* them. But we had that pattern in at least some tracing code,
and I'd expect some random drivers too, just because it *used* to
historically work to do "the user access path does access_ok(), the
kernel access path doesn't, and then both can use __get_user()".

In fact, Josh Poimboeuf tried to do that __get_user() fix fairly
recently, but he hit at least the "coco" code mis-using this thing.

See vc_read_mem() in arch/x86/coco/sev/vc-handle.c.

Are there others? Probably not very many. But *finding* all those
cases is the painful part.

Anybody want a new pet project?

              Linus

