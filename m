Return-Path: <linux-kernel+bounces-854202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E55BDDCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C37A4F512E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1731770E;
	Wed, 15 Oct 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnvMr1FH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F62C234E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521107; cv=none; b=mjhWS10ODTp/ArnTcMzt/FRxIj99NXWBqDSkCmr+qtJDJox9L4qRHFLptUJiS0xclLnmRGkezIbV9bfB6RsKtjbn8ElaSPsw9ZPkYYqG6/akXgjXHSMWV+Z7cTguuVEhbvhcpPcnv1KmUBgU2crgWxrpa8pt677gsigUafIq5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521107; c=relaxed/simple;
	bh=b5IS2l0A28/w+gvwMOGIzQ/leVrv34slltb6V0dNgiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mc54aEC+dMjygwrBFqQ4HmwnqBe/davEE6QbtHFJ9ltqGGBE2ItejyUB0loUbot25MCigqgas87ziMQAdTkb9j1raAqWMwEI7JgDd6uPzQ+3l9VMcUdwKZiZfFmp3cRw5rvRoMR3nmHWrHwgNEChvrpJDpuS3Ld2ARNBqrBEZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnvMr1FH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760521105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LSnX3eo6FeCXOk5qdLNLUhr/jZIvyBJy0HqMaf4vWMA=;
	b=YnvMr1FH1KsPHPrB2Z1YyS7wJMi8P/vCDR6yf/M/WAbGCEs8OjkjEmNu5/2wd/5XZUJ+pP
	ZArtB6H2er2w6hvp3KRPadAEk0CQGUqt1Rfv5oqW7aK01kCD+mgxFSd/dHByJXnlQK78ZD
	jW/7jg+j+VM8GIVMmNNKJrDCq+CrG4E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-qw1aske3M8iDiQa9BjqL6A-1; Wed, 15 Oct 2025 05:38:23 -0400
X-MC-Unique: qw1aske3M8iDiQa9BjqL6A-1
X-Mimecast-MFC-AGG-ID: qw1aske3M8iDiQa9BjqL6A_1760521103
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8715f5037beso2625787485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521103; x=1761125903;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSnX3eo6FeCXOk5qdLNLUhr/jZIvyBJy0HqMaf4vWMA=;
        b=V0uHtt0NBy69e1t0dDw41ccL8C/yw/Lc2fQlU0hMBnqAzcs+F3L1+9RldjVpY1xyND
         YKZzrfli/lma77XVwYi7udMXuvdOV5OP7cJXQk7KQRe4g1wmyM5rwhDgMOwmiiIaJRto
         GYOTftIewh8tRd+4SoRb0I3Y2XIRcnQYhfds6T5I7M3Y1gY0BulCb4CrBBoDMJY7xGmo
         ra6+G+HawUumIaVxa+xkz6AxUBmQTOOGLoeLB1g5ijrgjju7Sf0RKhJ9jbM2fEZ4S8cs
         3Bq+DvE56PYCjNuvIoLKw6ytilaiag5T4b64ozGRuOqdrv+0s3aCui2N9rt8CubONY9i
         2wJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY4fb6iSI+heHn4YJ8/DKq4iw/s+7+dyCQVldg1LruZazW4dJSWhqj5rnvUTL68ZrA/LgZ/rziPAfQEbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Qwueipeye/RORqdXdLN0hpXin82tc3dUzhpXubuI6yROSaJf
	qj9B7H3ZkGKpNyMfWSnB7YR/BRFq6y1HePUvnmc8f4/M1udjeRc8AaW0Mb5nMAB/+6alJtUz56W
	E6uPkjlGlUc555AmRfmf4wI3emwDfaqX0mEL68hzoWw/aXIcA1SZkhrvqs84GLyEXpA==
X-Gm-Gg: ASbGnctI+s8zCCR+JqWVffWz3Tsrt9UFLSPLV/dOIfRKk8aIIwj/5y++xF6SM8zm+ft
	ch9xPwSIkJ9C7a+ns49hLZtIGPVaaqFOaXpG6r9qnPtj0U5MTE8TCceoxa7YWbv/Nuho5VQ4yuq
	UjDtDXVPC7w+be0rs+DMAGoLQeTh8h3ashDH+ooeOK/cDvDrs8rouvk4goo2KdCG6Es347RVXTJ
	nU20dj66L9X9z/lR1T8v4Qf7VwiSnXlt9EmW/WWNCZ1Qk1vLBaUenaMKjku1zNUMRUKj8oSEyxy
	cuVxS96vaAL3SEldcagK9/dYkXq65kjWonDNv3PjX8VZfJyOjvwZlOatYNfFxD0=
X-Received: by 2002:a05:620a:bc5:b0:846:1789:c1cd with SMTP id af79cd13be357-8835547babbmr3728921285a.70.1760521103137;
        Wed, 15 Oct 2025 02:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9YggiDFCkRWPoV0rFabAjs5kcH3qOcSU9F7Oo4eJx1pRUhYsQ2aCSSzNGyC7YFs1DlLlE1w==
X-Received: by 2002:a05:620a:bc5:b0:846:1789:c1cd with SMTP id af79cd13be357-8835547babbmr3728919185a.70.1760521102732;
        Wed, 15 Oct 2025 02:38:22 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693a0sm1357643785a.53.2025.10.15.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 02:38:22 -0700 (PDT)
Message-ID: <52c8ac78-7a79-4a92-a371-6fb4520a84d9@redhat.com>
Date: Wed, 15 Oct 2025 11:38:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/khugepaged: fix comment for default scan sleep
 duration
To: wang lian <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Andrea Arcangeli <aarcange@redhat.com>, Rik van Riel <riel@redhat.com>,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251015092957.37432-1-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015092957.37432-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 11:29, wang lian wrote:
> The comment for khugepaged_scan_sleep_millisecs incorrectly states
> the default scan period is 30 seconds. The actual default value in the
> code is 10000ms (10 seconds).
> 
> This patch corrects the comment to match the code, preventing potential
> confusion. The incorrect comment has existed since the feature was
> first introduced.

"While at it, replace the magic value 512 by HPAGE_PMD_NR and use 'ptes'."

> 
> Fixes: ba76149f47d8 ("thp: khugepaged")

I prefer to not have fixes for comments. It tricks people into thinking 
that this might warrant a backport.

Likely no need to resend and Andrew can fix it up when applying.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers

David / dhildenb


