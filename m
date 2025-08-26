Return-Path: <linux-kernel+bounces-787266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3CB373BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18225E1470
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35912857C7;
	Tue, 26 Aug 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S66LS8vx"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E428312F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239477; cv=none; b=uaDiV6fsNqJATmpAqRzHQdmz1hjbiDpN/sBdKCjh4fmPn4Y4BAjHH6y2l1O6hrAWwhlkL5YMl/MIu3xBIG/YwDD1w9Q0T2r2dA6KMO5k++7TupC0x4c2Rm4+3BoGtR52OHm44s9JziyOP1NidET2uAZdJzcMK0aO2NsUmqAhYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239477; c=relaxed/simple;
	bh=5XRRsdgjE4lzuZEUEoTbtsUWRNyb44t1W8cJ+KHoUOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAqcAfUUEa8tWEFPj/j5blfNPwq9uB3Lo8c0zLSzGE4E3jm8raL76qUuSlEiRNabF7aRsjHnS1E1aZR2XHlsJ7t+Es93by0yCVrsstz10yJM3PgM3EF2CFqrPOPm86SDK2LeBRKoPHSr/WRp1TVlqDXImsZAQbcEsIcOfzEqDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S66LS8vx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756239463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbSH0Oapxw2Trya4zNcHzUE/2tqS906hfE9HlUqqOr4=;
	b=S66LS8vx6NIWhJPdUa5aFrGyV4a6B65o+9UtQ1/8fgEdxhBKkFdJizaL6V8Zk72Oyr/j01
	6P4LXcaQMwkZvUPtxpZV/zEK/rWHtCLY7mocLMFRxQpDujRQWfnYguZ8BVMRzGF4+Ux9wo
	YAcA10PqfyhcDhzxTgi4ntVLfyISIKk=
Date: Tue, 26 Aug 2025 13:17:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Content-Language: en-GB
To: Andrea Righi <arighi@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822140553.46273-1-arighi@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250822140553.46273-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/22/25 7:05 AM, Andrea Righi wrote:
> Some distributions (e.g., CachyOS) support building the kernel with -O3,
> but doing so may break kfuncs, resulting in their symbols not being
> properly exported.
>
> In fact, with gcc -O3, some kfuncs may be optimized away despite being
> annotated as noinline. This happens because gcc can still clone the
> function during IPA optimizations, e.g., by duplicating or inlining it
> into callers, and then dropping the standalone symbol. This breaks BTF
> ID resolution since resolve_btfids relies on the presence of a global
> symbol for each kfunc.
>
> Currently, this is not an issue for upstream, because we don't allow
> building the kernel with -O3, but it may be safer to address it anyway,
> to prevent potential issues in the future if compilers become more
> aggressive with optimizations.
>
> Therefore, add __noclone to __bpf_kfunc to ensure kfuncs are never
> cloned and remain distinct, globally visible symbols, regardless of
> the optimization level.

I tried with gcc14 and can reproduced the issue described in the above.
I build the kernel like below with gcc14
   make KCFLAGS='-O3' -j
and get the following build error
   WARN: resolve_btfids: unresolved symbol bpf_strnchr
   make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91: vmlinux] Error 255
   make[2]: *** Deleting file 'vmlinux'
Checking the symbol table:
    22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_strnchr.cons[...]
   235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_strnchr
and the disasm code:
   bpf_strnchr:
     ...

   bpf_strchr:
     ...
     bpf_strnchr.constprop.0
     ...

So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strnchr.
For such case, pahole will skip func bpf_strnchr hence the above resolve_btfids
failure.

The solution in this patch can indeed resolve this issue.

>
> Fixes: 57e7c169cd6af ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   include/linux/btf.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9eda6b113f9b4..f06976ffb63f9 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -86,7 +86,7 @@
>    * as to avoid issues such as the compiler inlining or eliding either a static
>    * kfunc, or a global kfunc in an LTO build.
>    */
> -#define __bpf_kfunc __used __retain noinline
> +#define __bpf_kfunc __used __retain __noclone noinline
>   
>   #define __bpf_kfunc_start_defs()					       \
>   	__diag_push();							       \

The llvm does not support __noclone so __noclone is noop for llvm.
I tried with
   make KCFLAGS='-O3' LLVM=1 -j
and the kernel is build successfully and also the kernel can boot properly.

So ack the patch:
Acked-by: Yonghong Song <yonghong.song@linux.dev>


