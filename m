Return-Path: <linux-kernel+bounces-820076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D27B7E0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CE6484C32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4928B4FA;
	Wed, 17 Sep 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMisa/Rv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6BF1E3DF8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091302; cv=none; b=OnHrKoAcg8QzeSBKFQ5L/GmHkoaVHrJ8JbmDGUrhWWpxtzu+Wpv9uAhV+q+JTKyGDUaAQXKkVPv7bFGrY+NiGzvV68CEL9AJWVNeMwwABlI/aPH2eAlDqbWo3sEbJbPmmY6dCOWvS1cXYmHJ2+3BzUpqHmoxV0KARijyO4VZtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091302; c=relaxed/simple;
	bh=T0iVRqYjMl2xvDtrQJ16kWmCb8PF43r3K+G5IOGlLhc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n5zE+wtclGfBfSb0lKw8T95mwapK3nX+d3AZ7tLkakUpbOYuw63ZfKYVqAAKg9CB/EcaDOepd0YYtkecNm26xyle/WZZUGr4nIo3ubQTNeduFcRfIqsQdOwZxHFrbT9mRnITkDK1nIlceJkWfV+/sFzCCcl7Bxyq3GnB3A4tzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMisa/Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B8DC4CEF0;
	Wed, 17 Sep 2025 06:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758091302;
	bh=T0iVRqYjMl2xvDtrQJ16kWmCb8PF43r3K+G5IOGlLhc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hMisa/RvND4bb/dave5KS+GBDAZAZVR5esdP59RdY9gVhIyPdxgVwSOuSpbeVafXi
	 TlFp7W/OFxNNhhcUbThltBYfxCG/mFZdeguy9I6q5MDsBrVdW9RgYbezGwfpBdQmyC
	 LiOC2L9Af4aRVNEllF9IoyH5VXsBdORWLzcoNhJXo7VFe2DY6EyFTzT0Msva73pdaG
	 jX3LLIfRmsoG5HUxHPtxtKMk/PrCsL4ujuQTi9Fre7UPEWNkIQniQvTFS1PJMVIPAS
	 /CvyDs85oKnkj1DzXn2pkiZjLWwR0XL5RZFda12WPzl/IKpHHdknu4QEzkVygw2EpM
	 QtHXV15jRTAJQ==
Message-ID: <760669e9-22ec-490f-adc2-2981d2a56709@kernel.org>
Date: Wed, 17 Sep 2025 14:41:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: fix zero-sized extent for
 precache extents
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250917023622.516052-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250917023622.516052-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 10:36, wangzijie wrote:
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
> map->m_flags & F2FS_MAP_MAPPED == true, and we make zero-sized extent:
> 
> map->m_len = 1
> ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
> ei.fofs = start_pgofs = 1882
> ei.len = map->m_len - ofs = 1 - 1 = 0
> 
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

