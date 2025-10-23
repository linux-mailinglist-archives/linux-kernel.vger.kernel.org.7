Return-Path: <linux-kernel+bounces-867896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D5C03DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB32F18C2D24
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D602E1EFC;
	Thu, 23 Oct 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgDQFX/9"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE3238C3B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262445; cv=none; b=OmqXqFtptng+A3suf19B4nnwdTSiTBQcPP1RZ31JQqNip4+LDtKAKHzbCHscsuVuLonpwvPHHnVPZkw8bqP0MHTAQbBVfE8vEVjcXD+muNLRtuAeNp5oJA7xfv/79EYC75xxJtmVL+fplSlSP74WZ3CtyCiVcekwMlH3enqsHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262445; c=relaxed/simple;
	bh=BqW+NHVQfV90UXpZVjr45/4/xXU74MNnhEymK9lft9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7bE7Ke+9GWjEw9dneXWc+WOOD6sdnUCoZ7H0NB5G7WIt7IBZw/ixknwggEnuHJQAYYM1ZzT5xQkZFIGBRGDPxoNPbvUSMA8U2BWCoLPZ0Wpap2Y9Wi4TVTRy5VZ0hdaRsZrUCTBTE8TQX+o9exoPeBc1ljC3gCqFQ+YYUH2OTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgDQFX/9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so4581a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761262441; x=1761867241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqW+NHVQfV90UXpZVjr45/4/xXU74MNnhEymK9lft9Y=;
        b=wgDQFX/9ig15LKqt/vnopKVYisTwftyj7C0+V0JSkVkz+hKjUian2kAAsxhQDij1FE
         VAKpgOYH0h3mkFj0VFqb6QQfFBSIY1/vlFbdnqsZv2y4bFZpDkhrJNAEI0yjf9rkEBzI
         E0BnPtGpsEBO0mu4CxCsAx5T1uaTAl8H7bfD9D1d/jqzWzi3zGVUtjpvYf1E03YeXn43
         k/9t+5R31hiac7VEF3X6o9mENmol1GCcezwl5Sgi1aL//3xYYNmqSor9HWW2AlYenGUf
         ghdE/Ru1aJeKCc1zKPRRpU8FSe2I6L4D49wzm00dp0hZq37BbWfkhRLewwtOvcZSs2tv
         wgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761262441; x=1761867241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqW+NHVQfV90UXpZVjr45/4/xXU74MNnhEymK9lft9Y=;
        b=DNTGtBGKZLIkedoc4b8O+3ggZ38KTJMp3jvQHbRfry4u4oO2gNwge1JQsqxvItodSv
         BY2p6MBW+ZFOf+OSKjLi65K3IURstpJALia40zfg5nrGEcG6XGJ5CJ+qouz9w+E5Pz9r
         eSyxI6/BSORvDz+kH7/IWRduXnXxvDBAX/RwnNGKTFVy4Erzm+LKABF3+wa1knloOo0n
         qqbwqXJGVVkWuOQqI51ekXuXngXaXpk/JWD8iG8K0oeM8t2cDga7n40dn3K/XggdApOL
         BZCEiiQO6M0txn1kabR3d9yFPfYqaeq364g8rx0IN2IvdtyW41RG+byKsIddbNbsgNNC
         bOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe/6E4h1CuOwrbmoDH0AN/BKxZQnN+sHMlAD/fOP8GdFmrA+VJ+c4iabbf+J2W2OBQjKBoe7O2/3bJ7k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCeWHfRujxXJIp+519gY8tTPaiURzKzvgpQnpi3sUlfnjwZcTf
	NYY3GzPRNUzpb2ZXnq6MbAcqAPrVI8W8S/l01SstT2sdUKZxQekWlufDsLh3p5FjiFF1GWX5oRv
	KKI0YkEKbJkMdzlX3sMr8G3+lyHCMlkPFNXetWdRF
