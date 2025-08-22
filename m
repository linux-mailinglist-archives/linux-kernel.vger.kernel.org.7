Return-Path: <linux-kernel+bounces-782095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E2AB31AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B6E18864C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDDD303C83;
	Fri, 22 Aug 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbm5CIi9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78A301476
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871844; cv=none; b=cmaF+F2hUE7OEyByDVnOftkSDjaQszG/Fftjok82FDnGDoYyDyQgIdcYunCmCTQaTpXZ6uvQAryQUEwC4FjPzRoQZysbpr4jurhRk/r/Kxcm8Z2zHDWvd5h147wn/gwUec4SgjxPgvFL1Ed1fzfpJaYJOtBo/8Dws1683m8K7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871844; c=relaxed/simple;
	bh=G2WxCv6oiSFA+ItejNsR+Qf2E8pYgoeEr8WbwSgPY3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qH6M+7CrIlUUfoZgtd0uek+TCfgX93M1vC8ZIrgQvrDa6DsoeX5PFCIrzSDi/B18VKd5hMnOcHa320FJrMnC7nyswZkTq7PXhSjLLqOCZjE5W0bRGcFt1yk4e0QjZW+fU9lFGqd0kmpt+Vj2IaIAdVLKX8iqkvVlAGltK6SzqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbm5CIi9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y4Sy5j6GyLKa/6POtPURBhOkK7kt59z0IbjXNHFAuis=;
	b=fbm5CIi9zsoRj81BP2g1ko3VyRw3Ho/hocsBxLTXUkPatNTJhVB1Un7m6hNmBfSPoowO4i
	jv8/O8h3lYobaSRRnZtxIVKEUcauTevHP8iqSCBV37C8/W4MLFqtnW8pdlI6Sd+7jT4Qyg
	H1G3DXbUVGhBW0REaDK0DhnJ6+/K6+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-fbiK0sO9MvW_fSv5InMp6A-1; Fri, 22 Aug 2025 10:10:40 -0400
X-MC-Unique: fbiK0sO9MvW_fSv5InMp6A-1
X-Mimecast-MFC-AGG-ID: fbiK0sO9MvW_fSv5InMp6A_1755871839
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9dc5c2c7dso862471f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871839; x=1756476639;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Sy5j6GyLKa/6POtPURBhOkK7kt59z0IbjXNHFAuis=;
        b=KxJE23h7E/3GUVLzsdZ9dkW4c5AdiN8zN0yJ43p9FhVF+6/IGEL9QEKjapcHREqWv0
         SU3YAxhC7xJ5PtUduO/7EouGYshg97WfFt/ZzcVgRvShIQhpb1A6M6lSZuZ8FP0PX56i
         BYsx5SnJ4SUc9iVvsL6kfaqbPDe6HuwgU4nDcmvIW2VUpUWBzHKXEZBOaza0YHlsw/H4
         cMPqBy18PLwBRAz/hF+ZXU3V32zc+7/PkIZuY51nWAzO/0wjTr56ITEIKo4eCD89wd6M
         ivyEEmx9PkhgeK3dlvKA0BCLkNTBrWkxXq1LN3/UWkg84U6sr3Maoh6r5D0TkY1k5yD6
         JBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP0FdIouXNHhdHMYNFqyPi6kfWZMDJkp9NPrwDCdhBpaKsIaGTw0PCsCCW4mEsEJoCao6b1Mul4CX15iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSC3261VpaePxahUOWcdlzZFBbEtpWLWTE2eitjcShsUHCJGe
	/0A7HERmCxM4XsZBd7b8TSK28bZOLApuVb/zuX25kNq05/0HKQPFrr8titQMLzEde+rEsP2V0QJ
	X/zzk2TVFe40R5UXMQdEWfXfeOeG02QQdHrClZZK7YP+7ScBtVLz0T0XIqQM6stP3YQ==
