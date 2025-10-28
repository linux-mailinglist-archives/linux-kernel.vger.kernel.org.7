Return-Path: <linux-kernel+bounces-874276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9EEC15F12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5C3421799
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6FB3451D1;
	Tue, 28 Oct 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUniYt29"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB4343D9E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669760; cv=none; b=JSBC7gmDRuDzdF6xdfQ3VoVoqtbNOwaW9Omex4KK5tdkujKQ1bcLerkmVPkUx0/IMAXBQh+AGNaXX5ZN1bdBgZcjVMIKa2fBAvktx76FFCFBdM+zmO2LedZUdMY7EltBPmySKPTIc8ekTJVK6CqWZ0b6eMY1jurapSY/nLX/hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669760; c=relaxed/simple;
	bh=fmcSkCTWJXxMwOHEOfJ3aeHiFD/tJb5QoCCZSX55ODc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYig35qzQS6QlOt+vQd4cimkm6cdwjCO+tgUELS0zg1edb006lQe5KBtYqGVpeYLeg4rs2k0A+twuhh+GALVpRUEJUAaVTJo9TMb5YEn9m99UFDsseDIQonINcwGRUSrPUClmoegVgT72DTILQj1xdDjrC7ONd1oma+nThP3Y+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUniYt29; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b553412a19bso4058843a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761669758; x=1762274558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/gmStdv3FU0oGBzCptCijx3MdjTDsamveWiRrc2ft4=;
        b=xUniYt29jAvYMWDjJ2xXLF4SQ5kOdSmcpYAYlXnN0Fuu1y8a2tWyn+SC1aLvvwO/ej
         5o5YCd1WkLze/1nTjVD9/bQqL94x8PIEMUIY77/fz0/+2HckIGDULqpKlf7STDwMV5BH
         7Vwb+4TqfDvLWSDE3Stau6EgiT++8FGo+nInifZHq57dORwnsGEFDxGJlj+XLqkDVTCw
         Szt0Os5BiSlN4hx5GrHDerPsTiVcgxLbdZCd4zJEt95O3OQhyBrfUVK28NWTJP+b4HXc
         YgtPjIMAav+R6QguxAfh37D62f+mejz3NQlIoxGRfu+tUFRe1Y5zBm1F54bSx4XIDs2B
         ktDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669758; x=1762274558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/gmStdv3FU0oGBzCptCijx3MdjTDsamveWiRrc2ft4=;
        b=myUbGkh3MtlzCQX33s5aMOVIP8oguDztnXWHrSVTgF6WQh4KHuPkwAs33/1l0wSECv
         gGQGqT0KYrKARN0BqFZBPXZEvAzI3ySUtG69cBlqQUGj64tyYqVa4U57gbdtlqlVs/MW
         9qyDcTs7o4PUAxcYUWnbZONyfMKK18PHaYRG1v6p/9Bpgb6JYvb9PqInXBmC7gmAoGa/
         AmAg/LQc1jJ7/Wfc4+p8I8hVVwnJ0EBkM8CJ/TB3lrtCLjLuUFk9VhJpvypDgDePh6zJ
         5eh7JPWx9bYwYv8qiCEY0QRIPnUvgTh7UliESBG1nE2EEHC+fi40wbIGJj8a0aRKrYCE
         9vTg==
X-Forwarded-Encrypted: i=1; AJvYcCVf16dzYuMc1YRXzo3jKpkTDNMRRvngRU7I9t0YQSwAOeGmy6dMNfqBJF/YzlQfPevQZorfkHhDHHy8CY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63Zk8N81UTWQtZ8zbKAgqlb7xpfbcOBNJMDolsg0S5XdaqdTB
	9+v47kf4nPBExhk+6h9BVDn+Zg8JwmpaS/04V3QXPQLZf+IN18XXAHgMMFGDwpHdqolnnPjlHQ/
	4jmMlPQqAY+JCldObBNbXfeMgpmvc3cyZ3xcs2QBC
X-Gm-Gg: ASbGncv2NXgKzmxvegsu/fN8ehY8zMAUpPOy5D0AMtkTe4VMPs5VkO2Xi24+uka5sEd
	l9Dq7VNZyO3GfxopT3m3rvb+p5ATGAoH89xqZMdtk3Ue38pwUugs9Cn1W8BMRN6njBcNvDHkLqG
	pHMA5W/milf6GuqYXUsDlLSnw031K6crA1CDV3kWQvzH4H+/iTFPM+LLxISNq329YqXRp8xon/O
	L9f2hpaibmJa3cqDHtL9NY/F5SN/eKpOVe9NDu0nQqnf6bFiiQnIyGwMACymdRrItYucnoTjzb8
	a66uA+y3j1qkzUnTJPE/uoLn1g==
X-Google-Smtp-Source: AGHT+IEA9HqIHKBrDRAdapOaEhdj5ptHdSYRpb4qWqp0AQjJ5Y7jaBBFwbe3KRRyVBlj5jpvCvwUbXxGS+XHLaIF4JY=
X-Received: by 2002:a17:902:d484:b0:290:c0ed:de3a with SMTP id
 d9443c01a7336-294cb522c8bmr51946525ad.30.1761669757359; Tue, 28 Oct 2025
 09:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
 <20251028053330.2391078-1-kuniyu@google.com> <20251028095407.2bb53f85@pumpkin>
In-Reply-To: <20251028095407.2bb53f85@pumpkin>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Oct 2025 09:42:25 -0700
X-Gm-Features: AWmQ_bmNBvZgs1Mp1FllgTi4GNPibwKiayJAa04sxsmAaaKLfS_gUEVbDU0m9lw
Message-ID: <CAAVpQUARk-XeMdTeGy_s65sdwuLY2RzocGyJ=2_WkhsrFN-bUw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
To: David Laight <david.laight.linux@gmail.com>
Cc: dave.hansen@intel.com, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, catalin.marinas@arm.com, 
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com, edumazet@google.com, 
	hpa@zytor.com, kuni1840@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mingo@redhat.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org, 
	tglx@linutronix.de, torvalds@linux-foundation.org, will@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:54=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 28 Oct 2025 05:32:13 +0000
> Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> ....
> > I rebased on 19ab0a22efbd and tested 4 versions on
> > AMD EPYC 7B12 machine:
>
> That is zen5 which I believe has much faster clac/stac than anything else=
.
> (It might also have a faster lfence - not sure.)

This is the Zen 2 platform, so probably the stac/clac cost will be
more expensive than you expect on Zen 5.

>
> Getting a 3% change for that diff also seems unlikely.
> Even if you halved the execution time of that code the system would have
> to be spending 6% of the time in that loop.
> Even your original post only shows 1% in ep_try_send_events().

We saw a similar improvement on the same platform by
1fb0e471611d ("net: remove one stac/clac pair from
move_addr_to_user()").


>
> An 'interesting' test is to replicate the code you are optimising
> to see how much slower it goes - you can't gain more than the slowdown.
>
> What is more likely is that breathing on the code changes the cache
> line layout and that causes a larger performance change.
>
> A better test for epoll_put_event would be to create 1000 fd (pipes or ev=
ents).
> Then time calls epoll_wait() that return lots of events.
>
>         David

