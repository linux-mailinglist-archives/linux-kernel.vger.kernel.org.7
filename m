Return-Path: <linux-kernel+bounces-862118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38075BF476E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9E2F4E8B89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2F20ADD6;
	Tue, 21 Oct 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzPfYY65"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030891A3166
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016303; cv=none; b=aU0ncac9iTAbr92LIuxdeadY50BE72KXaePBHBMASQkAY8yoxCKEJX5C5zpCyIFv2nZQBP+L9QszQwknQ+6omRu4sU7oP48nUyHbCqunajvvrZmQ7vMpQux4rsrSTyp59Y4IZeBGM28pQnIBm/oSej5mFnmZNR7duYEuL1I9qEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016303; c=relaxed/simple;
	bh=qcon7731kM8DtAFClgJC8hpcM8vS0wf/25XVt6j5B9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTyWmxysjjk2+vEBLMrfLJN6BI4ORJNoWZ4tVlyP47TcQgVsDDucIOLCOL7LbaeCPfadlr19tZ6mC7puCvcKSsymNEiqH9TGeZF334jpFAORcPrzhNE2ITpiSeHFa19c+CSb0NZmpZ+a6jai54xfnCzD/fpybti+iuxT/xkxGy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzPfYY65; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-362acd22c78so42913151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761016300; x=1761621100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gxGV6t4KaQKIEkuqcnqWAwcGIC+MCONMaxXtiyj/QU=;
        b=VzPfYY65CAwpjVcVoYj6Hzl2naDrnjrLsMOIug0DlFeq+2vHZ0ZZwI2lyuxKeUoAmP
         COxlZ8kivif/btxdfN6G4Y3wTA84kjmUeWGugd+zhhOLwpdryYHLSgyEMPsONL5OSrnq
         TM1TrZ4saUzfEa6CZFkdMe2pkIKEM7yNfTpoeivCmmEfybSqcQ0qyw2fI+t082iyYzhj
         +FTl0sNXU08wLwHXENaIpPfxw9aEHso1vF8EvRb8pb8ynKC7Rcp6EhvtkUxOX2/sa0oH
         NXpQZOJjZz/D0lSbvMweadO11LWt6Bt1pE4K1HhNpULWgct0A0dfV7czbimqBaNFVIEL
         3LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016300; x=1761621100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gxGV6t4KaQKIEkuqcnqWAwcGIC+MCONMaxXtiyj/QU=;
        b=aiwHRHM3TmpXSnM1dhwVFClu+VjiLjyqg4GoJxaVzMb51dTqm9Oat+Xr672eQrjzU0
         sTQ5cXAMpZFhY9CAAfRQ7gBvFXot9YR7EYiPw+NV2qGTJfw1hXR3YUhubDDgNpx2Deue
         91qY/57XhPJruUZVC6hsER6Xrd4C12sQcde9KcGw4vDwfaVAyZA2OU3au9+lPmncFL35
         +jacg8sCZGp/3KzE8wvIUHJ1pl15mPgfy69KJFCW5shj1bk+Rvswx7BNCmg3SO1lk8hi
         5oNEb4bxc1I/KNTpwMAqKj21Ezeb26itIawwKxUSzU8BI0XWv4NVBFoC212EcSE1lU80
         kEmw==
X-Forwarded-Encrypted: i=1; AJvYcCXYFPpDK3SZAjjOUE+nlmMFqaxE4NkyDmNfmaNjoAfPP1PonjLQN7fW4ONkcKLxaNIZ5Cu9Y33uWYzZsrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzhS06/ljP5GIhU/2clDhw4EfFn90MtnuHtmS3HR1dLaWtBHr
	wXjXHQBp6T2kPYrogWBjxvlr1iHFyr5HXGLIMMuAoTbeouHbYVhe/shRfecIUW2iBy/M1EaLfi7
	kIWFP6f/d8vzFqtZEK9q4vPm4tfT+tkI=
X-Gm-Gg: ASbGncuqNYFR8FqtY0hJdvxqcTWKd7iQm25t7DrUpgUfCxGX7gRX7uFYqz3IxSXdoF9
	ioAt/tHNnmgcPI/Vmv+pQ5J6ER5NxbYzkQj9ZSD0nvZpJrW33FyzIZUDPMofaHQ+wnOIIGXTxO7
	T81pR8A4pkApgbyck6gU6GA6DZZBEfBpQUNAoZfeGtRiqcNKAoC4iEDcZfVs235gZ6FT3MSTbyR
	N7UZsJcwAt3OeikEIJ4K2+Bwj/cjXXoW9stTVD8QkPuuz08O5nlyichUoFy
X-Google-Smtp-Source: AGHT+IFpveaJSVS4mgWlRM9jSoTpjoRFFU+f4lYGlQNbGnNFQGEff880W4rCMgaiIJe25Pb4mW6KaNs0FJ/ahUudfag=
X-Received: by 2002:a05:651c:2221:b0:336:5d33:c394 with SMTP id
 38308e7fff4ca-37797a3ed65mr48068101fa.33.1761016299796; Mon, 20 Oct 2025
 20:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
 <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
In-Reply-To: <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 21 Oct 2025 11:11:27 +0800
X-Gm-Features: AS18NWDEDTT28sB3PMCUs6Kzey9uCcXUf6Pr04BcrxLqqHzOIKq4mXBOkBPItE0
Message-ID: <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,
Thank you for your reply.

> > > To be clear, now we are not talking cross build for perf program or a=
ny
> > > targeting a CPU arch, it is a build failure for eBPF program.
> > >
> >
> > I=E2=80=99d like to clarify the background and scenario once more:
> > I=E2=80=99m building an SDK that includes a cross-compilation toolchain=
 for
> > the target architecture along with a copy of the kernel source tree.
>
> I am not preventing to use toolchains in you mentioned SDK.  I just
> prefer to give priority the headers provided by the kernel source.
>
> Seems to me, a more reasonable series would be:
>
>  - Fix the eBPF program build with using self-contained headers;
>  - Extend to support external headers.
>

I=E2=80=99m sorry, but I believe there may be some misunderstanding between=
 us
regarding the term "self-contained headers". May I ask what exactly
you mean by "self-contained headers" in your message above?

From my perspective, it could refer to one of the following:

a) The header files installed via the following apt commands:
> Have you installed the GCC cross packages ?
>
>  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
>  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cr=
oss
>  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross

b) The headers from the Linux kernel source tree.
c) The headers located under the sysroot path of the cross-toolchain.

At the moment, I=E2=80=99m not entirely sure which one you=E2=80=99re refer=
ring to,
and this uncertainty might have led to some misalignment in our
previous discussion. Therefore, it would be very helpful if you could
kindly clarify this point.


Thanks,
hupu

