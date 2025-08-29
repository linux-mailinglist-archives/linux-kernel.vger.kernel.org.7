Return-Path: <linux-kernel+bounces-792141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7BFB3C0AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4003BD4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2C326D79;
	Fri, 29 Aug 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AhpQWR63"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DE29E0FF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484943; cv=none; b=EqBmlVbmXar0X4JV52NR//uiscHoe4eZ8T0jTQ5JoDn8ts+wTlhp0R+ihfyw3Zkt+6zYswW7vEinH4+SUBpNPrJEKTNUmB0EHXYM3tRe2UECaHzIAlmdZI/bsKBO/Bk6yz+XjbCZxCeT2eIWjdzR/xoQzeiHLXlrIfKpDgb03C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484943; c=relaxed/simple;
	bh=JAYlCBf5lvQf2RAI2BCV6usuwiQQx3hpU17cVIVxX3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmAAuH/YWEvLawUP8+aT4ZoWGAgWUTnzavSnLlGMayX+Dg1YadzMx8SEnW4dO+WG0WmJN1NerHRygJMPWn8LlJJy4UT3GlNZFTGwNWCZtDd4rNF/ski+vegZ/2NKQGqieCIycPFpa8GQufVtNE4G21BYX2PzUWpEs+qILQ0HIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AhpQWR63; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afede1b3d05so403580366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756484939; x=1757089739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhtkB5kKKP+MCd/lsnF5BgjvtsGJ8UuOa5gag5oWTg=;
        b=AhpQWR63yX6QlnDCVzNemeg1aUhg+sk84+aLyn2Cw33yghbV+HYDAV8pTHmUmkNe5z
         ISvF5uEx7Mss53N1JiT1LmpbdPAxQbWZieI4FTKDYpUispwEHXN8kghS+OeLuagrky3J
         bYBwupT9wc1MWRbgFhjR0i0UY5BacIL+3bFrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484939; x=1757089739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayhtkB5kKKP+MCd/lsnF5BgjvtsGJ8UuOa5gag5oWTg=;
        b=oQuaN6ppY8hSzWcNqZwMYbLypAg6qX9sh/nplPDHu9ZxZtefZfsZ9/c8n/+APZqfgz
         o9/3AeUdtMLoOx8cQxIiIomNJfkMQHIsVkvYb6cY4QnRopdB/eR51jeO31GjstmNnfpw
         jQDPvnhyC+RzlCn9CKGUyNTXbEuS40fSUwH+H9jTDgb0u6FSdwtwfJTfyxCg8z48tAk3
         Iff557Fa9uM3bZjHxlDxPQOTTjegNM14nLizFfKWP6v0FowqRBFsL2xnXNgzytGcw4uc
         qA51NLEeolCf6U3lJ8G6+fgzTGldjiQAMAv8a7CEFwNe/DXE2GWkoi6iR83J2WXYfB8c
         ltdg==
X-Forwarded-Encrypted: i=1; AJvYcCVMdlw28ZvHLEMhezvrRjXknLVI1R9ScGMd/m/K9ylHJgLi/ciz4OAbrheQ7lXqwh1+w9PoGPMxPylUOUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9xbo1/HJHgdu9ZD94L2kk/P0voxwb2c4ZqxCJpHhq333IvkI
	L6HGb0hc7mJJakb1n6uR910yDuGIvqJo0hLG/e039XFiCy9WibvbvIl/2kg5EcFp/WOd4wf7MDw
	urwJAiapzsQ==
X-Gm-Gg: ASbGncsrYR7PA/Po7onFxo1iJpThrmVC94gIM1GaV8W6MaiSN9VCjshNMAnVC4vCoXV
	n6iucC/9HFZRMjKryasJBo2qrVoDDdtVY/BlM6jtgUIXW2TvGfz24mghl2cg9p50gcL5KnXSaXA
	FKLEPk1Zg+AvDJ7HqAV84FaUlWllwrLBfpWtLwEYy7GpPjS4gFeufrQUUkR3emyMu91CLY81s8N
	p8lhmImLbnycu+JnN5/BLIny2EoxTLXU9UZ8ZHbTjW4ai70kjwafYuIk81yuqzzO8d58m6DBZ6f
	GJ8UGWc0Wn6Iv9JsRca7jVmUAwy2Ch5aSbFID7iktM/smKYZhVbWSfoOmYEMhTvQbGFmEchlJfT
	M5+9hrUiNkmuxIr2tNaZlOD6m3TppRKUtoASU2Fq3KK6b8B1jUEFWtUcT3fCHOdXc/RTKIi0Tmo
	4OdrdTJxlTx5zyF2TnhQ==
X-Google-Smtp-Source: AGHT+IEB6lbEbzVPTQhekWCCbjphqYKCvXSXGCQWvQcA8Q4Gbw+piC15shjCZJmBRcy+U5gc2BaIdQ==
X-Received: by 2002:a17:907:944f:b0:afe:d2e1:9018 with SMTP id a640c23a62f3a-afed2e1a58cmr972516466b.25.1756484939593;
        Fri, 29 Aug 2025 09:28:59 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm85238266b.88.2025.08.29.09.28.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:28:59 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afeba8e759eso350807966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:28:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURDLgPULRNgYX5StRMudrPE9eg0at8tm3cAkO9mp2loZeZmmt1frVz13wJqYFNw5UTqf/FPrBAIlKnBzo=@vger.kernel.org
X-Received: by 2002:a17:906:c116:b0:af9:a1e4:a35b with SMTP id
 a640c23a62f3a-afe28f864bamr2310935766b.7.1756484937731; Fri, 29 Aug 2025
 09:28:57 -0700 (PDT)
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
 <20250829121900.0e79673c@gandalf.local.home>
In-Reply-To: <20250829121900.0e79673c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:28:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
X-Gm-Features: Ac12FXzKsn5qgiNoTPpUW92vL8XQH-QBVsXDCKCPAfj3-whVMqZU-D3ENWgGNVI
Message-ID: <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 09:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Basically what I need is that every time I add a file/hash mapping to the
> hashtable, I really need a callback to know when that file goes away. And
> then I can remove it from the hash table, so that the next time that hash is
> added, it will trigger another "print the file associated with this hash".

That works, but why would you care?

Why don't you just register the hash value and NOT CARE.

Leave it all to later when the trace gets analyzed.

Leave it be. The normal situation is presumably going to be that
millions of stack traces will be generated, and nobody will even look
at them.

> My question now is, is there a callback that can be registered by the
> file_cache to know when the vma or the file change?

No. And what's the point? I just told you that unmap doesn't matter.
All that matters is mmap.

Don't try to "reuse" hashes. Just treat them as opaque numbers.

             Linus

