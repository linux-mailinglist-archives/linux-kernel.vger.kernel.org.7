Return-Path: <linux-kernel+bounces-826563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F25B8ECF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DB4179AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6692919C546;
	Mon, 22 Sep 2025 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3k47kb4"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC114A60F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508972; cv=none; b=RcPnD1Dbn3bAxF/KULImlHls4dXzQf1QJiGmFlWPHzPhCiwqJWJd8ChZOSPPDyCsrh87cgzt+VNfQTNehrrbWZwIa1NUcSDRvz9vbVb9N6CjJN5IA1xhjt4Yg/7US1e2V7oR/L9O0f1cI9mMiZp9EvUoYMbxsh0u1RBTj1YwbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508972; c=relaxed/simple;
	bh=/1cGLZSP8kaxfekkX+rPZuAIkcebERioAH2+cpf7ehM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emiq10dwdL38A2BBr8gfKuRJmMnrWgZvOZM84TUImK311RrnlRJAbmlYvuRd0z3C4f6VtzLUohFQHrvn5oZ0pc9M0zjnyMuj/Tq6rVH4LYEM0R4UUm6YwCG/oBJhohm9L9J7kHHe6uNMhkMP9aQf5ChJu0ZkD71vPjv1UnOeXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3k47kb4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5516255bedso1947756a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758508970; x=1759113770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpGBhjyC/fsnWKELi2J+xDResCrP6qtwTx78RLf5cPk=;
        b=k3k47kb47RA3kKZ5d2k/U+Y+LrCu6JS+0HLkHzRvRqYW3Y0CnXk0Vu+WAehtAA1SfR
         h2RTTph1C9MqlrPBa/B8g7uLbUlzJh3YZjV2Uq6LDLUnmabKtxdbQDJj+TOTN9sGS6SJ
         oxomDT5x4QogG5iwOExM9P9xOTR9Lj6PZQeekg1fML8L9B/AdOutfrQt0jeTDdT5zqzn
         19cQxi7GR6tFUGq6GcammWNVXBKX8VCtyKka9RR7daj4RiZBvZmJrwY31CXvl1zMhfvV
         Qj8AFp7Q5e/cvX51PLsZ3V9vEFRzsrCkvIVQ3VJ0DArTxwPU9sLgGKlkH1N1tVNsH2W+
         BCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758508970; x=1759113770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpGBhjyC/fsnWKELi2J+xDResCrP6qtwTx78RLf5cPk=;
        b=C4KDjQmK0VS+nBSEVnJYui4UVzIoDNtHSx2ay5UbZM5FhEI8yZKkH2U8QxqnWdZU24
         UqLDZ9SljE0fl6qF4r4wruZjNEB+Pp3j4RgSfY5PeassNoE/3cfadXpbE17LXlB2+o34
         ZWaRyBmdSjKsELFANkg8P9mPj3ukrk7X1/cUl8vd/EYXDTY26kkNrWi+/1ANjmerwEXO
         CR9wJGyp4cPLpDx7OI5SqrHDzkzRjjJQUxkNa/96z9FkJdm5d6kUu7g6RTWuXg3tojFZ
         VoLbKKQGlKgzGKzbMOjehsYA+yL0UyXfQKKLd/ZXtsI6xST1JmwKj/cSko4qlVg03hYa
         ff6g==
X-Forwarded-Encrypted: i=1; AJvYcCUWXKta/PYpQlB2IdAb6LkWT20HQYtyroJBFdE+M4ebLSFmYFG6VrdZ6ItrSyMhlz5+mNW/aI/WS4eQIKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTouvjkTnmPukk9xtoQn7gC5yfa0OkaEF0r0hr3KSye3p4+KzT
	INGkND0F1pmZ87I51hzR1rWw5xNQIZAa7eqnsahgejjebOnmIxnyaXzv
