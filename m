Return-Path: <linux-kernel+bounces-883744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22DC2E3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9C394E25E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFE3002D4;
	Mon,  3 Nov 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFOBzJy+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CE19A288
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208343; cv=none; b=Z2Ov5WoFaCvvxlqzLkBUKNFoQ3zO+5ASSSCpIcPFAFWnNXu5OHw8CoeB5He6KUgGIe8pVeC/wLFeovfGSJqhThtH4PpK6qI3Kp5AwdGqTnTa9OTd+GrrxevzAvwi2fQPQtLJ8NnF/uDt94wjMZRLGNyXUcQuRR75Kp4HuJuh6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208343; c=relaxed/simple;
	bh=Qd0PE1Rs6KEWNdoTb5m4PqCdzDcUkr71JoeguUvCzBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/dDJuy49UwAwro3qtg0rZkVMd7N230cKlI6bNIZ3YTg+Fy7npMkOEY9QDsm0t17BlEgRkynmhlLPFpFvzWAlEFlLnXrlkHVmkBTeuHl6Ch6zuMut00iOttkjjrAyDH96h8zkcxLmpQGpYjo/u+Pv7fRx0m9u+3p+LqDzBM6oSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFOBzJy+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47114a40161so939385e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762208339; x=1762813139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MBSZMkbxxZJ1gtP8k5ceMrKm0u9CL1gti7+ICrCG4k=;
        b=jFOBzJy+yUtV258q9tENvakIr6Tddgxo7mqJBtf41LnEJ28naG8J6xfVKkKHE6iMp4
         ThjpuVC6Xri9nl7QXJsxa5yJ/0D/eoaa+7ZutxgF32KxehYPA00DMo3OwctTl0U7Sq0m
         7hvxFQQOlrnlOtdCIMXa0Rfkt90ToEZQjFVd1DA2gqxXxuJ/Bf6dii4k8dopylmEAf0l
         W3179Mk2DpJXjsD/6mD2uV9L4+2sEYmgHsFbkgkhg5ZEie980eGeimK57wRc4Dr8eb+O
         eqpGb64X4vAVQNElDXFkvc4rKDxQULF4uM+8XUOQgHRb4ny2hfn6nFlBqaNsJqrw6HiO
         rxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762208339; x=1762813139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MBSZMkbxxZJ1gtP8k5ceMrKm0u9CL1gti7+ICrCG4k=;
        b=X/PAsE02lloJa2hRPTdWCNaRFmtMzLI/RKIwMqep9gO+uStM6qA3P+Q1wcdFRTBqv4
         GEaWkjHY7JTEk1lydl9BTmEv/jR8r8arfO7nbyXVlAqn7IWKSB2XJOtjF9q8Ccynrjwd
         eXjaqk4RXlUD0z6ZGKvDv1sFdc62oMUbwxE/4WcjdFf3RmjfRsBPVudYKzVZiCiG3cVe
         uRF62LFoVbN5LDu0IQMV9g1okEUWS0igyq8Cf2tZeOBe9FsyvpalRLXFumhkUQKQyiXS
         jcHOoa1l1GboOmzo/3wjFxO+HWWDBt8trbwfB9tO8uD37dk/nrkBw67mpz8nzaKOj5r+
         HW7g==
X-Forwarded-Encrypted: i=1; AJvYcCUHCc3hp9SUWJx0xHAAWcqwUPCqHUJl5qm/gDYlC9zDMSohg5YS4n7K8SjcPTnbWTcK19w6olsMLz9e/18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxinGbGUkZjFniFcas6ZwCFGrLAToik38k4WWbliHZgqaJS9Zjk
	5305SdXhN6EXk/lxksEdwg0rPDfiJqBQgN9VfrEGsdetzkb1u4ySKp75
