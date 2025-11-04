Return-Path: <linux-kernel+bounces-885574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429EC335B0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FEE189E88A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E02DAFCB;
	Tue,  4 Nov 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVdZgzlB"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E02D94A8;
	Tue,  4 Nov 2025 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298302; cv=none; b=jVZXqL4EIvNCyG72/1zURzInL4NlkXjfATxAsERJ/WKrL6NeC0myANokTJeWxTGAy8kdA+0f/ELW6P3fxP/UVDm54JkBaHmDLhTSOvNR6jHT24KI5oNoEv3s6c9pqSd1vpzdYUU4HN6e1tT2KT9IqBChbLl5DMAF2QlPNKcaOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298302; c=relaxed/simple;
	bh=8eaU4PEC2c2giMxU+6+faFJS11n7Ure0cR+De/7s2vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L+diKTlS+1QUrihy1ghI5+kdNhazNoiM+PmKwAaoNcj6tBToNEfU5x0WyliMZAZIwGNoGDl9ukaZMsk3UJHRi6zVvV5pl8lJvDqYwB0NIRtu8x9cuogJG9eMjbOJVG9E009t/J9R8USWL6C3yYMfrW6V32xPtXRmY3BPWjFbpAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bVdZgzlB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=Y790WKwGEGT5HnCsGWE23gAkpRos3CR2T6aFVpk1eug=; b=bVdZgzlBmcSONzcAqO9ipb6pCj
	1mA0SoZMXnmQ3BEY1ZoBRSWNzky0bSvN34jBb7IFXtOY6x5MUADzVy5MyF/mKOJkPeQnyTcLYF4xY
	69kfgIvjbsZ7fErq3LyhCjirB6GJJOn6URuJ2xy6aHX9aw1qP6VewAcmWcwbv2Z2RTcyUNYIPFHCi
	iCgdgoKjEWO5hZ6AVaZi0ozrmj0mDHoKJuJLRWnMn+u7aPz58NakTArRI3EtdfVNjXBuwLfB6k4Dv
	7Wb2Rkygu/fXOWzA9cgaJQARoa+ap3G6TUYl/2GOCEKiQGn/fFQtpmRXXBkuEF8AeTX7DQP1DWcnx
	w4RHpndA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQI6-0000000CkB6-3u5t;
	Tue, 04 Nov 2025 23:18:18 +0000
Message-ID: <0dfa2a07-cc84-4f04-ad2b-ab88cd08d974@infradead.org>
Date: Tue, 4 Nov 2025 15:18:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 1:55 PM, Andy Shevchenko wrote:
> When kernel-doc parses the sections for the documentation some errors
> may occur. In many cases the warning is simply stored to the current
> "entry" object. However, in the most of such cases this object gets
> discarded and there is no way for the output engine to even know about
> that. To avoid that, check if the "entry" is going to be discarded and
> if there warnings have been collected, issue them to the current logger
> as is and then flush the "entry". This fixes the problem that original
> Perl implementation doesn't have.
> 
> As of Linux kernel v6.18-rc4 the reproducer can be:
> 
> $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> ...
> Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> ...
> 
> while with the proposed change applied it gives one more line:
> 
> $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> ...
> Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> Warning: include/linux/util_macros.h:144 expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> ...
> 
> And with the original Perl script:
> 
> $ scripts/kernel-doc.pl -v -none -Wall include/linux/util_macros.h
> ...
> include/linux/util_macros.h:139: info: Scanning doc for function to_user_ptr
> include/linux/util_macros.h:149: warning: expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> ...
> 
> Fixes: 9cbc2d3b137b ("scripts/kernel-doc.py: postpone warnings to the output plugin")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Oh, thank you. I knew that I had been missing some warnings since
I still compare outputs from the 2 kernel-docs (perl vs. python).

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index ee1a4ea6e725..f7dbb0868367 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -451,6 +451,13 @@ class KernelDoc:
>          variables used by the state machine.
>          """
>  
> +        #
> +        # Flush the warnings out before we proceed further
> +        #
> +        if self.entry and self.entry not in self.entries:
> +            for log_msg in self.entry.warnings:
> +                self.config.log.warning(log_msg)
> +
>          self.entry = KernelEntry(self.config, self.fname, ln)
>  
>          # State flags

-- 
~Randy

