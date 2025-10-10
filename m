Return-Path: <linux-kernel+bounces-847889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99872BCBF50
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0438E403408
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D582773FB;
	Fri, 10 Oct 2025 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8YEblkX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B06274FDF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082039; cv=none; b=Y2CRiBGMFeinz4+yiau/0oj97BnwET3NegNiaY8+Qkm6jCEbd+u3tbO7x368YD5e9mrkbDTSV73poGfQ692rRBS9As6hXnHllSJYubLg5M4bv+n/V9wncijEFpkdanJ8KEVVQAg2J8kzUwz/a6pn1pUBB0uNl0S3brVjJwXBQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082039; c=relaxed/simple;
	bh=bAjqW3ERl7MASAWOsSr2+cO5+t8F79Wpb3UBkz/DF3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvoYAs3xXGRqcv7vUSvHagdpEtFbJisFB4vJ9F1D+bKxhi/lybiWgjetbBoUU9j67QdKAvipUUZHCP8hFHmlCscRDzq/DLXb1Z6cxE3XO3SesD9GlC6HUFGC5U9ULFsTYoa41/nWVfv4EQkGTx/kUjsPcVAs7ft4l0hcDkb0j8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8YEblkX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760082036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fwJz/AqNSYJZ9V1C2xBbiX8Uw8ClPqDAnbOwKwUJ1Rc=;
	b=S8YEblkXSayEzZtLTMXCYUQ2eIP/n8VF+PubZ+i9AUtjh6k+mCoQO+Rv5XqnbMegDu4nsG
	7FlnAwdBeizokqEpEUbH41PmqNqjp1B0zpXyPckGMK/knxGwSaIrU1dvsX2+2hn+LNpQPB
	9SpNGjzek+DqwhsrqHVrrMQUldGXZxQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-GIEDaeBNMrqYl-kw4uUL5A-1; Fri, 10 Oct 2025 03:40:33 -0400
X-MC-Unique: GIEDaeBNMrqYl-kw4uUL5A-1
X-Mimecast-MFC-AGG-ID: GIEDaeBNMrqYl-kw4uUL5A_1760082032
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso10202965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082032; x=1760686832;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwJz/AqNSYJZ9V1C2xBbiX8Uw8ClPqDAnbOwKwUJ1Rc=;
        b=KoFisk+8r9I7CTRqRUdmQriE1oDnRCdNMPKEL6cJWyv9JadjSXmDPa1Ly6JwCr2xCn
         RxdlujzLyAjt4Eeu0D4/o6SJ5jzuvbeq3EsBK181ulpVMzQzLkE/mXFusH6jD5uL9lah
         XnVGVMd7dWX33EL21TIOlPrK52Z2ZT9IQKL57K43hrBy4ZgiII1G7jz9CU1+YeJH3hV9
         ugioqZBAYRZGkgv2ALgfw0zs7o7dUtI90dz5Jk1YH3nyLo7uxQQMxtZ6mqrRWZhHllA9
         If+xOquNzmJRbLtKq9kD7/7tN9q28ykHEBbecBHV5E5iRZiSbzlTx6+zjJ7TOT/5VVKA
         7bcA==
X-Forwarded-Encrypted: i=1; AJvYcCUfNClY2PbaQ6wng3ML0Vp/8MixpEvgeChOSKvc69Hn6EIvxcIRICzn+eau5n+Z6zbMs1jWE/6/U6D2nSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4Vm5g9oT4AQJsxp1UwYYXc1ZEBc/AmJXpK3SocEsSLranzhN
	oq1dfBB26Yam0ymHMO6EqIbCi7a97iOEBsiM5CQ0F0IdVixLyK7D2ESoh7atagzH/7tkzRFOp3g
	IKMQxG+6j49XQW9qD42kwFzc98pc2ZT/DZGa3ts7Ka7NWIj2JrK2Mpq7Djkw47sbbDQ==
