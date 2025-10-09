Return-Path: <linux-kernel+bounces-847544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EBEBCB265
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 294874E2EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9726A0BD;
	Thu,  9 Oct 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UkFdvKTb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1072625
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050538; cv=none; b=cuv0fW+x/DeksOZM4Vmx0FyqsGLiv48OmJpkRxNDRZbSUiJDokIp7uk8tCrpw/vTUojxeyu75/DoirZRvhsR95BFwdbCKjUGoDLJDw88uXS6CvuQ9EU+v7MQVdRQ+2TYUE/0jHQf9vZEvtAYE/8vdYBsbQrTipdh8bcqGjrVHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050538; c=relaxed/simple;
	bh=8J0pX+fiutoFsEtFpZ6q1T86lKWR+w922tpCE/x9C2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VePNxThOGuGqyQ1gJzoanPG76RiwNs7HuvdWF5ZbLBFMH5/NGG1qQJE5mk31iciOSLMadm4pRyrxqOJPNE7+JOcCpkDNcvT8U//6kcryoSPS1VrwhzWGAhFJBdnQ4sSdul45MzTM7idevZY9exc+4umbiYpGEgof1Pfmh7TYxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UkFdvKTb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3ee18913c0so230861566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760050534; x=1760655334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NviypFPu8KlI/k2FhZQ8437BpAEk675tbCoP2h8ti20=;
        b=UkFdvKTbbTyRsya5sZOiGVB61XnYBDUpHH25BLaeycYHdBlHGvFZVQLw5VyP7M7VPN
         YZar2lILwkA9mWu4ZtBvBmNmGsz0ywyL9VH+Z7s6UePeOo3uLm1v6vLK7aslKZd1Nbyq
         2p+8pPH9jCzo9to5OGKbNjdUnwG7gOtGhksnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050534; x=1760655334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NviypFPu8KlI/k2FhZQ8437BpAEk675tbCoP2h8ti20=;
        b=mlQK3Oax+XZmXpsAHE2IC7BnGBzYuwFXyXu9S12xomXRbxdYLfj6xbKS/WlTXBp7iV
         xngEPKDBAPqNQe8z7MK22DDo1pLyqsNY7taQUflbOFJUOqDs7s86/7ET65J+bsdfB4bb
         8QAWumNtdy67f7Vf5+0aT9Fi/LvpHkFgdAKFWuJDEKaquv84RvGg9rlAFs5+9oTruF9P
         IS3sZ4xH9CPHJjTr4uvdnT66Iq37CpqiadsiU/hc6lzqfX7YEtKBLBzeoLeLr1sKpySe
         Ubkv6eN9XAS3joqYHAET2DO/f+QHjjR14G8xl7PJ/3oDVdIvpPZeocp+OsQ4TzNCU6Ww
         mRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWZ8WxD7eHQRre+b5FKNkW4VsD5XUKOmxtfuV73O0wJ7mPbKe4UsjZjAKcWmJrOO1bTGunLeHQ3UTLVic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RoEfn0DrwqEyIxjJS9wiEyrVgdqohMtduWZuhxdygZUorR+i
	rTSHHxIpqjR7HZPUxG6kvm2LXp4vpcVxirmcke3bgXMpgKOZnuyv8ABS0RdCkKuPE7tu/7G4IXp
	e9bWbUiI=
X-Gm-Gg: ASbGnctmAFrdl7cuBXDI4sel6vU6WHSWr8ASz2Kqtikg0ECwlexx01z69rQWaxG+6Im
	Kvg6C0H+VlCPxfeP75hsg4FKrMA8FQ8UocQPUD+wNN/XuPizXX2EPpikeKOmW/ApIcb6FgGWDzz
	x9RBqFiYSC0Q+UvrB9xBhdyP1V9mAg9DMPcF/f9o++QebJbpV5WxGuOBr7/wRntKGLMEOZBB5+s
	g0DgENUVOE/MNJYj1LP6XXzJ79O+cfLaDN+AybRGn+N9htevI6fXLIEGV0WzvUadVe+NENgTepx
	USKWWU/xPybMQG0LpxP2XIT0LcIIINiOUsIxOgicZDmrMhQ51KjeSON7Ex3Q1AKCYaZx5F+HJuP
	CQ9FGnih4BxcLxHRcleYSwL43W+4zd5v9htM9biO5nkHVrd1ZrwqJefKv5t7B1nXCHuH3Ya1Zke
	fqE2WYEpcAc74rABqNEfsM
X-Google-Smtp-Source: AGHT+IHm1XtnK1xKGv2yMm9VnPxESiFb3ZtezLnWPgpAh4aZlHjbpzne732JdA4t5LeQBnJ+uDFC3w==
X-Received: by 2002:a17:907:1c28:b0:b3e:580a:1842 with SMTP id a640c23a62f3a-b50abfcaff6mr1161053566b.48.1760050534173;
        Thu, 09 Oct 2025 15:55:34 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cada66sm78613166b.18.2025.10.09.15.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 15:55:33 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso2163869a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:55:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURht45uFI62oj9rDFLHkoKsTwkMxwG11hAkL4/72HuOBejtd6+lwhtGp6KsuPT4cW7RIn83nF8YyS0XAo=@vger.kernel.org
X-Received: by 2002:a17:907:3da6:b0:b4e:fc90:47a8 with SMTP id
 a640c23a62f3a-b50a9a6cd02mr1009825266b.4.1760050532531; Thu, 09 Oct 2025
 15:55:32 -0700 (PDT)
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
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com> <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 15:55:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
X-Gm-Features: AS18NWD2-yWVkA4c4866Vu6Ar7MZvv2rpvIgM-HfQqlpASifXTx8gF0NYStUBZc
Message-ID: <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and scoped_seqlock_read_irqsave()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 15:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Sure; otoh compiler should be able to tell the same using liveness
> analysis I suppose, but perhaps they're not *that* clever.

They are that clever, but only if they end up unrolling the loop
statically. If the loop remains a loop, the two variables end up live
in the same code.

And while a compiler _could_ in theory still see that they aren't
actually live in the same _iteration_, I don't think any compiler
actually ends up being that clever in practice.

So making it a union then hopefully gets the compiler to basically use
that explicit information.

> So I thought they were fine; we handle all the enum cases with 'return'
> so its impossible to not exit the switch() but the silly compiler was
> complaining about possible fall-through, so clearly it was getting
> confused.

Yeah, I found the same thing with the 0/1/2 approach - the compiler
wouldn't realize that the range was limited until I added a very
explicit limit check that "shouldn't matter", but did.

This might obviously end up depending on compiler version and other
random things, but in general the whole value range analysis tends to
be a pretty fragile thing.

In practice, compilers tend to be good at doing value range analysis
if they see particular patterns (like initializing it to some value,
always incrementing it by one, and comparing against another value).

But when it's written more like a state machine like this, it's
clearly very hit and miss.

             Linus

