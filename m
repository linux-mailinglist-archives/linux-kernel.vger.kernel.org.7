Return-Path: <linux-kernel+bounces-796545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB1B4024E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A8A3BD55B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED02DCF69;
	Tue,  2 Sep 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrwYiCTC"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F12D59F7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818669; cv=none; b=H8KGyTq9oyrQYhH2FAyUfdOqATiBAx5s+e3TYWW6FM7qosdJydE8VGY++eu5TN+o0/RVB025jgrluUQ65zEpDWHJ3VVZWOc0Tmv72GqhWPuZZ3xqor5CeIKto5V0aMfAoEaxUqFaMuWXyLj0vM6dhxY1W4GxnmAWpevGKixH7yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818669; c=relaxed/simple;
	bh=a6+7H71onDG4ZfaCBC69FB5SY12ev/7tff0d25FMAG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQbZz1hndvO2nFmPn3pOJtScM08o8vNeyIZMWCVKrT7EWFzBkHgef4XF1sExN5qbcH+Su4Bav8+n0Z4C49KTIzDVYu/nedn7lovhKMKcaE0/oLLle8M9jGBCteQkTHPzMwq6G6ptZcAonT7Rn6iVpE/Ra4tOi/X49X8nrXS8lCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrwYiCTC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445824dc27so48895375ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756818667; x=1757423467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm8LYWgbBbSoxzsUxJyqmS94JWyK2thOVWLaY84JeS8=;
        b=WrwYiCTCGAvJoqUkACxFSAvaOAK1GOH+8zPJFwD/tJD774Fw8WQwHKtDnm6akDx657
         Dh7aFqvU/h1yOy+7b6+vEDQPDzvAVdF8RtiCpIBaLLFdUNTwr1EhjJAt6bN+dHoCRE63
         h3nQHod5hLtAxcVId3lcuKv07lzqyvxC1tW610L5r0ZyoRdUsi+snlT0nY0RIF2xntU0
         pWIj7CZMsYrCp1XG8mvg1RSk2ifF6zC6g/ckPzMXTIZ620hjfdC3Y5bJOqlC8r44qpt1
         fvoD7Q4D/fGAWBHVhbo+euC7hIn6VoNsDM4CqUzlk+QraRDnuj68sngJC0z5IB+GNwfU
         LTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818667; x=1757423467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm8LYWgbBbSoxzsUxJyqmS94JWyK2thOVWLaY84JeS8=;
        b=AshlfESsi0bzAzQgTpY/NIFHpmxwXy1l0yKwl8HE0Ej2+5xIGR3guo6uOLrDPhy1WY
         iEXulK6ADIEoRENNCpVSAcn8PIzKWxPQon5u+LDVcmkivdvV5doqMoyeEUgey/cPG/FY
         2yzwgT9x2LT23NbQuG7FkJUf6cEP+7+Zsjcz2C7C1pkvpUDT72KzqHXQjoHH/ikKwmhf
         ZYMeZeJtcYmsXSzsPqwWwKYCe4tFw5sr7Y6VuH/0jRP66ve7ThNROQgDEPRgp5Lab5XS
         TGSQcaiW0M5nei2jDjVdZQIhSxo56BYyFAwDKQQyGwchqA5tKuBojlBpYY1aKmNyocMF
         Zy6w==
X-Forwarded-Encrypted: i=1; AJvYcCXbNqzsxoAVi0oJ5pSxzURtIYMS1Gs55VZoDpl6NyrtoSuUx9UCguatCv6/W5lIjRAPDoTuwvk1AXmH9V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lo1KoOFB4a3mkTtIpz4+RXO+Q0nKCBhfWO/tkxnXYrwPsWiR
	vTiDNP+wIBELJ8pyKYKJYZNM5wmqfpcZFiNM8EAfI2yx1mzNSA1LiNv75ZzEupSUBdjk7Ah7H1B
	ymJ7ljRNCNeTpZBnj2kHf8NF3XBU6EfTnDDQfoLKN
X-Gm-Gg: ASbGncsTM+cgThvqUFAmfUAG4ug79ydrm7/BCq0FCE0/7NA+Zp0HL3aG9RfGJ6b4vRV
	pOLnqiY9TNk6c42hege3lptMfk5F/5U3CEYs9yMWjnM+k78sJue0+mA8B907TkKFd6Ef+5zGk7q
	8eGT6ux9oRutsQLWb6V5e+rJ9Gn/FfPsnKjjT/9axZ+JgkXj7wftHYr/rk1a19w6roeTFUByrrx
	js9KF8uAQ2o3r4zIhcnsMph98SZgvfYB0a8
X-Google-Smtp-Source: AGHT+IEajt5n7miuhpVNgaVc7Q6fAs6vdDGW7Ft6PJ5otEsVyTncI7dUQga6YoFZNasinGVO2qLjbv1bEw5pg8a7acU=
X-Received: by 2002:a17:902:ce03:b0:248:cd0b:3454 with SMTP id
 d9443c01a7336-24944873445mr133817985ad.9.1756818667376; Tue, 02 Sep 2025
 06:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902073841.2338568-1-abarnas@google.com> <aLaypTjukJJloGuL@stanley.mountain>
In-Reply-To: <aLaypTjukJJloGuL@stanley.mountain>
From: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Date: Tue, 2 Sep 2025 15:10:55 +0200
X-Gm-Features: Ac12FXwTsBas7UmElXIeqiXIRz_1zSROWnkOhZSndPGsKtOskJgJVh0CaFvpYhg
Message-ID: <CAATBrPEsea2GfK26W5eg4ZFm=hJLO1pLNax85vvXZ8hb=iGaFQ@mail.gmail.com>
Subject: Re: [RFC] staging: media: atomisp: Simplyfy masking bit logic
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> These are supposed to be opposites, right?  Subword and inverse Subword.
> You could dress them up to make them look more opposite.

In fact this name is misleading as well. For me it should be named
`clear_subword()`. It is zero-ing the "subword" provided with low and
high bit boundary (start, end), to be then easily replaced with binary
or operation.
And this operation is not an inverse of extracting a subword using the
subword function.

> The problem is (and actually with the (end-1, start) above that it might
> generate a really bad code on some CPUs, so I really, really prefer the w=
ay
> when _at least_ one of the parameters is constant.

It would be  easier to create a bitmask sing GENMASK_ULL and just
reverse it but if it is not safe, this is what looks fine for me and
works the same as previous function:

// Added a helper to create a mask
static inline unsigned long long subword_bitmask(unsigned int start,
unsigned int end)
{
        return GENMASK_ULL(end - 1 , 0) & ~(GENMASK_ULL(start, 0) >> 1);
}

/* inverse subword bits move like this: MSB[xxxx____xxxx]LSB ->
MSB[xxxx0000xxxx]LSB */
static inline unsigned long long
clear_subword(unsigned long long w, unsigned int start, unsigned int end)
{
        return w & ~subword_bitmask(start, end);
}

Best regards
Adrian Barna=C5=9B

