Return-Path: <linux-kernel+bounces-772235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 532ACB2903E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A2E1C86E90
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3E1F75A6;
	Sat, 16 Aug 2025 19:36:04 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF351F582A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755372964; cv=none; b=nUJarS0BsDLd4ELlWBRCyV9oboDLiDHKH+rxAEn2YahC0Qb2mY/2Lxa0b0YdgTNQNm3ZLjWHIZQcjSLch6Rd+vxhy4NYwFGjSbSIdEzbmih+sFebvttPbrnIP2T/ZBdnqP/qa41239WnIX7qHpthjjnKHac/SY+BE8i4tug+ymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755372964; c=relaxed/simple;
	bh=QzrSxmFk6iveACVr/9rEhCqobbpcZhNFTVK5ExiN5Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaqsW4k8uwJTZGonGeCa2WU9Jd2DC9+y4hfPpTWKPf1vvnk9mg2Cj//v1cO7WbCKgycszZT4Zbp4dbnPjKvyogR5h0b7aCrqtSMQhx/1bvhaSdb5SN5G0/Hr/QI2qYiwZHOzW7c5dakpAtp6KX23JY+DCFRZC4frOAFcv7m268Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7FD744349;
	Sat, 16 Aug 2025 19:35:56 +0000 (UTC)
Message-ID: <c5bf56b8-da06-4e17-86bc-1b69af3065cd@ghiti.fr>
Date: Sat, 16 Aug 2025 21:35:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/sysfs-schemes: put damos dests dir after
 removing its files
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250816165559.2601-1-sj@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250816165559.2601-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhuddtveegleeggeefledtudfhudelvdetudfhgeffffeigffgkeethfejudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdefrddvfeegrdduudeirdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdefrddvfeegrdduudeirdduhedupdhhvghloheplgdutddrudehhedrudejuddrjeekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepshhjsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrmhhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmhesk
 hhvrggtkhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi SeongJae,

On 8/16/25 18:55, SeongJae Park wrote:
> damon_sysfs_scheme_rm_dirs() puts dests directory kobject before
> removing its internal files.  Sincee putting the kobject frees its
> container struct, and the internal files removal accesses the container,
> use-after-free happens.  Fix it by putting the reference _after_
> removing the files.
>
> Reported-by: Alexandre Ghiti <alex@ghiti.fr>
> Closes: https://lore.kernel.org/2d39a734-320d-4341-8f8a-4019eec2dbf2@ghiti.fr
> Fixes: 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement DAMOS action destinations directory") # 6.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Not Cc-ing stable@, since the broken commit is in 6.17-rc1 and hence probably
> this fix will land on the mainline before the release of the first 6.17 stable
> kernel (6.17.1).
>
>   mm/damon/sysfs-schemes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 74056bcd6a2c..6536f16006c9 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2158,8 +2158,8 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
>   {
>   	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
>   	kobject_put(&scheme->access_pattern->kobj);
> -	kobject_put(&scheme->dests->kobj);
>   	damos_sysfs_dests_rm_dirs(scheme->dests);
> +	kobject_put(&scheme->dests->kobj);
>   	damon_sysfs_quotas_rm_dirs(scheme->quotas);
>   	kobject_put(&scheme->quotas->kobj);
>   	kobject_put(&scheme->watermarks->kobj);
>
> base-commit: 9aa69ba9d9e220ea1d8ba62592fe7ffba376b2cc


Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the quick fix!

Alex



