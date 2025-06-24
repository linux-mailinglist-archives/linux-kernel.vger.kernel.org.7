Return-Path: <linux-kernel+bounces-699377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0DAE5942
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 03:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2B94415A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E519CD01;
	Tue, 24 Jun 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aeeFHLHE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405C189F3B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728795; cv=none; b=dmCVA7cFP97qRS53i+epQHP+Wraxf7DbTdKkT+ZDLPh5YMfU2lZ9gAh459SmxZoSOKIFVTp9+r1H2UxGQRW5eE4juLk2XXyrUYu+PnE8uuvC68paIg4gA7bsf6VmCh+5nmmDTTWH+ejUK2RupwOQ2bnfU39JlB94jE4WVLUhEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728795; c=relaxed/simple;
	bh=6p+408MQpHytDrmhkcz+mmecWcdbhzehShay90+zkUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVmmATRnxzpjOxenAHulicSi00tJAxkpoQCcrGP3WugyGQTCUw//ctlxtJRe7LpSZ5owuU+lu+rUyk/0inTQPXQe50fwq7k7q+lRgNgce38zeJtJ/8rTK8vrU6BrA0Tyi9JzrkANGsO4qoLOeGSGtEaa3KkSRuvVwD8VdozTxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aeeFHLHE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a52878d37aso730587f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 18:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750728791; x=1751333591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHCKLmpVjEQudH3qzY65MufqOC1HcXRqB++GHgObSkA=;
        b=aeeFHLHEoLCxCTPAfaw2B2cyTiZ9ddc+ak13xP4ORIEDiBh6WC/M90bYTVwGPdcLQj
         zcGJn3Bjmqpm73ICfH8RmoPoG7+4tlqY3TicJUSujVVxNoAVtss5P3Cleh0r3qg6OpSp
         h4x1kxksToAFFV2lFqjc3KpWuA5e31voJpMM3Iutzh/UdfROJZIeF1wlCZrRWZRYzmIL
         E1vGd5VXY3jz9zjE1c+Cb3OyBQXnPQopJ9CDOzTF4QeRqTmfLnsrzwFSed1iZkkBBLmM
         WYVhnpQDiPgbzkeASF/XlA4wlKSi0asf24YVowEQLZS8XmXoYN1N6gBgB1E/DziR38LR
         y74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750728791; x=1751333591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHCKLmpVjEQudH3qzY65MufqOC1HcXRqB++GHgObSkA=;
        b=lF6W5LzGfo0KBwbpvuFyfmk1r1u68NvdIky+ButW9DfprYixhzOlc4t94RH8NpThtZ
         uwO4LkMZ4g0wgkvP8rURdx2TH3PFooRQ6dK1alUvE3xjm/HzTJfSwee4lhCDFRkkOR+4
         GHAehU2sbbMmq/i+ngrv3qS+FbLFW+sWKi/XMAK5DoP2ThCuehgc5smUcEy5qLblyTQU
         ohzw99fmNN2YtUikbQlU1EQ1wSR0BxbERbBbTqSTZ4WjOT7NQHacK4gQ/wOfhcoN5Aea
         H9YRv/LdLe8DbQKORj5vTb7XsRw7ZtaGmXRMIWYMd9K5smdRZgAxPjZtkvlGgprHK0X9
         y3Lg==
X-Gm-Message-State: AOJu0Yx4vzEDeFwR59Xa8o14nAj6lPifImGOaDcHSgmZ1xk5153qyx3h
	6cRsxUB+8ZkrgvDDslyX7iwU/+aJqECQNyREccnflITDskZcA/vHuPYoUBrlkNyucTE=
X-Gm-Gg: ASbGncsfTjYGATCMyjbDTmpEgk4CALQxLLSf2qa7EV1CAT/uQgFQHriukTaeJqCcal5
	U1DOsfUiSCapSkAqOPy8WITNAI238h8LvRBPx958wYnhCf34kNvCVlUdQiJ1j2fFmH3oWiEL9uA
	Dms7x0I1dPP+OTYC7yaJW7nNUrrviXuKgSVBUBYUcgJoDJOdcQt2yaGgjbc5Bt+nthYI2Yv3nrd
	1m1DZ/ruJzxEJFl64mENSbX5/CqWnbnQs9UT6m197tS8w4TI0Tguh9Yrm3Fx1Ttt4BusiWN9Cub
	RMylUxMD4kL/oLGj9G94HBR+Nr/Kt6CE64VnXi8F7ZIOOvAjQnYoyQwP4PeS+X21kpzyGOqmt14
	iKA==
X-Google-Smtp-Source: AGHT+IHbfpmIDPmqnU8cy+Q9IV2WuX88shLGTNNvcbapHH0ZNP+AcjRX9uwgvLrVr3YI9Yof+6Sl7A==
X-Received: by 2002:a05:6000:40c9:b0:3a4:eeeb:7e70 with SMTP id ffacd0b85a97d-3a6d12dfaf2mr4201936f8f.4.1750728790593;
        Mon, 23 Jun 2025 18:33:10 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e4068esm399198b3a.63.2025.06.23.18.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 18:33:09 -0700 (PDT)
