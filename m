Return-Path: <linux-kernel+bounces-874082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BDDC15793
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6590423892
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F633F8B1;
	Tue, 28 Oct 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai73c205"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985218991E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665369; cv=none; b=FgE4MbHZYOYJeSC+D/yHNWoX1Ssu2AV0CXF38ANo9nu53ma2GR4L7CK/PANQnVYfm9HJ2bGClISU5xNfKK2CVcyNE1I1KoeHKedWXMA0iqtNpoc3jW10VCwM9qTmETdAB4I2yd92P2y00HE2LwiszYNWDDhSAtx6V//a+JaIPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665369; c=relaxed/simple;
	bh=nNT2aPH4pU1awg69EcKL59cHGn20iFQORIESFfdyeo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meyOt43SyCAWd1WnE5GPiCHI5jaosEGw5nKbmQeqJcQAezx2Wq3uuZ9XZT/fJ9Pc2nPKo/KXCA5tJu0Wr/txM3qPpDE0VqxzLy/grjpuZYlOc3R/RY5lM9L2Ce/sEm3/qLEuW2prkAUP7k4oxVXg225VfYRO8BcBjszviUXJQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai73c205; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b62e55af64aso244318a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761665367; x=1762270167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRzWyIqQEcf/ZJBQA3s+G3tjXpp8X6ENyc3hg9mUVd0=;
        b=Ai73c205dNJNvfCmoKJqpIEhIgP0KQgAhaKmSQ6DmldTtgg1iz6KUKiK/k02rCiPoN
         UcjYBoxpADg+WeXYqQ1kMCkHdIbpJrfUqRYOt/dTyJCImxHjuedcV9y3ois3ZIMmItaI
         a9eApK1aF9mHdPnuM/Ana97W5+619GdCLyO4gq5noClE5VrOGq5+z3BocZFdN/wxm2a/
         k9jUUoLI4ZhqoQ+g0RCVFhYIOK8goCyOCKjWd8btDpwzlayfciLa6/+iiWMBk1vnJj+t
         pyGTVi57sMz+dTISFjg3jw+X/Xt1gH1QgWFMOiEauwzSr5uCxY+yrFbxtyg0NWYxX2Ri
         ZHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665367; x=1762270167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRzWyIqQEcf/ZJBQA3s+G3tjXpp8X6ENyc3hg9mUVd0=;
        b=rjekPS21cg35eBkXVfaUS6C14mnTLCVGvECze3Jf+z+lK7FiJBtq59UGW43utnBL4a
         vqBagd1zU4g+BUbCMzTj2nbDYQIbh3wZ3oQDRf4rdCHdrF9/hRL/AT5lU6dJkk2p1p3t
         S5bHCUih/6KK2aJFsrXy5rPevfTLJ52iRbS2jJZFdWyis6OiL5YuYsZfilyBV7qAo/tY
         1Z7XpjY5FyZmJ/pG/hniWvNViL1ZhPLOAu4JkZLzb5yKnuy37DJk/fKc7GX+oXGZ5HUc
         zt8JOHl47u7iy2KEeE4pzQ1NfVtB/3XBV6vPCwykwVMz7hqpv+MrDRmBMk2Xerw2B4Tu
         L5Mg==
X-Gm-Message-State: AOJu0YwrlWF6vy6cz8bYBhlDfSH2T9FHsTZ4q9EAiWJJhMaR/Q8pGG/2
	SumK1Au91W8aRll0/zkdtmwCCiDVYSe68umz/HlGHZv8CZb2K/v7VAP1Nq4cNKW/hmftpmeTRUJ
	6MezIm+GtKrc7ppcNE58XjoxttUMf7xGNkZ+j
X-Gm-Gg: ASbGncs28ledkxCMGKpi2Dq7eauI0W53nvRP5rKD5OeqAjH815HiHMOnmESWKahG+/L
	q/UdyB5YFucj70sZjcH6MzP7xZOl+RHN5U2KwaeLkSKAnoxYdbZfkFD2evZ5W8IEVq4B9HVZTaB
	GTcaTqz8RokRlnfLrBWJJ1OP0aWnoBTcll0PqvSVnZmNIDmTBTYL695QptBIp2v1/kxG0kxaZbh
	ksvaT86pm8OMS5jCd23m9K+zZOCY1lUbM+ElDunUYJ+ZuzeTRHip2RmWUOuvxVhaR8ND2O735Pt
	D3K+CPd9hBkfzNKsRqGu6L9GG8Oq4lUNEVhimhTmDi9YTgBVm/KqVtzXPxnDm+a+NVRBX2wwm7m
	Nfx4gRMluxHz9TA==
X-Google-Smtp-Source: AGHT+IEt2QWSiwc1fzvapL/YFipPkowqSgA91n8w6WIGAEj0+tbOdL4w857IZTcBs08XlqChrmu6plQ01ps3q8KEsqY=
X-Received: by 2002:a17:903:37c5:b0:25c:9c28:b425 with SMTP id
 d9443c01a7336-294cb523db2mr25447145ad.11.1761665367378; Tue, 28 Oct 2025
 08:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027201204.352890-1-dave.hansen@linux.intel.com>
In-Reply-To: <20251027201204.352890-1-dave.hansen@linux.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 16:29:14 +0100
X-Gm-Features: AWmQ_bnSh5NBAupbDNmWUWjhYUw4CT3QMwRqBP2qFMQPrSjrN72Y8_1eqwDUTw0
Message-ID: <CANiq72k7LQwXFnZgh8fCLNnx=v17Yb7yVcPQT_cdPi5k=17jbA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Provide guidelines for kernel development tools
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Dan Williams <dan.j.williams@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Some more nits and suggestions below...

On Mon, Oct 27, 2025 at 9:13=E2=80=AFPM Dave Hansen <dave.hansen@linux.inte=
l.com> wrote:
>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

No big deal either way, but for the commit you could use ojeda@kernel.org

> + - Spelling and grammar fix ups, like rephrasing to imperative voice

Some bullet points have periods at the end, others don't.

> + - Reformatting, like running scripts/Lindent.

You could perhaps add

    Lindent, ``clang-format`` or ``rustfmt``

or similar (the Rust one is particularly relevant because we enforce
that one treewide unlike the C one).

> + - =E2=80=9Ccheckpatch.pl --fix=E2=80=9D output, or any tool suggested f=
ix.

We should use a code span for this one.

Also, should it be "tool-suggested", i.e. with a hyphen? (not a native spea=
ker)

> + - coccinelle scripts

Coccinelle

> + - ChatGPT generated a new function in your patch to sort list entries.
> + - A .c file in the patch was originally generated by Gemini but cleaned
> +   up by hand.

Like Jon, it also crossed my mind using just LLM here or perhaps
mentioning "open" models. On the other hand, it is clear commercial
models are getting used already, e.g. Gemini is in the commit log
already and Claude is in the mailing list.

I hope that helps -- thanks for sending this!

Cheers,
Miguel

