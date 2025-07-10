Return-Path: <linux-kernel+bounces-726547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E8B00E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8745E1CA25F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0823B617;
	Thu, 10 Jul 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gJhmgwgL"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002042206B5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185331; cv=none; b=o7aq8iIsYF7CDqwXjLub2CM3kIGfBFHCe75mG4TSAZcxMPHUTt5E7h4r4XREww9TS7CTiInDZcHIA21IXUQSuiVSja5+3eYLWlgbj+RLB5Lo1DH1OCYQfX6P8qhFVUdYzS5jt/SGqDx9J0myemIiilVx84sYMpAIkRZAec4Dzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185331; c=relaxed/simple;
	bh=2U6l5kbEP9IBFxT9l3j6WvMdQZkeDWhWgT4LU0TCP98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG5aHQpNzB9WO1LjxysqOlUdxMS3Gv+eWuzqZVdckNN2x40uDiBTPPwO0Ger/TC0bry+NzAFuej1a4a7GahTZ5bp70YNRNrJrCbdNpTdhK4QkIJdKlPCoG/6+lWJGskc1uI+X0I4ngkQqC24HjWlQ+3Nqdy3QY7QBP6V8F7sPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gJhmgwgL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so242481966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752185327; x=1752790127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ykdGKGKuBHYeQ543548mngZ+AURoPxGnuzWJOvHPANU=;
        b=gJhmgwgL/C7gthMleszZjDplyr4OXjtyBgSDzsQVHQc/LxxwUQJE6tWzeZLRRvVHqX
         XM38pflRzf02X7aoXKP7zc6gqLDvmfnGTClLJs7HXBJgSXYIaBa9ok54FUFaiWyGWw8N
         JGS4i+2I6lYQHA324wj09apsikModhGaCR0Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752185327; x=1752790127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykdGKGKuBHYeQ543548mngZ+AURoPxGnuzWJOvHPANU=;
        b=lUQ5i8Qz06mNS7XXysA+VrfKfSfaVmXhKR+qlGuKfUVpS6s1txGBHjOblwLYtIIJ1o
         KNg6F08MQJSin9qB2kw8YLLnG4kPMW51csbHN0r0UsS/iN9DLxNbWiGXTXrXNnIXBKat
         UslhjmgVTgtpwLU5My0L1LIPCKStm1VjK5Pxx706lzfVqOBJnqCGAdTJecn0HcINNxIL
         RLoxG3d0r6lT+fWJUZYe3J2TtXTVWssEtHwzxM6w/7ek8Lp/7uq12gmz6c14oPgsosK3
         x5XN/jauSt7S0j1LQuysBCRtlEyaqxJqxoMgbZLmoI1M76/lP7Be93PVBfcAA7zNSeNN
         j/WA==
X-Forwarded-Encrypted: i=1; AJvYcCXztekzO2Efr/Y+tztaZLjFBZYmhjVxvFs3iQy9Gtf903oS+aM7VQDqYDZIYTxgqSDDzxfJ+mVv4o/wVoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpL1pocFLoxV6equXLu33H08O0WXHBRc73Gr+q/REH+SuTvV9e
	qktNAgTi+VLuTsZLb+qyLU4CgEiHoR5ng+OBIkCDwc6LxVL0BQ901zht7NKu56ASWXGXfmRCMiw
	UELHag/QP6Q==
X-Gm-Gg: ASbGncuxMAoAVuxC0jVr6npGVmvnehvbHXU8EAlR0QcQAfqeh5WkTZnJwx31RnBljFr
	XwkPrKdP/K6UvzUW8V6ksUIE86ocn37AeoUxvLtTuXrhu4uVVd94sqCV1jmAayMzxxlSV4iKf4u
	vCY2DtpZP7Os/Mk4Qmbzt8EE0VUNcTnGnSlJBStD/0Jn/657bGC61lFq2ttGLGf9M5hF1+cluRb
	zKSI6qvGRC6V+Y/Fn2wB18IWF/DwrEQTaqjuNjet2W1Cxha/tazc2Z6zMgokiq3vyrx6H4IhRg8
	4bUzOjp8hrwgUPjXaf8CSJOd71C67Rq8xLPzjbzDFPGZBw0M6QUklqC+ruEknzSLw5uCQ6lT7zi
	73H6DwzUJW6AyvL2K5ncAzAx2y87SVjYjVd0ZEqr53AVoqS+Q8dprNqvZi8oQDmwC7/MYacTB
