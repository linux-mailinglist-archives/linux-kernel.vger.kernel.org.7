Return-Path: <linux-kernel+bounces-854467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A96BDE749
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742583A8E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4553326D4B;
	Wed, 15 Oct 2025 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTWqUzG5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAC30BB87
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531028; cv=none; b=cMPM/PQ8C1kQyGaZm1Cwg/LNhq07tF+GWy/PO+ZTyjqqtf1YoJIEwDmypzXrxr2Zc2Ks+FCGiYvdN+7P5EvhsLsN3mhDlv3ZfUAn4HDsFsvXxZJO3lHyHkFWeKlZfiemyOG/CBHdhIEvQP+MySivRqx2yHIYmeuywMn389XC74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531028; c=relaxed/simple;
	bh=h+fsC8Z9BvvJwS4hSDkW6YgKXpOcShJtua2SVFVJEGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnaeom9qPpmrH5QKjUHZOKebvJ6isX8R1Yc0m5tLqiZXkCDevRR4qe38NsGgCTEPHqdGiAwyJz3BjqfegrfVDDib/7wQAcClwzXFCcsrjrhRVKjEImBQ9k5WC98XcFOcJY908qYIbwqgSwMqAxvfRh0aKiNIMfFserRWD1DUccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTWqUzG5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760531025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZkqQTWDiFQG/rhmW5z9gOyGt97QuPR5S/ZSPPEuBM80=;
	b=fTWqUzG5Gcn0xi+fRKT7bqie5RvmHCc4c94nlidJsXVzfJjFyg6XeKtlJuIJdhAdOin//3
	3W/I/JvIaVX2ZtcsBWhr5LV8dA+2wguAYHU/FXNxKWWo30gDA97eYoeZLWgF4uUgqKL7pz
	QDXcO9VVacDn0Xr8GItz3xxZATlPLT0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-lTVcSjJmM-KvH1LogeuBgA-1; Wed, 15 Oct 2025 08:23:44 -0400
X-MC-Unique: lTVcSjJmM-KvH1LogeuBgA-1
X-Mimecast-MFC-AGG-ID: lTVcSjJmM-KvH1LogeuBgA_1760531023
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55118e2d01so8306264a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531023; x=1761135823;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkqQTWDiFQG/rhmW5z9gOyGt97QuPR5S/ZSPPEuBM80=;
        b=GMjI1vwMpinQr8GIrIsKStl6gYuEC/3bU5S7b53a7FrPQ9KYUiH5fec955b5lBdxrP
         uIw/70Hl/9I3K8KIYqtCxf11Na1iBKHIZDQkuBxKzhHhE49T0+JoEOE5swlcd+LBVfUL
         fEgbEBALgigwqxKUjsHXJVbhPVl5yqwXimUl6rs4Q3ltIMxySOXisacLKHyLeoXLBGzj
         mqoQHjrIGWaK2HWrHPjzAzSH4juX9rbEKwL9JNQEKQ9zu6RRiG78cEDiQ6zxTDrkxKPs
         tKYVAdmpjfFnzduziskstxzoRmIoHXFOlwh2rbiq3iE900i7OEcUY2MA65+3rPTArOBB
         VzMg==
X-Forwarded-Encrypted: i=1; AJvYcCUrDxM4eqGaEcLEY+ex/ZsZblK5/fsMLRVweutsoIl4BwDYtqY0XQQMHvqrNXm7BbV3QqoBGnXxK7NchGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohSl+irRT1BrJsV5fLcSUIC9IXNPlcxT8v7rHLdNCgar0D8/4
	hEE6NZYUQBscjEqMYnbo8FSVwqJC+luJZYOD8EBuOJj30IjtWgNMp0OKTI3sb3+Q/2uxPTFB7kg
	2dnlnrl7PSLDmdmVccw04FuSw3uJVswPJoDL3e2pO3ZG3ukMcIiWVDyPZFS6AscO0/A==
X-Gm-Gg: ASbGncucCUc6X1M1+w63j2p80I5W2YcTae0NupJ2xFXhvFAWGqyLLT2wB9S8w+eNPBF
	HhWexy8uBrSjTrFCHNaKJUJFwo0mzIL/eHAxLzb9/5f5OOK2BpPhZ27uDGj1BZyZ6KqHdiugsRr
	9Ino9AjeTKiNRmnRbjCGGs1+YayIZbKq4VWsh6Ah+OA7aOGa4CDfpzrMOQH/prVacNs0RE2JQ8g
	Se8tsfpUd+jNc2/QdzjklYcd4pASkUczG1QYXSXOuoax/rJylsPmz9PmIJWMEZmIT576DBbbrpW
	eOS0clb11hyBd6sI+duR6hJVciDiSio6L1fx9c11vvrwd63BJOs2wy1ADRAm0Mo=
X-Received: by 2002:a17:90b:4c4a:b0:335:228c:6f1f with SMTP id 98e67ed59e1d1-33b51168de3mr43078764a91.12.1760531023003;
        Wed, 15 Oct 2025 05:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHphda3lGGfkiLRoBnQzpvHA4Ky6Irwuv735W3mQQQTqQIM8ZJIPop8Z5JRhjHaRWbxoi3uKA==
X-Received: by 2002:a17:90b:4c4a:b0:335:228c:6f1f with SMTP id 98e67ed59e1d1-33b51168de3mr43078717a91.12.1760531022428;
        Wed, 15 Oct 2025 05:23:42 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df2360dsm15222181a12.25.2025.10.15.05.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:23:41 -0700 (PDT)
Message-ID: <b479a6af-1e13-41da-82b7-d4c17e9034dd@redhat.com>
Date: Wed, 15 Oct 2025 14:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge
 pmd
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-2-ying.huang@linux.alibaba.com>
 <4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
 <87ldlcpnbx.fsf@DESKTOP-5N7EMDA>
 <d748bc6b-2aff-4cee-a233-008f4d2555fa@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d748bc6b-2aff-4cee-a233-008f4d2555fa@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>>>>
>>>>   	_pmd = pmd_mkyoung(*pmd);
>>>>   	if (write)
>>>>   		_pmd = pmd_mkdirty(_pmd);
>>>> -	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
>>>> -				  pmd, _pmd, write))
>>>> +	changed = pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
>>>> +					pmd, _pmd, write);
>>>> +	if (changed)
>>>>   		update_mmu_cache_pmd(vma, addr, pmd);
>>>
>>> We can make this simpler, e.g.:
>>>
>>> 	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
>>> 				  pmd, entry, write)) {
>>> 		update_mmu_cache_pmd(vma, addr, pmd);
>>> 		return true;
>>> 	}
>>>
>>> 	return false;
>>
>> No problem.  As long as David is OK with this.
> 
> Sure I don't think he'd have an issue with it but he can raise it if so :)

Absolutely fine :)

-- 
Cheers

David / dhildenb


