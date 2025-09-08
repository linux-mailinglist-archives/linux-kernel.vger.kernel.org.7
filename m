Return-Path: <linux-kernel+bounces-805734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6955EB48CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA3E18999EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6AD2F7AA1;
	Mon,  8 Sep 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzUphNzE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9A2EFD86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333054; cv=none; b=GQD+BD8PIHw5eu2wVZFLmz2svwVraXTCBp0CFRnLWR0Mn6hpNbkjEet1TayXrN+WMVX2PdcC0hPiJ1Gq4HNYgN8iTaEHWPEzDuBT/KQBcqZus2YWRTwW+ECD8ud5DJyDM167L4xVpvvQuktfa1cn9Ayu+t9MOJbyaJsM01zmIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333054; c=relaxed/simple;
	bh=OkHFUk3qNr1u9be+WybyzHAKLpgmEn297I9ztwXiZnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZzywuV5OBBTvmQQcfFUKdBLyTas/YDBoEz1SyN/oeTk729x69z2IrFiV07+RHbC4KnLbB88XuNE3d9YlwzZaQdYo7fe9GQComUxvYI3f4DNaaHctkG4p3qg7yVL2TiwRw963o0xLsc81eiKb+o6siOFb3WOB8VioUljSAHtmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzUphNzE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757333051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZQY5mtCsJ6G72X3ReunddNY+XFovjNM7Q+qStzUuS7A=;
	b=fzUphNzE1GyyIzfRW9GcgJ2azNCcdZUDSF9CKp/9j7OiYPoNwqItU8kOu8/nrunIWJ/STW
	5UsfjHE3IsL5mP+zdBq4wtLK1P3BINdabwLFARSTQr69dJJKik2pyND89w94UhV0X3/dUw
	7pHoTs9P+YLlUt06SHn3iytnzeP5fb8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-eSs4Z2jNPYGJAmSBnd9Eaw-1; Mon, 08 Sep 2025 08:04:10 -0400
X-MC-Unique: eSs4Z2jNPYGJAmSBnd9Eaw-1
X-Mimecast-MFC-AGG-ID: eSs4Z2jNPYGJAmSBnd9Eaw_1757333050
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5e91fb101so126527831cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333050; x=1757937850;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQY5mtCsJ6G72X3ReunddNY+XFovjNM7Q+qStzUuS7A=;
        b=djuPVL7BIUyJrmx3pFG6PPv24zRIMsZ0aKxVl2VtX2xmNmi5YCQTqt2KqoKuHZ3Yue
         uozn24LfGgiqByeqwT6w8TbzDRRjeM85xya0KElVjApU68aFk7upZCQ47Zl1Joz5a3Wz
         N2WpeAbIOHmH3dg40qYZM2xaTSEj2TpU9GdM2fvZfErYM85aDbhPMxpASkvflq3YZDGw
         R0lV4KCEwFIeg4gUM/b0BgGtuJptfdgOojYXQ2K3oKBftzzEsN7WMrbg+YR/z/I9FkAe
         vMrlYTLvvVD+6dBg+fCow3zPOInMYbKWoVyNfUUtgp3UGP7mOgUU+D1pGKiSW7d1nJ7q
         Zmjw==
X-Forwarded-Encrypted: i=1; AJvYcCWfuPVAIH+jZwy9IA+FTGLpKIeGuYR+9MhKmmXqvBn6p0qJV3mdejUnOEMuBPkflh/r6jgFZzh4AAs6JJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kVZR0W4D7/By8uY57oszTJgpKh+FhrJiPIKhdtqk+K8yU0Zj
	3YhCk80pNuiveifkMLFJemu6u0QTBwqssPuj0vEMdzUUqm6mSoFUdqhuMtGb59IN/3eEbdrVGER
	8tfwhZmMhY3yx5VrowjO/3wFn00uemH3WKKrDyFYDGiuX95lZEAneIXeuCvaB+UuxNA==
