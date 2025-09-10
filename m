Return-Path: <linux-kernel+bounces-811015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36707B522FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC1A586B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DFE3081CD;
	Wed, 10 Sep 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQMBLw5D"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3B2F546E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537352; cv=none; b=XAFsB5wDB2jBeTNOw8H7PfAbjyYkKuLjOl7sdY2wqRexQt6JUciWvKEwi963Wk3aaHncV8wRbexqtve/Tf9YIWkdXqDmo4T23Dz/7IpiCd8n5JPIp+VOLfNV0/fbck+63TLHq0b/4hafKAS4mjtaxVDRGUVa7USLE2h9c9PXck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537352; c=relaxed/simple;
	bh=kocdpr+5Hpzb3+6EdPtF6aVjU5h3/r53kE4yaBVZ5TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li272aZmOrvUVLiTTBU8/NrykLb4lH/Nq95JdkECkm5JiDwSmNLKS1OwVpAVVHNrM9g0lg7LXFsmbZYIUH8cfW4qWmNfbFuLyCPQxiGAianTEc/V9Y/g2T6i+sfOCEza940FdddGjaNMiTj0TYhXtA4sncLOqYbTmnYzvWV+vMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQMBLw5D; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-81076e81a23so849081085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757537349; x=1758142149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdKNnUqR+FthWHSkVdu+kDWg2jegsxHUPzCEEZJSG9Y=;
        b=AQMBLw5DImsaD9nS9LVdPo7xXpzIFgWcEPTcfkzYQ36AWsAtFA/iXLAaHgwy6KfX84
         0FJB2gWGbaRmitPytWZjsaaLLlu0LIpS76zUkNTWtcWR/+o6RFcfYrrfeSahCHSxSifT
         H/7OJBGpnxLz6GQkdjKVV7jFc53c9LaO3QW6JwbeCl8lTccfQdsFMR9FtlMjGZr1DoMN
         1abpwf7VHKYoCSh1S092n6inrFqXDTDQp0ZlFR17lwowOdwuYfF5pXe718sfKQUvgtIB
         KwEy7XXhDdN4tvQIjIT7EMPNGYab8A23ANDP+WdIUIECnsLKIVX86DhrTAJib482mBJZ
         g4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537349; x=1758142149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdKNnUqR+FthWHSkVdu+kDWg2jegsxHUPzCEEZJSG9Y=;
        b=k0VPxPNnkifIH8ReQ3EpwteEwG0kqlgWfM86QTowNzoMc60bWKTbhNBpmIOw0iFx22
         xPW8tF2nHjFAGsBgAgkTtpNVJwCfTP1jxOst/eMpwAWVA239lcIPf0hN2fylDB//027V
         MYYLr03kAAxiqFeQgvu9VKJEH9fWuRPd3W0J2nkD1W4nUAEb2wYd19jjrFNnn0Jfm+WK
         65nByeMeyJi3RqHJpFfyJIxVTVJ/bwsR4jExJE4NN0vVu1XcU/h3yzKVZI/bm8VngQzI
         /iww0Y9R99BdZa5YNPYKdzpJp6bPXCa1tKZcpuLqt6csxzZvhZEHFUrXaWpAthqBZnrk
         e2QA==
X-Forwarded-Encrypted: i=1; AJvYcCWTAlH3i9+E2ZwLgfsFTTVMtvkj3cgpaGzzESlhBNuaAyuUCZ9yrduW74CZiXGt+LuzUde1uYjdv1lxAcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BCJrXrMoeMKsx6Y/3hork0Pk1GdOFmuhzzwqcigXY43j1Hwe
	3glxE09K6WwK0w+dprdlRQt4w2fyjhWjcmUTxoqKOBGbkh1Vp7LLBo8C
X-Gm-Gg: ASbGncvQeeYtLBkXkPgV3YM2DFLz+P3Dwsu8NHUKMkkjXCJQuC+G+n3FCMWoFiIdo8Z
	4CIuxm3q75knpCF2zEeiQIyT9ru0fBo0ZejXRaeJXKuxYa9Ao/YHevgtjHh3e0pmJD7MnrPAa38
	G1wAv+l9Lf2kFFEOfmhDiIrctUDJ0IhRaibOMfTwoNbkJFMx1CkMTpr1OxUg9jBBh4o3l/ftl88
	OcazzE1wr9PcSFJ9hBlhadR4hB9d9A5qr7ABgbhFOuTDWjNXL33R7nMiPXjgwRft9i5SVaxfAPW
	/zgdBoNMyXPuf8x5twDObZHnHJgCWlISnZpWNKVWfYfk0Dx1ZBd6eqoMFstm1DMHGA0LRcqplvb
	OZfn8GZtE8wS785fnWB5r/w/96Wf3KHXActzaNJtn
X-Google-Smtp-Source: AGHT+IF5t9CgVNGthj48BfL5VlbkBf29lx5nVEid2Z4AgsD1UqZumkmImiNnxSRYun/vml+FuDG4AA==
X-Received: by 2002:a05:620a:4385:b0:815:3483:21f6 with SMTP id af79cd13be357-8153483258fmr1982394485a.72.1757537349179;
        Wed, 10 Sep 2025 13:49:09 -0700 (PDT)
Received: from [172.20.7.106] ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5e5bfbd5sm353061285a.41.2025.09.10.13.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:49:08 -0700 (PDT)
Message-ID: <c2efc885-8b23-4ef9-8eca-05f17e158fb3@gmail.com>
Date: Wed, 10 Sep 2025 16:49:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] alloc_tag: use release_pages() in the cleanup path
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 shakeel.butt@linux.dev, 00107082@163.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909233409.1013367-1-surenb@google.com>
 <20250909233409.1013367-2-surenb@google.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250909233409.1013367-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/09/2025 00:34, Suren Baghdasaryan wrote:
> When bulk-freeing an array of pages use release_pages() instead of freeing
> them page-by-page:
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  lib/alloc_tag.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Usama Arif <usamaarif642@gmail.com>

> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index e9b33848700a..95688c4cba7a 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -438,9 +438,10 @@ static int vm_module_tags_populate(void)
>  		if (nr < more_pages ||
>  		    vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHIFT), PAGE_KERNEL,
>  				     next_page, PAGE_SHIFT) < 0) {
> +			release_pages_arg arg = { .pages = next_page };
> +
>  			/* Clean up and error out */
> -			for (int i = 0; i < nr; i++)
> -				__free_page(next_page[i]);
> +			release_pages(arg, nr);
>  			return -ENOMEM;
>  		}
>  

Maybe this can be done in free_mod_tags_mem as well?

