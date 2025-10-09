Return-Path: <linux-kernel+bounces-847326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51263BCA898
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD033A94A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA442244677;
	Thu,  9 Oct 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a8NiOtDZ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6B225A39
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033358; cv=none; b=EmYbmRT1vameePCLzMYFDOeVNNy9j3TnPmyJO5iJ+Wb9b0B+yaw/YGmsbVgBpbvNFXyHOyEiNyokgX6H8+MAV4s9XApQD8GHtfTbTh0jLLMXEsZMV5SW0ksx1pjNFtylJFBkL0r73PmTr/5MBwx7OsFsns02CTqT9McYoHF6Rzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033358; c=relaxed/simple;
	bh=rHrHFKDIXB+Hg0YmzbmR1rzmL1IsBh8r96zV1Wl4vlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EChj2RzUuTWnzVsCD/teLaBZAFE2FBoAGCZZviHIudGmdnBXj56ITo2zO903wls9aSg2I/crRd8gai5iXX9GcAUm/4VcpcN+W2X/I21m92vYNu/2cEpz1W0rq87U2dEv+PIQUwJCfBGyd0ZeJzk2aXqXQOUWjk/uaOd2G4nJ1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a8NiOtDZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4736e043f9so183506366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760033354; x=1760638154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivp4f6TYndCVNWeU6nsb0GGYxvEVlx6N0Z1qdzq6Yco=;
        b=a8NiOtDZGoZ+VeaQKKn0c/IJAK4ts1LwqIZlxsIHabFv3kvh9Zk+/qlpVYSuXIbZSx
         CUIV1aubyJtUR2iM3QM2/+kbla/2Td14U4UmqUqLzKtXsrgBnUB5yLUNCKyuqzmKs9HD
         R3+ctZlbRiRueGCK0bK5K6hzfy5Z1t+R5KEXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760033354; x=1760638154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivp4f6TYndCVNWeU6nsb0GGYxvEVlx6N0Z1qdzq6Yco=;
        b=tualh5cVLP7NtCNkvhzNwnlZn9ODf9zgv59wF+JsDchsigygbXaU2oJA+W2zWDxoMD
         mXxICYOGzCZDnxzpN9+s3wGQi3KmP4JMlmOdNGKeuo0cdeTvro7HuGi76Jqpl9wb41Wv
         3dI0PDQcdjr65Ab1v6mzhhw9BlnzvkXIdrb8Q+OdfQjIapezqCalDf+O3JB1qicjWILG
         ILxdjenyq3hw5FiQAYOLZXAPKXC3VMdEMHhkwZVPMWA3mlhnN6eJ1vIoMmarDUfW26KO
         DpyZ4wCM7c4LvSuShxzIPapyCFptQtNq3jqtcoMltOQZKsM51AQgvGBmLWkOVeR5Vbhy
         QAXw==
X-Forwarded-Encrypted: i=1; AJvYcCXLWqlrMWMnxxuZsuxbw0yHxGck8O13BMBTrgF3U092zzzEBXx57PklMSmSyR68xjsKGm5pNmJ0Ag/EdrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuC45cGsEYLg4rLwjyYvD/bh4AwMWfsEIAlF+5a3loyj04N3j
	xD9grH5nGeQa/RcVkdxc5nkOpgzCdu4Yi7ASIf+BslrNjOD7JnLhiNxjjdtfDbk/FfORNt5jEXO
	lLvUXgJA=
