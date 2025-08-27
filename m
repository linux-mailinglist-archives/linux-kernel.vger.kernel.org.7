Return-Path: <linux-kernel+bounces-788715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A75B3892B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CD13A7A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE02D838B;
	Wed, 27 Aug 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVwOwXQY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C82D7DEB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317541; cv=none; b=cjDV0bFld96n19huly8qt9h9PgZn7HH8c6aBBPNJxcqXbUddwmbF/4c/BD7smmp0rxH916D9J9c8HhcfvBLHIhO6WbcWw6+XdCCRuFQQHTHt9C+vDK5x5F3X46GFo8xDZ6sg8V2f1Pf0YLCWNonJabL4jzaAZfq9IPUgHl/A5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317541; c=relaxed/simple;
	bh=qM07M6YX83zAu1MJFTJWRYrFha6NM53dS1++QwRW8Xg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VwrJd7QH8estFBSNYjRPZ4H3EZ3zoCjWeBEbs5c+7H0+YKc9eDnOD+25PgiQnan6mCnOTgygCQH9r8XUS/smpDaH+lLP72lRA4q3VDbPJsljxKB1cg/Y41gB3ofkENImbDSIzVaiCMUwVG5W9uE58RJXLZO7cfyekdhXSdRO5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVwOwXQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756317538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68zTd9ybMYa+9LcXDQYMsbuSzuPSYGRrvVBPkMTfky4=;
	b=HVwOwXQYMpIHat+8S4uYaNfX54HQ+Ey6XHQ24v1ssLwmYMVRCTP2Awc59usiRTS/fxedsR
	7pYMxvdOwbJFQMcHUclrPPvpJFaYDztzXvcWpEwap3AweUXml8lsRNSf/WeSVQVoNnu1UD
	sM9MMKcblGB9O/TWndFfvA8PM+PmbzE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-SVFADXrOOau7w9dodkgj4A-1; Wed, 27 Aug 2025 13:58:57 -0400
X-MC-Unique: SVFADXrOOau7w9dodkgj4A-1
X-Mimecast-MFC-AGG-ID: SVFADXrOOau7w9dodkgj4A_1756317536
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71e7181cddeso638967b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756317534; x=1756922334;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68zTd9ybMYa+9LcXDQYMsbuSzuPSYGRrvVBPkMTfky4=;
        b=vIpnvrt8qd1DHwruwbdWG9by7njNnm4Tjus9L+N3jpEJvIXUVTsq8sCpHKuVyAwJjE
         sNbhDkBI7rmbmOjd0HmoZF8XGStNz6IUWgdGpdieXvouq+H4Wyi5eTWrP5DBeUhaOIPH
         eVXd8jDQ+EyGjdPqtAnjDOxpVuSfWC2Y/AG0biGEMRi5ZMlEaEsf1pOK/YdT/cR2KgXU
         mTppdsBjIl9jMtq5kdKNpYJidb6g7Sb2LEkA25zz5T0nitQrWDh0LyhLjxATgZe/5wCt
         K47ITChRRB4G0rIjwAbCQTf8ZAqkleo1iolHtX2KAmkYBfH8eueTfRt8Z6I9q6q/2S7x
         FzXg==
X-Forwarded-Encrypted: i=1; AJvYcCUFNe+Fq0ZjK+A+YzCGNM9Iv2O3VyFs+EePA+176UzBfn1AjM4u81ZYge1nJ4U4pFyrQfgsEHJFwkj1yN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNexSEFCcWxkPGc4vIhJpTh3fj5aZtO2hqORBvP1f7qIkOgyTc
	jBqIYO8QUIfhPlFCxZ+R0Hw+jtiE5pJ1/PdnoCHSY9jnPJEVKPAmHQQBVl9srTqvua6aqm/oBVO
	/nlpMUX/0EIVrUdYskuHk2KROzy1/I01P5isKCEc99rE2vRMq2aZy5vESB+bXnvH3/w==
