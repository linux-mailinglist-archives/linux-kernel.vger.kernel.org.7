Return-Path: <linux-kernel+bounces-749656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDEB1511A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869403BB3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC4218AC1;
	Tue, 29 Jul 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oyfStBAT"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE414884C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805868; cv=none; b=VJJTOe2acUpTE8/38+ni0mVKe3sod78yVr25gdj1ynmjJQf+WyUUChovCS7uFK83IPa0x3bQ878Vdb6D8/uHocj9knTRJAkcPJAf4MAUstX2i9dJu6gFRlGgbz1RspxR0nCfI/84afhiRTn9C62sAnT8NJq4P0taq9gVDLCDFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805868; c=relaxed/simple;
	bh=bVgH+SpuX+NCU9F7+EKXDKOmUz3J7ttGLL5lD772tIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRiWx763oiQRRjKu65gI/QPm9oO0UqDdmcBZzCGmI0cuifCNR0Fqm6KJ4Wcjvg/xOpSsBQeshtEqUCjnlXvR5RaRqda4MsBX84HMFy0405EESberyvG6yj+RX3Yrpva29aGKeed54YICnZrpCy/WS2Z85gWuuI7A42rEtlJpmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oyfStBAT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49c6b3ba-7860-4b13-944f-5f503eb201fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753805861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74sXRGTOX8kdRi1jglu/lI9ORb7qfgWFF96WpXKXhYs=;
	b=oyfStBATK+qsm07X/dRfKVqu+egzFqlF+z/NNgyqW2lPYU6gsjGJM9iXiCdNkFJCLugxW0
	s2/wmtTqLuhK9UjIgFFctJjEhOWlV45DoN9CSYV2QIyZRYawJMEAvRi8odHpRvNa+5YQBr
	hFOgsZF0plKGgoXlkn7k4sZqUcPbXJk=
Date: Tue, 29 Jul 2025 09:17:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: avoid possible use of uninitialized mod_len
Content-Language: en-GB
To: Achill Gilgenast <fossdd@pwned.life>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Viktor Malik <vmalik@redhat.com>,
 bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250729094611.2065713-1-fossdd@pwned.life>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250729094611.2065713-1-fossdd@pwned.life>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/29/25 2:45 AM, Achill Gilgenast wrote:
> If not fn_name, mod_len does never get initialized which fails now with
> gcc15 on Alpine Linux edge:
>
> 	libbpf.c: In function 'find_kernel_btf_id.constprop':
> 	libbpf.c:10100:33: error: 'mod_len' may be used uninitialized [-Werror=maybe-uninitialized]
> 	10100 |                 if (mod_name && strncmp(mod->name, mod_name, mod_len) != 0)
> 	      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	libbpf.c:10070:21: note: 'mod_len' was declared here
> 	10070 |         int ret, i, mod_len;
> 	      |                     ^~~~~~~
>
> Fixes: 8f8a024272f3 ("libbpf: support "module: Function" syntax for tracing programs")
> Signed-off-by: Achill Gilgenast <fossdd@pwned.life>

The code itself is actually okay. The error is triggered due to'maybe-uninitialized'.
To silence the compilation error, I think this change is okay.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/lib/bpf/libbpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067cb5776bd..fb4d92c5c339 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10086,27 +10086,27 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
>   	btf__free(btf);
>   	if (err <= 0) {
>   		pr_warn("%s is not found in prog's BTF\n", name);
>   		goto out;
>   	}
>   out:
>   	return err;
>   }
>   
>   static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
>   			      enum bpf_attach_type attach_type,
>   			      int *btf_obj_fd, int *btf_type_id)
>   {
> -	int ret, i, mod_len;
> +	int ret, i, mod_len = 0;
>   	const char *fn_name, *mod_name = NULL;
>   
>   	fn_name = strchr(attach_name, ':');
>   	if (fn_name) {
>   		mod_name = attach_name;
>   		mod_len = fn_name - mod_name;
>   		fn_name++;
>   	}
>   
>   	if (!mod_name || strncmp(mod_name, "vmlinux", mod_len) == 0) {
>   		ret = find_attach_btf_id(obj->btf_vmlinux,
>   					 mod_name ? fn_name : attach_name,
>   					 attach_type);


