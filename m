Return-Path: <linux-kernel+bounces-789206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D301B39239
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AC2463550
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86E194A65;
	Thu, 28 Aug 2025 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTWNkWeS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736E2557A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351901; cv=none; b=Bd93p/SS3TicvaTi2IsTN0mHZbg36WTo6hzKj/v/EqOGZhJ+V2m1FfiImyPiGBhESgAKRXdmrz8GEzXK7NdpYVFgu31r8/nsT9aTs38bIobSGQ6+NW6TedkgvB09ndVTT+jvcvdpO+kURaP4kXawZ40OhkwYeloaOIdRjAn50k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351901; c=relaxed/simple;
	bh=eYE4YCC+62NgocceA6DStyJGNAxd9Czbqyz9l9H8fPI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kwN8p9iIK2lZxKroGbspcbOQog0f+CNGov1BDgVa/abZ7Q/Sw4ImWeYRJFO5otHx6rClL0zVeKwa3DG0TCOvfYNzp/oM8uez/zmP0CmgaaS5aS31vbcZifhNXOr6CorOjI6NCqrs92rD4X02m3RiW4qcr6tnS65EzkhvsBydWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTWNkWeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB26C4CEEB;
	Thu, 28 Aug 2025 03:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756351900;
	bh=eYE4YCC+62NgocceA6DStyJGNAxd9Czbqyz9l9H8fPI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GTWNkWeSX8cuirS/frmngcfncIZSlAu+Qqk7hpzkFsg+OmZuJgVQ558/KyJHml/nX
	 U+rBjZWqWMKjkKJmFgL5kRNbaJE89+ZaVGuL59tbMkkx9ZT/fgVSds00uih6H67JSc
	 vN3VpUARgf9biQ/Omemn1VYmblRWqAppZJkKBOCFsuGcH0a1kfb6oi4CGgttEgbt08
	 kz1y8J0E9czEwnO1ERzOagvmjzw5u1ccbQJZHFgjjGGb6shIIrP+jd13arjV7Jcb7b
	 Giy/qI5eNsb3/o/co1PXsnuAG1ymbfkRT4rBnhskOvScSzcnlUC3Fws3NBToCe7uE8
	 RChmDh4MVgzuA==
Message-ID: <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
Date: Thu, 28 Aug 2025 11:31:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250827215222.1615844-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Let's split IPU writes in hot data area to improve the GC efficiency.

I didn't get it, IPU may be not friendly for migrating data along w/ write in
hot area?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e0f6589c6a1c..bb79dad55ac9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  
>  		if (file_is_hot(inode) ||
>  				is_inode_flag_set(inode, FI_HOT_DATA) ||
> -				f2fs_is_cow_file(inode))
> +				f2fs_is_cow_file(inode) ||
> +				is_inode_flag_set(inode, FI_NEED_IPU))
>  			return CURSEG_HOT_DATA;
>  		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>  						inode->i_write_hint);


