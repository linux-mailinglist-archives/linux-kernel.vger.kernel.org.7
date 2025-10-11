Return-Path: <linux-kernel+bounces-849317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05911BCFCF6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 00:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 978ED4E206B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B77221DB5;
	Sat, 11 Oct 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjyBLm6V"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81F2836F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760220435; cv=none; b=gpXo3nrmTI3VDEt6k1DgI6krrpBp6G+FYd9QW41q49LOqRfAsVYAi6W4t5FRg20rUb/T9kCv/58OSBkM+ZrmCypGOjpPwkr78sL61zYztqBdqGS8Sz320cNCfK2kYouiJytpJTqL8hVVtvl3TJYhgX+Y/nO3M11rW8IlEy4/ZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760220435; c=relaxed/simple;
	bh=JI1cw69pnium3tpK3v4HIIkuJSCB6TIdMnAeI9XTcQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Esblv6lZduzN0OKhjiFzCmKAwC8b3o4ZG5r6jZA1q0nHx9wkALn5WTDchEWp0mgwQLhMnWU49sU4Dz935eIR4EXRsNWU/36rP6NSdjF0gYWCqeef4cuygyKD+iT3ay0SZdtKlEWgrUdHfv2Z4uaAxVUTICCfDsZt1oNWm8UBeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pjyBLm6V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RNKr5f3nnsAaN7s9Al3Mh+8atUWEoNOpcgENWTkS71E=; b=pjyBLm6VLpDZFizFJk9KnI9bYi
	W0zCRi87jvcMlJ2k5HDC9w8TCoMXE+j7ByDeBkEf3Atw7G0ez6eWLJG+2NCmnmD2xJTkJiYAoAKT5
	1fdYXwLkKWrg0E/jxd3kD8BVEU+mYiF8e1K3VKMnCWHv6dZh0H9fHA0WDuT7kiR6xD5ThjvTNz3Cn
	gL9SGdKC/+eNUsq7y/RmuYNUBUadfoEmhn+RAxtz1F5beB9EMRaoTL+P5AcdeTcZ6nDq+uosQhbOX
	CgLWJGuJ4lsqgTFRywnjNuDIQI4ScMGtKdqp6A99ZNRAkXO31WaDvriEjEf8TCzc3xQcWIOcEL60+
	Xu9biADw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7hk7-0000000As0F-2gQG;
	Sat, 11 Oct 2025 22:07:11 +0000
Message-ID: <f5949227-7bd3-4fd0-b873-e79d0768a1be@infradead.org>
Date: Sat, 11 Oct 2025 15:07:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: fix == bashism in kernel-chktaint
To: Kevin Locke <kevin@kevinlocke.name>, Jonathan Corbet <corbet@lwn.net>,
 Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-kernel@vger.kernel.org
References: <1531d0cd452f1870e1703c263b11d718c46b54bb.1760216665.git.kevin@kevinlocke.name>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1531d0cd452f1870e1703c263b11d718c46b54bb.1760216665.git.kevin@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/25 2:04 PM, Kevin Locke wrote:
> When /bin/sh is a shell other than bash, invoking kernel-chktaint with
> at least one argument may produce error messages such as the following
> (produced by [dash] with argument 1024):
> 
>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
> 
> This occurs because the == operator is not specified for [test in POSIX]
> and is not supported by all shells, as noted by shellcheck [SC3014].
> 
> To fix the issue and avoid the error message, replace == with =.
> 
> [dash]: https://git.kernel.org/pub/scm/utils/dash/dash.git
> [test in POSIX]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html
> [SC3014]: https://www.shellcheck.net/wiki/SC3014
> 
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
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

