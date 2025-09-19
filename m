Return-Path: <linux-kernel+bounces-825330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB4B8B91B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3212A825A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BFE2D878C;
	Fri, 19 Sep 2025 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCI3vAvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703C2D8781
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321725; cv=none; b=PoF9OUZkiglz7gSF4R4ijE996Hpyo13WIJvE7et0TCS9XQWZ/rvhFWlKXVFRLdxTMgt/tWcdX/Cdwywj0NZcrCCOqE3zQcTCBUOq3HMFHd9W+ZOInrI/5F3BV9oowF5LsmL5AgS9bcS3bkpQvEwmiCCdUYRMD5dbtoWixeMAlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321725; c=relaxed/simple;
	bh=Zm1M3jHb9CJ3r71mYFzgfrQOp48B7ZOWK1X98tIDqzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwNg1gAWDNH3ki7RfvI5UTD9MN4Cw3NFQ6EnjkTMAcO2qeyKwuKsnzuPm89igWwT/JfItR0w2eiFslsg8QXo3X93SdyWGxujvBqBc4Jv8g+zvJI6erqQvJnf9D5fKSLidOTNXaaq6KVbOUGfFqyQdWsSaYUd1pUACD7IV+EHXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCI3vAvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86669C4CEFD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321725;
	bh=Zm1M3jHb9CJ3r71mYFzgfrQOp48B7ZOWK1X98tIDqzI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iCI3vAvxCZ1fdHW7PlbAGgZvqXMeRuoIhAE1SwbMhBQZhtPLhQxkxks6Xv1ecCjYK
	 zA+FyJo4ZycF/1Sa82O00r7ip4tY4ljZuZWU+YmeOgzp6+RIkU8pt5PaB/xnzAa6yV
	 xa1MCA2nc54d+OvT0vC3mru5Nyj+XwGKbzpGABAYMqAXDJSi5YlRurCl2wtE1zPNTp
	 tCeEPynuKTvxw3pZSrxbYlsgT8Uptgsd8VDf7bMwvdRAMGopUy1S0mZQ2rz6CEZIBW
	 LAah1wVrsCTzVK5Bq0YHJyKwv+5Mpy6Bvs5C0pjvuJKi7Fd2KmgiwIIv5rregCROJY
	 Vng59aOXu+rHA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3601012fdfdso21960941fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:42:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxYND+OIsz0p0uXjDDbRZY7oAH3D8whZOLXq90c3S7QaVUsfXFIPKT5OkLDIsEBOmr5upBWZQ8y/VbY6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQDlE3AGuEH1Qa/nJamkRr2hfgBQyIvngmn9qJWugjTcU+eAb
	x81FPuXRViMw2iukyLVwx0x0vGOiKOH3fJci3DhF6y7Lpjyr0x0aNTIjXGdHzjrLEK2bRoqzeMr
	MHrwZtMRshdjKnUU0jpjY+XpQPG9zd14=
X-Google-Smtp-Source: AGHT+IFHcKMAvs4PQQTYZlUVDWSc5ZK0PVWE4ileGQsev+UZeJzNDCdz1kpAlU2C8sOjUFnO06qBBhVnBMPRCeiLVIc=
X-Received: by 2002:a2e:8a8e:0:b0:35f:ddb1:96c4 with SMTP id
 38308e7fff4ca-36419785d45mr9902251fa.29.1758321723793; Fri, 19 Sep 2025
 15:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918063539.2640512-7-ardb+git@google.com> <20250919193221.GB2249@quark>
In-Reply-To: <20250919193221.GB2249@quark>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 20 Sep 2025 00:41:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFOS4n4HNCZuoSUT3KUs+pM6OqSYz3Pv5z1dmZJZ70meQ@mail.gmail.com>
X-Gm-Features: AS18NWAn8XZaWe_Iq5DVEqnG3m8nSgWuT9HLn9m4iHtAqolG9uEsGI6YX_WDbKI
Message-ID: <CAMj1kXFOS4n4HNCZuoSUT3KUs+pM6OqSYz3Pv5z1dmZJZ70meQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm64: Move kernel mode FPSIMD buffer to the stack
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 21:32, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Sep 18, 2025 at 08:35:40AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Move the buffer for preserving/restoring the kernel mode FPSIMD state on a
> > context switch out of struct thread_struct, and onto the stack, so that
> > the memory cost is not imposed needlessly on all tasks in the system.
> >
> > Patches #1 - #3 contains some prepwork so that patch #4 can tighten the
> > rules around permitted usage patterns of kernel_neon_begin() and
> > kernel_neon_end(). This permits #5 to provide a stack buffer to
> > kernel_neon_begin() transparently, in a manner that ensures that it will
> > remain available until after the associated call to kernel_neon_end()
> > returns.
> >
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Brown <broonie@kernel.org>
> >
> > Ard Biesheuvel (5):
> >   crypto/arm64: aes-ce-ccm - Avoid pointless yield of the NEON unit
> >   crypto/arm64: sm4-ce-ccm - Avoid pointless yield of the NEON unit
> >   crypto/arm64: sm4-ce-gcm - Avoid pointless yield of the NEON unit
> >   arm64/fpsimd: Require kernel NEON begin/end calls from the same scope
> >   arm64/fpsimd: Allocate kernel mode FP/SIMD buffers on the stack
> >
> >  arch/arm64/crypto/aes-ce-ccm-glue.c |  5 +--
> >  arch/arm64/crypto/sm4-ce-ccm-glue.c | 10 ++----
> >  arch/arm64/crypto/sm4-ce-gcm-glue.c | 10 ++----
> >  arch/arm64/include/asm/neon.h       |  7 ++--
> >  arch/arm64/include/asm/processor.h  |  2 +-
> >  arch/arm64/kernel/fpsimd.c          | 34 +++++++++++++-------
> >  6 files changed, 34 insertions(+), 34 deletions(-)
>
> This looks like the right decision: saving 528 bytes per task is
> significant.  528 bytes is a lot to allocate on the stack too, but
> functions that use the NEON registers are either leaf functions or very
> close to being leaf functions, so it should be okay.
>

Indeed.

> The implementation is a bit unusual, though:
>
>    #define kernel_neon_begin()  do { __kernel_neon_begin(&(struct user_fpsimd_state){})
>    #define kernel_neon_end()    __kernel_neon_end(); } while (0)
>
> It works, but normally macros don't start or end code blocks behind the
> scenes like this.

That is kind of the point, as it restricts the use of them to an idiom
that guarantees that the stack variable lives long enough.

> Perhaps it should be more like s390's
> kernel_fpu_begin(), where the caller provides the buffer that the
> registers are stored in?
>

If we're happy to change the API on both arm64 and ARM, then we could
make it more explicit. It's a lot more work, though.

