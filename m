Return-Path: <linux-kernel+bounces-822345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB8B83971
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AE7721395
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB92F8BF3;
	Thu, 18 Sep 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYFNaz6f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738D21255A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185458; cv=none; b=Bva0bVZL/U0agpikM7C2YxH3if9igwe7MwjWeyeGjD0CgP073takHdk2CcL56t+OUrrR3dajEdtAiEOxJTQdFBfyLr0NBn3hYljoTyMNqflAteFtq7Ia047AbLahILappXyqj7QCMFMgqxY8LbmywsCpIbcXzgKdjqduUbuY1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185458; c=relaxed/simple;
	bh=bAVGYhiWHNFLHX2Z5c864vrhb/TN1Pk3FEKmNRgVuxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSWpix0beq+I+GiqK10gzb3gb7E3biDyEmbogtjj3CK9ZYndl/hZ9UKwiEvjqZRftAXrv74QHyjsTjD0DF8I0Jd/0qHyy//bZwCZihRBSIHCKwXMzXfXEFnSIeBcJcBLQ8hqxzPvr3nr8VgaG2byp8Al6bOt3XKDUHpYYQpS2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYFNaz6f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758185455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CH/v3gIbyy+WCPfE/8m9cLd0LwiA2CCBDF5k/DDktME=;
	b=fYFNaz6faFhcS96iFFIjRr3BdfxXUcN+NoVQIxIfjufB0UiEZaKqoam8ozZEE7l4YgMRs4
	yhchxJcyYVzFXaTLlz3FvNr7sVdgFzt12a/eClf4iPgHSTMFM676DCh4JzBJlWeycNrl/h
	5xgoJUfGFONGhOkRZzKTyhMQu69revs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-FtqPGgM0NkiNmOtRZLAubg-1; Thu, 18 Sep 2025 04:50:54 -0400
X-MC-Unique: FtqPGgM0NkiNmOtRZLAubg-1
X-Mimecast-MFC-AGG-ID: FtqPGgM0NkiNmOtRZLAubg_1758185453
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso3861165e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185453; x=1758790253;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CH/v3gIbyy+WCPfE/8m9cLd0LwiA2CCBDF5k/DDktME=;
        b=J5vfYy+9r9uXujsvjMcc3Kui8REspX9V9gHL1pSVtLacmTqbUEo8RGZ1wBNpyPF0st
         lZRTR4hEM48ZABuoG0J0UuyG3ybCU6KhCfMZ12f5ZUcszQI97D696jBho+A4jLPuZi6M
         VWNu3RL0e0mRT8z63gBl2dPxV4zpZUikNm8YwBOy0IAlhRsR4nRdmWdSzRfR/q1xhm5A
         EQGi3eZOTdAReEbZe7DUVq2FkpBMY6tw2np6PPM6MkEjZ9s+AJRpeZMRMU4NYmfw/2r+
         XnH37FTNMwnHlzUH/rEHmuKL7aDhn8LPa9gnsIIlnJyPojciVa7R3qBBpAar5s3ktsZq
         ocKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJflYlBU0GKxej5MqxQ2EEOryWtFtw5mMwIgTrnKimJmbniOIOZ8TsKzz8ZHrla9687Ay2Yz6A8FrDJzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJqSw3B2YltCaHdFAYGIbwW8RGD8SPX0iRRY7vaBNEu64oFRP
	NVPOOXbxgmlyV/PTe8+7wkgtGlLAHOimU69QkY50CAy4A3zwU8sR6lR/3VCmnCEY/74ed6ZsQuP
	74X0trkMkjaNuQ3F7OGUvb7hJ194b81VSfAZyV7rAdGnOPCnvYYH4x4+TgEMZeK7sHg==
X-Gm-Gg: ASbGncvEJgeK7odh0ZzzrJ0Ejp6B4iQd5RSq+6zJOFp0gPytWhJu0xQWzNTylZ9SYav
	++os61FxgYeEPCa/0N1mapp4yVxHlusZoymWVitc++b019hc6WscPQjik2F87eiMw01JpdDW86u
	+y5KWAqJHqIocD4Xqf1ICS5ev2DRXu6+Wt2XFC/ucodRRitFYVoNT6YNzjlMjeCJW/MYEM16WfX
	tMz2ZMz0U8AiC5e/dF0QQ/ABgqYHM18wmPXxDiPmhhabGUV25DVholFnNV6QbM6cNg2HJWMVI4S
	qyphUcnd/l/twhPabbfd7lftjty9100N9CtAtEU2svI/ng8AzUwDCNwHb/rLSXBPIeZtPwZnaqC
	4O51dVYU3p1L+bqnwC2tJ7UcQFrFYyivCAaEP6pPl5upSf9ADQ9s6rO3p2ZQIiaKNIXO/
