Return-Path: <linux-kernel+bounces-731072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D8B04E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687AF3B2FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717D2C15A3;
	Tue, 15 Jul 2025 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f8yyV3fy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23B84A3E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752548878; cv=none; b=J4dVWPZFhPeqSSLNdBqP6CYLuZ6GCVietY7Oo+VeXcRBQZT3TcW/kU1ityn5JIpM433V2UWNNhGYF/MRE4+KpIeXyGbUgU+Bs9Uw4z6f8O/+aomiIW722CyMGR6sQs31kx+DoSdi9QFoefe0MF6Kp5rY4c10vBrFHsRC94WeEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752548878; c=relaxed/simple;
	bh=bEUcqUHYvze7KEw7ZiJehmR/ZyHXUK9EEygLgd/uhxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3sI4MG/ysQVHyp/xYn7UdC/ZsxRY7kGpnamZkIMMWI1w8vBW8YXkAfoU44XP/mRb7Uu6US7bsRRQDQKhweIRVZUE4WZHpL3lKRwYwzQsQT0HlsAp9qlxkK+rveTb34xmg2ci/1Fmut6RkJMln9x2dSWrTq4OigRWcEZXGLjUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f8yyV3fy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0FBOyWLIcS6AFb3W9zUK/LSHlb0he6BlmTGRRekweXs=; b=f8yyV3fyNesCvZnUGA9zm/X9tR
	xWVRR+yTOIFnSrg5gg4zhOG+7Zz8ptklEn3h9XppRkZqctqtU4y7ruS22VNGs+ftVwnsZnjq5uY2U
	+zUNeRotPpvAZrbfJiNtBN/wmteSHloDcjrR8gyvSfhYR7dkhJjWQE5bk9ypMYLjXxnUZFT1y2mlA
	T0XbjtZ+t23rc1W7wPmuOgBgutveE7suEF8E3TAKNogi3fXumHgj3RKPr4YTwE1s/mcNhxqlyQmcP
	TMYig+n1PkHyI73OMU8gYnUrAy3mnyo9e3IScYEiJyAJd072JrIJL/3q0fTUD8qK1XgQEjuzZyRkE
	J4Om34GA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubW1L-00000003qO0-40pt;
	Tue, 15 Jul 2025 03:07:56 +0000
Message-ID: <6e941369-4b78-4b7c-9ce1-00dffe4c10ca@infradead.org>
Date: Mon, 14 Jul 2025 20:07:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Work around broken noinstr on GCC
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
References: <20250714073402.4107091-2-ardb+git@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250714073402.4107091-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/14/25 12:34 AM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Forcibly disable KCSAN for the sev-nmi.c source file, which only
> contains functions annotated as 'noinstr' but is emitted with calls to
> KCSAN instrumentation nonetheless. E.g.,
> 
>   vmlinux.o: error: objtool: __sev_es_nmi_complete+0x58: call to __kcsan_check_access() leaves .noinstr.text section
>   make[2]: *** [/usr/local/google/home/ardb/linux/scripts/Makefile.vmlinux_o:72: vmlinux.o] Error 1
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/coco/sev/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
> index db3255b979bd..342d79f0ab6a 100644
> --- a/arch/x86/coco/sev/Makefile
> +++ b/arch/x86/coco/sev/Makefile
> @@ -5,5 +5,6 @@ obj-y += core.o sev-nmi.o vc-handle.o
>  # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
>  UBSAN_SANITIZE_sev-nmi.o	:= n
>  
> -# GCC may fail to respect __no_sanitize_address when inlining
> +# GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
>  KASAN_SANITIZE_sev-nmi.o	:= n
> +KCSAN_SANITIZE_sev-nmi.o	:= n

-- 
~Randy

