Return-Path: <linux-kernel+bounces-887196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4FBC37843
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 497414E2B8A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454AF342170;
	Wed,  5 Nov 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ji2EfKxp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhU5gOa3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2733A003
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371601; cv=none; b=Z1u54/yU7tnAD4rJfVlGdL6HUjkvGuCWn48h7qXW8VBLuHbQGb8FCdWYU+vnOXhh4CPY90IVF37Vh9E7ASyloKLmyAIu6jUfKsgHC6/ZeBuza+TRJ/EGeSwp/NsS94SIeGZEo4NsAqrpUo6qU3fnHLcM/TKcU5wnbRRRxXVGqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371601; c=relaxed/simple;
	bh=+SOyxLJBOfbSw/MqBDPVxoL7LcgQEUyR14RhOCQVl6U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rVhTdQH6ZtbpJrpdXUErfnL7BuH9KFU93ygb+W2B1RURo0L0ySZ6gR+k7Alb/vqr5IEfS1VbHyxDCOG6hOVEJrV7FsAylc+ucQ/1cRyMUv+6Xxgmxlu/G5LyGQUZSSj5qA7O0Xlm3N/DMZukSYYp0P41Z0n0qNFirdu4bkpnl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ji2EfKxp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhU5gOa3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762371598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kizs9xJ2GRG/rLXAdsJnM3tvDx/8JZcjC0BTEZZ5WY=;
	b=Ji2EfKxpkouMdAoEvwjcpOHzHYFZhaM7jucQYDckjDnvfUtx7PFR8xXeqaQLCYHcVYgMka
	LHk966IECzXZey1eZFLuYckMCIxYYB6b5mZ4CC0sHvkI0QKmZfFqQnGsXz43zmQEUdU8YX
	BL0LLF04F1SuySglXbOwLw5JjUQax84=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-NO6DoMwQMMKiDhc8VlCipg-1; Wed, 05 Nov 2025 14:39:57 -0500
X-MC-Unique: NO6DoMwQMMKiDhc8VlCipg-1
X-Mimecast-MFC-AGG-ID: NO6DoMwQMMKiDhc8VlCipg_1762371597
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2217a9c60so65265985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762371597; x=1762976397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7kizs9xJ2GRG/rLXAdsJnM3tvDx/8JZcjC0BTEZZ5WY=;
        b=bhU5gOa352yz6IMZNQMetzfE9fawz8lYejcR/dsPOJRFkYjWHgw9vmAiwAPDrfVHNe
         1SkuKfO9+wuixdu8J62kqL1yuPNN4UxT85BcWZYpR0d5mcq0muQGq7GOs9hlUDoDamn9
         qDc8zCFQs2kW8KY1q+oIEKTtdFq2w/PfUdDP4pQKE2gJTBF9krK+GdbUpi3/mnhS0E9c
         4bG9g8VDvW0JJvR67KQxZ4wEoWwbQfPWMP6aIb76vC2J1+no6tS5u8gwhyanuQ7TQk41
         XtldFp/Mq83IHfqtsAD6FFGYQ6dLzZPs7AdY8DQItDo+idRaRcXQZmkTlx2fJPZR63dO
         eX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371597; x=1762976397;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kizs9xJ2GRG/rLXAdsJnM3tvDx/8JZcjC0BTEZZ5WY=;
        b=M5gkSfmBVzayb9/ez7ge+8BNPDZKeDAzT4LAK+Qm2tn2QrQvanfLX+ElZ9azx4EXwp
         KrZmutmowibD/HHVnOuynzBkg2V4Jv4rMtx1VtE4vQr8xIqr0I1bAJGb8CVZXdXDnxix
         yZP4GuRld2cxtpfcuTp3z0U0dGM7WvpHjFXIVAI18WUawxrph+UUUFBbiEcTrkrgJYXs
         m8znqr1rEhRA3Xd9oeuy0C3KOkKm3rSXxhNX0cgINYU6YlHdz+rwTwfIKFmeSOfu/ooS
         rosW9FzeGOV/S0zoe5LBNyxOf6T9gIErPYwwqm/zgJexkCID1tvqYQSkpt/Rq+z+0m+F
         0v8w==
