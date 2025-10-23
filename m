Return-Path: <linux-kernel+bounces-866647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ACAC0057D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF793A7CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55744309EE9;
	Thu, 23 Oct 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="F2BVoFJw"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941C2D8371
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212891; cv=none; b=l/jEuxvDRDzhUVYGPq8Gv5IzoOy1+pqL4Yfx2YcTnW8jCvsXw7/tywsEu1Mj8AzJGy6TCgYegMXYpOfzoe1t63QcxObv46lsNXlBcQx6VDl6Po5eeay/g4ektlMgeCA+AgPhu0gA7gd88mj/fNEEDg1qBNTm4h+rjqT9XmlxcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212891; c=relaxed/simple;
	bh=zKd0UN4IByvvWBm0OTP/N95g6Ao0hAJUcAzbqbxZfHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVdyUZBRUIB4BDoJAEK8ZeHzTKBuldUEzM0z4huIodBH8fDK2orTn/nCt3ZiUKL8fJvGubHroEQU66qOso0fqOAABmR0sLFWyCrnkfzLRWabpFkMy3F9NMUCe1Ma5KNutQ5dtyNqOmtPYh0yj9BlhdJWTEhc41e3cjUFNqwKQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=F2BVoFJw; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <666ce353-0fc4-4f5f-9e5d-9bb95464e939@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1761212868; bh=zKd0UN4IByvvWBm0OTP/N95g6Ao0hAJUcAzbqbxZfHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F2BVoFJwhukSSIWijGQp/8QDLgBg7x7u7rPetIFHa/bnPRBOcChuLZnddqPkH49Pm
	 y5/u0Zblf5LF/5AA0gaCXrY3nbY8s5tH2cOgKgyMJC1qLUp8+rL93+Na9m2F5OYccT
	 lIsrVH2ejTSU2MPJClYEv9GzPkwsimLkPYCYfvJWL/OMBd7g12O969rAvTViqg5Fj3
	 WD3G8DPvudAwavr7Kj/Zal3vADaGctN9V4LWDLfozj+1LFuFimQdQ5GLuKczZRhbD0
	 W7IJuRcyVT0yoP+LQLP1BY+F8Fh0JBCZeWSwwCsq/Xyjy3oe0v0+kODA8ASmXBL+qf
	 fFGcVOKwsGosQ==
Date: Thu, 23 Oct 2025 09:47:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251022153059.22763-1-pedrodemargomes@gmail.com>
 <20251022133118.f13f924348e8cdc6d49ef268@linux-foundation.org>
 <f42b7b67-7de4-4a7b-8074-25ca87a952a6@redhat.com>
From: craftfever <craftfever@airmail.cc>
In-Reply-To: <f42b7b67-7de4-4a7b-8074-25ca87a952a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



David Hildenbrand wrote:
> On 22.10.25 22:31, Andrew Morton wrote:
>> On Wed, 22 Oct 2025 12:30:59 -0300 Pedro Demarchi Gomes 
>> <pedrodemargomes@gmail.com> wrote:
>>
>>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>>> to locate mergeable pages. This becomes highly inefficient when scanning
>>> large virtual memory areas that contain mostly unmapped regions.
>>>
>>> This patch replaces the per-address lookup with a range walk using
>>> walk_page_range(). The range walker allows KSM to skip over entire
>>> unmapped holes in a VMA, avoiding unnecessary lookups.
>>> This problem was previously discussed in [1].
>>>
>>> [1] https://lore.kernel.org/linux- 
>>> mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
>>>
>>
>> Thanks.  It would be helpful of the changelog were to tell people how
>> significant this change is for our users.
>>
>>> Reported-by: craftfever <craftfever@airmail.cc>
>>> Closes: https://lkml.kernel.org/ 
>>> r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
>>
>> Buried in here is a claim that large amount of CPU are being used, but
>> nothing quantitative.
>>
>> So is there something we can tell people who are looking at this patch
>> in Feb 2026 and wondering "hm, should I add that to our kernel"?
>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Co-developed-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")
>>
>> If the observed runtime problem is bad enough then a cc:stable might be
>> justified.  But a description of that observed runtime behavior would
>> be needed for that, please.
> 
> Agreed.
> 
> With the following simple program
> 
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/mman.h>
> 
> /* 32 TiB */
> const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;
> 
> int main() {
>          char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
>                            MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);
> 
>          if (area == MAP_FAILED) {
>                  perror("mmap() failed\n");
>                  return -1;
>          }
> 
>          /* Populate a single page such that we get an anon_vma. */
>          *area = 0;
> 
>          /* Enable KSM. */
>          madvise(area, size, MADV_MERGEABLE);
>          pause();
>          return 0;
> }
> 
> $ ./ksm-sparse  &
> $ echo 1 > /sys/kernel/mm/ksm/run
> 
> ksmd goes to 100% for quite a long time.
> 
> Now imagine if a cloud user spins up a couple of these programs.
> 
> KSM in the system is essentially deadlocked not able to deduplicate
> anything of value.
> 
> @Pedro, can you incorporate all that in the patch description?
> 

Thanks for example and explanation, that's exactly what I meant. Big 
datacenters and servers are primary use cases with Linux< for example, 
when many VMs are using and KSM operation have to be very robust to deal 
with so huge amount of memory. And, as being said, that bug is happened 
with consumers apps, like Chromkum/Electron (and based on it, like VS 
Code), when user decides to apply KSM for his apps. This patch is really 
necessary to apply in master branch and very preferably backport 
6.17-stable branch, it has high importance. I've tested by the way v4, 
and it's fine, stable, effective and very lite. Is v5 version with more 
comprehensive description is final version?

