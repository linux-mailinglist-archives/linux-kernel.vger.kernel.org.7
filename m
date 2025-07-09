Return-Path: <linux-kernel+bounces-723669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C8AFE9C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571BB642405
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B432DC34A;
	Wed,  9 Jul 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xp+Jaak1"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B535962
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066759; cv=none; b=V2r9SnSlzqE+qSkSgXtLm7MFXY9lYcFJ6Nq/CayzRt9nqbCdsWr4681jKr7rjoRaxQ3HX1zryenNvcposD45Lv76bzrWXMVv4EgaFN6+5yXlQ9Kflca49pZzXW08EO2X9N3Q0/PpE5h+j7NzNWy1cVAlJ/4qTt9OE/+ZRbNAfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066759; c=relaxed/simple;
	bh=oYqY6VOsUb2vogY9+8ZjXmagj5swOk8s/CbbXomrnQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYyw05httKiDkh6XPCal3+DFrFMhESDLngB+zB5ba85ULgCKDl7OFjoiYpTefK53/+xWJqU9n/BdX3thdjLJSiFLaqZpMukhRQqwEp71F002tLUd5f8S4OwPIDTBAqRXL5ZV7InEo/nMgEc/Wefmt8HMfI/VD6dlGShVjaTsb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xp+Jaak1; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87404493fd2so506591439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752066756; x=1752671556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fL+pY6fWp85rYXFbZMcl5dcJ/9fsmg9O8nAr0THFasw=;
        b=Xp+Jaak1KQg0CHmjF3kgNMx6HAGsA8kg03CdItVUFn2VBFFGCvMweB4guLJXIpQsxx
         Q+EjuhiTYjpC7nfkiwKOYyZ6AuCo14XVuHCiLsYghMzFtZcqG1xJOzbl6wSvT04Q5QWR
         w1HsewWearijVZqbmG75QWOEG+GI3yj8+b/qMib1e5z6dDBcOvvneEHm8+Z+aUjNkkN3
         1Lpketzzn/wdpBhaviqBOqXXhTQJ5kcr2CVOwDEzuXhgCFQjCtlxMzGvg3K08cfOI7jX
         Vbx4HdVcJ0Jl/9ZR9XPlY7MJUVvPNX0qofLHnvnDb9ajtZUfQFaefSfMiazLTcXfhMq2
         smxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066756; x=1752671556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fL+pY6fWp85rYXFbZMcl5dcJ/9fsmg9O8nAr0THFasw=;
        b=X/Oxmbd74+ueguNC3CH3ZaWbrCp/aMI6IhPtKMVIwZ7da8y6lFawiShy36drw70zHQ
         SzlBKY7u37RO8AV1m0mFsbgHHQzlMSAb1/gA45rCOpS/WQkvdUT0JM4aslkljLhYLqQk
         +HlRgpzbTEvul0rzRMuK4r9kONA75WnmwccEnLaygLxQcAb0+5teFtVKbII9Bjt/CKqE
         7JX9Vdch0k49yuqNkQwB6K7ojVYJhGGNUjSb52bO5TRAQo9/vdugAE/X1uypcGWcUyKU
         1YUtEfJwitfEeZrJ4eC7d0RK9Qbvk+12KGkOR95yd1J3AuSNWKv2RHzKkMF/fgCH4TkX
         o8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUodMuL33HSgHN7V/s4fvuTzSJQAwJme6w/XqMMr3dMjc2O3nb47qIhVkgb5rQb5onn5IAO0mqQUTAenNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRY228xZ42XDzeDHK8hDBmo5KBsZ8SuMw0DJurg2BrioeydSa
	7gkrUxK3qxutzfnv6rSkbM7z/yX7OobKe1VQ4z9hUjLGGuHmXUlKxTdJaGsaeMWdZvjq226Xz6O
	qF8mehZYlWwWe4XZyVWZ1Q5Ky9UURnviXRdPuMjix
X-Gm-Gg: ASbGncuCGIdtYfeYZzvrjnAQVYo3ESQVw9znbWVt806kGTcsPDTJSYPAjHh2yY2XtNc
	hgwbHrrdgBh9sl/3OcwCo/DYyCQj+zxLSfs/qBeGqP3LPBZaT/wgv4mtI7XjPGJix5sYfWYM0di
	RBWE/2Zx7nSEmJduh6fRwuElWVWUMrOvKiljXoKz9nC6pb+v/ZsFP7YXpVobWT54juua0ubi+WR
	coaQgMJji4E6Os=
