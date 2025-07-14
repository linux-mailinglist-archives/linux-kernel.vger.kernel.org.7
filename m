Return-Path: <linux-kernel+bounces-730433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C97B0445D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543FF1651E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720219F43A;
	Mon, 14 Jul 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErSyh3d6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D071E1DF0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507466; cv=none; b=b633F/KEdR5Fz11Gt5HgwEMvfAKjhPgtzS06CjpDUMTIXjXjxOwslaKAgkSsGzM7RF+MU3KKogczUSEqocpS4UO/qSGriYnabT9dUaIpjpwSbivBcmmH2I2gTf1QS6B9IlNjWT0gA5WFe6gL/0CXxm6Fo7OOWq6oBUn+Ut8UERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507466; c=relaxed/simple;
	bh=+CZ8qAKiMgPoicJBBVBRQc+ntOCICwmbfUpm7Dr6G30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4bLvaGsDFcQrNomXURn4OZlLf3nSpId0SNGCHc7p04ltl3L0VfTxFJC6GtoCs7qi6JLYDMnC0zuLWgeAjy1C8yeeuM7W8R8dl8wYqQVjRRJ+O6FsV+6crVDwdluLPiALDpTKZ72H0KrSf08ugk5EXkvHQ/599uvVfWQOuDDEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErSyh3d6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752507463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amM9FSOvpJvmGAYB5+wYTX2dkMFWF/xAHWtESWwGefc=;
	b=ErSyh3d6Gnj/h81zHK3CFxhB8O3X5/Z+j42K6xFDmE/i/mO/uyDBR8EqRicYhaZqIPwki/
	c/SxgcV34IOTU2iBV6+uhfHoL5DgIIthr+hIC9jmleI1sEGOb/D3RYEiGDgHpp8BCjjuRh
	bD0LNuVxj8eJ3kMbahHIv6C+9JDG0ms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-K4bSw54EOOe4mnmUHkmbWA-1; Mon, 14 Jul 2025 11:37:42 -0400
X-MC-Unique: K4bSw54EOOe4mnmUHkmbWA-1
X-Mimecast-MFC-AGG-ID: K4bSw54EOOe4mnmUHkmbWA_1752507461
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso2328455f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507461; x=1753112261;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amM9FSOvpJvmGAYB5+wYTX2dkMFWF/xAHWtESWwGefc=;
        b=E7jSmQ4gJ0dkSmobE1BT8bbHpsfv4p4s8/bA3h+Ibd4Qzd46eVhXm007UcbV6XaFp7
         KI5fCnaKDW2j39EoOYu4ZR4OlWVzQ+b5JZmJifbTq3nIpYKoFMI5MONz4O54XeG5d5c7
         3Ovyw9+i2WfFtDe9oiMGVuu3K2grNbeQNXMxByrDQ+NTCBFJOd+PBqMq85Khqof+9CEA
         h6GpKeMNEDPI3fKrS01z0rSmHXdelPSIqfxKhYxPU2bJmgq88eYPcT6LgqEtPGXngTzu
         tFJxXqhk+X4UblgU3HBj4m0OnUdNdKR4Z+Gd64LC/uxkaxKfcYCpY3g7/etg/5XG+BtR
         Ibrg==
X-Forwarded-Encrypted: i=1; AJvYcCVNbTMvau2XTx+R8GEYPO77oJ1fLzJwPQkfWlMxfl84tEQ1+5D2tXSBvr5evP2ZjNNnDEhmKeeRtXTca9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88F4hc7yOUcKf/63I4F4EXTmtK+y3v4WpgUmEz2X3Q3o7Sjra
	L9KYIV6uvEq4AS34X29wlXNvB/1qigfMsTNAyayTMqj7qc5e2rVBftGaJ2XCDMcJW0nMAVi2TUk
	67R4JY3FasxAKYbN1kqwO7DqMgDkC3kfgnjjHZsfOXDMUEqvDxWdW+mMqCyde5epFUA==
X-Gm-Gg: ASbGnctP1GiikLIFuYbqBirf11X5fv2g+qdX1LtP2R3VhvusUa8F6mfHtJN25qBgmNX
	xkDx9kdTdr5rG3iQjClh5M0pnzijiwRwgN3fo+oCRyeklrWFhmNBoqviOHVc0yRU0McY3n/sysc
	zG0VlERkXrZrKAa9jku7YNBhfPpX2nOOJ6HJKftxVKtutdO8Zg3aIJcGTkohUgh32+jrOl6JVKz
	iwb8X3OJZETvSq3penEZv64tw+9LuHqbEIKiSoPKDdytWdkFXLKY/EDVyHxFKYP8URTM1leaiff
	4lti6KhtlddCGVcxxygNFJlYrxPnvpfyAhIIsLNLgn3aBxQxhT8+1jpTyiv38gHOb69QjRaw7zS
	Bu3INlfq76BmmvWBvM0MoAxvuz6PXVSc1ANMIy6Ngb/2tkICwwSD9BjncnWV1u50P
