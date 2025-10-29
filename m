Return-Path: <linux-kernel+bounces-876921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C249C1CC79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057963AEE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361835580A;
	Wed, 29 Oct 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NCyyY+Y4"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245322DBF75
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762387; cv=none; b=WT3k3kmfYOHUBTbUguYmYKMT/ZcK1Rl9aKqILwv6CjUTPmcvgGhg6POlcZfMZ57uA3CZjr9MdF6+7CNHa8WL5L6mIuF6RdtK/OSenDStnvZQpqPekWywvrVc+UL9Z/COe2PEIcAtoJiaHioOWgaxizxSJmQxWRd1De1y6ZY0oFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762387; c=relaxed/simple;
	bh=48lU2XwUj7ZdpGh5mFN0ZdZZRp2phHUCYLeljLJmF4M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ft4GFxtOHCo0LZrguRq8XJiKBWfs0lz2DDqk0xnZ1fRmkVBQ24VK1W1lLszTLTJC2qO/7A3HHy6qN2mLDYnS3VTTwFj90p3MuNsX/XsR1VwpL+UUlL/krXC5L5Yw0vk48nTiXm9E10NlsQLqr0g/VffuREYRWxcm+1IiukRJjRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NCyyY+Y4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e88cacc5d9so985161cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761762384; x=1762367184; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ueQMFfRBEdYLINs8O5Q/wJZxZX3uYJRDpH6DN2nZSdc=;
        b=NCyyY+Y4Jm1dEBpAYdQXjjexqC6T3EjzKdq9ar+n3MopP/XNiXE6hhBRDbKdiSUZFw
         N6x3lGjUpsxlYbbfx0/cfIlQpvVpi/guSc1FcptD84BQv/KLKfAEr5EcgvDFdcwFHr0v
         TzjiDB5XaOUJG2CEp6SiNUBgn8kN4c82mENwgIjZe3PHyjsJGLghhHzF//7yXGYdpYlB
         KMau3wFiJo5R8NIifyQJLa1vmunTfMLl9KfsLxMks0P7zbkpAKLVS37Q0HSUThr78TAX
         bGuAnXZ+pOW1m/HmYiQ/TiO4/aqznWOVjoxeroVTpe0gFBZlFXx/UBKqJZJT6VxwyWTF
         UNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761762384; x=1762367184;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueQMFfRBEdYLINs8O5Q/wJZxZX3uYJRDpH6DN2nZSdc=;
        b=DORqa7lPGl2BvdDHfrZ7wWJJ+iyXb5Yt7F7B1OJ/simdUISjdB/78LFQfNJeIaLyyY
         +LWiLWorvYAmlaZ0UBUmnKeeKFi5qscTw63J7Kw23VbS8LQgv6xTa4V1OitGeO76zl0t
         2T6SlNslUv7yBD40eDb42HGLPEBK+B/elvmBSMWgR4uIgvY9A0E0fIi2Hn/ToIE0Zd6n
         OB90tD1HyyXM4sYOvIIesk6GO+Ak7IFLH7KkeCG+Bbb4Et4eewPG6mCln/DnKu4ApndA
         pQJHFzTD8A/uaCDDPBdBFPSuR+K5XOxrwBNkui1TvFf7HXR4broaEmr8W6sIRs0Zd/gb
         4RqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ol17/fVt4MT0LClyxsrcofiqtTZN+LU+V79e1TyDH7atC6cwOc2Ov0e//V8hijs7jKhxuookPSOEqt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQnysTFSEO/RcbQAxFZLTMf45DvsyjljYTsSVrQVJjs+9PYK7
	wYe3J/I/pYx6LbSIfG9gV5SpLguhRpbVpp3hepfKzLi1nGZ4mhjHwGhAYMKbBZtzV00=
X-Gm-Gg: ASbGnct2ScI7UM50k2Vc5x4YzvNq5gq5amFJDYIhSmiZLQZ0yYP08FZ2zFaGpCXD+rc
	R4auOscd/OuFMj3c1Lt6jzLOdIeueXcZCoHaW+Epj0CwFUwXB+NIeuK8YgqyKtyu+38FixHosJc
	t1fyi/rHGn0TFRTmUUSJ3xRSHE3K6n+odDoZWZ4LUWA+M6rtud2V+DVI+tch62ahioYj8JhYIhE
	2ZL2UebKP12FwSs5RXZJzmyeHZXVXtSn7kc5ZdZ/klxhIY3qi6p92Kzq1rlFzDlxwZSsZ/cxIk9
	AtHaRt2b7+MMeD9VKFwL4wmRUAs1U5pKaZ5RFkkhOrfDUajdYxxfvph2uv9tFpYvy97qYTYvXtG
	f8kOemmZK+y49uVaUD3f53PU7jLZIwU1fRZiRNmW9SIzkxv5hYP/tL2Mpsfgec0Xe+ytaryueBp
	k/5p1o27OVJfAVQ3s0fOzS5ATXDjOT2w==
