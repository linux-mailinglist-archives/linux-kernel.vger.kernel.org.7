Return-Path: <linux-kernel+bounces-879706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57AC23D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49743B0BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C802E62B5;
	Fri, 31 Oct 2025 08:24:44 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D72DF15A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899084; cv=none; b=mG2eHMq3ehmh+pUs3bDEBC922aB2ioW2+p9xPzUNol198FIeZNKjPuEXnkx0/iJ2uZBlX8wXHUa+r76hw7igEWgRXWCUArZOEzMNk/v07UcpGMafuQ4hyUVBje2+4I1wNLasb/GoBB+k5ZCxZLdtBg+Av8G+cvrhosEJIXspJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899084; c=relaxed/simple;
	bh=QBdLgXepaoyusDzfPuWF7W5gVFX3pzRYvpA7qsRLNtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKaSYoLR8RdcT0LQCkJUlWS1noF8isUseXciAVPsB9mMU4r0qeImVzJxW79EFr7DtfZ7rehtj9yF/WQposnun7CDLfiUrCKPlfI1epPt9xWAWNfzjm48OZKjj4U+tBm5UKth3esvAmjYbXJE0QXsdlss2z+BWhYkZOHQNnC3f+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5db7dfe9b7aso1560589137.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899081; x=1762503881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSmGt9VWfBQJDvvEyJ8bQzSLcQfsQHCg2enix3hl0bA=;
        b=o/gHKXJ/LpJegBhm1av/hhMRGuiM7IV8Hw6xiBBOZKLSR5JapNB2o0lsWfTKbBktTc
         2eTVPn7IoJ3HCpr5RvmAzbxtTjcHsDV2HxA/Hn5UTkW5Nm2bLY55sTFNXa15JKYu4Yof
         a3KaLGe7WRTrgTeRcDCzK9SdYGu+CGGGXsIaCs43/P943nGg8RIWo7EDGtjFofP8aGj+
         RXd39U3H6FaSX+ErICf0ZkCYgi6l10aNIJfK+qHoCm+6NPQFIxE8+SrxyqA2iBg/zp4W
         A/rTA+RsK9XPbgm1y/MjC6HBOqFXPQK17U/pwW3iibWbhobPyQjq5UG5BdfS0Sq7rvYx
         S9ug==
X-Forwarded-Encrypted: i=1; AJvYcCUi1rK4/XbfwJf3qmSUHdJqtQlAsWLHyLCXwhaMDkYydYvzA2wO2RAunxZjIj88J0vElkYO/i9o6FJtfUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaIhls6w7ZQmlr5aLaDeq7IFu0ZQeTO4MEHAPpVL3IjHxWNCU0
	UQU36apBOCjF7o1Eu4BqvZAe4ETbGZNW4dywBqtweXO/li26lFi0HNWtxGPWeg==
X-Gm-Gg: ASbGncuHCiHdY5nFqc+gvJA1/mEPdIsMGRwETLSCEKrjwNUY52HPUtQ4FlRsiQFUGDF
	IOh/YUzI+d7qzffMcNxpNdNixmpPc9s/h7N6o3milpF2BoN05pmb1ndYp981VYw9Fuhg23akKZb
	RnqsFxr477r8+beJHkAKVRv4Kag5bdEpVyNQd5PyGkP267vYswg0b1Jvrg8OgH3BWxZdXBC40CB
	fi64RgK+Nim48HWIe6RDqGBB1IGYYbdgFpavS5w5/vKO9svl6/78YHyQKNfBOv/0/7mg7B0eNYp
	1yADjoHzsvuTqu+c0P7yrO6y3nwRnNWfQZsLanup4mnYR92vtA2xezDQJ9zuMX1yddgFxLJB7sj
	mdrw89g4cwuolRXE4j6hxv0WI6d5N2H5PfLxfhMMD/rUHVQLo/5AoxDdumxCnWap9nqQFizzjOx
	DncKvG2cR0xEqmuBch4s9lUGlWaFkgWENbwZZp+NAO
X-Google-Smtp-Source: AGHT+IFJ+WGwJZsZV+Wl68GwxG793zxp6ZimCJkrvA5fh2vgujMxuQfGia4fB8d5/dj11MlQR5xdjQ==
X-Received: by 2002:a05:6102:c8b:b0:5db:341e:94bf with SMTP id ada2fe7eead31-5dbb12fb676mr903855137.28.1761899081317;
        Fri, 31 Oct 2025 01:24:41 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93512a554f5sm432562241.5.2025.10.31.01.24.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:24:41 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5db2593c063so1499060137.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:24:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU9cGkJKDdA/LyEwXO0KiD0qfumWadupEIOBnjUqnpbSSClUJ3hlwNfEMQ7/Uc5nnLCjM9y4RtmSw3AcA=@vger.kernel.org
X-Received: by 2002:a05:6102:508e:b0:5be:d04d:d2c6 with SMTP id
 ada2fe7eead31-5dbb1204032mr790145137.9.1761899080804; Fri, 31 Oct 2025
 01:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <87zf982s52.fsf@linux.intel.com> <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>
 <aQOvCugzYe/2DcNW@firstfloor.org> <baf2665c-49aa-4b8a-be26-69dc23876bee@sirena.org.uk>
In-Reply-To: <baf2665c-49aa-4b8a-be26-69dc23876bee@sirena.org.uk>
From: Fangrui Song <maskray@sourceware.org>
Date: Fri, 31 Oct 2025 01:24:52 -0700
X-Gmail-Original-Message-ID: <CAN30aBEVdhju7CG4Tato-D1uof5p+dhTM6nJtjXX_SiYH7fU+Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkGkpQQsklzLvHTWsBZ_xTryR-WgcL-38L2MiIPvb0SEfuMwf6pZKrIbe4
Message-ID: <CAN30aBEVdhju7CG4Tato-D1uof5p+dhTM6nJtjXX_SiYH7fU+Q@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Mark Brown <broonie@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>, 
	Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:45=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Oct 30, 2025 at 11:31:38AM -0700, Andi Kleen wrote:
> > On Thu, Oct 30, 2025 at 06:07:49PM +0000, Mark Brown wrote:
>
> > > It's going to take a *considerable* time for the hardware support to
> > > become standard.
>
> > Optimizing for the past instead of the future?
>
> On arm64 no currently available hardware has shadow stack support, and
> once systems start becoming available it'll take a very long time for
> that to filter down to even being all newly shipping systems, let alone
> all systems that people care about running new software on.
>
> > Not on x86 at least. All my x86 systems have it, except for a few old
> > skylakes.
>
> My experience trying to find a system to test changes on was somewhat
> different :(  I did eventually get something.

I=E2=80=99ve chatted with mobile toolchain developers at the LLVM Dev Mtg, =
who
emphasized that size concerns are especially critical for AArch64,
which is heavily deployed on mobile phones.
I think Arm ABI makers are unlikely to want a format known not to work
with mobile Linux to coexist with a future, more widely adopted
compact format with callee-saved register, LSDA, and personality
support. I chatted with Peter Smith, who seems to think so, but I
don't want to put the word into his mouth:)

---

Intel=E2=80=99s 11th Gen and AMD Zen 3 support hardware shadow stack.
A software-only stack walking approach (and remains unvetted for
AArch64-see above) that doesn=E2=80=99t replace .eh_frame would quickly bec=
ome
obsolete.
Shadow stack can be enabled per process, providing flexibility to
balance performance overhead / memory consumption with profiling
needs, even for users who don=E2=80=99t prioritize the security hardening
aspect.

