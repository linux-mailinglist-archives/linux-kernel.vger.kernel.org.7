Return-Path: <linux-kernel+bounces-792443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F1B3C3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ACA176BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CA34572E;
	Fri, 29 Aug 2025 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ry/tAa/3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0D4A11
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500871; cv=none; b=peFSx0WLmpheIX3Pe/hY5EL9qzuatB51mQbWoLQu26VnlMIlQPJHR2MkjhdQhX6QbFdFl/e2BNtygwdXec976ZtLVRn0l16+dHSEuklDAm+KyEPfDw2IY1mBSd/lPZNVxy16N7v1cX5jdN8DWO/gqqoHds6q1CKV+/CHt0ZfuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500871; c=relaxed/simple;
	bh=lm0u26OhekurXvbZmRAMXY3a04c03Jb12UfPOAKe1Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpWE001TvRcAfRtS8gatyjaAwoETqZGh0RBRs1/qXoEVPF9crGZDMXsVT9zDlqYjrioTrAYo4E41uv2bTAKF8XzqQYxAn5UpEYcQKQcmn+nZT/QlvfdDPDwerdE1RJNkGZDmKzqEm/mMw2xnEXhtO864gfSgwftNWMH93af8jgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ry/tAa/3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afec56519c4so333310766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756500868; x=1757105668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtxiUTojkJryuwfS4utzOx7v5IFRnxmAU2q8IplphGo=;
        b=Ry/tAa/3MKcRToDTWk95810hJnEoFdSfAh+ir5Bs3cTqPZ6DMHbEQmQ5j+bekTmz6q
         jPQ30eFzAtICWRY+DyekiGs3pgpx3HSOSz4vCXODg78U/bijzbpDn7B9hkDbgpopNn9U
         ZpUtZnfE0Cp/HwfJzhcdfWNPRnR+bKBreLjDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500868; x=1757105668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtxiUTojkJryuwfS4utzOx7v5IFRnxmAU2q8IplphGo=;
        b=dUFQTSh1y/gqu/IfZMnA74GcPhkEfJzW8b7nKHmnF5PrXkX1ym1h2M4a9i2Ame7DPZ
         p0Y6ul1A0qAFx0+jnT3z/Ca9RPQ3RnLUEO19WJfLw6NF+4Ru2iBMKvielsLHnKdZBOxl
         ZUhS5RMI+3uODZA3HTb0Huxyk+Um3UC6KWdltA98dCS0xx4gM8ZdQMUiDfgXobNur5Gj
         xy/JJljblnAgqOmzWtA0gcVcxQUO2IDGGA77q3w+0d7TP0G6Tl+sVJBnhoXMvx0IJ5xA
         +fShFu90hMbvd1IJVzBoVQjqXyAaiy3PY6oLQ2lzc5uNNL2299zhyh+daNm7f5/GeLqN
         pZzw==
X-Forwarded-Encrypted: i=1; AJvYcCVbxjoq1ypN4uW1ofs3J9UJMcie16rii8juI1GdOkVMRc58axNhQHijT2fSz/Ae+ihBkmGx5mT/6TfSjaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQi8Xxgymw7g01KM88m6fuX/uYtiphTJMEbJdLQYWakM493cZ
	igIHaPh+CnKAw/ff2KL/121fPHFMtnTyhOIYeEQFMzYkDYxgkuL3Ws4XQgHayht6tS+HdbdVYiD
	f7+6LM6vcDg==
X-Gm-Gg: ASbGncuV33j7FrE6gX5/66zFrk3/aoYee+bfIi6cAFhikcg4A4pQwjGYpPHr4Fvcpp6
	EOpmCCdws0WsQXL1cAaBnJNxHe+OiGYmKphxR7vTj3Df2YQpA655/CkIk8Pn0nY6pqWb13RdVp+
	hfyOM5eR8RVADVKinLjLlLBF08qJ2A7XHFQNuOq3ZKLrOrutS6iiEALUMBodEKE7DsoS/G9w1AH
	zM465yByt3h9BXv50wirpfg/cAh3OPX4LYsepCHukr3xaWdLohm1hANcrIH3HmMWDc57DNbt5wV
	nm3Jqfkq3tmCZ18Z96TKcW/5ATXDcdv3prGK74zZVWPOMLd+VFnyhJfDtamEGu9wZrkJWghTp/f
	8LzRqqnPbyM6J/8wMu5RrnuH+ciTEkoYITmqi/JchzxVEx1MQSNmkuU8Ql8iwc8gSPyvHO8D+
X-Google-Smtp-Source: AGHT+IFCbQ2IDLq0DOEYcjSiyfJXFZql6uRzALk548BCZ72v+G8/mJI2vlEIu3SCbVLcL3z1zoUyDw==
X-Received: by 2002:a17:907:7289:b0:afe:8af3:2ac2 with SMTP id a640c23a62f3a-afe8af332e8mr1685653766b.39.1756500868145;
        Fri, 29 Aug 2025 13:54:28 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c397sm280483966b.81.2025.08.29.13.54.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:54:26 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afec56519c4so333305366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:54:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU45zGBoSt/CqHMHdmu9porWY/oL7XXuajLk7COYno3A44WLDMSJizv/xXFPp4579wlEktwPp1UsOEQIBE=@vger.kernel.org
X-Received: by 2002:a17:907:804:b0:afe:ed3c:1f9a with SMTP id
 a640c23a62f3a-afeed3c33a9mr669079266b.38.1756500864690; Fri, 29 Aug 2025
 13:54:24 -0700 (PDT)
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
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home>
In-Reply-To: <20250829141142.3ffc8111@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 13:54:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
X-Gm-Features: Ac12FXxq3CT2Pra5MUu2kfheMZZZIqxJ8O9KYQ-_o6FJemvdl2_01eUe7c4e2AQ
Message-ID: <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 11:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The idea is this (pseudo code):
>
>  user_stack_trace() {
>    foreach vma in each stack frame:
>        key = hash(vma->vm_file);
>        if (!lookup(key)) {
>            trace_file_map(key, generate_path(vma), generate_buildid(vma));
>            add_into_hash(key);
>        }
>    }

I see *zero* advantage to this. It's only doing stupid things that
cost extra, and only because you don't want to do the smart thing that
I've explained extensively that has *NONE* of these overheads.

Just do the parsing at parse time. End of story.

Or don't do this at all. Justy forget the whole thing entirely. Throw
the patch that started this all away, and just DON'T DO THIS.

              Linus

