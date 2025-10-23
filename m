Return-Path: <linux-kernel+bounces-867892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB53C03D47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9539219A5501
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548C27B324;
	Thu, 23 Oct 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvsOtUTY"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26E184
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261854; cv=none; b=uAll4UNSQ8U3hg8EBwXaSvbjAszmzhg0SEXVLeAP0HSzn60q6xSbh6ciKbIdGg3G9nukDVeYbj+h36Fw+MVDab4QwZKQGTOWXf7vod/zTwbqpceVHSt3iEhaZr/jDyeV9Y5t1HjLP7Iwmivp2OpkiHOPKNIlticINoZvqBld0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261854; c=relaxed/simple;
	bh=FCH5BsmTJldF4szkqMwFaaN6TkKxH+k98j7Pz/lqrYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ci/rDwzFZZgEalmX1fjD7Y07/otO/MocSIrFsMzu586pPLYWN/BcBBCy3rqk4IfkHEJIqJJU0pobxk9rD/oMDaVmz0NmehF2qtNjbQSXLffmOeLVxJ+G4wSRPDCf+mdof4XWx9aN9dzFAT6VJaJBbeWPE0l0PJjl9bc5meQ/dCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvsOtUTY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so4521a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261851; x=1761866651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhisYMy3Vpthsrdn+jl2i6ral8f0eTdW1jXrFk49/xA=;
        b=FvsOtUTYyKfpLUUnm4RMv5e3EafNW1owSuwhZZHPUj4ZzSe1/St+1+5YC0Kn7B59tQ
         ZoB6vcORQrhU0gIyzGKDY4TVVRBLJlbaZqomH2QMhN2TeCW3kK6LLW/V8aCNsXqqr7oJ
         Xz8Tt5mNljYhh9lrD6HHQTkYi+tPe4oo4961IieCA6XQDF7ioxELOo0GN9IDYciR2TlL
         r+Sod12L2AdLTYmTg++Cw/ZmtRtWoiG0vc7ak1wh4q3mz4BJ8uKaZVAExe3f13nyby0W
         2WBK9rnwVEvr60SCohmDfaqgRPe0h65gu9LcFkYhKyb+87KN7RIaubkR/9ImvP21RZy2
         /U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261851; x=1761866651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhisYMy3Vpthsrdn+jl2i6ral8f0eTdW1jXrFk49/xA=;
        b=BJILrS+o2Jh4SAtUpYV9ZWRthXmS4yBSo7zsM+TCvshO7U7tr4KDVX3vX/fPpBoL2A
         9pAFVZ9QjpmyA7NnUFKeqxaEdJ8zbXkE1RLx7+NTQVYUtOep3+hxROk9iOeup9dzPrd5
         MOlHK9TF8IdLwNZrIVZ7Bw8i5aR+oFY1/uGfSoz1pgrjdYOSYZwHow1+/G8hoyz5lAmx
         N2npQsM2Yad4QNaCeJblGSOWdPiJMZKLiszu9MZr213eED8aKQ9Ygp8HQgj+kgPx9wII
         Ye9KY9zRhV680yeopchsIF2RzQZ6Ei2lXpDXI3d5L0YniuH6KzG9V8hVimnYVjPgN8nS
         WBww==
X-Forwarded-Encrypted: i=1; AJvYcCX2v3OaGFpxJ7wPc5DX4VfVu5TADOQP2lIRP1p27wJBD/1ff1To/2N7b4Gs6/v6pveoVhj3sH95oLP8qdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfzdbB6ppJq/NOjvoS5Pqsm66dUfSp1Nk9autv2vNOp7k6X/w
	y9o/GznSZ7Yn5cUJPNrL0KHUQ8smGALkd7OoZyx4nCoAhQZnq4VfdmQBst4Rprzlb/554U2xWmE
	qH0+pbMmOZUsg5dFLrEQ0hvPLBiS/5m1Yc7BaWvnY
