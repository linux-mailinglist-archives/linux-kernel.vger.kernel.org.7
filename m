Return-Path: <linux-kernel+bounces-829463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD74B9720A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2634E3227
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518B2DF70E;
	Tue, 23 Sep 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ETATS6bU"
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C528643C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649861; cv=none; b=ZTpUNskbrz0RpzcSEAsIB6TFU7bO/dwnpS03Ua4zKxsjIgzGJ99P/T8LC1ZDO8ETPXAuZh88AiGhpwyniNExGk7zU0oTAEJMTsSsUnA2J4hmJglHG5Fz8dvBQK2/HbGLKhU0vNJ373pyzYV1tHuaIL/2gosCCYA/m8wxsSs7/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649861; c=relaxed/simple;
	bh=hcoGFZNJkreCDeYr6BpJKXMGFNUt6arRLg1n277LcfQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0Ig81L/zQ8WilRe80eGZ9fMTAO8tBxSBK+XODPUXLev6G942yGsNxkYuDMfJ0TQy/iqrTgj9yMZuCESuzLFuQ8m8uBIfR51YjRzxm0kAulkv8mWaY0jA5OyNLMuQIJsxU73Ilt3pU8KMRqO8439Q4zL1NalRgST5k3mEk3SGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ETATS6bU; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758649859; x=1790185859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3tx+fZ731hStR3QwB8Vwr+fatNxOU7DCvOysaUDqs0=;
  b=ETATS6bUzRIn+4spVw2wdJdvInGV0isllpkaPNNLvNjmesI1HyFSjBuU
   IRprsA0PPtEsL/U1gYtibuI13BW3h8dzcR7K4apD5NLb13/LWpeTwH/Yg
   Z18xv6Z5oFmoG7yoT5Gz/a7KWxX0iBhOmV5LtzvFGf5urbBFT/HnwIEk4
   dO9VavlgfOlX1qBqvL/IiRxWsOws0YL3sIbHe2aS9tAdqqGL0rLNSG++G
   j29XbiP1vJQG2mb6+23otJRjSh3oDzAJ3LXs01+mzasE1uD2CEJjKVXY9
   TH4waPSIsAIhGve+v/ZcHEnWOOAu+ZjnxLrNw7CZaaCTqLtK/v1ukempC
   Q==;
X-CSE-ConnectionGUID: lwCl1RWXT+aKK2oadLaBiA==
X-CSE-MsgGUID: 475HWfd+TQehZxD0e1rLsQ==
X-IronPort-AV: E=Sophos;i="6.18,288,1751241600"; 
   d="scan'208";a="3480840"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 17:50:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:47695]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.121:2525] with esmtp (Farcaster)
 id 3a68c820-3ea0-4f05-bb30-09be8ba4b876; Tue, 23 Sep 2025 17:50:58 +0000 (UTC)
X-Farcaster-Flow-ID: 3a68c820-3ea0-4f05-bb30-09be8ba4b876
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 17:50:58 +0000
Received: from 80a9970eed1e (10.106.101.9) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 23 Sep 2025
 17:50:57 +0000
Date: Tue, 23 Sep 2025 10:50:55 -0700
From: Justinien Bouron <jbouron@amazon.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He
	<bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, Justinien Bouron <jbouron@amazon.com>
Subject: Re: [resend, PATCH v2 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <aNLd_6CO6YMvm2MN@80a9970eed1e>
References: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
X-Editor: VIM - Vi IMproved 9.1
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, Sep 16, 2025 at 02:51:09PM +0200, Andy Shevchenko wrote:
> clang is not happy about set but unused variable:
> 
> kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
>   745 |         unsigned long maddr;
>       |                       ^
> 1 error generated.
> 
> Fix the compilation breakage (`make W=1` build) by removing unused variable.
> 
> As Nathan noted, GCC 16 produces the similar warning;
> 
> Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
FYI the commit this patch is fixing (i.e. f4fecb50d6e1) is going to need a
second revision as well (I haven't submitted it yet, still working on it), this
means that your "Fixes:" tag will need to be changed again, requiring a 3rd
revision.

I am not sure what is the proper way forward here. Should I:
    - Send my v2, without fixing the unused variable and then you send your v3
      with the updated "Fixes:" tag pointing to my v2.
    - OR fixing the unused variable in my v2 (i.e. "absorb" this patch in my
      v2).
In the latter case, I am not sure how I am supposed to credit the work in this
case? Do I need to add another "Signed-off-by: Andy Shevchenko" besides mine?

I'm still learning the ropes on how to contribute through the mailing list so I
would be grateful if you could share your input on what's the proper way forward
here.

Best,
Justinien
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: fixed Fixes (Nathan), added a note about GCC (Nathan), added tag (Nathan)
> 
>  kernel/kexec_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5357ed39e9d1..32722926bc7e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -742,7 +742,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  	struct kexec_segment *segment = &image->segment[idx];
>  	struct page *cma = image->segment_cma[idx];
>  	char *ptr = page_address(cma);
> -	unsigned long maddr;
>  	size_t ubytes, mbytes;
>  	int result = 0;
>  	unsigned char __user *buf = NULL;
> @@ -754,7 +753,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		buf = segment->buf;
>  	ubytes = segment->bufsz;
>  	mbytes = segment->memsz;
> -	maddr = segment->mem;
>  
>  	/* Then copy from source buffer to the CMA one */
>  	while (mbytes) {
> @@ -782,7 +780,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		}
>  
>  		ptr    += mchunk;
> -		maddr  += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.50.1
> 

