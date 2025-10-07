Return-Path: <linux-kernel+bounces-844739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A19BC2A27
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895663C6525
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE41FDE39;
	Tue,  7 Oct 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5gbhXI2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCA1B87F0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868591; cv=none; b=kKlxoPMfhqN0tT8B87NE5s+jgEAIiVKqmCzdBp0I/cPvhk2y0EVkAiYtqWofGFRM8wiSKNN1hLhlV3lNljONzigoN9Dt0Np5xPslrRXKr+k4IZY0ByI0Tepnwk7bwlRihX+S1F/fgvszVCqxDi/EoJxz3jgkrDzdtYwhURYtVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868591; c=relaxed/simple;
	bh=/w9Z/jjnsLzzYXPX9/Tlp8ox33eQBYhUEAQ7nC4PNI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HlCYykPNHcwGc6/0S8mC4p0hFWNVuHUDdVDI/lY8pHAZ9QyL5MEiXnJABHHILnjZmH1/GrNTHwI3bMDn4xYv/Z0JUEBtfO+5h/YfXTY/j7N/J787lHg3/PB8Gbzh+EXpq9aCq5841u1cDjjVleghRqG3jBn0ndqr+5Pbp5mT03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5gbhXI2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759868587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=20wu+vOF0Ha2x/6Ix9nDsL9M9GUsTdlC0SzAhqgKi3U=;
	b=O5gbhXI2y1RcTEfEcFC4os3XRL40m/hMG77INdl9Bk49ivu3/06EKQiKluGXed3YlzJ4kJ
	kPcUgo3mWBXGAk5ji/vXaa2vmbkf0BUhkvsWca4bpWGHklz13Lh7z2AOGJDTyXLMal6Oq8
	tI+E3t+Zm3Rehw1arlaIpN42AwHPq20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-LJPA5WTtOwOPySRnY8D7cA-1; Tue, 07 Oct 2025 16:23:06 -0400
X-MC-Unique: LJPA5WTtOwOPySRnY8D7cA-1
X-Mimecast-MFC-AGG-ID: LJPA5WTtOwOPySRnY8D7cA_1759868585
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3e177893so36221725e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868585; x=1760473385;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20wu+vOF0Ha2x/6Ix9nDsL9M9GUsTdlC0SzAhqgKi3U=;
        b=g/sANEt/l+tTZY24JUu68ntS7G1H8KnYMj/6mwzR8O/UpaUbHhwucGDLMrbkkfZPTX
         7uZMnvhnE+1SlZJHFbFeTBXNHc79DKOEIMlJp0dLLumoHYITvhep7YTBSwByn1g7v7rz
         qSA6Pj+zuSpF9p8zHnSDsD/dpnuRmUJ3t9Am0HCbaoSLI0S3nt+a7ItMJeeY2h8DFY8W
         F3AocCIkWpimB4w1lah1lFNXT1iTW3/BX18XQDfohz9MC4hU+/d39xUGPyFscsquAZD6
         XH4h8EjCiB9SCRFNjtn5XExvJZRRNFWmfmJvgNfz4YgrXBcsyU4BhaFOi2/vmPvMN7Wf
         6zPw==
X-Forwarded-Encrypted: i=1; AJvYcCW2O/oKW0myo+ghpyYsQ142ZM27kMT25ByiCm0RaTIDbJ7tzVkigxKd8xQeWKvXeAwCD24Rx+tRmEOoCGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9KSnXN+r715IOJIMaZx342tigM13aJhjVnHxWL71HZDFCeXx
	NC526enCoRs5NWLnjRSpcZcKJmtDpxgRGLHUqZcxSvFP0W1FxQ8lxsXc1r0lxPVwNPg5V8GTdmG
	Vk6aDDkJCYur0tvy1F/Jb74X51olK060ooOpT0d0pD9clDrTvSHLjhZJNC2laKKfNCA==
X-Gm-Gg: ASbGncsKRzJ01uk3SeD82nI4Fm70kN0zG9GhBMA7+NEMjD/PD3VSXVe3fm17/yQjRTg
	OsdnB/MEc3dMjCsH/y0kgSZPnhMX+I5xw5GZKTT/KjDMlNe+xW1ZlTO0svlQ53+pZFc4b+1c5Vu
	PMIV99MTHvFOpxL5cP1prkAIjobUyi1+7Klfjqxkdqe5iIKWCUkLeqfQWjRmIB9HuQ2J7Wy4w9g
	4I6F+/0HIqE6pNtGlanQYyYnJxs/zGfdvkJrLUnqufy+aE80UMPdX724Rg74I02Zqhz0Ewd5Zdb
	OhJEAO0oLzKUaqg0gVi61Xa8Xw117of6owmiIL9G3j3DgGD75V2zK2J+DeAtGcMk/9QvW/2hb3H
	2Jo+E01VD
X-Received: by 2002:a05:600c:608b:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-46fa9b03b22mr5837545e9.32.1759868585449;
        Tue, 07 Oct 2025 13:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7rpKtsIuQGWFbfyF0r34E38kHA4/Elu/xXsROCpMKx9ujbgeBUDaHZlo63QkN9imCqyeaw==
X-Received: by 2002:a05:600c:608b:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-46fa9b03b22mr5837385e9.32.1759868585025;
        Tue, 07 Oct 2025 13:23:05 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c2a380sm7411365e9.19.2025.10.07.13.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 13:23:04 -0700 (PDT)
Message-ID: <7d25bdf0-f225-4bcf-a0cc-d0364bbfc7c7@redhat.com>
Date: Tue, 7 Oct 2025 22:23:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Axel Rasmussen <axelrasmussen@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 James Houghton <jthoughton@google.com>, Nikita Kalyazin
 <kalyazin@amazon.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Hugh Dickins <hughd@google.com>, Suren Baghdasaryan <surenb@google.com>
References: <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
 <aN_XZbQjuYx-OnFr@x1.local>
 <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>
 <aOQuZy_Hpu1yyu29@x1.local>
 <akld3v2mtnjdqvs5dgwr4gnffdqf5dojwhmfylq3mkfzakjj7j@5oqqxsymkcbp>
 <aOUa8C8bhWvo5TbV@x1.local>
 <frnos5jtmlqvzpcrredcoummuzvllweku5dgp5ii5in6epwnw5@anu4dqsz6shy>
 <9089d994-262f-4941-8bed-f3c6ee05a769@redhat.com> <aOVEDii4HPB6outm@x1.local>
 <6csw4pmymno4kdtlbzd74posr3dekamq4zkje2mfkmbg5q7xbx@y3o323tbm7h3>
 <aOVtAMm8PqEbGANh@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOVtAMm8PqEbGANh@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> I believe that's what David mentioned very initially here:
> 
> https://lore.kernel.org/r/f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com
> 
> I'd rather go with the two fields, but if we're trying to introduce another
> feature sets almost only for vm_uffd_ops, I'd prefer keeping it simple, and
> deduce the modes from ioctls.
> 
> Is that ok for you?  So it'll have (1) get_folio(), (2) supported_ioctls.
> That's all.

I cannot speak for Liam, but for me that looks like the best way forward 
for now.

I'd hope that we could get this all cleaned up at some point -- 
including hugetlb, because it's a pain to have the hugetlb special 
casing all over the place even if it's at some point a legacy thing (we 
all know it will stick around for years to come).

-- 
Cheers

David / dhildenb


