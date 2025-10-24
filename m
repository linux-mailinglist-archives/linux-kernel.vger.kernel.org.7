Return-Path: <linux-kernel+bounces-868112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7221DC04663
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8EB3A9AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7F2144C9;
	Fri, 24 Oct 2025 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCNwGQRu"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9835B14E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283915; cv=none; b=lq2Qo8FMsaN9dA+KvWjg8OEYsX8HUl0BEvTga61Pdtm3263FFTQ69rtREmJ+4BmlFIDCmK+7DwNQrk6oOsBFxl4qqr1DhJMRKVkJFCZhH1d4JYV5qyXu15AuvAYPzpZjuM9wjP+qS0Qcx9b/KxnNlqE5CivgYmCP0e8s0SxneW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283915; c=relaxed/simple;
	bh=5QVlq1E1welM33ugXxDMeg6/WrmnoC8hajuTmVVFYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZM+KQGaApvxEcmoj7OukJL8nkiduBwRL3nF5+PEc+JMNpr32P6vZChjUmfXcCQj4G5HjpR4l1iuCAH70p7BM5UR6/K2xNbPSHfV2fImOBbDNnlpZr9u7BSGBRgXzqRQN7vbw+5YwRAKYWZvV6n6i9Fh0DfyW5vqGlmCujfTbPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCNwGQRu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b62e7221351so1431669a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761283913; x=1761888713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHfVHx15Bq2/aoRhICm73cKae4vxx15Gf2KsSuTNfOg=;
        b=OCNwGQRuGgpz+1UZjoxX9x/sRd28OW82fNFPTWWSyUUwXxeDEcPHmeRsL2lZerLPEB
         d4JykDDSYjV6l/V2zrBDVS90Txp4loP9DABmxoe60xSBnPzCa1zffFYwGQDoJeg6Ue+s
         nHfjYMqOXdyt8eAlFYLW5VNAoZVhiWOrBnT2zUA01OnuNz3v6nUSO+FDd9oWlxGGR3kL
         d9DSX8jo4ON911L9jFDjAdQmpxb1d5NqU9LPx+K3tQybMOrk8fk5veJXe/uD13WfDNzJ
         9FQD3zyzTAR8Bvu4TlT1MUhBbKnZQWZ+BskCbhFNi7wNgeJ3tReHwblPP+5Y3S/wpxdT
         /EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761283913; x=1761888713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHfVHx15Bq2/aoRhICm73cKae4vxx15Gf2KsSuTNfOg=;
        b=Dhc/hUbO/piz9Wonx3IlOYfEDKkzFjYUYy/0cjRuFpYJCOfz2j6MZLNIQHel0CCT5w
         RcMKbW/HUeckFoXnxGu9G4SMgEzNx0NdeNfG/4Omm9zPC/CC4wMwwDqltsze1W/itRWk
         hiYq1fHW7HzoR+ePft5eB5dS3BFBuWXw71HHN+QY76hrQ6YkAfvTm3iUllXmT9QJppq6
         +dpNP/QDoFm/G7M2EuVrPckHiE/PAisstdmLUVYkcXerdR0LjdVQf2y3capv9eRcCtEq
         za8jzJt0k1D8w0A2P6bbMu2HBI3yNm20sssuHFATOLF8swg/BXp/8uBLjiXtuFcqYx15
         ZSSg==
X-Forwarded-Encrypted: i=1; AJvYcCVnjVOtiIdEdDb2krvZm8pu7HtadPpmkDFqlUnm19sClHKPa1Cla1PRAzaYUqYyHwQTOmHirskTgFdthJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG40NozocaFqUrO+SMi1zNqCVFbdVRklb5AJ5EFepD/UWQgtY/
	tqFpNK24R1fxSbdNAU/dF2svSgTgfD0LS40kDXIy5fvF2RU04zsDfPO36Rl9SExD6SCRrrcF5vr
	mZdcGVfPRW8yWseSG5eUSo9OQ4IxV8/sbzfWZ1zF4
X-Gm-Gg: ASbGncsqnFbXGEUqrx41dWZmIGYYbXzu0jRcbHIDPVK79d4mwRu6ge08X3dfZ5Ksjr2
	HMb3Apov6txXdvf1cSKP6Lbq4/3KlBM5n18B1Cj01lmrZVd0MwGdbPlaE3Pay0UJt7GXdYM+2xF
	4qnF51cM5ApoyuSldUe8U62aw91BKT9kUfAyMnZXTt4nthjqtV2mpnAxu+izdOn5EEyNVD+vPgP
	1v2CTVlRjCL8AFVw6p4j4HDsmCDEFHQovEXh2DecZclW01ruCnRUNzL7lZtaNWcaNo11dmnksgc
	ulZern64oRepGoGVm74zDNA8uA==
X-Google-Smtp-Source: AGHT+IF/VvU9VCEldtU8TlKdOOJKqinHd6plYVfP7jz1N/U0hWCfgU1KoVW9GCuTIIpcsB4YHkE/z7uj+DsUXzYb81k=
X-Received: by 2002:a17:902:f542:b0:24f:dbe7:73a2 with SMTP id
 d9443c01a7336-290ca121a7bmr368072235ad.31.1761283912454; Thu, 23 Oct 2025
 22:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023000535.2897002-1-kuniyu@google.com> <20251023000535.2897002-2-kuniyu@google.com>
 <CAHk-=wjXGvUnmN5ZL3nhj_J0cbiVfeHsM9Z54A55rgHRUaVOfA@mail.gmail.com> <20251023092910.2ed9cf15@pumpkin>
In-Reply-To: <20251023092910.2ed9cf15@pumpkin>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Oct 2025 22:31:41 -0700
X-Gm-Features: AS18NWAlIGQJ_wV8neCVFWBA2cf-w_Bdy_0uat0cNCw22R5tVWCPnuP-0EplywA
Message-ID: <CAAVpQUC=KH8iFOdMZfnuXdEMuCYuEgFxNvU93zgFNiGSU_tMLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] uaccess: Add __user_write_access_begin().
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:29=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 22 Oct 2025 19:37:27 -1000
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Wed, 22 Oct 2025 at 14:05, Kuniyuki Iwashima <kuniyu@google.com> wro=
te:
> > >
> > > unsafe_put_user() can be used to save a stac/clac pair, but
> > > masked_user_access_begin() or user_access_begin() introduces
> > > an unnecessary address masking or access_ok().
> > >
> > > Add a low-level helper for such a use case.
> >
> > I really suspect that you cannot actually measure the cost of the
> > extra masking, and would be much happier if you just used a regular
> > "user_access_begin()" (perhaps the "user_write_access_begin()"
> > variant).
>
> Or wait for scoped_user_write_access() to get committed and then use that=
.

IIUC, scoped_user_write_access() is simply inlined to
masked_user_access_begin() or user_access_begin(), and this
is the case where I saw no improvement or even worse performance.

>
>         David
>
> >
> > The masking is very cheap - literally just a couple of ALU
> > instructions. And unless you can actually measure some real advantage
> > of avoiding it, let's not add another helper to this area.

Yes, it's only 3 instructions on x86_64, but by saving them
I saw better performance constantly.  Please see the numbers here.
https://lore.kernel.org/lkml/20251024051653.66329-1-kuniyu@google.com/


> >
> > We spent a fair amount of time undoing years of "__get_user()" and
> > "__put_user()" cases that didn't actually help, and sometimes only
> > made it hard to see where the actual user pointer validation was done.
> >
> >                Linus
> >
>

