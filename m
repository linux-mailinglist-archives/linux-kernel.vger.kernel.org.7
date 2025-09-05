Return-Path: <linux-kernel+bounces-803186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C681BB45BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A71F16551E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3F2F7AD4;
	Fri,  5 Sep 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8IljYjC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9631B80C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084535; cv=none; b=qnKOtXcXe5YRhMX11IFvNLEoQXyzxFiD7B/OaIbY9Vrmek9e3bs9GltytXgLj2PRiWphvNNn2QsYoV6Gb8ZlFtr5Ba1NI5Zw+3zCCZrLEB/KDmeM4CxBrikEs1ya1NtJuZGK2LMcONdh0yYqsfFci9Rz1U4jUP8pQCunDC4tfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084535; c=relaxed/simple;
	bh=EEnjxsfg3GqGVY8KznxCWQl3dReDpCLSkFRHyYHNJro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmKNCcxWgEekr/T8mZldOpSlCIhrGjdubs6LzXEda+F+qmUBnBdlgP8K0iK2QYnskehuCFwUegtYlUdmTId4cS5wmmKfiVRfqYiS8KHKHkplYPApjx3CVgSwzrOp+pU2Ag8Us52DSzfRmM0Kndw9zNxf7odbyrGy478k44y9LMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8IljYjC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b7d485173so15320715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757084532; x=1757689332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EaoMsxZI8Yhjr/Cd8wW2J9rqvrFj5skzpXLsWrxWtPM=;
        b=E8IljYjCN5p20Vb64ElhP93xNh+QyKZ6q6LBn3nKahSYOJcFyMePRtCxmzlcCjHaHF
         I/Kiy3ZMo80TTiS53QTh8IYUHHiN1I8Crll7gBuuYwQsUPCJpgpCl0X34MCRjG1HxQhR
         LemwoxPrmnFe8beRDzRgNAXRgPhqdRhCyYzn02juAyYWzp/7zXSAd9YHJOQFQrcrcNC1
         RRH/Qlz/H4k9D5Vn5nKJrtPgNO+EcmxEcni3vCk2uj0d8JJu3qaqyYqN0aZz+WNqQB7A
         g0mGcf2Ud+oY3XqoTU0kcMAc+0faqUtFxuZL8jrKAxtqEpcFg0BE9QlIDqG5dfktP2sJ
         dqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084532; x=1757689332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaoMsxZI8Yhjr/Cd8wW2J9rqvrFj5skzpXLsWrxWtPM=;
        b=QwKw2D39EbomaJFrTTvRYk6j5coaDVaVYJEaARiEfhnyGVfi1totwv0mEMOCTQQzeT
         XzEmbpfa+7d6Ni65FmwCWGNGM14+uW2+qW2ko4ZXnE5a12azL95CpI5nLj/yjQXIDqFg
         14LWFW8hM5WKy6HE+v3xwShvfedmAEkWeR6FxqWw3gj2sPmv++DwtpjLOfDKtuRfRWbG
         QP2QPRgEfA36VaFEm2cc9+jnlg5UYJOvmNnlS9Krf2DGHB2eUTR/z4SFVTw+R1kc/SW3
         /N5bQwvfclrkmK2gvimJkA3w63v6B4dUy0ePSKiITgRzTA7Z10neSOvTYX0Q3aRnnrfY
         8OCA==
X-Forwarded-Encrypted: i=1; AJvYcCWggazp01S6jC69yCeoYjhEtHP1rUKTgNbbwtAE5bUgCfyNPa2sfh2ePJb7qXUA/oIdute58U964xoa6Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFD2XvtUAV6e/40kTUh+ZXEqxdh0OL8j7hjEBaSHFPPHWVsUC
	puzC8alTYg5vU1+qvwzKzGQAj3Ch0vjVPKOhThQ8gtPE9Q0dfgTbjELo
