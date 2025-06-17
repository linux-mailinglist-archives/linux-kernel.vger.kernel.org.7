Return-Path: <linux-kernel+bounces-690626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38130ADD7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 18:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FEF7A0FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D9C2FA641;
	Tue, 17 Jun 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bi/fC6DK"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2E2FA622
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178736; cv=none; b=mC+Efg/GO1kYSZslA7v1E3tbHZy7hd4xu+UdsOGkvuNJdW3PRVBGb0xDImSfB4yFiIir7EmO1RCzt+2LurTXAZZ9L3DcxboyJIfcMGAGG2ldksgsqmU4gir33YuJ/nJpop0ed9fe29+vUQb4JCj5t/z8SOZZ+OyOyuPGxTFQ4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178736; c=relaxed/simple;
	bh=QlSKujTZlaBLHU+qu/frnC9Q5uFPEe/DuWTpe7Ul7a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US1ztshKof91/t9NEDWVquRiI+iaaRcioz16yPs8bNxvAj366ToHxk8oqhux09wXi9QBwnffC/TgwRp3FBunWa9QbiAHciHK4oYOFGZpsCOALumqGHg2jBY4QMe0EPBbnkipdywtWf32wYcAnzpdaxA/EYfNy439COpjLGbFBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bi/fC6DK; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53167fb5690so677174e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750178734; x=1750783534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXhemJPdp/3fXynI49MHBimsNv3czWVJS7vfKOb1L3g=;
        b=bi/fC6DKfIUT/5udQaViNeKFFFLkvovmW/lfWGTJxN2Mtl8lzOOLGRsnj8Kdl62dXT
         MUmUgUmNjus1ewy4D+fg9BcHJMw/OB/pfoTb5S4YlUfNVU5TKoEzzE3HzfgsSxF0b3tR
         1KFY3aBWA2IjmjkIsNohqVwFwOJajhnGfwLZ1vy3Xj37HDKB7aThMxSs9imqENLoMUvg
         GPQ3JWmRgiFcBJCHkY7cI1X+XxDGKVXnbGjfYIt6hifXDiZdn4/N/zVbQCmYCm4MxAqL
         pPs4ZmZ+rQz5hnu7oSZQsGxFOquPQZfOgSzj7yhyleQVBn0XdMjdnvom45BXP9I1O4kh
         1xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178734; x=1750783534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXhemJPdp/3fXynI49MHBimsNv3czWVJS7vfKOb1L3g=;
        b=NYY0rz5+3AjjX38lNjBPBUdYugtlca321613qlkQarbC27+PmGWNRtsigQ9gBnh3qt
         No8zieJOL0BioD9MvS2czNerHTjJ6Kut04GsK8KaYn0hLl/DqIwz1Nj+Q93Ux++3bbYB
         uXevlFvcfdoEUOz6qgH4BGNzM0Ds7j74HnN61mKisUGL98aw1doQCpUGCrqYlyPwcqBV
         cRlKp8lQZ5zA3eASu7M3rPnaL9csEqu9xSz4rOe90N3Fb+JxP3GGKYEyDuXt9U2kc4yj
         tckrTcRW2EmCYyorF6Gn56WxJ5KQ/mY5A91uwFHSP7+LrTLVbWawZsInB9S/aipjnzO9
         qR1w==
X-Forwarded-Encrypted: i=1; AJvYcCWLWttYYUBIo35sK5mrknfgGsAUcV4VVFoJ9T/dkKVOQJDH8ybYUo7d29TPk1wTKPrSeeBgD2+b0fDI5Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0a3r/toaDHQI3DFct2Vyl+r4r7/MJGHU+CCYW0EwhhQTIproB
	munRGZv/lNMXYg6yrLrWStCAQJjBEE0n/3dZ+aVxbvml8HxllomeeiWQMfr5GyOa8AMU4o5WCRY
	Rqyduof+VLWsbsY4h59MA4Lk4R0dLsP2Sk92izhcdzw==
X-Gm-Gg: ASbGncvwRS3w/Gyg0HxDJR9uZ/K34jjuKQXkckBOEgsqj6QH+yzdoh7H9UU/IkriWAf
	JYl5gAFpHSFFqIq5fAuXEkkwlC22FYk+evSM6iZOCNkvUitwC7iWhcRwicIbn9i6VLoq+RhASy3
	xe1AP1ZfEDGpRwaBhkjjiHAWGU+7RvvLYxjSNzoRgcvzcazqkNVdkFKrcKmlQhFJHcl0XtqEB7D
	0lp
