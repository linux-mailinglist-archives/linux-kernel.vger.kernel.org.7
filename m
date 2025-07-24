Return-Path: <linux-kernel+bounces-744301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F2B10AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FF41C22091
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C684D2D3EE0;
	Thu, 24 Jul 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBQT292E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D31E4A4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361460; cv=none; b=dbTxejE+3TTRJ+m5pXuvIdI0iW37Y4sAVM9k1ycr4OjDdIYqeFMq2MNq/jKjMPafLAIStJU8upYTwxYU8kqm0QJ08uDUTHG/4Ur+5V+YxMNxXhRq/dgoxA6HJ4hnE0Mm7R5L0EL+0my8Dx/XSr6wa7AOiN3JZGblofh4PiTKFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361460; c=relaxed/simple;
	bh=wpyJfM5Cwer3eb3m4ADvdms9YwdATaTcSHsIq7SRT4k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rI1IVNgSij+A5tmyjXXQxMs0WEhHQU+vEFm0rPYhwstGhTCsKGG8jbWcB4RZU/Ey81zKQwClUqVfjECuVsNMMaxKbMbbLNBXOv2a+YI3HDrbzelSxHEgJSc9IeWZwpZ+p/YpX4v2tbXrqJkpI+xFFB4bCRQ1T0rmxssV75J006g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBQT292E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E0EC4CEED;
	Thu, 24 Jul 2025 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361460;
	bh=wpyJfM5Cwer3eb3m4ADvdms9YwdATaTcSHsIq7SRT4k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pBQT292EYVdBVM+4DG/9130zi279NdyXZf9nAmEoZyudQKiTEkZseaomOyDfz2fTc
	 xpT5QhDdbdeAL865/nPHAMDTcL2opqHcMufpCCw8fDepXsLcGPjmAP50AkiZXlKC6Q
	 Wb1r7zZK8e0gDQw+Enf5i47X9wuvanNbi36iGPdLUTn8LCplhmwTVTO/p9IPhQNyYX
	 5Zc1ZzNGLSrBMXVJDa6HkeNCWP3pnNMCpRZph1+2TvFp/rKeUrnySyA9D8xjs2202S
	 AcHXcKsknEXjsvUsm6M2a1B/M6u3oIfBRq6cX9Lnv/K5vSS+nREMf+B1/lSWwsSoVt
	 6klICXevjCyKw==
Message-ID: <f3f1810b-667b-4b3a-a9fb-606a87097f86@kernel.org>
Date: Thu, 24 Jul 2025 20:51:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: vm_unmap_ram() may be called from an
 invalid context
To: Jan Prusakowski <jprusakowski@google.com>, jaegeuk@kernel.org
References: <20250724103016.5164-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250724103016.5164-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jan,

On 2025/7/24 18:30, Jan Prusakowski via Linux-f2fs-devel wrote:
> When testing F2FS with xfstests using UFS backed virtual disks the
> kernel complains sometimes that f2fs_release_decomp_mem() calls
> vm_unmap_ram() from an invalid context.

It will be better to include testcase & crash information in commit
message.

> 
> This patch modifies in_task() check inside f2fs_read_end_io() to also
> check if interrupts are disabled. This ensures that pages are unmapped
> asynchronously in an interrupt handler.
> 
> Fixes: bff139b (f2fs: handle decompress only post processing in softirq)

./scripts/checkpatch.pl will output below warning message:

WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")'

Please use this instead:

Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")

> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Code part looks good to me, please feel free to add my RVB tag in next version:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d1a2616d41be..0acc25f996b3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -280,7 +280,7 @@ static void f2fs_read_end_io(struct bio *bio)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
>   	struct bio_post_read_ctx *ctx;
> -	bool intask = in_task();
> +	bool intask = in_task() && !irqs_disabled();
>   
>   	iostat_update_and_unbind_ctx(bio);
>   	ctx = bio->bi_private;


