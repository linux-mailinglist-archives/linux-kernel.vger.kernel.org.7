Return-Path: <linux-kernel+bounces-731290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C1B05248
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7131895418
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1526CE17;
	Tue, 15 Jul 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8PNAUDl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB52264A9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562739; cv=none; b=sAVSVqz1EQYsOl/svAbbobxgBTxpxlLumy+4j8YAIFxTr70hr2Xh/5nyHIPBwbr6TI1CyC90R03H1AJaBfMLpCN2MqKxUkHSW0Pc0oDtvHHQK5NSiMgFdgc/xwAMFAnDwsdRb7EiH4zwQNWutRnd72mRvkk+l6Jz4jcQLBvifFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562739; c=relaxed/simple;
	bh=mbfAD0hFlSTMolZq2J7TOzEpdHQycJi5YCq0IBF2A/8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PmXh5y7wzA35OlqiOsQDHpYUekp1e0yG6Ax1PnWc87msB6SkUgZpysQTbF33XYHnXmCAaghtkgl3JMzcHzkzrG9sW8wr3KXVZ++n1DZq0Tkeelh94q9iMSCtS/+OMHSPQI48ftLj0CYWCNv6n2hI/avujXqwQxIHAwyKkoDek+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8PNAUDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE46C4CEE3;
	Tue, 15 Jul 2025 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752562739;
	bh=mbfAD0hFlSTMolZq2J7TOzEpdHQycJi5YCq0IBF2A/8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=O8PNAUDlkgOCGO6+fGwuv8CuHB7rLOROlx30Eb8pl4AIwW17YkCXE3mmGsl0Gemsv
	 vL8D8zy0qoE/LtPbsLHZ2KutU4BiuKTL2pigTiWwtr4Uq1qsFSTDbgdv2lzqvZzn0M
	 IS7RHwsc6dP3bAdpf/BJchRSOqOIP2HgbUUpShmDYIkZgFKXq8/bddkttu2MwG0eoQ
	 +9WGvdcY53XfE91dqwBm1LijPgSzs3MOY8LLQd3llu3KLFUC/xP/Tb9Ts8oC3ifovn
	 urLTJ+DI58tHbPPaOntX+FJ8Ui7ux+QyYMJcOtFzyelbrpj2vCzDSwkdBcgKHUt9mu
	 jo+N7FzT2LryA==
Message-ID: <d822f21f-bfdb-443a-b639-66860a30ccbd@kernel.org>
Date: Tue, 15 Jul 2025 14:58:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, axboe@kernel.dk, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250715031054.14404-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 11:10, Qi Han wrote:
> Jens has already completed the development of uncached buffered I/O
> in git [1], and in f2fs, the feature can be enabled simply by setting
> the FOP_DONTCACHE flag in f2fs_file_operations.

Hi Qi, do you have any numbers of f2fs before/after this change? though
I'm not against supporting this feature in f2fs.

Thanks,

> 
> [1]
> https://lore.kernel.org/all/20241220154831.1086649-10-axboe@kernel.dk/T/#m58520a94b46f543d82db3711453dfc7bb594b2b0
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 696131e655ed..d8da1fc2febf 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5425,5 +5425,5 @@ const struct file_operations f2fs_file_operations = {
>  	.splice_read	= f2fs_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fadvise	= f2fs_file_fadvise,
> -	.fop_flags	= FOP_BUFFER_RASYNC,
> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>  };


