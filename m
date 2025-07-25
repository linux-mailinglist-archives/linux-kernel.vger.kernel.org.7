Return-Path: <linux-kernel+bounces-745735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E900DB11DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00A51889743
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79723ABBB;
	Fri, 25 Jul 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQRcFinp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEA2367CD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443090; cv=none; b=AgObBfUywh0sjBwxSKD8xi30Qc9G4ab82NVNdauEBr1cEon7VNGwgstsTDoZIJpN6rSRnv285Fs1cJjpYWSK0MhTcFWydSaRDdgZsX83maHXoG5IOQfFI2HUadlh8Nzzk36p2cD60kbOKgMjQjM3hCXslqhqLshNH3luvNNWWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443090; c=relaxed/simple;
	bh=cs5Yj83FPgF/AKareeJzDmcbgtLH7WAC4mnlRm3GZeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbEmM6LMH/H+RE/Dk7xy8DrX29+jKgOr3wRfFb2jkU+HIuznqBPxg3fT6WTABQeQJxs3F2zTKVxH5x44zrR1dXofa9F9orBe5mZ9NtjoRCBqgyN+z+dyj9A7jR/fX7egIhPNkIWuLluc5+ILtlz0KzB0XHNosdPu1tjkoANHgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQRcFinp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753443087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BmxXs6pJBA2fg3s6c32iEeTNLDDw2KZ9iEJnk+P5By0=;
	b=dQRcFinpVgga5eL5KAp+ex9dZV7vzRwx0cOKDFf0di55D9/1YV9FRKhxtpzh0E2WFAOnRb
	ny/JZvkLJTXAmONj+ckp2eSh19ESOTMk4Tw3XFZV8c9osLO3PG5X7TPIuHGACCYpjG829O
	toxqHh2VyD2X/vsI1ABbc5yeqeg6P/8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-0gQ4_yGuMHaRSKxxeMiMNg-1; Fri, 25 Jul 2025 07:31:25 -0400
X-MC-Unique: 0gQ4_yGuMHaRSKxxeMiMNg-1
X-Mimecast-MFC-AGG-ID: 0gQ4_yGuMHaRSKxxeMiMNg_1753443085
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-456175dba68so11501515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753443084; x=1754047884;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BmxXs6pJBA2fg3s6c32iEeTNLDDw2KZ9iEJnk+P5By0=;
        b=RRCPViICvoksHUpSOeGuT0kaK3cshKiDbOcly8bvfjmjDv4YQ679gVXAqdj5dC65FG
         oEw3Nz4N8SFGyal52xjet7lwOgwAjmTMQAq+FVFqux3+UqI9yTRMG1Yl2is7hIqla1OU
         bahAQE/ubxtEjG1kIBMKCye2SJJJDfNFZuPkgoxNwHWQUdvK7x8E2Yx2GwMDROpw6MAe
         7HF1LHPLSrFi0AfdB650evNixOR304wgOXaec+eLbbxN+u+8adddaA0u+EIKZKkxHHLH
         18tGjJNeLS6cCdvsOFZh+ZhDPDhlxG55h7saV0Y7sYvggw+vM32DjOe4BBGJx/bWu0Pf
         tOAA==
X-Forwarded-Encrypted: i=1; AJvYcCUpEaKl8PPAaQac0Ny7lcOiF+LEb52TvuWaPNe5p+tuhmJIulDsECHCIvmdgfqrzWlez/7IrNsgOTcGjKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+obTk4krLk+yE66mMUk5JfAnQsOQnUjTuu5deax8Yx6Wh55A
	m1x3rv24Y7W1jOxhU2IYpdV9lDbcNldXJKSdUJaBNx/Yfxbk8VAucA2ZCHHUbXRTEBs8yR3qZad
	wqi2q0Eo9zEmhlLqKynLnetlC8Mp4YIQOG67WdaUKtYAPrfMuAxfK/r7L66LVz31tvg==
X-Gm-Gg: ASbGncv0cGmd30uMXGkR4Y0KJpFR9hFcurwaNC5FC5ZwtjL45sw+kp3cNNTNVYpXtw5
	anfXdgT4Y+rmcl9PvB6NZpuGc0KMi8PbQ5wVRjfdMzG0OPG54zHgVmIhvFv/6hLHNxtSoyMbqFT
	L5vg9T+/99ANHiDmcANNVVJ4vtz3IZ5K1br3SfFhwDz87LPOlYKufEhe5cQWaZL0BTb8cjocVMn
	MQAXAGTKWxiJNQPcE5UWTXGAGavVSvoJqJtoBq47v66Wov/HbuXH8rhPXrp/l2RBxdydNhfA6nz
	JAGoaLzst6WgbT0eSiZ5JzvKzIQ/FBuuqD7Q7gzviQsqUBo8vIyufhqsJjBycD4FLfJ7XYthVpm
	eoqmjGKhkgRACL5zgcXfzcDEVroFQ7EhbMCwZ0+h+jr4uODELdOQwiCtus7gtd9KrGII=
X-Received: by 2002:a05:600c:3486:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-458765457c7mr14180385e9.20.1753443084586;
        Fri, 25 Jul 2025 04:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyDRVNwUhQZmInqK+trerIAkKwiA6XE4MdEY23cCvQBgdpasZQjVKWm6WOHJPMGTNDt11OAg==
X-Received: by 2002:a05:600c:3486:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-458765457c7mr14180025e9.20.1753443084112;
        Fri, 25 Jul 2025 04:31:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1? (p200300d82f1af4005a9fb1bf4bb399b1.dip0.t-ipconnect.de. [2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870564ddbsm50462835e9.22.2025.07.25.04.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:31:23 -0700 (PDT)
Message-ID: <d6781e05-bde6-490c-af79-97993ed9018e@redhat.com>
Date: Fri, 25 Jul 2025 13:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <85c4a092-14df-4478-811c-f3789610e4b8@redhat.com>
 <CAG48ez1O+7ciCNDVnh9MPh_1_1TLWd-=H9L6p90J_9AEbav27w@mail.gmail.com>
 <bf29d398-5f7b-449c-b142-cf9873a5b183@redhat.com>
 <CAG48ez1=rd5W5SBAyyqu-=50AsRGg8pdYW5BZ4SFhHqFYOHbyg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAG48ez1=rd5W5SBAyyqu-=50AsRGg8pdYW5BZ4SFhHqFYOHbyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.25 13:24, Jann Horn wrote:
> On Fri, Jul 25, 2025 at 1:12 PM David Hildenbrand <david@redhat.com> wrote:
>> On 25.07.25 13:08, Jann Horn wrote:
>>> On Thu, Jul 24, 2025 at 11:56 PM David Hildenbrand <david@redhat.com> wrote:
>>>> 2) We have a folio here, so ... better
>>>>
>>>> if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
>>>>           ...
>>>> }
>>>
>>> Hrm, okay. It kind of irks me to write it as two checks when really I
>>> want to ask "is it this one specific type", but yeah, will change it.
>>
>> Well, ksm is a subtype of anon.
> 
> I mean... not really? At least ksm folios are not a subtype of normal
> anon folios. 

Well, what I mean is:

A KSM folio is considered an anon folio.

An anon folio is not necessarily a KSM folio.

Of course, there are implementation differences when it comes to 
folio->mapping etc, just the way the rmap works.

-- 
Cheers,

David / dhildenb