X-Received: by 2002:a05:600c:1c9b:b0:45d:d9ab:b85a with SMTP id 5b1f17b1804b1-46201f8b09fmr43949755e9.7.1758185453038;
        Thu, 18 Sep 2025 01:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9uhP9lU2sbclYjkhVEANMoZCPkO/bf+8HWAZr0cAYfclDLXHCDeLCvCQTcNZzgtXxHqXTaQ==
X-Received: by 2002:a05:600c:1c9b:b0:45d:d9ab:b85a with SMTP id 5b1f17b1804b1-46201f8b09fmr43949445e9.7.1758185452623;
        Thu, 18 Sep 2025 01:50:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm2725928f8f.60.2025.09.18.01.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 01:50:52 -0700 (PDT)
Message-ID: <e30cf8a8-b58b-45fc-9df2-adcd93c1a095@redhat.com>
Date: Thu, 18 Sep 2025 10:50:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmstat: add header line to /proc/buddyinfo output
To: Ye Liu <ye.liu@linux.dev>, Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250918071741.526280-1-ye.liu@linux.dev>
 <aMu01xIkj-3hgW88@tiehlicka> <1a9f44a1-855c-450e-9dc4-415a29b90011@linux.dev>
 <780aa9d6-a85c-4050-820e-c0ca9f5bb658@redhat.com>
 <6d6e2e33-c221-4ab8-a29b-3d14fb1a592c@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <6d6e2e33-c221-4ab8-a29b-3d14fb1a592c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.09.25 10:31, Ye Liu wrote:
> 
> 
> 在 2025/9/18 16:16, David Hildenbrand 写道:
>> On 18.09.25 10:11, Ye Liu wrote:
>>>
>>>
>>> 在 2025/9/18 15:29, Michal Hocko 写道:
>>>> On Thu 18-09-25 15:17:40, Ye Liu wrote:
>>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>>
>>>>> Add a header line to /proc/buddyinfo that shows the order numbers
>>>>> for better readability and clarity.
>>>>>
>>>>> Before:
>>>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>>>>
>>>>> After:
>>>>> Free pages per order       0      1      2      3      4      5      6 ...
>>>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>>>
>>>> Why is this needed? And have you considered tha this might break
>>>> existing parsers of the file?
>>>>
>>>
>>> Thanks for the review.
>>>
>>> The reason for this change is simply to make /proc/buddyinfo self-describing.
>>> Right now you have to know which column is which order; with a header it’s
>>> obvious. This is similar to what /proc/pagetypeinfo already does, e.g.:
>>>
>>>     Page block order: 9
>>>     Pages per block: 512
>>>
>>>     Free pages count per migrate type at order   0 1 2 3 ...
>>>     Node 0, zone DMA, type Unmovable             0 0 0 ...
>>>
>>> Regarding existing parsers: the patch does not change any of the existing
>>> “Node … zone …” lines, it only adds a single header line before them. Most
>>> parsers match “Node” lines and ignore everything else, so the risk should be
>>> low. If you know of any existing parser that this would break, please let
>>> me know so I can address it.
>>
>> What if there is a single one out there that has hardcoded to skip the first line only?
> 
> I understand there may be no way to be fully compatible with all existing
> parsers. However, /proc/buddyinfo is essentially raw data intended for
> human and tool consumption, and parsers are expected to be robust against
> format changes.

Let's take a look at a random one: pcp-buddyinfo.

Reading the source code [1] of the /proc/buddyinfo parser in
refresh_proc_buddyinfo() I have my doubts:


     if ((fp = linux_statsfile("/proc/buddyinfo", buf, sizeof(buf))) == NULL)
         return -oserror();

     while (fgets(buf,sizeof(buf),fp) != NULL) {
         char node_name[128];
         char *zone_name;
         unsigned int values[SPLIT_MAX];

         i = read_node_name(buf, node_name);
         i+=6; /* erase ", zone" */
         read_buddyinfo(buf+i, read_buf, MAX_ORDER+1); /* read zone name and page order */
         zone_name=read_buf[0];
         for (i=0; i < MAX_ORDER; i++)
             values[i] = strtoul(read_buf[i+1], NULL, 10);
         for (i=0; i < proc_buddyinfo->nbuddys; i++) {
             if (strcmp(proc_buddyinfo->buddys[i].node_name, node_name)==0 &&
		strcmp(proc_buddyinfo->buddys[i].zone_name, zone_name)==0)
                 break;
         }

Do you think that one would survive your changes?


https://github.com/performancecopilot/pcp/blob/main/src/pmdas/linux/proc_buddyinfo.c

-- 
Cheers

David / dhildenb


