Return-Path: <linux-kernel+bounces-845724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD3BC5F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95411892105
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43BE29E109;
	Wed,  8 Oct 2025 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D3J9+q3z"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59E209F5A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939543; cv=none; b=BrVdWEjfIrjIXicmWiQp5Hr0la41Htb5eFcxA/1x3ZILWtre31v+1S5pNfJvW+C1z2nGMEZoDMJyjCHDI22T0EY7gwe1mTzmYt95VPiE21yxQqy7mjXqKsHRYk1rmBDUgzh4qjzejHSjR9rGkBoqNKxdweXK0pcuPG0OPpzmliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939543; c=relaxed/simple;
	bh=yEQRjSwB6AJN4UUymCqU3OU64k64HmUpry2T3Ix/f1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDucSGdwzzD9RMsOG7nJK6cTxaS+xsDYAuv953E59No/pM62LSWw/f+iRasBl9ihW3sXROQCEMGA/tEBQFaZm+JDmuB3aAJjuey8Hehe/6BYKyC1C+f6pi7HFg35yLZeUYosJTs49GMxWGK8uLwgR+TpHSRFzBES/+g6z9njf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D3J9+q3z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e9d633b78so23711966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759939538; x=1760544338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q1/gcptaduq0AJp5G/NOWu9M2fXYMwaSCGFrpoYsoc=;
        b=D3J9+q3z/VzUStwjy2ymKw3U0Iw9F3xnNG1wLLzQF3yZvjCdWvBB40ycFjzeU2fgQn
         TYoG2Vwcui2v6O5W5SzXAnCAkB16kddkqBqMWFBw3MHFEUBwF8JcXf/SbRb1vnNU5sPb
         6zl5R6e1otDclOe8OSJPWILKLR4GEqFd9cg5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759939538; x=1760544338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Q1/gcptaduq0AJp5G/NOWu9M2fXYMwaSCGFrpoYsoc=;
        b=fBqqmUa+JGjKJXiMv7UJM9qyHFPglDaU5HL+tAi57JO0zj83PYxdNPAip3IhXbhDTt
         mEtPFBT1knE4MsbekInLq77Il6RYuABKPeCLFT/hkxdwebeTi3jam0ivF/lLLWCkAvLd
         IptZ8AoB7koia2WzcEMz/fPq+/SEgHnThgyOsWGvKlJLrks4TlDCDi2mNk8HINSaYlDd
         lGZ5zYCZswqRxAOoebODFFwW4Go9DL/tNXv/bJUlyYp/0KBtp8x5bG+HAq9NgH/kIi5z
         IRIjKhKGwvL1231+8zdtEOTBM+wrsK8WnpiC3BbmNnPt6djw0fpTnuZePp2mh3Y/V9Tn
         JrBA==
X-Forwarded-Encrypted: i=1; AJvYcCXoBfhjG7EgfjV6wbO4g6GRHuTFHMow9qy/LiZb10VaJ0IwQnzOjVJiue9mZsTAii12VHCgwP9Cxe3hcXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrB4VM+uXUws8oyTqsnLudr+TMCzaKuzIAb4wCgMkz7mSR8zRb
	Cool9XWG6L5A7h66LziPQ5ymi2OdTlMVOItLCH+UF3WX7xRiE80giGlRYOSm4Z8CpGB9J0VPoCx
	7y7XF7pk=
X-Gm-Gg: ASbGncsl+deLkZ70Vn92xCRCO9TfjDKUQN7DEs936u0WZV6Cxv6gADne93JsnTFJDW0
	8mXX3OZcVnKdeAwnDMcgodzSOK2mQD9zEV9DcbT6+Dzkv6SChaH6jl8el5yNMIzvw6tDde6oSPV
	G2LlbSNuxKwEjoHZmZhwKNfTERWFmrh2EJQpCyoVqt9zG4h7zVJVoWLm9iRRSH7zECgtEjv5esW
	w5uaGA3G6UBGOVWsbCT7wIJKwo5xzYP5Q9Fqf1RT30hTVY2oHWrScvjTCGfwsdvpLUHuCq3bPWl
	7fthF6fJqOcgG0f7AozI06k3g1eDcKN18zdjDYbqVvujUbVKAKwITBlnFY/PPasZjI+T6LvMk5J
	qoxIbxMYYtSKiNLIZLU8CH/P/Q/I9SBTzw9znnPQXy43h1FpFgJr1LcQc5y9hvmgP1shiMtKyxs
	jugelH2usP/Wg+EJGaKAMK
