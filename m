Return-Path: <linux-kernel+bounces-740095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300DFB0CFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15D716E502
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885771E3DFE;
	Tue, 22 Jul 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HedIRV/j"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636C1E22E6;
	Tue, 22 Jul 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151613; cv=none; b=W+kMtMmhT9oqoJa/O8wP4d0aXKk/FHHY0kjDw6UXxwrCRfZTYcnULNhloSzDVbLxFcyP062JQKbrRTdYtjJuurZONM9o3Op0VYf9usxp8EeGmMTcS7HwX0OopXkOR1GwV0NLi17pXZZQBfq8Stb0KINESP4Z7S1RxelGYxPZQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151613; c=relaxed/simple;
	bh=Gf2EkO7pgANadcMSUUIdmLVnh3pQBfsUfEPhTRKVEi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERKzmO9LR49g9Rhppp9DBEZtqryr3awQBZqbYYrHREKllQy6Dh6X2QIHvL9glltRXg97nIfZcFSVhGYQsFFP5tBvDzEn2Z4nUZxh0SLtSnaPS0NoeLuVigw6B0cUfDPBEBrvPAz8tZ/fscMXLDMzhWTYvFH+NJTdLzKrqbyRfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HedIRV/j; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753151607; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pWXVyeKGfLMQnpoF8/uk15LxfELGiJXWnze7SP/0X5E=;
	b=HedIRV/jnQpTthoSwqjT20Y6Yg1SSew3b9YotwZ4vOmKI0xcXSeHQpx7tqEg9DVePJ4suskt8PhJBCDjNIOc5z1JtqmyeeF8/Dc+OVAAdaa63VyJIW0znai1zmU2qHPZwplDccnPBvZcgcnDeDHxc0fLJeiVP34+7SsqlBoPngc=
Received: from 30.74.144.108(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjTwAqR_1753151605 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 10:33:26 +0800
Message-ID: <a7062d0d-804f-4b9a-ba7f-62d67064c584@linux.alibaba.com>
Date: Tue, 22 Jul 2025 10:33:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
To: Barry Song <21cnbao@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
 <35df32ae-dc95-48e1-bdb1-90f17bfd4d5c@linux.alibaba.com>
 <CAGsJ_4yMLi_+yxJYebTbEALujcVmeqbfHh=ArkZRxMwE+OBWgQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4yMLi_+yxJYebTbEALujcVmeqbfHh=ArkZRxMwE+OBWgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/22 10:23, Barry Song wrote:
> On Tue, Jul 22, 2025 at 9:30 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/7/21 23:55, Lorenzo Stoakes wrote:
>>> Rather confusingly, setting all Transparent Huge Page sysfs settings to
>>> "never" does not in fact result in THP being globally disabled.
>>>
>>> Rather, it results in khugepaged being disabled, but one can still obtain
>>> THP pages using madvise(..., MADV_COLLAPSE).
>>>
>>> This is something that has remained poorly documented for some time, and it
>>> is likely the received wisdom of most users of THP that never does, in
>>> fact, mean never.
>>>
>>> It is therefore important to highlight, very clearly, that this is not the
>>> ase.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    Documentation/admin-guide/mm/transhuge.rst | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>> index dff8d5985f0f..182519197ef7 100644
>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>> @@ -107,7 +107,7 @@ sysfs
>>>    Global THP controls
>>>    -------------------
>>>
>>> -Transparent Hugepage Support for anonymous memory can be entirely disabled
>>> +Transparent Hugepage Support for anonymous memory can be disabled
>>>    (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
>>>    regions (to avoid the risk of consuming more memory resources) or enabled
>>>    system wide. This can be achieved per-supported-THP-size with one of::
>>> @@ -119,6 +119,11 @@ system wide. This can be achieved per-supported-THP-size with one of::
>>>    where <size> is the hugepage size being addressed, the available sizes
>>>    for which vary by system.
>>>
>>> +.. note:: Setting "never" in all sysfs THP controls does **not** disable
>>> +          Transparent Huge Pages globally. This is because ``madvise(...,
>>> +          MADV_COLLAPSE)`` ignores these settings and collapses ranges to
>>> +          PMD-sized huge pages unconditionally.
>>> +
>>>    For example::
>>>
>>>        echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>>> @@ -187,7 +192,9 @@ madvise
>>>        behaviour.
>>>
>>>    never
>>> -     should be self-explanatory.
>>> +     should be self-explanatory. Note that ``madvise(...,
>>> +     MADV_COLLAPSE)`` can still cause transparent huge pages to be
>>> +     obtained even if this mode is specified everywhere.
>>
>> I hope this part of the explanation is also copy-pasted into the
>> 'Hugepages in tmpfs/shmem' section. Otherwise look good to me. Thanks.
> 
> Apologies if this is a silly question, but regarding this patchset:
> https://lore.kernel.org/linux-mm/cover.1750815384.git.baolin.wang@linux.alibaba.com/
> 
> It looks like the intention is to disable hugepages even for
> `MADV_COLLAPSE` when the user has set the policy to 'never'. However,
> based on Lorenzo's documentation update, it seems we still want to allow
> hugepages for `MADV_COLLAPSE` even if 'never' is set?
> 
> Could you clarify what the intended behavior is? It seems we've decided
> to keep the existing behavior unchanged—am I understanding that
> correctly?

Yes, Hugh has already explicitly opposed the current changes to the 
MADV_COLLAPSE logic[1], although there are still some disagreements that 
cannot be resolved.

At least we reached the consensus to update the documentation to reflect 
the current sysfs THP control logic first, to avoid the misunderstanding 
that 'sysfs THP controls can disable Transparent Huge Pages globally'.

[1] 
https://lore.kernel.org/linux-mm/75c02dbf-4189-958d-515e-fa80bb2187fc@google.com/

