Return-Path: <linux-kernel+bounces-728074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB436B02371
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C2B3BC887
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29262F2352;
	Fri, 11 Jul 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XMTuUxYA"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADD5383
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257814; cv=none; b=a0y6M2oxVIYw9zXR9zna6TavBvKPoFDy+HScdfN2IJteq2hQlyCUkaloBRWI/6rAtT1G/o+X9YaXe/wESVxcDDe1eu68g1TF7uuyJDp8gnixAuEt/8h+VVgv7Pvy/CkdvuoW/6ujDaSClziKhmnRkdJJWDIQQmehD5Ljb+TtTT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257814; c=relaxed/simple;
	bh=NeJocBfdOpLqvXpiJ6aLAWQ15xXfqG5i0CXXacTxLio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwJPzmAhXU3CSfSeOmLXZ+eaYySmM0ACAQEtmme7KCU4eZ+wB7YNoe+f32os9En5rL+6vudFYPHrjUCbsFbiVdYLip03UWibnzczu6oASLuVVQTZk+LYsdQXZjJUaaDMAZ0Vvq0v1TrtBF1+hH9MiLwkcpPwustybUGnAuVws7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XMTuUxYA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so4556470a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752257810; x=1752862610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GrN2boTDwdY7zzXQMC0DmC8Xqjzwg7Z5l0fiFiA7274=;
        b=XMTuUxYAuu/6YnrAUuBpbyChCus/mrvDTIVjvmctIBXMm0FHlIuT47gwwf1IwSqfU6
         N4afYu5XQ1VKhYetUagLw+cFf4CDIFM5vSog7X7UmRgkgTCQclyCm91tut7w/4ZAmgS/
         9Fky1Fu42bEvatd9ffamnVIRRBUoOa81WSaZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257810; x=1752862610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrN2boTDwdY7zzXQMC0DmC8Xqjzwg7Z5l0fiFiA7274=;
        b=BPaFX9vbHSXeuqa8Kn0uA3xd+By5b8r6l4e+i+C0CB0eme3J/fTjil9vtTMgWmHodd
         sXuYrDiM83/CVOFdHBoWQF4SY/Rg82ilvyrcbzZnDFLD+lHB5pPqi7lJ3D6pooMnTian
         y2KPNfgld2rp3JQBCGtczJuJ43/6kfYnwrNFW+sEbUwGFBXzOJYI+hKOq9WPgTDR2DCX
         dxJLL8NNiLS8hRgiIXAMMCrcZYdM+IOiwx8afjkkc7je3H28MB1kk8oAiInqmWIVdyQz
         9XwV/tkt5kPu2EcXdqDubQrPVF9dZHBfBzkPaWEjtA0yY99GEPwLHV9cUFZgV+8JSN1C
         ZFag==
X-Forwarded-Encrypted: i=1; AJvYcCVCDXWiKaqeF7NaJzvazwXC2mKOaHhxBQcVl4Duoat9gSzQ3NUX/GsPU21qrNNxAMqRLDhI9Pek/Wobc10=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcyp1+ZywWJeNi4iCG2II1mKWLlXzEvL7GFg+xOn6J/etOUGTN
	DR1Wy0B6RqZMWpkQ0fN+xyl9aaR+X1siV9jeJYi/AGuSAMtoOpXpJDlAR3vdk7aVGLAgHvYVe7a
	ii2vGGYur1Q==
X-Gm-Gg: ASbGncsoO2smgfsnWcX58/W7wedm2Zetie0HDJ8CeQGTE2BxOK/aUWjAiBiuKX4Creg
	UrHEWuLAuXktvP+dJlqQeaJFICc7DdWVRrMweFkK7+0pS8YJ5kathGjPrtS3UaUdSju4E4bD+nO
	cP1q0PJEop15EaghD827isfULf8r8NwMvF/4ubVBgwD4XEITSmQ0LCA7YsPUEK1AaW9ZZoDp0di
	qPMDcmAuoXwWQ6z/DlWEFWJ6baydrosGTVZMVlc2Ke9LGPERRsRnYyiDDbC4LgZdhh0SjTiHUhf
	6DOlX9wr6Ukoerm/fIwuHqMsO/4RHD9d8JIghjptfvbDimD1wJ0Rse5jDTB5EXdV+UvNIn9W3Ph
	I8K01u2aVwPE9KEhAlRsEPAyznJu+w40xX6OyuEDEBKN01m4537TaTYD2KHDXf4QDqi0tvOVl
X-Google-Smtp-Source: AGHT+IHx+pGFn8GiYlIIW6OLzey8ixN5yUdOJA8oMUSWPGcHNIzca87x9FGHXda6zrhLdgFI5j4XRg==
X-Received: by 2002:a05:6402:34c8:b0:60b:af9a:726c with SMTP id 4fb4d7f45d1cf-611e84ce60fmr3858408a12.25.1752257809902;
        Fri, 11 Jul 2025 11:16:49 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611e4c3c756sm1472991a12.8.2025.07.11.11.16.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 11:16:49 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so4460201a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:16:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt6uogiOPEiut+GNgqTNRDSmSenfTTqQ9waeC11T4/Uf3jE1Uh0e9ALf65sI6yF3kR+lCGdxx75udHJww=@vger.kernel.org
X-Received: by 2002:a05:6402:454b:b0:604:e85d:8bb4 with SMTP id
 4fb4d7f45d1cf-611e84a3613mr2945462a12.21.1752257808496; Fri, 11 Jul 2025
 11:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711161732.384-1-will@kernel.org> <20250711161732.384-11-will@kernel.org>
In-Reply-To: <20250711161732.384-11-will@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 11:16:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijmAO=-dWc8HUMdUbkdGqgNtiO6mntAcTekWc5qN3YjQ@mail.gmail.com>
X-Gm-Features: Ac12FXzHjD0wng1ky85XRCcFPrfFYtoOUVtma4lAy9KVvuoCMzEgKe72-0_IGfY
Message-ID: <CAHk-=wijmAO=-dWc8HUMdUbkdGqgNtiO6mntAcTekWc5qN3YjQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: mm: Re-implement the __flush_tlb_range_op
 macro in C
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 09:18, Will Deacon <will@kernel.org> wrote:
>
> The __flush_tlb_range_op() macro is horrible and has been a previous
> source of bugs thanks to multiple expansions of its arguments (see
> commit f7edb07ad7c6 ("Fix mmu notifiers for range-based invalidates")).
>
> Rewrite the thing in C.

So I do think this is better than the old case, but I think you could
go one step further...

> +static __always_inline void __flush_tlb_range_op(const enum tlbi_op op,
> +                                                u64 start, size_t pages,
> +                                                u64 stride, u16 asid,
> +                                                u32 level, bool lpa2)

If you replaced that "enum tlbi_op op" with two function pointers
instead (for "the invalidate range" and "invalidate one" cases
respectively), I think you could make this code much more obvious.

And exactly like how you depend on that 'op' value being
constant-folded because all the different levels are inline functions,
the same thing ends up happening with function pointers where inlining
will result in a constant function pointer becoming just a static call
(and in turn inlined as well).

And then the actual *callers* would use the "look up op" thing, but I
suspect that in many cases those could then be in turn also simplified
to not use that op-number at all, but just end up using the op-name.

I didn't try to actually create that series - and I think you'd want
to do it in multiple steps just to make each individual step small and
obvious - but I think it would end up looking nicer.

            Linus

