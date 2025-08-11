Return-Path: <linux-kernel+bounces-763161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60893B21129
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7440A6878BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225701A9FAA;
	Mon, 11 Aug 2025 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1FI+u44"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8417A1A9F8E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927586; cv=none; b=G1CacjYIbMnQs2lFzhph9vrGG+zYVRh8mBlpKH9L3YxZ4cf9CggKjlHhNgOHa9muS4z+Vl3EBVWTl/xTrtHKWNZ9KIdo6go6k61GcNkx5SSsp26/pIAk6DkSLeiILfvvDGMUHCzLlBBZJKt0E2a5qx+5CDS9KBCKHbTiCh8+d6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927586; c=relaxed/simple;
	bh=wH+YJJ78SpGXvS/sNiNLkme7MxFSovvNx4cxQr7gEow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fDasxj/AzKS4lzWZ1zp4zqTOgp/U081kFecRx2Hkphk5DEJxxlgAr6jYj3S6TdfdE9t2gr+txmHoK5BGA/F8qoNH8AMOA11i6U+Cz7dvcMN//epNfSq8+7Ea9etvvn6pXH79SJORfqYZqrPztr0BwFUuJKvudmYDVVB/f+9nOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1FI+u44; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754927583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GyWr1QpZuxF9B4FyrzRej7noS4J8x1+3Oa8vyw2kJ7w=;
	b=N1FI+u44s7WKGOvfMDvYigIXqdCOGMdBf5mi2tFLoC12Uyjggv6nEqvDgxoypNxn/5ANsE
	pYneTzh1tWgOt3+3fTId4gKfNlaNlBkHIgDhSGDDyt/LCwqSxJRGPunLvxNlOM5xSeoOPt
	Q40YwklLrr9oQ1K2bDq5RZ1zNDBzWks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-ZNRyrtmLOP-1i8Bb4oAuWA-1; Mon, 11 Aug 2025 11:39:35 -0400
X-MC-Unique: ZNRyrtmLOP-1i8Bb4oAuWA-1
X-Mimecast-MFC-AGG-ID: ZNRyrtmLOP-1i8Bb4oAuWA_1754926774
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d6c83e2eso25675215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926774; x=1755531574;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyWr1QpZuxF9B4FyrzRej7noS4J8x1+3Oa8vyw2kJ7w=;
        b=hNgVkOOX2J+NZCvqUCqCxOyix8V+YMVMKpLYSEu4nnDQIosJJoCTe+6cUYAoSRCrQQ
         Mein7vBe9obzMeAqPFfvp3KgAw+OrkFo7i+sr4qFbb2acEQgO9hwjyvcLsPR8ubLm7V4
         GUst1zwDxXtPGHKIrw00zAcIyg0E4P2HyGVWD0U0eMsebCCmRYHFUO9gxDP7+gHov5TY
         MRH3l0WE4wr5ZixB/jdCfwgTQCkGnlmHKg+Ye1UU5J91zUk7LecAMCwboLUBmILaeyt0
         CwYianAmWahgsMmx2COqNCz3OvLMGhKDySUBINCcHB2X2Jy/TgCGKcKEfk3GGJM5rqdN
         SAnw==
X-Forwarded-Encrypted: i=1; AJvYcCVoikY0Vc3tbXtkvWAEez6I5Cek5DrkTx6L9QM1OJHZvdugo4zAfo24oaGxjWtdT5W/XtNrO33POLbYJMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4FRMUmr7jyq+GVOMw2EDTjoD0iRR92O2weGukBBLqEkDnynw
	Ltx5cLLOPnCCQ4r3LFiCLNkVaLz2xXR/PqNpFuhtbr5ZaN7u3slHXTvu32rRaMVEn4Lwxdn50N9
	JbX4ihcD9s2EeGTbt++vZvArB10psG94voq2NMoTcjoko2ZBsbQB/SfN8d7uGqXha8w==
X-Gm-Gg: ASbGnctclF8iXRuo1jeu9wp+QDe6VhGgdyTSeQxMTdo7JPQjTfLoBBR9KvzTWivLr6g
	tGOcQzGJd5I4QRT1hZ+ch7OSY59J08rj3f//yFpt50Zb1R498pv4BawGBjxofnVf4zQ9U3mTYFr
	tiShPixbwy1pOv1XOlYPJcUJ2l9M9XE7llPFyPHVRDz8Kd5F2d/CmzoKOjcB3eCcaO76ZQcDUOG
	tZaX+Ow8X+by3/c808np50oarB1NfDpio5A1RYKwA/xntOcv73B3oUNfMDtkkZX+VfU2y45bNRC
	PZBiDHsqOgNq4St05p2R7Ut2xdgXeqt9xn3sBfKMZdkclNVUkeGLF7NB/9ZQB1b/q5/4ge2PEqE
	1pKzbKCPN4THMAVDNCYHNouCWADSLKd0v5yqfI6fPbrDWT44ClrJUaUA2YssZhCLCxWk=
