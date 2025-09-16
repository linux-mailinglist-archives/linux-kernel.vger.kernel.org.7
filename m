Return-Path: <linux-kernel+bounces-818734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C3EB595D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C9A16B074
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DA3081A9;
	Tue, 16 Sep 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6o5n9q8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2121EDA2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024751; cv=none; b=IM2IuqY1CXi+knucUpTP7WUwqCPRGb0DzDMew85hkFLP6KS0F4n6FSEcQxRkD4UZlqNQPo947RinNWtH7k08LDMVbUq7Kbo3SgULH3pcpaplyY8YVagdo6uCARupMPDug5D6VTS8wLJpDhWseKXYyxt6l5N4lwtrmEBFNlrWShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024751; c=relaxed/simple;
	bh=hiXSWzOiLhbz/0pwI+JJnR5U2ggEanH7kVkF3wl+d2g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sm8kTwVLzh66iT/9NLnllQtXsyGnJYI1bzj+1g2ufCDWyzTe/+dWUc1AUUpgzLR/c6nqeAFr8Zh5VAFMz96qodE+odM73xGQSdgTYV5i8mUj61X1A15pczAGLGQxYWnBIq+QqyX6LVlvUd0s5lcL2IcBomQ81sharRapBz0zi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6o5n9q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3F8C4CEEB;
	Tue, 16 Sep 2025 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758024751;
	bh=hiXSWzOiLhbz/0pwI+JJnR5U2ggEanH7kVkF3wl+d2g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Z6o5n9q8YjO9Rz5PItEdYUznt8kXuXdGCBIDrPVXDXBRz/MIh6taeVUZSkzvJ597y
	 Mbm1F+/78/i9YwkPU3LeVgPWmP+ROhuqC65FIvQjqOOs4E5EL+erH3QGnILcD1Yq2I
	 8V+r4Xmnc8ION2Z+ZR6ki3Vrr28i2iI9WkW5T7g+boRpT26909Eg5+NOQk91kgHLHj
	 4aGeKai14dC3XoWljOv8xbebYqXMvqkCZqxaTtbxzcl0XHIcxrp7v/VyXwjXNSi5ZG
	 8TRm63KZGzauivwYq7Spd3ymX4FQmaJtBz86juUcR5RjnwxBWOY6+Q3/G9lZE0O7dp
	 J16ugFZDuOIBQ==
Message-ID: <1f80bc3f-845f-49f4-93d7-cc1be8a781f5@kernel.org>
Date: Tue, 16 Sep 2025 20:12:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250915035246.98055-1-wangzijie1@honor.com>
 <20250915035246.98055-2-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250915035246.98055-2-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 11:52, wangzijie wrote:
> When we get wrong extent info data, and look up extent_node in rb tree,
> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
> return NULL.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/extent_cache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 199c1e7a8..6ed6f3d1d 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>  			leftmost = false;
>  		} else {

Need to print some messages here as Jaegeuk suggested, IIUC.

Thanks,

>  			f2fs_bug_on(sbi, 1);
> +			return NULL;
>  		}
>  	}
>  


