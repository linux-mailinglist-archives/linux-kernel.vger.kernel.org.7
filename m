Return-Path: <linux-kernel+bounces-775164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21179B2BC19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148CA3BB205
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E53115AE;
	Tue, 19 Aug 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GcRvVVOA"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC6220F5E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592948; cv=none; b=ap2eaW6Z6d9DAeSm3FLQbtZokM+4JAPakhwgvdviW5ITJ/Dha1y43FDTte3jxI8d7XiXlY5t6sQtBDJyEjE/AXACSJ9X1g8YfY0OYAHRI5ox0ydXcFTuLYvCug2ED5DqmRMnp7Uu1e0ub1hHCHf/dc8ceZAEfwJuxmmm9VbrTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592948; c=relaxed/simple;
	bh=EmQtnRhNzSQirzjzDlLb2H7iNdGldN2PTHlTkkc8qFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnMyi62qrfUYZ+Kul731YfVCgoBNSfiyaJO04PJRjam+Yxwvns9GfEqgusb7VTtkduhpimPpFcVKMMEQwTxpOztzXGZGcHe5ZISJyABy+v89BgtxLzSC8gV2T79J/zhhPFv1dGjI0roIZjJhRfSrRr9gRiuIvtISGlyzadHYcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GcRvVVOA; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755592936; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hv85OKdbUVLLicGnLiBJxS9oGC/z4oA0d2NpFuy29Yc=;
	b=GcRvVVOA/PGwdIJoAp4yKRUqkE69qHSYEiFt9ZjoD32VmFkMRcOG0Xh5twGCyl6ds7hy3wfd7N5hLqRAJt4CtHcfvAPSwOwu8oqEltOv3cg0DzTXNFgf8R161O3C/n2J1z6y8w7M7EYHQhrUAKLLmJEaMCcVImQyjEnO5JB0Dag=
Received: from 30.74.144.109(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wm6eUSR_1755592616 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Aug 2025 16:36:57 +0800
Message-ID: <f26426c0-3ce6-498c-9090-397e93b74d05@linux.alibaba.com>
Date: Tue, 19 Aug 2025 16:36:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tmpfs: preserve SB_I_VERSION on remount
To: libaokun@huaweicloud.com, linux-mm@kvack.org
Cc: hughd@google.com, akpm@linux-foundation.org, jlayton@kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20250819061803.1496443-1-libaokun@huaweicloud.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250819061803.1496443-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/19 14:18, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Now tmpfs enables i_version by default and tmpfs does not modify it. But
> SB_I_VERSION can also be modified via sb_flags, and reconfigure_super()
> always overwrites the existing flags with the latest ones. This means that
> if tmpfs is remounted without specifying iversion, the default i_version
> will be unexpectedly disabled.
> 
> To ensure iversion remains enabled, SB_I_VERSION is now always set for
> fc->sb_flags in shmem_init_fs_context(), instead of for sb->s_flags in
> shmem_fill_super().
> 
> Fixes: 36f05cab0a2c ("tmpfs: add support for an i_version counter")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---

Looks reasonable to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/shmem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e2c76a30802b..eebe12ff5bc6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -5081,7 +5081,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>   		sb->s_flags |= SB_NOUSER;
>   	}
>   	sb->s_export_op = &shmem_export_ops;
> -	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
> +	sb->s_flags |= SB_NOSEC;
>   
>   #if IS_ENABLED(CONFIG_UNICODE)
>   	if (!ctx->encoding && ctx->strict_encoding) {
> @@ -5385,6 +5385,9 @@ int shmem_init_fs_context(struct fs_context *fc)
>   
>   	fc->fs_private = ctx;
>   	fc->ops = &shmem_fs_context_ops;
> +#ifdef CONFIG_TMPFS
> +	fc->sb_flags |= SB_I_VERSION;
> +#endif
>   	return 0;
>   }
>   


