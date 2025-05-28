Return-Path: <linux-kernel+bounces-665874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0803AC6EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81431C021EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3228CF7F;
	Wed, 28 May 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qARwkqBv"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9128C5CD
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452560; cv=none; b=K+7qDQm2sUSBtPjyg0pUyTzk7AQucd3bMLpcdiZsFH+4WQA9RvoeCEIH8v/AWxy/Fi7XxIvnW9CpB7mFBRO0uvAA69qyDRSeK5KCIduouEuPGGZwZa1AuprnMAdRZluD412z01qZ3sJEcRr926dR6JwXEnWeQdObBAW3qotqiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452560; c=relaxed/simple;
	bh=GFuirEaKGhl5vMyZboOmESj/mIt1D5zTTMZxltcKv0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA0lJ4uuXcn8YezpbEJX8/743Mv6QFMLTtaSScDHk/Nw+aTjBDkKd00yNTMdWhOHpSla6OzT/7cEWrxN6YecU1gg0HtvCuJ60HUPR4ZiPge7Z6wAqAs/5BmK4asIH7sSq8UNAvKaPwhRnghHYIUVNSjOqsewFnNoUmXEgxv16mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qARwkqBv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so594a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748452556; x=1749057356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUdwWMmdYpRWctOElE23L2fIeNE3afrw4G+RZhKXn0o=;
        b=qARwkqBvmySlm5KgkxKy9dYHiyFRAlaSZiND0UbLEvUeRLenuKGMG591lLl91Zxd//
         zMnKVGZCZaf8W8YwowvpQ/kQ+lwxqAhDfnDRrbl6RZ01JNt3xGlJfl3du/R+IuOMG19W
         dGsQs/QP7UA+V89sEHRyAuwx8Gu/dJyxU+8w1wCUQKrMNsNz+I0rfulSgSMdCzjkO+ax
         cZ4zbFvzJNF7Xq6N3Ic1UQdgYPMqgwnQNPFFM+aVSrOUrCeba7jIizXOXDIFsQzVs02M
         hhI0UbR2efSwkV5nLlY0AABQXAKp8VeFeehKEeDP1zt/F62bQYXQSoIOzXzzQiF4u+dv
         Ac0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748452556; x=1749057356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUdwWMmdYpRWctOElE23L2fIeNE3afrw4G+RZhKXn0o=;
        b=eSthpOfEK9MMfmx/YNIPiX8tczQe6cs/1XGzrNvI5XVs1BfJoIOLSDbsx/C16RR8uK
         pwpoEhUBLt/YHFZycU0EJAWcACRORjUyvK6Z8x4hoEISu1vhWe0xsTpCnOOQpCfJ2Api
         8XB1MHyr9A+jerv5S05JuektWsxu7tUV1X3WPkVaOC7MvyPR3knocC5/a9JKPDkqBYtq
         YNwQgCI+8/Y02JI6r2VXblfTBWD3XGoBSC7fnF5ZB0udHPZ76PVRNmrEugQgunMYxfGm
         btN3MgngwveKXVigfC24zW04rqAastzyweVt0pFdZe5Bw6kmYXmT831HcpfW3NFWlryO
         r47g==
X-Forwarded-Encrypted: i=1; AJvYcCVT0wW6NZxiM19H1/3TanBsK/rXaVFTJp9nqfpkGBtc7LoBhyL+KyCjjly6tujuEhVQWAvqdiuq1AobCHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOv3KL1JdGQnHNCylxS9bQPFmmAZWUGF7SkBRi9i5K0N/cyxAR
	ThbOH5HGhJ9kXjTQT4I0/QP10G0RoT5JMSaPSrZWnHqH5yHRddUP7EXtY7Ke5W15+bGXvsmPT3i
	zEyhxUAGPQtub189JJYJcbsUFtxsWIZnAgOgfuHHe
X-Gm-Gg: ASbGnctFX9RAmplMFe7/SR+H8+aUsknVAYV24wvgdXB3pIlvqpJ0nky/gc8WUABwjXB
	1UgIADCN57WINkJ8J4tvfp9CD/s73SQGiRTm/lMZQUWxB+SZ8etj54Ic8tMXCrnwOojwVjSSEY9
	vYy4XQWzgTUVZeDQvSeUtQtO0Fu2gTbNasffwcnRkacECZ0XDXy2NVf3mweh9jW2XlSleGFn0=
X-Google-Smtp-Source: AGHT+IEt7PzAIkfFsXWZlxFmSgQSVYAlHTzvWz749ZmQ/S1uJVlMVoEN7SLnaEY1BBFoG5gmWjLgKZ2VITWWPkBMzQE=
X-Received: by 2002:a05:6402:14e:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-60518dd2ce6mr131981a12.7.1748452556188; Wed, 28 May 2025
 10:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202505281024.f42beaa7-lkp@intel.com> <20250528061427.GA42911@sol> <202505280937.6802F0F210@keescook>
In-Reply-To: <202505280937.6802F0F210@keescook>
From: Jann Horn <jannh@google.com>
Date: Wed, 28 May 2025 19:15:18 +0200
X-Gm-Features: AX0GCFtG0eJUnIASULD2nwd-Zdd6sAxsHjSny6-oy6ySySzZaKEp0fZyIUqXpLw
Message-ID: <CAG48ez3i37DYjM+SjBjC-VKQOiJs7-YVdLEQ7aqXQwxWs-rS9Q@mail.gmail.com>
Subject: Re: [linus:master] [crypto] 40b9969796: UBSAN:unsigned-integer-overflow_in_lib/crypto/chacha20poly1305-selftest.c
To: Kees Cook <kees@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:46=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Tue, May 27, 2025 at 11:14:27PM -0700, Eric Biggers wrote:
> > If this new sanitizer is going to move forward, is there any sort of pl=
an or
> > guide for how to update code to be compatible with it?  Specifically co=
nsidering
> > common situations where unsigned wraparound (which is defined behavior =
in C) can
> > be intentionally relied on, like calculating the distance from the next=
 N-byte
> > boundary.  What are the best practices now?
>
> Hi, yes, this is still under development. I tried to make it hard to
> enable accidentally (not via COMPILE_TEST, not UBSAN-default, etc), but
> we (still) don't have a way to disable configs for randconfigs. :(
>
> We're hoping to see Clang 21 with the more versatile Overflow Behavior Ty=
pes:
> https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes=
-for-wrapping-and-non-wrapping-arithmetic/86507
>
> and our current testing is showing many fewer false positives. (Having
> run syzkaller for weeks now.)
>
> > Documentation/dev-tools/ubsan.rst says nothing about this and only ment=
ions
> > "undefined behavior", which this is not.
>
> Right -- this will get extensive documentation before we move it out of
> its development phase.
>
> I'm not sure how to enforce "don't enable this unless you're developing
> the Overflow Behavior Types" with current Kconfig, given the randconfig
> gap... I have some memory of Arnd doing something special with his
> randconfigs to avoid these kinds of things, but I can't find it now.

You could depend on CONFIG_BROKEN, the canonical "if you enable this
and stuff breaks, it's your fault" flag?

Or if you want something even more explicit, maybe something like this
would do the job, so that you have to set an environment variable for
the kernel build to unlock the feature? (To be clear, I'm not fluent
in kconfig, and this is almost certainly a terribly convoluted way of
writing this - if you like the idea you should figure out the proper
syntax.)

config VERY_BROKEN
  def_bool $(success,sh -c 'echo $ENABLE_VERY_BROKEN_STUFF | grep "^y$"')

config FOO
  depends on VERY_BROKEN

