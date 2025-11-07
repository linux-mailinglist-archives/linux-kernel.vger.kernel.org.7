Return-Path: <linux-kernel+bounces-889798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD7C3E8A3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 063514EA1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B3261B70;
	Fri,  7 Nov 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tJy31I5z"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9F258CDF;
	Fri,  7 Nov 2025 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494428; cv=none; b=io97iZuKTWSxubgToKrWMKJbV0bIwPerv+bQuTaCrA+GXMxcgw58plo8MSsv6E8p4fslutM4KeWY+5lD6TU1vZct+nth3B3etsAan4gvlI+znwqFj6hZ/5G+BQeyh3yuHhfpt4Is3VRJzrr/zDmyMtoH9NECKwpAdrHZtheTxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494428; c=relaxed/simple;
	bh=rOMWh8Xk+wOfVWUeCKMywVDKx/6rmMqxNy+VPgUewOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km8JT+ZxIGcxnM6WJm4DCRJxOhtS0DiZwyR4d2x9YlJbdTIAEbXZdy4O0aQ6VXHPd344VDiXB2ibtqFCL93tFwDy7T7YIWlqWRJ8dEQpjM2LHJc6eP5Q07ycn1dE74V5seSqBuArStl3u6mgPneqHNaz1e/fANdsdKzYnc6xa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tJy31I5z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CpiyMvCQsrzPAmRu9VI6pvGp3ZMbmAj4As6/po+/n6g=; b=tJy31I5zpCExwDaU4GZHyc1qJG
	FRptE0bt3QbReeMUeDjBDPRVA1MhsvrBWI2CuC+GrmFTIEkTCOEZDuTy0Vwki1sQQJw3BvEIugB0i
	ZK9kV26otc8tY1MysjVCSyHno6vJSlq7z//k0/mo+KQ8T2J98y1A1yd0C9LMTKPigRtzvxt2MR0Pb
	fKpAFyEekRGfnhkmPzT1+AdQW/5DORFo/F7bB7otVPTPzM/+j6BmLkQgK0oLgBHzybtz8GtXTGwBA
	uAp6Qr3ZpLRy6UnbEKajBo9E8BB+O6Qy0gW1b7qth3zz6dps+CYBc01hOpyS5zMnfTkOV2rVEdrRZ
	FtNTpBiQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHFJK-0000000GhX7-0m2A;
	Fri, 07 Nov 2025 05:46:58 +0000
Message-ID: <e7a48398-6ea2-458c-bb2d-8142c8086d36@infradead.org>
Date: Thu, 6 Nov 2025 21:46:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] doc: kdoc: Handle DEFINE_IDTENTRY_*() cases
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20251106101416.1924707-1-andriy.shevchenko@linux.intel.com>
 <20251106101416.1924707-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251106101416.1924707-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/6/25 2:12 AM, Andy Shevchenko wrote:
> We have an unparsed kernel-doc for spurious_interrupt() IDTENTRY.
> Update kdoc to handle that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index f7dbb0868367..b583edd80a52 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -1430,6 +1430,25 @@ class KernelDoc:
>  
>          return proto
>  
> +    def idtentry_munge(self, ln, proto):
> +        """
> +        Handle DEFINE_IDTENTRY_*() definitions
> +        """
> +
> +        name = None
> +
> +        # Replace DEFINE_IDTENTRY_IRQ with correct return type & function name
> +        r = KernRe(r'DEFINE_IDTENTRY_IRQ\((.*?)\)')
> +        if r.search(proto):
> +            name = r.group(1)
> +
> +        if not name:
> +            self.emit_msg(ln, f"Unrecognized IDTENTRY format:\n{proto}\n")
> +        else:
> +            proto = f"static inline void {name}((struct pt_regs *regs, unsigned long error_code)"

Seems to be an extra '(' here ...................^^^

Oh, weird: is the comma inside function parameters converted to a '#' somewhere?
See below in SYNOPSIS.


Output from testing says: (-man format output)

NAME
       spurious_interrupt - Catch all for interrupts raised on unused vectors

SYNOPSIS
       void spurious_interrupt ((struct pt_regs *regs# unsigned long error_code
       );

ARGUMENTS
       error_code  The vector number

> +
> +        return proto
> +
>      def tracepoint_munge(self, ln, proto):
>          """
>          Handle tracepoint definitions
> @@ -1499,13 +1518,13 @@ class KernelDoc:
>              # Handle special declaration syntaxes
>              #
>              if 'SYSCALL_DEFINE' in self.entry.prototype:
> -                self.entry.prototype = self.syscall_munge(ln,
> -                                                          self.entry.prototype)
> +                self.entry.prototype = self.syscall_munge(ln, self.entry.prototype)
> +            elif 'DEFINE_IDTENTRY' in self.entry.prototype:
> +                self.entry.prototype = self.idtentry_munge(ln, self.entry.prototype)
>              else:
>                  r = KernRe(r'TRACE_EVENT|DEFINE_EVENT|DEFINE_SINGLE_EVENT')
>                  if r.search(self.entry.prototype):
> -                    self.entry.prototype = self.tracepoint_munge(ln,
> -                                                                 self.entry.prototype)
> +                    self.entry.prototype = self.tracepoint_munge(ln, self.entry.prototype)
>              #
>              # ... and we're done
>              #

-- 
~Randy