X-Gm-Gg: ASbGncvmbE6D92Q6TvG8tVoE/yP/gjvsvrD/KD3iEaTMnjbsl7t6ZRgykmRbp/TkMJA
	GBQGK5C4rw0iqG0DJcZvpjikSvdVVB8XS1jDNuXl1IVwKEgz6X3xMxHgHxI4a8V64ELujz0fzkN
	uLVI/7sjop6uiNl4f98fVC6OvxICbfyRD/ox9ZLzMO/VRC9f8oSU6Eg4ifdhx4qXvFlF44guyh6
	O3KxpW8+kvk00UURDwcTzT/eDslBbydZNPJXaX/ydDbrMtPlnVt22td+xdnSTM0D8exYekAXtYF
	gb5r9SvEKs05mYfpNpw+bwQPLeKVXNecvvW+MgDGzBx/v7hM0tA/EELL/ZLSEj+ehcD+NYMPsGz
	SRf8=
X-Received: by 2002:a05:600c:5486:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-46fa9e98810mr73730185e9.7.1760082032403;
        Fri, 10 Oct 2025 00:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3lq9nxHi+CEqnziqdMyoKoOLYsWDdxhE4EmiTf95ov9ATpNl2HHkuJv4MfSmlUI8Cd+bijg==
X-Received: by 2002:a05:600c:5486:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-46fa9e98810mr73729925e9.7.1760082031973;
        Fri, 10 Oct 2025 00:40:31 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2c1asm54109495e9.1.2025.10.10.00.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 00:40:31 -0700 (PDT)
Message-ID: <1d7476e6-5c6d-4175-b28d-3622222ea8e6@redhat.com>
Date: Fri, 10 Oct 2025 09:40:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
To: Gregory Price <gourry@gourry.net>
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, corbet@lwn.net,
 muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
 hannes@cmpxchg.org, laoar.shao@gmail.com, brauner@kernel.org,
 mclapinski@google.com, joel.granados@kernel.org, linux-doc@vger.kernel.org,
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
 <ac0393c7-9c0c-4b4d-8b35-5e6369e5431b@redhat.com>
 <aOgpz6no2Jx2-Y8Z@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOgpz6no2Jx2-Y8Z@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 23:31, Gregory Price wrote:
> On Thu, Oct 09, 2025 at 08:51:54PM +0200, David Hildenbrand wrote:
>> On 09.10.25 17:29, Gregory Price wrote:
>> Or would it be sufficient to selectively enable (explicit opt-in) some user
>> pages to end up on ZONE_MOVABLE? IOW, change the semantics of the zone by an
>> admin.
>>
>> Like, allowing longterm pinning on ZONE_MOVABLE.
>>
>> Sure, it would degrade memory hotunplug (until the relevant applications are
>> shut down) and probably some other things.
>>
>> Further, I am not so sure about the value of having ZONE_MOVABLE sprinkled
>> with small unmovable allocations (same concern regarding any such zone that
>> allows for unmovable things). Kind of against the whole concept.
>>
>> But I mean, if the admin decides to do that (opt in), so he is to blame.
>>
> 
> For what it's worth, this patch (or the new one i posted as an RFC), I
> was able to allocate gigantic pages and migrate them back and forth
> between nodes even after they were allocated for KVM instances.
> 
> I was surprised this did not cause pinning.

KVM does not end up longterm-pinning pages (what we care about regarding 
migration) when mapping stuff into the guest MMU, so KVM in general is 
not a problem.

The problem shows up once you would try to use something like vfio, 
liburing fixed buffers etc, where we will longterm-pin pages.

> 
> This was all while running the QEMU machine actively eating ~2GB of
> memory.  So this seems... acceptable?  My primary use case was VM
> hugepages, but it doesn't even seem like these have been pinned.
> 
> I think the confidential-compute / guest_memfd path would have an
> issue, because those are pinned and/or entirely unmapped from the
> host, but that just seems like a known quantity and a reason to leave
> this off by default (make them read the docs :]).

guest_memfd allocates folios without GFP_MOVABLE, because they are ... 
unmovable. So they would never end up on ZONE_MOVABLE.

There are prototypes / ideas to support migration of guest_memfd pages, 
so it would be solvable. At least for some scenarios.

> 
> Seems like this is pretty stable tbh.  Obviously if you hack off the
> node0 hugepages migration fails - but I feel like you're signing up for
> that when you turn the bit on.

Right, just needs to be documented thoroughly IMHO.

-- 
Cheers

David / dhildenb


