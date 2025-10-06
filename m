Return-Path: <linux-kernel+bounces-843520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FAFBBFA40
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843AD189B7AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578541E1DFC;
	Mon,  6 Oct 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MQNrYicc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9C1A4F12
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788590; cv=none; b=fkKzjaSQX61qqX1MxpO/0zXId+ZthoTLATsfql1agX2dtBvKsBD+KTxU8uxxzeyniN1uZ6xjTWXXGeMjHqC+k26uGKcWPwC/TL6nl+HoKOQ9w98oKKzOFPnr0/i301xTHdm5ffIo/JfMQatrQABqUvEhBPa2mVYzIjAa2WDChtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788590; c=relaxed/simple;
	bh=CHD0J+xjJcGVkTXfHKoo2fZhpHdZNaSK3j/FMipOEMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBt+lSHlm3U+KMFbqxOlZ1Q8KrcXmLY0ldyYuvzAZf7E58AQxEVDjwxl+fy63jgfBmzv8pBjW7b75yoK84s9Kovn4eUbsArLKldMYk68n3NYfzONrKZAyNg7GT+soOB7ILKaHIf2XHC37jlYHFYXWOy3ClKpDLtt+vsHG6IIKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MQNrYicc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so6418087a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759788586; x=1760393386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uGao8D5BSZy4tBpGeUoA8r3hr67oWCrLy7wILsVxn4=;
        b=MQNrYiccnbRmVexS/vtUBcAEVKuzNy0x44Z7LGDqdca42nJ6wzsjeWqZXDU0pR0CD/
         3c8fIgeRcw08DgKVoofHRn8YRy0fSkytM+9tvPHn+Y6Z34q+IJtUYGSvTjNotNtI+2nY
         mQwUCtnwALOIyJRlreO7EOQ2bacM5AWVMC0a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759788586; x=1760393386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uGao8D5BSZy4tBpGeUoA8r3hr67oWCrLy7wILsVxn4=;
        b=fPCU42gj872CP9o5kL67LEXEXU9CABoCC7q1fiOrfjdj0iBwkogbT1rzs23d04aWpy
         hkHju3N1diRB6Zl6YmSwFUNti3hMHA59/yOaysY77/8nfnDJlyRGmZadwsXYSXzAaFw0
         4axf6O8n1QGgvdUT6Zi0i6hmG7smhv7rfcPfLyfd0R0YFkzz6y8yTZ7H8dJpjvUUqXkj
         X1SHT7Sf2n+qw1bB7Z4wYQaOWyENYRtdSxmeOOj6BtEVIvVuKvd0MAL47aFcflNlsgr+
         VOB/T0xFeEev1ZQoJwSSA13kcWOvTAmjQirLSIfVmwGt7BF6iB9CVe/HSghLunz8RkH5
         8ChQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHUi3ZuAqegd56MXDT7sDoSw1vqkgjzm5/F+U6kNHd8LIhJ11jGUSJvETfQH7/Fil2D7afCRdDQ0FpaRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGXufkIcYdBwf/0B9TS/E68uR7Ex94jE5VdNQarK6dc7rD70/
	eSJ+mT8guyveZX+joh4i86L4SLk6Q+PnnuF0h4A7F6RyFLjK/vSAIXwndVZe1JkPrhiIGQ2THAu
	vOCBdpzs=
X-Gm-Gg: ASbGncvMDzkrIOM3VvDpmVbwK6pjPvC9qghIRV09Vss+tbhkofBFYH6AT+ZL11HdC66
	63pd/1TOrhozdh54Q1CiE1IzR37Ix4Dj3m2qRLCuCQGBc6t78M5X8D9k4259ruKlb8fmQssz+Rt
	ZEPxNLy8DLUjUzLyvveQHnkyE8bvtjxV2Shq7JR2t+fINlC5zI2FIfnneJnKfBCsu2NCaGuE9kr
	DZEXpO1RM8T+Tw3Mpg8cQgdTS4a2WupdXJfEVnKVAhDuvNL3BXTgZECkKvMdKbRAW4EmCsEZ5xY
	0HowOuAeBJvqb7JC2x/WSpC0rhD0np5s3gqfgEhxdUgtpZZ3ffJ0/lswL4cH4BdJEVyG0vDmz9l
	NvDGgObAXld0K2g92P3oPdkR4GxuWRsfzOUya9dw4xsIRaa/9OIZKtzLuZLKg6PgX6SlHuSg45X
	2lve91w9ovvZosvTbvK47k
