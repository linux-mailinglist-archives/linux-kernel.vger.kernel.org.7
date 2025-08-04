Return-Path: <linux-kernel+bounces-754863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9EEB19DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCC31670B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC31E9B22;
	Mon,  4 Aug 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar5fPDmI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D138FA6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296253; cv=none; b=Xu0tT3gZVd0mM7tWbM3R9sr2bs64+wHYAYuf9ESC/jFsE7HpgVQqaSXqqElrSo5O7Ru7FtCWOXW6xut0f3AeBDpoJWYnbF2jqOhEBnCKX20W2b/ebBlre/410WNAmiq5wZqCuiLTEhPHWzGcUodo9g5R7ophMQr3yfuHdIWXbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296253; c=relaxed/simple;
	bh=qrtjvzppzEf/WrQhfRlB5qA9+qX8HW2kTAvW7IccNGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6fC06uDXaFhySi0FModpRa2/DLQvUxR4JQUonQhqe1GXdJ2igaQ89ivhVWZT+kLtifdjVmrmHSlFdIVPeuAFHboCD7bXDGd3mJPZFhX+YCw5Vc3DUx6U99wAskdMaY9CokoduuECkml/Yz7E/PptUBfs+kHdz1Ml3faBPbFd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ar5fPDmI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754296250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ebFR2P4VjmEcZ3SdqCemUM65iDCRmP6ds2X10ucNEEA=;
	b=Ar5fPDmIOSq7oshGbUyqVBzx0sl+hzgHszlmZ6wQEp5TrsJVItFdNePGCFTxurVaJ5vMa/
	H3jnd5ox1ld6So5noJs4Yb38cYo6gX8eWpKD+HHxxpA5jaVHk2TtG9bNAXRjJ/F0JsbUys
	RxLo1j86FB6QculZ6FRg3leYhiXGhk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-ChROuLtuMKG9JbtLVuX5cw-1; Mon, 04 Aug 2025 04:30:48 -0400
X-MC-Unique: ChROuLtuMKG9JbtLVuX5cw-1
X-Mimecast-MFC-AGG-ID: ChROuLtuMKG9JbtLVuX5cw_1754296248
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7825a2ca5so2561696f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754296248; x=1754901048;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ebFR2P4VjmEcZ3SdqCemUM65iDCRmP6ds2X10ucNEEA=;
        b=VyvoqL/bFEKnNCJX7NurnVrA56WOgKUxPBB0oa7FiJ5trPEvqeBl4s16lk0Al4i1Qo
         0TV7u0PXwK9l9sucZ39vyaTz7C+3z7iC5Ty+IqUtoUT6JEAaXBvQTbAnoHz49+DodiYJ
         lsdJ0/Bl0dRjoHlpFmoNvQbcTMmC+cS7UCEkmE2Nx+/anygnP/Qdwy8UxA+8GE9e1RWV
         2DaNJBGa3FI4kAZhxZxA5k3UcrSljvY9SrJ5jdf48NtQiAjQTwsC0nootEYaSxoysY/8
         PbozLzXpVNMOOk9+ukvqYpCwA6bDHuEH+TTkCUF4KrUE6AmnGaqb3ezg5fUan5OsgB51
         HoHg==
X-Forwarded-Encrypted: i=1; AJvYcCWLJTA+rQAeQ199IL1EOJu/olYo8flgL2SGdRAQU0UflzICtGU0rGgZ6odGDBywM9r85yxHChfUMNIyer8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFW9bbD/6bKmRlSKfCd6B1P4I2R3DnV9Zb0c06jUVDNvCtqGJ
	42NU6tNHRFnw1f/Z5bBfO2pYDXNLSHTG8NJb82goN9xm6EHcUmeb1mipbk0avI2MxHhOcKrDTbK
	kUU8L9FxeQiTvMJbXjPzZnaZuo/Vx0WkQI6MEKTvDtJ0VebSjCcLPIshEsTVwnErtDw==
