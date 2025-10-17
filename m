Return-Path: <linux-kernel+bounces-858674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5DBEB653
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD26226CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B252FC01B;
	Fri, 17 Oct 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oXxXfnHl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE632C955;
	Fri, 17 Oct 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729979; cv=none; b=e8SHxkcpP4Sfw2I9GxYqxD2rul1PcBfPHdjAjrLhEIrQqZaxpWP0RYxu43ORnA2GSmWCL4v0bHsH374Eqw2WZMh15G2lP/uZUWeSJOawsAazUUxnFzN+pBRmA02qZCoIi0RXx3GbFjeYQ1uD/G7Hp/fAsEz3IDgw4NTQUof8NCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729979; c=relaxed/simple;
	bh=LhUB0GpUgK9F14BhCiULoa01j3fhb9rDCe/KcxgN2LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwFEiTin0GWASbdqOdgL0QezBKL7GHPeQLEs92taHGb8yQqHaQQYy2SXs00Cw4+HBvF6a1t+mA2HoGI0hl3sI/RS9xAyQeQiWb19jgQPMdIfIGTmNwW1NmtVu3lYnlbbgEsAVfj4GE2ylIATPX1GG0BENPcvboZxNnPao9MMhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oXxXfnHl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2XmsMIjVw/ixg7JxgZV2GT8GjGC0FM4HT+IGUYyQpcM=; b=oXxXfnHl1uiSuj278E3kXgxwHr
	RFYzIyqgVUolJ3sDlgnvK9OkbahcdUHzmDgxjgg62dmRGcjX1LBpG596ep5piN0lWNSpWXWpv/lyZ
	OUPJWeHFeehBFK7rrL/X2FF27uhfyjZ1htvGDDlhm+esQre+rGDQQv8orAcXTZi3mQ+lSUXHGrWKF
	GW95gbZd4f9OVdhvVB6ohCOg9ocVIe29xIEOH/NT/DzZr4C/OMqR0NmtamI5X03XPH4mtO4b6jQNZ
	/Sg1djBIV2CYSiX+oFiZ/8o0HvLDuHwPj2CbnCZP5KJHfMBEfFSyEHr0xHCDd77jDUJDWE9oh4BFG
	PsWgPcfA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9qIa-00000008qjf-2XEE;
	Fri, 17 Oct 2025 19:39:36 +0000
Message-ID: <b71d9455-610a-40d7-af3e-f030499dd2a0@infradead.org>
Date: Fri, 17 Oct 2025 12:39:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: checkpatch: Align block comment style
To: Brian Norris <briannorris@chromium.org>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20251017180225.1489398-1-briannorris@chromium.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251017180225.1489398-1-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/25 11:02 AM, Brian Norris wrote:
> Ironically, the block style comments in the checkpatch documentation are
> not aligned properly. Correct that.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

However, I would just remove the entire second comment block and
its lead-in comment.
Networking no longer has its own comment style and it looks like
checkpatch no longer checks for that.


> ---
> 
>  Documentation/dev-tools/checkpatch.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index d5c47e560324..d7fe023b3080 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -461,16 +461,16 @@ Comments
>      line comments is::
>  
>        /*
> -      * This is the preferred style
> -      * for multi line comments.
> -      */
> +       * This is the preferred style
> +       * for multi line comments.
> +       */
>  
>      The networking comment style is a bit different, with the first line
>      not empty like the former::
>  
>        /* This is the preferred comment style
> -      * for files in net/ and drivers/net/
> -      */
> +       * for files in net/ and drivers/net/
> +       */
>  
>      See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
>  

-- 
~Randy

