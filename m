Return-Path: <linux-kernel+bounces-822875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28AFB84DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762184A7EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4303093CA;
	Thu, 18 Sep 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9b85mSE"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00602D3752
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202361; cv=none; b=kHfdHPIY2dXac5ZexZMQrQrWQ1nAw7YPobAUeewdsX+LL9NGsF8Avv9aiohMiP2meh+L3PEcpQkB5mTzQRIeG9yW0mRMhWCAGzZzo1ggHXqU6hnd3D+j537L/hqf9uEDNYPnHwOTdxb2gOJ21gpywOdNSPFQEdGqeMzveSiJ980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202361; c=relaxed/simple;
	bh=oxJiGbOc7aw1fHkiA7J0rf4ilEqD7BsiiYiwS7xl7ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+JtwGWmaaSW26EhK8Pjk3QIcuVG5r/f2gogpNMM+aJTPKKgYmzIHY5At1GgzHcU29RQu0wb1UJiIdQKjOakRjdvmRuENkI0hClQWHEz+CS1GadzC3Tf50VHUYkNCp5LFZkdKUc0ZhQ8gqp+GQqFD33u7PpHgX4ZH2SXx4bsdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9b85mSE; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e970acf352fso723767276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758202359; x=1758807159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUE2gHe7YLhn4Tjh2XvbUIgWYcWs0P0Yu4OFl5btK+s=;
        b=e9b85mSEB47sS0mS2GbuuQO1ayTgmwZYK3NBmGqGS7jT/5manA4HtHpOxRdRV8zLj+
         z9EcVKd+fqcPamejFyryVzwCXGjPu4NamsdB7CSdT41b2KE4/07gcmBX8qS2jHLRK3s+
         JSn7fA//iVqqkfTrGo8O7ebpLYO/AZwTdA8Aoag2iX72bwB4KAf2TEt35vKKMgYXLUpe
         AcFbk/bQOLK7i1t1/szrdq6FPieJUILtOemL7mUMA9K/Ney3ABb3GUesQWdyVG74Lte2
         llEctmqHKv2Hgwc1nxrxyHHv+crS5CRg/L77L7xWE59ntRt0Nd5KYvyaT5z5e3nbSyYZ
         sqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202359; x=1758807159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUE2gHe7YLhn4Tjh2XvbUIgWYcWs0P0Yu4OFl5btK+s=;
        b=iA76/L8ZHv3Vcg0kqpCoflciOIICy6Qsst19IlgG0mwmV8DCt95D/OtamdjPVHvr1a
         oGiHrRpFqiK4tjaJCqPV883AOc/GK8k17j49quSXwQ9PmjD3iJYnx7mA8otlNtinO/JV
         6dHti8fFB2Z4YjQSmdHSEqMvCWcPZuQ0hFZGkaJAGoEXMHzwraXdLKiFNdfAU1hWf1xF
         exIPQvkViz3LNZyEn4QsuuUAvTv9dpnanzDHofym4kEMeduHrNmklZRfo+BVzEkaRbIG
         OT42Onwbd1gqdNKBPR8tiuruyLjyZDbnrt5aBuQreVFOAwYz3Z0hhL5jGLnb2aRR/qwm
         U4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0FQQ27ZDNxnJ8eLifGN61WmpHVV40FauG5g/2myw31rDbpWSS6ecWVsohj92zK+vwOliZ10gQHTRWmsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySvHC7dhnb+xrjsO/Z4156cdHzorGDPMvEIoi1BN/GyuexCsVa
	o2tMuTPCRpRoo7Em6CE1VNKY7j+w7EQi60TuIhIF2EbZl4NnfCcPly4lR5ewPNsgjYiz1TockrU
	5vzz1+2qJLCuuo04qPcmnGNuAc9nHm0Q=
X-Gm-Gg: ASbGncsnZknsnbEGqXFhVLF4C07+Gp2RhQFz3i3pMJG/nhouCHBylH3f1fvG/MpeN4X
	0rfNtkbY5CtO7+6fzF6+6eVOJ9680ShCLmGYCwXspbjnEgZDuQ+uG5Eeq4unZlZqBh7m74vG7ve
	9XpvbjsOo4YNvrq7tdqnym15D1/VKSeRjVO85ReRdcfmz7n4Xwl5xZAkbwAGSMgvOe4LzGTZFZu
	6lGvjji73Sn3BvZK2n+7sJgUQ==
X-Google-Smtp-Source: AGHT+IGtqcAVAFdskQ3nvvg5tGb+wpuXkBl7+z9D1cZ5z+zV4plcRbO2+OWKDjgQB6MO9fLNyoHo4500LAblOC9RzIA=
X-Received: by 2002:a05:6902:6203:b0:ea3:f114:75e7 with SMTP id
 3f1490d57ef6-ea5c0687159mr5679817276.28.1758202358485; Thu, 18 Sep 2025
 06:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn> <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 18 Sep 2025 21:32:27 +0800
X-Gm-Features: AS18NWBtunmHG653NSNG_FTMHgwxFNYu3n6X3_LSv7HnFAXelTzRmzVHNLLq10M
Message-ID: <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, kees@kernel.org, 
	samitolvanen@google.com, rppt@kernel.org, luto@kernel.org, 
	mhiramat@kernel.org, ast@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:05=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return ->
> > kprobe_multi_link_exit_handler -> is_endbr.
> >
> > It is not protected by the "bpf_prog_active", so it can't be traced by
> > kprobe-multi, which can cause recurring and panic the kernel. Fix it by
> > make it notrace.
>
> This is very much a riddle wrapped in an enigma. Notably
> kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is that
> cryptic next line sufficient to explain why its a problem.
>
> I suspect the is_endbr() you did mean is the one in
> arch_ftrace_get_symaddr(), but who knows.

Yeah, I mean
kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
arch_ftrace_get_symaddr -> is_endbr
actually. And CONFIG_X86_KERNEL_IBT is enabled of course.

>
> Also, depending on compiler insanity, it is possible the thing
> out-of-lines things like __is_endbr(), getting you yet another
> __fentry__ site.

The panic happens when I run the bpf bench testing:
  ./bench kretprobe-multi-all

And skip the "is_endbr" fix this problem.

__is_endbr should be marked with "notrace" too. I slacked off
on it, as it didn't happen in my case :/

>
> Please try again.