X-Gm-Gg: ASbGnctqQisXd1A/d7pAxIi37YEfEEchqhbJ7VkyYstOAYpmZ5lxlIq6sUjx56hT/N9
	vuk4GeNk/11Q94I7NHKXzVfYC3UsR+U5Zpe6wFxoBljsW0CL7L+yh2lpyr5N0Qj9nbhPIzUbKAy
	F1JhBrtlFjS3VgN0MIGeXIgMLSGJ2UCdGIGCSPRjzPUw5AGQ28ikYfVhwJ3+7edsQxX7Q/x+f0l
	Zyoi37kuWAs8K/gxer4/QE8ep/1NhOnyq8JJkMA1qO+6s4cmYLtC4XA3DnLtiJ6nog2Chf5lkqs
	zl1sqMZLCTHHsrgmNhYS982x
X-Google-Smtp-Source: AGHT+IFpBQfJrmD1BAdbhlCnwLoQ7nYjkNyT3BaeXpttJtR94D2fYixRL9GehTWkRgXSCenzZ7PlMiPZWEM6PSBUdgU=
X-Received: by 2002:a05:6402:c9b:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-63e6009cd85mr16334a12.5.1761261850463; Thu, 23 Oct 2025
 16:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022233743.1134103-1-mclapinski@google.com> <6bd76106-339f-4204-a418-738b7ee545ab@intel.com>
In-Reply-To: <6bd76106-339f-4204-a418-738b7ee545ab@intel.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 23 Oct 2025 16:23:58 -0700
X-Gm-Features: AS18NWB0aMiZQqeW0CH8D8CYZOJxSLu62F0lK0CwgwoxAU9TYuVymbrZAoBKA4A
Message-ID: <CAAi7L5fxqiMMGJi2xB42L+A-xVQwx=10TBG_kU15=q=i=6kcbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix avoiding memmap in
 physical KASLR
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <chrisl@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:29=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/22/25 16:37, Michal Clapinski wrote:
> ...
> > But it would not disable physical KASLR for:
> > memmap=3D1G!4G memmap=3D1G!5G memmap=3D1G!6G memmap=3D1G!7G memmap=3D1G=
!8G
> > since the whole function would be called 5 times and the last `if`
> > would never trigger.
>
> I'm missing something about how this works.
>
> The:
>
>         static int i;
>
> is static so should be keeping state across function calls. For the
> purposes of checking 'i', why does it matter if the function is called
> one time with 5 arguments or 5 times with 1? Doesn't 'i' end up at the
> same value either way?

Sorry for not explaining it better (again).

Let's look at the original function:
static void mem_avoid_memmap(char *str)
{
        static int i;

        if (i >=3D MAX_MEMMAP_REGIONS)
                return;

        while (str && (i < MAX_MEMMAP_REGIONS)) {
                int rc;
                u64 start, size;
                char *k =3D strchr(str, ',');

                if (k)
                        *k++ =3D 0;

                rc =3D parse_memmap(str, &start, &size);
                if (rc < 0)
                        break;
                str =3D k;

                if (start =3D=3D 0) {
                        /* Store the specified memory limit if size > 0 */
                        if (size > 0 && size < mem_limit)
                                mem_limit =3D size;

                        continue;
                }

                mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].start =3D start;
                mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size =3D size;
                i++;
        }

        /* More than 4 memmaps, fail kaslr */
        if ((i >=3D MAX_MEMMAP_REGIONS) && str)
                memmap_too_large =3D true;
}

If called once, the `i` gets to 4 and the while loop exits. Then the
last if executes, since `i` is equal to MAX_MEMMAP_REGIONS and `str`
is non-null (if there are more than 4 memmap regions provided). So
memmap_too_large is set and kaslr is disabled.

If called 5 times, on the 4th time `i` will indeed be also equal to 4
but the last `if` never executes since `str` is null. On the 5th time,
we exit the function via the first `if` and memmap_too_large never
gets set.