X-Received: by 2002:a05:6000:2181:b0:3a5:52cc:5e29 with SMTP id ffacd0b85a97d-3b5f18565a3mr10465572f8f.7.1752507461091;
        Mon, 14 Jul 2025 08:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPukMrCzOvCLUT8Y3kmqUzqBTSWnEJUhx8wiPtEwlzku2il6SHlKwJQ5ZMalbTMucKfe2C9Q==
X-Received: by 2002:a05:6000:2181:b0:3a5:52cc:5e29 with SMTP id ffacd0b85a97d-3b5f18565a3mr10465550f8f.7.1752507460652;
        Mon, 14 Jul 2025 08:37:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1741sm12914882f8f.18.2025.07.14.08.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:37:40 -0700 (PDT)
Message-ID: <1163e5f4-2ce9-49ee-bf2f-9a52e948edb8@redhat.com>
Date: Mon, 14 Jul 2025 17:37:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
 <c57a0048-17dd-445b-8d92-4c8cc6f47d17@lucifer.local>
 <0c78bc9b-8aae-47ba-9679-423d862591df@redhat.com>
 <00bb2d76-4d52-40ec-ac75-546311b8ddcb@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <00bb2d76-4d52-40ec-ac75-546311b8ddcb@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 17:27, Lorenzo Stoakes wrote:
> On Mon, Jul 14, 2025 at 05:24:14PM +0200, David Hildenbrand wrote:
>> On 14.07.25 17:18, Lorenzo Stoakes wrote:
>>> On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
>>>>>> or sth like that would surely clean that up further.
>>>>>
>>>>> Well, I plan to make this not a thing soon so I'd rather not.
>>>>>
>>>>> The intent is to make _all_ VMA flags work on 32-bit kernels. I have done some
>>>>> preparatory work and next cycle intend to do more on this.
>>>>>
>>>>> So I'd rather avoid any config changes on this until I've given this a shot.
>>>>
>>>> Sure, if that is in sight.
>>>
>>> Yes :)
>>>
>>>>>>> + * only do so via an appropriate madvise() call.
>>>>>>> + */
>>>>>>> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
>>>>>>> +{
>>>>>>> +	struct vm_area_struct *vma = madv_behavior->vma;
>>>>>>> +
>>>>>>> +	/* If the operation won't discard, we're good. */
>>>>>>> +	if (!is_discard(madv_behavior->behavior))
>>>>>>> +		return true;
>>>>>>
>>>>>>
>>>>>> Conceptually, I would do this first and then handle all the discard cases /
>>>>>> exceptions.
>>>>>
>>>>> Hm I'm confused :P we do do this first? I think the idea with this is we can
>>>>> very cheaply ignore any MADV_ that isn't applicable.
>>>>>
>>>>> Did you mean to put this comment under line below?
>>>>>
>>>>> I mean it's not exactly a perf hotspot so don't mind moving them around.
>>>>
>>>> I was thinking of this (start with sealed, then go into details about
>>>> discards):
>>>>
>>>> /* If the VMA isn't sealed, we're all good. */
>>>> if (can_modify_vma(vma))
>>>> 	return true;
>>>>
>>>> /* In a sealed VMA, we only care about discard operations. */
>>>> if (!is_discard(madv_behavior->behavior))
>>>> 	return true;
>>>>
>>>> /* But discards of file-backed mappings are fine. */
>>>> if (!vma_is_anonymous(vma))
>>>> 	return true;
>>>
>>> Right yeah.
>>>
>>>>
>>>> ...
>>>>
>>>>
>>>> But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
>>>> mapping?
>>>
>>> I'm duplicating existing logic here (well updating from the vma->vm_file check
>>> and a seemingly pointless !vma->vm_file && vma->vm_flags & VM_SHARED check), but
>>> this is a good point...
>>
>> Yeah, not blaming you, just scratching my head :)
>>
>>>
>>> For the purposes of the refactoring I guess best to keep the logic ostensibly
>>> the same given the 'no functional change intended', but we do need to fix this
>>> yes.
>>
>>
>> Likely a fix should be pulled in early? Not sure ... but it sure sounds
>> broken.
> 
> Once this lands in mm-new I can send a fix (like litearlly tomorrow if it lands
> :P). I just don't think a functional change belongs as part of a refactoring.
> 
> I worry that we'll get catch-22 caught on the (numerous) problems with the mseal
> implementation and thus not provide a foundation upon which to fix them...

Not sure what's right or wrong at this point. The cover letter only 
talked about anonymous memory:

"
Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymous
memory, when users don't have write permission to the memory. Those
behaviors can alter region contents by discarding pages, effectively
a memset(0) for anonymous memory.
"

We're similarly in the domain of altering memory content that was there 
(resetting it back to whatever the file provided).

It does like something that is not desired, but no idea how security 
relevant it would be. Probably a corner case we can indeed fixup separately.

-- 
Cheers,

David / dhildenb