X-Gm-Gg: ASbGncvPyFwktereiNmLMbsYoWDoE1CZXLN7VnGBhFRISpP3EPGcSb8pzMYwRcoRdg3
	AO9sroa2ZIuPhuajDWPw7albgKrUP8kcsuVzz6dOo5fP4WQNcgjXhbxTOMcdHnSBRMnjBuZQkGM
	C+/ABTkj7A08+LWxLUNzp/NK5GDft2wo14ba6vSjlwb6Vo8YBtMBJnhPhQPVtgn4/TzLlrQd3XX
	44iufXJhf6CUlKTyy0U7T2WjE1ESNkgnckL8XlrbQVFP/nmi8gGdAtktdgNBdk0J/AyGwxYU1HC
	6ek1bcdqWVKzxzt/fbje0fWp8kvKKG2JkyuEMEAEq4XnVt6InooWgRAKQ8jrjhM0WJ0sGt0o+v9
	kB4dmAs9j7g6VMbliE6B44dqr5iACL650tN6fpf6CROwDWptZ05urXagguqKbVuUcHBk=
X-Received: by 2002:a05:6000:188c:b0:3a5:8977:e0fd with SMTP id ffacd0b85a97d-3b79d1f809bmr10603177f8f.0.1754296247602;
        Mon, 04 Aug 2025 01:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHofHu5ZtOwuJz5HKrWCTgS4jITMgfjzwqhGlCL/LeQzyG7CNRclHWrI0CkyPhQKfbeG1CIQw==
X-Received: by 2002:a05:6000:188c:b0:3a5:8977:e0fd with SMTP id ffacd0b85a97d-3b79d1f809bmr10603151f8f.0.1754296247174;
        Mon, 04 Aug 2025 01:30:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eb7acsm194716745e9.28.2025.08.04.01.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:30:46 -0700 (PDT)
Message-ID: <d9d0890e-2837-49dc-9ca8-1d6c28e95a21@redhat.com>
Date: Mon, 4 Aug 2025 10:30:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: Qi Zheng <zhengqi.arch@bytedance.com>, "Lai, Yi"
 <yi1.lai@linux.intel.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 yi1.lai@intel.com
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
 <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 10:26, Qi Zheng wrote:
> 
> 
> On 8/4/25 3:57 PM, David Hildenbrand wrote:
>> On 04.08.25 02:58, Lai, Yi wrote:
>>> Hi Barry Song,
>>>
>>> Greetings!
>>>
>>> I used Syzkaller and found that there is general protection fault in
>>> __pte_offset_map_lock in linux-next next-20250801.
>>>
>>> After bisection and the first bad commit is:
>>> "
>>> a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
>>> "
>>>
>>> All detailed into can be found at:
>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>> main/250803_193026___pte_offset_map_lock
>>> Syzkaller repro code:
>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>> main/250803_193026___pte_offset_map_lock/repro.c
>>> Syzkaller repro syscall steps:
>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>> main/250803_193026___pte_offset_map_lock/repro.prog
>>> Syzkaller report:
>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>> main/250803_193026___pte_offset_map_lock/repro.report
>>> Kconfig(make olddefconfig):
>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>> main/250803_193026___pte_offset_map_lock/kconfig_origin
>>> Bisect info:
>>> https://github.com/laifryiee/syzkaller_logs/tree/
>>> main/250803_193026___pte_offset_map_lock/bisect_info.log
>>> bzImage:
>>> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/
>>> main/250803_193026___pte_offset_map_lock/bzImage_next-20250801
>>> Issue dmesg:
>>> https://github.com/laifryiee/syzkaller_logs/blob/
>>> main/250803_193026___pte_offset_map_lock/next-20250801_dmesg.log
>>
>> Skimming over the reproducer, we seem to have racing MADV_DONTNEED and
>> MADV_COLLAPSE on the same anon area, but the problem only shows up once
>> we tear down that MM.
>>
>> If I would have to guess, I'd assume it's related to PT_RECLAIM
>> reclaiming empty page tables during MADV_DONTNEED -- but the kconfig
>> does not indicate that CONFIG_PT_RECLAIM was set.
> 
> On the x86_64, if PT_RECLAIM is not manually disabled, PT_RECLAIM should
> be enabled

That's what I thought: but I was not able to spot it in the provided 
config [1].

Or is that config *before* "make olfconfig"? confusing. I would want to 
see the actually used config.



[1] 
https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/kconfig_origin

-- 
Cheers,

David / dhildenb