X-Gm-Gg: ASbGncvmNQc+J1lCl4L5kL+0VLP6mSkZYL415NF0OrNa2FaLhkJ4M6fLh8e5jN0yyeO
	qhyUQ7HGoeYU8mTwc21lEuDFAW+GvoMT8IJpodmIYAeJaxB2J8QbBZhW5Pg5aZeQilBNNQZ/ecO
	B5n00t48QvbE2bu9Rz+cH3Au6PHyb0aE0S32H5gmpBis4CU7PwDPHA5cgzTjBwE1ONSExZkZtRo
	Mu4FgZ+uRlDSs5Sgz5sBt8bgmbGUX9tnsc5oEbkGBhn8oXouOVOgm/cniSry7WI169m+JZVGqDZ
	xJiu6zw5u8Srew==
X-Google-Smtp-Source: AGHT+IHWDAwdLYomR1PYX5oAmfP7WE5iGlButtwINm5xmhHS5OA1kCEzVqoMJQe/caQWZIxKe23lUpXimYx8kL3xrJ8=
X-Received: by 2002:a50:fc16:0:b0:634:b4b5:896f with SMTP id
 4fb4d7f45d1cf-63e5d0cec58mr40130a12.4.1761262441353; Thu, 23 Oct 2025
 16:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022233743.1134103-1-mclapinski@google.com> <CAMj1kXFqwOYBNPzNYo2vjPycjyO5SrEnk_wRVDw_dhGd8qT2qQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFqwOYBNPzNYo2vjPycjyO5SrEnk_wRVDw_dhGd8qT2qQ@mail.gmail.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 23 Oct 2025 16:33:49 -0700
X-Gm-Features: AS18NWCEbHOeke_sVgOgEix4Dn1kmaB8LD7gw1gjAXeAb50HOM5SXsvrRA45rzg
Message-ID: <CAAi7L5fBgwUTi7J1r2WSQbQRC_kkGaTxPNBGoYPXyt4d-8srtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix avoiding memmap in
 physical KASLR
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <chrisl@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:25=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hi Michal,
>
> Thanks for the patch.
>
> On Thu, 23 Oct 2025 at 01:37, Michal Clapinski <mclapinski@google.com> wr=
ote:
> >
> > The intent of the code was to cancel KASLR if there are more than 4
> > memmap args. Unfortunately, it was only doing that if the memmap args
> > were comma delimited, not if they were entirely separate.
> > So it would disable physical KASLR for:
> > memmap=3D1G!4G,1G!5G,1G!6G,1G!7G,1G!8G
> > since the whole function is just called once and we hit the `if` at
> > the end of the function.
> >
> > But it would not disable physical KASLR for:
> > memmap=3D1G!4G memmap=3D1G!5G memmap=3D1G!6G memmap=3D1G!7G memmap=3D1G=
!8G
> > since the whole function would be called 5 times and the last `if`
> > would never trigger.
> >
> > For the second input, the code would avoid the first 4 memmap regions
> > but not the last one (it could put the kernel there).
> >
> > The new code disables physical KASLR for both of those inputs.
> >
>
> Should we just disable physical KASLR if memmap=3D appears at all?

It would indeed fix my issue. I don't know how much security physical
KASLR provides but I'm not sure disabling security features instead of
fixing them is a good pattern.

I would actually prefer to significantly increase the
MAX_MEMMAP_REGIONS to something like 2 * MAX_NUMNODES but I'm not sure
if creating such a big static array is okay.

> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > Suggested-by: Chris Li <chrisl@kernel.org>
> > Fixes: d52e7d5a952c ("x86/KASLR: Parse all 'memmap=3D' boot option entr=
ies")
> > ---
> > The patch was suggested by Chris and I modified it a little without his
> > knowledge. I don't know which tags are appropriate.
>
> I think this is fine, unless Chris has a different opinion? In any
> case, you might add a link to the original submission.

Will do in v2 if otherwise people are okay with this patch.

[snip]

