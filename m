Return-Path: <linux-kernel+bounces-855979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBBBE2D02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254805E3F36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8972DF3EC;
	Thu, 16 Oct 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwQLh13k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749B328603
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609572; cv=none; b=EcK++/ceFVf7dYdTdn5zVQbKwW1rg93ZM5Cl9NhAZ3ca1Zz63KX85PR3gHm5jruhB99xLNrD84Ak9s6mDqKUH0yvIqczCMVm7N2w7qh78hlCX0r6/GnJYSBUkqzdahT37Yb9jwDY2N8YMEp82L8vtRi15vjuptCW1KsfPq4apRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609572; c=relaxed/simple;
	bh=ep4WvnFaJAInijuwafHJ8Dba++c9UHnZ3qrBY8flBas=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HG4wOlQKotMBf9Mofth7ifFC3yUYWxseT68S3LoFZ4/PQqmZ3MW/yBVM4XJqbdUHTuJG9hOyb419lI2cDkaNmHTPs7xwX+SL90dYbFBWfDfU/SWqi7DYiI62TtBEqYyi4VVujH7iVmIvyjcOLEp49GMLPGO47njuWMiJbh4D6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwQLh13k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74F9C4CEF1;
	Thu, 16 Oct 2025 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760609572;
	bh=ep4WvnFaJAInijuwafHJ8Dba++c9UHnZ3qrBY8flBas=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hwQLh13kZZvuUZKDsuIEU8ZcTAkEFJ1miK2LYvy/sN0Q0BIV75752Zj4Z+GOjMiTo
	 FKo5K8Sq6HI8KCXGqGNc0kXdQQtp8b+kY+WYmfIfEyt+mFxAxYCiBm9N56xl0L6kK0
	 Qt6DELb7cUFUEGhpTrRM/4XG95+F4QfKsJXETCZ1z7YBTvbeaHzfsNM7SQtl2ghwrj
	 KWI0lnMNOUGJZ9P8zdZa3E7njr7Ki/5mE08yIUVl0Yoo6v3LJGfJARp0uUh1EyM9Lz
	 +hEEVV8nr/XYxAUwv+bYIj6J2AihdA9euJNUKZpPq0vpefAXkuUWMixqtBQ9gsNraZ
	 SgRmf5SQXJRyA==
Message-ID: <5257fece-d947-4a33-8f66-4db5e8b73a28@kernel.org>
Date: Thu, 16 Oct 2025 18:12:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, jeuk20.kim@samsung.com,
 d_hyun.kwon@samsung.com, gyusun.lee@samsung.com, hyenc.jeong@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com, jieon.seol@samsung.com,
 keosung.park@samsung.com, wone.jung@samsung.com
Subject: Re: [PATCH] f2fs: serialize writeback for inline-crypto inodes
To: Jeuk Kim <jeuk20.kim@gmail.com>, jaegeuk@kernel.org
References: <20251016051621.7425-1-jeuk20.kim@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251016051621.7425-1-jeuk20.kim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/2025 1:16 PM, Jeuk Kim wrote:
> From: Jeuk Kim <jeuk20.kim@samsung.com>
> 
> Inline encryption derives DUN from <inode, file offset>,
> so bios from different inodes can't merge. With multi-threaded
> buffered O_SYNC writes where each thread writes to its own file,
> 4KiB-per-page LBA allocation interleaves across inodes and
> causes bio split. Serialize writeback for fscrypt inline-crypto
> inodes via __should_serialize_io() to keep foreground writeback
> focused on one inode and avoid split.
> 
> Test: fio --name=wb_osync --rw=write --bs=1M \
>        --time_based=1 --runtime=60s --size=2G \
>        --ioengine=psync --direct=0 --sync=1 \
>        --numjobs=8 --thread=1 --nrfiles=1 \
>        --filename_format='wb_osync.$jobnum'
> 
> device: UFS
> 
> Before -
>    write throughput: 675MiB/s
>    device I/O size distribution (by count, total 1027414):
>      4 KiB:  923139 (89.9%)
>      8 KiB:  84798 (8.3%)
>      ≥512 KiB: 453 (0.0%)
> 
> After -
>    write throughput: 1760MiB/s
>    device I/O size distribution (by count, total 231750):
>      4 KiB:  16904 (7.3%)
>      8 KiB:  72128 (31.1%)
>      ≥512 KiB: 118900 (51.3%)
> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   fs/f2fs/data.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ef38e62cda8f..ae6fb435d576 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3217,6 +3217,8 @@ static inline bool __should_serialize_io(struct inode *inode,
>   
>   	if (f2fs_need_compress_data(inode))
>   		return true;
> +	if (fscrypt_inode_uses_inline_crypto(inode))
> +		return true;
>   	if (wbc->sync_mode != WB_SYNC_ALL)
>   		return true;
>   	if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)

Jeuk,

Can you please try tuning /sys/fs/f2fs/<dev>/min_seq_blocks to see whether it
can achive the goal?

Thanks,