X-Google-Smtp-Source: AGHT+IHiviyPGkTFcCyOEjKleoRI/v4lQYI61KZvIQKi8h767pohNZGJQhlKpxjetXvSQaf1w/Rrhg==
X-Received: by 2002:a05:622a:349:b0:4ec:4630:18c1 with SMTP id d75a77b69052e-4ed220d4bddmr5786981cf.2.1761762383580;
        Wed, 29 Oct 2025 11:26:23 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25c8c71bsm1090809485a.47.2025.10.29.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:26:23 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:26:21 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, 
    Yu Kuai <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, 
    Jens Axboe <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 5/9] lib: Add tests for
 mul_u64_u64_div_u64_roundup()
In-Reply-To: <20251029173828.3682-6-david.laight.linux@gmail.com>
Message-ID: <rq53orop-1429-2rro-5644-992s788q2s6q@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-6-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> Replicate the existing mul_u64_u64_div_u64() test cases with round up.
> Update the shell script that verifies the table, remove the comment
> markers so that it can be directly pasted into a shell.
> 
> Rename the divisor from 'c' to 'd' to match mul_u64_add_u64_div_u64().
> 
> It any tests fail then fail the module load with -EINVAL.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
> 
> Changes for v3:
> - Rename 'c' to 'd' to match mul_u64_add_u64_div_u64()
> 
> Changes for v4:
> - Fix shell script that verifies the table
> 
>  lib/math/test_mul_u64_u64_div_u64.c | 122 +++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 49 deletions(-)
> 
> diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
> index 58d058de4e73..4d5e4e5dac67 100644
> --- a/lib/math/test_mul_u64_u64_div_u64.c
> +++ b/lib/math/test_mul_u64_u64_div_u64.c
> @@ -10,61 +10,73 @@
>  #include <linux/printk.h>
>  #include <linux/math64.h>
>  
> -typedef struct { u64 a; u64 b; u64 c; u64 result; } test_params;
> +typedef struct { u64 a; u64 b; u64 d; u64 result; uint round_up;} test_params;
>  
>  static test_params test_values[] = {
>  /* this contains many edge values followed by a couple random values */
> -{                0xb,                0x7,                0x3,               0x19 },
> -{         0xffff0000,         0xffff0000,                0xf, 0x1110eeef00000000 },
> -{         0xffffffff,         0xffffffff,                0x1, 0xfffffffe00000001 },
> -{         0xffffffff,         0xffffffff,                0x2, 0x7fffffff00000000 },
> -{        0x1ffffffff,         0xffffffff,                0x2, 0xfffffffe80000000 },
> -{        0x1ffffffff,         0xffffffff,                0x3, 0xaaaaaaa9aaaaaaab },
> -{        0x1ffffffff,        0x1ffffffff,                0x4, 0xffffffff00000000 },
> -{ 0xffff000000000000, 0xffff000000000000, 0xffff000000000001, 0xfffeffffffffffff },
> -{ 0x3333333333333333, 0x3333333333333333, 0x5555555555555555, 0x1eb851eb851eb851 },
> -{ 0x7fffffffffffffff,                0x2,                0x3, 0x5555555555555554 },
> -{ 0xffffffffffffffff,                0x2, 0x8000000000000000,                0x3 },
> -{ 0xffffffffffffffff,                0x2, 0xc000000000000000,                0x2 },
> -{ 0xffffffffffffffff, 0x4000000000000004, 0x8000000000000000, 0x8000000000000007 },
> -{ 0xffffffffffffffff, 0x4000000000000001, 0x8000000000000000, 0x8000000000000001 },
> -{ 0xffffffffffffffff, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000001 },
> -{ 0xfffffffffffffffe, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000000 },
> -{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffe, 0x8000000000000001 },
> -{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffd, 0x8000000000000002 },
> -{ 0x7fffffffffffffff, 0xffffffffffffffff, 0xc000000000000000, 0xaaaaaaaaaaaaaaa8 },
> -{ 0xffffffffffffffff, 0x7fffffffffffffff, 0xa000000000000000, 0xccccccccccccccca },
> -{ 0xffffffffffffffff, 0x7fffffffffffffff, 0x9000000000000000, 0xe38e38e38e38e38b },
> -{ 0x7fffffffffffffff, 0x7fffffffffffffff, 0x5000000000000000, 0xccccccccccccccc9 },
> -{ 0xffffffffffffffff, 0xfffffffffffffffe, 0xffffffffffffffff, 0xfffffffffffffffe },
> -{ 0xe6102d256d7ea3ae, 0x70a77d0be4c31201, 0xd63ec35ab3220357, 0x78f8bf8cc86c6e18 },
> -{ 0xf53bae05cb86c6e1, 0x3847b32d2f8d32e0, 0xcfd4f55a647f403c, 0x42687f79d8998d35 },
> -{ 0x9951c5498f941092, 0x1f8c8bfdf287a251, 0xa3c8dc5f81ea3fe2, 0x1d887cb25900091f },
> -{ 0x374fee9daa1bb2bb, 0x0d0bfbff7b8ae3ef, 0xc169337bd42d5179, 0x03bb2dbaffcbb961 },
> -{ 0xeac0d03ac10eeaf0, 0x89be05dfa162ed9b, 0x92bb1679a41f0e4b, 0xdc5f5cc9e270d216 },
> +{                0xb,                0x7,                0x3,               0x19, 1 },
> +{         0xffff0000,         0xffff0000,                0xf, 0x1110eeef00000000, 0 },
> +{         0xffffffff,         0xffffffff,                0x1, 0xfffffffe00000001, 0 },
> +{         0xffffffff,         0xffffffff,                0x2, 0x7fffffff00000000, 1 },
> +{        0x1ffffffff,         0xffffffff,                0x2, 0xfffffffe80000000, 1 },
> +{        0x1ffffffff,         0xffffffff,                0x3, 0xaaaaaaa9aaaaaaab, 0 },
> +{        0x1ffffffff,        0x1ffffffff,                0x4, 0xffffffff00000000, 1 },
> +{ 0xffff000000000000, 0xffff000000000000, 0xffff000000000001, 0xfffeffffffffffff, 1 },
> +{ 0x3333333333333333, 0x3333333333333333, 0x5555555555555555, 0x1eb851eb851eb851, 1 },
> +{ 0x7fffffffffffffff,                0x2,                0x3, 0x5555555555555554, 1 },
> +{ 0xffffffffffffffff,                0x2, 0x8000000000000000,                0x3, 1 },
> +{ 0xffffffffffffffff,                0x2, 0xc000000000000000,                0x2, 1 },
> +{ 0xffffffffffffffff, 0x4000000000000004, 0x8000000000000000, 0x8000000000000007, 1 },
> +{ 0xffffffffffffffff, 0x4000000000000001, 0x8000000000000000, 0x8000000000000001, 1 },
> +{ 0xffffffffffffffff, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000001, 0 },
> +{ 0xfffffffffffffffe, 0x8000000000000001, 0xffffffffffffffff, 0x8000000000000000, 1 },
> +{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffe, 0x8000000000000001, 1 },
> +{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffd, 0x8000000000000002, 1 },
> +{ 0x7fffffffffffffff, 0xffffffffffffffff, 0xc000000000000000, 0xaaaaaaaaaaaaaaa8, 1 },
> +{ 0xffffffffffffffff, 0x7fffffffffffffff, 0xa000000000000000, 0xccccccccccccccca, 1 },
> +{ 0xffffffffffffffff, 0x7fffffffffffffff, 0x9000000000000000, 0xe38e38e38e38e38b, 1 },
> +{ 0x7fffffffffffffff, 0x7fffffffffffffff, 0x5000000000000000, 0xccccccccccccccc9, 1 },
> +{ 0xffffffffffffffff, 0xfffffffffffffffe, 0xffffffffffffffff, 0xfffffffffffffffe, 0 },
> +{ 0xe6102d256d7ea3ae, 0x70a77d0be4c31201, 0xd63ec35ab3220357, 0x78f8bf8cc86c6e18, 1 },
> +{ 0xf53bae05cb86c6e1, 0x3847b32d2f8d32e0, 0xcfd4f55a647f403c, 0x42687f79d8998d35, 1 },
> +{ 0x9951c5498f941092, 0x1f8c8bfdf287a251, 0xa3c8dc5f81ea3fe2, 0x1d887cb25900091f, 1 },
> +{ 0x374fee9daa1bb2bb, 0x0d0bfbff7b8ae3ef, 0xc169337bd42d5179, 0x03bb2dbaffcbb961, 1 },
> +{ 0xeac0d03ac10eeaf0, 0x89be05dfa162ed9b, 0x92bb1679a41f0e4b, 0xdc5f5cc9e270d216, 1 },
>  };
>  
>  /*
>   * The above table can be verified with the following shell script:
> - *
> - * #!/bin/sh
> - * sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \4/p' \
> - *     lib/math/test_mul_u64_u64_div_u64.c |
> - * while read a b c r; do
> - *   expected=$( printf "obase=16; ibase=16; %X * %X / %X\n" $a $b $c | bc )
> - *   given=$( printf "%X\n" $r )
> - *   if [ "$expected" = "$given" ]; then
> - *     echo "$a * $b / $c = $r OK"
> - *   else
> - *     echo "$a * $b / $c = $r is wrong" >&2
> - *     echo "should be equivalent to 0x$expected" >&2
> - *     exit 1
> - *   fi
> - * done
> +
> +#!/bin/sh
> +sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \4 \5/p' \
> +    lib/math/test_mul_u64_u64_div_u64.c |
> +while read a b d r e; do
> +  expected=$( printf "obase=16; ibase=16; %X * %X / %X\n" $a $b $d | bc )
> +  given=$( printf "%X\n" $r )
> +  if [ "$expected" = "$given" ]; then
> +    echo "$a * $b  / $d = $r OK"
> +  else
> +    echo "$a * $b  / $d = $r is wrong" >&2
> +    echo "should be equivalent to 0x$expected" >&2
> +    exit 1
> +  fi
> +  expected=$( printf "obase=16; ibase=16; (%X * %X + %X) / %X\n" $a $b $((d-1)) $d | bc )
> +  given=$( printf "%X\n" $((r + e)) )
> +  if [ "$expected" = "$given" ]; then
> +    echo "$a * $b +/ $d = $(printf '%#x' $((r + e))) OK"
> +  else
> +    echo "$a * $b +/ $d = $(printf '%#x' $((r + e))) is wrong" >&2
> +    echo "should be equivalent to 0x$expected" >&2
> +    exit 1
> +  fi
> +done
> +
>   */
>  
>  static int __init test_init(void)
>  {
> +	int errors = 0;
> +	int tests = 0;
>  	int i;
>  
>  	pr_info("Starting mul_u64_u64_div_u64() test\n");
> @@ -72,19 +84,31 @@ static int __init test_init(void)
>  	for (i = 0; i < ARRAY_SIZE(test_values); i++) {
>  		u64 a = test_values[i].a;
>  		u64 b = test_values[i].b;
> -		u64 c = test_values[i].c;
> +		u64 d = test_values[i].d;
>  		u64 expected_result = test_values[i].result;
> -		u64 result = mul_u64_u64_div_u64(a, b, c);
> +		u64 result = mul_u64_u64_div_u64(a, b, d);
> +		u64 result_up = mul_u64_u64_div_u64_roundup(a, b, d);
> +
> +		tests += 2;
>  
>  		if (result != expected_result) {
> -			pr_err("ERROR: 0x%016llx * 0x%016llx / 0x%016llx\n", a, b, c);
> +			pr_err("ERROR: 0x%016llx * 0x%016llx / 0x%016llx\n", a, b, d);
>  			pr_err("ERROR: expected result: %016llx\n", expected_result);
>  			pr_err("ERROR: obtained result: %016llx\n", result);
> +			errors++;
> +		}
> +		expected_result += test_values[i].round_up;
> +		if (result_up != expected_result) {
> +			pr_err("ERROR: 0x%016llx * 0x%016llx +/ 0x%016llx\n", a, b, d);
> +			pr_err("ERROR: expected result: %016llx\n", expected_result);
> +			pr_err("ERROR: obtained result: %016llx\n", result_up);
> +			errors++;
>  		}
>  	}
>  
> -	pr_info("Completed mul_u64_u64_div_u64() test\n");
> -	return 0;
> +	pr_info("Completed mul_u64_u64_div_u64() test, %d tests, %d errors\n",
> +		tests, errors);
> +	return errors ? -EINVAL : 0;
>  }
>  
>  static void __exit test_exit(void)
> -- 
> 2.39.5
> 
> 

