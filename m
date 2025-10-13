Return-Path: <linux-kernel+bounces-851037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE6BD55E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B631A4F7A86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A04C81;
	Mon, 13 Oct 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ybjtqq9s"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FCC26F2AE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373966; cv=none; b=BGoueju+HhIk3uJaaoStcZ2s1B3XHgS4kzZSXrT5raKb1pXh8FIlLtXjMAEQVCtpfSbA7b0GKUTvPYokZOOHhgpOgnIQAriryBvR0sxEU4aiFmhsRbn9HGSK7QPf297f9HGu9vk36PRa5AQ58N3h6TOFbfdFYEF4623BxRYo0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373966; c=relaxed/simple;
	bh=ozTJoGPUDl2Q/XFcc/njJnNmrBfSc/yZ0ybMPXm40SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RprBY/81y7nX7e/0Gc+X5CrYqxmyKuM1lY02X9Mrw2xu7Bb0yTQDKitiWpLiFIj2AVCksEadkrNIOpKyyGZNJNSRgwPY4b17L2bCQRG3m1+fmOEQke3THHjkd3VjCN1KhvZKIbNs4fZtb00olubqdAkpeaMcP5sgU+neGEIbhs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ybjtqq9s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mD3bAV2yaoTW4h21alY+aJsT1tByLvi9/visriR6TVU=; b=ybjtqq9sdg7jp2ncAr5INztqUd
	o3y0tJ10QjdUZ9mwGA2iZhmUuARpfzERQuPYHmIK5HckcdXqZkP7tRp5IRx/XqdhN8nMnczW3qnzL
	COOPztfcXlb1pN+Y6B+n0FwalFpvjge/aLvMQKnngAr/eLYA/fvgMNjf4yYnU3LaNKJh+SoWTdxGN
	mfnZ8C14M6/PXJZ7LS+vjpspyFJ3oi/ez3LOMjGMJVfW8fhOUhiMaFLjeqZcOLAuGyUpiw/t8GFyl
	SDmbcDP4Wd+zjvOL9fOmBQyteV72rLXhuUj79Vv/qp7aS6Rmi6CIn+AeB4rWnHGv4Git5Ywdx0/9Q
	BUkyU8fw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8LgQ-0000000DujU-0VNH;
	Mon, 13 Oct 2025 16:46:02 +0000
Message-ID: <e308bc41-7b98-4f03-b25a-d859d8bfb737@infradead.org>
Date: Mon, 13 Oct 2025 09:46:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: fix == bashism in kernel-chktaint
To: Kevin Locke <kevin@kevinlocke.name>, Jonathan Corbet <corbet@lwn.net>,
 Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-kernel@vger.kernel.org
References: <47d80432-3838-4fc7-898c-9a9154080113@leemhuis.info>
 <cfa643395a4ae569838b7992c3fe7a3c3797831d.1760366509.git.kevin@kevinlocke.name>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cfa643395a4ae569838b7992c3fe7a3c3797831d.1760366509.git.kevin@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 7:41 AM, Kevin Locke wrote:
> When /bin/sh is a shell other than bash, invoking kernel-chktaint with
> at least one argument may produce error messages such as the following
> (produced by dash 0.5.12 with argument 1024):
> 
>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
> 
> This occurs because the == operator is not specified for test in POSIX
> and is not supported by all shells, as noted by shellcheck SC3014.
> 
> To fix the issue and avoid the error message, replace == with =.
> 
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>

This should have retained the previous *-by: messages.

> ---
> 
> Thanks for the reviews and feedback Thorsten and Randy!  I agree it
> probably doesn't matter, but I appreciate the value of consistency and
> of being aware of those conventions, and it's an easy fix.  Thanks for
> letting me know about it!  Here's an updated version with an improved
> commit message.
> 
> Thanks again,
> Kevin
> 
> Changes since v1:
>  * Remove superfluous links in Markdown format from commit message.
>  * Add version of dash used to commit message.
> 
>  tools/debugging/kernel-chktaint | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index e7da0909d0970..051608a63d9f1 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -19,7 +19,7 @@ EOF
>  }
>  
>  if [ "$1"x != "x" ]; then
> -	if  [ "$1"x == "--helpx" ] || [ "$1"x == "-hx" ] ; then
> +	if  [ "$1"x = "--helpx" ] || [ "$1"x = "-hx" ] ; then
>  		usage
>  		exit 1
>  	elif  [ $1 -ge 0 ] 2>/dev/null ; then

-- 
~Randy