X-Gm-Gg: ASbGncuqvq/ZWqz6WC+8Eihqcv6UGg1ZJb+tdKkWvS/LhIxzaQ5i5jZ6+OIoXHvO0rr
	yXe9XbQe4ZYwiEGdSkrSxGNPZg5+DWIa3+9cnVIWFVcs2vajZrfmFvMto78ituDSQXAwZPiZNoR
	ugZ8rBc5Bp2HKtLZ8V0Qyjurr6pnSNqITbO0hIV09lM5gybeR9ABy+VoBklx8ArdGUt/5VMTvZA
	tfBlHc2y1JMgY+1qx3Y7w9IfyLnW16n/FlE2ypDnATxt3ePlFISMusmKPcl08yNu+NqVsnnEYhW
	ovmvvmRATfP8uiLb9rZB3f7i/e/Q7nqYfzyckrTdH0dCYkjW6bKPC2gxlJAjyY3cW5FAsCpxgJl
	2N4g6y2N0s6Y9H7MElljIIiuL9tvUyaJ1LFLvBRaArDrvsGGAL9pjM8ReYtKV1LDC81aBI2tXAJ
	H0aBXwUg==
X-Google-Smtp-Source: AGHT+IF52tc+2jGHfWNG+jCjR5B3XPESudwQYDdGn/o+8RZIPAE7fMw1zT471GgS3WKZBqGf9FluDA==
X-Received: by 2002:a05:600c:3543:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-45dd9abbaf8mr22659165e9.31.1757084532079;
        Fri, 05 Sep 2025 08:02:12 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add504sm31413426f8f.30.2025.09.05.08.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:02:11 -0700 (PDT)
Message-ID: <74906d5a-a838-4f0a-8f07-532c787d3540@gmail.com>
Date: Fri, 5 Sep 2025 16:02:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250905141137.3529867-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2025 15:11, David Hildenbrand wrote:
> We added an early exit in thp_underused(), probably to avoid scanning
> pages when there is no chance for success.
> 
> However, assume we have max_ptes_none = 511 (default).
> 
> Nothing should stop us from freeing all pages part of a THP that
> is completely zero (512) and khugepaged will for sure not try to
> instantiate a THP in that case (512 shared zeropages).
> 
> This can just trivially happen if someone writes a single 0 byte into a
> PMD area, or of course, when data ends up being zero later.
> 
> So let's remove that early exit.
> 
> Do we want to CC stable? Hm, not sure. Probably not urgent.
> 
> Note that, as default, the THP shrinker is active
> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
> THPs are added to the deferred split lists. However, with the
> max_ptes_none default we would never scan them. We would not do that. If
> that's not desirable, we should just disable the shrinker as default,
> also not adding all THPs to the deferred split lists.
> 
> Easy to reproduce:
> 
> 1) Allocate some THPs filled with 0s
> 
> <prog.c>
>  #include <string.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> 
>  const size_t size = 1024*1024*1024;
> 
>  int main(void)
>  {
>          size_t offs;
>          char *area;
> 
>          area = mmap(0, size, PROT_READ | PROT_WRITE,
>                      MAP_ANON | MAP_PRIVATE, -1, 0);
>          if (area == MAP_FAILED) {
>                  printf("mmap failed\n");
>                  exit(-1);
>          }
>          madvise(area, size, MADV_HUGEPAGE);
> 
>          for (offs = 0; offs < size; offs += getpagesize())
>                  area[offs] = 0;
>          pause();
>  }
> <\prog.c>
> 
> 2) Trigger the shrinker
> 
> E.g., memory pressure through memhog
> 
> 3) Observe that THPs are not getting reclaimed
> 
> $ cat /proc/`pgrep prog`/smaps_rollup
> 
> Would list ~1GiB of AnonHugePages. With this fix, they would get
> reclaimed as expected.
> 
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>


Acked-by: Usama Arif <usamaarif642@gmail.com>

