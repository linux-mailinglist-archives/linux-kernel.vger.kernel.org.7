Return-Path: <linux-kernel+bounces-690043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6ADADCAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9AD3B2606
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07D42E06FC;
	Tue, 17 Jun 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gD1tcwYZ"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F12206A6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162240; cv=none; b=CjInT583GekQzYcMs4vGEQM1/hf3UPs7NgEvatdoSfsMQgcKkRIrwBmsBO6Dy+mcsVboVr7vr6jyDo2mnVRhMzlN4pxZP1SvGkQYLwukMOKSb1HnmOxbPNL5mIEICnfFWENhmCveWXDos6MtRDeB6IrtBCO5sXLuO1TvbUXEWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162240; c=relaxed/simple;
	bh=eQbtgAXVim/V7lKvfBJCMdtJg5asI7FbXt5KYJh6f+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/3F/ht1Efws4CA8o/MLt3c9Qq1dtkc6WJcXkpufoyq5+OTpvtBteJzTASlcMcwlDfEe8bgBmabQzKe0LTKOyeYE6HKp3xV0ftLQkS7gLI/9Q8GiXue/02dWaeiCgwQjNB3ZvguanL93VhydcHb0rzjApirqF6k7+8nUCJhOv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gD1tcwYZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d0976776dcso613763285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750162237; x=1750767037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=03J8IjZSa7RJs746bHjxfihX5+FUeZTPfOgcNc5eBLg=;
        b=gD1tcwYZHSF0BuSGF5QfkRrbjlWxapVlp7F6cxx4SX5/ZG3eZzMXH894FpiV1O9OUQ
         KrEKjxHi9udATRgXNvKlk2QW46BpKHSR5/ZTFizXhsfrsAMIFg0xigj+Z6SsLfgXpHXZ
         6WRwzbh21H4gkRPzz6mN+QTTSGVeU19IgPUSroFqnYSAPEjZI3gfZ9runKID5djHmp6m
         pkZujb/Hn/Ixiz6jJ0ZWfWnduCzYiIopNnSQHr7QDkmPvCZRov49dtXWNm3cX8nRBq4H
         oJtuGZS1RAlFTS9DwdhUfGyABGJSdIonMjTdabpAu7Va/s5G1vnFjRNF+NRALX4+2PF7
         vJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750162237; x=1750767037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03J8IjZSa7RJs746bHjxfihX5+FUeZTPfOgcNc5eBLg=;
        b=byDzSuShm6hGuk0SWn6G1raBA85TbtHX9/XtSL4j4Dr8wiPrEBytVGqk3Z/zmElD9R
         T31B031H1oS0myxk23TaR5AZb5QiAoJkdbkmsQxX9gNumBFXOtIFPQ5HZRTRET4hfmRm
         mGGMItNOa6oyBxtx/EMnLQWZo02JkXFficRBKg6qVKe2jhwyv3/2jr2PBcC/dfx33raz
         Bi7/SvIXAfKmQ5m6qkWs3biUswUsI+IEm0QQtiwHkVClbLV34rdyDoNA/9GSIuAsdmQW
         yBJ2EambpL4pVNVkOqCselaL2+l6XZCZ7ZDGoAA3km94XjLvNs7zF1fnZULhqt3eUliS
         Ntxg==
X-Forwarded-Encrypted: i=1; AJvYcCUBx7ZzSe72j8pXd8/N/zdA1O0R1/ida7YTPmmK6LjKofOWuSty7LFsgB0sv7Ms5s4Gsr964Wo1WIgbOkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrlP/KGB7qzZQieLSyeGnTo/Z8iJqKrFo+Kou3pPwANrXV4Of
	NWR1L/ND0YFVUmQobSrvMkGFZ9QhipNqdhwl390yl/lSP7aTput7XuyHQqW7ief2tIC3LyoIiis
	+zHNQSgY3RzumArjj8zgiyjXx4+chRqDa9hIBoHd64g==
X-Gm-Gg: ASbGncvHQ/y+SM1n8jtpKnm5qfUOuvC31Wr8xOAEbnr/D57/e+ZUgsgGyK7U9j9tL+5
	gPqAbKr0wnZIMy8aASFhox0A/9E+UJZijP7mizq3dArmJXsd3EuwX3ek+v9iS3XJioQAj+GY7Um
	yje4JCtxB5sccnJtZXTX3RNv3fY2I7KlIHCau3QbshHJZWZNmCUU1K5crIG+s9NYRh6gR8JMsHs
	vz3
X-Google-Smtp-Source: AGHT+IH1N0alZSpS2og/YRtrO6BJSrFoQcgwn2EAt1dnwxk6JId43IAh6DG97xNIAsNPpYTwM0BzsECiOdp6WxQ9Kck=
X-Received: by 2002:a05:620a:4156:b0:7d3:9ecb:74ee with SMTP id
 af79cd13be357-7d3c6c20910mr1798287185a.20.1750162236905; Tue, 17 Jun 2025
 05:10:36 -0700 (PDT)
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
Date: Tue, 17 Jun 2025 17:40:25 +0530
X-Gm-Features: Ac12FXxoVZqyTzWtPceVbJMbpvfCSWZtPP8iCGPF7196lDnB0gKWM5O37iKTTJw
Message-ID: <CA+G9fYtuiFHYBuRpB5MVwnZqc+WVRnnYMRHUExXAyu3_jMVurQ@mail.gmail.com>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Masami,

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

Do you mean only this single patch on top of the Linux next ?

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
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
> Fixes: 8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by using tp_vec and existing APIs")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/alternative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index ecfe7b497cad..8038951650c6 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -3107,6 +3107,6 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
>   */
>  void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
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

