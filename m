Return-Path: <linux-kernel+bounces-619503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD306A9BD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 06:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F377E7B541A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 04:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC93215778;
	Fri, 25 Apr 2025 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e7mlQmc5"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EC2153EF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554032; cv=none; b=FEuRBmtqNXyj5TwouOXsXafqEg4VPiGU9aj3661cCDKzuC6EmYnMLeiyyJaRffGUdSXefxmi5GHRBEAIdt6n5eHZedsRNU4NtVMUGZ8Zw3jxGA6Wh/H5iP7St+RqQ4pPGHC87RDLrtOFFdKDeG/EOwkWbZF9qMdiSIzBD5sItuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554032; c=relaxed/simple;
	bh=WtJMnjwowPfe+6KgXjjmyyZyeGpcViFHXukmWXOJLbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkozXedjk3XGGe3znDqKCNC7bPgF2XN5kt/kY47RAIG9iF3JgZ8DtjS+ZckvM+lqY1dtMXK8qsoqULq4U7EGlPjptMxkxluPv84ad/kXefsD61tZFJEWpFVq2wUY4Jl3Q6tvOiao8G20UIGpei6UYAaTwUIGhws2W3fvZwi8Y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e7mlQmc5; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8352c76d-ad30-4c2e-91bd-9676df21b293@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745554015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McgZG3+kgRVX1m1JTnpDAlQQ4f5/9JzIXvGUQ0n2AG8=;
	b=e7mlQmc5secbcKyizKg9GNyiWPCUKFVJxMmaikba9aLEHzAw03yTr5rJrlS0h2qx4tnOk1
	qmFn7/hxKlzyHOhynFgHAODkM6HYsMLFfRHzSD4IODbaxEM2jQlgJxV/CFjDAxhni0oGW2
	seUQ99KLl3t0+NCpWikuVSaaD5Prtuc=
Date: Fri, 25 Apr 2025 06:06:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] loop: Add sanity check for read/write_iter
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <680a45db.050a0220.10d98e.000a.GAE@google.com>
 <20250425034057.3133195-1-lizhi.xu@windriver.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250425034057.3133195-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/25 5:40, Lizhi Xu 写道:
> Some file systems do not support read_iter or write_iter, such as selinuxfs
> in this issue.
> So before calling them, first confirm that the interface is supported and
> then call it.
> 
> Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   drivers/block/loop.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 674527d770dc..4f968e3071ed 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -449,10 +449,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>   	cmd->iocb.ki_flags = IOCB_DIRECT;
>   	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
>   
> -	if (rw == ITER_SOURCE)
> -		ret = file->f_op->write_iter(&cmd->iocb, &iter);
> -	else
> -		ret = file->f_op->read_iter(&cmd->iocb, &iter);
> +	ret = 0;
> +	if (rw == ITER_SOURCE) {
> +		if (likely(file->f_op->write_iter))
> +			ret = file->f_op->write_iter(&cmd->iocb, &iter);
> +	}
> +	else {
> +		if (likely(file->f_op->read_iter))

"else if" is better?

Zhu Yanjun
> +			ret = file->f_op->read_iter(&cmd->iocb, &iter);
> +	}
>   
>   	lo_rw_aio_do_completion(cmd);
>   