X-Gm-Gg: ASbGncutZHKTgn2lk/TYHwhXf8lonAkOtdLmCslBFT5X5VKSuBOthk5NDokfrJTBNBv
	NpjkfnrcWdvS8U0kBhHhppw51i+XccIUQqQx/aLJ7R/a2f6KVLnSxpQGvB+twhOh4DAmrEAaA3r
	c7ap1taLqOlLaw03dScAKF5yNBrgqcDkNkjkYwdxWunWepnSc39fr18bLJNmjEIrA+lC8RmdryI
	yCNHO3WyUxgUXiu31EVGtGAFdmdby5mfDX/7cLbygpG5kTv9b2HInYS7wAqRT/tndcwxwvqFqA+
	fhquN/ExmEm5u7etVuehes3ogldFlE6jhIl5K31RY7OzC9EsE775MbhubmIcNc13TA9LjuFkscH
	Lxa9MpptDOJpct9W7ZEIA7uSJKJ3rjR3VrlEy3eScCiYGI/fyBpyLUzRLMSYBgT1T
X-Received: by 2002:a05:622a:256:b0:4b0:907c:918a with SMTP id d75a77b69052e-4b5f83860edmr90178161cf.16.1757333049958;
        Mon, 08 Sep 2025 05:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ0m+xqdk6+V/miczYIvEh+2/fCRGk0GUT37l9KKiOekcHaZPTLhCb/GFJBksR4DqtSb8WDg==
X-Received: by 2002:a05:622a:256:b0:4b0:907c:918a with SMTP id d75a77b69052e-4b5f83860edmr90177261cf.16.1757333049154;
        Mon, 08 Sep 2025 05:04:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7a531asm102949671cf.49.2025.09.08.05.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:04:08 -0700 (PDT)
Message-ID: <f58a472f-4a36-40e7-94d2-229125ae7373@redhat.com>
Date: Mon, 8 Sep 2025 14:04:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com
References: <20250908090741.61519-1-lance.yang@linux.dev>
 <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
 <9a0c07b9-5bf0-4251-8609-fbaf0ca75bf9@redhat.com>
 <5j6i2o6umqwxabdfncbrdytmvdma4yrraxe6hu4csckcniduya@sm3mlablwbad>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5j6i2o6umqwxabdfncbrdytmvdma4yrraxe6hu4csckcniduya@sm3mlablwbad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 13:44, Kiryl Shutsemau wrote:
> On Mon, Sep 08, 2025 at 01:32:05PM +0200, David Hildenbrand wrote:
>> On 08.09.25 12:38, Kiryl Shutsemau wrote:
>>> On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
>>>> it does not make sense to try to detect whether it is underused, because
>>>> try_to_map_unused_to_zeropage(), called while splitting the folio, will not
>>>> actually replace any zeroed pages by the shared zeropage.
>>>
>>> It makes me think, does KSM follows the same logic as
>>> try_to_map_unused_to_zeropage()?
>>>
>>> I cannot immediately find what prevents KSM from replacing zeroed mlocked
>>> folio with ZERO_PAGE().
>>>
>>> Hm?
>>
>> I assume if you're using mlock and at the same time enable KSM for a
>> process/VMA, you're doing something wrong.
>>
>> In contrast, THP is supposed to be transparent (yeah, I know ...).
> 
> Yeah, I guess it is user error.
> 
> Maybe we should make ksm_compatible() return false for VM_LOCKED?
> KSM breaks mlock() contract.

I was thinking the same and falsely remembered that we would already be 
checking for that.

> 
> But it can be risky if someone already relies on this broken behaviour.

Could be.

Staring at QEMU, we have the following parameters:

	mem-merge=on|off

     	Enables or disables memory merge support. This feature, when 	
         supported by the host, de-duplicates identical memory pages
         among VMs instances (enabled by default).

And

	-overcommit mem-lock=on|off|on-fault

	"Run qemu with hints about host resource overcommit. The default
	 is to assume that host overcommits all resources."


Now, I would assume that anybody who sets "-overcommit mem-lock=on" either

(a) Has KSM disabled on that machine.

(b) Sets mem-merge=off

as well. But QEMU would allow for configuring it.


Interestingly, mm_populate()->populate_vma_page_range() wants to break 
COW. [*]

But if the app later calls fork(), we still allow for cow-sharing pages 
with the child. (another case of "don't do it", like KSM I guess)


[*] it doesn't do it for mappings that start out R/O. I think we might 
end up with sharedzero pages in that case, but not sure if worth fixing.

-- 
Cheers

David / dhildenb


