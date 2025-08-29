Return-Path: <linux-kernel+bounces-792177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38CB3C118
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB8C1CC4E18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B6334369;
	Fri, 29 Aug 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WCd8diMV"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A432C32E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485747; cv=none; b=eUxlghFEiy3NHPwo1XS/qcpIxtpcR/Yz2adjd9eBMz4/YiePgYcHzFc1JPMg9MPmUdl7u8Kt8kl4dwUTgTCQmwCU9aPWC928JsNApc2heJmbuq0R8pOhvt5cINUF4Eq8WN0/Q0neduhzY4hSnToMeDd55qER5KKHt8vgZ9wmMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485747; c=relaxed/simple;
	bh=upVsUuMpOdHRiGkETwVJlsIxvbf0n85rijqW3icJrTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZdQhdKJO/feTML7tad8yENLC/oVL/QgEMnGjEPChqZdP49VLxCWvKSTJmprtxgMzuSiaZNUJwE/WCl04Q97i7IHxeee3yEcqVPxC1+mjvMia2FgTGKIfktDAUlfdwwLZn/GN648Uh6j4YvlQxDF3d5zCH/s5vVuKyiTgfCekzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WCd8diMV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so3212935a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756485743; x=1757090543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcseL9VLwiGrQMBX6gFapN6MvL8wsPhkJRSj/QHz9Rs=;
        b=WCd8diMV3w2ZaAxEe/uUOtRXCXjC1SnFjkaOX+rGeGoHJNl4Ot/l7oAUv4FtMWnhV3
         hnrPnedq08pQBlbVXF+uslLWI/8eQcC/JWEqSzAdcuc/D5RcPlVCHrjUe7Y8YCqBZ+xB
         o9TaIjxxUIn/TAaTqPrWLQ7tcAXQB0xBb2LbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485743; x=1757090543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcseL9VLwiGrQMBX6gFapN6MvL8wsPhkJRSj/QHz9Rs=;
        b=n31Fl9NH7/BTeL/pkVuwqhiroY7W5Bchg9sH5WQwvsfXuNlC8k832W6lROOxrcjOwV
         ZilADfLKtfuTjKMpNQZO0t95BK1+PF+u8EHrI1104/iVYvvPFg7nvQfgD2JwfIetEvgh
         PoSbLjxGCALBtLyID9Xxeeao6FsjzGPXtt0sEYebdKq6CJtPuCks9LFmdQDJ39k5RoVA
         wiZWJiZbZUZrF7ujztWce+fespmAz+Y11u74xj5NjGLtSBSGV6z6MeICLK7f6nQ1Tx0N
         RlOiFnot84xJQqqxo3TJbhT6uLMZRtC/cbysoG/wHS9DAKQkfhjq64AHudQoLWCaLKOM
         63Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXW2adaT5XIMcXNdFkqK5IuhiPd2rPInEBEb7pybitnF9zPwGLilvRi+KkSbDYeU/Bt/1sHpsFNgHlKmRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdyyNbmFfPrHkivcCYoKZtPaMl+pQGUV037/68MFqs76NgfyR
	Xl79Z7SeBjDgkTlSY1sZxlJphKQOeL9Vk3MHucK5UGCDeIddUgdh/JBdhOZ+RHYPElxks+eQ4p+
	3yf7OAkL/cQ==
X-Gm-Gg: ASbGnct2J9V4mdhPplkYYjGnWseSdiIqCZ5WokEz5RfCzPTrICt4aNr5wWu0HslB9Gq
	3tO25ONVfUYhmt5QS+4GjcLU4NhBhM/cEwKZoSzCiei9ibdqkQyaUARdssxR4+r9vtACU1sU25B
	/MDBWgqr8QDx1Zlv/f4HlSEq5E8vY2KVPIqWlLuwRTwHklXuFFmZdV6EFs8Iw2Nn9rdxzQHYO+1
	QCUmcZindBRtoTsXPmmXc+1PVNUo+o2NjiNpyLYqEwihwNQgo7gptliJ3vthQDosyw8NyC4nRdR
	zT39J4B9FYAcmotOAtOCsM1z+J743opIaNBwXokR2itlRysSY77Uj3HigbNA7D3x5Z1PUznFxHd
	dS0Ue/ARtTsM0b4r/J+i23ihrgOcQJibcPSm0TAN1oliJlM7BnagzL/YflSIRrCb4uXfv2Gb8
X-Google-Smtp-Source: AGHT+IE4dIxX2cOpNT0DCIKo6SJPz/ciXBnh/sZCXeA55CbBaX/a6AE2e9DeRQFarQRrTJbzFw4NtQ==
X-Received: by 2002:a05:6402:42d6:b0:61c:9cd7:e5cc with SMTP id 4fb4d7f45d1cf-61c9cd7e8a2mr10768811a12.19.1756485743184;
        Fri, 29 Aug 2025 09:42:23 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc51e0c1sm2005656a12.42.2025.08.29.09.42.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:42:21 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so325978666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsAgGP3lP1CQ/XWA4/NhVto4VXyFcCGV2JI8N4M7rfdykPYBjDdWRzPOuVezMyQO457QxuoZYPDUGesck=@vger.kernel.org
X-Received: by 2002:a17:907:9405:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-afe2875bfdcmr2604625966b.0.1756485740538; Fri, 29 Aug 2025
 09:42:20 -0700 (PDT)
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
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com> <20250829123321.63c9f525@gandalf.local.home>
In-Reply-To: <20250829123321.63c9f525@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:42:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
X-Gm-Features: Ac12FXyxaMJRB_uNJ16NrW9PwMVmli5CdBpfhgymWkTxGXIEdjwFXvJ_jKjFZ2M
Message-ID: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
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

On Fri, 29 Aug 2025 at 09:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I just realized that I'm using the rhashtable as an "does this hash exist".

The question is still *why*?

Just use the hash. Don't do anything to it. Don't mess with it.

> I could get the content of the item that matches the hash and compare it to
> what was used to create the hash in the first place. If there's a reference
> counter or some other identifier I could use to know that the passed in vma
> is the same as what is in the hash table, I can use this to know if the
> hash needs to be updated with the new information or not.

No such information exists.

Sure, we have reference counts for everything: to a very close
approximation, any memory allocation with external visibility has to
be reference counted for correctness.

But those reference counts are never going to tell you whether they
are the *same* object that they were last time you looked at it, or
just a new allocation that happens to have the same pointer.

Don't even *TRY*.

You still haven't explained why you would care. Your patch that used
inode numbers didn't care. It just used the numbers.

SO JUST USE THE NUMBERS, for chissake! Don't make them mean anything.
Don't try to think they mean something.

The *reason* I htink hashing 'struct file *' is better than the
alternative is exactly that it *cannot* mean anything. It will get
re-used quite actively, even when nobody actually changes any of the
files. So you are forced to deal with this correctly, even though you
seem to be fighting dealing with it correctly tooth and nail.

And at no point have you explained why you can't just treat it as
meaningless numbers. The patch that started this all did exactly that.
It just used the *wrong* numbers, and I pointed out why they were
wrong, and why you shouldn't use those numbers.

          Linus

