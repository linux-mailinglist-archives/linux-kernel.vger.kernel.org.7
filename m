Return-Path: <linux-kernel+bounces-857221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96794BE63DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B505E16BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470401C862E;
	Fri, 17 Oct 2025 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZQwLLYg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADDC1643B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760673644; cv=none; b=kU5ObDBhN29/5M5XZU5XWeAnHrlglCv+xeVq0ue1oQWzUfRldCzwaGapF9tNEPZ+sFzv1go2/+NvS0lrNfP8hIyyh946qch23wNDSWDh7P0zuOZRazbPBfJgDqdHK75br72AigdMkm5uKfBLnhJTnT93Z1O9UjngINNcA/GIPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760673644; c=relaxed/simple;
	bh=9T6sgg5C5mrHRqZhwDwXXoB3rRIUDQqAqJJoxh+6nSk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HSo0cpGXE+3ORBSfe4K+4RTkinDK12VnbdyjA01G+hXi1G4LsmZ2QI6tRv/9QRwMnfKCn7ie6GX+8OW+q0/xvgTIpsNd6vqu3B38JbzdOxidWHYAcArclxycCSg/poZyV6WD9j0+tIsYr0CZKILMyxUw4Wcwoiux0tSpPtaWpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cZQwLLYg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Gcr6gbWp08XzOkcHEtKDLGEufzx9+hOK6htukdjtybk=; b=cZQwLLYgUG59WG34/oGf89aGq9
	ktP1wMF3WJU6ilKmQlzmqUmt16VeJnReMGMEDCF99f0z8f4yM5aHerZQesOupCjNQpmmVuWQ1mW7B
	/T21rrPUbwYHWwzAiQCvHDgoj4IzfqSienmf07Pc1YXkFx7seiDrcpZ3ZUkvrLbfRx3W6ErqyZyii
	VEEkYAGy7Qn4I86o51i1lf4WFmna/hzfe/DJy72BGPIGYdCg271udhuwmk1/6nvqHiUCzY4gxl5bo
	kM9qZbREEbQKahW4dDS6SIkiLKhYkLscwH8PliWgq+M5dgDPgJIpi+pdswpwtDVgz7MhMTQadeJSr
	EWqZIdgQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9bdx-00000006UOo-07j3;
	Fri, 17 Oct 2025 04:00:41 +0000
Message-ID: <1db6799c-8d24-41dc-aa1c-83d7b6ccb188@infradead.org>
Date: Thu, 16 Oct 2025 21:00:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] tools: remove unnecessary x suffix in test strings
To: Kevin Locke <kevin@kevinlocke.name>, Jonathan Corbet <corbet@lwn.net>,
 Thorsten Leemhuis <linux@leemhuis.info>,
 David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20251016214707.5c3d373b@pumpkin>
 <a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
Content-Language: en-US
In-Reply-To: <a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/25 4:47 PM, Kevin Locke wrote:
> An "x" suffix was appended to test variable expansions, presumably to
> avoid issues with empty strings in some old shells, or perhaps with the
> intention of avoiding issues with dashes or other special characters
> that an "x" prefix might have avoided.  In either case, POSIX ensures
> that such protections are not necessary, and are unlikely to be
> encountered in shells currently in use, as indicated by shellcheck
> SC2268.
> 
> Remove the "x" suffixes which unnecessarily complicate the code.
> 
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> Suggested-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> Thanks David, that's a good point about the x suffixes.  Since
> shellcheck warns about the x prefixes (SC2268) and I'm not aware of any
> shells currently in use which require them, I think they are safe to
> remove to clean up the code a bit.  Here's a patch to do just that,
> which can be applied on top of my previous patch.
> 
> Since -o is an XSI extension to POSIX, I've stuck with ||, but I think
> you are right that x would not be required in that case either.
> 
> Thanks again,
> Kevin
> 
> 
>  tools/debugging/kernel-chktaint | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 051608a63d9f..051ac27b58eb 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -18,8 +18,8 @@ retrieved from /proc/sys/kernel/tainted on another system.
>  EOF
>  }
>  
> -if [ "$1"x != "x" ]; then
> -	if  [ "$1"x = "--helpx" ] || [ "$1"x = "-hx" ] ; then
> +if [ "$1" != "" ]; then
> +	if  [ "$1" = "--help" ] || [ "$1" = "-h" ] ; then
>  		usage
>  		exit 1
>  	elif  [ $1 -ge 0 ] 2>/dev/null ; then

-- 
~Randy


