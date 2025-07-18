Return-Path: <linux-kernel+bounces-736389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E20CB09C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8903AFB74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E821A436;
	Fri, 18 Jul 2025 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+uReOBt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312A213E89
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823335; cv=none; b=R/8agZTBu6QW37yBIol/c1KQXvJXaJytzT+7CMrMlCuy3ACp5rp9ACqOHdqoKfUp/9+gN27TJerZ6nUO09g9PN8VeRK/mtg8DtUhk7w6d2agZciklTJZf40toQgFHSHtpD+lu9iWpzyFSVTbjWUDVonsT1D4h6moZoGREdfGkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823335; c=relaxed/simple;
	bh=t/HHasBPB+Z3ebdXX/zG/+58pzVRMqnINLQNTgY3Ong=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjFOM/Q0WG0z2JrQylKMVMb30vNU3nA0MP8rLMFqDLvCq3YMPVOo98VFlPt+mFLIyNVyugn+WaVlWXFu/bgcCwmR3Tb+467Kks7JgeyizfiwYZqGBC4PlZJBwvfH+zseUWRFDgWBDgAkEddww4G36lm4jzTyI/44s6nE8yyDSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+uReOBt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752823332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S64nmm1CmYXTsKNjLLVJT9xjGOP5MhwT+RPhwkoKmp8=;
	b=M+uReOBtXC5YkmaPSOlXJtTlL0LOYnlbfzJg1VVkYuRI7dibgIQswhYdEYRTsutsvHiLwa
	0U6Zp+Hts7wXT8m0XQEiZqkksZ/VPO+uPAouni9vSDBK+mFEjT6pisP9QQcjBg0AvIZ4Wr
	fZ4I5NFxahpMqxEon28Y18WlDth1+Jk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-ucyPUODMP7qX8bTZPeySFg-1; Fri, 18 Jul 2025 03:22:11 -0400
X-MC-Unique: ucyPUODMP7qX8bTZPeySFg-1
X-Mimecast-MFC-AGG-ID: ucyPUODMP7qX8bTZPeySFg_1752823330
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so1237299f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823330; x=1753428130;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S64nmm1CmYXTsKNjLLVJT9xjGOP5MhwT+RPhwkoKmp8=;
        b=dC1bzkv/bU/W6YmSqlvBmmvEi5IrTtiNUKt9H+u6+b1B3268OdcldrroAUwnyvGDQ6
         sFo2vYbkFIrppin5Wy/vZ1lm59+gyiHSqLoARwfFa5Eogj9HkTtfR+TDPRxYK+5MEGWb
         pU3yJlgOrhII6ywN9d0Vlcl162QeAVs4e6zAlq7efU5OgzU1xJDKEe4p/OK823LFiix6
         ARU8nnRI9/D2McF+nbJIHbHoXLyO0twA3toAliZUzlvKeJKn+o5uAS5pFQY83O1z3inP
         CYeKicrsseot0VJi4C1c+rachPv1dEpGLcJa9Pkt+SIyeHOaiB+RJtk2WN0nfq6Pj4Hl
         OHaw==
X-Forwarded-Encrypted: i=1; AJvYcCXb8z/2YWMFLpg6W85oAG47OrFXexhuwPc4abyqwBizIEnl+H8lYgbqKdQpkX9O3KNKJmfaZXNCqg2QwW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVktLv/citEoVMjjuyCLy4ySEk+pBJoV3oqkMRmeYGYtF6xsUK
	1I0/ukZoAiYgfaW2hyygtq2Q2n87FCcb+vk474E05gCJoNeX0h6FZE9gJc3dOtrdHv/HUs4Y2Ec
	z8uOgOEzSsJM3LIi9p/TzQRPhfZcD7zlCULbmSflWojv/P1l1JCQDS1htSiz+UVFB5g==
X-Gm-Gg: ASbGncvqOSmked7WYgxG9tywa95RgjCvTFhCqigcMIwAN82QXJ/994JtctsvqxW+8ca
	M8rm3MPDnt4hrrP2rQ/f2WQuc///Rdhti6rnrVTCDO+BMod2tWKR1yPWNJfCSkbqLgVKhYbwwZ1
	FcZbLuWuMGKUWnR6bWZj1FhP9u6RONQUt+YKCJzDy08TQvrrWxMtb1CMtJTSv9mI1fRGda79V+k
	ZDjRgEAXIulY2K3aoArh4krqMgLTLrX6q4nrmGbO310kXPYuq4S6f8Nj2CjHdGYI+203Iq3gICU
	R7u1qaFsyxURuXLZgPPfrIGB1MP/h/9H5npf7il0Toxki5JHJaypLEdQcjuMpxtvnCgHPZ5OVTi
	0GPw80jfbkbiyIlp0U2Qo4q/SbzTTkd+xcA4UJj4PxQU4L3YPhFSLvYpxLepnqxdNB1E=
X-Received: by 2002:a05:6000:26c7:b0:3b3:a6c2:1d1b with SMTP id ffacd0b85a97d-3b60e4f2e53mr7044465f8f.28.1752823330010;
        Fri, 18 Jul 2025 00:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtcDpZB4AC3Qf1+73jluGyxsv5vKKt6WgwtoaUdWufdaaeHjQIUXlAFhprYhAV/bBWv2gGtQ==
X-Received: by 2002:a05:6000:26c7:b0:3b3:a6c2:1d1b with SMTP id ffacd0b85a97d-3b60e4f2e53mr7044431f8f.28.1752823329539;
        Fri, 18 Jul 2025 00:22:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm1024933f8f.36.2025.07.18.00.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 00:22:08 -0700 (PDT)
Message-ID: <3ecb7e94-c0c2-4dff-98bb-a9e32a48c369@redhat.com>
Date: Fri, 18 Jul 2025 09:22:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm/huge_memory: convert VM_BUG* to VM_WARN* in
 __folio_split.
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Balbir Singh <balbirs@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-5-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250718023000.4044406-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 04:29, Zi Yan wrote:
> These VM_BUG* can be handled gracefully without crashing kernel.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d36f7bdaeb38..d6ff5e8c89d7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3601,8 +3601,14 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   	pgoff_t end;
>   	bool is_hzp;
>   
> -	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +	if (!folio_test_locked(folio)) {
> +		VM_WARN_ON_ONCE_FOLIO(1, folio);
> +		return -EINVAL;
> +	}
> +	if (!folio_test_large(folio)) {
> +		VM_WARN_ON_ONCE_FOLIO(1, folio);
> +		return -EINVAL;
> +	}

For cases that we handle gracefully you usually want to use

if (WARN_ON_ONCE(..))

because then you get actually notified when that unexpected thing happens.

I am not really sure if recovery is warranted here: smells like a 
straight VM_WARN_ON_ONCE_FOLIO() is sufficient, and catching this early 
during development that something is extremely off.

-- 
Cheers,

David / dhildenb


