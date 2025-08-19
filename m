Return-Path: <linux-kernel+bounces-775045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4142B2BAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6651618855AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E7264FB5;
	Tue, 19 Aug 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL4c7w4Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F82773E2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588362; cv=none; b=Sa3mnK9sTSWMa1Fq6IJ9wFjEj0ny6f9bXJPpoQOtJaG79eWpZXq7wJ3iYbykcfCanRauYji5eF0x2pSqa5JJeQoDjdshKrZ276mlUlaF3sIIBdd0kkPlOZiLzZS4VpPgz2dRhLvf/ck+H5KZSgjOvp7tb6LmKPHfxRFsuvchQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588362; c=relaxed/simple;
	bh=irusahjcgH1FkJMVRqGEPpFm2OpYlwPirZD/QqGE2L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRPRlfp/SbpMMCpo735CYfE7jJ7Qt51vKT+2ary4XxAXz1g+ggrcAu8uEcwaPFlGBGk7SSyLd+gt5Sb7r2IDAQn5XGNRkewHeEDMpEmUWw4Zhm1/jdDIGvuWJg8EfyiJdZA16Kr/hJqkhKm1ODvupT4oEYZtEHQbTisyhSvWBFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL4c7w4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755588359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jHfqlcSubeJn7/W38DDDWlN7ObnUVNPyWAs05D4g68c=;
	b=AL4c7w4QtYTvwlDhWWufI6erZxjfg/eU+tmqeHdq8VGHYYhGM1qH8D3VbfyZ8birZYmZb9
	hD55r19tXHNs2TdTE7MeaD+aGjttu9q2WKI9+ATZYazgENvrtJlYLt4DSF2xKgpfSgNB+m
	i4G/Hlhhc5EgXOn33oZg5xqwRTBqC48=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-Nk7-8pKxPtGy-Z7C_SYqPw-1; Tue, 19 Aug 2025 03:25:58 -0400
X-MC-Unique: Nk7-8pKxPtGy-Z7C_SYqPw-1
X-Mimecast-MFC-AGG-ID: Nk7-8pKxPtGy-Z7C_SYqPw_1755588357
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so21310815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588357; x=1756193157;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHfqlcSubeJn7/W38DDDWlN7ObnUVNPyWAs05D4g68c=;
        b=xKG2jd1z7CQhdaXTMuvwcnoj8WnA/CH+2MemYspEFiFcDwt6fA9ucJEe7n7Q8IS/RP
         WHKm8BhMqwwpN16K+EkdusM2BI9U5HdjG6wK+kJevo8SCCPFCy5fUo7NaArApv4tMMJe
         EYGQTvQtsGwjRX5fe8a/Jk2xxeN84RsudlWuaoefcUkorrCrRXgIiVKHE6L+IP1cEU/I
         0HnQGiaK6RQumDjzUmNqt4NBxl0SOqte/pm+Fb3lSznBAUQOG/ANyc+WuLFV1JFWpNmu
         NexXDSK1kXxMgz+vVjTYPOnJyBtynxNSOZPYvza/+1M2mrgztUHrKJFYu0WwpKrYHotI
         O7dw==
X-Forwarded-Encrypted: i=1; AJvYcCWD37nNA/MS57ZCoyypwrh0ixV0jslgge2xuuWefQHp1zrTITtApTZsgP1YOPHEPIQSSLXXwULr//Qz3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPV99lxRk8ox18D9uQnZQ+jSYwgvTzgbpAfAxOaY21IHmc4Rea
	BGN9VGZrU2/jX9UJfRouglYjFIkjwbpYTyhWE6cIkjzfiWYFnR1gUolZyI1Ke1C7/HW1pik9/Cu
	HGj8xcBf2OMb29UGzpuLnmmroFjOb7H2uO3yp2yHsLtZGs3t3pM1I2ZNUeasyhpg+SA==
X-Gm-Gg: ASbGncsKIrKzq6we3+Gxw+fkCoCIg2TSKfdjfuhgY66amCrODW+JMolR52sKfnpZvEa
	RKRU/iG8QiTSJNpW5/VJRICcYsUMB5a1e5yQn5H0rb7GW1nlJQHLemaZQrD9xCFyOUI8lWMdfzG
	ycIQcbf/jO/AuI3ihEytMeLvE2GhG1GcVHgeae3Ow1xH9ZAia2n74ETdw+Uyng3gIOtAkf0Lew9
	KSzYsML8ybE68oCo1VphqRdzVf/MkTeQ2LVJSYTa/WJHKpMqLSQ9R3vqUXfWRDON/l1H8mg7lQZ
	tym702oWwVlRYzCoYDpcdFtzi7GyZ9UKUsiVgKIgQtCnS+V+qjbw7Gz1ylAJ7712YxgmzlkfWmS
	NYcgYLDEA0aEHsjCHCml7Mn4AVJhOupYxy56J/xKe6TLk1fPamVKwZ+2LEI8OjGu1G2s=
X-Received: by 2002:a05:600c:358f:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-45b43f77da0mr10625495e9.7.1755588356738;
        Tue, 19 Aug 2025 00:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiCUhqGQNn0Jp/QYUQ0I6wiZbOyiVGMzK7ZWG8eNWkfWyIP3UZUKCKLtKKgTXe7raIvIZrIQ==
X-Received: by 2002:a05:600c:358f:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-45b43f77da0mr10625195e9.7.1755588356252;
        Tue, 19 Aug 2025 00:25:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a24e5562csm146699305e9.20.2025.08.19.00.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:25:55 -0700 (PDT)
Message-ID: <8142d36d-2a0e-476c-8250-1a69c1f92913@redhat.com>
Date: Tue, 19 Aug 2025 09:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Fixup PATCH] mm/selftests: Fix formattig in split_huge_page_test
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250816040113.760010-5-aboorvad@linux.ibm.com>
 <20250819041239.167537-1-aboorvad@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250819041239.167537-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 06:12, Aboorva Devarajan wrote:
> Removed an extra space in split_huge_page_test that was introduced
> by commit 4b76e221794b ("mm/selftests: fix split_huge_page_test
> failure on systems with 64KB page size").
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 54e86f00aabc..faf7e1f88743 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -544,7 +544,7 @@ int main(int argc, char **argv)
>   		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>   
>   	nr_pages = pmd_pagesize / pagesize;
> -	max_order =  sz2ord(pmd_pagesize, pagesize);
> +	max_order = sz2ord(pmd_pagesize, pagesize);
>   	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
>   	ksft_set_plan(tests);
>   

Please just comment next time one the respective patch as review comment.

-- 
Cheers

David / dhildenb


