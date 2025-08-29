Return-Path: <linux-kernel+bounces-792256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45096B3C1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F5AA6646E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620DD32039E;
	Fri, 29 Aug 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EYFPPjAv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC1343D70
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488841; cv=none; b=EDLL2c59MJY1wF0tibuQi0c7hK8ZperzsaevdNglchjUxZtM35ftaJghEZPw+umyAOWkwPCovwX4TyifeunOlBnmf5B89DrHfTiQGLA9sL0xmCaQfA3lLfT9+PUwndQMbHuLcj/69NHlWxSShQsVa7sP9uzoCNQ1N4av8qKgbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488841; c=relaxed/simple;
	bh=0Iwk8kojSYVfnDLAmzrwi9KHqF0f7PplXnNwNjdrHA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYmpEPvOKhO7EjXVbsBp5PHZvC47+dsnrOj8S8E0uVviBvzo44s1dk3iSVIt34clqXKWAqSCIt0ScK2dBxSU9Mpppg9H8DYnqITIe+r2Ebk+napYjHN7Eq24S56SXfx6Nz3SNe+ERWIuT7RQAW4/gixbPVPCl6E0rMTJFk37HSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EYFPPjAv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61ce4c32a36so3312849a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756488838; x=1757093638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JzHs6USaZca2JuAKnnFeoU743SczkPKj5+4UqlxGdQ=;
        b=EYFPPjAv8HPt6SOLB83d88n2ATVYt6h1hA+eZ/4c0lKj/90V8GPjl3gyrkUbAt0g6J
         H5QYjTSEbSW5kePswh+TJqZw2DpWHEpr5Qdq/QizV+QeWYVj3d46ilBLXnvAVrLnk/aw
         8NEPsAbx3MQ+OkyTvteWHw3h17IlzfczD+Krk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756488838; x=1757093638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JzHs6USaZca2JuAKnnFeoU743SczkPKj5+4UqlxGdQ=;
        b=d21mPZxj2W6WgsrtwMeJBKcjH2NaUgGgk8rBHj6KtkCrov4KZ32hIPrQA5Rp4i6iUR
         t9P7D0tHrONCe4d73naYQDIkyZHcMOdiCrLIiAi7TF4zE3Zp+rsjVRxAjGcJCZH+tZuH
         /X5HVE3v26mVblLT3WPZyj+ymtLlPqDvwWydb5UYNEZidIskgjxebfReem0KcvM8Un8m
         w1dRy/Y9JZYX+nT3LUB2K3jn/Qv1/FyHZKy+YkoPDyWWsyTOc+ZIacWXD12M8q1cfGpn
         5E7RBJDr+sL+73SLUlmgSmOdw7oHrxGGGXnUIyFEuIb7ZUzVyKmZVAMdPXfSBGjCnoBg
         AtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb+Ak/eMYL8uRrCGcF0+aQRQE9BH1Ma+GxQYl4Io0nX+e4fCc3r8yuLIgqhU1f5WtmBKhRGHfKSyAooMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylBWWZbrjwFvRuH9VhQmnunRP4AqzJxTion3/bzposwMEISBC
	JRYgHrPaRvnPUXYoLiad2s575c3Eh0HUmlRy40Ps3tdIX2ou1jSsTzYm96bNIX2x6s480Pgee+A
	H2DQhJC/8TQ==
X-Gm-Gg: ASbGncsHE9hjWKcayRbXG0QYIc8baMEma4X/pCB1/yGtiUFyXLfAjOrX8MvyXNl83Hz
	vD6GLuL/s+v5TCb6ITj1B8Fz6hnkfxDk25bCNOyhu14Syqf3sdMD08WXfd45Y7vU8mpkZDxiRAN
	0+fscm+OYDM5hZIFVh1bGLjWxMmTqMLz3QOPKzKKWgmaby+7Z4hOr1TPWVWo2eeELF3CLyrDu75
	+pHDXcZfr/OC7ABeR7mYTJJat0WvE5TTYf5LXA2spTbGspOFiJdXxh82J4i6ckxjQgobmoYrA2S
	Fkw2EiHSEjs5HNY4Gld/B4sL4tCpntCxJ2SjpKfhXxSe0t4aT7sRo7fNXdDVxhs7lAVyEVQKU6a
	U9Tuez3TbaSLuwoWgpB5Pgnp9+KpEjCEd0E1CksXIWd/lsv+4WthNqLZwaYRQXN++t5abFaygDn
	vhcpzK91Y=
X-Google-Smtp-Source: AGHT+IFfrgcfhe/CVFNOi1TWq9WazO77sN1Wi2q3lynLWEjtAThYGa5mPKZC4Rs6moUsy2Z52+A35Q==
X-Received: by 2002:a05:6402:358a:b0:61c:6ca1:1a89 with SMTP id 4fb4d7f45d1cf-61c6ca1245emr14635212a12.5.1756488837711;
        Fri, 29 Aug 2025 10:33:57 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7dfesm2092945a12.7.2025.08.29.10.33.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:33:56 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae31caso442699066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSKhPTudAndBe/93RUFNf4FIuMlikvMnTQXl270hZ+CGAwmTDw7YJ0oQhxVFCCsK1tCh+BhVj5zcsOO94=@vger.kernel.org
X-Received: by 2002:a17:907:7286:b0:afe:d24f:fd70 with SMTP id
 a640c23a62f3a-afed2500115mr854960366b.43.1756488835450; Fri, 29 Aug 2025
 10:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
In-Reply-To: <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:33:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
X-Gm-Features: Ac12FXy9v9IJY2LXrpDvJU9dj4Mt87wFmaIDhMj9zyTfDwA5B4n7cidgQycVydY
Message-ID: <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
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

On Fri, 29 Aug 2025 at 10:18, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> As long as we don't lose those mmap events due to memory pressure/lost
> events and we have timestamps to order it all before lookups, yeah
> should work.

The main reason to lose mmap events that I can see is that you start
tracing in the middle of running something (for example, tracing
systemd or some other "started at boot" thing).

Then you'd not have any record of an actual mmap at all because it
happened before you started tracing, even if there is no memory
pressure or other thing going on.

That is not necessarily a show-stopper: you could have some fairly
simple count for "how many times have I seen this hash", and add a
"mmap reminder" event (which would just be the exact same thing as the
regular mmap event).

You do it for the first time you see it, and every N times afterwards
(maybe by simply using a counter array that is indexed by the low bits
of the hash, and incrementing it for every hash you see, and if it was
zero modulo N you do that "mmap reminder" thing).

Yes, at that point you'd need to do that whole "generate path and
build ID", but if 'N' is a large enough number, it's pretty rare.
Maybe using a 16-bit counter would be sufficient (ie N would naturally
be 65536 when it becomes zero again).

That might be a good thing regardless just to have some guaranteed
limit of how far back in the trace you need to go to find the mmap
information for some hash. If you have long traces, maybe you don't
want to walk back billions of events.

But I wouldn't suggest doing that as a *first* implementation. I'm
just saying that it could be added if people find that it's a problem.

            Linus

