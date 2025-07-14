Return-Path: <linux-kernel+bounces-730204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 645EFB04155
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE17B7A6E22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA21F25487C;
	Mon, 14 Jul 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxeaDZWa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469F24A047
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502805; cv=none; b=t/40Di5DlSzL3l13cavo9qzyzbg26x1t4wtxDLRJN3C5Mc4MRJmNDSC7OX54e4++e8H72+xhLwWhqkr8QcSn6DjGFV9n/wzVn3qeAWTXXvckdhsewq0P6UV5d/YXIOMWzsebLTYX+3Yx2amBIJ8JmlwhAoTUaFKlZzTmx3QPrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502805; c=relaxed/simple;
	bh=2kRwGEqTOZs7JhXecNnrlyD92qCW3b+lQYYUT4EULdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1faLot7FRNW+utK9pIip+RcdNUPanWTFdbo0by4P/syvxEZTVZfwOKb+yV1N6bCeUuHKysq09ejDCSBdm6tiazF/ZLevSNHaXR8l5rIWq0EjWy6KTySyUTztNXnjAe/Xuingz8iXDgNasrI9saFLNl7CqfzRAlQdOPW29C6AQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxeaDZWa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752502802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4K3RqJrf7KmhwL+3KLLMGGlHCpdHoFdEYm5ankYXqM8=;
	b=hxeaDZWaQG/Dyv/LWCVh+4O1qmpC5shTp7v5sGJdxHIZ0jzs0gQ6IalCu56TDIkH9IWTzg
	6cQs+CTFlOIVDO8q/oQtzRY4KINEl49YWzqRM40bkr7Tb2memE5GEa9uZec9ff464RgnwE
	lMonlyz6FJ1uSc9RANrpszBzR1IUzCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-xGbQJ_bAMcebBXAzSsa-Gw-1; Mon, 14 Jul 2025 10:20:00 -0400
X-MC-Unique: xGbQJ_bAMcebBXAzSsa-Gw-1
X-Mimecast-MFC-AGG-ID: xGbQJ_bAMcebBXAzSsa-Gw_1752502799
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so32117605e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502799; x=1753107599;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4K3RqJrf7KmhwL+3KLLMGGlHCpdHoFdEYm5ankYXqM8=;
        b=qxXesy5MJoKVHx7PXvpHJY4M/J5KZf05XmlVQ09OrKUE363VSf4VnFXvCJGg5unE8d
         TS4gD7zeQ1XYOH6Wt0W8wQUzgOdaypUge/nxGOHLFpe0WyJs4sQdNSUG+8ZJw0K4sVXV
         iYtbSRTlsZugL+ErxVQbj/k0i16Im2fGDsCfaU0PAaO0eEG7yZVcu1AKukmy8IiKL3ot
         0Ao3B3GLlh4Qt4I8O1PcdZVa2awtQCIvXxnlgL6e4k2bpNPMyd3GrFUUITC+zQC9qh7q
         zUDhs9BNUA2Ihkk3vBzmTa+QIDs2mtGwULlztyYH4hg/ktp6mHNDOG0DN09r/RBCmVBk
         wItQ==
X-Gm-Message-State: AOJu0YyYqv1Mho9aOXoETErVaNu3LFdGoc5xWZB2dfzEDkioJotj/cm2
	px6443f4NnXfeQmEPOQH4xb2+MJ5/sW+xDzSFZz9YGSVt7ZplzuZYU1SNMLfkbh62gZjL3TUEbF
	9Jd2A16tk7UIEQzRtsZFa0wctYnV/XqMuGiM7PtYtdGwvP5YjMTWvVHp/tKwhkVqxRy+m38AigY
	QE
X-Gm-Gg: ASbGncsLlIKPuuVJom83/VvllQgye6BPjO39ozAuv8275OJ00dj3v+ibrDyMvfkQ0oE
	aEDhWOG+Z68gnYxgBBLVayTVqJZ9HPjtIIrb9Q3j1hbe720K+mgAVyCKHvlea9qho671rP+hyoI
	F3CwQRBLZ7deGpr6TXFfiwkf2gpZjA/IAHki2XaHiqOFQ6SqUri6uibTatATf38ATGy7V0A/Pqw
	l7+mzU0OWPyu+1Ps7ueMCXyxnUNBFzfY7QN1pDFyBX1vCbEmkYAejKT/WoOm1Ip981HQknGfbM+
	Bx+jLg5tboOouXb/MyCyx1w5leHPzcIrkcd58Ofu6jIsallnFAlbb6F1D5C+0NGc/oxeFgZkl/U
	JpB8d8oEAadDw9IRmXgX5GAxbfO+e25M/KJvDRgq3sntIwfBghA4llfzc5Dkxoop1
X-Received: by 2002:a05:600c:4fc7:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-454f425864cmr140771205e9.16.1752502799182;
        Mon, 14 Jul 2025 07:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGJvO/ssnRl3cckVvvj9d7F3RJpr63ZpTi+x8KpiJ7FTSoA7deoCSAIV4bwXlXkSYtEJB8vw==
X-Received: by 2002:a05:600c:4fc7:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-454f425864cmr140770815e9.16.1752502798724;
        Mon, 14 Jul 2025 07:19:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm12785293f8f.37.2025.07.14.07.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:19:58 -0700 (PDT)
Message-ID: <417888bf-db7d-4334-a8df-678c14c0d442@redhat.com>
Date: Mon, 14 Jul 2025 16:19:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/14] mm: rename vm_ops->find_special_page() to
 vm_ops->find_normal_page()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Vrabel <david.vrabel@citrix.com>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-15-david@redhat.com>
 <aFvCwYDzEOQfpu0G@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFvCwYDzEOQfpu0G@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 11:34, Oscar Salvador wrote:
> On Tue, Jun 17, 2025 at 05:43:45PM +0200, David Hildenbrand wrote:
>> ... and hide it behind a kconfig option. There is really no need for
>> any !xen code to perform this check.
>>
>> The naming is a bit off: we want to find the "normal" page when a PTE
>> was marked "special". So it's really not "finding a special" page.
>>
>> Improve the documentation, and add a comment in the code where XEN ends
>> up performing the pte_mkspecial() through a hypercall. More details can
>> be found in commit 923b2919e2c3 ("xen/gntdev: mark userspace PTEs as
>> special on x86 PV guests").
> 
> Looks good to me.
> Since this seems a "mistake" from the past we don't want to repeat, I wonder
> whether we could seal FIND_NORMAL_PAGE somehow, and scream if someone
> tries to enable it on !XEN environments.

Hm, probably not that easy. I mean, as long as we cannot get rid of the 
XEN stuff, we don't particularly care about new users ... and it seems 
unlikely to get rid of that XEN stuff :(

-- 
Cheers,

David / dhildenb