Message-ID: <faf70481-09dd-4c7a-bd43-f1e8bec877cb@suse.com>
Date: Tue, 24 Jun 2025 09:33:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: kill osb->system_file_mutex lock
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, jiangyiwen <jiangyiwen@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, ocfs2-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>
References: <934355dd-a0b1-4e53-93ac-0a7ae7458051@I-love.SAKURA.ne.jp>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <934355dd-a0b1-4e53-93ac-0a7ae7458051@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Protecting refcnt with a mutex is the right approach, and commit 43b10a20372d
did it properly.
However, I don't see how your patch fixes the syzbot report [1]. Could you
elaborate on the root cause analysis?

My review comments are inline below.

[1]: https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b

On 6/21/25 23:56, Tetsuo Handa wrote:
> Since calling _ocfs2_get_system_file_inode() twice with the same
> arguments returns the same address, there is no need to serialize
> _ocfs2_get_system_file_inode() using osb->system_file_mutex lock.
> 
> Kill osb->system_file_mutex lock in order to avoid AB-BA deadlock.
> cmpxchg() will be sufficient for avoiding the inode refcount leak
> problem which commit 43b10a20372d ("ocfs2: avoid system inode ref
> confusion by adding mutex lock") tried to address.
> 
> Reported-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
'Reported-by' should be: https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b

> Closes: https://lkml.kernel.org/r/000000000000ff2d7a0620381afe@google.com
I don't think we need 'Closes'.

> Fixes: 43b10a20372d ("ocfs2: avoid system inode ref confusion by adding mutex lock")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: jiangyiwen <jiangyiwen@huawei.com>
> Cc: Joseph Qi <joseph.qi@huawei.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Mark Fasheh <mfasheh@suse.com>
The 'CC's are also useless.

> ---
>   fs/ocfs2/ocfs2.h   | 2 --
>   fs/ocfs2/super.c   | 2 --
>   fs/ocfs2/sysfile.c | 9 +++------
>   3 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
> index 6aaa94c554c1..8bdeea60742a 100644
> --- a/fs/ocfs2/ocfs2.h
> +++ b/fs/ocfs2/ocfs2.h
> @@ -494,8 +494,6 @@ struct ocfs2_super
>   	struct rb_root	osb_rf_lock_tree;
>   	struct ocfs2_refcount_tree *osb_ref_tree_lru;
>   
> -	struct mutex system_file_mutex;
> -
>   	/*
>   	 * OCFS2 needs to schedule several different types of work which
>   	 * require cluster locking, disk I/O, recovery waits, etc. Since these
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 3d2533950bae..4461daf909cf 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -1997,8 +1997,6 @@ static int ocfs2_initialize_super(struct super_block *sb,
>   	spin_lock_init(&osb->osb_xattr_lock);
>   	ocfs2_init_steal_slots(osb);
>   
> -	mutex_init(&osb->system_file_mutex);
> -
>   	atomic_set(&osb->alloc_stats.moves, 0);
>   	atomic_set(&osb->alloc_stats.local_data, 0);
>   	atomic_set(&osb->alloc_stats.bitmap_data, 0);
> diff --git a/fs/ocfs2/sysfile.c b/fs/ocfs2/sysfile.c
> index 53a945da873b..b63af8d64904 100644
> --- a/fs/ocfs2/sysfile.c
> +++ b/fs/ocfs2/sysfile.c
> @@ -98,11 +98,9 @@ struct inode *ocfs2_get_system_file_inode(struct ocfs2_super *osb,
>   	} else
>   		arr = get_local_system_inode(osb, type, slot);
>   
> -	mutex_lock(&osb->system_file_mutex);
>   	if (arr && ((inode = *arr) != NULL)) {
>   		/* get a ref in addition to the array ref */
>   		inode = igrab(inode);
> -		mutex_unlock(&osb->system_file_mutex);
>   		BUG_ON(!inode);
>   

I agree the above mutex_lock and mutex_unlock is useless. we can remove it
without any problem.

>   		return inode;
> @@ -112,11 +110,10 @@ struct inode *ocfs2_get_system_file_inode(struct ocfs2_super *osb,
>   	inode = _ocfs2_get_system_file_inode(osb, type, slot);

In my view, the key of commit 43b10a20372d is to avoid calling
_ocfs2_get_system_file_inode() twice, which lead refcnt+1 but no place to
do refcnt-1.

>   
>   	/* add one more if putting into array for first time */
> -	if (arr && inode) {
> -		*arr = igrab(inode);
> -		BUG_ON(!*arr);
> +	if (inode && arr && !*arr && !cmpxchg(&(*arr), NULL, inode)) {

Bypassing the refcnt+1 here is not a good idea. We should do refcnt+1
before returning to the caller.

> +		inode = igrab(inode);
> +		BUG_ON(!inode);
>   	}
> -	mutex_unlock(&osb->system_file_mutex);
>   	return inode;
>   }
>   


