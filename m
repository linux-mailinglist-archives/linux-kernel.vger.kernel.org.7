Return-Path: <linux-kernel+bounces-870151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C326C0A0C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 00:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88D234E3211
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4512C3749;
	Sat, 25 Oct 2025 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UMu5+Pe+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D35D8F0;
	Sat, 25 Oct 2025 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761430847; cv=none; b=RcwY2/Dbi4oBpLAus9ZOU+I46WujI93QF8T02hKINwM0kiML2kEDXovoBIYLlWDhDHNRVndyDEXl85rzpeJoDq8xbHQw1MmEahoP8m73PPdcH8fFJGWELozkhMZSBBE/hZ8VXDCfUU7m1od2pT/MBwT6UKeKntBDKe8qYcVMDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761430847; c=relaxed/simple;
	bh=l/b+Yx7vbASjmTNiGPaVJJU4k9e1IDZy00yud1KlT28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufa7/IqIJGjkb5sujx/aI31nK0EH1DUIXBk2go5iUeX+bdAhnEO2UyWTbe31hX1ZOKTg5XQxxfOPuwEHaP11r/lW3WeJm/Me7KKJduT2/Q8O0AgMQ9K00RJ6TysJl05FvJtQ+WjeXHKWUk1zuPsSykwNCFA0WmLpVljQom54634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UMu5+Pe+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0TVPUd4oM+c9CYCjanSYEZ+zsEi27Rc05MbASsefem8=; b=UMu5+Pe+CPrrRXuDCuLPnJgn7l
	/srtOglIHsNhSrEFjkvTm77aPg+41WeFPMofdY9PANcgXOwE7Tyvd/pUvZu7h/wDoWILLDAOdEpiw
	BLuwBqk1Z0XVnCuIIw4JfuoV1sLkATKYdycvauJNmjHW0KrbNYkzROez7ldybtnjBGthnJBIfwwqY
	eOsZ+yTcDUMesnrFf1rSCZFbk4kcF9L+lynvf9//WT/IU8/7EiM31xu3xSKAFCqusgND6kzhKlSZ0
	iBUz9zaNeNu8F00P+XWhEqus92USl6KhzjCQkaNosn9qmR476mzM2AKqhhAWOE85dVQHZihCqKJwP
	rgGJnzig==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCmcs-0000000Booi-0qqT;
	Sat, 25 Oct 2025 22:20:42 +0000
Message-ID: <f72d1739-8c3d-4bc8-a26d-8f03b3aecf15@infradead.org>
Date: Sat, 25 Oct 2025 15:20:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: replace broken links in ramfs-rootfs-initramfs docs
To: Nadav Tasher <tashernadav@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: corbet@lwn.net
References: <20251025171625.33197-1-tashernadav@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251025171625.33197-1-tashernadav@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/25 10:16 AM, Nadav Tasher wrote:
> http://www.uwsg.iu.edu/ doesn't seem to exist anymore.
> I managed to find backups on archive.org, which helped me find
> the right links on https://lore.kernel.org/.
> 
> http://freecode.com/projects/afio was also down, so I figured
> it could be replaced with https://linux.die.net/man/1/afio.
> 
> Replace broken links to mailing list and aifo tool.

                                           afio

> Signed-off-by: Nadav Tasher <tashernadav@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> index fa4f81099cb4..a9d271e171c3 100644
> --- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> +++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> @@ -290,11 +290,11 @@ Why cpio rather than tar?
>  
>  This decision was made back in December, 2001.  The discussion started here:
>  
> -  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1538.html
> +- https://lore.kernel.org/lkml/a03cke$640$1@cesium.transmeta.com/
>  
>  And spawned a second thread (specifically on tar vs cpio), starting here:
>  
> -  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1587.html
> +- https://lore.kernel.org/lkml/3C25A06D.7030408@zytor.com/
>  
>  The quick and dirty summary version (which is no substitute for reading
>  the above threads) is:
> @@ -310,7 +310,7 @@ the above threads) is:
>     either way about the archive format, and there are alternative tools,
>     such as:
>  
> -     http://freecode.com/projects/afio
> +      https://linux.die.net/man/1/afio
>  
>  2) The cpio archive format chosen by the kernel is simpler and cleaner (and
>     thus easier to create and parse) than any of the (literally dozens of)
> @@ -331,12 +331,12 @@ the above threads) is:
>  5) Al Viro made the decision (quote: "tar is ugly as hell and not going to be
>     supported on the kernel side"):
>  
> -      http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1540.html
> +    - https://lore.kernel.org/lkml/Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu/
>  
>     explained his reasoning:
>  
> -     - http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1550.html
> -     - http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1638.html
> +    - https://lore.kernel.org/lkml/Pine.GSO.4.21.0112222240530.21702-100000@weyl.math.psu.edu/
> +    - https://lore.kernel.org/lkml/Pine.GSO.4.21.0112230849550.23300-100000@weyl.math.psu.edu/
>  
>     and, most importantly, designed and implemented the initramfs code.
>  

-- 
~Randy

