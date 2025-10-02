Return-Path: <linux-kernel+bounces-840798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A82BB5720
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E74544E66D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBFE1E008B;
	Thu,  2 Oct 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OvqFYGnZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADF7081C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439412; cv=none; b=C0/+wSdhPVqIc7A1ekbu2L4S/JgInfqnQiGOpfahDdtE6vfDIqDPYSRspFpCe6+RY+zzPZGFWS6nPXzbe2icqL3GlNixSyyMilDdhRCFuP4l8oaMhcfbfi2j7AS7FFo99s0eVflw3U7kL1xwqGi1eIcb6niCYsbgZW+Ob6ElLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439412; c=relaxed/simple;
	bh=fiUOyQ6iGeQ22U1sPoN7c/8/2YmXLYxAeKd2vtk11nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYJyEjKoARuYIdpYTu7Uc/J7rZcqWH9j1GTDBT42KqndoCSMK5usZ6uRC1n78nmPZ/0xjiEarsm6IvWjIWdMh0WCabaAJTKB1FmSGgvFE2uTGPKceh4kFBQgMv1WHzqE/eqri1oX7l55OcfqLbEuWlqzapOp5pFFHnpE01r167o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OvqFYGnZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-636255b92c9so2477767a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759439407; x=1760044207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5TPdFtyLRsVmbepAE5ls45/K80yfrCXm+/XCuvIMnss=;
        b=OvqFYGnZJMi04gXX76aDcvibG8wSxShZUTy4TJTKjYVPG6eghzhnHxS+nmjdj6ulpd
         jTYG+kFUkh7qTyU0rBoq7bcElxlLBiwGR/AE4vMsqQzxH+dJLxdPQvvvEyJIhSIzGmxq
         MfeUnir5+xlk4tSd/LEQrbrQYGnXzaW9nP7kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439407; x=1760044207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TPdFtyLRsVmbepAE5ls45/K80yfrCXm+/XCuvIMnss=;
        b=KfF1K8Zpb0SORGGlu4OQBEcAi7RiXbjoEDutySVciYPi/RFn1ZRGtfEVVwxMtOj4ck
         gREdp7aGjmKcCemz9OjHzsYUzhSQAxdpZPl7pjNQyLtyiJtJHbxpmcgK9cRf+nOV2W0I
         AbDbMt/3EG3J4vsr4Tff19hfqqTtrx8yB58Pntln23p5yIYxeI9Xk02EZ2Dwmgbec9qK
         vX7oIn8ljznI4C9Z3MEVPKRZQ0DoWatIA2QX+8Du6zp8wqNzKPapXewBGGn7ghYxo7R1
         yQWWFSSQsAQAMQgqVayxZcHJcWD9qzBJEnFyAp8NVmI6ttpAZApfJ+bAbQubIaqGrJfG
         hhkA==
X-Forwarded-Encrypted: i=1; AJvYcCV4IDGJtsaGVmpWt3fsaEnttU5b4LLVXsa/6Q8kPDqjmxj3UVF8DXAmR3XJlkKXpvM+bDg+LA350CdVahA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5fUh1btdSzFaj2FhCsBYKVitAo5POXId6iK0Ydr8QZ9MqZ4n
	tS5zdyAGLSGn6FEZY424m90bmGOxXNVln/yJd/TeM5cfN3IZC2Hs05zUFjwoP2X/rGec05DV+HI
	sLYHsHeI=
X-Gm-Gg: ASbGncubCjbU23oTW43Dp0jeztbsv6PvGi8JvvgH7TTsGAmi/DXcq5VvswD8OWmbshl
	S8nBdShRujpI0au/ghRfB/n/Ow2hjYR4rvj72ecVpXH4KDiUBRIgKdJeB1j978kkHBpENIXsy+W
	0cMuqMegyib4xJgXlyMdPJS/18JOpUOLHs/yjq/A3zgYDFz2DyXIDlH7MSKu3JjqTfSjcEyDJSA
	PB53bYYoILL4bhY7EJMBFnvzQLv2DvYWNFz05qyvT14gNgHcui8NjVyC/OwQaJ5qHq6q1zTKJBN
	Yiy7lWtrMXXzlkzUS0r7JecbDFu14DmbRrP8XWVG4Na9XwvkBnBar8uiXlP2a4mqgZp1w61xmyi
	U+RPYuyQE+hhmcDcnaR5eRk8yV6oC2UkOVJEolN62h2t5m2gL0yxX07xyobqYyqV1kOrhH/T2xn
	6fFAroW0Bt3+rEfCdVaiDX
