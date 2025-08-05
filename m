Return-Path: <linux-kernel+bounces-756429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675EB1B3DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C7916B948
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEF2727E7;
	Tue,  5 Aug 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqBaBc+q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159C2264DB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398538; cv=none; b=r2/ATGfMM1pXrFFq/yKT2TBTq4QySC9f7LecfNZubKwSsuQ2yJBo7Q5VX2gjthFZpR5cHHQVlD0gTh2yaqWRCGMGn1XnNgXD1tMI6J/0NIVPb9z0Qfpu1NPlQWcklo7qrOE+x4Yb+4VzjUQcUWMsN6kgHX9lLuFje8fM5xx81Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398538; c=relaxed/simple;
	bh=HOB22G3loRJWaKMt8mwgyEJ+zx+KC090srXh72+31xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AB0zRp23JrHnn7YH8s5YwiV/cRloT+jbiYpiVjFjkVw7IO9JWLEpO6rKHd4VYbxSKzdcp0cvwexEAv2hHsbL+oLhkxcDOF5EEkW9B4iOJokjBiPuhXXi5MzmfJolxVmfJ6ucayI/6RsPASH0wUjHGldPFcspvPlnDxNLhEy5Fdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqBaBc+q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754398534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mXQVWi/b7AMP+vy5HeVixIeMAJNnKqw2TByOJlo+1Us=;
	b=HqBaBc+q+OtPQ6gXdtTqFGJ8+0N+G0MMVLJA/DSYspWhEeJfxWnQea1ouySUq7Ui5N8AaO
	wcxuxYMWHohaTkbL15HJZtWpuXLpWkAmZ6/ERB7KqtoMo74+END649Uh36HQ498wsw1yTo
	FYXQChTGDAsCZz+BjlrnKPnUIJungUM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-hyiUAY3qNO-QvufqOHK9kQ-1; Tue, 05 Aug 2025 08:55:31 -0400
X-MC-Unique: hyiUAY3qNO-QvufqOHK9kQ-1
X-Mimecast-MFC-AGG-ID: hyiUAY3qNO-QvufqOHK9kQ_1754398531
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4595cfed9f4so9294175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398530; x=1755003330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXQVWi/b7AMP+vy5HeVixIeMAJNnKqw2TByOJlo+1Us=;
        b=uQJP0ZrB1x+mvnagyG8tAB55rdjmNw4pDNWjRefz1AcyPKvfWui0S8FSKsWDBx+qCD
         uzBY5IohNjCluOP9kI77CymFk6Ss+HNsGXLYBdt7Me+tO5sT1WfzUaAPm3hV/O/rypS5
         uBkJTjKs61pcTWAIoHF1XeGMbtQQIN/NZRp+WZg2zsCE6bbul8vXQe3TyBJosKX4YYij
         f4BjWmcKTO7vk2H8w4A8J0/GWum9n2BhvzLq7S/I/nFtHthcet+XsfYzh8/hEBRkCt59
         RYl3mKJQixxf0jTuPUUe+90SYf98NJs/UspDrVXefeRWRQ5kSeaWID0EuN5We5ADMW1D
         tsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuIzxow0S5rwvwCLLZj5mBN4vVe6gjnG725bGnfuKrdEH+IXWbFMQsNdt+7GKpdlMVyhRtGQLFqr3cNyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3cvOG22RBjF6h2Lhkkv6P7txlHu93CLrcjtydwsDm40xS+tz
	5J9PQOkr0N2lgrpxprr0JM13OCG5G87m2Qjq+j3eNx0H/WvBjSg7UStBl6kobpAJwBwzJixTFLq
	+n0oghHCO2e+76/6FaAjvOsqvAKYKw4Ygc/yNZNNb3SXv86NKN1F8bIpIiTAeSpnCRQ==
X-Gm-Gg: ASbGnctOMbZM6ZcicLJPVKR7zLWSwKU+sXnerouCpo0U0OTq3G4Wj/zAsZj6qLVbtYd
	xsnQ4hoX3t0zPkfXr7meILz/Wi6/BWesDDUVHWVJUQvBmdMsSDpx4gjGWXjOUn0NCyfmHDmXHZ+
	ypwnKTzLmKlQFy59p3hp0S3bYdVo0TCEjLlFbobBbZwrwDxUSyL2toyiR799RREvKoUCRINWKwn
	czXVtIpMy7dad58hVxWb/WFGIIm2Rks1CNOskqJllA5sdi2hpAMgt8+P0SDrh7RfOwdKI5aBNTl
	l5Sf5Nr4G4hKtNFBwOmTK5R9FlUiYWhidsAYfFJ4lI238MiY2Ziv87FaGtJsfcGnU1NsgNA=
X-Received: by 2002:a05:6000:2287:b0:3b8:d2d1:5c11 with SMTP id ffacd0b85a97d-3b8d94d3549mr10242844f8f.51.1754398530421;
        Tue, 05 Aug 2025 05:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoW0VEHeHdM6KbOLWiBmAjo9TG0Lqe1CZviyoNOwGriAOTp++1O5KXtJScToSn/9LRd7ABaA==
X-Received: by 2002:a05:6000:2287:b0:3b8:d2d1:5c11 with SMTP id ffacd0b85a97d-3b8d94d3549mr10242807f8f.51.1754398529950;
        Tue, 05 Aug 2025 05:55:29 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a26f.dip0.t-ipconnect.de. [87.161.162.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm19065920f8f.47.2025.08.05.05.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:55:29 -0700 (PDT)
Message-ID: <e608f766-8750-4781-bd23-8fa95b6d683a@redhat.com>
Date: Tue, 5 Aug 2025 14:55:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <66c2b413-fa60-476a-b88f-542bbda9c89c@redhat.com>
 <a22beba8-17ae-4c40-88f0-d4027d17fdbc@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <a22beba8-17ae-4c40-88f0-d4027d17fdbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.25 14:46, Usama Arif wrote:
> 
> 
> On 05/08/2025 13:39, David Hildenbrand wrote:
>>> +FIXTURE_SETUP(prctl_thp_disable_completely)
>>> +{
>>> +    if (!thp_available())
>>> +        SKIP(return, "Transparent Hugepages not available\n");
>>> +
>>> +    self->pmdsize = read_pmd_pagesize();
>>> +    if (!self->pmdsize)
>>> +        SKIP(return, "Unable to read PMD size\n");
>>> +
>>> +    thp_save_settings();
>>> +    thp_read_settings(&self->settings);
>>> +    self->settings.thp_enabled = variant->thp_policy;
>>> +    self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
>>
>> Oh, one more thing: should we set all other sizes also to THP_INHERIT or (for simplicity) THP_NEVER?
>>
> 
> hmm do we need to? I am hoping that we should always get the PMD size THP no matter what the policy
> for others is in the scenario we have?

Assuming 64K is set to "always", couldn't it mislead us in the 
"madvise"/"never" test cases in some scenarios?

-- 
Cheers,

David / dhildenb