X-Gm-Gg: ASbGncsGQNF7ciNP0zfEGFxBKgf1tkVA9RF6J/b3OTQLjgRfTVwlQUx4fULPk9CZPEl
	rYAseuOypi+yvGQS1mrjbnXoulxj7iMAkkOndus2I8/wcDW5UIxYW38lodlg9aGsalevYNlWah/
	lqpMJr+bA37lftc34na9ONeWXvagJUI3dsTLmvH/gIWCvt3wIykZZJfJ4tnlFtQ46puSrlGpy/m
	iMgdpiqxN2qdWisBAhxty0tM6yvmMOjcYjXUIXhtFjcsk+21cUNBCKhEZ8XKl7DHtZjtxYIycES
	1vLZkefxRCm79jYPkFCfQKsFzzvritP9SQCv2BG9CRZyPRQ7YkBL7YA/sZakF/TJvEgS4fPoVBx
	BeadaoLQa0P8pw6DOmYku6ed4ekYF4ynJg97lTWDq0VPnYMg3PWABDFB5/cYbR2vZ/YM=
X-Received: by 2002:a05:6000:40dd:b0:3c3:973a:fe40 with SMTP id ffacd0b85a97d-3c5de349863mr2850246f8f.58.1755871838915;
        Fri, 22 Aug 2025 07:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG3zymBLgr0oFAq5QBoFCFU2lzOHhnQpA7QCSr+J+SBt8FHvbVBMdDQMGrrRZe6+dP4YZONw==
X-Received: by 2002:a05:6000:40dd:b0:3c3:973a:fe40 with SMTP id ffacd0b85a97d-3c5de349863mr2850174f8f.58.1755871838314;
        Fri, 22 Aug 2025 07:10:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:6100:d9da:ae87:764c:a77e? (p200300d82f2e6100d9daae87764ca77e.dip0.t-ipconnect.de. [2003:d8:2f2e:6100:d9da:ae87:764c:a77e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c576b7sm15322771f8f.63.2025.08.22.07.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 07:10:37 -0700 (PDT)
Message-ID: <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
Date: Fri, 22 Aug 2025 16:10:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
 <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com>
 <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
 <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
 <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
 <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1), but not sure
>> if we have to add that for now.
> 
> Yeah not so sure about this, this is a 'just have to know' too, and yes you
> might add it to the docs, but people are going to be mightily confused, esp if
> it's a calculated value.
> 
> I don't see any other way around having a separate tunable if we don't just have
> something VERY simple like on/off.

Yeah, not advocating that we add support for other values than 0/511, 
really.

> 
> Also the mentioned issue sounds like something that needs to be fixed elsewhere
> honestly in the algorithm used to figure out mTHP ranges (I may be wrong - and
> happy to stand corrected if this is somehow inherent, but reallly feels that
> way).

I think the creep is unavoidable for certain values.

If you have the first two pages of a PMD area populated, and you allow 
for at least half of the #PTEs to be non/zero, you'd collapse first a
order-2 folio, then and order-3 ... until you reached PMD order.

So for now we really should just support 0 / 511 to say "don't collapse 
if there are holes" vs. "always collapse if there is at least one pte used".

> 
>>
>> Because, as raised in the past, I'm afraid nobody on this earth has a clue how
>> to set this parameter to values different to 0 (don't waste memory with khugepaged)
>> and 511 (page fault behavior).
> 
> Yup
> 
>>
>>
>> If any other value is set, essentially
>> 	pr_warn("Unsupported 'max_ptes_none' value for mTHP collapse");
>>
>> for now and just disable it.
> 
> Hmm but under what circumstances? I would just say unsupported value not mention
> mTHP or people who don't use mTHP might find that confusing.

Well, we can check whether any mTHP size is enabled while the value is 
set to something unexpected. We can then even print the problematic 
sizes if we have to.

We could also just just say that if the value is set to something else 
than 511 (which is the default), it will be treated as being "0" when 
collapsing mthp, instead of doing any scaling.

-- 
Cheers

David / dhildenb