X-Google-Smtp-Source: AGHT+IGXzavSfLCAmRAn/76w/8qFHfMcjs4NkkbCKXdvUIHrD+VHwrQ7JWt6p8ovMiMd9+LWQWhncIO43+9zX+TMFOw=
X-Received: by 2002:a05:6602:4a0e:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-8795b0fa8d5mr306086339f.4.1752066756235; Wed, 09 Jul 2025
 06:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-4-glider@google.com>
In-Reply-To: <20250626134158.3385080-4-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 9 Jul 2025 15:12:22 +0200
X-Gm-Features: Ac12FXz8IWecUDpLj5NTCC5KnNHKtX0iPWuNoUP_LzOkkm3xhcQGIGzEOXtSrOI
Message-ID: <CACT4Y+Z=G0PBvMk=5MgLAC3LjKOHvCpMqtnw6PLey3SxeUa5gQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] kcov: elaborate on using the shared buffer
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 15:42, Alexander Potapenko <glider@google.com> wrote:
>
> Add a paragraph about the shared buffer usage to kcov.rst.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Change-Id: Ia47ef7c3fcc74789fe57a6e1d93e29a42dbc0a97
> ---
>  Documentation/dev-tools/kcov.rst | 55 ++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index 6611434e2dd24..abf3ad2e784e8 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -137,6 +137,61 @@ mmaps coverage buffer, and then forks child processes in a loop. The child
>  processes only need to enable coverage (it gets disabled automatically when
>  a thread exits).
>
> +Shared buffer for coverage collection
> +-------------------------------------
> +KCOV employs a shared memory buffer as a central mechanism for efficient and
> +direct transfer of code coverage information between the kernel and userspace
> +applications.
> +
> +Calling ``ioctl(fd, KCOV_INIT_TRACE, size)`` initializes coverage collection for
> +the current thread associated with the file descriptor ``fd``. The buffer
> +allocated will hold ``size`` unsigned long values, as interpreted by the kernel.
> +Notably, even in a 32-bit userspace program on a 64-bit kernel, each entry will
> +occupy 64 bits.
> +
> +Following initialization, the actual shared memory buffer is created using::
> +
> +    mmap(NULL, size * sizeof(unsigned long), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0)
> +
> +The size of this memory mapping, calculated as ``size * sizeof(unsigned long)``,
> +must be a multiple of ``PAGE_SIZE``.
> +
> +This buffer is then shared between the kernel and the userspace. The first
> +element of the buffer contains the number of PCs stored in it.
> +Both the userspace and the kernel may write to the shared buffer, so to avoid
> +race conditions each userspace thread should only update its own buffer.
> +
> +Normally the shared buffer is used as follows::
> +
> +              Userspace                                         Kernel
> +    -----------------------------------------+-------------------------------------------
> +    ioctl(fd, KCOV_INIT_TRACE, size)         |
> +                                             |    Initialize coverage for current thread
> +    mmap(..., MAP_SHARED, fd, 0)             |
> +                                             |    Allocate the buffer, initialize it
> +                                             |    with zeroes
> +    ioctl(fd, KCOV_ENABLE, KCOV_TRACE_PC)    |
> +                                             |    Enable PC collection for current thread
> +                                             |    starting at buffer[1] (KCOV_ENABLE will
> +                                             |    already write some coverage)
> +    Atomically write 0 to buffer[0] to       |
> +    reset the coverage                       |
> +                                             |
> +    Execute some syscall(s)                  |
> +                                             |    Write new coverage starting at
> +                                             |    buffer[1]
> +    Atomically read buffer[0] to get the     |
> +    total coverage size at this point in     |
> +    time                                     |
> +                                             |
> +    ioctl(fd, KCOV_DISABLE, 0)               |
> +                                             |    Write some more coverage for ioctl(),
> +                                             |    then disable PC collection for current
> +                                             |    thread
> +    Safely read and process the coverage     |
> +    up to the buffer[0] value saved above    |
> +
> +
>  Comparison operands collection
>  ------------------------------

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