X-Google-Smtp-Source: AGHT+IHOrRt1lDtV+b6aJDYLThkYnTrOcVa6lAhpv+M1PokEXkMAz1eA8pVNvHz4UWw1yBppC3ArIFBZ+3pgDS8SBH0=
X-Received: by 2002:a05:6122:1b07:b0:520:61ee:c815 with SMTP id
 71dfb90a1353d-53149869d6cmr8701581e0c.10.1750178733716; Tue, 17 Jun 2025
 09:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
 <20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org> <CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
 <20250610105337.68df01f4@gandalf.local.home> <CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
 <20250613172753.3479f786d40c29ec7b51df0a@kernel.org> <20250616163659.d372cf60ee0c476168cd448e@kernel.org>
 <20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
In-Reply-To: <20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Jun 2025 22:15:20 +0530
X-Gm-Features: Ac12FXxAwLyToHkseFApClLDnOgkdr0qu9cWg2D1qvO5sz6RJsV8jwdXs125LsU
Message-ID: <CA+G9fYsBhS+yUa5KSzGDzqPhbRxW5p9_qLjt5taecAcguj7oNA@mail.gmail.com>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 at 16:12, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon, 16 Jun 2025 16:36:59 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > So the fundamental issue is that smp_text_poke_batch missed
> > > handling INT3.
> > >
> > > I guess some text_poke user do not get text_mutex?
> >
> > Hmm, I've checked the smp_text_poke_* users, but it seems no problem.
> > Basically, those smp_text_poke* user locks text_mutex, and another
> > suspicious ftrace_start_up is also set under ftrace_lock.
> > ftrace_arch_code_modify_post_process() is also paired with
> > ftrace_arch_code_modify_prepare() and under ftrace_lock.
>
> Eventually, I found a bug in text_poke, and jump_label
> (tracepoint) hit the bug.
>
> The jump_label uses 2 different APIs (single and batch)
> which independently takes text_mutex lock.
>
> smp_text_poke_single()
>   __jump_label_transform()
>     jump_label_transform() --> lock text_mutex
>
> smp_text_poke_batch_add()
>   arch_jump_label_transform_queue() -> lock text_mutex
>
> smp_text_poke_batch_finish()
>   arch_jump_label_transform_apply() -> lock text_mutex
>
> This is allowed by commit 8a6a1b4e0ef1 ("x86/alternatives:
> Remove the mixed-patching restriction on smp_text_poke_single()"),
> but smp_text_poke_single() still expects that the batched
> APIs are run in the same text_mutex lock region.
> Thus if user calls those APIs in the below order;
>
> arch_jump_label_transform_queue(addr1)
> jump_label_transform(addr2)
> arch_jump_label_transform_apply()
>
> And if the addr1 > addr2, the bsearch on the array
> does not work, and failed to handle int3!
>
> This can explain the disappeared int3 case. If it happens
> right before int3 is overwritten, that int3 will be
> overwritten when the int3 handler dumps the code, but
> text_poke_array_refs is still 1.
>
> It seems that commit c8976ade0c1b ("x86/alternatives:
> Simplify smp_text_poke_single() by using tp_vec and existing APIs")
> introduced this problem, because it shares the global array in
> the text_poke_batch and text_poke_single. Before that commit,
> text_poke_single (text_poke_bp) uses its local variable.
>
> To fix this issue, Use smp_text_poke_batch_add() in
> smp_text_poke_single(), which checks whether the array
> sorted and the array index does not overflow.
>
> Please test below;
>
>
> From e2a49c7cefb4148ea3142c752396d39f103c9f4d Mon Sep 17 00:00:00 2001
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Tue, 17 Jun 2025 19:18:37 +0900
> Subject: [PATCH] x86: alternative: Fix int3 handling failure from broken
>  text_poke array
>
> Since smp_text_poke_single() does not expect there is another
> text_poke request is queued, it can make text_poke_array not
> sorted or cause a buffer overflow on the text_poke_array.vec[].
> This will cause an Oops in int3, or kernel page fault if it causes
> a buffer overflow.
>
> Use smp_text_poke_batch_add() instead of __smp_text_poke_batch_add()
> so that it correctly flush the queue if needed.
>

I=E2=80=99ve applied the patch on top of Linux next-20250617 and ran
the LTP tracing tests. I'm happy to report that the previously
observed kernel panic has been resolved.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=3DtKyqP7FEKbOEETRvT=
DhnpPxJGbA=3DCg+4w@mail.gmail.com/
> Fixes: 8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by=
 using tp_vec and existing APIs")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/alternative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
> index ecfe7b497cad..8038951650c6 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -3107,6 +3107,6 @@ void __ref smp_text_poke_batch_add(void *addr, cons=
t void *opcode, size_t len, c
>   */
>  void __ref smp_text_poke_single(void *addr, const void *opcode, size_t l=
en, const void *emulate)
>  {
> -       __smp_text_poke_batch_add(addr, opcode, len, emulate);
> +       smp_text_poke_batch_add(addr, opcode, len, emulate);
>         smp_text_poke_batch_finish();
>  }
> --
> 2.50.0.rc2.692.g299adb8693-goog
>
>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

