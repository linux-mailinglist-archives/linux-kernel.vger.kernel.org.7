Return-Path: <linux-kernel+bounces-792616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D5B3C6B4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F401CC1CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1421D00A;
	Sat, 30 Aug 2025 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Txf1Ex5O"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B421B9F6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514762; cv=none; b=aUH2gRbbsyQSljU58dlo17Q4gspjoHIzYZtMAi94TySQicxQ+W4wn8/Xgxtlnnigqg1r7o8xyUFBLZ83gsHsSZC244yCB7GWxMh31DeDtGYGv9XTVCQgwRyjgF6XNiXYEW0Esw6rOBy3dRSAaHv2zXS9Nl0DcINZHsxIHOJIZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514762; c=relaxed/simple;
	bh=8mek4otXRSBa5jdsIR7RcX9metPdhjWZ8Su46YZiXvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a84zBpMZ46Z9KHBcnNUzd0ps3cc0KT9dN2X3+xALEYfvtZ7q6nCz4F+0RyII60xEqzTUMp3oaA5w7bHHhfkl1kpXwr/TpNhtZsOjNmen4jyIvqU71FDQryN2UEkSW306Nj2vFcHVid8ssObY3zg7M3naXtLPLS1Vp70f0soxSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Txf1Ex5O; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb72d51dcso391686966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756514758; x=1757119558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh/LOKtbCFYx6ow3+8rmdtjbSkdbgBd5ekJbYw0X8HI=;
        b=Txf1Ex5OqOMoI8bwEDH3Xp9BhWB0VOpxPjuSa58WubqkA4ACuIt9A2z5IKbIJ2wp/B
         ts7H/8PvjyA8k0XBfk7XR8y93mVh/q2KySvSdwvZ6AwWpq/wb9gfA2Eh5of3jXBevsql
         gNUbiY3iE2kmS7hAKpKA8qWzgGhCZMKWxM6Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756514758; x=1757119558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh/LOKtbCFYx6ow3+8rmdtjbSkdbgBd5ekJbYw0X8HI=;
        b=OgUs/FpiJsQuzE2eAzTcbN1cQmtUEhVInXGuCPO/tVhCvuJyt3xRl6b3uY0w9e6uVl
         t0/zixxtBqr+lZ9x0wJO1IIR3oNbo+KEKqgeBLWDh8vnMInr8Ok9BpelvokCPafZ5er7
         gsSxgbL5GzTU4q7GHnCyZSo4poKrzxgQPKuMM3I3EaKwQkUNFtErWtRP76nSxLNBBMvX
         yXCP37J6ngflyh88QVn19RyIBuJDWvgmJzdYJY8S0i8KxvIaVTUxq22/LER3eIqixVL/
         jou/OhPiZ3nsC67+6O2H/T+TJrbS5NToC2ueP4PPnQNW9jlgDp62+R3GoNNP09r77f1f
         IKWw==
X-Forwarded-Encrypted: i=1; AJvYcCVO9+FWxr5QYHETQ7aZnlrbXiQ4LXF0gqsWrbnMAdUQTm0vQHAXuV3o0NsKkWClBiKFIXqM1tnNMahjAP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Wh0w0/6F6OGRZ86Q9UNFzSBeMCEjvCelBzAlhLUH/yBtr4gG
	JtOiuDz7QNqo0f+YEKr71g9gQ2xYTBEXkMKwDhUYT39+uFp+O/Mui7k8EiOBuQojW7XO+qBZjqY
	zyIdeijlr8w==
X-Gm-Gg: ASbGnct3/4BnrDQzH3GvvXMFHsQkAoTN9ZiyP3o+/s3XdJmA07t2nWmDFJ/hko2D1KK
	3O4xcoaODG2XAa/thxOef77gejf3XtyJVXQYzjGqHvX4yyJly8Lm05D/4I1yAHSWibd/OyiTGjN
	FwomOQVkAHz+3375NdDZeYBNyG96ytJbZeb0BvdSo85oa0Muz2cVxbPCp5IgkL1HurrmuZCp2Dy
	saf5dGhd4mqACaWZADjzfxhroiAzPaVDLoq8tYFYzllhZpnJi+zsOI088yDi0nEZpvENgWoKdSf
	t9iMoLUF2lELTp8aMg5dhOyGZ9QTO58MAR7jkfyxYfYVgj3LZf4i+OTyjNS519xpjTKD4e5oEEt
	u8ZjHvOHq2pj8Gjb3KtAqC/JNzkwD1M6ubToKmkCCmb/Q3O2yLE9pmmFXXbjlc0e4YDXrQWwl
X-Google-Smtp-Source: AGHT+IFsJwVjhOiUmUwnS7TyPP9KrTYmEMoLJEuXbbUUbnBw/QXjUBioeqYOBHztfrBZGNq3B9EfrA==
X-Received: by 2002:a17:907:9301:b0:afe:b878:a164 with SMTP id a640c23a62f3a-b01d9772bd0mr45375366b.50.1756514758371;
        Fri, 29 Aug 2025 17:45:58 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm95837166b.103.2025.08.29.17.45.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 17:45:56 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-affc2eb83c5so80910066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUW44yhjxEeRF1LP2y3yIeIeBU6rmDM+8jG410I8sP8BWx6aCVkXf3Wx7G5UVHTBpcV+e1NZ8Y6PCEF9T4=@vger.kernel.org
X-Received: by 2002:a17:907:7289:b0:ade:c108:c5bf with SMTP id
 a640c23a62f3a-b01d976d963mr49768666b.43.1756514756264; Fri, 29 Aug 2025
 17:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828164819.51e300ec@batman.local.home>
 <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home>
In-Reply-To: <20250829190935.7e014820@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 17:45:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
X-Gm-Features: Ac12FXzHUWBAlxqQk5ohlyV44LW67utXZUBljhzh_p3civTAmgJnlakeCHnJEkU
Message-ID: <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 16:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Perf does do things differently, as I believe it processes the events as it
> reads from the kernel (Arnaldo correct me if I'm wrong).
>
> For the tracefs code, the raw data gets saved directly into a file, and the
> processing happens after the fact. If a tool is recording, it still needs a
> way to know what those hash values mean, after the tracing is complete.

But the data IS ALL THERE.

Really. That's the point.

It's there in the same file, it just needs those mmap events that
whoever pasrses it - whether it be perf, or somebody reading some
tracefs code - sees the mmap data, sees the cookies (hash values) that
implies, and then matches those cookies with the subsequent trace
entry cookies.

But what it does *NOT* need is munmap() events.

What it does *NOT* need is translating each hash value for each entry
by the kernel, when whoever treads the file can just remember and
re-create it in user space.

I'm done arguing. You're not listening, so I'll just let you know that
I'm not pulling garbage. I've had enough garbage in tracefs, I'm still
smarting from having to fix up the horrendous VFS interfaces, I'm not
going to pull anything that messes up this too.

        Linus

