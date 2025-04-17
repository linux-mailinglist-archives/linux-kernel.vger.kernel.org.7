Return-Path: <linux-kernel+bounces-608924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19545A91AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 13:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAA75A7748
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F623BF90;
	Thu, 17 Apr 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kmuzlFgl"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968423A99F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888950; cv=none; b=B8De9HHuwuQe8qa/S6Irf7uqE2grhJx7Oke8gxdd/tgJT0GeremBfv8dU/Ua3ZTZOr4c9qgxYrZBjjpjNQP3tsKbakKiFaL1q+UGzk/DqulDJmRnlXqD6xv20kIjtuO2IxvivOulWFXNI6z/pgB6bMMbEYRNv7k1IeAp8p10GVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888950; c=relaxed/simple;
	bh=+6G0YGIZ9cPrNfB936rY48ZKOf1Y6gsGzRyVPrGXzZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZ9dnp4uddZ7TR8dgdI7Tqj6X3+UFE9OwCUzCdmGoEkvk+35UduXfYffIfUH2A2Zbza2jpYIBejM+ZqNhp8k5xX20dNpll+GudMniOSdhKv8ynpGb4zuYhNwhYvgACIuaBP/9+3lKeNTjDxE05SYRSbCxXLit6qhz/ARl1+ZVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kmuzlFgl; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4l3H5XoP1qoOtPaanLPOXIJj8oTfFM6gBeFk4wZOUOQ=; b=kmuzlFglRmkvwwjFCnM+UN+/0i
	AMXAhQnC+MpXEUzEWy7310zMVAtdM17ezjvMq6vrbkafMxqoIWLa8TGSk55xx2RFoDGlT3fgVpmDL
	gR0ULX8zekNaFw48xR4Oy8VRf200hG48vd2/K5u7i6mqzMkagmNXifeVmZzB7iTUyDgxHhsjE2q/U
	yrQS1087fYAIDtMxCopRT+9CVysIAzON+joB5ljxDXl2mO4qHA+3gUt3k/NKtGpRhMmYjtt7GTLf0
	+FjM2c61Lxwe+h2wgTEFL0Xk7uwnr0FsS1cTiXszfwV4+C+nVsDN4jGiXoHc/pfDA/AnUBnA5Erqw
	wlzSZTzA==;
Received: from 39-14-49-133.adsl.fetnet.net ([39.14.49.133] helo=[192.168.220.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u5NJb-000ma4-V0; Thu, 17 Apr 2025 13:21:56 +0200
Message-ID: <f344d741-962c-48d3-84b7-ce3de5619122@igalia.com>
Date: Thu, 17 Apr 2025 19:21:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration
 entry
To: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
 ziy@nvidia.com, linmiaohe@huawei.com, revest@google.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20250414072737.1698513-1-gavinguo@igalia.com>
 <27d13454-280f-4966-b694-d7e58d991547@redhat.com>
 <6787d0ea-a1b9-08cf-1f48-e361058eec20@google.com>
 <83f17b85-c9fa-43a0-bec1-22c8565b67ad@redhat.com>
 <98d1d195-7821-4627-b518-83103ade56c0@redhat.com>
 <7d0ef7b5-043b-beca-72a9-6ae98b0d55fb@google.com>
 <05a7d51e-f065-445a-af0e-481f3461a76e@redhat.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <05a7d51e-f065-445a-af0e-481f3461a76e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/25 17:04, David Hildenbrand wrote:
> On 17.04.25 10:55, Hugh Dickins wrote:
>> On Thu, 17 Apr 2025, David Hildenbrand wrote:
>>> On 17.04.25 09:18, David Hildenbrand wrote:
>>>> On 17.04.25 07:36, Hugh Dickins wrote:
>>>>> On Wed, 16 Apr 2025, David Hildenbrand wrote:
>>>>>>
>>>>>> Why not something like
>>>>>>
>>>>>> struct folio *entry_folio;
>>>>>>
>>>>>> if (folio) {
>>>>>>   if (is_pmd_migration_entry(*pmd))
>>>>>>       entry_folio = pfn_swap_entry_folio(pmd_to_swp_entry(*pmd)));
>>>>>>   else
>>>>>>    entry_folio = pmd_folio(*pmd));
>>>>>>
>>>>>>   if (folio != entry_folio)
>>>>>>         return;
>>>>>> }
>>>>>
>>>>> My own preference is to not add unnecessary code:
>>>>> if folio and pmd_migration entry, we're not interested in entry_folio.
>>>>> But yes it could be written in lots of other ways.
>>>>
>>>> While I don't disagree about "not adding unnecessary code" in general,
>>>> in this particular case just looking the folio up properly might be the
>>>> better alternative to reasoning about locking rules with conditional
>>>> input parameters :)
>>>>
>>>
>>> FWIW, I was wondering if we can rework that code, letting the caller 
>>> to the
>>> checking and getting rid of the folio parameter. Something like this
>>> (incomplete, just to
>>> discuss if we could move the TTU_SPLIT_HUGE_PMD handling).
>>
>> Yes, I too dislike the folio parameter used for a single case, and agree
>> it's better for the caller who chose pmd to check that *pmd fits the 
>> folio.
>>
>> I haven't checked your code below, but it looks like a much better way
>> to proceed, using the page_vma_mapped_walk() to get pmd lock and check;
>> and cutting out two or more layers of split_huge_pmd obscurity.
>>
>> Way to go.  However... what we want right now is a fix that can easily
>> go to stable: the rearrangements here in 6.15-rc mean, I think, that
>> whatever goes into the current tree will have to be placed differently
>> for stable, no seamless backports; but Gavin's patch (reworked if you
>> insist) can be adapted to stable (differently for different releases)
>> more more easily than the future direction you're proposing here.
> 
> I'm fine with going with the current patch and looking into cleaning it 
> up properly (if possible).
> 
> So for this patch
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> @Gavin, can you look into cleaning that up?

Thank you for your review. Before I begin the cleanup, could you please
confirm the following action items:

Zi Yan's suggestions for the patch are:
1. Replace the page fault with an invalid address access in the commit
    description.

2. Simplify the nested if-statements into a single if-statement to
    reduce indentation.

David, based on your comment, I understand that you are recommending the
entry_folio implementation. Also, from your discussion with Hugh, it
appears you agreed with my original approach of returning early when
encountering a PMD migration entry, thereby avoiding unnecessary checks.
Is that correct? If so, I will keep the current logic. Do you have any
additional cleanup suggestions?

I will start the cleanup work after confirmation.

> 
>>
>> (Hmm, that may be another reason for preferring the reasoning by
>> folio lock: forgive me if I'm misremembering, but didn't those
>> page migration swapops get renamed, some time around 5.11?)
> 
> I remember that we did something to PTE handling stuff in the context of 
> PTE markers. But things keep changing all of the time .. :)
> 


