Return-Path: <linux-kernel+bounces-792442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9509B3C3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825EBA648EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BB34572E;
	Fri, 29 Aug 2025 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S/EUYBlt"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4D4A11
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500729; cv=none; b=pfLNmjii9XVE4biDqtoYiDtUzWBMLWgYAe0JNevUNmFMmGBbXh56ZBkzG6QKlSjLXeQDlvdo+zK7N1aGzmq6Xh6uAhdgZMLvtvQLZdBN9cQ/8jP4f+OVTP2XazIZOLBrwqMxFpERxrFYEcykXYN+j+ZiUujyCyMZtGEBotQtWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500729; c=relaxed/simple;
	bh=ohMVoYLKqK85A8YWDL5s4gkFfq9CRDj3CUysT+XmebM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbDW8qc4leTH16nCpmMDQ1rMmtmru830jm2CZMcOblZnMcguC68P3SVccyH5oI8OO79RhRP3fxosJVWAEt8RQHvBWnxKYCiqaGW3B5A15ukf3v8K6pD7uqpjEjdP2v3wR/UjPu5UNDSgNh0uWFSfVHz+ADhMNA4dTMKU+UHJLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S/EUYBlt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c7942597fso7076227a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756500726; x=1757105526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJnIXD44JoqcrcREChaKXOoLztkoHAV/cNICzLJGB4U=;
        b=S/EUYBltCP1ZBgFu5FDNsd5DCvA4Ppgs1eLMOuo3OVd5yunUI02rl3qAjrnmVhyLJj
         0oJJUJgIbfTWcAGw0vDrekP6wj5pld8r8dZ1YYcfOY7mIpKRTQb3tWZp3eNr2rwIP2W1
         skfWcljNNdaJY1rHp5ZQIUXfRk24zz3WTk0HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500726; x=1757105526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJnIXD44JoqcrcREChaKXOoLztkoHAV/cNICzLJGB4U=;
        b=iu0xLMZiPJerHAmYhbeQCEBzAUS4u6BHITlJO0mbkrx5JHMJIBG5yTDOca7NevFAE2
         Poj9oeBqX1G7sWKCue2h17fAAiTYD1NdPFbROcwYiJ2AM8dpTfScCEdgH91G1eZX6105
         9+7bVxB0H468dTRPqtwjW10E/NNiO0qXs/dybTF83uDiOGU1u1Q7SUz8vga79F4nG9TA
         f5nbuUSghFyIBa3TZtEBdw5AgziHGV2+3ufd+hxVeKM71UZYp92TJxrQ4qKU9hef/spw
         g+aYm3QCYWU2ApZoQHy7yOvBT8LFt8dOWh0B7JR0yxw4PebQGUdqnvSRyiq4lWaI8EMZ
         eVhA==
X-Forwarded-Encrypted: i=1; AJvYcCVYRq//04vpQ5XvW0lq8OMQ6Lw/Yac4rlARyMWPLSpnmr20D6U3PtdB+F02/w4p0Odgieh8VbUc/JA3yjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlxbXxpKQnWzRRx3bOcPm2lTJyWC754zE37e/Kv6xDXpwoYBJ
	WO5t8MMBOXxRf5Vt7lmIS19JCoR0f+yKsOGoJKmXigiKF9eh7Fa34joF/cuHOLScWWU71XXu6cv
	CCwiBJQs5qA==
X-Gm-Gg: ASbGncucgfYdy1lrOMSuRovMFTxIGEUHHA99rg5i0w+sVSA0/XBNDyNXeo+cjiERCf/
	DtsuOmplaNQvuOIHA0ZXimrFMS2LY3vxnsV3LuQETzPfw+fiNiKQr7nHbCAgFfpPbn6jyZc8wb6
	7uTnqppGhywa5BYVqpLTbc4jQSZz4Z0TR9qXB76i/A3xicn6rdgBPpGs4qQ2EprRT0uKLvShnm5
	U8m1d9sAbDXwGvGSyIkdbQJq26tRhuSJ4k63s/hzndgBeivI0M8RLd+IHuiVNbc/Dtgxp6t78Tz
	qycPMNBCWp7KbEQB18eNpQ9YqpF24aRyjcbmwNYsxLmwe3ZeAaXS+6M5H7CZ7Enszgegk5lhf1B
	u2XfixAb3KbjUd7HasYQAD/fknGJiW3VUdfnVSvOUKtb6VtQMaXHkq7RyGs2wKusSGnOiU6My
X-Google-Smtp-Source: AGHT+IHNL/aeKIM7HaIhlwIUpkUD1z50qAXioYx1uPV+1n6wY2Qe1mH5dbJHxSJFQ2Yv018QkzhTqw==
X-Received: by 2002:a17:907:7ba7:b0:afe:8ae2:a8fe with SMTP id a640c23a62f3a-afeafeca898mr1625999466b.14.1756500725886;
        Fri, 29 Aug 2025 13:52:05 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0a5fasm270990866b.30.2025.08.29.13.52.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:52:04 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aff0365277aso174087066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:52:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTvV1y9XCYPA3TErlhG0dAwbt5K167O/zRfDkc+h70Cn5xz5kdhfBoe4KauTpXc+hBEOvkizF/3uaeIpA=@vger.kernel.org
X-Received: by 2002:a17:907:3e02:b0:afe:84ed:6152 with SMTP id
 a640c23a62f3a-afeafecb9a7mr1571449466b.12.1756500723697; Fri, 29 Aug 2025
 13:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
 <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
 <20250829130239.61e25379@gandalf.local.home> <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
 <24E50A07-EC58-4864-9DB3-E5DB869AD030@gmail.com>
In-Reply-To: <24E50A07-EC58-4864-9DB3-E5DB869AD030@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 13:51:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxMx4Bew7naxecrivtrdt0mzABSTt==vO-tO9Th083kQ@mail.gmail.com>
X-Gm-Features: Ac12FXyW0nAdh202diR-dvFjPy8CyZHx9x_gTjrEDXtExTrmFznxHPLMFXgTReA
Message-ID: <CAHk-=wjxMx4Bew7naxecrivtrdt0mzABSTt==vO-tO9Th083kQ@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 10:58, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Can't we continue with that idea by using some VMA sequential number that don't expose anything critical to user space but allows us to match stack entries to mmap records?

No such record exists.

I guess we could add an atomic ID to do_mmap() and have a 64-bit value
that would be unique and would follow vma splitting and movement
around.

But it would actually be worse than just using the 'struct file'
pointer, and the only advantage would be avoiding the hashing. And the
disadvantages would be many. In particular, it would be much better if
it was per-file, but we are *definitely* not adding some globally
unique value to each file, because we already have seen performance
issues with open/close loads just from the atomic sequence counters we
used to give to anonymous inodes.

(I say "used to give" - see get_next_ino() for what we do now, with
per-cpu counter sequences. We'd have to do similar tricks for some
kind of 'file ID', and I really don't want to do that with no reason).

And if the only reason is "hashing takes a hundred cycles" when
generating traces, that's just not a reason good enough to bloat core
kernel data structures like 'struct file' and make core ops like
open() more expensive.

          Linus

