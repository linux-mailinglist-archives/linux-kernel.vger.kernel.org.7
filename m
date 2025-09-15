Return-Path: <linux-kernel+bounces-817679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD8B58549
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461901B21985
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9C283CB1;
	Mon, 15 Sep 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFhWm1/g"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819628314A;
	Mon, 15 Sep 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964557; cv=none; b=gGZSo426IxdvYWnoGv0ttMjuZXfj6DwBZLb7RzFC7m2KoeLfsnfYgQLduFttd3xSGeubbXI38H0dky+Jbx3cKuLbgqe1gyLALYI+SKs7LS6nHrD2BHpWqhoehJ+UsL8uG63xERqBVdxZyiyuTTLu5Yyjrtj+TQtB7m8wQW48ZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964557; c=relaxed/simple;
	bh=W+5vxPZXQflnKrX9eGh5fWsCigAJNqd3stTJWQmEEi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2+HvYq8oYM5zc5NskzPWT/gQthLc7FdzwujUtrE+2ePJN6KjkdHnDA/2CxJbJIT7U5vKJ5E8wASCd760+/YCdKlhehq8uIC7QDldVmVGYh5t5KXP6WqFGLFnwgkWBa3TlwBNampjS2H1vX78oKHdUhdvoEoTlQT2nEXrZ17UMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WFhWm1/g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZbQp6a6Zj/MsZULZi4Bi7x/UTatlCEOy3h1PtigaPRU=; b=WFhWm1/gMVCa86Z7w19EVIu7JH
	I9OBrJxo/xqGxBa24IYE2MHatDqU56lhTVaRFcftVBwzkLaQzr44Ne06H1o/wsHZWOLDcfHsGatx9
	Ke2zfUT+VE7kV8xIbbU7NFtetOONtzVIzyEg15w7OC9j2qrhUcZQrmjeePk9kXOgL1TyxSG4Lpy3R
	y1H7hFEmecYEB0snDyhYiAtr+I1vMv+6GK8PVvNHZddGBe7dJiwOMPk0ZrXZZUUGJqSnzEhBhMHUh
	5VsuMXHvYXwB7ogSVVAsO+Qe6L2jBU0he1BNCvOm0wb6fHCkIzBiWKC8CT+lRqjZavFgjiNcgUqOu
	pi3N2jRA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyEsw-00000005VZR-2VpN;
	Mon, 15 Sep 2025 19:29:10 +0000
Message-ID: <c85881bd-a159-4bb3-9615-b87ce4ab0575@infradead.org>
Date: Mon, 15 Sep 2025 12:29:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: maintainer: Fix capitalization
To: Thorsten Blum <thorsten.blum@linux.dev>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250915192235.2414746-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250915192235.2414746-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/15/25 12:22 PM, Thorsten Blum wrote:
> The sentence starts at the previous line: s/Indicate/indicate/

Are you sure?
ISTM that the entire line is a "sub-heading".

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  Documentation/maintainer/maintainer-entry-profile.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
> index cda5d691e967..f411a0d10fad 100644
> --- a/Documentation/maintainer/maintainer-entry-profile.rst
> +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -68,7 +68,7 @@ wait for the next -rc. At a minimum:
>    submissions should appear before -rc5.
>  
>  - Last -rc to merge features: Deadline for merge decisions
> -  Indicate to contributors the point at which an as yet un-applied patch
> +  indicate to contributors the point at which an as yet un-applied patch
>    set will need to wait for the NEXT+1 merge window. Of course there is no
>    obligation to ever accept any given patchset, but if the review has not
>    concluded by this point the expectation is the contributor should wait and

-- 
~Randy


