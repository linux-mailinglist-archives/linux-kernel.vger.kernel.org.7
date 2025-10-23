Return-Path: <linux-kernel+bounces-866065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC5BFED0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB5419A01C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8B183CA6;
	Thu, 23 Oct 2025 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JBwZ97GJ"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32535194A6C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181949; cv=none; b=Vj4RjhWgFdgSFZJmO6GFYJ2fOPFp0MYiKY0evD27JIkgv3dVsnVKnKSu3hm22WCc6CLiiffYVFfKc8lmD/klhV3epdw2oc9huE1HbWnAGLrYEA9lkUHSvRx8lwDewJORn2NEv7FaQjhzroW91oMonIxjBTIBooLEwhZi0A1L+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181949; c=relaxed/simple;
	bh=6UsLCFdec4i0VpG/0SEdWFcOMjQCBlzbAtDjHfha0Xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gzCuFtHQhxCP9Mi2wb0Gh0Qw6EeafRbKbzoN1AN6pj01WpfJuqdaM7jCyN71L3tZQjXTpyZIobZ0o9cmfCNyp5yRdW6MqisjryOt1QvYdN+F+E3MfLnyAkLPojnVuVgPWcGQ6bO+Gck5o6pKznkFn7u7DFkJw7+BzyGVruUMnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JBwZ97GJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761181943; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=OY0FCj556fptPozBFxGp5get5cRe/MRUmiOCM9ncjw4=;
	b=JBwZ97GJil+RYkKKjOPaN2dV/zNwZXYWDUnhGtFHeAL1hv4ZProHR6+KWnAGX7D5HQ597VWmlMmsoXXLBr1J5Jcaujy/BmeKfhrYMmNshKZqeTFSh7FrBsChH1aerBdrG4BWcDR62LLsiSRZi6sjBsHN/eSLMW3wzJhG8ywLUOY=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqogLW1_1761181942 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 09:12:22 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,  linux-mm@kvack.org,
  Andrew Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
In-Reply-To: <0a121e1b-e238-4a75-b431-7c5a23c70f45@redhat.com> (David
	Hildenbrand's message of "Wed, 22 Oct 2025 22:24:06 +0200")
References: <20251022032951.3498553-1-anshuman.khandual@arm.com>
	<87ecqve6gg.fsf@DESKTOP-5N7EMDA>
	<b5a1b52c-75ef-4915-a254-a502b9f78eeb@arm.com>
	<87o6pzbbks.fsf@DESKTOP-5N7EMDA>
	<0a121e1b-e238-4a75-b431-7c5a23c70f45@redhat.com>
Date: Thu, 23 Oct 2025 09:12:21 +0800
Message-ID: <87qzuu2zgq.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 22.10.25 10:11, Huang, Ying wrote:
>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> 
>>> On 22/10/25 1:03 PM, Huang, Ying wrote:
>>>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>>>>
>>>>> Add some [pte|pmd]_mkwrite_novma() relevant tests.
>>>>>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: Huang Ying <ying.huang@linux.alibaba.com>
>>>>> Cc: linux-mm@kvack.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> ---
>>>>> These tests clear on arm64 platform after the following recent patch.
>>>>>
>>>>> https://lore.kernel.org/all/20251015023712.46598-1-ying.huang@linux.alibaba.com/
>>>>>
>>>>> Changes in V2:
>>>>>
>>>>> - Added a new test combination per Huang
>>>>>
>>>>> Changes in V1:
>>>>>
>>>>> https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/
>>>>>
>>>>>   mm/debug_vm_pgtable.c | 12 ++++++++++++
>>>>>   1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>>> index 830107b6dd08..def344bb4a32 100644
>>>>> --- a/mm/debug_vm_pgtable.c
>>>>> +++ b/mm/debug_vm_pgtable.c
>>>>> @@ -102,6 +102,12 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>>>>>   	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>>>>>   	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>>>>>   	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>>>>> +
>>>>> +	WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));
>>>>> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
>>>>> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
>>>>
>>>> Why do you use
>>>>
>>>> pte_mkwrite_novma(pte)
>>>>
>>>> instead of
>>>>
>>>> pte_mkwrite(pte, args->vma)
>>> Just wanted to have more coverage for pte_mkwrite_novma() helper which was missing
>>> till now in this test. But just wondering is there a specific reason for replacing
>>> this with pte_mkwrite() helper instead here ? Also we could probably add tests for
>>> both these helper variations if that is preferred.
>> IIUC, pte_mkwrite() is a more formal interface.  pte_mkwrite_novma()
>> is
>> used to implement pte_mkwrite().  So, IMHO, we should use the more
>> formal pte_mkwrite() interface if possible.
>
> pte_mkwrite() does different things based on VMA flags on some archs
> (e.g., x86). So to test the "interesting" stuff one would have to
> craft a special VMA.
>
> Without any special flags pte_mkwrite() really is just pte_mkwrite_novma().

Thanks for explanation.  If so, I'm fine to use pte_mkwrite_novma() in
the tests.

---
Best Regards,
Huang, Ying

