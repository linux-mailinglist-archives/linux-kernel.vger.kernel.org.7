Return-Path: <linux-kernel+bounces-829859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9FB9811F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B421E16B6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC121D5B3;
	Wed, 24 Sep 2025 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhfoSCNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF971F4613
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680719; cv=none; b=LO3PwOyw3MK8/+BweaQJ9ByH/bE0Xw7NkuIWqvfw4ZaoXLpkgppIvXXc8IA/pM866DLK+k5tlPjwdOQ71emBCA1Hx9w9CR7kcmJlY3L0nbnuasrshEurLVkLBixLHH3xqtgQbvkdgJfR10XV3YZT3+OhR2AsK8eunCsnbJwIYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680719; c=relaxed/simple;
	bh=Ln/q0WgbJA38unhz8cFgC5U6hSD4aGeQda8ZrKmuzH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S/xMT5elWvK3pKa84ye0VASOiKMDvBDEPc6ZmxPe8gvwdcXl/GjC5O5sLdsb7oJGfiaP/sgwrs+m/3W3h3XFS/LbqWxtgHOO3PmlXHRLXzPWbyW6esVkvRjb/FMNuI4TB58EaCILkuNjY4lv1wosFel2YF7OGMLTreqFWmk/bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhfoSCNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E558CC4CEF5;
	Wed, 24 Sep 2025 02:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758680719;
	bh=Ln/q0WgbJA38unhz8cFgC5U6hSD4aGeQda8ZrKmuzH8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=uhfoSCNWzxXXWv0GEfEn61U/MyXQc4Urx4z13p9XSJBaOmGSfsfCDqdiTQnmON8gg
	 +IZwxzzaDz64Ae4Ja0E3A9oPTSfRDklnRaV0iubx4W6ulgiFZ6QifynAaDsMYHdBjH
	 nNxmCe5afriAXAMgZDmy4Jrk5ip8Ck+8dZ3S3x1O26ABvtPOwsC0rRn/7ih1vBmvNB
	 bNcB9dAkzIu89W1AXEDxpvfQ6Ls7kQBJiuREjKCvbFdfo8wE6qked4iAGGmdSq7jlg
	 sK/qeJ/VDcpEwXdlayB4/qilHIkkNHQwvzGGOZMvDfZGy/Hh6Nf753btWjl03obhtw
	 Jxn3wz27yxXfA==
Message-ID: <d6609f12-78c2-4a42-b4fd-689b310ec615@kernel.org>
Date: Wed, 24 Sep 2025 10:25:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: Use mapping->gfp_mask to get file cache for writing
To: jiucheng.xu@amlogic.com, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, tuan.zhang@amlogic.com, jianxin.pan@amlogic.com
References: <20250918-origin-dev-v1-1-8d9877df9e77@amlogic.com>
Content-Language: en-US
In-Reply-To: <20250918-origin-dev-v1-1-8d9877df9e77@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 11:32, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> On 32-bit architectures, when GFP_NOFS is used, the file cache for write
> operations cannot be allocated from the highmem and CMA.

Hi,

Have you suffered any problem w/o this patch? Can you please describe more
details about it?

> 
> Since mapping->gfp_mask is set to GFP_HIGHUSER_MOVABLE during inode

GFP_HIGHUSER_MOVABLE includes __GFP_FS, we should avoid using __GFP_FS here.
f2fs_write_begin() uses GFP_NOFS like the most of other filesystem to avoid
potential deadlock, as __filemap_get_folio(, .. |__GFP_FS | ..) may run into
memory reclaim to call ->writeback in where we may suffer deadlock potentially.

Thanks,

> allocation, using mapping_gfp_mask(mapping) as the GFP flag of getting file
> cache for writing is more efficient for 32-bit architectures.
> > Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>  fs/f2fs/data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7961e0ddfca3aaa332b7dbd4985ae7766551834f..9fbc41f9accb2626da22754f1a424da4805ca823 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3587,7 +3587,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  	 * Will wait that below with our IO control.
>  	 */
>  	folio = __filemap_get_folio(mapping, index,
> -				FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
> +				FGP_LOCK | FGP_WRITE | FGP_CREAT,
> +				mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio)) {
>  		err = PTR_ERR(folio);
>  		goto fail;
> 
> ---
> base-commit: c872b6279cd26762339ff02513e2a3f16149a6f1
> change-id: 20250910-origin-dev-8a5ff6bee1f2
> 
> Best regards,