X-Gm-Gg: ASbGnctv+TZi6a2yNj1jCV4a4tcaYZNfuT1T22o/eDkr+HoMZ47ivnJLuZYX3THt1OE
	6eMce3uuRajmLGsXFJliG3jq+Huo6PjMsdw3H8ERRJPN7jpp8WCcyo8l47aFvyxA8VpszFYCV/D
	vUF0M4GsPu/ToasBE3ZwyTOvg21E5rJ5VGVEVjoW3bvD7H4uSeCchauJIoAbHScd9alJtzH+CNG
	+k+7uLBBhRLmEaIE8P58U6w8S3BzLcWlFfuLQwnxqNbGHIcc8ZmPCZhegEzM73qDIcIfCPbF5E7
	aZaVJQmkjW4lQNOPG9m/hNL/gAi0pZ9VEsRvCSD+t4gubI+xfA0iGBlds7BCHFL2jLNCS/Hgokq
	l5ZSsjBpLmdrniaS84yjTXgBKaJpbLrKpjg/ZtA7y1MhCGwUSVA60T0nWAUmYmMQfPRHtc0LIdt
	tDnKOjhsdvwG+1jeE3cjnIJRLkqGIPtTQ=
X-Google-Smtp-Source: AGHT+IFDTiXwcOXkoNHHVVsGta04iT21uJle+rt997hBTTgcF01LayWIFpOQsEnEC9Wst8EwN5sBMw==
X-Received: by 2002:a17:907:7e88:b0:b3f:b7ca:26ca with SMTP id a640c23a62f3a-b50aaa96b30mr893244366b.21.1760033353962;
        Thu, 09 Oct 2025 11:09:13 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67c9b68sm28215866b.32.2025.10.09.11.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 11:09:12 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so1860164a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:09:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA1gYS4h2QkpWhE58ZY77OIbJuSw6IPTouO/zno5VMJUmRCwTlwQx4/2cog406QX2d/2/iFG5B2nDrRdY=@vger.kernel.org
X-Received: by 2002:a05:6402:57:b0:636:6801:eed7 with SMTP id
 4fb4d7f45d1cf-639d5c5a767mr6448801a12.32.1760033352025; Thu, 09 Oct 2025
 11:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009131240.3363697A73-agordeev@linux.ibm.com>
In-Reply-To: <20251009131240.3363697A73-agordeev@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 11:08:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB4OTWTDf0oEkWtWEms8KY0KNrwMj5x+NhhTbAUGy-DA@mail.gmail.com>
X-Gm-Features: AS18NWCKrCSUgJkK3SzlTaV7D8pRpwBhRtFw98jE6dWOIBVAFHIJLlAe9kYHNOY
Message-ID: <CAHk-=wiB4OTWTDf0oEkWtWEms8KY0KNrwMj5x+NhhTbAUGy-DA@mail.gmail.com>
Subject: Re: [GIT PULL] more s390 updates for 6.18 merge window
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 06:12, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> - Remove superfluous newlines from inline assemblies to improve
>   compiler inlining decisions

I've pulled this all, and this commit probably makes the generated asm
look better to humans too, but I thought I'd just mention that quite
often the solution for "compiler does it wrong" is to just use "asm
_nline" to tell the compiler to just not count lines of asm at all
(horrible "count instructions" heuristic)

Because often the asm may be multiple lines due to things like section
directives or out-of-line things like exception table entries etc.

In the kernel, we almost never have truly *big* inline asms where not
inlining things would make any sense at all.

In fact, it might make sense to just make "asm inline" be the default
"asm", and do something like

   #define asm asm_inline

and if somebody *really* wants the compiler size heuristics for some
case, they might want to use an explicit __asm__ for that.

But from a quick look, we really have very few larger "true asm"
statements. I found some disgusting "write the whole function as an
asm" cases for alpha, where for some reason it wasn't made into a
separate '*.S' file, but that was a top-level asm, not even inlined.

Sparc has a few cases of "33 mulscc instructions in a row" due to
horrendous instruction set, and I found a couple of bigger "copypage"
implementations, but none of those actually struck me as "the compiler
shouldn't inline this".

Everything else I saw was in the "handful of instructions" range,
possibly with extra noise due to section tables etc.

All of which makes me go "we shouldn't have to even think about the
compiler not inlining these things".

             Linus

