Return-Path: <linux-kernel+bounces-872433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76359C11357
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C709E563530
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B431C584;
	Mon, 27 Oct 2025 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC2OH2bD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210DD2D9EEC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593266; cv=none; b=fucEmrOzGWtshESjfzrwtG02npEl4D8AovmH23DbmgkQgr3QkXml78Dmb/mR0/5PymmobIB8/VH0GeEHKp0k6laVq3WrKMgSjAn4+Bi6lkrjf+ktH9AYN3r3ae4HH7CvtI/XFfUJf5OlEEFF8zr8WERAGUAxAbyIY//CJorRTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593266; c=relaxed/simple;
	bh=f3eRkMag5ov3KE93lLo7WdKz1DdH8y9+UCo3+Ee7ANQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fK5x3qGOKbNgtBlWmYTXh+FXA0GSuzcX7E8Az3ZQ/8NZzlM4LFA7ig0FyBblXeiDsqJLodb+zmMdIf56qj1Er3hOywOXV+b9TC7i23wReKCpqx372m2DWfreY8dW2aDcXavygEAYJ31NMpgQ1VAwEbW2wToiW0ILMaCXedavQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gC2OH2bD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761593264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2w78NxW1jWIqK+QOMKPJt/pP9KIF6sorS7NsXSTfP1c=;
	b=gC2OH2bDswv6E0U99qQdOAyaPXicaaZEhw7xBd8sqI6th70LMYoFR068ajHZ1UaAQX5IcD
	6EV1rDkzG1EyPiDA+9QcknkwKg54DNsAbGGWOjIcLx0dCfBSv27WsNmfuF7HTY6zBKT8hl
	11XGIiJOxRTJLNQRUFG+tNspERzRY2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-41nPxe9GPtWxbkBMJHJ5zg-1; Mon, 27 Oct 2025 15:27:41 -0400
X-MC-Unique: 41nPxe9GPtWxbkBMJHJ5zg-1
X-Mimecast-MFC-AGG-ID: 41nPxe9GPtWxbkBMJHJ5zg_1761593260
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475dd9906e1so12085185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593260; x=1762198060;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w78NxW1jWIqK+QOMKPJt/pP9KIF6sorS7NsXSTfP1c=;
        b=li1TyLElrTcKHsOazlHtSxAQidYdMPOCBXQcgiwnNzryMNKceW80XVtS6Ad0g4nOpK
         +tIdczNvSoCLMSZoZYeInCbAoDdKZFordpyrdjbiTW4Lin1ndJynrjHytxTnrHeCuLqy
         sv1nS8KoX/cyeDt4A7WRpI0wz8Tq6Y614vCv8DdJVqzPNOyWtt46otF3XGFxbfKTtadF
         ORjD72DzJT4pdaNMHq28aSlgZ86pim0wltObx9VvdOoXHqfgrKwLnDa/hvNnQMdi3ioX
         Z6rmdJ3Ly8RpQdymcEKXLWLu/Zogu8C9XQNqkjfBe5qTGnVwReIJB1oQzj+hMT9i/qOt
         9G1g==
X-Forwarded-Encrypted: i=1; AJvYcCXmUfSdlUVHjUDjPzrJ+MyXeqP0otOaWZ7yqmU2G3GbEk3CDHKcuGtT4RZ/32mDGRuqD0cOumYUFW0c/NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDEISPOCW3lHSsikeHPE5O0+s8LBSFwFeCazqDGGzDBFIA133
	ufqiPId8wFlZb17t4ASdbVPAi5pi3Lxmk9pusN7IIkqRvcWK/fy1iMsOTgM1mMseSQZ9TxaVQYm
	Hcj7flipTLLeYsRM1M1RZv3OM348nVHxa8Jg40mJGQWjOIzsyMlSpbvA02BOxsJRU5w==
X-Gm-Gg: ASbGncu60heKBfbvSh8e+Fo+N1CA5xHauC3VDM8+9gE3xf0qh0TaOfJKe5WHoPckAwa
	/4CJAdJLzK3mBJUMKDMUWnGulTQasNc9KerWoRNisNTuobpXlPhxW9KHpxQGIkdn5sNSYm2eRkr
	rIkOFbmEzw+wh1cWdk2jzbnmIId0jesHABKseOmSnfz1zkPoi0MVcjyZUEktWn/VN4ayo5s1VPt
	9jC3JyjapqucqMj5X8KoeISdierIqoRNFwoFZZotX1LA+2BdYhmr78JKDCM3QhICTzJ3va7p0dg
	U1uBPh6+8AnJYZ9SCMvbEVl/RGgh6UbMep6AQ7h7gsNzTXDDaJ6FFMV0bD/sfEhWfnItv/FPHJ7
	nFXQbMei6XE85atLFkJGTJmn9nxVMKhwo/RVx8+lWit+3FVOjHWNlrINe+V5CJvh7ucLrJzpkG5
	oeOIS88fd//owzesuuTqUiBL1DkVg=
X-Received: by 2002:a05:600c:3154:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-47717def755mr7722695e9.5.1761593260068;
        Mon, 27 Oct 2025 12:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbpXllXHAu5xDQPnZivpzTJKRxctkaL1xw+ulo3Yfn9pck8l65PhaLNbNI5P3AXsj60XVLug==
X-Received: by 2002:a05:600c:3154:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-47717def755mr7722575e9.5.1761593259687;
        Mon, 27 Oct 2025 12:27:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd48942dsm153103495e9.4.2025.10.27.12.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 12:27:39 -0700 (PDT)
Message-ID: <3a21a41b-6062-4c81-8b83-c4b922fcbbd1@redhat.com>
Date: Mon, 27 Oct 2025 20:27:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] mm/mincore: Use can_pte_batch_count() in
 mincore_pte_range() for pte batch mincore_pte_range()
To: Zhang Qilong <zhangqilong3@huawei.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, jannh@google.com,
 pfalcato@suse.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20251027140315.907864-1-zhangqilong3@huawei.com>
 <20251027140315.907864-3-zhangqilong3@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251027140315.907864-3-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 15:03, Zhang Qilong wrote:
> In current mincore_pte_range(), if pte_batch_hint() return one
> pte, it's not efficient, just call new added can_pte_batch_count().
> 
> In ARM64 qemu, with 8 CPUs, 32G memory, a simple test demo like:
> 1. mmap 1G anon memory
> 2. write 1G data by 4k step
> 3. mincore the mmaped 1G memory
> 4. get the time consumed by mincore
> 
> Tested the following cases:
>   - 4k, disabled all hugepage setting.
>   - 64k mTHP, only enable 64k hugepage setting.
> 
> Before
> 
> Case status | Consumed time (us)  |
> ----------------------------------|
> 4k          | 7356                |
> 64k mTHP    | 3670                |
> 
> Pathed:
> 
> Case status | Consumed time (us)  |
> ----------------------------------|
> 4k          | 4419                |
> 64k mTHP    | 3061                |
> 

I assume you're only lucky in that benchmark because you got consecutive 
4k pages / 64k mTHP from the buddy, right?

So I suspect that this will mostly just make a micro benchmark happy, 
because the reality where we allocate randomly over time, for the PCP, 
etc will look quite different.

-- 
Cheers

David / dhildenb


