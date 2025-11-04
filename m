Return-Path: <linux-kernel+bounces-885216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD3C32472
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BC01A21D63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AA332907;
	Tue,  4 Nov 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKI1GZDP"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B028299A94
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276175; cv=none; b=BevK4v6+vWhRZm+zwxFRSPrd1sgOBPw7dNAKSb8VYKtQ0AAgX7FmVOpo4HLH1a6YUlWAi6rve3L00NL3ROxbxFTmh1Qofo2mSgOrkzu6wh6ZYtSZxJppl9wcxVUFs6UJXG0OwFAIFN83PXQkuZKgnQRtR2NIycP/J/VHZDxYYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276175; c=relaxed/simple;
	bh=fLYNppll6t3kLWAUaRsq8n6hnetj7Sk9RdC7VbI1fIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GdxfOQ3TRvz9JamNe6YfRZiAmmhH/xCg86zQiDBPAUXhH0k5jBSHTcl0PCI0135OJTE9fJP6/jq2wsGE+787pg4aye6Yhc8zaxfYUYiNaheUYePfelnN02GbYeSYE4r1EU4m3ds5TDdRckCiuBauTFOZUFwXo/JvNUE69h/gqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKI1GZDP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2954d676f9dso28139995ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762276173; x=1762880973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESsFb4FWracpR2TzDvHPqwAo241JJ5KRosL78pKPvYk=;
        b=DKI1GZDPQpbxJw/KCBeQOHoRdMG/0Lc51DRCVJWmC07OQKU1HalByNewE+bf0UgAaX
         TLl9rQElzKjA2/DdspFbiZVivdMZICorCUOCW8quOJhsUkEa7mh79HLK27TDk42qaxI8
         e60BVi4Faw1PwiGoWuqzVpsWzI52mThfRTPxY31lvV3z1uQvIeakPPZOhgqInftM6tpU
         X1m4kXNQ/yypZgLTGMz5nPu3NeUK+Q6psW5BusFACuDQ012z5OfAVOGbsw/DQNmT0jMm
         l/JRuCyzg8r6EtzV5ngeQurpNa3xg3l54joJtouaxzAw+KErxv2EPWZI1zH7PHZ5gtnv
         kz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276173; x=1762880973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESsFb4FWracpR2TzDvHPqwAo241JJ5KRosL78pKPvYk=;
        b=N/FbMQeqkmg16g9f/8rfIL0MH5i822ycRhLJ3UguF5VRs5fzcn83zln9UnHWVX5uU8
         YPgRneYo83FFQtv70n6Tj64NKJGS8g8qVnsKgMtL+7QhyQHZ8aPu8i5zKMo/XrQ1Ws7s
         vjDR9EGRKFuXKw3V6Z1FPaYpY9HObYBZxqc/DhWzR41CaSMCvYj5oO3/zYSiO9HzmO54
         GJNiRTngNOta/7ZcpLO6o/tdsYWcFojSpZgQ+AY8d09AhZ64EPlAIDuAM7iVQsgx/+C4
         A2a6k1IcAxoJoQLqjwN19km6opdcZ+wksde3hLk8h0OqiueG0bWylxkSW/aHyzBbqSGd
         zHBA==
X-Forwarded-Encrypted: i=1; AJvYcCUKjuk0zmj8uWYvBk/CdgQfrFJRJ5XfdK75jH6B0qA58NcbYDR2q3ciBSoe0jxvyc7hLqD3CSm+IEwWO6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+QXNFKiDkgjdYbTIypzOw53bjGIcf4S6wwHd4W3DxASQgNrL
	JV/x31FOD0blZS0zLqzqn3yez7b3dcAFrf8uSx2fUNnUGdIZ2WDM24g5b+DAMBNlKy9mtE0306m
	WUiDPxA==
X-Google-Smtp-Source: AGHT+IGQ0sGhS55n4NwGqrLp7I4ZqP5sQwM1HuZAUZBARPNaZyXx2vgsm8bxhh6NIaMledcxEB/xQt409L4=
X-Received: from plbbd2.prod.google.com ([2002:a17:902:8302:b0:290:a6e2:2006])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b4b:b0:295:c2e7:7199
 with SMTP id d9443c01a7336-2962ae4c0d3mr3828985ad.29.1762276173341; Tue, 04
 Nov 2025 09:09:33 -0800 (PST)
Date: Tue, 4 Nov 2025 09:09:31 -0800
In-Reply-To: <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
Message-ID: <aQozS2ZHX4x1APvb@google.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
From: Sean Christopherson <seanjc@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 04, 2025, Linus Torvalds wrote:
> [ Adding x86 maintainers - I had added Thomas earlier, but I guess at
> least Borislav might actually care and have input too ]
> 
> So I think the patch I will commit would look like the attached: it's
> similar to your suggestion, but without the renaming of USER_PTR_MAX,
> and with just a
> 
>   #ifdef MODULE
>     #define runtime_const_ptr(sym) (sym)
>   #else
>     #include <asm/runtime-const.h>
>   #endif
> 
> in the x86 asm/uaccess_64.h header file and an added '#error' for the
> MODULE case in the actual x86 runtime-const.h file.
> 
> As it is, this bug really only affects modular code that uses

What exactly is the bug?  Is the problem that module usage of runtime_const_ptr()
doesn't get patched on module load, and so module code ends up using the
0x0123456789abcdef placeholder?

> access_ok() and __{get,put}_user(), which is a really broken pattern
> to begin with these days, and is happily fairly rare.

Just to make sure I understand the impact, doesn't this also affect all flavors
of "nocheck" uaccesses?  E.g. access_ok() + __copy_{from,to}_user()?

> That is an old optimization that is no longer an optimization at all
> (since a plain "get_user()" is actually *faster* than the access_ok()
> and __get_user() these days), and I wish we didn't have any such code
> any more, but there are a handful of things that have never been
> converted to the modern world order.

Looking at the assembly, I assume get_user() is faster than __get_user() due to
the LFENCE in ASM_BARRIER_NOSPEC?

> So it is what it is, and we have to deal with it.

Assuming __{get,put}_user() are slower on x86 in all scenarios, would it make
sense to kill them off entirely for x86?  E.g. could we reroute them to the
"checked" variants?

For KVM x86, I'm more than happy to switch all two __{get,put}_user() calls to
the checked variants if they're faster.

> Also, even that kind of rare and broken code actually *works*,
> although the whole "non-canonical reads can speculatively leak
> possibly kernel data" does end up being an issue (largely theoretical
> because it's now limited to just a couple of odd-ball code sequences)
> 
> And yes, it works just because I picked a runtime-const value that is
> non-canonical. I'd say it's "by luck", but I did pick that value
> partly *because* it's non-canonical, so it's not _entirely_ just luck.
> But mostly.
> 
> That was all a long explanation for why I am planning on committing
> this as a real fix, even if the actual impact of it is largely
> theoretical.
> 
> Borislav - comments? Generating this patch took longer than it should
> have, but I had travel and jetlag and a flight that I expected to have
> wifi but didn't...  And properly it should probably be committed by
> x86 maintainers rather than me, but I did mess this code up in the
> first place.
> 
> The patch *looks* very straightforward, but since I'm on the road I am
> doing this on my laptop and haven't actually tested it yet (well, I've
> built this, and booted it, but nothing past that).

FWIW, AFAICT it doesn't cause any regressions for KVM's usage of access_ok().

