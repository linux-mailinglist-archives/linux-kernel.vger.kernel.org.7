Return-Path: <linux-kernel+bounces-847358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C4BCA9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A033C1A63F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148624EA90;
	Thu,  9 Oct 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvnbQuZj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D298241CA2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035925; cv=none; b=Sw8UH23bw0L1qz68GPr8tHJybngdv6RDZfMuPyq+kgXJG0pQ/B2bz/b6JKlvLohtlAcVLHPiOFpzOn1Kb3aFX2GuyFqNMT+kaSDdKNNX9eSEXC6FF2DYm4uVynPQMCGe1vP5qvMKzxCtzuaOEUp45yKDKEFkFfJ7LgLldbhwq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035925; c=relaxed/simple;
	bh=S1XAPAYMR3qNpjj5xniwP9ol1tw2U+Ud1bo8aQgn5MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP6ez3GjcaQ9ZHF4iUoIIwvqLda/+H1N234I5mKJMnmXzWtcm7+sgOYOqU/tXtPDM24CJHinQ7SgvQCQBmEYJvR/nwCBcNUV8vZgM+11Kqrm5NwUiXdG/mDMA/2M6ZzDh2R93e4NDlJBALgNNYOQC/FO8bzexodyLYwlb2ZX+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvnbQuZj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760035922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JuM/xy0uDi2aKWqEBu4ShLZn7rdYhN1RSBK1xoj3T/Q=;
	b=fvnbQuZjrmASNvFVTVuYIrDyZRpq/R4SaWI9mdN47k7VSvIJcJMJiFnmNC1nJNlDP/BBXD
	Pd9Cxyi6/IAHeeGvb8hZWWzHdhZQextcCNqeDAOdB4nPYrxZ5z6mQ7dmKC0jBRZERDEtDP
	e8b/vLDr3YKpa9W0SohOeChIGQArOs4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-qsshIkzcNfKhH4cfMXgaHQ-1; Thu, 09 Oct 2025 14:51:59 -0400
X-MC-Unique: qsshIkzcNfKhH4cfMXgaHQ-1
X-Mimecast-MFC-AGG-ID: qsshIkzcNfKhH4cfMXgaHQ_1760035918
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso1397859f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035918; x=1760640718;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuM/xy0uDi2aKWqEBu4ShLZn7rdYhN1RSBK1xoj3T/Q=;
        b=Z9o7ahlDvaaaoGbrKj8fP5AZBNpSwSj+QKamIItFIZLhwfF5D59ai2i3av+PAGEpx4
         EBFgZQ039kRn+azGI08/LCobt3ivUYHtkadSLbf94hTg9CMFqL8mHa+2zwFNCnUrpKck
         OLaFDHcjt1xWxjCZXpgPnLwri5H7ZbCTeWCVluJjsryO8WoD3pEWxRt07r4HRiHqg8J4
         uEOxKvPnCuS1od5YfQAjIoLR1TiyTg5p2s9DuYfFL+hN51skWu/J6KHJSd1ixTd/pRD2
         Bndklp3JUN7Gb9YIHFayWpo6U2cIZfMEiT0nVcp75DhoctfHKKlwCpsqqKQCYlow0+ph
         XyNg==
X-Forwarded-Encrypted: i=1; AJvYcCWpAptjgEGzmztST4MWR6C54OkPk3D7NqJk7IaIcYaURS+tqynoWLKZTYzeNzVYFy8qRg/VTOlwY3sbI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRip08eodBtcKxo26lOKiDo+1hAl5f28ojGgMdpUAmYXYLC5Cq
	C6lXSF9fmEBpt0ULagcQ5io5KlU5WRQKZ0Zfd71GVOC0rB77vLJozj771VHjLr8NHI/8bBnQV2l
	+FQPFNzzQe5CyzVaQJm8yPUo1slfLEPOySNCBk9tX4UyNwoKvTFwtUhdv4xLpvNW4TQ==
X-Gm-Gg: ASbGncst1sa7BVjN4ATntn+tWPitviHiwcFjASzX/WAftehX46Xbf2dEMtzwTYK/YyO
	rr40GeT0jS4tz51nX9rRSdaG/hWIFxJW+du5edHnMH6AIuu67iOnG4AOLy5mvpCELkusA2oHiYl
	lKlqtbEjEdn2vKmYWJgOa0Fi6AqO9duAYtGqGgZ7GSCvqIZ4yNxVf1YVeEt/SkCKFnPpVunnG8V
	S36P/hAR2nfBhuB5nj4im6tI+p4qq9OLi+Yiirmr3yN1islaW+//9lj9UHmW5yCxFfu/O14OA89
	JctxnAspGa2af3Ydx7phcWuqLRvCfq4kjfuqJSejb93U18+8gWPLxUzHSVrpRDEr0NlHxSmyiR2
	ahz32YR20
