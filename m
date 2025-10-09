Return-Path: <linux-kernel+bounces-847424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC428BCACC9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952A54EA308
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD026F2BC;
	Thu,  9 Oct 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ew6LoB3y"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0C26F292
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041514; cv=none; b=Rgx68IEGF+rtyKEjUXbifA03s5MZzhbrbV1kvqnbCsA8qR5pz44P0DBL9trSSkw6aVETDmBVJHk8Gb2q7e7hG8tmxoRJQ+os7nfx11Vi2kbbZfvPxW8asv9hYZ67ZOWB58qJ64PIrRDIo/YT83KiqC/DK/vz1JmzoFsOfmh0LDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041514; c=relaxed/simple;
	bh=1yDg4kaYpHyfB8kgSxUzXZV/Gejz9FwLQbXpvXDSXmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTSQAwuA3XEXG/IZXWWbRDdlHYyhf7Z2+xu9piSJHk+ndGG4KH3XLI7WJGuf5RjCbw+4Z0TKBIqGI3kiqNagngfGicBzyEmX/5uSD4+714nq29dr2VnTP0VWru8me5ypH8TioURQt1G0s1v1n7Fh8hcrybcIRBtt3nCuITQj+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ew6LoB3y; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63994113841so2225122a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760041510; x=1760646310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GygpU2gHdBu+smba8fE9xPKFyfcrRBB7u113k/F8qow=;
        b=Ew6LoB3yeXmrOWVd96rDVHORyVCwf+HQPobDEzujkGZzMau1v90v9sjiV3hlrVQZxx
         IdRbRg0cADXGeom995rvqPHhTH+NoGIQV5jMQNBtUJnf5x0TzJGk650uXpYTvenP6viN
         KCBr7vIsCkZ21KFO6zluVUBByaSPhIQ7LNCmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760041510; x=1760646310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GygpU2gHdBu+smba8fE9xPKFyfcrRBB7u113k/F8qow=;
        b=DO3jlnWjyJjuLAMAMRe4GfOboEvNm4H4uDdx1MmKsBxgPe4qOPB6LsvX1aCKIF7btg
         kydvb4KBSe46Pxll+J59a+MaPdrLIR778mIbiBhWsYAiE7YPApCZO+GSea05Z5ZbefEq
         IVmEFq5Cv8hybbpH52fdibTGF29Pp3CtC7B7IWIbzBUPWKQ6PbyZ3SqKXEBod78FNcxG
         GjbuCPEmR7N4ZY2Zqm778PkthgB7urPrM8xCDYqyFTEWWBEXXtvA+4/tt+rrYk2A9l37
         Ecl4U+3AW9Ql+XKjKyO90ssj6aRfeiBPpT77hkexvIQWtnwB8Swk/wondMfb5SXkKM9M
         IUkg==
X-Forwarded-Encrypted: i=1; AJvYcCUm/nd5i9vInBPIneUJWvNt9T3KkPxRli7nPn5bxWhHHQZT5eIJ/P5CoWz6QlC6d4Tz5W32Ey0lOacbhFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnn2RZdBjWBjspQ9z4m/jwn9f0oq36cN7xVZgflqWJ1CvlTV/9
	EXlVhtltLNhTkg5Yu32pN94BS+yeORNuZ5M+JGdQSNikiWX2tsftWSjsfav/gu7iklmVHaOrsgk
	fQvE0ces=
X-Gm-Gg: ASbGnctSz9U2WKdinZjJMCY357qiz96eCXu+13Q+zRHRBj/5xiP7MDwFIORVAmfzUlJ
	QjM96jJs8itTYTJvfLPPfrN0RSp49y6eNNi8KJ4EjnkuD+6bC8wT7BiasfaVrRzqmRZVQXOENos
	KnhvM1Muu60+2Aaj0f2WF57zatb/Zvaqd9iFoDW9AG35x+qWOxe8WWCCGsTpVX4d0Zzj8TdEc7N
	00nE3p6LINqXGu+wiyBaUj2SmlVBCmXi2RHC/JAD5A5FqiRGeY0mVvO4q5vmaLScPmvv7Afq0L7
	/tVU+ktTrXuj9x3HVtyiZeOSj+OiJ5wuKHbEmCqraXE+7587FjAj04wvBL6awA0zpezO/H4QwxQ
	kOkDJzjVHDRpFoHLHHwOouoLP+21tHyNAwcBDVgo/c6qHFmztMKGWlKiUk/sIjtkieinxuQM5mG
	daxQiF2EsQpObJKjUDQKI9RNk0hyNH/7A=
X-Google-Smtp-Source: AGHT+IENKnWCYxym28kCX3SeVMvNzqxRgV95gSLZcB5CH9YFLwxbb1DoqN3513JBonFZMuv6oQYeyw==
X-Received: by 2002:a17:907:3e22:b0:b3e:b226:5bad with SMTP id a640c23a62f3a-b50a9a6d8a3mr1019000566b.8.1760041509634;
        Thu, 09 Oct 2025 13:25:09 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8adsm53261166b.7.2025.10.09.13.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 13:25:08 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso2018829a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:25:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWw/s/zCofbZfobWf38+YTMYEylRC1Z9YPWpylrUoyjIqs1+25/8LLvFHTpppp5CHE44AOh5vLkZf3dl/E=@vger.kernel.org
X-Received: by 2002:a05:6402:2707:b0:638:df2f:b8fb with SMTP id
 4fb4d7f45d1cf-639d5c2dbaemr8258952a12.19.1760041507789; Thu, 09 Oct 2025
 13:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008123014.GA20413@redhat.com> <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com> <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
In-Reply-To: <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 13:24:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
X-Gm-Features: AS18NWAWWI4oocfrbAQnW4PqJLbKisZR6Gr825Cs6DKHYWbEPIcdIkl-1uqFz0Y
Message-ID: <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 13:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Slightly nicer version that's actually compiled :-)

I assume that "target of ss_lockless" is an intentional extension to
just make the loop never take a lock at all?

I do like it, but I think you'll find that having a separate 'seq' and
'flags' like this:

> +struct ss_tmp {
> +       enum ss_state   state;
> +       int             seq;
> +       unsigned long   flags;
> +       spinlock_t      *lock;
> +};

makes it unnecessarily waste a register.

You never need both seq and flags at the same time, since if you take
the spinlock the sequence number is pointless.

So please make that a union, and I think it will help avoid wasting a
register in the loop.

Other than that I like it. Except that "BUG()" really bugs me. It will
generate horrendous code for no reason and we *really* shouldn't add
BUG statements anyway.

Either that inline function is fine, or it isn't. Don't make it
generate stupid code for "I'm not fine" that will also be a huge pain
to debug because if that code is buggy it will presumably trigger in
context where the machine will be dead, dead, dead.

             Linus

