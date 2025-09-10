Return-Path: <linux-kernel+bounces-811018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD016B522FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E5C1CC1B90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2212FB96C;
	Wed, 10 Sep 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI3Z2+Gl"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9472F3C30
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537527; cv=none; b=PlrWeDopLILv61r9Rxp1fc6C7LMPbkE9LEKiLDWyUxO9XWVL9519xcJZo5uepPt0PSeLdgA41fLkHHu8yLHk0QhQhdtTgXlZn9PgQN+rx/yRNNvXXFAyUP9UFSI7b1zBt25Y33h6OehSRXs5EllAokl+5/qhhg7TDF++MYGhBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537527; c=relaxed/simple;
	bh=s1TtveuImqnP0hpIGysAqfx+gnL5Qe3RC5p2R902L/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihKoYokbq9NFynr+mmCnn44vP2CbSu4oJiT64QIe4Mbyhv0az0btw/zTkwUaciOxti6LKrPYB/Pd2vTsJUh/nJ7xr/o95i1Ci8nyGMFo+8R4jnJD+4n7bpUjsjJORxP7/gI62fN8YSzIdniO7x47ee+aapKNjdZKkQwL8e5lQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI3Z2+Gl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b60481d4baso676481cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757537525; x=1758142325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWNfQlk257JJfT1KYHWmeyNUroe/2i7tvfJ15AQHNsU=;
        b=iI3Z2+GlqWEOHMkiMBbBUh3F74zeP55W93AEzQUN7rxa1Khw/lPPlZzB0f0+dTwuak
         VLLTHT+tphWpRD0j4W4K/ylgA76GgJm6TpYf9jnIoN0FF/L91CIv8GzMpFiMyHXnHBKP
         HZfriJQg6MYvHgqPDjQWjIVZjYGh0qkLFIq/WZyU3MWrwXl8HdFx0tZPLc5RCbFYmysS
         Xf7hdDBh8VnezUVfElg3hOLcSJscg2tfNr6jGKNALH10IqZ5NNiNRYCXRy+fehLSsNwg
         jOShdOFrMWKPw27ZMINt3StcPONLrcfiOW7eQQLXHDTfgDKrnWORGnsqpnz6a4H78CG7
         AG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537525; x=1758142325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWNfQlk257JJfT1KYHWmeyNUroe/2i7tvfJ15AQHNsU=;
        b=ZqRsS/UnrvpBOVwc5GylddKRHffNaqsQ76yHBjV41cHZqSX60aV8XDFUZebGfsyztc
         k6hXHGe8mHOzZISBsdDW5fO/PlZupzOR3jMWZBvA1pyWW6GdRlHKDkPRllUchElR8ofE
         dTeqxpTj/V445U9WeTo8YYTA1OseYXn4VwVDtDzX6+fwjsFIJufNErPKnIWpqQhHWkFZ
         l4iZZ3sIm+ghsWsmqgEl1zlE6vbdpiI2WgetYx6Yt+F4bvHLmEDQykg3tpA3M1lTdgCs
         yrheVbCEH8PyFcOeacQT18wouqzufez2fsLEXzjfwQ61MSaH/0LP7YyW11cimWGLcNdh
         0Ltg==
X-Forwarded-Encrypted: i=1; AJvYcCUHs8Ia6J68RdNr7Bwccc1F+C4kqgTxtAi1SdnJeoXwPBz2fTTUhXLtP0A71jyycxDSgy5YKsrURi/JUyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVWsPDnzMZzO0V9BVpsExwlFfMtqQ3PNGLurQgECgY3UUcS8p
	Nfj51PaIu9/oBPFIDWPB9JRUwJWmUKKi/YRzVKclfiWVGyew49taPMbtPWMo5Q==
X-Gm-Gg: ASbGnctpOKCzTFzUqMXjyN7aRmIITHWUSvDfT1xPCc+6FoQOfVdoLXjpA8Ki7rNB8w8
	kc3MifiTdv9cy/QmZMRyoUZsLSEOYlmsQCzCXy2XNyGz8xch/PSyi/LgepRQPARBNTz0nINUqYF
	1iI1lkuM0t0Vcl6prxMro5l7RzOaF7rzgZvx7BWuJIrwHNsU3HgdpbHGdAssvbqsFl/nK8hQnPT
	nR+nXHYJtvje1MTWMXEJEuIihoAgvW+h2mV9j9GMxnxDMBlGnbHKYCgrZc6oOhiv0X8egV50vIh
	xLlu/+mM12GOuMsAyxyrMCVgJXQ2HZ9CgCDFWMhTg1an+EEfVWhB1v0TD6OKrJrMGiqC2s3XlC2
	R1J9sn2+g3hlWZ++jrPvIkHW7fE6zGpukvF4fLAWrz88SJXXYxq8=
X-Google-Smtp-Source: AGHT+IFosu/REDKci4+Jh9k0F5EUAbtHTivVRaQuKcjCuMndGQMzNxwSqOG/Slmd3Ge+SzGqo/JjZg==
X-Received: by 2002:ac8:7c45:0:b0:4b5:e54b:190b with SMTP id d75a77b69052e-4b5f844d21dmr230870771cf.50.1757537524852;
        Wed, 10 Sep 2025 13:52:04 -0700 (PDT)
Received: from [172.20.7.106] ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61bbdd190sm28886691cf.36.2025.09.10.13.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:52:04 -0700 (PDT)
Message-ID: <8c4967ca-a125-458f-9998-6de4f8257dd5@gmail.com>
Date: Wed, 10 Sep 2025 16:51:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] alloc_tag: prevent enabling memory profiling if it
 was shut down
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 shakeel.butt@linux.dev, 00107082@163.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909233409.1013367-1-surenb@google.com>
 <20250909233409.1013367-3-surenb@google.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250909233409.1013367-3-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/09/2025 00:34, Suren Baghdasaryan wrote:
> Memory profiling can be shut down due to reasons like a failure during
> initialization. When this happens, the user should not be able to
> re-enable it. Current sysctrl interface does not handle this properly
> and will allow re-enabling memory profiling. Fix this by checking for
> this condition during sysctrl write operation.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  lib/alloc_tag.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Acked-by: Usama Arif <usamaarif642@gmail.com>



> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 95688c4cba7a..79891528e7b6 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -767,6 +767,16 @@ struct page_ext_operations page_alloc_tagging_ops = {
>  EXPORT_SYMBOL(page_alloc_tagging_ops);
>  
>  #ifdef CONFIG_SYSCTL

nit: might be good to add a comment here that we are not using default as we dont want to enable
it back if it fails once. But not worth a respin as someone can always check git log if curious.

> +static int proc_mem_profiling_handler(const struct ctl_table *table, int write,
> +				      void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	if (!mem_profiling_support && write)
> +		return -EINVAL;
> +
> +	return proc_do_static_key(table, write, buffer, lenp, ppos);
> +}
> +
> +
>  static struct ctl_table memory_allocation_profiling_sysctls[] = {
>  	{
>  		.procname	= "mem_profiling",
> @@ -776,7 +786,7 @@ static struct ctl_table memory_allocation_profiling_sysctls[] = {
>  #else
>  		.mode		= 0644,
>  #endif
> -		.proc_handler	= proc_do_static_key,
> +		.proc_handler	= proc_mem_profiling_handler,
>  	},
>  };
>  


