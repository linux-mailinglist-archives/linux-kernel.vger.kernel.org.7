Return-Path: <linux-kernel+bounces-888778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B02C3BE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469531897299
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B1E3446C8;
	Thu,  6 Nov 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DspfoUWh"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632934029C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440587; cv=none; b=hv4UWAbb793+tCpxoVaixkflvLaAO0It/83dobcVC+m18s0H3/ojngbBUx2P46aDRzDR6qV9fsqT93W9otX6trXXVRTF9AYMe+XbVOEvddi54pOa0Z1u2BKsAUoXxtKh0/RDyJ7aOe+6kkiSeH34Sp2m6sA03lHtjwNqnDUMm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440587; c=relaxed/simple;
	bh=x3cqipEYJXlgL2yviFdIDPMoX0lSj6NBR8ueUAg2vCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq/EIXMCMJYA8th8NxSiyh0+kqRBjDwZvUHoMeF0fTrcl8BDftSPP4rvelrs6jkke1b4U8eC6fW5GPPCM4AbTTx6qfeb9stH9Y0NdXzElGLhmADPqkcDVEjWmWfQoObYGKaK1TJR2xB6ANEcugrUZ00ae1KsVnWaulbIF8FqA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DspfoUWh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7277324204so124039866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762440580; x=1763045380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3cqipEYJXlgL2yviFdIDPMoX0lSj6NBR8ueUAg2vCg=;
        b=DspfoUWhahtPHhFdWDegsdcwvsHSQDUoukpSkt4KBUgeq7o9RVBgAwZiEq7JSvPdoF
         rb5+Z8tcMus4xTlp9rMQgh29MIRse59qQfCiJEyUpkJfSa0NN1qMHfXmk+UUVbbZrfAy
         JU92y1m+X2iqdv5DF1GvQb/FcxFVvXH9uiJrohC8Jz0JTsHHNCGIck9aceOY77/tca2b
         V+91M1jCErOP19GbulXXwYQ0OEt+8+aSkn2p1dgJmpz0VMXO8lstub7UecC1mvk28eoj
         nC8Iii6uRU9RtQpZS0gNtbTiPCrVOpkJLFRXAc2PcR8+wUxY2AyqHoijlA8VSnKE3IqF
         bklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440580; x=1763045380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3cqipEYJXlgL2yviFdIDPMoX0lSj6NBR8ueUAg2vCg=;
        b=XRzH/Zii2uqa4fU6Jy9O6AyUrAHdt6iH8Ee6WqpOZJN9pQdLE53iPTPYilqVXHtI8p
         2rsUWKcGPf0rJCfEF2/oYqJ0h7iF9fCMw+wHiY53OmNP58UJKUhCNweRYCcjMgHFZPl2
         oe0on5zoQOHinu0k77p1xiMYevWNTjOFraglPuF8J8vh0iv6ZcpouXM+Pf9hQREW4tlM
         PElfFczotyKiLkPiiBM0/ludOhGhnZrfSUlulFhveUPGg7+IAeiU9b7nlyaGUjdNDPhS
         lxd34/BHXXIe11l1jLzxhNYSScHFpdBG0lB+VdDsjaeKBlS+IlmhzaklQVf75gt7U2al
         GDFg==
X-Forwarded-Encrypted: i=1; AJvYcCX/DPJvfSoosxaqqoQ3jnmWedkmGqFXY+S0Wyp8+dcWZGDkBbYdVDcanugyiuvIfPmjlCLHkcfUa502AIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDeExvp0TMce+puycwwq/cpCadgmA1UticFPbQsH27xs5gqH/
	pi+TXvI7FkF6rX6hxeoPc1gmBM7S663O6mV4ffieeBKtx73+/GoswgYm+2CDDLfCENyee7SGSCR
	NwbyAbTdItj8tE5GhnD1pZs/Xxz1OkeW2KtDB
X-Gm-Gg: ASbGncsRjQV3RoIJKTAsIpTvOML65wwco9ZSUts4IccEed2J+rSm9oH0KDDsdrV+EoF
	sZUpvgl3FYY31lWjYBftXWBYsRAwGIQ34/Eb2GM1vM24bqXSek/EsYjc84/lcDj4TtB/RA0eyzk
	tQEUyt6XIQrz3H57rjLMSd/gXuCQ6Jl6CTWUCqg119vsOoqqqIMH99aIRDO877jziyrbVGlIA/t
	3c/XeuAh4oUnIwVc1YpA3oiCcqjfe8EY+wUiewOL29TidYb1LcsDrPy5Jp+PP7EHUnJmCoxapTo
	iFF8TW1uk5GlNuNJDUo8RNWFCw==
X-Google-Smtp-Source: AGHT+IGTkbZJGRchGTkQauVj9fkvo01scuDDcRqu/thxmiYqRRhXCxyAX7NNBPJ6BxbxjvhqOiymHXZQFXN5z82w8MQ=
X-Received: by 2002:a17:906:f58e:b0:b50:697e:ba3 with SMTP id
 a640c23a62f3a-b7265608c08mr761114666b.63.1762440579515; Thu, 06 Nov 2025
 06:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local> <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
 <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local> <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
 <20251106133649.GEaQykcT0XXJ_SDE4P@fat_crate.local>
In-Reply-To: <20251106133649.GEaQykcT0XXJ_SDE4P@fat_crate.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Nov 2025 15:49:25 +0100
X-Gm-Features: AWmQ_bmx6eYJ_i1PPLlx42piXDe7pXDP9_APoR1EKtbmzECfxNFgWpRPEoJy1m4
Message-ID: <CAGudoHF7O-q4AENo-jdZymr+U8AGfQBcz7hjbi-kTg=MSOECXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:37=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Thu, Nov 06, 2025 at 02:19:06PM +0100, Mateusz Guzik wrote:
> > Then, as I pointed out, you should be protesting the patching of
> > USER_PTR_MAX as it came with no benchmarks
>
> That came in as a security fix. I'd say correctness before performance. A=
nd if
> anyone finds a better and faster fix and can prove it, I'm all ears.
>

Perhaps I failed to state my point clearly.

The position you are describing above does not line up with your
behavior concerning the use of runtime-const machinery for
USER_PTR_MAX.

It is purely an optimization and it has nothing to do with fixing the
problem the commit introducing it was aiming to solve. You accept it
without a benchmark. Later when a bug was identified you did some
testing to make sure it works. I think it that made sense. However,
per what you are describing above I would expect you would be
questioning whether this is warranted in the first place.

kmem is probably used about as often as user access (if not more so).
To my reading you rejected the idea of patching up some of its memory
accesses without a benchmark from the get go, which is quite a
different stance and I find myself confused about the discrepancy.

I have not tried to write patches to optimize these. There is a
threshold of complexity/ugliness where I would drop the idea myself.
But in a hypothetical case where they turn out fine, I don't
understand what's up with the insistence on benchmarks for this
particular thing, especially in light of your position on
USER_PTR_MAX. Per what I described previously, this would be hard to
arrange anyway even if someone genuinely tried.

