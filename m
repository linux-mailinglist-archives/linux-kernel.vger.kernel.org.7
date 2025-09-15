Return-Path: <linux-kernel+bounces-816997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F65B57C22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1FC188EFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A330C604;
	Mon, 15 Sep 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkCTDSIs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F430BF78
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941167; cv=none; b=lndOiqG+n6RLIVyZD49AI50pmDswpARPesfMfDgcmE9N/0NE0r7Egeq9RRNMInczeQ6T4mO6/sNDNvDxGq+1aMPi0h0d/zrHVeC+7wKfB2zVC+AAS2QS1pzz8yTyZku3zuJV/kL3dA6xX4jSOWcK/lOcdh77nIqfnahoGJ9J3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941167; c=relaxed/simple;
	bh=F/zAZgU2FomGVtqnhxBwQWziN36p1+sFiuLHtl9Ytrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E00FUnczZrHaiuFbdISkpBKevYvvW/EnnxR6nRVlufaHp2gIVeIduqvvY5SITeR+7Af1Y/ohz+0WpuPb5dxMqnZDaIPYzqDNEMMl8oX28HVXN9u1bwUDok6FKnxlTr35vt/5J40t1rfJ4p1MlnQKyaGvjI2F5o+zgNTzf8gVVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkCTDSIs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757941165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z9AyUt4haocv7F95i9a+JlLpc0x0YT4r6qftqX3qLrs=;
	b=fkCTDSIsbl48ReGGj+xigoTjnaFlixpMGDCSPxA/O+LBiWEpGmbmz5D8KYtxlYWwHtzpc0
	+fmCwaUuAl6chO7Q6T4YkQUKNXGQKpRn+qultnxChbreQ6+7Z0oE4Yj6SnrNQB2JqPbAI2
	G+/J07fzDxxG48VKIj/pkwVHilL1rNw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-e-5GBCcxMkehMdqvksQC0w-1; Mon, 15 Sep 2025 08:59:23 -0400
X-MC-Unique: e-5GBCcxMkehMdqvksQC0w-1
X-Mimecast-MFC-AGG-ID: e-5GBCcxMkehMdqvksQC0w_1757941163
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45de07b831dso22833535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941162; x=1758545962;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9AyUt4haocv7F95i9a+JlLpc0x0YT4r6qftqX3qLrs=;
        b=N2zC4SyndQ9R/MnaiaYFb4JNR5n2QJyGVmycwfG2my0Ij6/B0Eq8N30H7mcG6tTSVs
         tBh0Htp1zpM+VpZ9nzqeRRuo3v0SEx0uwpO9uGjTMUiM2h+kQ43RRei8TESry1rRrl44
         43XBgHtMyee7rup/wX9tJYiz7hE4qlcnKyojYJgcFzAZJZEYGu48VtM3u3yZD3gAxcL6
         Ix2J3P7e+ERaXMth1Nwk9TSFnzdvoZ8b4UTFKljatWHQRRpRDRk1sgfVdSfn0IleNewp
         rnEgFCEX8Gv7pqj8TjHRRJN9hJgtC9J+2fsQu2fRQXnp5vjxtQzJ74W7nDbzHxLnCd15
         AG0w==
X-Forwarded-Encrypted: i=1; AJvYcCWcfy/HL4b7KukqJpLbixws+lu4b5bCUJIsggUsYwTpf8q7kIdUKdJKIHdnOFSolIB5A/9K+KvaNZ0OLUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFK1AiN/BGALfcf1mGxkEOgll5GjqI3WDPxiBjrSE2vjmhOIHY
	zxF/Crdi0FsO15iwqZfmVSmqSrM14UScAurMRriwgJpgn0hBWUJLFK0qPrjTsS52BIJ2V3VUA7m
	CrBpuKkc/6Sq0CmXxsfxMaa3Eyn1vrfjKX7R/pvBD7tWHf2Acd2w19Z469eHaOnTDvg==
X-Gm-Gg: ASbGncscJ7g2h1Qa3yEHc4vOiAo4ljDtDUARo/0fetZB2wJFxI5HB3bjeqLBQ2yDW2w
	du6O/m+9DSmP7FZ0m4+QuUMUuFWpyjkqouHYXtkZunsBvJvIuqMuMaro96/UUXbHQzIL6KO8JFn
	Tyu+pPoTKmh+sPbQQDV6bbeAdZtv34QbbSVONot4V2NhtVCh64Be5N3v/BjV8fh47qRZrUWb+ma
	f0qmXpQPkDXVJeo2bWkF6FlH3WwwmyF5Zn4QDFIuPQIZQfg6e/N3JXMv2Zf9pMne6R43+wS2ClX
	4abgDD0VtyxDbCza1dJSRhyXJxFlnVl5qLIZ8C1Gcb2YonIXqy4jXdh/fc+XSIqyrQV3CtiJgug
	g9VnFCrYFGzWcor2Ufv1G39aUo9V4KAzuNYWbVFKuIAZIJmrEQqLZhCLNIWDov1Vp+Ec=
X-Received: by 2002:a05:600c:198f:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45f24df556fmr95538985e9.0.1757941162434;
        Mon, 15 Sep 2025 05:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKriu8iaZGvf/bFu9nYRr4M1WXgTzDA+G+Qti4ilusiGCyEBdwFxvpcMyyGZ5HQLQRNLOcSg==
X-Received: by 2002:a05:600c:198f:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45f24df556fmr95538715e9.0.1757941161998;
        Mon, 15 Sep 2025 05:59:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e04cf2870sm94355605e9.1.2025.09.15.05.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:59:21 -0700 (PDT)
Message-ID: <2af510cc-8173-49fd-87b7-a6f9c59bd104@redhat.com>
Date: Mon, 15 Sep 2025 14:59:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <CAA1CXcD1BhXqYM7oOTLuqPHyWSztdCEk462sYXFXxJCmOpe_Rg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAA1CXcD1BhXqYM7oOTLuqPHyWSztdCEk462sYXFXxJCmOpe_Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> ...
>> 10 -> ~0% used (~100% none)
> I think this scale is too specific, I think it would be easier to map
> to the one above for the reasons stated there. There would be little
> to no benefit to having such small adjustments between 4-10

It's probably best to discuss that once I have something more concrete 
to share :)

I yet have to think about some cases I have in mind, and once I figured 
them out (and had time to do so ...) I'll post something.

-- 
Cheers

David / dhildenb


