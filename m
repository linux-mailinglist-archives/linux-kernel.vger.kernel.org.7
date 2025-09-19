Return-Path: <linux-kernel+bounces-824189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C791B88500
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7E35651B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40192FFF85;
	Fri, 19 Sep 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDyX+Z/n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27A2BF012
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268824; cv=none; b=u1Dy7CPFfGjNRoCDSYYfMXsyrFwPqnvSvY3MmZnk+psTlXX0YDzvBeflwxn5Uj+veosnld1ih69dV88SGnA2sx4WgVz78tcry/CrmEl/VLuYvFUy99zXypX8NhX/VuTiHV2QWBgEd1gsopLIGJnmsfmqGkabWr4+JrTZblglSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268824; c=relaxed/simple;
	bh=vZ5gUzRzqXUROSY6Gp+IoBLhQ3uHYI45KM/yq/+dme4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiWFUaNYMkn1XkfA8WuJ6jX86IKkIn6KzQcp0pb1YgYl4JKVhf9OVoCzNk3H2+WYvsuSHNlxXiNFxZVGWK1wBsRzcJ224JXUzVxDcViqcyzP+AaAPGSRop0L0NPVYMeWCJ+M/1Z9cltO0svojluBrrjIGid/OwAB1hwAS327j90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDyX+Z/n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758268820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h+042s/OQ8tt/41h13rc/O/ZdxLQ7dgj1n0m0iBdyvM=;
	b=jDyX+Z/nDGHEcHm38yD61cqJACToFODuJc1IArXByaQxohYKue7xGnkevm39lN4A3BQqLu
	BJ8Oa9t/BHH+pdlMTqUFnwEkj1PIfSnIi7guHjSqWhcbIJrhRiqeOlOI21p7YLcfKjYhqp
	EnwqwwYq+LXsaErpS/+IWp6o8GbzELU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-fbY-a7t5PpmzTa8Rwy9Mvw-1; Fri, 19 Sep 2025 04:00:18 -0400
X-MC-Unique: fbY-a7t5PpmzTa8Rwy9Mvw-1
X-Mimecast-MFC-AGG-ID: fbY-a7t5PpmzTa8Rwy9Mvw_1758268817
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f29eb22f8so9098245e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268817; x=1758873617;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+042s/OQ8tt/41h13rc/O/ZdxLQ7dgj1n0m0iBdyvM=;
        b=sjfP69kRedaX7AQy8UGOsSiDgCJARpSlMngfEdnBfCDo4Mx4olBPGnEP02D+czN0q8
         JCeH5UK7RLyZFxFgjZvnyJy+4h6HVLRkDEZK5BH4TZnypbNtXTxAGvdDY4bUyPrJKfWc
         oeMkEr8eN4W+7mSBwK/sCa1vsxtIZabIVXX8Jem0jhrdkkVz7XxYVjhUlhYQLRID/rjT
         nXAd++16BarSJ1Vm97y+onyqGkMBfMfBgmKteyBW30QkvQvPlyqnzAsgnF7TqBiz7fQi
         yCf/xUBq6VBNXZHw0K7ZGHTAEvDcMHPZjyPzVbjuwxQZoDWuyxyZrUMhAOFUix4aeNMH
         5HQw==
X-Forwarded-Encrypted: i=1; AJvYcCW5GjfvZ0z4p9BpLv8mF/No0xEIqJPI6wjbwZpv9+15+IIzcfHDlvg2FxwPoc5NlvqhRke5nPhvs89En/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5v+zPj4Pgz79bbFX/h9GYy9sAsYXTC2Bx5eihD1WGNODit6cs
	WpOqMBrPvFE42O2R30J2oTa/dmwucG2WPJy93nZOpAVOEcATWkP4boKw7iVBn+PFFji4KAfztkD
	wLAyjmqPuTrgaBGpjB8rIsExvu+B7I5jKmnq0WUOhKT7Ml/bexlBnAiHOf7d28gCNDQ==
X-Gm-Gg: ASbGnctR3u6TyA0Z5apwlAGNooCdPKBe0pGF+Y94XOPdiqAzH/SBb5RpRjqLLVdHVq4
	Rdf/pwgNLyWLBd754SeMZdwTcX1F0umf8yVAbDUy0fiGq0VDgA4jDE3HVjv+MS3I7aGl6MzCSir
	J5vvf7sRU8Zp3phn4rKhZxkMdyVWO2BcG+n+hMB8ozG+XZn0O4sty7BGd+AJVD2vJ/0h/LNTuVl
	xqOYgr952wzRZlwrUmraNFoZVsn5GFOuI/A58ToqN3zOGI6wlhxImemRgNsMiDY/ia6ZnGd9DTA
	ynsMuj4ROcMsUPJhxkmrMeT6mgwcYOsu662FzT7sL38UuXIhHjp9QoHAxMAQPrFmJsthOPSdQMT
	GoSCUhcBDB4WpJ8ZZhipTiFKUzJq0EZft2a+EwvYgqQRK45G6zO4Ns1mmcJQMdyILXh20
X-Received: by 2002:a05:600c:4fc2:b0:45d:ec9d:5fde with SMTP id 5b1f17b1804b1-467ec46079dmr17229375e9.37.1758268816908;
        Fri, 19 Sep 2025 01:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGom1Qw6n3XFPDCOTSj/1O9ThoOyY8Y4gVn1ncgKcnD1fztu0a8MoRQ/npOz5+Wv2OG/wiqSA==
X-Received: by 2002:a05:600c:4fc2:b0:45d:ec9d:5fde with SMTP id 5b1f17b1804b1-467ec46079dmr17227785e9.37.1758268814964;
        Fri, 19 Sep 2025 01:00:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:5600:727b:b2f6:94a1:a51b? (p200300d82f235600727bb2f694a1a51b.dip0.t-ipconnect.de. [2003:d8:2f23:5600:727b:b2f6:94a1:a51b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e849a41sm113556505e9.20.2025.09.19.01.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 01:00:09 -0700 (PDT)
Message-ID: <db051a89-4eef-42c1-9fd2-16ffbad18b75@redhat.com>
Date: Fri, 19 Sep 2025 10:00:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, hughd@google.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
 <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com>
 <17d1b293-e393-4989-a357-7eea74b3c805@redhat.com>
 <4e938fa1-c6ea-43fb-abbd-de514842a005@linux.alibaba.com>
 <tombfifwrhx2n4jnj2pgcdcpj42mdv7yizkpxrppnqrtsxd5fw@epnrjqgmmy6z>
 <787dc1a4-d0b7-4559-8160-55de987beac3@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <787dc1a4-d0b7-4559-8160-55de987beac3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>> -        if (folio_test_private(folio)) {
>>>>> -            if (try_to_free_buffers(folio)) {
>>>>> -                folio_clear_dirty(folio);
>>>>> -                pr_info("%s: orphaned folio\n", __func__);
>>>>> -                return PAGE_CLEAN;
>>>>> -            }
>>>>> -        }
>>>>> +        VM_WARN_ON_FOLIO(true, folio);
>>
>> Unexpected but better to use VM_WARN_ON_ONCE_FOLIO here.
> 
> Um, I don't think it makes much difference, because we should no longer
> hit this.

I mean, all VM_WARN_ON are not expected to be hit. But if it ever 
happens, it's usually going to be a lot.

(I recall Lorenzo wanted to look into cleaning a lot of that up and 
possibly unifying both helpers)

-- 
Cheers

David / dhildenb


