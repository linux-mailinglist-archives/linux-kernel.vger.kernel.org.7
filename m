Return-Path: <linux-kernel+bounces-747979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1FB13AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C970D3B8AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B50257AF0;
	Mon, 28 Jul 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFNmqLYo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9C43147
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707806; cv=none; b=pVqX+mqQ1R7k7W+LxrStpESvOI900QD4qAtrrKeJcqtKbuj1/pDHdFTkTQL5qzpgSuK7aEHFw7vWoDIrsUVk/+lE+Q2pZ0XFs5l5IQ/M8bB9BRsTXpitG/Wy1fY3YEzYHPIUBBZ5sG3K/HN0UviRUy7RVfR16c09OLZiA7mlFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707806; c=relaxed/simple;
	bh=7Yvvd0kTEHH72qI1p178Lg9kVktivlhHfZY6+O/mPCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0DbnvnLnyWt9qz+IQa3opP1bohpPVWICkN5XVLYwiPTh3vQaECucCLG7UJYpOEBrQO7NgLS25ociqeRaOM7XVCfkoETN7dx98ntgKZ9F6AhfGN6FHDSKpLRIqkFxcVOS4sNYX+mm34f/HuWBp4girsoIELKiueOC6p0+gNKPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFNmqLYo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753707803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J0PluGLIH2rBSQgAj0MdwoDFMgB7c8mn+PWxY/wnuMA=;
	b=jFNmqLYoo4oHxAv16pBid2IRDYkUChN/6fVs0csFlJua2G2n5Jf/DOl2R6rVa0Uqvypyv3
	wEgVqj0K5LYQvx6KmsRWtyJPFod12sv+jmGxiEWf2oV0CoG8A80j+hEBqACJB0x/JS1M1f
	TyUi5rqKqRPzKXQai5xu/vaTUN6TyUQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-GiSJMyKVMA68E7Ru0HnNhA-1; Mon, 28 Jul 2025 09:03:21 -0400
X-MC-Unique: GiSJMyKVMA68E7Ru0HnNhA-1
X-Mimecast-MFC-AGG-ID: GiSJMyKVMA68E7Ru0HnNhA_1753707800
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7812e887aso979314f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753707800; x=1754312600;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0PluGLIH2rBSQgAj0MdwoDFMgB7c8mn+PWxY/wnuMA=;
        b=tDgNBLGGzDbZfHZNqZJnM55Vflg6K+F0yLhymE4Z7+cyOMGQyaEzd3MLgd87S+kLf6
         rwwrnCcjB3iagG2HGGV8qg2Br4bhIqkGBPQ4lHRyNSaHLY+0nFnBMY7/e4SM8M1h0Tpk
         kt4n27sLei2SRofVFAE97CG2IPnF+rJeUbqGPYNKy96arXK9UA6bcZ0AcXAfCBmedR1p
         Q9vHXdiUlnKUo2uSF5t0lMqZRFMlM7WBXU9/KLmQ8w3kpvAtGEFjy+rEN++2W0TUj6Jj
         8GgZFyIdixRu7bw6JwRBrdZXxFUSr32fy/8lZ4JvqTxm+ucbHDJGvBKCjdYK1ifadzwt
         pEWw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ao05F4JOlh6J7CMe2jlAxiFgFYUy0U0yvrkahcZU2zWIN//vwjVFhNn/Ak40md9sqWrGY9F0WI38zo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFzyQ11XmM8WZYBJRpuFnEO8gIQRXvdQQZ0cqVFZmN5G2jASmn
	B7VHBxbCsguesxd6At1spzdeTpBEC0PFa2Nd5s0YFn4mhmcfGRxpcfT1D2ku6/vMZ59BoJOklWO
	8wpPUk4LT0y3mezu6rp6GojkFfDmhMFh8tH3HPQzRsMs46vfvfwTED0HQGqkG//9/WA==
X-Gm-Gg: ASbGncvBzQ5DLbb5WLt9RRVsR8c4dA8YwKE1s9hRBqMb2Twh3DsFtikK8Tm9j7+ua7e
	+fZUrKxVzDTz7lXbKDIHDkZW/R+SO1nneIPGRIMtrSgDNfTSBZdZDdcY9mC4FVqWDfJap8z3PIV
	jHzpkW15dudytyH/B8ERfvKMsMjJw6MN5m1/3aEn4eSUzARMiRYc9GK+6GeBYPtZ56s6apNq3Cm
	Ll1oThSBiGxXkcqJ5PtvXzO0if8xxTtc5kn74epNMJPdlw2MQSGK+gCs9UYVlKxTDfd3ZZ4UGah
	sys3NYM4GLU/QtiLvweLxGp2DORjJ1dpjHCGliPxhIwkB0k93UJlx909fTvMdUuJE8+2IUucHOn
	A0lFK6UEIgGyomyyh1vedw3EpZzBZBT+nGsblOMXeWtAeEKW8hLH21IIyXtFk+tgLdOw=
X-Received: by 2002:a5d:64cb:0:b0:3b7:895c:1562 with SMTP id ffacd0b85a97d-3b7895c19c0mr2265641f8f.11.1753707799962;
        Mon, 28 Jul 2025 06:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9bM25HxST0JsiPjjgsMZ75OiHi2N6n8pmyQKntaVMlMKGwxmNe+fLVHGCDZaplr+sPD5Zog==
X-Received: by 2002:a5d:64cb:0:b0:3b7:895c:1562 with SMTP id ffacd0b85a97d-3b7895c19c0mr2265554f8f.11.1753707799177;
        Mon, 28 Jul 2025 06:03:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f104ffsm8644052f8f.66.2025.07.28.06.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:03:18 -0700 (PDT)
Message-ID: <eabe40da-0136-4bf0-973d-28f39d3053de@redhat.com>
Date: Mon, 28 Jul 2025 15:03:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <aIdqVNCY-XMNICng@tiehlicka>
 <1f8d924d-3554-43a6-a75e-66a08d1ce7b9@redhat.com>
 <a06922c2-9dad-4449-991c-913fa7765bc2@redhat.com>
 <aId0UlyH9ErtGDl2@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aId0UlyH9ErtGDl2@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 15:00, Michal Hocko wrote:
> On Mon 28-07-25 14:27:29, David Hildenbrand wrote:
> [...]
>>> I think the whole libdaxctl handling for onlining memory is based on that.
>>>
>>
>> Sorry, forgot to add a pointer:
>>
>> https://github.com/pmem/ndctl/blob/main/daxctl/lib/libdaxctl.c
> 
> Thanks for the pointer! I will have a look.

In particular daxctl_memory_op(), used to implement stuff like

daxctl online-memory
daxctl offline-memory
daxctl reconfigure-device (--no-online, --no-movable)


I am not sure if they also offline memory automatically before disabling 
a device.

But in essence, they want to to everything automatically as possible.

-- 
Cheers,

David / dhildenb


