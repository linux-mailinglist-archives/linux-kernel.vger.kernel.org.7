Return-Path: <linux-kernel+bounces-885411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC4FC32D37
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 423574F75B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFA2836B1;
	Tue,  4 Nov 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eAFtIC+l"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAC184540
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284884; cv=none; b=GPbdPLBkcUc1utErnTbjsMmR6icd6W4EwTnXtwqjBaYIQOTDFVi/73TZWryXuz/sZtP9f8SDXusdgvV9mB/QCmHBn5b9A14egC+F09NuDjIsPRBpmxVwIkLLZfoazBDfQu5HemdeVQ6g1H3LDxL/Rvav5br2+BdmhnQUOoqNgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284884; c=relaxed/simple;
	bh=+0KQLznGWai2QqA3COF+wfMOTBGaiIT1pBvD3XbGrNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucdc+43ZiyRUmgZtueNXntj4Aw9Ih2Yis8RlKKgeEBiUmbMOdNtJ8qxpqXRw1DEPXy7R83VAayHwB6IQJ2Yy5s2J6k2o7fCnUWp/yxkExVzJsGDrw6bIHbNaOYDXhqehyMikeVQrGHLx2ksA/09DkUx+OjbkGR0im6mGKd0TTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eAFtIC+l; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so6414596a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762284880; x=1762889680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJTDMIYCy2+6jR/hKcOnnxfENzi0WCsvGq1H0Tr1Gd8=;
        b=eAFtIC+l2x7gxD+7kimg6alL/dxUm31F81a2p9iBrYmiPUvXBSmdrR1uVemXRHncnH
         7vlHe+SQAHZzeIPq50jjXNAcpb9gukcQmMox46IF1QwaDYphtSyvv+8OPAU+pzXXGcxW
         9hJsjo3ZfcDVJ3Ado3emJ3MngEcqz9zvLa9LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284880; x=1762889680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJTDMIYCy2+6jR/hKcOnnxfENzi0WCsvGq1H0Tr1Gd8=;
        b=QGVXX0ES0oET0I2iIfMzgOwu+yJ7NvPipAHjmD18F3Bu4n8sD1d8XsWWwk+C7OnPca
         wao3CxyYRisK0Bl8qSUDmYbjbqT2XzwSbzYMCg+FPD4CD89wrzOR7rw9nywyyXIAfbz+
         JApGmHR/PQvfHcgXdkXad2WQtjgOp65rOL3uBZ1fkQA7wHuBhEiCEYdICuyDNEi75uul
         4yySWj1IVLLYdk2fKmNXnhp16AQZR1yjz6l8GpTAt9BRomsDbVaMTMhrOqeKheo7obRP
         dHwQnrOJGADgO2590EOwzqqKw97yMQKoBDW0otMaPMW2mPN7lCwagrLjm3pQcT4v4+q5
         4Rdg==
X-Forwarded-Encrypted: i=1; AJvYcCVXyUmT3FarOVYvoxmjhr/+4c6QjYpEOjzbnqhRGacB/b2XokBixd3JcPj63r40kt8gDBhCg7HUxpjKzQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLv1Ja16JChuX6s5oW71f1NzwnFTSEaIkNWRF9nWtFkvZmGT3i
	SaurBoCcnlkTdK/7hJudd9JugLEMsBJMWKoyRNmdIVLghy+jhGvXlvwz9LEPa6k9ulZQxRD//Qo
	ymJu0yghWgA==
X-Gm-Gg: ASbGnctUs0OYEahH6U7kkB2aqugZFb2JPuW0qodepwId/2ktu7x99Z1/EVU/b55H+w7
	IoMAyluO40FL0fKGpPGmqmCEy0lCPeHTVyHgAEUTSEN7m50UQlEZJjT2tnTPkNR15//mG79gmYs
	HYI8maCqwrJqrKZpBcJvvekfTFFUqm/mKV+S6iFDxYBbB420V3JWfUP79+Z6QGBnDzHk1oQshB6
	tNradUIaE+U5woifYKPhuuRtgwbhcGCxENNJ8QDvdfgjawbSsiG1K72aohHEzlTUE5DZk33yudM
	AMftoOmqjVnS/eLSGTLMUz+IvTd3sQOlIu8tZQ7ioGkMAebx3NVgfHb4HAAYxCocGcY65JLkybI
	0ucHWJ8W8yKkoGMdI8aCk5aH3cVNw9eTbHZxZU64Y0ra6R4F8pZsfPZnTlJyPnYIikYoxSYfRNb
	ronX1WocW80M1KCjxpS/xv+ZfWzlCltDXZLhynCaXRcw8SoZ6kfw==
X-Google-Smtp-Source: AGHT+IH6TKdWn+qpQ9tIC0F36IRj7/XX2IDddpaiIS2Ze0yYDJA8BG3YTivvV+tdKQedvIOYax1GPQ==
X-Received: by 2002:a05:6402:26c2:b0:640:aa43:1595 with SMTP id 4fb4d7f45d1cf-64105ca97c8mr327794a12.38.1762284880410;
        Tue, 04 Nov 2025 11:34:40 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e78f8985sm2647175a12.27.2025.11.04.11.34.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:34:39 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7200568b13so284289366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:34:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3BG4Wg6vkK1tgoeEYIAyFAK/+gefCYASMnUIfeFQ7LpFO8VeoyiZ8zdHfWTIIxNYxbMEVJSQn7Xz1g0A=@vger.kernel.org
X-Received: by 2002:a17:907:1c0a:b0:b45:1063:fb65 with SMTP id
 a640c23a62f3a-b7265587595mr27576366b.39.1762284878155; Tue, 04 Nov 2025
 11:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <aQozS2ZHX4x1APvb@google.com> <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 04:34:20 +0900
X-Gmail-Original-Message-ID: <CAHk-=wgYPbj1yQu3=wvMvfX2knKEmaeCoaG9wkPXmM1LoVxRuQ@mail.gmail.com>
X-Gm-Features: AWmQ_blVf2isOH-EeyNpLShBliAIq3Vx5qa1nvwuHS5khsUBXtzT-rTUMVRjBpY
Message-ID: <CAHk-=wgYPbj1yQu3=wvMvfX2knKEmaeCoaG9wkPXmM1LoVxRuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Sean Christopherson <seanjc@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 04:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sadly, no. We've wanted to do that many times for various other
> reasons, and we really should, but because of historical semantics,
> some horrendous users still use "__get_user()" for addresses that
> might be user space or might be kernel space depending on use-case.
>
> Maybe we should bite the bullet and just break any remaining cases of
> that horrendous historical pattern. [...]

What I think is probably the right approach is to just take the normal
__get_user() calls - the ones that are obviously to user space, and
have an access_ok() - and just replace them with get_user().

That should all be very simple and straightforward for any half-way
normal code, and you won't see any downsides.

And in the unlikely case that you can measure any performance impact
because you had one single access_ok() and many __get_user() calls,
and *if* you really really care, that kind of code should be using
"user_read_access_begin()" and friends anyway, because unlike the
range checking, the *real* performance issue is almost certainly going
to be the cost of the CLAC/STAC instructions.

Put another way: __get_user() is simply always wrong these days.
Either it's wrong because it's a bad historical optimization that
isn't an optimization any more, or it's wrong because it's mis-using
the old semantics to play tricks with kernel-vs-user memory.

So we shouldn't try to "fix" __get_user(). We should aim to get rid of it.

             LInus