X-Google-Smtp-Source: AGHT+IE2JcV4ji8pSPXADoum8NeIM4d6/QCnMbjIrDqhyLRttP0ZIdLtdXQzmwO8tHtM3r8/JnADIA==
X-Received: by 2002:a05:6402:34c3:b0:62e:e5b3:6388 with SMTP id 4fb4d7f45d1cf-63939c28081mr585501a12.19.1759439407321;
        Thu, 02 Oct 2025 14:10:07 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b6927sm2594577a12.14.2025.10.02.14.10.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:10:06 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso2644951a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:10:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWziKTUujVWeJJ0VT6KfHco7gCAe747+mVl44tvqmvveVLrVQneApSrE5q+Sm01wt46C/H6O6Vt0GMG34=@vger.kernel.org
X-Received: by 2002:a17:906:c14f:b0:b30:ed1f:894c with SMTP id
 a640c23a62f3a-b49c3f77bd6mr104348866b.43.1759439405095; Thu, 02 Oct 2025
 14:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNrm_14uJmGE7MYC@yury> <CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com>
 <8170477.EvYhyI6sBW@workhorse>
In-Reply-To: <8170477.EvYhyI6sBW@workhorse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Oct 2025 14:09:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib1_c6-MaJz+5Y_UOgyCF8+OCYKx2gnzHRCo3XaRNa4Q@mail.gmail.com>
X-Gm-Features: AS18NWCxGvi32fp3H7pyvIAfJ-mTj-t2kT6id3TD_LSFKpT6so-PBuaHyRs_1oI
Message-ID: <CAHk-=wib1_c6-MaJz+5Y_UOgyCF8+OCYKx2gnzHRCo3XaRNa4Q@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap for 6.18
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	NVIDIA <YuryNorovyury.norov@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Burak Emir <bqe@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 13:32, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Thursday, 2 October 2025 18:46:01 Central European Summer Time Linus Torvalds wrote:
> > See commit 10ef6b0dffe4 ("bitops: Introduce a more generic BITMASK
> > macro"), and notice how ALMOST ALL use cases were switched around to
> > the illogical "high,low" format by that introductory phase.
> >
> > And yes, I understand why that person did it: many datasheets show
> > bits in a register graphically, and then you see that "high .. low"
> > thing in a rectangle that describes the register, and that ordering
> > them makes 100% sense IN THAT CONTEXT.
>
> Hi, that person here.

With "that person" I was actually thinking of Gong Chen and that
original commit 10ef6b0dffe4 from 2013.

That's the one that introduced the high,low ordering - the code it
replaced actually used low-high in the EDAC driver (and high-low in
the SIS driver).

So that's the commit that started using high/low "officially".

> My datasheets indeed show registers in the probably verilog-derived
> high:low notation.

Yeah, very traditional. I suspect it predates verilog, and yes, it's
because numbers read right-to-left/

(Unless you work for IBM, in which case you start numbering bits from
the high bit)

> FWIW, I am also not a fan of GENMASK's high-to-low order. I do
> however prefer it over bare hex values

Yeah, it's not like hex values are great either, although I do end up
often reading them just about as well as bit numbering.

> > Am I the only person who would find "BITS(1,11)" to be much easier to
> > understand than "GENMASK(11,1)"?
>
> I'm with you on that, but others may disagree.

I wouldn't necessarily mind having two different ways to express bit masks.

And sometimes you don't want "beginning and end" (never mind the order
of those two) but "beginning and size".

The HI:LO format is very common in hardware documentation, but a lot
of our _software_ conventions are typically driven by packing bits
into words, and then we typically deal in "I need X bits for this".

I'm thinking things like the page flags, which are also fixed bits,
but they are fixed at compile-time depending on various
configurations, so you have things like this

   /* Page flags: | [SECTION] | [NODE] | ZONE | [LAST_CPUPID] | ... | FLAGS | */

with the different widths specified in

    include/linux/page-flags-layout.h

with fairly complicated rules. And then we shift things explicitly
with things like

   #define LRU_GEN_MASK            ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)

and we do use BIT(), but it really ends up fundamentally being "X bits
starting at Y"

           Linus

