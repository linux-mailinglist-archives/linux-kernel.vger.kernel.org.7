Return-Path: <linux-kernel+bounces-816329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46052B57280
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE0416181F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497E2EA73C;
	Mon, 15 Sep 2025 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMJEH/fp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8F2EA15C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923541; cv=none; b=QRVag7Hu2dolS2r9/hZrhA/jejDnpD5IP2ihu7NQZlaPrS+WG3VscmIxUdJjdArgvFcwBASxw0mbSkK1CqiyuTHEIYglokRkUrnrTYo5R9Cqhyllr+QrP6h+43LEA4NhGiymHU5WEXthADFEAhaNX/XBMtZt7bvGKs1n7nhFqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923541; c=relaxed/simple;
	bh=lzzHpXrl4T+O1eFsZmhBzn3Qp59jklkv+WRQqIpRaxo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eBcDnrraWg+TJQXLoKp1BlGbvvlMwwqu+OYOcG64ZlBfnwYTDCiV6nsT/6VAMiUiv9Vs7U4Z/LuLoexMoTEiHWUnpi6DCLBy4+h5KEZZsNrgGDwVmXXncn3+5Q2lHQ3lFtdE5CxSZtuosB0L/c/YoKjP2lkmi/noQdQGLuyrVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMJEH/fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F67C4CEF1;
	Mon, 15 Sep 2025 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757923540;
	bh=lzzHpXrl4T+O1eFsZmhBzn3Qp59jklkv+WRQqIpRaxo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RMJEH/fppeez5XHLej251shsdGH3YLaGuO/xeYNuD0mxteNCLH4kw6YERzIxbgOhE
	 cqTjx1hHQYbBT/ah8bGX5rHmjv7zdfi5x++4YXC9U8Nkn+B92dI94DlXT/MTTrRAsx
	 vqMESklN65bpJy8NkY6LA4HDjAihzl6lWZTcAsb/qPM8vho3rCCkInTR9YUIpFnSu8
	 EApV+OKHD3z/pKUa6SbkXMEtfN12LxJ3u+Gqx+2gKNOVY3HEOopsn97pILJpnM+aNp
	 MjqLh3iO2LbmF5IQskxI6A+StEI0grnoE3lAbXdwSiwP9iTBbV1rQ5ecC+ycJZMTRF
	 k1BVMWt5toZ4A==
Message-ID: <2f1c3f5f-7ab2-4b11-8368-b9c925cbea7c@kernel.org>
Date: Mon, 15 Sep 2025 16:05:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix zero-sized extent for
 precache extents
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250915035246.98055-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250915035246.98055-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 11:52, wangzijie wrote:
> Script to reproduce:
> f2fs_io write 1 0 1881 rand dsync testfile
> f2fs_io fallocate 0 7708672 4096 testfile
> f2fs_io write 1 1881 1 rand buffered testfile
> fsync testfile
> umount
> mount
> f2fs_io precache_extents testfile
> 
> When the data layout is something like this:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> During precache_extents, we map the last block(valid blkaddr) in dnode1:
> map->m_flags |= F2FS_MAP_MAPPED;
> map->m_pblk = blkaddr(valid blkaddr);
> map->m_len = 1;
> then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
> map->m_flags & F2FS_MAP_MAPPED == true, and we make zero-sized extent.
> 
> Rebased on patch[1], this patch can cover these cases to avoid zero-sized extent:
> A,B,C is valid blkaddr
> case1:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...                         ....
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> case2:
> dnode1:                     dnode2:
> [0]      A                  [0]    C (C!=B+1)
> [1]      A+1                [1]    C+1
> ...                         ....
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> case3:
> dnode1:                     dnode2:
> [0]      A                  [0]    C (C!=B+2)
> [1]      A+1                [1]    C+1
> ...                         ....
> [1015]   A+1015
> [1016]   B (B!=A+1016)
> [1017]   B+1                [1017] 0x0
> 
> [1] https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/
> 
> Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

