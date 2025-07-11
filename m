Return-Path: <linux-kernel+bounces-728061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B7B02338
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A436C189BEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259F2F1FF2;
	Fri, 11 Jul 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e84vmfS/"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AC41760
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256758; cv=none; b=Pi0j/hYTRBsx7kUHLyASvRHBUkO9bhAEpPYtwfjoF6t/epfJCGwIK7h2NtttPIvBVs9E7Cv9gQuU/wtlRrKlL8Rb0fxsBdHCzAjyQp5Envg3qbTUxzMztkU294TC3bUfKtIogV7idfy4ozrVAanS8HbcshA98NkCRxPAOIrc+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256758; c=relaxed/simple;
	bh=kJPTgPdH0OPrTn/YGSgGWpc1xCCW5T5ErXZFEUacy4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTG1iOwGke1QqsPgTEMjsH0Z09TmVDjaM0BSkvTTopcOGXNjND4+RYqmaspPyZ/ex0GPAQJfXOirIx9tihWwbynIVN3oAU44BulsypX07h7Mcc+BTOv73h5iYsU7bhaEnEH0s+iVgM8jrsUDgmH393Tv0tTmh7Tz2N4/43eTb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e84vmfS/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso3970964a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752256754; x=1752861554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HO86Lx8//8hSyzYLerKKeVnItqg9SoMBkOdjNB0C6us=;
        b=e84vmfS/uvJd4/7X9x9JaZqS7k53tkpjlFfTh956f9UYkN0iEsN4RUnhwm+GEhTleH
         aC35uCL288fvWaHkxq3WSDZGWMtpie/ZxuHaqmQBfzlu9cUll2ECAJfie1+xkuSjFBT1
         nIhTYvwv1VzPUOCcHQkqS4nbupaiquHTToLNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752256754; x=1752861554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO86Lx8//8hSyzYLerKKeVnItqg9SoMBkOdjNB0C6us=;
        b=Q+vix4GN0MHQEMCpAZEjfq4c0dwzlkzKxPukj0YO/6QdKoVLsr1elRIt0Ct747BO3t
         XHRWPqzQEqX6LFb+alkiEsKJKQU86Tfh57MYIUB3oqGMcHzvfP+XfBaJKEUL4vkUZJWv
         xihZMi2tSs5lN0Jd77zh/nsC0Xe51juxWp6DSS5Dp8Wo5tPlXn4PQZXI/jlTq+EmdYy2
         bRdARc+9ZSnxh5BdLXstg2oruspE2NPV9pVPKt4A6ZeEi354ivRedPTM78QilPWKMdaU
         qTDmY97t1oMKG5dgqsY+CTGch/1YGudUy5lio9Bihwj5V2ir/BKSzm4xwqH5ep8iXxUR
         WLuw==
X-Forwarded-Encrypted: i=1; AJvYcCWE6PpJH91TLrIAUpGf/qUghRtrudHHbdahNNEeKS3OQSlB+OfxyRQsyp8PIaDW7W8QyC3e+kAg6lZfCjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WSnWmC+EPmX3vVKMET9J9ql2vD3yeiVtJJZFrW1VSSkaj71w
	yohzp4FrKKVVFMzZROKhK/xOq4N52c4xiAB4zBz+QwxRf4naO9cFgeBwmtOwJcobOaz3sOsKR+U
	3z3dn/kLrxA==
X-Gm-Gg: ASbGncuCSaqZpzlqqaOAmQJXx1EpyithXckbLqyt/oGNCphTZT6Q//pUdg317zPPOcO
	/M2DvyY/EOhaP2uEyicvezkFnJmMjeNH2IeIOikehBRyiN1o3x+wmJwwKM5sWC+f3cjquj5Chiq
	QcxuVVJQqNjjpZv+rSknnciz9uH7mxN965VPmfyJE5DBSNXuM24DD6EHeOjDA/KefRV8mfpJTxe
	d2v1n83Q/JJDRf5s2+qomlRzCzZ1ZqVgesuiwBzvOIpW132OWR+WvUuyrKIP9yeEnPB4aowLh49
	jvhNP6IWZSwcSu7AVkmZILpjNvpon60ndH8k3Y8rQMFby+yGDnhTKHMUoouM5ltoqkQji6y0qfB
	OlJK0Jt+ZyjQXMmKmsrc1tS1qI1P7Isb5BV81zU0E/O1shFFNBHfI6Aa4gIB+IIiqkqDiyAlq
X-Google-Smtp-Source: AGHT+IENv5qWA3H80XmKhozj7/Bl9I2Z6WX5vPwzgikDEC3PCej4pTu8Yu43A9oTIvpgnh5Ya2sLGQ==
X-Received: by 2002:a05:6402:518d:b0:60c:40bd:8843 with SMTP id 4fb4d7f45d1cf-611e764f6e5mr3668433a12.11.1752256754134;
        Fri, 11 Jul 2025 10:59:14 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612067f7ca6sm186068a12.55.2025.07.11.10.59.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:59:13 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so3557842a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:59:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUS/LKsmaujALbE0/bhDv9nIJiTxw6zznBl4gJ8ZjClV16BFbzlg8LSC3lZ7U4vMD907MK8R0Xig1L3TA8=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:60c:40bd:8843 with SMTP id
 4fb4d7f45d1cf-611e764f6e5mr3668397a12.11.1752256753054; Fri, 11 Jul 2025
 10:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com> <20250711184541.68d770b9@pumpkin>
In-Reply-To: <20250711184541.68d770b9@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 10:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
X-Gm-Features: Ac12FXy_-gvqQgEDwxrh9_yUhPGT4NZn2yvYc_wfrsBVUNUS1D4_tzcLfdrYbJI
Message-ID: <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
To: David Laight <david.laight.linux@gmail.com>
Cc: Martin Uecker <ma.uecker@gmail.com>, Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 10:45, David Laight <david.laight.linux@gmail.com> wrote:
>
> What does that actually look like behind all the #defines and generics?
> It it continually doing malloc/free it is pretty much inappropriate
> for a lot of system/kernel code.

Honestly, the kernel approximately *never* has "string handling" in
the traditional sense.

But we do have "buffers with text". The difference typically exactly
being that allocation has to happen separately from any text
operation.

It's why I already suggested people look at our various existing
buffer abstractions: we have several, although they tend to often be
somewhat specialized.

So, for example, we have things like "struct qstr" for path
components: it's specialized not only in having an associated hash
value for the string, but because it's a "initialize once" kind of
buffer that gets initialized at creation time, and the string contents
are constant (it literally contains a "const char *" in addition to
the length/hash).

That kind of "string buffer" obviously isn't useful for things like
the printf family, but we do have others. Like "struct seq_buf", which
already has "seq_buf_printf()" helpers.

That's the one you probably should use for most kernel "print to
buffer", but it has very few users despite not being complicated to
use:

        struct seq_buf s;
        seq_buf_init(&s, buf, szie);

and you're off to the races, and can do things like

        seq_buf_printf(&s, ....);

without ever having to worry about overflows etc.

So we already do *have* good interfaces. But they aren't the
traditional ones that everybody knows about.

                   Linus