X-Received: by 2002:a05:6000:607:b0:424:211a:4141 with SMTP id ffacd0b85a97d-4266e7c61a2mr6181008f8f.27.1760035917757;
        Thu, 09 Oct 2025 11:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9phgoJQqtDuGkZ35opgptVXsnLjQkrMgDx7RkFdRbInqtHP9Q7Mvdzi6WvZ+AZV1w4gKU3Q==
X-Received: by 2002:a05:6000:607:b0:424:211a:4141 with SMTP id ffacd0b85a97d-4266e7c61a2mr6180982f8f.27.1760035917202;
        Thu, 09 Oct 2025 11:51:57 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm383854f8f.23.2025.10.09.11.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 11:51:56 -0700 (PDT)
Message-ID: <ac0393c7-9c0c-4b4d-8b35-5e6369e5431b@redhat.com>
Date: Thu, 9 Oct 2025 20:51:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
To: Gregory Price <gourry@gourry.net>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
 laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 Alexandru Moise <00moses.alexander00@gmail.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, David Rientjes <rientjes@google.com>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
 <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
 <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F> <aOdSvriKRoCR5IUs@tiehlicka>
 <aOfU9YTKMPWzYOta@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOfU9YTKMPWzYOta@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 17:29, Gregory Price wrote:
> On Thu, Oct 09, 2025 at 08:14:22AM +0200, Michal Hocko wrote:
>> On Wed 08-10-25 12:31:22, Gregory Price wrote:
>>>> I'm not quite clear yet on the use case, though. If all the user allocations
>>>> end up fragmenting the memory, there is also not a lot of benefit to be had
>>>> from that zone long term.
>>>>
>>>
>>> The only real use case i've seen is exactly:
>>>   - Don't want random GFP_KERNEL to land there
>>>   - Might want it to be pinnable
>>>
>>> I think that covers what you've described above.
>>>
>>> But adding an entire zone felt a bit heavy handed.  Allowing gigantic in
>>> movable seemed less - immediately - offensive.
>>
>> The question is whether we need a full zone for that or we can control
>> those allocation constrains on per memory block bases to override
>> otherwise default. So it wouldn't be MOVABLE but rather something like
>> USER zone.
> 
> 
> Mild ignorance here - but I don't think the buddy allocator currently
> differentiates chunks of memory based on block membership, it just eats
> folios from certain zones/nodes.
> 
> I'm scratching my head trying to think of the discrete mechanism to do
> this that doesn't inject significantly more complexity into the buddy
> allocator.
> 
> Looking at the recent[1] THP support for ZONE_DEVICE, I wonder if we end
> up with something more along these lines?  But this aschews the other
> requirement of wanting the memory to be otherwise general purpose.
> 
> https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/
> 
> ZONE_USER does feel like the most natural solution.  Literally just
> (ZONE_NORMAL - GFP_KERNEL).  This might need a new GFP flag for certain
> use cases like KVM (GFP_USER) to denote certain "This isn't technically
> kernel memory, but it needs to be pinnable".  That would slot right
> between ZONE_NORMAL and ZONE_MOVABLE.
> 
> Alternatively we could go the opposite way and introduce ZONE_KERNEL
> below ZONE_NORMAL and disallow GFP_KERNEL from ZONE_NORMAL - then have
> strict watermarks on ZONE_KERNEL to ensure the kernel is always able
> to get memory.

I'm afraid any new zone will be highly controversial and take a long 
time to get accepted, if ever :)

The real question is: would we really need a system where we mix e.g., 
ZONE_USER with ZONE_MOVABLE?

Or would it be sufficient to selectively enable (explicit opt-in) some 
user pages to end up on ZONE_MOVABLE? IOW, change the semantics of the 
zone by an admin.

Like, allowing longterm pinning on ZONE_MOVABLE.

Sure, it would degrade memory hotunplug (until the relevant applications 
are shut down) and probably some other things.

Further, I am not so sure about the value of having ZONE_MOVABLE 
sprinkled with small unmovable allocations (same concern regarding any 
such zone that allows for unmovable things). Kind of against the whole 
concept.

But I mean, if the admin decides to do that (opt in), so he is to blame.

-- 
Cheers

David / dhildenb


