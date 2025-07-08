Return-Path: <linux-kernel+bounces-721946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B4AFCFCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DCD162FA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE112E1C74;
	Tue,  8 Jul 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ef4TnyBY"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA962E1754
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990058; cv=none; b=s90dsAKlZ9i7y46dejVgCg4Xs6JoX85FGwF0KDUsZMjhRhV2bkFgaGCeuRjIJOOJX+7IG31oXCAJgKddFSiVtjfqnghD7aZVvMhUaPIti0TfQWhNDLQudKQfzqZ62uM1p1A7o34SKll0AL5R4IOFI9ifyEefG/r62dXixxUkJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990058; c=relaxed/simple;
	bh=gjZLHGLmfbVObDGOZ4Dg5r0jve/c3K3iH7rC6rix6b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be1FjgXZACov9ANUcbffHY+Xu4AZJ2TTKgOVj8nb0hXKDMk6YRFAmLA5HE6NVzMZ/LMTIJYxbqE5srsmBA8PYrIhspScqhVb9jgCpLDtD8q1RKljdb1kCh8F51DCVJ/qbKb88BeGTzeulY70dwkI9j/PxBvbvP/gEA76l+SS+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ef4TnyBY; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso969509066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751990054; x=1752594854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JviNfoY/DbOqb7IBhvcbJrjlb0wZveDxGuzjGFCnAdw=;
        b=ef4TnyBYTj4iDNrEIclbT9tK1giFtWOLDdEwzLM1+HYwwUHO9PyEMleMNFxSIxsmmv
         lUovRuQd+9tWda/QsNynUMklonaEFih2HMA89xSx7CBvZ3PHAvkuIaddqAolPfSspV8N
         B8jRtLcOn0qoMVfPH2sWThM2yJY187m0krAnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990054; x=1752594854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JviNfoY/DbOqb7IBhvcbJrjlb0wZveDxGuzjGFCnAdw=;
        b=Vk8bxDtScn262Ij6rQh9QjBzZj5vStSl97LF8/+gY1ACZ0/AAZSeIJKkaCB7M6bsl6
         ytasQK2Up/9rNFhG4IHwPpQ+iko2ForK1o8jxJ7s2zjj4qoaKU0qPiJEdJS1edTwMGjs
         pFvdmXl0FvNWThJYvLLWt//brM4pIWEh+V6BqwdvzQlDrWNSCxct7fsN0d27JFai5iZK
         nqRbu+m85ENbTvM1bqEeoO00O1wTlrmm03j3IVWyrWGsNLJd0yAUsJpb5PGo5fHCtZQj
         IN3vfLqmjOkssPwftzagCOl/D3NaLCeMZ+2t6DwTIAguA4JTXdvUbvDqbCOWQQAicXgS
         I0hg==
X-Forwarded-Encrypted: i=1; AJvYcCXeHFmiXs0a+PhpqQ/D+hCw42lU8Dlh5hHxELRPDQKsdYPNXsvFSrfXhQ6d0DNaFQ7FguBdKv85E82IYt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKstysjtPjWeD0ybwDKb0WWr8OvFLCz0yO8C0GKVQSGOZpiRd
	l3jMOtObL0yRzYLDfcIAY6b9iWtj6XiRQNgeXaWXf6T0n+Pd1mjDy1cwahIGtrxTkhPbs1gRYRf
	gVNNujVjWlw==
X-Gm-Gg: ASbGncuiWuXW1FeLRd4c3FUcqDdyOMzXxhLvMadsKCuL694ZyfG5u/+u1mxklAGBatv
	ev60U5mlStsNF1P0pWwHD/Qs8mYvxrRYz+8H6mQqTjAHtWC8VjYzQEsS1FCG7jbOi2XP+/5E8Cd
	Ld6t1tcouGdzjpLs7Jo91JKcwzQRtvzfE/tHDH3VA8q7O+C63JPmaOHpNI3uPM053x07lDPr2eV
	GkrafOtssVVCRnScEjehsIB1KwRYheqO6Qj0aHBjdFRO1EMNIHQCChVCLYABNiyCs3rjNrJZkBD
	jg1ioWsrBGZrlvzdmM9lja8J1XbtK9Nb5g6orKkjkldDncAqxsT3l1/wA9KaNC31APnULtPxnEF
	kyKVRKUNPJUBWzq5tcJVb7p6YAxXOCeVVDFnA
X-Google-Smtp-Source: AGHT+IHYV3fn/dn64Ty0k3Zr5pF8ML4Qwzr1v5RGkTjUhpzK8nLzWV8nlt0UtkJYqlmi4E2eoOIUmg==
X-Received: by 2002:a17:906:6a17:b0:ae0:c355:2140 with SMTP id a640c23a62f3a-ae3fe740fe1mr1626600566b.45.1751990054210;
        Tue, 08 Jul 2025 08:54:14 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6676adsm7296777a12.10.2025.07.08.08.54.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:54:13 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso8111781a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBQe0dR5Dp/RbmupLzgku1olUig8soYgUqgYWgkITKkTK82nnGTDGlqpkQhkCDuY+kF2Vvc8WRzexb5rY=@vger.kernel.org
X-Received: by 2002:a05:6402:27c9:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-60fd65092eamr15258834a12.3.1751990052924; Tue, 08 Jul 2025
 08:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home> <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
 <20250708104130.25b76df9@gandalf.local.home>
In-Reply-To: <20250708104130.25b76df9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 08:53:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
X-Gm-Features: Ac12FXxjWw7PewHMCf7vpGhvfipJRiRQXNVSUY5qO5rT6dy-QSSufIBM28NP0Kw
Message-ID: <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 07:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Would something like this work? If someone enables the config to enable the
> validation, I don't think we need dynamic printk to do it (as that requires
> passing in the format directly and not via a pointer).

I really think you should just not use 'user_access_begin()" AT ALL if
you need to play these kinds of games.

               Linus