X-Received: by 2002:a05:600c:c494:b0:459:db5a:b097 with SMTP id 5b1f17b1804b1-45a10c0126fmr1610705e9.16.1754926774348;
        Mon, 11 Aug 2025 08:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlf+7BcvARxFRQk8Q5EGLD08HwQZfsUf/AwyhotSUn7XHRyNjGYRhhAvp4S2PkxpNDcQl2fQ==
X-Received: by 2002:a05:600c:c494:b0:459:db5a:b097 with SMTP id 5b1f17b1804b1-45a10c0126fmr1610205e9.16.1754926773715;
        Mon, 11 Aug 2025 08:39:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b4f9e952sm399513135e9.9.2025.08.11.08.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 08:39:33 -0700 (PDT)
Message-ID: <2e8df53b-d953-43fb-9c69-7d7d60e95c9a@redhat.com>
Date: Mon, 11 Aug 2025 17:39:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
 <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
 <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
 <fec5ad61-7caf-4076-ba81-7b454ec7018d@lucifer.local>
 <9178bf98-2ea7-4ad8-ad43-cdcc02ab863d@redhat.com>
 <904f85d0-acd6-4f47-ab45-fbf18b80f1c6@lucifer.local>
 <7e7bfd05-434c-40b7-98ec-8ce352a8147d@redhat.com>
 <fd35dd5d-95cc-4c37-bf72-52a27fe822ac@lucifer.local>
 <efe3aogdw5wxsn46xyy2rrqui7oghyi7elam7aiv3c6o6hsfbx@ee6dayztcy2x>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <efe3aogdw5wxsn46xyy2rrqui7oghyi7elam7aiv3c6o6hsfbx@ee6dayztcy2x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> I think it may actually be difficult to do on some level or there was some
>> reason we couldn't, but I may be mistaken.
> 

Thanks for the information!

> Down the rabbit hole we go..
> 
> The cloning of the tree happens by copying the tree in DFS and
> replacing the old nodes with new nodes.  The tree leaves end up being
> copied, which contains all the vmas (unless DONT_COPY is set, so
> basically always all of them..).  When the tree is copied, we have a
> duplicate of the tree with pointers to all the vmas in the old process.
> 
> The way the tree fails is that we've been unable to finish cloning it,
> usually for out of memory reasons.  So, this means we have a tree with
> new and exciting vmas that have never been used and old but still active
> vmas in oldmm.
> 
> The failure point is then marked with an XA_ZERO_ENTRY, which will
> succeed in storing as it's a direct replacement in the tree so no
> allocations necessary.  Thus this is safe even in -ENOMEM scenarios.
> 
> Clearing out the stale data means we may actually need to allocate to
> remove vmas from the new tree, because we use allocated memory in the
> maple tree - we'll need to rebalance, new parents, etc, etc.
> 
> So, to remove the stale data - we may actually have to allocate memory.

Ah, that sucks. And I assume we cannot preallocate early, because we 
might actually require multiple alloc+free cycles.

> 
> But we're most likely out of memory.. and we don't want to get the
> shrinker involved in a broken task teardown, especially since it has
> already been run and failed to help..
> 
> We could replace all the old vmas with XA_ZERO_ENTRY, but that doesn't
> really fix this issue either.

No.

> 
> I could make a function that frees all new vmas and destroys the tree
> specifically for this failure state?

I think the problem is that some page tables were already copied, so we 
would have to zap them as well.

Maybe just factoring stuff from the exit_mmap() function could be one 
way to do it.

> 
> I'm almost certain this will lead to another whack-a-mole situation, but
> those _should_ already be checked or written to work when there are zero
> vmas in an mm (going by experience of what the scheduler does with an
> empty tree).  Syzbot finds these scenarios sometimes via signals or
> other corner cases that can happen..

Yes, I rememebr fixing one instance of "0 VMAs". Most code paths just 
don't apply if a process was never actually ran I guess.

> 
> Then again, I also thought the unstable mm should be checked where
> necessary to avoid assumptions on the mm state..?
> 
> This is funny because we already have a (probably) benign race with oom
> here.  This code may already visit the mm after __oom_reap_task_mm() and
> the mm disappearing, but since the anon vmas should be removed,
> unuse_mm() will skip them.
> 
> Although, I'm not sure what happens when
> mmu_notifier_invalidate_range_start_nonblock() fails AND unuse_mm() is
> called on the mm after.  Maybe checking the unstable mm is necessary
> here anyways?

Can we have MMU notifiers active while the process never even ran and we 
are only halfway through duplicating VMAs?

-- 
Cheers,

David / dhildenb