X-Gm-Message-State: AOJu0Yx7Wl8hmlD04eSJ2uZOL6NP0DuzSLZ8jWMU6hLbD44J/ZnHdxEU
	aNU/C4UcsTyI35ahKgpzo05BjNIv8T34eE39aigmTgoopYzkRKGZoL3eB5AkQNobcpY/UNg/TWL
	Jw04KILAOXiZMURUyPqdm2mQRIebef5OZ98oiLxYpJWNrCnhndOjblQhfz2BgjiIWLg==
X-Gm-Gg: ASbGncteZGuDuZk+cF9p669awBgjUJ4M7cCS3ek74mM+JCWFag6qhGTmY4J5ZajR1VO
	AS8KOl5WTK07vOyYYCGfd8oPidul558c6GxBTJapG4wIMjTnnx4F3Lq5/jqxQ/Pbxn+Ds144dJn
	ERw3BQlF09KlzernwkmWoTvzrEPkCW0m2QhZYefyFkOO0Alga5zWBXbaxNinDeNkObOIkf817Zn
	FP+pIzQIroaf9dc9AIhEwj9WvAJ+Yc8TTO2ESOy5SElC7H5u38Z66xWEGA6/8Ik2wd/JRYpSeGU
	cDBJmShqIvNTeN1dyhxe+qMRHH7K4G+XK4sJraufSokv9rRcwZd451pbxYFpay2t1QTZrmNmrGf
	9tSFjhfVJbimkcBemscO/dVhHoFnLVzUUvhup2x8CYRLMQw==
X-Received: by 2002:a05:620a:460f:b0:89f:7109:185f with SMTP id af79cd13be357-8b220af7c8dmr589560885a.31.1762371597235;
        Wed, 05 Nov 2025 11:39:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd9eT2YzuyaD6xKA1zXzyy0WWTMe4/Y4jwbmI24djGe/tYf+EHmXjHRZnQzj3cSXaGnWo3FQ==
X-Received: by 2002:a05:620a:460f:b0:89f:7109:185f with SMTP id af79cd13be357-8b220af7c8dmr589555485a.31.1762371596761;
        Wed, 05 Nov 2025 11:39:56 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c2797sm30330485a.10.2025.11.05.11.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:39:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <74c2751a-4de6-49fb-b675-dc3c7f6e0bef@redhat.com>
Date: Wed, 5 Nov 2025 14:39:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-14-frederic@kernel.org>
 <ea2d3e0e-b1ee-4b58-a93a-b9d127258e75@redhat.com>
 <aQtxMYmwzfg2NW1O@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aQtxMYmwzfg2NW1O@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 10:45 AM, Frederic Weisbecker wrote:
>>> +	if (!trial)
>>> +		return -ENOMEM;
>>> +
>>> +	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
>>> +	if (!cpumask_intersects(trial, cpu_online_mask)) {
>>> +		kfree(trial);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!housekeeping.flags)
>>> +		static_branch_enable(&housekeeping_overridden);
>>> +
>>> +	if (!(housekeeping.flags & BIT(type)))
>>> +		old = housekeeping_cpumask_dereference(type);
>>> +	else
>>> +		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
>>> +	rcu_assign_pointer(housekeeping.cpumasks[type], trial);
>>> +
>>> +	synchronize_rcu();
>>> +
>>> +	kfree(old);
>> If "isolcpus" boot command line option is set, old can be a pointer to the
>> boot time memblock area which isn't a pointer that can be handled by the
>> slab allocator AFAIU. I don't know the exact consequence, but it may not be
>> good. One possible solution I can think of is to make HK_TYPE_DOMAIN and
>> HK_TYPE_DOMAIN_ROOT point to the same memblock pointer and don't pass the
>> old HK_TYPE_DOMAIN pointer to kfree() if it matches HK_TYPE_DOMAIN_BOOT one.
>> Alternatively, we can just set the HK_TYPE_DOMAIN_BOOT pointer at boot and
>> make HK_TYPE_DOMAIN falls back to HK_TYPE_DOMAIN_BOOT if not set.
> Have a look at housekeeping_init() which reallocates the memblock
> allocated memory with kmalloc to avoid these troubles.

Ah your previous patch of this series did that. I was thinking about the 
existing kernel code at the time. So you can ignore that comment.

Thanks,
Longman


