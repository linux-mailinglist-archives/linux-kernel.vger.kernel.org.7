Return-Path: <linux-kernel+bounces-780535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDBB30328
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167A4604C65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26881214807;
	Thu, 21 Aug 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBZMjcAS"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305861C8603
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805557; cv=none; b=ug0884eMNIvQeVRESMOVfsLhJQI4abIiH0igq5ITZSooBP6U/cW64QuWTadwyDcY+PKvSZwR5WnqsxnWFySpbYxwA0yvlYjO5kQlTAxQSztSdR85nu63qU+yXMzReH4Sq4f8vtKaF3jzdkZzjz2WxrHITA+nJk/9s+SQHvoVx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805557; c=relaxed/simple;
	bh=KDrvuX2+ZJ8PMYchA+/upOy3pQeS3VHdrN1A5HlRpYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPoAd+10agti189pxFTpdS4EkyFhFJRkUbC/5Zk0rV5fI2b6Tw0+f9H1zX9cfyLTzGhX88OYc1Q6Jv8OylGlmk2jH40Mas0tm2sUL/ooLYKMFEAmn2TyJUNzyKGwQq+WXId+9+C/cGVuCwP6iOC29nAZ5BVv7IfZ9U5C+VHtONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBZMjcAS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266a1e87so1382248a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755805554; x=1756410354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBe8oFkS0TaasrcFBdxI4bV5ZS02PxKLMpjScwmrTBM=;
        b=mBZMjcASMu0WZrM1QG5GlgouJvrDNG9PbV5rbahbPb75i2FCNgRrbtBlsFyo0mRopQ
         s1uIL/7U2DjwTymYp2TosvLHSkkOybU6R8/kOnKsN/mUSzbsyoDwZQEUw2y8jQUXLZll
         gogLzQlcRwo0wuEBgW7wjfUOt6oATKVF+5Lr7XseYQr1J/pgMV28+98dhnvqv17ofTeu
         E16Qo/iGKviDfNXxVvD4Oydh4O7tn48piAjkBETxpy9rS4WNotOo1+J+w0k2OvAPiFbh
         qRLab5qrsd8oLTbGw/I/uy0yJ80gNGXgKtkHWtRBONmGHgCi4sVGr+Ss5RUE8EtsKKAh
         qJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755805554; x=1756410354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBe8oFkS0TaasrcFBdxI4bV5ZS02PxKLMpjScwmrTBM=;
        b=IA30YEXlAxWNOfnWTmIGhROSQfpqq0fguNh1bDd3ohjM/1uH6Ru4p7sJ7nT0HqR3MS
         FRK2Etj/DhIspmKebNu0n+g/jvhRHhApR3cj5TKcK85F7iAzVFtAHUgGAANdzOYIlWgJ
         IQqS07W/t5ygSnZ33P0BpQLZGVn0LsC6OhQ3PusX24Df2wEo3+AFLE7iIK863V+6U9G7
         M9hUifpDnt+5Vr5EOPQbrHQqtt/Ymy300SX3AtGq71ZqEHByGZwYTG6h9Tj9uGl6Q+aG
         YL6l73k/MZKoeYKylCjpntRwZyHhD7q5dgzAT0V4WqAn2Yf/AZUqmJyPjn+DVEwe5GVl
         DywQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQn/tSS+YVj8l/KHA3u6IRL2ugbryO/q3if+jRTIXvfbdKR20pOUDizK6ZemKQxJNEQVd8T+TCmfc9cao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wJMwJ/c67qMpS9+8tJFChtIXxc8KbN9U9pVBnFxvYWDCFbZx
	RWA8pNe3Im7pa8yF0nwlVxZsT0ONKdD+dj6qb5Un4H1nB7yl3iiYi0Rzq4XpZHOxh0vLTnQce4F
	IKgMdrA==
X-Google-Smtp-Source: AGHT+IEo3yLuGQVILpS1tYtl90+XHbY6Qcq9NXFmWWu02bkntnLYkBb1CoazK3fjI4rrngnBGWxBf0AndXY=
X-Received: from pjbof13.prod.google.com ([2002:a17:90b:39cd:b0:31f:6a10:6ea6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c87:b0:31f:2101:849c
 with SMTP id 98e67ed59e1d1-32515e48b22mr1029506a91.12.1755805554476; Thu, 21
 Aug 2025 12:45:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:45:52 -0700
In-Reply-To: <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local> <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
Message-ID: <aKd3cNJqj6_g_ATE@google.com>
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
From: Sean Christopherson <seanjc@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 21, 2025, Linus Torvalds wrote:
> On Sat, 9 Aug 2025 at 14:02, Borislav Petkov <bp@alien8.de> wrote:
> >
> > please pull a locking/urgent fix for v6.17-rc1.
> 
> Ok, so this clearly wasn't a fix.
> 
> > Thomas Gleixner (1):
> >       futex: Move futex cleanup to __mmdrop()
> 
> So this causes problems, because __mmdrop is not done in thread
> context, and the kvfree() calls then cause issues:
> 
>   https://lore.kernel.org/all/20250821102721.6deae493@kernel.org/
>   https://lore.kernel.org/all/20250818131902.5039-1-hdanton@sina.com/
> 
> Hilf Danton sent out a patch, but honestly, that patch looks like pure
> bandaid, and will make the exit path horribly much slower by moving
> things into workqueues. It might not be visible in profiles exactly
> *because* it's then hidden in workqueues, but it's not great.
> 
> I think it's a mistake to allow vmalloc'ing those hashes in the first
> place, and I suggest the local hash be size-limited to the point where
> it's just a kmalloc() and thus works in all contexts.
> 
> Or maybe the mistake was the mm-private hashing in the first place.
> Maybe that hash shouldn't be allocated at mm_alloc() ->
> futex_mm_init() at all. Only initialized by the futex code when
> needed, and then dropped in exit_mmap().
> 
> So the problems seem deeper than just "free'd in the wrong context".

Piggybacking the futex private hashing attention, the new fanciness is causing
crashes in my testing.  The crashes are 100% reproducible, but my reproducer is
simply running a variety of tests in parallel, i.e. isn't very debug-friendly,
and the code itself is black magic to me, so all I've done is bisect.

I reported the issue on the original thread, but haven't seen any follow-up.

https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com