X-Google-Smtp-Source: AGHT+IEeY0EZVnUj3TjNo4fe1HwQLUjZa8KuYEXAb8ArI5SGea0p8+x2zQWFsCK/q0ndHyAl+UAOBg==
X-Received: by 2002:a17:907:d7cb:b0:ae0:d7c7:97ee with SMTP id a640c23a62f3a-ae6fc0af170mr90910666b.41.1752185327100;
        Thu, 10 Jul 2025 15:08:47 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91a1bsm194930766b.29.2025.07.10.15.08.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 15:08:46 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so2382777a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHOmlvrXnnnnch6kNDhBnsvEPQX/mS2geWzv5jHwn5Br7m2fNaey16DuELhSC27wmf1xWZU1VLH8guBgs=@vger.kernel.org
X-Received: by 2002:a50:cd57:0:b0:607:77ed:19da with SMTP id
 4fb4d7f45d1cf-611e7611808mr397182a12.1.1752185326316; Thu, 10 Jul 2025
 15:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
 <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
 <svune35mcrnaiuoz4xtzegnghojmphxulpb2jdgczy3tcqaijb@dskdebhbhtrq> <yxa4mb4tq4uamjc5atvhfefvxyu6fl6e6peuozd5j5cemaqd2t@pfwybj4oyscs>
In-Reply-To: <yxa4mb4tq4uamjc5atvhfefvxyu6fl6e6peuozd5j5cemaqd2t@pfwybj4oyscs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jul 2025 15:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOSRbTqEO8H=5bBem4Su3E=bZRLM3nE5rwLHSofhD0Lw@mail.gmail.com>
X-Gm-Features: Ac12FXzpHETNg-HuLSmnK9b1Tp10RJ2FzmkvjWu0i-rRbR44n9d-UbbJBC2bj-w
Message-ID: <CAHk-=wiOSRbTqEO8H=5bBem4Su3E=bZRLM3nE5rwLHSofhD0Lw@mail.gmail.com>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 14:21, Alejandro Colomar <alx@kernel.org> wrote:
>
> So, I prefer my implementation because it returns NULL on truncation.

As I pointed out, your implementation is WRONG.

If you want to return an error on truncation, do it right.  Not by
returning NULL, but by actually returning an error.

For example, in the kernel, we finally fixed 'strcpy()'. After about a
million different versions of 'copy a string' where every single
version was complete garbage, we ended up with 'strscpy()'. Yeah, the
name isn't lovely, but the *use* of it is:

 - it returns the length of the result for people who want it - which
is by far the most common thing people want

 - it returns an actual honest-to-goodness error code if something
overflowed, instead of the absoilutely horrible "source length" of the
string that strlcpy() does and which is fundamentally broken (because
it requires that you walk *past* the end of the source,
Christ-on-a-stick what a broken interface)

 - it can take an array as an argument (without the need for another
name - see my earlier argument about not making up new names by just
having generics)

Now, it has nasty naming (exactly the kind of 'add random character'
naming that I was arguing against), and that comes from so many
different broken versions until we hit on something that works.

strncpy is horrible garbage. strlcpy is even worse. strscpy actually
works and so far hasn't caused issues (there's a 'pad' version for the
very rare situation where you want 'strncpy-like' padding, but it
still guarantees NUL-termination, and still has a good return value).

Let's agree to *not* make horrible garbage when making up new versions
of sprintf.

             Linus

