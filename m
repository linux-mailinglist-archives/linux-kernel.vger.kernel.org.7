Return-Path: <linux-kernel+bounces-794256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0854B3DF0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F333189EBA2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD02F549D;
	Mon,  1 Sep 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbmOWchu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3E78F5D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720383; cv=none; b=A4iWOlKcNLM+NXxXzpvHQCK8CMts9wCmSbs+gm+oF8uEmQbV1EE6IVDk6C6QekpoExmfeEBZ9zy7p02qKwX7Qr0wsBWl1yHim7ZfzeDb4bF1ylPtt9gMXZY/ICEq9JbWi63koM7zlnG2ifm9qdoQgNU/fayA+4ADciMuYrUSIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720383; c=relaxed/simple;
	bh=JJDES6ilxhXTdcmy7euOv3/pDzH+OtxVfqgscv8eniM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdwtqdJu+mHzJPa1acTyiSzcwLyMG+/5yAj//IXBLFmZoLS42QNej9hRsxScW7ToQxwDJIGbw3gzBF1VBarev7UG/aLV2mRB++OA2JdhzOtOcW3UoVsQJRlUKQXk68KjQEYjTwLVMTyr7cXGE5XELcOEJYgN/6WlQQ63L0Ukk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbmOWchu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5LvLVeYuHdeJH8AgS79Exqr4t4r6MVkWdGrUcZdBGdg=;
	b=AbmOWchuXymSMpRMqMUvFzatTveXD6fbDZquI46cGthp9i6rPjGhBIuAu+tzj8qnh9a81T
	nuISfjoPOrTTP0H+v9jMy9ttAddRUndj3zTH++92erWSITUylh0BFFYLC4BMNzKXQa6Hu4
	jvQfGH89gYjSh/kK2kYvjYXbTBDXAcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-59A3nRKDPRms5J9GJ6DAQA-1; Mon, 01 Sep 2025 05:53:00 -0400
X-MC-Unique: 59A3nRKDPRms5J9GJ6DAQA-1
X-Mimecast-MFC-AGG-ID: 59A3nRKDPRms5J9GJ6DAQA_1756720379
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b87bc6869so10492325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720379; x=1757325179;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LvLVeYuHdeJH8AgS79Exqr4t4r6MVkWdGrUcZdBGdg=;
        b=CqSY6eObplz3gFcjd6F2C3BGXHSa5ZR7DwErnC94oCDXz09eXFROO5UytHm/lEtvVi
         TMl+QT6rcpd/g10mnSz/NBTAth8BRj9lsnlRbHJdxwpQ5FTTmDxF0PcBYA51dZU5Qsjg
         vha+6YsL+OoKiAhsqhSFYWeCJXEXLp2o178PAvMOdF10Qmqcux0TGdBwxyHeW6fc7Z+z
         gSqfmCSJwjR4SV2ohHgo7EcCniySIPAu5ExZ36T4LHHhwQbojS5w3OpmkWIX9qatBIKr
         GQyGJ7QVQfWCB6m9IjDmj0+OlAd7f0/GcTvOlfSD5N++dCwMnIgSoQCmZfhDDSHCr8xR
         /EGw==
X-Forwarded-Encrypted: i=1; AJvYcCUXwjlA6qlqivFYhvurFwNZ5VSi1rns5qDrlPwktVIGtKuyhgqWnrsy+JYriOETAc9IcpptMD2zB97M2JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5bumfKVcsncbbleApXIb/TpRublZVHdrh5LTu60Ieg9SvoNK
	phscLFBsIFD34WVIhtFX59Dr1SOOSdUBYjUsBbrdOkWYHjSnFPA6Tj44Nco2IrHa/hT3Tdqmjef
	VTa/ieSukpPIE7pHJ7mC8ITWB1EJNTpl0iqV4ak5at5k0BiFlO3sC1xmB8l9jQ+MpFA==
X-Gm-Gg: ASbGnctjug1DhaOsOKsLmiOSwZQp+m3CH8YNvLg3pS7GRXmfrOnmvZzYqMiZPuovrCa
	qMvM4oDfyXSoxEYOJUsa84SyQpnbjRhOGsj4h0qToKWQJrZXb9fds/5IcgZF+PBm22lbexQVI0j
	lX2AZRL5LlvVwPsPvCmYdKlfTygGuxcGb0docM4GKpimXGdHFDy71y5FpCqENkr3DoXqh38ruNO
	2i0jmKfZsjvzRTT6tVGzTJLzMZBajCTrbh0gh19lSn/DLmxOMyDTLu2hKNKgwMRZy91DyIjXEbG
	XaTLfZ6etaIbtdEQCJxRUt8QTkzYwN60vSedMcJHN4piWqcjyAaS/c1Euwg3pkb32zAmQqLsbaB
	NV5rve4Vo8FyArheJaE0U/H5jwwpVJGCNHKGL1/qZAoVLWiDBYrZSFwUu4S1+lJtCgwc=
X-Received: by 2002:a05:600c:4f87:b0:45b:8482:5ad4 with SMTP id 5b1f17b1804b1-45b855341femr56195535e9.13.1756720378786;
        Mon, 01 Sep 2025 02:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE11yXnXacBpUOwwJsY63Hrb03jEZbAs5yp+OA+dCPrZ6f84MMl4rXK6UnnGbKusCjKp/Wm9g==
X-Received: by 2002:a05:600c:4f87:b0:45b:8482:5ad4 with SMTP id 5b1f17b1804b1-45b855341femr56195345e9.13.1756720378403;
        Mon, 01 Sep 2025 02:52:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e887fdcsm150682805e9.13.2025.09.01.02.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:52:57 -0700 (PDT)
Message-ID: <25f468d2-8474-4d27-9013-d4cac7675897@redhat.com>
Date: Mon, 1 Sep 2025 11:52:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
 <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
 <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com>
 <CAKPOu+_KbBRdtB-WiZuiva7Fqsus4x7zBOPkqdhwfYFkdS-doA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+_KbBRdtB-WiZuiva7Fqsus4x7zBOPkqdhwfYFkdS-doA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 11:48, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 11:41 AM David Hildenbrand <david@redhat.com> wrote:
>> There is an important distinction between garbage and a reasonable patch
>> description.
> 
> It's still not clear to me where you draw the line (it's opinion, no
> objective truth; to me, every redundant piece of text is effectively
> garbage because it steals my time) - but you asked me to get busy
> instead of arguing with you.

I'm sorry, I have no time to argue about the basics of writing a patch 
description. I even proposed a simple example of what we (multiple 
reviewers) would expect as a bare minimum.

If that's not good enough, I don't know what would be.

-- 
Cheers

David / dhildenb


