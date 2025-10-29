Return-Path: <linux-kernel+bounces-875011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B4BC1800B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A0394FD27D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EBE2DFA25;
	Wed, 29 Oct 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYJPfHMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3834A01
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703568; cv=none; b=ur+2jzKqVn66zFL/EC8q9vDg6KhxzIQUS9y2i/4lm69JehCCcpG5NIxRjoR4E5cBG7gqChRNlrn9So4BpPVj6MnATaoglnVidLMoHAbOCyg2NGtJUtLOIiM5yTRqKiN8aKQ0O5s2O2iPZlUW0QNQzyG6zeNQW0RpIq9lIfuR94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703568; c=relaxed/simple;
	bh=HMC9j24US+EH/znFASuxf00dXnERjTr7097s6hS7xqE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dWoAkDae3VQ/hDtdbr2O4ZLeXgmK/RAhFa6TSLLGcsqM9sI9NicZITkVMAcZKY7ihimIZXdRdegHNGPPl79ZWT83EPYLstjad3rJOlynd4aw+rNXnURYkk1VeHu0JQCZyvnDckKzu/APt4fqNiiChsXmQE+91oj+iM3O6KZqdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYJPfHMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053AEC4CEE7;
	Wed, 29 Oct 2025 02:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761703567;
	bh=HMC9j24US+EH/znFASuxf00dXnERjTr7097s6hS7xqE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HYJPfHMH70x0ReVPqAR/fHtQRwR/8jEg24hQjp06TxfiGlxO/G0AVGZFcCg1WXkxu
	 SiQtAKO4wMYXUJhiVirVBBCAZfnGHKSAeK2u9Q7KaUyc8dN4zQmCKnnlkdI1Zu/Cqe
	 H1U1+9OT4HU4T+MKFTP9AekfYDD88GUJjiBIKPktd1gl8MBMgwfRg689h8Uyr3rq3k
	 /rCPbX9XXsq5P+diQn1MBf7rfgqS6zMkzE34EQaILNR79zaYnNtlGiZXeYDl5A2yhW
	 4+atRnSc+F+sqpkpUytWO4Jto9GidmdWrgyIJy6aD8v5Ww8LHKk9NlwRACVyPdLY5d
	 ykvrP5k3tXZ0g==
Message-ID: <81602674-b9f4-4ab2-91f5-0afc762e7cc6@kernel.org>
Date: Wed, 29 Oct 2025 10:06:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: add fadvise tracepoint
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20251028195444.3181203-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251028195444.3181203-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 03:54, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This adds a tracepoint in the fadvise call path.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c              |  2 ++
>  include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6d42e2d28861..4a81089c5df3 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5288,6 +5288,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
>  	struct inode *inode = file_inode(filp);
>  	int err;
>  
> +	trace_f2fs_fadvise(inode, offset, len, advice);
> +
>  	if (advice == POSIX_FADV_SEQUENTIAL) {
>  		if (S_ISFIFO(inode->i_mode))
>  			return -ESPIPE;
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index edbbd869078f..b7f5317b5980 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -586,6 +586,38 @@ TRACE_EVENT(f2fs_file_write_iter,
>  		__entry->ret)
>  );
>  
> +TRACE_EVENT(f2fs_fadvise,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int advice),
> +
> +	TP_ARGS(inode, offset, len, advice),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__field(loff_t, size)
> +		__field(loff_t,	offset)
> +		__field(loff_t,	len)
> +		__field(int,	advice)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	= inode->i_sb->s_dev;
> +		__entry->ino	= inode->i_ino;
> +		__entry->size	= inode->i_size;

__entry->size = i_size_read(inode)?

Thanks,

> +		__entry->offset	= offset;
> +		__entry->len	= len;
> +		__entry->advice	= advice;
> +	),
> +
> +	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
> +		show_dev_ino(__entry),
> +		(unsigned long long)__entry->size,
> +		__entry->offset,
> +		__entry->len,
> +		__entry->advice)
> +);
> +
>  TRACE_EVENT(f2fs_map_blocks,
>  	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
>  		 int ret),


