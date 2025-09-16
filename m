Return-Path: <linux-kernel+bounces-819733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B030B7D6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461A21C02DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C32F0681;
	Tue, 16 Sep 2025 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qN3YWDGt"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1D2D063D;
	Tue, 16 Sep 2025 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065297; cv=none; b=u3uMOv9mQlwGyyHVUoNYjOvWyMlrAEwO1qmde89oi/w5P+YL4AGkc33dT8zAwLUajwc1l6sbfZyXwvSy4KEI72/cZHZ+6F8SERXvaJv09W3k8DYRjAYCSNyat0JLN4q2181SIMrBxSeH/MCKB+waeksordz8r4G6MvKmmf2lvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065297; c=relaxed/simple;
	bh=bp0dQY/0IPohE9yH9P88bhJPT6HidUKVWN9nWSJ7paE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4VtFD/Q6AF/MRYjn5Yl8LHcj3vI64tqP/AvRV6oXePqN1suHctSkf7gj7wyiWo7vjRtDvhiNsYHR1J3jKhnXcqRhPY6wUAcqW6QCMduSFPJMicHiTIVQ97zbCYS/ilSoxKSf/Vy0K52OEGn/Owub8beVH/F3G2+87DeMV4X6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qN3YWDGt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sIPj1eQ9/W7gYEmefz7ujrw8Xu1tovQ+cRdB3u84UiY=; b=qN3YWDGtD4wXOI+qhcTNG4wXnA
	TI3pFfRRpa0iiBzXMBa0eUQYnclocPHpyaKGAeFpRCb/uxS4G96+dccUQggCNZSH4OGdHYosL47Ha
	awzmBqvEbt6pNJnfrhv5SRf3NejUibMm4ErEYhBK2ZKyD6Ay0UYkDsO0VgEhFjx2+uZCG/VkKnBWn
	NBdY7Suv1jsxOLcnvRqfXqN9+vkdPFwPQCH+ICV01aDh4fp3jJkTJlUZzZ9B8tMcCuxhtd0F4agFb
	03+DdXq7IHWVh66JseIlLgzIwRx7LXGufAVk2/uf+EP8F52oKcxNnxwTxIJSQ5ayvb/Vbq0nlJyEc
	wN6auWIw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyf5p-00000009YEq-0rlk;
	Tue, 16 Sep 2025 23:28:13 +0000
Message-ID: <3f5997c7-4387-4b26-8a98-b2a1acc3f82c@infradead.org>
Date: Tue, 16 Sep 2025 16:28:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: maintainer: Fix ambiguous subheading formatting
To: Thorsten Blum <thorsten.blum@linux.dev>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250916222944.2547948-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250916222944.2547948-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/25 3:29 PM, Thorsten Blum wrote:
> Add a newline after both subheadings to avoid any ambiguous formatting,
> especially in htmldocs. Without the newline, subheadings are rendered as
> part of the following paragraphs, which can be confusing to read.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes in v2:
> - Fix subheading formatting with newlines as suggested by Randy
> - Link to v1: https://lore.kernel.org/r/20250915192235.2414746-2-thorsten.blum@linux.dev/
> ---
>  Documentation/maintainer/maintainer-entry-profile.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
> index cda5d691e967..d36dd892a78a 100644
> --- a/Documentation/maintainer/maintainer-entry-profile.rst
> +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -59,6 +59,7 @@ week) that patches might be considered for merging and when patches need to
>  wait for the next -rc. At a minimum:
>  
>  - Last -rc for new feature submissions:
> +
>    New feature submissions targeting the next merge window should have
>    their first posting for consideration before this point. Patches that
>    are submitted after this point should be clear that they are targeting
> @@ -68,6 +69,7 @@ wait for the next -rc. At a minimum:
>    submissions should appear before -rc5.
>  
>  - Last -rc to merge features: Deadline for merge decisions
> +
>    Indicate to contributors the point at which an as yet un-applied patch
>    set will need to wait for the NEXT+1 merge window. Of course there is no
>    obligation to ever accept any given patchset, but if the review has not

-- 
~Randy

