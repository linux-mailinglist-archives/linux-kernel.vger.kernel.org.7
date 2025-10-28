Return-Path: <linux-kernel+bounces-874426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E302C16529
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F25B5027FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2033CEA7;
	Tue, 28 Oct 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPoXohSs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308134D918
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673798; cv=none; b=JtkauHvW24g5w5AOs2xjV0OLmFEVrVkQoeWXkyJkbLexsSjpsfF/xz9+TqQLkNt61Dt4vyu5VgeatyIgt+/XOsPPkYpJUe3zuS/pLgPDRJHFja9TrFDmJ4qW30cGOKW6YbrlxyMunz9x6AZaQ88zTUyeqhwz2YbcojDj7MMDMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673798; c=relaxed/simple;
	bh=HNDUMYeo/L/RCwN82toFe06UY4HVw5LK/Mt12pX+Xkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjRXlY345MH9lP8p5OZxw6ZBodJho+OwJcfHkS4d1ze6fCQWcpvH64H0KLdQ+YDLnwS0nj0I/Kf7qcXsRyVMXy70O9eFWl7mhI9rLM7Keqy/eGVbR6te+80Q8q6G92TQRt4AeMambNuNJytNeRxFKRx/qVr9Hdb7oSrOcUsrf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPoXohSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761673796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0wjUs/xTYbM7Fdac3xo6xGaBum9uo0673qS9j9wmfiU=;
	b=aPoXohSs8TOySKf8Dw3cYUekTK/b2G5Oklyy6pHyzklCqSL/q4IwHZD7pN42Nf36Qg6GwU
	zK6TkoZ4bZS3+fQkuGSTxJG8CIHMMHZuqBUTxzCWRCibSt6tpYFTS801Yh06BX7Cm5jAYO
	JUAA9hddVK+vutLcgnY0RBvaGr6fxKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-yHwI1lOYNtSNBC6Xp0tSPQ-1; Tue, 28 Oct 2025 13:49:54 -0400
X-MC-Unique: yHwI1lOYNtSNBC6Xp0tSPQ-1
X-Mimecast-MFC-AGG-ID: yHwI1lOYNtSNBC6Xp0tSPQ_1761673794
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106a388cfso37083975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673793; x=1762278593;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wjUs/xTYbM7Fdac3xo6xGaBum9uo0673qS9j9wmfiU=;
        b=XB3UX1Jib7oC7n1+snOL5lfpJ2fg8ATzizEbR5vqelCVr0fW68CUF5taH6OKBhvuiL
         Qb43H8iboVTmQfbeKhkEME5Rx0GU0qx2Xx9aWbqJunA0ZFMN30L8xK8BrZjv5BsmMXZN
         wHGYDCyfwQqjaMltjCX6AIAUjC9AX6M3JbswD8FUgnXBgCOtpfQHysX6yjpW6JhRkgRr
         dv+x1qmzZ0VAsu7BB8R+8rDwQJ7NXkgs32XJmPFYl5/MZL7rPkcVbtjCqGEle4BC1+dG
         8SnQ7ZDetxbS3+4ZvXJZQE0vY7PdY6lUq21COkvef5oS9ujMRxEwfjff2NLuPDTDhA7o
         SC1g==
X-Gm-Message-State: AOJu0YyVtaiFmeeKhFKC71eI4smAGJIrDxM39387Sq8uzms/DtrdDgfJ
	otpBsLD/t0/GR4bIqmG0DL17nFqj4/80JUIrBB4T/a2+H+m2q87Cx23TCC/tzYonZXb99Qi/B2/
	MsqZei40dyrCCr2oVJQHGJA9jgbuyRggpkNAMTG9pMKCdSJeQ9R8yMBWiv/gL7VOBIg==
X-Gm-Gg: ASbGncsOxfVsi8A7jD9/IbQ7BFIp4tH4frZPleTQSlJIxlGmxdCcO16MZzU0xmC3hA6
	JqjGVqwOcvoHOkQ5NzRmQNLIqM2IQMKSmnS2lLqDzYq5xZPyjt3d0TcHli3wgTHx2VTIxmawXpb
	fY/6tCEpFLuUD9GPq5Tv3ZEqGiy/pcCJ0z7y6znK4KsoI/oLaXfp4WanerTWBrWRXuYHciS2tWI
	hgK/Bprjb01UzCZhsq1iNhn4XNSJDMplu51jafBaPXo3DxtwMDaNx8+Q315D9ALibu0jJ6Af07s
	iuvBKIOwmPnrGu2eM9tBUobuYC/1Zb9tt9Bi+BDnaN7ADyz4mN1SYQNSx1wNmeuCUO9VZqkMZKR
	JSh8/7QqlYgEt7YiFHkmQenf3k2ZPy+5/tfzqvuI=
X-Received: by 2002:a05:600c:3f0d:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-4771e283ed6mr2495625e9.0.1761673793419;
        Tue, 28 Oct 2025 10:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcx7klDKQsDly0rERnv58qXRJAfJupSMrXo3pXhmlMb1uRNgLUDuTQsDYYW7kLhyUZ6FSXvA==
X-Received: by 2002:a05:600c:3f0d:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-4771e283ed6mr2494955e9.0.1761673792961;
        Tue, 28 Oct 2025 10:49:52 -0700 (PDT)
Received: from [192.168.200.155] (host-80-81-2-50.customer.m-online.net. [80.81.2.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e387baesm2888955e9.2.2025.10.28.10.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 10:49:51 -0700 (PDT)
Message-ID: <f36ba14b-f2e7-4efb-92c0-a4d4f58b1bfd@redhat.com>
Date: Tue, 28 Oct 2025 18:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <2983c165-8c13-4bb9-b2f8-bfe8508cce43@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2983c165-8c13-4bb9-b2f8-bfe8508cce43@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Hey Lorenzo,
>>
>>> I mean not to beat a dead horse re: v11 commentary, but I thought we were going
>>> to implement David's idea re: the new 'eagerness' tunable, and again we're now just
>>> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
>>
>> I spoke to David and he said to continue forward with this series; the
>> "eagerness" tunable will take some time, and may require further
>> considerations/discussion.
> 
> It would be good to communicate this in the patch, I wasn't aware he had said go
> ahead with it. Maybe I missed the mail.

Just to clarify: yes, I think we should find a way to move forward with 
this series without an eagerness toggle.

That doesn't imply that we'll be using the capping as proposed here (I 
hate it, it's just tricky to work around it for now).

And ideally, we can do that without any temporary tunables, because I'm 
sure it is a problem we can solve internally long-term.

-- 
Cheers

David / dhildenb


