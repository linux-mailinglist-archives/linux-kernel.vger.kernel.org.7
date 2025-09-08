Return-Path: <linux-kernel+bounces-805844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6890B48E37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33821161869
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853E3054DC;
	Mon,  8 Sep 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmh36mre"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FC227EA8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336040; cv=none; b=P1utLrIfkZ08OmEH2RGwN/9Md5kF9YHPWfkC4HPK8AESJ4066SkQEHHmxS3WJf4/1SGX/kBnINAEU0ap9t1uEm7BtqFsD+ee2bZcKXdb/WCi6mtMQnx21Nn3sYEdL73xb+xbvNYWZ2aeYPQxzEGou1Uqf5LfaxioI6TCdhEqsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336040; c=relaxed/simple;
	bh=233OW1LFydMeXOb8xSOoWvm9e3erkbWg/G1Yy+tesvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmxgyJ4uHkQ0MhlMZEW5YXeo7mLMGmHwBenD8V25nJnR3pl7kSHnFy45o2SpEPoJMh7SBySfBHqzkRP71SsZPjPEx/nqo+Qr/05LjkS0JjYWHzHBHU0ymvL51MLO0LgSayvu9NGdDUGg8zTrNP8kZR4CFHRgtNmeg1Dcd8WGQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmh36mre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757336038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BLOEr+YqIuXqBDrjXURDf2AfCeVrrz6FeaRsnrIi6vs=;
	b=gmh36mret/cHDxiJHV7EdmWSKPLRbkbgcgdvySpoGRuQHE6EGRmDEMoogdc1/1Gr7729Ij
	uDMXO03aHOnZoUBoU8TTHn/FA4ghynBuovOxfT4c58DbkQTz9Ul1j45xFxnpoGvQkrt5T/
	KKegpxPVb9MHTkLpQd07YDAwfVaK6ao=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-SjR0CYsyOVKIWvDC38VntA-1; Mon, 08 Sep 2025 08:53:54 -0400
X-MC-Unique: SjR0CYsyOVKIWvDC38VntA-1
X-Mimecast-MFC-AGG-ID: SjR0CYsyOVKIWvDC38VntA_1757336033
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e4a8e6df10so1202225f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336033; x=1757940833;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLOEr+YqIuXqBDrjXURDf2AfCeVrrz6FeaRsnrIi6vs=;
        b=sVjZsxywo3YLQGrCWXXdkKSK+RDOaS8u4eJFbFMutnrwLp3g1SFAFwOU+AxT7RSTog
         3s51GtpajU5NYGvzn398TQMgnQ8682FBsWQcg1e2DIuNAc3oVDPnmhmi2UL0n47A/M0v
         Qb1chBoutgIdnnkUijqb+74G8E+qEDKf9yY4/11TjFxri7Oj2eHBHNVV4G8h2baax5VR
         NrhDh9lS6bgw4zXIINyrFc76H8wiomNUxuy0NpMVDBm8eAfC3T5YqkRWkkcrToAL9KVD
         Gb7Z5zPgA7RvAfk1/P3eRnIzD00mxv/YhjEz2ZWhPJBJwYmCPb3cGqyfN8yJKkImy0B4
         kFhA==
X-Forwarded-Encrypted: i=1; AJvYcCVeIFmwlDYEF52a4qD7lk0AuC7wzokwVpkq2fftJ2X0ur6nxO5ut3EPdGQnHQIbongk9VP2arvMfYu6Law=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnT420KTpbByUVZ9AosFNCcuoNJnGY4bF4GxgCzgUsqvbNW0io
	xUKWroCSlwPEfDamCNGtyn3+hIuSH5BmmGC68IpBLEhtyEp3lusqaUqmKMrNQ/3cXWTBb/XWGdv
	bEwo958CAlr/Yk+PgyKWZI4On5mjhZbl4BEmeyDeukCkDl3UdgRYHaBe66KFE+KN+OQ==
X-Gm-Gg: ASbGncus/r9OTLWwn9PqQioMvGKGcJF7qeSL+di52SqquEdn6ZaBPddH+ZolRJjpAGq
	EbtiiaHFu7mB0aBbglbdDbU/N8Ozba/BBP02KnX3L3/+hMCypjmC1NFhK4T1I1620Ofa10kEC24
	HCKFM4hPjzqtRxj60/pyHU2qoMYYyygErEHFUr6Lmc2t/OsRiu2Tn+O3kCcrrVU6afH5I6nhuKA
	J8+cax8iGgSw3H2oJM70TA2k0EHnyTOh8WbUJTQyvSFQuAsuRiHqYXMAd5T97a4Al8Rb6az023T
	1XpwIEThu2wF8Z9QMnmahVLVDo0QGEWIHpuaj1ltl4zjnaZO85M+idd3LXDXIe1XfzHgcrgZzJA
	l5nWt0/uTD7CKVkvBFOIH1fb7sedtZviZFb0+s8RuS+O52awhSlI5jUyLKP7d/CW8
X-Received: by 2002:a05:6000:230c:b0:3e3:3d84:9761 with SMTP id ffacd0b85a97d-3e62c284c68mr5425697f8f.0.1757336033177;
        Mon, 08 Sep 2025 05:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEhOhEXB3/NANpF0KM4SgHP7UU1Ksfhc0jmNzHaEtL3ivj5fCYOv+qhWrbqhmq7XSyBIxbIQ==
X-Received: by 2002:a05:6000:230c:b0:3e3:3d84:9761 with SMTP id ffacd0b85a97d-3e62c284c68mr5425670f8f.0.1757336032735;
        Mon, 08 Sep 2025 05:53:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm41285539f8f.61.2025.09.08.05.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:53:52 -0700 (PDT)
Message-ID: <ad4abcd0-30d1-4683-97ab-abb1d151700f@redhat.com>
Date: Mon, 8 Sep 2025 14:53:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/mm: fix hugepages cleanup too early
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20250908124740.2946005-1-chuhu@redhat.com>
 <20250908124740.2946005-2-chuhu@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908124740.2946005-2-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 14:47, Chunyu Hu wrote:
> The nr_hugepgs variable is used to keep the original nr_hugepages at the
> hugepage setup step at test beginning. After userfaultfd test, a cleaup is
> executed, both /sys/kernel/mm/hugepages/hugepages-*/nr_hugepages and
> /proc/sys//vm/nr_hugepages are reset to 'original' value before userfaultfd
> test starts.
> 
> Issue here is the value used to restore /proc/sys/vm/nr_hugepages is
> nr_hugepgs which is the initial value before the vm_runtests.sh runs, not
> the value before userfaultfd test starts. 'va_high_addr_swith.sh' tests
> runs after that will possibly see no hugepages available for test, and got
> EINVAL when mmap(HUGETLB), making the result invalid.
> 
> And before pkey tests, nr_hugepgs is changed to be used as a temp variable
> to save nr_hugepages before pkey test, and restore it after pkey tests
> finish. The original nr_hugepages value is not tracked anymore, so no way
> to restore it after all tests finish.
> 
> Add a new variable orig_nr_hugepgs to save the original nr_hugepages, and
> and restore it to nr_hugepages after all tests finish. And change to use
> the nr_hugepgs variable to save the /proc/sys/vm/nr_hugeages after hugepage
> setup, it's also the value before userfaultfd test starts, and the correct
> value to be restored after userfaultfd finishes. The va_high_addr_switch.sh
> broken will be resolved.
> 
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


