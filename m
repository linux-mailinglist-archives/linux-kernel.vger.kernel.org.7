Return-Path: <linux-kernel+bounces-792199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FCB3C15B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250A83B6BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339121C5F39;
	Fri, 29 Aug 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JUy5RpUB"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28B21CC47
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486576; cv=none; b=UxLYOSsnv90jPXrtHy12ly348h4Ru896UnGsGTKrclp4G9LKWNLifsbUrzx2SU2uzSjY3TuFKSHGepNuOYyrHAHIVISwXCJQob38Hbf7y30byB6x15FAw9dsQxAzfy/nhJXn5zVxzx40hMCUBHj20mB4NbjS0Ea/Tdh04V+HpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486576; c=relaxed/simple;
	bh=h7kL/4uMpyKF5NccHp4ZNI0Wmfvu40JouRjLRpItj7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sy6DMLfcYPeQ1qLccNmwVPy9CoxCH92s407+0kZAFCTp+F/8Kv3JaILICw/03kbNliy5LpgnmcNS3fIdBxhnsWfu+QPqETm1kyvH/DE61IxJZegTsWkvCqwJUownrVLLNkWlnKL9GGZ2z9yT7ZqG7aNY7qBfjz6wAILnKI8CDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JUy5RpUB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb72d5409so399327066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756486572; x=1757091372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YuhPIWx0Vj7KfkidRYFQ7OP6ebYW22eg0BlKIYspAk=;
        b=JUy5RpUB50q8VJqUSY37DIAfQ864cY2XJwgyUbTRwQFfYqR6t4aqn2BhgGhE4TCInU
         27eClXFvlapfd87kO1yDwBUnU+M5VtYFDY9bA9rHU/3omlfw8dkuYOXaF9XGZ6jcGT9M
         oRmVgxpJGVSQxPsAz+ihTY6NVFNkTS9809l+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486572; x=1757091372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YuhPIWx0Vj7KfkidRYFQ7OP6ebYW22eg0BlKIYspAk=;
        b=K/CvPJW8t4L/ZDPwGZAmGgSZlrMjjqqe6wlJ0lB+9MMFAFp3/pQYKJ81mHlQlr9x3R
         08dYSQ/FsTxHEW0UUMfwl+gNHKCq5nLB3gKam1CbmS9EjCRt3AfrpymmrrWr/Xp+2ooO
         WbW/QxrkE0jyjWOrv51P9krla4B0YuVCGxJ6Zw2XCdzY/wdDUnBTOs3GOTzFTGqeAFHi
         uByDY11eY5H6oA1nBjj1DPMZv+aAz4aTUIqOHIvdNptoAogyxOqazN55wdiaJ+fV/QtH
         FggEaQbpx/sPFWQh3Z0Pp+pezgEaGf7AOoM+MGXGJaGt0idoJgMEAdHoL9UkFRHxSkVC
         8kww==
X-Forwarded-Encrypted: i=1; AJvYcCVBpzA4Q8WGMR8JkS+fA8RAuCxmppmudSCLGozpaCGvfkmK2+6hb/3l0mC9Z4561TcO/rtuoB1qJyO0v3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqJyVGyBNbtPC7c94uG4mej20ZUTjQW69In3ia/wJZFFxUpo9
	c/JNwQ/hnGecsSLYXc8X/KKi2JncdqFSsoqaXaI4RLWEhU8OPt/iwbyfHGBUMwRrsdWK9zU6MrA
	EXuSZl5UL0g==
X-Gm-Gg: ASbGnctOngeUtIrzhRvZLzfICTKgT3ol7bsJ5Q/pjbjx40LOGB8fcl4bRF6hrm8bOQP
	qc2ekxqccp5sZyw6L56ypffxC2FBoZUjWUBsihiw8+OyHtRvkcpM/awQomdp8yaxagvTHJO//7D
	Dyrz+jetec3xmARBZJhaQnPnSVrMtlwiKa/ZwE8j+P4d8UPXeI3d5AwX6pPIH6UIn4h4kIk4eWK
	vSSh7qUi5wKMmcZyUh/OuDUiW5pxiKfaTnHoS/YY16Ysb88uf4dEEwfO5qdENnQobjMTkaGWJ/6
	kXiGlUWCKn7HSzBIxkbe+z6GO8K8CtsiHWr15jf2Cvll+9VlDZS6rzSjSRBERq/BCh/ERpXCik1
	F7Q9ynrSgrWcvDm04twKdANUkoRxoj3v2eyjNUTlpW75h4RTlHMZZwIjXv038xbeUvL2yR3H7Tp
	MYKdcdWqE=
X-Google-Smtp-Source: AGHT+IEpjCNm3msBD4vzXVQuhuivPj6fCFofsoZjkQwgkOKfiAiuLlmWZ3S37l3OYxNbAiRI7THLcA==
X-Received: by 2002:a17:907:97ce:b0:af9:e3d3:a43f with SMTP id a640c23a62f3a-afe295ffe26mr2345863366b.47.1756486572546;
        Fri, 29 Aug 2025 09:56:12 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f0d44sm238111866b.11.2025.08.29.09.56.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:56:12 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb72d5409so399320866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:56:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmCyR3aU0tc30YkWJ+UOzt8Ryqio0y7WzmszOwzBZujlUCB2KDBDEFCNlUPN4z1ivp+Rl1Fnr2HVfPCR0=@vger.kernel.org
X-Received: by 2002:a17:907:d10:b0:afc:bcfc:b3b7 with SMTP id
 a640c23a62f3a-afe2958afa7mr2671499166b.38.1756486228847; Fri, 29 Aug 2025
 09:50:28 -0700 (PDT)
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
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
In-Reply-To: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:50:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
X-Gm-Features: Ac12FXwTdaKGwKQQrcvfZIpWu9JvQChz-8oubMdWokhEh6BbzzxHD6kJcwqyw4w
Message-ID: <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 09:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Just use the hash. Don't do anything to it. Don't mess with it.

In fact, at actual stack trace time, don't even do the hashing. Just
save the raw pointer value (but as a *value*, not as a pointer: we
absolutely do *not* want people to think that the random value can be
used as a 'struct file' *: it needs to be a plain unsigned long, not
some kernel pointer).

Then the hashing can happen when you expose those entries to user
space (in the "print" stage). At that point you can do that

       hash = siphash_1u64(value, secret);

thing.

That will likely help I$ and D$ too, since you won't be accessing the
secret hashing data randomly, but do it only at trace output time
(presumably in a fairly tight loop at that point).

           Linus

