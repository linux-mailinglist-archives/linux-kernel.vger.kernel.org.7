Return-Path: <linux-kernel+bounces-837493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A279BAC6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A7F19235CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7132F744C;
	Tue, 30 Sep 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iAeOnS8f"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1B2F656A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227222; cv=none; b=VG2Sv9reUXpYhnG4B4tLr2C2ZrYGo6WNKD+gUdBIHckL+6da7vQDF47eUc7vhjkO4yH8oo3dECT7z1G9ALdgfDEJn0NzQL7xWZUNUL+4buGgjp9JY2J1IOYf9BdCgExQK9CAFUTKOG3UOmGFwj7qDJAA0Nlx76pwP6GhYpO69ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227222; c=relaxed/simple;
	bh=mpP7G9JCL9PIhzSHc0S9qvP24/HlpcKMgjRpGUGS8CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcSOm//BJCZATa1aWGQk0jtmTm7iJJ1JzmKOrbo1F9BA3esSAMzoliAL0oXbpjNlx2EcYHp9fkgo5f1PvFw9AL2pAMm/p1wcdND/tDnZLPms3YXp5zZCqPMIn48Q47k3RdsiKxGFnyGQs8pC8W2jdT5lGgNmUgnGq0AxeN9+czA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iAeOnS8f; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f637f793-7979-4817-bfb4-732ddb7d2e32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759227217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZmqSQC1HjW/If1x8PYxKuOR/oWq1mejmSvIWyDl9Gk=;
	b=iAeOnS8fKLsSALcaZT1eCR+NEP2Qc+GEKd9yDnqSeZ4USGAs7Z4te+iKr6fGiraaAMLx7h
	kFbfnHSm1htYKvpBBXMnL1fzMM8sD4Tp+n5dXTz48B4vubJgAfbuEqM1XNA6kfCL0sZHtM
	VnYdniHNblgwbzdi/vzQOd6qjS2ct50=
Date: Tue, 30 Sep 2025 18:13:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Jiaqi Yan <jiaqiyan@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org"
 <baohua@kernel.org>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "Chen, Farrah" <farrah.chen@intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Zaborowski <andrew.zaborowski@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
 <SA1PR11MB7130ABC25E060D2CC4749E45891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
 <SJ1PR11MB608350E5169EE77F86A51E2FFC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SA1PR11MB713082CA93E9B1C5F22CFBBE891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
 <c1294b63-eeee-4d99-82b6-93eb3a6d0af9@redhat.com>
 <CABzRoya5wuXoMWuGb_+F0oBc0mCDVrjbXTZsoMwcfRT99Y5z7g@mail.gmail.com>
 <c980f6ae-ba44-425b-b7bf-511cb6957c2d@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <c980f6ae-ba44-425b-b7bf-511cb6957c2d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/30 16:53, David Hildenbrand wrote:
> On 30.09.25 03:48, Lance Yang wrote:
>> On Tue, Sep 30, 2025 at 3:07 AM David Hildenbrand <david@redhat.com> 
>> wrote:
>>>
>>> On 29.09.25 18:30, Zhuo, Qiuxu wrote:
>>>> Hi Tony,
>>>>
>>>>> From: Luck, Tony <tony.luck@intel.com>
>>>>> [...]
>>>>> Subject: RE: [PATCH 1/1] mm: prevent poison consumption when 
>>>>> splitting THP
>>>>>
>>>>>> Miaohe mentioned in another e-mail that there was an HWPoisoned flag
>>>>> for the raw error 4K page.
>>>>>> We could use that flag just to skip that raw error page and still use
>>>>>> the zeropage for other healthy sub-pages. I'll try that.
>>>>>
>>>>> That HWPoisoned flag is only set for raw pages where an error has been
>>>>> detected. Maybe Linux could implement an
>>>>> "is_this_page_all_zero_mc_safe()"[1] that would catch undetected 
>>>>> poison
>>>>
>>>> This sounds like a great suggestion to me.
>>>> Let's see what others think about this and the name (though the name 
>>>> already LGTM 😊).
>>>
>>> The function name is just ... special. Not the good type of special 
>>> IMHO. :)
>>>
>>> Note that we'll be moving to pages_identical() in [1]. Maybe we would
>>> want a pages_identical_mc() or sth. like that as a follow up later.
>>>
>>>
>>> So in any case, make that a follow-up work on top of a simple fix.
>>
>> Yeah. IIRC, as David suggested earlier, we can just check if a page is
>> poisoned using PageHWPoison().
>>
>> Perhaps we should move this check into pages_identical()? This would make
>> it a central place to determine if pages are safe to access and merge ;)
> 
> I would have to go into memcmp_pages(). Would be an option, but not sure 
> if we should rather let callers deal with that.
> 
> For example, in some cases it might be sufficient to just check if the 
> large folio has any poisoned page and give up early.

FWIW, one idea I had was to create a unified pre-flight checker, like
folio_pages_identical_prepare(struct folio *folio). A caller could use
it before a loop of pages_identical() calls to pre-check a folio :)