X-Google-Smtp-Source: AGHT+IHM8iXzrJqualShbYQMOtyFXpUi241vbc1mwh/EbxE0kIF9yiDnXpSnBrrz9Sm1Vj9dvnkHOA==
X-Received: by 2002:a05:6402:34c6:b0:638:1599:6c34 with SMTP id 4fb4d7f45d1cf-63939c24f04mr14265733a12.21.1759788586573;
        Mon, 06 Oct 2025 15:09:46 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6397c9355c3sm4630770a12.0.2025.10.06.15.09.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 15:09:45 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so6418038a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:09:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNPgKMVUZ2EREe71krmO5ZGqpnAuSksIc/LJZX9cf8dj2BFKJQfSyB4vMOK86tVFFWWsRmGdGpvsODooI=@vger.kernel.org
X-Received: by 2002:a05:6402:34c6:b0:638:1599:6c34 with SMTP id
 4fb4d7f45d1cf-63939c24f04mr14265679a12.21.1759788584720; Mon, 06 Oct 2025
 15:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOKTFv1vh1cvvcLk@kernel.org> <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
 <aOO3NKegSrUQ4ewg@kernel.org> <aOQ3V6M-wWQxxCWK@earth.li>
In-Reply-To: <aOQ3V6M-wWQxxCWK@earth.li>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 15:09:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEszQD56Q2EZ83EhzJK+OnqPaAkUavfPWako2rA8Z4uA@mail.gmail.com>
X-Gm-Features: AS18NWC-seoJUwFefSk_kijwQa6IpywQiR1JR3Kf97fiLCY3_kM93cgcwAVjtWw
Message-ID: <CAHk-=wgEszQD56Q2EZ83EhzJK+OnqPaAkUavfPWako2rA8Z4uA@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan McDowell <noodles@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 14:40, Jonathan McDowell <noodles@earth.li> wrote:
>
> I'm not sure _reads_ make sense for the TPM device files at all. It's a
> command + response interface.

Yeah, I won't disagree. My main worry was one of "existing users doing
odd things shouldn't then get new semantics"

I don't actually _expect_ people to do odd things wrt /dev/tpm and
friends, but I've so often been surprised by the odd things that do
happen that...

> What should we do if we get O_EXCL and O_RDONLY? Return an error? Ignore
> the O_EXCL flag?

Either of those likely is perfectly fine. Just ignoring it is the one
that adds the smallest possible ABI change, so in that sense it's the
"safer" option.

But you are probably right that there aren't any users that open that
thing read-only in the first place, much less then using O_EXCL.

Except I've seen programs that "work" by virtue of having done
entirely the wrong thing that just happened to work. Things like using
the wrong values entirely for 'flags' to open(), but the bits we cared
about happened to be ok, so...

And we have *traditionally* very much ignored O_EXCL when not paired
with O_CREAT (and even then it's iffy with NFS).

So people might just have random crud in the flags. That's why I
reacted originally: O_EXCL does make sense as a "open exclusively"
based on the name, but realistically we never actually *use* it that
way except for block devices.

So we *have* had those semantics for block devices, and they make
sense, and I don't mind the change at all per se.

But this is the kind of thing that I react to just because we have had
unexpected behavior in the past when a bit goes from "don't care" to
"meaningful".

Put another way: I'm probably just being unreasonably worried.

                     Linus

