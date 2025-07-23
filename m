Return-Path: <linux-kernel+bounces-743290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62225B0FCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317BC7B90EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160F26CE07;
	Wed, 23 Jul 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f2yatpqx"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C3230BCC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310017; cv=none; b=J7MwhYedKwobq6cfYhNxdNC815bCE2uLuQ5DyyLZ6C/QGSbssZm6megz3iIchtiFr0Z+ZG92edFQXUVvRMwfkZ2BcoFiPffZLfSbMxApZdq0Iy9Hq1lGzt44Eb8F7NFhM29a1KyT8IIqYgy/Cgzmn/RS4zRd5OmvSEk07lC/mVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310017; c=relaxed/simple;
	bh=yrn43/Dd88jzmaaVGTzLoak7dGeibPTUtixV/XrA3fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVgQRMbEe/3J9gUSbUVerLmC7fVZ27pFQN+dPHPMnip3dL7CvcZfUxw9KrjTKa+r2EYSGLJVU14KGVsvh0vwP0xJh9Ved2ve3QS/hei+a9PJPp6K9d2yjb4lw9xm0sDT1rFgkAuUJVY4224IQursKhZdb8+0T0f5xcxwUTDMmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f2yatpqx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso53127866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753310013; x=1753914813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3GqWWXpnYm25spaRnX4CYYgsNtz3In17QSKaRJKdgA=;
        b=f2yatpqxNgHe+QZsD3mBJRgN166F83kPNfKqXNxDWYFIbKI7Pl7XQrnQIgU0K4k+yt
         tlXqT0iPX0EAAjncm3B03VWOy0yEmRJoj3z4DhYgTjBz99U/KW0VWm553pKaflEc1YwO
         3nol6pGy2Jaoych8qhPAJ7xBOoIGaFqwBc+9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310013; x=1753914813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3GqWWXpnYm25spaRnX4CYYgsNtz3In17QSKaRJKdgA=;
        b=nfCjj0kfTem071AAnaZ6gqaeGqeGJCRHNYz6p4+KgCkfwvUbG6ZAv7PTscwgwAP9zN
         eh483KE0RnDqlQA/jSsAZxdlAs9i27QOeLEjJeZlZhf0C1mmZstWnedSne1ElHbKCZtu
         BFEEhgOcve5Hj8DXFSeZraTeVjg3tC6m2RIi8PHDrSDLIdZo0jgXZ7RSTA/LQ8LBU24c
         b3MznRW8FoWjzhVa1ztrX6LRhF7M5AkCkP3wc2qv892bRMmCGyN2WtKJ0A1tz8fs4hZJ
         e4NlDBM3i3+36YAG6gcJpWo5zeFCMzqW5maHIBIt2H5XHOGgkZ6c/NJPzzi8dtcd9n1d
         4x7g==
X-Forwarded-Encrypted: i=1; AJvYcCW6G4s2SKXTxNy7QpqCHIjgdPYa+FXzWvr6TkeRf+OLh37oPdzLYN3dl99WivRW5dDc4NnBfFgmL6tFZ0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8bBn3D5YDD4ofJB80vPCLSIbmvrJVWhb/i8Z/Sauf0Jh/ogE
	q4J30971Es0qMUl76HNAK4yvJcO8zKxNQkxJIosQLrrhZp90WgOyx76ZtCwFtdokyCEUe83k5AB
	RIydKJX4=
X-Gm-Gg: ASbGncu0oke4TE9yVwe6wYoTIxV7TXQFdk8VJTug5qUHvi+caaeuTennbpivAImr8YL
	kovjVriN+9C+XQBUSBFETwFr9RY7UvvRQ2u1XQ9ZQyh8w4yoPViaMjLyr76ELGnS+12IdVf35G9
	m9k+2aTv4bQ0o+o9BQkQO4r0ZU6FQw3wlIk5lk7FqUiYn85+S4ZipkHT18gCaPxxOxHJDGzcukN
	s5q0IHDpaYG3wLaCiYDmuwbyGG8xUJ7n9bWu0BAMr80V4xU/ZJoaljgmmSlA5vyZhcEkq7h0NCt
	5Vewq3JZfed1015iZYEHo7lWdiotRcgFzT7X4orUsEG7WkMrqK6K9/ZxspnueewDshZfOS6W4cl
	R/3Sqz/eQBySjinXBcQeZl6Gw495yxmUCRKao8Y1Qm8Xcr8Rq6nPXtA6Nt5hO5pAc5JIQ+lG3
X-Google-Smtp-Source: AGHT+IFLFisr7o1ZtmI5dMX8R21DO8Ot7jVWaVuBNJ2dKK/T0jG02KwXu2JSj93hXhd/07m48GmUdQ==
X-Received: by 2002:a17:907:1ca9:b0:ae0:cadc:e745 with SMTP id a640c23a62f3a-af2f8e51179mr448738966b.40.1753310013367;
        Wed, 23 Jul 2025 15:33:33 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff3f5f1sm16624766b.128.2025.07.23.15.33.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 15:33:33 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so675933a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfwLV8g1jkrbVIAHAes7qHtwv1v0OjRK3g4WVIaLn+z+EsSWGOmDGaPqfO+i1/YQD5uN2AB5zFVticey4=@vger.kernel.org
X-Received: by 2002:a05:6402:3096:b0:612:c966:4464 with SMTP id
 4fb4d7f45d1cf-6149b596940mr3270676a12.25.1753310012644; Wed, 23 Jul 2025
 15:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723194141.617125835@kernel.org> <20250723194211.768813368@kernel.org>
 <CAHk-=wgbAruRX=xFVGevggtRpHNYyMVwgNYYJgYg5hMuU6ASGQ@mail.gmail.com> <20250723182701.195a5ddf@gandalf.local.home>
In-Reply-To: <20250723182701.195a5ddf@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Jul 2025 15:33:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQA+kGVKaUqSGenXVZHaPFkuojb7MgJKVetsXZnLMFuQ@mail.gmail.com>
X-Gm-Features: Ac12FXyMftZ3rEphBYdwOs1gj8AFlxDMI37MidwdrkgzW5H2-qOMpERJA1z_XSQ
Message-ID: <CAHk-=wgQA+kGVKaUqSGenXVZHaPFkuojb7MgJKVetsXZnLMFuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] tracing: sorttable: Add a tracepoint verification
 check at build time
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Jul 2025 at 15:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> You mean to also get rid of the TRACEPOINT_VERIFY_USED config?

Both of them, I think.

> But this will require that I change how it's done, as it doesn't look like
> it's available when sorttable.c is used.
>
> Looks like it will require a separate application to search the vmlinux.o
> instead of the vmlinux (which sorttable does).
>
> I could probably take some of the sorttable.c elf parsing and move that
> into a header that would share the code.

Hmm. Why not just make sorttable then use vmlinux.o?

No need to do it twice. Can't you just work on the original object
file before re-linking?

                 Linus

