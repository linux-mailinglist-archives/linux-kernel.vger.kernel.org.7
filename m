Return-Path: <linux-kernel+bounces-688538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC1ADB3D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C5C3A2C62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74371DE2BF;
	Mon, 16 Jun 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8VsEx//"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90A14F98
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084004; cv=none; b=Jd6AajTt8tmlrOb/p4r60m3wgQX41SE9D+5UH9V+S0nhC2L0eOzA27nfg6jSpIsXPVlIHwzOH8eJoVo4bRDK3f5NOAOgBYQRIUIhnvBFsHSNafSSlm3HYskewThIMJdcEBuaBMZatQ7q6VM3hBLTEHgBI5+H75Rs/Uy2tB9bN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084004; c=relaxed/simple;
	bh=VdTd3t4yRfcKnz3b4mUanyqkG781sAnj8Fm2OKk72IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7Zq4asTTnpfE2iYMluI2B6ctXQoUo0X+Hbxs2A8SAJ+QTMYiNvuK2Uob0oJ9pFdK/AzEjiHKTUVCQWlOPTq4Mt8Pa6EJeMP2yN6eiOWSYjQ182vfdTqJ+N+mLD9hUwrRG9qzgEZc+4V+wfXGvyjRqJtSsjpBNAm6VXTSL9pRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8VsEx//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750084002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1fgPDBu0KJ43+rGAV2urrNF2orX2coVnVUvF2z+7Yq8=;
	b=A8VsEx//y+Mg0GiHX21+13RKczIZbTNqBan0N2ipdVypbgThi0yHTqCb7h2/a1aUdMG8De
	ZpObInBqacH/j2UBc8xelBzQ+pjn5uYopHarVkpI+PDQt5gvWvz1F9nGOHSQv6Jc4qVCBN
	Z3S+l2WT/YbqgngaNPpYGD+K8sMDS5g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Hdlh3wpYNtqV34IYvOWxXw-1; Mon, 16 Jun 2025 10:26:40 -0400
X-MC-Unique: Hdlh3wpYNtqV34IYvOWxXw-1
X-Mimecast-MFC-AGG-ID: Hdlh3wpYNtqV34IYvOWxXw_1750084000
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so2789415f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 07:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750083999; x=1750688799;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1fgPDBu0KJ43+rGAV2urrNF2orX2coVnVUvF2z+7Yq8=;
        b=KaRp/ydCPYdPHnifVB2Ye2TkO671lCWAdzz6mdwt28yS1LEr3VDsfRyCVd3zLdBLwQ
         QCP1Tb+Qtoel98C7naTuGyi4eencEGOvA8+h4fEwDgJQy2xcq60l9/4I8rZyonX2obad
         6XPV/UArFHvUUv08fXprT/rsi+abOsFDSi855stNx/Ygk4V3FS6N5uDCKgDvnZnA+VXE
         jKiV4S8OieHUFMyP9CItTDh/t8YmYzXD1HZiqLcC4D+trR7tNIj+eToNkVoBylrdVpeJ
         UnB3CrS18V2VdB4HYyq5Mw4k7UyvtPslGChYHIHGIU/2KYauKKnkf2riZ9i9Px8mAplC
         Q9zg==
X-Forwarded-Encrypted: i=1; AJvYcCUf250NMW/vYYbUavzdavNNGs78ZIJ0Rwo/QngTbBDyJQv20kp+4GWY5FI1veSPSNCiGYDwNVOP6sE2ZyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyRYBxUXrU5hSQXbj1TbJKdlTOxSPaJxw1iD8J8DvpkWmYgTD
	InCDAb8po2Y2jLW9Y2MeMlnwkIMTp489U/qdFyeep3UeMy9zoEok/t0coweVVk8xRfpsJyn7ivj
	uZJUm+hnOD8n0WNpD19lmWgeHQFjbD6ACsvs3dJCbcQChOmYuIeQN1eKItNd8bF0wB9Nc5VnpTb
	G4