X-Gm-Gg: ASbGnctxCnu3qN6Eo+filaf4Sny5TKzOUAm7PBJ1vGnHLv/d3TvcjgF5CuNJFAKXOuG
	HBAwQGy8x3AIDGmn9Jm1XHz+p6mqisFxwlp7wEVpZ7FWzC9LquGCoNxh2QuPW445PySN22qU3ju
	DvAnfZPDYlo0256EMIyf80qUuFbBcatoJ3C0YWGsN02r1Gfs00nr47zQKlunUdTFSwQMkyoL9Qm
	xngoBU0+U9L+vpqSltOzpHH0kxW+f1nhiFH+rt0hp8PliofAPzAeqNXUdW5HWIsC4zvLDmHGUex
	tEfnYQdE83eDU43kPFyZJNkeHznElyJcoFnH4e0xROWGLw9S4hLVajGw/bFWy4p8Uelqv9rVC47
	I2zb5C/SZEw==
X-Received: by 2002:a05:690c:d96:b0:721:1d52:1989 with SMTP id 00721157ae682-7211d523da1mr99240777b3.28.1756317533659;
        Wed, 27 Aug 2025 10:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdT+RZwBJztTIfOFsLMwmdt6wt8HAm15gYADw5Qx7LUh/r5SyBZcKwlrd4mhwQThimE9Yenw==
X-Received: by 2002:a05:690c:d96:b0:721:1d52:1989 with SMTP id 00721157ae682-7211d523da1mr99240227b3.28.1756317532998;
        Wed, 27 Aug 2025 10:58:52 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721307edf15sm11492567b3.74.2025.08.27.10.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 10:58:52 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
Date: Wed, 27 Aug 2025 13:58:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
Content-Language: en-US
In-Reply-To: <20250827154420.1292208-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/27/25 11:44 AM, André Almeida wrote:
> The "Memory out of range" subtest works by pointing the futex pointer
> to the memory exactly after the allocated map (futex_ptr + mem_size).
> This address is out of the allocated range for futex_ptr, but depending
> on the memory layout, it might be pointing to a valid memory address of
> the process. In order to make this test deterministic, create a "buffer
> zone" with PROT_NONE just before allocating the valid futex_ptr memory,
> to make sure that futex_ptr + mem_size falls into a memory address that
> will return an invalid access error.
>
> Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> This patch comes from this series:
> https://lore.kernel.org/lkml/20250704-tonyk-robust_test_cleanup-v1-13-c0ff4f24c4e1@igalia.com/
> ---
>   .../futex/functional/futex_numa_mpol.c          | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> index a9ecfb2d3932..1eb3e67d999b 100644
> --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> @@ -143,7 +143,7 @@ int main(int argc, char *argv[])
>   {
>   	struct futex32_numa *futex_numa;
>   	int mem_size, i;
> -	void *futex_ptr;
> +	void *futex_ptr, *buffer_zone;
>   	int c;
>   
>   	while ((c = getopt(argc, argv, "chv:")) != -1) {
> @@ -168,6 +168,17 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(1);
>   
>   	mem_size = sysconf(_SC_PAGE_SIZE);
> +
> +	/*
> +	 * The "Memory out of range" test depends on having a pointer to an
> +	 * invalid address. To make this test deterministic, and to not depend
> +	 * on the memory layout of the process, create a "buffer zone" with
> +	 * PROT_NONE just before the valid memory (*futex_ptr).
> +	 */
> +	buffer_zone = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	if (buffer_zone == MAP_FAILED)
> +		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
> +
>   	futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>   	if (futex_ptr == MAP_FAILED)
>   		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);

This patch makes the assumption that consecutive mmap() calls will 
allocate pages consecutively downward from a certain address. I don't 
know if this assumption will be valid in all cases. I think it will be 
safer to just allocate the 2-page memory block and then change the 2nd 
page protection to PROT_NONE to make it a guard page.

Cheers,
Longman

> @@ -229,6 +240,10 @@ int main(int argc, char *argv[])
>   			}
>   		}
>   	}
> +
> +	munmap(buffer_zone, mem_size);
> +	munmap(futex_ptr, mem_size);
> +
>   	ksft_test_result_pass("NUMA MPOL tests passed\n");
>   	ksft_finished();
>   	return 0;


