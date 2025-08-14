Return-Path: <linux-kernel+bounces-767998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D251AB25BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6355C3D05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D823B611;
	Thu, 14 Aug 2025 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwHvZHET"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD3199FBA;
	Thu, 14 Aug 2025 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152271; cv=none; b=SbmqGW0iT0uVHTK9nNLJYQpdWDeFmCq/enxj437mzHZ84xPtSofBn/pK8vgPiqv10wojN+gNTA+un04esNQz6II/Zwn+b2k+5/cSnDK2VSek8t29zwrJaZ+7chRiZtkuVoXng0bBjB3U4+wyamqQMgz52Uanz9p53qo+r49kXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152271; c=relaxed/simple;
	bh=JUlGXDoDU3h8VdYmd71GV9rx3NSd1zaFVwUlBMhfP84=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=txdlp6NWdKjhbwNUpvhtGKrnx04dzmXwhe9j6tNDUcXbrmnAGUYCgeTZkPj9HIiVJXMYpnXSpXlQWTL7PudHRDXvSgSMGAGSRsgIQspOkzMJae4N8UabZuJdsVB7HostjS4G9npDEtkxGXq3suhjcdUf8Ro7tUE/E/J5CrO288E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZwHvZHET; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=uyhswAR8zAjm8saDsw6xts31EBzXU2xYMGuJPzUBHv8=; b=ZwHvZHETZM5U7jKaA0CiTInLQd
	LzsVv7SRuTVGhQFfEGwjIzpYgPyYwqyvzUfWEKWrSUA6qaY+agtffT25uMjKtH8jp6RXEklMRRapB
	khShInvsnnDXXyYizOA4DHasWNlbiRFrUBDn6ywc9X4RsinSKqnGNNP7q4+QNKUQmKuAm1V81Xi5k
	PY8CfLKfl9xK3G6/7ZfgS4RqHAeZcw77R7w5/0uBnjueXntmkuf9RpKslnGCGcW/3pdm47696VRtW
	+Q/wD3JuOTygh1Fi2tiUJGXu6yBs4C+NIHrxiTQdt7/rvfBu2IkMe8PVWZek6hIiY4b/JuKXTixsB
	HIJvchDg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umRHZ-0000000FvAN-46BE;
	Thu, 14 Aug 2025 06:17:50 +0000
Message-ID: <29ecd4d8-2af5-4854-b4fa-2a1d6b312e9b@infradead.org>
Date: Wed, 13 Aug 2025 23:17:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kernel-parameters: fix kernel-doc warning
To: vivekyadav1207731111@gmail.com, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814041610.28171-1-vivekyadav1207731111@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814041610.28171-1-vivekyadav1207731111@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/25 9:16 PM, vivekyadav1207731111@gmail.com wrote:
> From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> 
> Fix kernel-doc warning in kernel-parameters.txt
> 
> WARNING: Possible repeated word: 'is'
> 
> ```
> [command]
> ./scripts/checkpatch.pl --strict -f Documentation/admin-guide/kernel-parameters.txt

Thanks for that.

> [output]
> WARNING: Possible repeated word: 'is'
> +            The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
> 
> total: 0 errors, 1 warnings, 0 checks, 8339 lines checked
> ```
> 
> Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 747a55abf..302145870 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7506,7 +7506,7 @@
>  			Set a trigger on top of a specific event, with an optional
>  			filter.
>  
> -			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
> +			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
>  			Where more than one trigger may be specified that are comma deliminated.
>  
>  			For example:

-- 
~Randy

