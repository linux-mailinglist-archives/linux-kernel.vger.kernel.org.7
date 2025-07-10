Return-Path: <linux-kernel+bounces-725136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C50CAFFB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADB03B1E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FF289835;
	Thu, 10 Jul 2025 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="veD5lLKJ"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077F1A285
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133322; cv=none; b=UY7KNICs26/Sq6cW7Dx0WErFkFjh1WZVSPhdpGg0KeN4dBpLUD4NLvdr+KNRJ71sKXF2TlJbjXdJWI9vuxACn324XLGXatyctni1NX8UKLtuBxY5blN0aNoiaN32u+j1kjfRacjJNAguuUDNJBJS1xM4Ibqech6DVKZ2t92wOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133322; c=relaxed/simple;
	bh=io/O9iEK8acfRrFt/kVZxcROXYWEKtjWTISLvede08E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjuOdUqNGGa/xGopdBw9UWOrh0dbkfd+0jiun5raQVRQVr3rBtBYhsqEwNljbtxb06h5dIlmxXgsVzw5S1PxEQ9PG3wBCAeZDtmRH4QBSVtsrlt83W+XPYgMCX8XjHzu3WjZWHbarK7pTN7PO04W4aiqS2+ZTdKJoOT6kQabM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=veD5lLKJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752133311; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DMjplhNJqUQSclZDRNVMXu6TwMBThFiq5ml4fAhr1ck=;
	b=veD5lLKJsJ01ahu+8SLJm+x+Uu9ZrRrVooL86GJqTxFRIFf9lWbVeU96MM4Om/lafnj4hk4gEUYlSh/JGZtoeYRzQMs0N8M2NCEjli0X12o8oy0FqL6DsbWBw4qi51+pJbUYIvOfmJYvLPaqZ/L8MjzTZAOTo+FxXkJ0eizFFkw=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WibwoAD_1752133310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 15:41:50 +0800
Message-ID: <a4ab45c9-b3d2-4807-954d-1bd7d38b7242@linux.alibaba.com>
Date: Thu, 10 Jul 2025 15:41:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: allow readdir() to be interrupted
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250710073619.4083422-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250710073619.4083422-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/10 15:36, Chao Yu wrote:
> In a quick slow device, readdir() may loop for long time in large
> directory, let's give a chance to allow it to be interrupted by
> userspace.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

> ---
>   fs/erofs/dir.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 2fae209d0274..cff61c5a172b 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -58,6 +58,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   		struct erofs_dirent *de;
>   		unsigned int nameoff, maxsize;
>   
> +		/* allow readdir() to be interrupted */

Hi Chao,

It seems that comment is unnecessary since the following code
is obvious, if you have no objection I will remove this
comment when applying.

Thanks,
Gao Xiang

