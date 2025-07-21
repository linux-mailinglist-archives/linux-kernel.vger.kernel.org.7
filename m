Return-Path: <linux-kernel+bounces-739931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C735B0CD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A2917A644
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645E24169A;
	Mon, 21 Jul 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKyn+GZC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC831D63E8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137214; cv=none; b=ruKYhUN+KXkHLnEiIhzvUEgTLXRO4bm0TCmrAhkMphmUf5E+R6vQWfgL6c3tIignID5xayMqKXEklTEnjMuWG3BOcvS6F8nC6k6Pf3roxFh//NaAcONR1bivdg3Njq3opIfccAwMJjTJ3QNHUoGzVN4rGt4A4yho5XxBbfRD9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137214; c=relaxed/simple;
	bh=j+5u8vKRU9Y5ARArhCBRv5xODAIyRFp69Xa+IjrJT14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGr2cWe3t5Gm6lD6bZFiBrCRSNN9SlDXTXKR22WZVB5ASQ23kIXhzLCSHihdUfqRQVE7Kq0flaXWUx5sHTAoC2Lqgu9hW93SIBHhKXRRk0yjDSFvd0GzWzdZqLNuThee25bupO54yQQK3TURxaH2j5KOsz9GY0iUtYxxjeI4N2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKyn+GZC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753137212; x=1784673212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j+5u8vKRU9Y5ARArhCBRv5xODAIyRFp69Xa+IjrJT14=;
  b=cKyn+GZCjrky3P+YL4FnDc27nX5lVzR68J0bh86vFAkkhM26lFZEwMZB
   vhHN8mFA08Oebs3MnpxTTPyTmrW5nNEI4tF4Zf4RHkJc8eyrsGBqjMNIV
   m+qGLitP0qPtrvjT6LSJuBv+bbyr7gUgUkwHOLQpIFdMBvDF+nSubmxN7
   IZprYE620JMwnb0+sEkLlb2neDO37aGncIq0t5xRD4nW7w6GngrxCm7TO
   2SNGle8FuIof1DGw/jNq6308eFDqBqavX14uxBB5OMATYv1Wa9qgszEl3
   /Vb0HLQAwf9IfawY3fx6fLPUePnpIrg3npnMTXOFvurbVySUhCdQhpK9J
   Q==;
X-CSE-ConnectionGUID: qeDZ3OirQYa06cqNemFOCQ==
X-CSE-MsgGUID: jsXSEqBjTjGSrEO48FKg6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="80814900"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="80814900"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:33:31 -0700
X-CSE-ConnectionGUID: soMqseb9QdW5t9kHBULtWQ==
X-CSE-MsgGUID: vSW18LGcRaScKZjc4XClvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="158264433"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.108.89]) ([10.125.108.89])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:33:30 -0700
Message-ID: <9d02685f-5c19-47d4-8f7f-bb546c0c7504@intel.com>
Date: Mon, 21 Jul 2025 15:33:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix NULL dereference in avx512_status()
To: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vignesh Balasubramanian <vigbalas@amd.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Oleg Nesterov
 <oleg@redhat.com>, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Brian Gerst <brgerst@gmail.com>, Eric Biggers <ebiggers@google.com>,
 Kees Cook <kees@kernel.org>, Chao Gao <chao.gao@intel.com>,
 Fushuai Wang <wangfushuai@baidu.com>, linux-kernel@vger.kernel.org
References: <20250721215302.3562784-1-sohil.mehta@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250721215302.3562784-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 14:53, Sohil Mehta wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When CONFIG_X86_DEBUG_FPU is set, reading /proc/[kthread]/arch_status
> causes a NULL pointer dereference.
> 
> For Kthreads tasks:
>   proc_pid_arch_status()
>     avx512_status()
>       x86_task_fpu() => returns NULL when CONFIG_X86_DEBUG_FPU=y
>       x86_task_fpu()->avx512_timestamp => NULL dereference

This seems to imply that CONFIG_X86_DEBUG_FPU _triggers_ the bug.

It certainly makes it obvious, but isn't there a bug with or without
CONFIG_X86_DEBUG_FPU? Even without it, I think it'll access out of the
init_task bounds.

> Kernel threads aren't expected to access FPU state directly. However,
> avx512_timestamp resides within struct fpu which lead to this unique
> situation.

What does this mean? Most kernel threads have a 'struct fpu', right?

> It is uncertain whether kernel threads use AVX-512 in a meaningful way
> that needs userspace reporting. For now, avoid reporting AVX-512 usage
> for kernel threads.

It would be idea if this was more explicit about how this changes the
ABI for kernel threads.

Could we make this more precise, please?

	Report "AVX512_elapsed_ms: -1" for kernel tasks, whether they
	use AVX-512 or not. This is the same value that is reported for
	user tasks which have not been detected using AVX-512.

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 9aa9ac8399ae..a75077c645b6 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1855,19 +1855,18 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
>  #ifdef CONFIG_PROC_PID_ARCH_STATUS
>  /*
>   * Report the amount of time elapsed in millisecond since last AVX512
> - * use in the task.
> + * use in the task. Report -1 if no AVX-512 usage.
>   */
>  static void avx512_status(struct seq_file *m, struct task_struct *task)
>  {
> -	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
> -	long delta;
> +	unsigned long timestamp = 0;
> +	long delta = -1;
>  
> -	if (!timestamp) {
> -		/*
> -		 * Report -1 if no AVX512 usage
> -		 */
> -		delta = -1;
> -	} else {
> +	/* Do not report AVX-512 usage for kernel threads */
> +	if (!(task->flags & (PF_KTHREAD | PF_USER_WORKER)))
> +		timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
> +
> +	if (timestamp) {
>  		delta = (long)(jiffies - timestamp);
>  		/*
>  		 * Cap to LONG_MAX if time difference > LONG_MAX

Can we just do:

        unsigned long timestamp;
        long delta;

	if (task->flags & (PF_KTHREAD | PF_USER_WORKER))
		return;

	timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);

	...

for now, please? That way, there's no made up value for kernel threads.
The value just isn't present in the file.