X-Gm-Gg: ASbGncvFOKj9szaqFe6IuZI6Cj10ixBBAYmyGEUh6EVo7jOcOMTAHHW/Zb4aeTlXDkh
	0pK7ukhX3S/TiGve84f65q7z0TGenKy81kpy2yKohDC6RzzV/4562NH3tzsxTrYHClfk9Y3bs8K
	gdxAKISuIKeBsdjNLCA5M2UEFM87OLocoqA76UkIESFpFKjsG+MgMC+H4Lx3xtyukUcogTjt7v2
	vO/MLKA2sqoGe0D3DTXpbAoS9V3nVb/1cpNGG6gxIgkfRkWdllU5aIfZGsltH9+5ojFwveqMQNb
	pLxtcdw95BzUKszBnMu0rLC5b5M1e5YlYBQCvGuKGUV66CX9FF4YBcWleXJ0PIaCBp2WUelIxOW
	dGXxEo6/Er08KPCSbg9uOgOvqPtxFgIjckSd/bLMNSmiznQ==
X-Google-Smtp-Source: AGHT+IHRdzjR6lUNTVj0Tu1hJGVqYFIE8OBxpwn+ueG5Q8Sftr4UcpyZwJYiPtnZcxdst+qlMwzlzA==
X-Received: by 2002:a17:902:e742:b0:246:441f:f144 with SMTP id d9443c01a7336-269ba5688b4mr128039495ad.56.1758508970548;
        Sun, 21 Sep 2025 19:42:50 -0700 (PDT)
Received: from [10.22.65.172] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf11sm115029975ad.34.2025.09.21.19.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 19:42:49 -0700 (PDT)
Message-ID: <f1d2d0fc-c541-4acc-b5d6-34f2bba37aea@gmail.com>
Date: Mon, 22 Sep 2025 10:42:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
Content-Language: en-US
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250920155211.1354348-1-chen.dylane@linux.dev>
 <20250920155211.1354348-2-chen.dylane@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20250920155211.1354348-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/9/25 23:52, Tao Chen wrote:
> ...
> test_stacktrace_map:PASS:compare_stack_ips stackmap vs. stack_amap 0 nsec
> test_stacktrace_map:PASS:stack_key_map lookup 0 nsec
> test_stacktrace_map:PASS:stackmap lookup and detele 0 nsec
> test_stacktrace_map:PASS:stackmap lookup deleted stack_id 0 nsec
>  #397     stacktrace_map:OK
> ...

As they suppose to pass, they are meaningless in the commit log.

Please describe what the test is for and what it is doing instead.

> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/stacktrace_map.c | 22 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> index 84a7e405e91..7d38afe5cfc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> @@ -3,7 +3,7 @@
>  
>  void test_stacktrace_map(void)
>  {
> -	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> +	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, stack_key_map_fd;
>  	const char *prog_name = "oncpu";
>  	int err, prog_fd, stack_trace_len;
>  	const char *file = "./test_stacktrace_map.bpf.o";
> @@ -11,6 +11,9 @@ void test_stacktrace_map(void)
>  	struct bpf_program *prog;
>  	struct bpf_object *obj;
>  	struct bpf_link *link;
> +	__u32 stack_id;
> +	char val_buf[PERF_MAX_STACK_DEPTH *
> +		sizeof(struct bpf_stack_build_id)];

Nit: minor indentation issue here.

'val_buf' should stay on a single line, since up to 100 characters per
line are allowed.

NOTE: keep inverted Christmas tree style.

Thanks,
Leon

>  
>  	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
>  	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
> @@ -41,6 +44,10 @@ void test_stacktrace_map(void)
>  	if (CHECK_FAIL(stack_amap_fd < 0))
>  		goto disable_pmu;
>  
> +	stack_key_map_fd = bpf_find_map(__func__, obj, "stack_key_map");
> +	if (CHECK_FAIL(stack_key_map_fd < 0))
> +		goto disable_pmu;
> +
>  	/* give some time for bpf program run */
>  	sleep(1);
>  

[...]