X-Google-Smtp-Source: AGHT+IEBAU/1+Mk/shZIO/8rxFy0L5QBvzqdemfBlLyVcWX3nEzeHe0vuvNNxNxWSpHwF3vVtSRCBg==
X-Received: by 2002:a17:906:ee87:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b50bf7eb3cfmr439899866b.30.1759939537957;
        Wed, 08 Oct 2025 09:05:37 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4c83adec08sm985359666b.56.2025.10.08.09.05.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:05:36 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d80891c6cso176352466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:05:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0GeGRK5OtbXmvTL4FstRgI8pJ2Xzkz4yK+nUr6EYf11li7uUW5IQ0QUxCKsP0rd7XxPyqGWwr9FTnggQ=@vger.kernel.org
X-Received: by 2002:a17:907:c717:b0:b4c:629b:aa67 with SMTP id
 a640c23a62f3a-b4f43730a1dmr943906366b.32.1759939535669; Wed, 08 Oct 2025
 09:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008123014.GA20413@redhat.com> <20251008123045.GA20440@redhat.com>
In-Reply-To: <20251008123045.GA20440@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Oct 2025 09:05:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
X-Gm-Features: AS18NWBMsj5s5FP73yEhAeSQmI8SrDvh10NOgnRoQVy4jaZaA2b3rqSxd9LPdxw
Message-ID: <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>, 
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, Peter Zijlstra <peterz@infradead.org>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bah.

Now I'm reading this again, and going through it more carefully, and
now I hate your helper.

Why?

Because I think that with the new organization, you can do so much better.

So the old code used "seq" as two different values:

 - the first loop around, it's the sequence count for the lockless
attempt and is always even because of how read_seqbegin() works (and
because the original code had that whole 'nextseq' hackery.

 - the second loop around, it's just a flag that now we hold the lock

and you converted the new scheme to that same model.

Which works, but in the new scheme, it's just all *pointless*.

Why do I say that?

Because in the new scheme, you have that explicit "lockless" flag
which is so much more legible in the first place.

You use it in the for-loop, but you don't use it in the helper function.

So all the games with

        if (*seq & 1) {
       ...
                *seq = 1;

are horribly non-intuitive and shouldn't exist because it would be
much more logical to just use the 'lockless' boolean instead.

Those games only make the code harder to understand, and I think they
also make the compiler unable to just until the "loop" twice.

So instead of this:

  static inline bool
  __scoped_seqlock_read_retry(seqlock_t *lock, int *seq, unsigned long *flags)
  {
         bool retry = false;

         if (*seq & 1) {
                 if (flags)
                         read_sequnlock_excl_irqrestore(lock, *flags);
                 else
                         read_sequnlock_excl(lock);
         } else if (read_seqretry(lock, *seq)) {
                 *seq = 1;
                 retry = true;
                 if (flags)
                         read_seqlock_excl_irqsave(lock, *flags);
                 else
                         read_seqlock_excl(lock);
         }

         return retry;
  }

I think that you should make that helper function be a macro - so that
it can take the unnamed union type as its argument - and then make it
do something like this instead:

  #define __scoped_seqlock_read_retry(s) ({ s.lockless ?       \
        (s.lockless = false) || read_seqretry(lock, s.seq) ?   \
                ({ read_seqlock_excl(lock); true }) : false :  \
        ({ read_sequnlock_excl(lock); false }) })

Ok, that hasn't even been close to a compiler and may be completely
buggy, but basically the logic is

 - if lockless: set lockless to false (unconditionally to make it real
easy for the compiler), then do the seq_retry, and if that says we
should retry, it does the locking and returns true (so that the loop
is re-done)

 - if not lockless, just unlock the lock and return false to say we're done

And yes, you'd need the irqsafe version too, and yes, you could do it
with the "if (flags)" thing or you could duplicate that macro, but you
could also just pass the lock/unlock sequence as an argument, and now
that macro looks even simpler

  #define __scoped_seqlock_retry(s, lock, unlock) ({ s.lockless ?  \
        (s.lockless = false) || read_seqretry(lock, s.seq) ?       \
                ({ lock ; true; }) : false :                       \
        ({ unlock ; false }) })

although then the users or that macro will be a bit uglier (maybe do
that with another level of macro to make each step simpler).

And I think the compiler will be able to optimize this better, because
the compiler actually can just follow the 's.lockless' tests and turn
all those tests into static jumps when it unrolls that loop twice
(first the lockless = true, then the lockless = false).

Again: I DID NOT FEED THIS TO A COMPILER. It may have syntax errors.
It may have logic errors,

Or it may be me having a complete breakdown and spouting nonsense. But
when re-reading your __scoped_seqlock_read_retry() helper, I really
really hated how it played those games with even/odd *seq, and I think
it's unnecessary.

Am I making sense? Who knows?

             Linus

