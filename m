Return-Path: <linux-kernel+bounces-836504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D653BA9DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4517F16779E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E2830C0E8;
	Mon, 29 Sep 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XK70IWJ1"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734E1F94A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161238; cv=none; b=gwA0JmKG26S2uJxgFBxVnrGKMxw0VmJV+FqdaQs/WOa3nex0QFtVG8g5V2qjC+9pzKsnII8i6LJWVWRzff9BtaUjgwX/q42ixbmDfBvwL2LcWxGmMrVRnrAQKI5d858oCq7f5XOhUr2nRBgpzii1Cz4WoVpdfZpBGGEWHGCn6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161238; c=relaxed/simple;
	bh=Vjm8rZ14V77HWC/fLQ6JHPrBH0h5AirUfmFPeFyAxHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHih6RJZT1+O6bIxWssN88j+rIw9VMvnzOS2QfDWl6gK/zxSGUlJcntnbAdow8oX+wHsT8wxXkXOBaSv31+HyYxtz/mY4TzCz3eTmsdPYsYfu7UXpMnuDLUksj54xXVQHwLr9VSY1OC4zzcOSw5QT4hLJgvg+QCUkvBK9tI8MeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XK70IWJ1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6365c5704ceso552181a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759161235; x=1759766035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8bogWF7ZzmqTQ/ldKkIp7R7jAOYo/1qoIHxhZsbi1nU=;
        b=XK70IWJ1jmc7DqRguz9jhRhnbFq6syf5pYypXkN7ZNq/DIsTxTPUIVYk+na40h6Bzv
         3/anT+6tMq9mJTk82auodGtfauF1cX1icFtdJrlAXdpV5hHTm0ucaNRwWU2a6aBPdmRd
         ROMN+WlkbYoFFEJzLlQ17/AnXuj5ceNEp1wWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161235; x=1759766035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bogWF7ZzmqTQ/ldKkIp7R7jAOYo/1qoIHxhZsbi1nU=;
        b=n2hZCaCNNt5pKGmuBZzpCLzoJoSQLqpUvNarK3eZUuLbmcZY5jRDTgGtBa5uOHJO4D
         OS4Twu4L6g/H3KcABusWZBhqffnvpfjBH9C3bOgxQlMFSLUL259fpHsfFhHsf2FH/H4x
         rs8+GbN0lL8RpYjp8Ncqf+ILvAbKIZ5FVHaO0yJrdF7Tiez5gtlYcDvBhHivitU29WVg
         qWTd1Y7GxyPM4Ku7MZxiy7ISC9cI6KNRusUKGYNIuRrGUFkHGBYrTQuD4xjoahGFn8iE
         2e6lzuyKB8qIo4kxX7PUxVgza5uorXpG1e9hbXLv5NDaY1UgJ9Z7UAe2qJY3LptyAoK7
         OxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8TfwyB2usX905NeskAeDD+rWIG72Z3pS0mNcBzUeKu0sAfxBYVjPJ821T1ER8l9pz0KSPQQAKE8DIe/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6TzpuaiftNOGu3OoLr3jOveuugvLCTbEOehI+23V0VCBlJ/L
	aAMHF/vCSG2/WyTXUlLC7u8EhBhXiCZsPELb1G8tuAJ89DYtnP9GVFlTpYzub5NJDexreXonCeY
	vjVQ6/1I=
X-Gm-Gg: ASbGncuVcDgWBOt1iPYpQ1AVv//MYTN9ShwqQ6goU2ma55n1wS8y2Yj6te2bsUI+B32
	4G16rUEF5gCXBjjQv35N0a5QdKKsdXNJNEhl+BZRonWC8PEdvGlQYOCwnxxyBSqcPwwpLCm6Wk1
	bqbIORKhK4vwqusUNODJeEmuuAhoyWrJB+dvIAaT//iA6n7DKcMlenn6BEGfx5tSlY/l9p8Hr0S
	ZLfBlkEqCDkw03ymqGMAVWKa/UnsdA9wtyxrAJmgdzHgQOVyfUeCr/oHsAdh1NFgbB12mbRMTeW
	dM1GyvcCiKIRztgMP5va0RPL5dFAm+xcytVoqJ+kCRjvWCExwJvfHwNYuXRKDN2JIbprzbTh1CI
	JdCn482ENxzkz0ZD68J/0jaFMidazDPDeR+sEPgit0pjzADjiGvwcneDPfdyJI/vtqfvXqRz/2p
	c2qTF1uz7cWfEWYpk5gg==
X-Google-Smtp-Source: AGHT+IE0hRvACbuZXg7jYvgQ95tKD5UV6nNwjwaUac2IDfgA6ZBPfNfiq+hcegTq+Z2ligceLKpejg==
X-Received: by 2002:a17:907:7fa9:b0:b30:b2e4:af3f with SMTP id a640c23a62f3a-b34b7fbb4cdmr1918126766b.14.1759161234823;
        Mon, 29 Sep 2025 08:53:54 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f575aa347sm182342466b.57.2025.09.29.08.53.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 08:53:54 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso9966809a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:53:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGIQgc2XWfKcIQ1jJQxOsy0888Fa0Ss3Skc4aGRts64lyWN6rtdb27gImU162osInCO7LYpUA7VFln8ek=@vger.kernel.org
X-Received: by 2002:a17:907:720a:b0:b40:664c:3317 with SMTP id
 a640c23a62f3a-b40664c5446mr230881766b.43.1759161234098; Mon, 29 Sep 2025
 08:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
 <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
 <20250929110400.GL3419281@noisy.programming.kicks-ass.net> <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
In-Reply-To: <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Sep 2025 08:53:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
X-Gm-Features: AS18NWA_sOSQWHCpV2l3Y3mPQhfU2h00coqPdVCtJP07FYq0uVp2OVr9zTyIh6I
Message-ID: <CAHk-=whmf8OKRBKW_xi6SLrvicif8a2e7Pn9v6Qi+ioDJxnqmg@mail.gmail.com>
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang <
 version 17
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 04:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> >
> > Ah, d'0h indeed.
> >
> > void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto(""::::l1);return 2;l1:return 1;}}
> >
> > Seems to still finger the issue on x86_64. That should build on !x86
> > too, right?
>
> Thanks, builds fine on arm32, arm64, riscv, m68k, powerpc, mips, s390.

Ok, I just applied that fix directly. It's clearly not a fatal bug
since it just falls back on the non-optimal code, but it's one of
those "silly and subtle code generation issues" so I'd rather have it
fixed asap in the upstream kernel.

Geert, thanks for noticing.

             Linus