X-Gm-Gg: ASbGncv/gn8i4WOflOyDO6W+cvkPkF4RyZg17XBYuujlCN4bEyU9ar/nQqjCuyvuoLp
	AZynaUdSiPR1Io9pCJh9IGMLxxGVxFPf9zqRCu1Q+E4WwVnghxWedWfx24mFR606LHbcL0o8cNS
	rfkmtrKg3A06F+mv9jdCWkJsXa+ZyTFuMS0DBs4aXUTVQeqKBMPik/AmnnMVioteycd4lELDpG2
	g7BHX6VAlynp4E6R8Gka2GtgfRGAofwEDgSXpFIK/TSmDw7yxt941pYi3a/NTWVaJIfJufU4psj
	PteSBLtNfwjwYHmd4J/b/UImDMnxt8NWSz+8Qfs9szd+g+QFmsEZuf9KnV8l2NFQ9KLqBaSzLae
	qs80Zzcx7EQcrW5Br6y9i/MPGwgqjc1NB6yvPMueOp5rgs6U=
X-Received: by 2002:a05:6000:40c9:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3a572e897camr7732326f8f.55.1750083999568;
        Mon, 16 Jun 2025 07:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELzKc0dIQdYFnjNJSpzNmGnjL9tXEIqxyGsvGT7be6pTwRa2ROwBpc3G5nO8T5y+xiz3UZiQ==
X-Received: by 2002:a05:6000:40c9:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3a572e897camr7732303f8f.55.1750083999132;
        Mon, 16 Jun 2025 07:26:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:bd00:949:b5a9:e02a:f265? (p200300d82f25bd000949b5a9e02af265.dip0.t-ipconnect.de. [2003:d8:2f25:bd00:949:b5a9:e02a:f265])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b28240sm11292833f8f.72.2025.06.16.07.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 07:26:38 -0700 (PDT)
Message-ID: <51662e0b-4ca2-4841-b8ba-cbf32178eea2@redhat.com>
Date: Mon, 16 Jun 2025 16:26:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in
 include/linux/mempolicy.h
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org, akpm@linux-foundation.org,
 corbet@lwn.net, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com,
 ajayjoshi@micron.com, vtavarespetr@micron.com, damon@lists.linux.dev
References: <20250612181330.31236-1-bijan311@gmail.com>
 <20250612181330.31236-2-bijan311@gmail.com>
 <5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com>
 <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
 <e40aa590-f0a2-4666-84b0-c33c8f4fef87@redhat.com>
 <CAMvvPS5bTUfAXy4g79tAq+1DWKX79b33Jt=UNBg-xR9BDa7FdA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAMvvPS5bTUfAXy4g79tAq+1DWKX79b33Jt=UNBg-xR9BDa7FdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.06.25 16:16, Bijan Tabatabai wrote:
> On Mon, Jun 16, 2025 at 4:46 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.06.25 18:33, Bijan Tabatabai wrote:
>>> On Fri, Jun 13, 2025 at 8:45 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 12.06.25 20:13, Bijan Tabatabai wrote:
> [...]
>> Hi,
>>
>>>
>>> I did not use get_vma_policy or mpol_misplaced, which I believe is the
>>> closest function that exists for what I want in this patch, because
>>> those functions
>>
>> I think what you mean is, that you are performing an rmap walk. But
>> there, you do have a VMA + MM available (stable).
>>
>>> seem to assume they are called inside of the task that the folio/vma
>>> is mapped to.
>>
>> But, we do have a VMA at hand, so why would we want to ignore any set
>> policy? (I think VMA policies so far only apply to shmem, but still).
>>
>> I really think you want to use get_vma_policy() instead of the task policy.
> 
> Sorry, I think I misunderstood you before. You are right, we should
> consider the VMA policy before using the task policy. I will do this
> in the next revision.
> 
>>
>>> More specifically, mpol_misplaced assumes it is being called within a
>>> page fault.
>>> This doesn't work for us, because we call it inside of a kdamond process.
>>
>> Right.
>>
>> But it uses the vmf only for ...
>>
>> 1) Obtaining the VMA
>> 2) Sanity-checking that the ptlock is held.
>>
>> Which, you also have during the rmap walk.
> 
> There is another subtle dependency in get_vma_policy.
> It first checks if a VMA policy exists, and if it doesn't, it uses the
> task policy of the current task, which doesn't make sense when called
> by a kdamond thread.

Indeed, anything that depends on current task / nid / cpu might require 
care.

-- 
Cheers,

David / dhildenb


