Return-Path: <linux-kernel+bounces-823684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097CB872F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DD11C87D90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20422F2910;
	Thu, 18 Sep 2025 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D3r6g0zO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349A2222B4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232484; cv=none; b=eXA9NJ/660TMQqQ7k0Cz1RjgdQhIF1eazQpOFNDdM/uM/4ogoQ8m+fNw6Dp8fiDtnZifGxUgsxov191y4aCOHUuWsvB/yvX+MOjg+eZ8P4MgrRitJUODIOUXsjaGm8rn4SJFDi1Wpg1XJ5/lKfAc71PLK2QdzHgiFt9Kfg+QIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232484; c=relaxed/simple;
	bh=OBdCMGeWv7G/tkOmZiDbcUQKLH/CnWF06gVEbnVu89c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgBHA58j2Y9vY4jKOwaNt9G3WQ1gmPNT1zvFACNjlauRzZnrPcRGt21kZeGnr/Y3UtNx34O5KiXybmTl1TX369HFQNneUmgJfU+ZSfxiANDFQEyM8/9pB/vwB3VLLhzGUhIWl67IbIM8Llt7jiLbH/26k2/lyMX2+Jh9QRdKq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D3r6g0zO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso1638723e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758232481; x=1758837281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=D3r6g0zO0172INQvfoenu5QSashNR7n7NEicMp1eGk6G0yXtB4hSyKqDJ09IfGhBEJ
         fC8wmYo28ywGI4sR2DfXvyIwyqeP+mFTHCidXEyAsnJiDSZeW1cD+DthE8e7C6CrN1FA
         BFQBJGXI6F5CHxk9oVZoOCc0MZ9dAkARXms9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232481; x=1758837281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=Vz8ILx2qmm6VwDurlhnmPJlbcl13wUAe4tVokoDtqGx1DXiqWdAj7+i82qoGNwv6J1
         euu7ZJreBIWlDIw+pJ9VZ7rhYHmJxQGSlkmL35hpJB7d+gTeA1nFEtuQ9mN5WuZMZb6U
         xHi1jiYi1tV2LwhkTR5NciLK54/0TV/bL+LXjqJ7l9QNsV7eZ7aK9DQZCBdGW7lGVFGZ
         1ZKYLUPBLlIp+02R4oO83ng/ri3oNKkuo39sDETMr1CPSZdnO4PKqbLjzf8Rrti4p+u4
         qbPXJaUVJH79ig5ggxCXgkwFKwEozKBwKqSftP2Eax+ji1jq0BQhiXLTZxsJFzaAYbeY
         CBcw==
X-Forwarded-Encrypted: i=1; AJvYcCWPxgvoL4OkhnVCfkCd3Js5oaI6aClbQXSgyhUFPfR0Ay+cipp+l75ROOBnFsAHQvIS0ttP5PmtvxovycU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSWX7ZoI+N+XJChCPcn8vgtPsp83GwogZUOKLY530rf0cmRJQ
	Ys1MHJ4H/XmLVQI05KTqq5K8oy7h/4HOs4RxG/uPwxTF/vuvz/4TxGj5tNtXHMNcYEpSs4P8VT0
	q+QazaP6Gbg==
X-Gm-Gg: ASbGncvgg1mBH4vHbd0si0szMgT+LLHRppVMJIqiLwTO72THnriMulo+Bcs5ubmmykq
	mgG0n6u8T1SZ02tM6CXz0Hb3O6rkceLXq+yej7JlJHSZXSCGzDIc4PbxSUVD85RWQyFGwqAUwAD
	pPXaB8YHsLowOatGM4djlDCJVvhMx+vWMPDxd6Z9UYet45FH7Bgzjrr5Ajp4IZXaEc3oM/B2j7s
	NGkIxU8kodflzT+X7ynhC/YZZ4qvPKO6g/CQf/gpeiZjoO2iQYyoJNN2bSzCGlq2SbtJ0rFe4ZP
	8gANA+dfzr3E+lkeeaZcd5TD30yl5AqMtGSjlAWiRZGlFtzj9e2OfkxAhqaEUYynZfG4DCT713/
	ZJ7nJqO/m+K2wxWmxB7HGdBNc1tjDe4GxeJt4r8fHzkfPNLPQAY+rn8rA+sWV1SpAbyOTJz82Cm
	3v5pjiSR6VZJhF6Fw=
X-Google-Smtp-Source: AGHT+IECUKdSKp9czMJLUMDNUj723vuGAgoBUcCiRTw+JiBPjyzmZ0gfsV0gtC+GJrzMxt1x/Qp8Sw==
X-Received: by 2002:a05:6512:2288:b0:579:f4b3:bc3c with SMTP id 2adb3069b0e04-579f4b3bc58mr277810e87.55.1758232480702;
        Thu, 18 Sep 2025 14:54:40 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a8fadb2dsm961021e87.90.2025.09.18.14.54.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 14:54:40 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5607a240c75so1525517e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:54:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmyyYSmjCXALhvjDQofzjQL9yIsrqtGRgg4T9RhWxt0q3QXwnKITjZtdX7uO18uFx9XiLbUG7QJt5/DOI=@vger.kernel.org
X-Received: by 2002:a17:906:dc89:b0:b0f:a22a:4c30 with SMTP id
 a640c23a62f3a-b24f5685fdemr62738866b.47.1758232077501; Thu, 18 Sep 2025
 14:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com> <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
 <aMx4-B_WAtX2aiKx@elver.google.com>
In-Reply-To: <aMx4-B_WAtX2aiKx@elver.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 14:47:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
X-Gm-Features: AS18NWBxHuMwwtU-EoNbPFA3uJ1YRJkAKqdurj12n-PWNJgH6ecKwZ8QZrX3P28
Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 14:26, Marco Elver <elver@google.com> wrote:
>
> Fair points. "Context Analysis" makes sense, but it makes the thing
> (e.g. lock) used to establish that context a little awkward to refer to
> -- see half-baked attempt at reworking the documentation below.

Yeah, I agree that some of that reads more than a bit oddly.

I wonder if we could talk about "context analysis", but then when
discussing what is *held* for a particular context, call that a
"context token" or something like that?

But I don't mind your "Context guard" notion either. I'm not loving
it, but it's not offensive to me either.

Then the language would be feel fairly straightforward,

Eg:

> +Context analysis is a way to specify permissibility of operations to depend on
> +contexts being held (or not held).

That "contexts being held" sounds odd, but talking about "context
markers", or "context tokens" would seem natural.

An alternative would be to not talk about markers / tokens / guards at
all, but simply about a context being *active*.

IOW, instead of wording it like this:

> +The set of contexts that are actually held by a given thread at a given point
> +in program execution is a run-time concept.

that talks about "being held", you could just state it in the sense of
the "set of contexts being active", and that immediately reads fairly
naturally, doesn't it?

Because a context is a *state* you are in, it's not something you hold on to.

The tokens - or whatever - would be only some internal implementation
detail of how the compiler keeps track of which state is active, not
the conceptual idea itself.

So you name states, and you have functions to mark those context
states as being entered or exited, but you don't really even have to
talk about "holding" anything.

No?

               Linus