X-Gm-Gg: ASbGncu4ZKUp4GE4qoHr8Vomu4elafnW9yEcmWeRLo1jXXwjBckdF35payJKwlBoIfJ
	0tVzlAhH2ZnFILFgLUhWdueo+K897IJ9yXTS1NGGxHh7RSXOf+c+ISSfjN4+YZdc7tltLyJmuG3
	IAxoqJ1Jz0j5XebEWRMIeBBB9DLJsid4t9oBojZfNwEpP1N2Jcs1DHgUKH89hRYUARSlylwJWHf
	M9Zwp5q6Kb84wRxq8xGus3aajCOvOIG3E58UZTLeSD9Bx1gqjC9MKmjb1SXd9BVUb/aghJKKJbO
	79ulnfvcvZ4gj3fBSYbHiuvRiYvjFluxwNfwBVkSzKOYoBeOcitAWBCdPNi6NfDMomgt/nxZ9+P
	QxcPbuOZ4NjfpMURB4Eyw9A+IWIBD3TaYbNJzq21VAwwoIok7EIQXwllR7wcyOXSCfwVEuUgEqe
	Y6JsslG+2vabU7AFaGuXS+JRKlnDXfgufP4RriL120qaSix1cdKrk4
X-Google-Smtp-Source: AGHT+IFzpbpSBm6GlQ7wzFwsxE51trySjE9fZe9wa1/WRmwwIqlL6XEj3/eS/DX3Tjwr7N90r3+Eaw==
X-Received: by 2002:a05:600c:538e:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-47730813571mr124826945e9.18.1762208339245;
        Mon, 03 Nov 2025 14:18:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f5easm1111425f8f.10.2025.11.03.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 14:18:59 -0800 (PST)
Date: Mon, 3 Nov 2025 22:18:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] base64: Unroll the tables initialisers
Message-ID: <20251103221857.1acaf6ab@pumpkin>
In-Reply-To: <20251103190510.627314-1-andriy.shevchenko@linux.intel.com>
References: <20251103190510.627314-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 20:05:10 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Currently the initialisers of the tables have duplicate indices.
> This prevents from building with `make W=1`.
> 
> To address the issue, unroll the table initialisers with generated
> arrays by the following Python excerpt:
> 
> CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
> 
> def gen_table(ch62, ch63):
>     table = [ 0xff ] * 256
>     for idx, char in enumerate(CHARS):
>         table[ord(char)] = idx
>     table[ord(ch62)] = 62
>     table[ord(ch63)] = 63
> 
>     for i in range(0, len(table), 8):
>         print (f"\t{', '.join(f"0x{c:02x}" for c in table[i:i+8])},\t/* {i:-3d} - {i+7:-3d} */")
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/base64.c | 115 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 102 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/base64.c b/lib/base64.c
> index bcdbd411d63b..0a7c15c5c1b6 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -21,20 +21,109 @@ static const char base64_tables[][65] = {
>  	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
>  };
>  
> -#define BASE64_REV_INIT(ch_62, ch_63) { \
> -	[0 ... 255] = -1, \
> -	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> -		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
> -	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
> -		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
> -	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> -	[ch_62] = 62, [ch_63] = 63, \
> -}
> -
>  static const s8 base64_rev_maps[][256] = {
> -	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> -	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> -	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> +	[BASE64_STD] = {
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*   0 -   7 */

You need to use -1 not 0xff.

> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*   8 -  15 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  16 -  23 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  24 -  31 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  32 -  39 */

Nothing wrong with [ 0 ... 39 ] = -1,

> +		0xff, 0xff, 0xff, 0x3e, 0xff, 0xff, 0xff, 0x3f,	/*  40 -  47 */
> +		0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b,	/*  48 -  55 */
> +		0x3c, 0x3d, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  56 -  63 */
> +		0xff, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,	/*  64 -  71 */
> +		0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,	/*  72 -  79 */
> +		0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16,	/*  80 -  87 */
> +		0x17, 0x18, 0x19, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  88 -  95 */
> +		0xff, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,	/*  96 - 103 */
> +		0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,	/* 104 - 111 */
> +		0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,	/* 112 - 119 */
> +		0x31, 0x32, 0x33, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 120 - 127 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 128 - 135 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 136 - 143 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 144 - 151 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 152 - 159 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 160 - 167 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 168 - 175 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 176 - 183 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 184 - 191 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 192 - 199 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 200 - 207 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 208 - 215 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 216 - 223 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 224 - 231 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 232 - 239 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 240 - 247 */
> +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 248 - 255 */
> +	},
...

This is impenetrable crap...

	David


