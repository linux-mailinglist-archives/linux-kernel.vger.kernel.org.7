Return-Path: <linux-kernel+bounces-822304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC9B837D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DB418965B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37CB275108;
	Thu, 18 Sep 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUp4Uyb+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C136B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183383; cv=none; b=JEaZ+ug3cppGSxS6SO3dBO5AtZ93KaDhDu4ErMPUIZfWsF9SZ40i9dwHWOJ7+Xku/2Ol/SKIoK0OQ+t8lI8Jf9B4yO/twVi9hCCQEf9UtC5idwdxJD4Y1oAFvMxWdBFHcLXS+/xCzBbmvHP9S2kfdg1LnA4FLg61uPWd7XSkJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183383; c=relaxed/simple;
	bh=GTP2gzJFZMmHC0SlV/I7M/svxdRDJGdBCcN2vpAlKZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egoDReVUvW1iSm+xcVt+0lliNQYzGSPTsQJabyWAQ/uyuXNHxz3Kl6/z3CjUaNxm+H/N5G19j8b8Pat9AhlwVfII74VPqa0hRb8CZ+j+m8pRbCnGGMaflj8s+pDB68U/9arfktJ1ZRjWhgp1VFPotutTFJYd4dLe35zqr70qjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUp4Uyb+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758183381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G/5PObydQBTPKRhudbGOIVgXgkozXKhQR5xYk0UPbFw=;
	b=BUp4Uyb+ocTfjU7fRmOz7+6KhvuY4XW6FdlS1tGMLzsjk4BW3DaHVndKlhuu1W/O5L5NGR
	yVnYo49O2brZmgixPXcW2EYgd7lUGDve8tOzW8iqMMk/1BJiMRSm3H63F8iJC5PQL0q18F
	xspVBSZvMSPLzjvx7ZTuzyFSyKbHE0w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-OfM_g1zwPfesEaeDMM0NSA-1; Thu, 18 Sep 2025 04:16:19 -0400
X-MC-Unique: OfM_g1zwPfesEaeDMM0NSA-1
X-Mimecast-MFC-AGG-ID: OfM_g1zwPfesEaeDMM0NSA_1758183379
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee130237e1so123647f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183379; x=1758788179;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/5PObydQBTPKRhudbGOIVgXgkozXKhQR5xYk0UPbFw=;
        b=aaL/oXPZngVQHw/nLhk2gfdQMQO+ZtX2mbrhFGT43gTV8wLH1nmsF5j9kTdQKV17s+
         Wa16bgo3AGvT0mSdQmgkxeg11MAmiUHlomTV0UXNqBJAf3X/5RZSS/oh9IV4ymk/ouB9
         UvYMuOFplIk1gAWYyCiMkdGPoaqocEDePgKr+NN0mnefUdbMi7Wjo+8zzlidFlRC8dJH
         TW0TaZ6FcrwWFmkkZ+djbmANt6xQlRQY88x7+pd+eZcqNuu/LrTVQM11ekYHaE6m/Q+2
         iZHKCVpdDcwe5LPW3HVXjWOEcpEd868RfGbY1/vZ80ZiPJRCWj7AhrNxZssuRCMHFynt
         iT6A==
X-Forwarded-Encrypted: i=1; AJvYcCXfhiyDi1Cu7uqkDz0rz2FID7DA6M5RnWYLttxEz7EezEY4Cxdyzi7SiiGtHpmM83fpw0TgR5UkYPxXTzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnLsZSLM9LNzZZJbmglB8V0CYAN6NPz5FBnm8EqTKPzK/TtGQ
	OeslXPx1xvxcB7nRpoAUxZ3sWvQVGp+XgOLkTQVUkynCTM52R7+t7bG4Eeu2O43bpAMw7DC5y75
	j1vx9Q01eN7Vim3UTScE9nqu7bjQlGPIiH/geCGGeWZPkBnIo65qRmLT8AWNJRyGVyw==
X-Gm-Gg: ASbGncumUqcxBUELvKcVYBSfvPGAojUURY/VivZQNCjwsOleQJ2KxguBGMES1Kp8uek
	SJsNAUiF2Jlu03Sy61Mrx/8njFfyKgNjp5qMQ96y8deofo7QirIjatAXqcfI0cHuiO4j6cISv8M
	FTt5Ws/0+LWzXe/icPF/Mz/tgNsRDDeY/uHM0W5a2aBjq/UIqv8/8ab5AgLLIAWasJieHHC8v4p
	ztDnFNyKVtg8KNiElPBPpEst9ofx8AUDpTbJYji5mZnnOwzybvRy8cTRODFA293Jyoic8Sd5KgS
	V+NLBC6XxosjKFu4QPHi/nwaoOmRhNmxXsAaOdlMBvJgH97YqfkB1QJOKCovVOgiU3AF/KDVJur
	uBcaF7OjNKG0DoR2qw2foc0CV1vf8anCoeWyOg/Dme19tmG3rWWosTL6Cv38W9L3fjVt4
X-Received: by 2002:a05:6000:2012:b0:3eb:2313:ec03 with SMTP id ffacd0b85a97d-3ecdf9d1628mr4864900f8f.27.1758183378615;
        Thu, 18 Sep 2025 01:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtt7vZBRj0+uFcgr+tMEMlGdyMOg7OfiXBQjB5T17V9Ui8y9E//Vz8+/m+TtE2Xmiz5a1NNA==
X-Received: by 2002:a05:6000:2012:b0:3eb:2313:ec03 with SMTP id ffacd0b85a97d-3ecdf9d1628mr4864857f8f.27.1758183378121;
        Thu, 18 Sep 2025 01:16:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee074106f4sm2570434f8f.25.2025.09.18.01.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 01:16:17 -0700 (PDT)
Message-ID: <780aa9d6-a85c-4050-820e-c0ca9f5bb658@redhat.com>
Date: Thu, 18 Sep 2025 10:16:16 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1a9f44a1-855c-450e-9dc4-415a29b90011@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.09.25 10:11, Ye Liu wrote:
> 
> 
> 在 2025/9/18 15:29, Michal Hocko 写道:
>> On Thu 18-09-25 15:17:40, Ye Liu wrote:
>>> From: Ye Liu <liuye@kylinos.cn>
>>>
>>> Add a header line to /proc/buddyinfo that shows the order numbers
>>> for better readability and clarity.
>>>
>>> Before:
>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>>
>>> After:
>>> Free pages per order       0      1      2      3      4      5      6 ...
>>> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
>>> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
>>> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
>>
>> Why is this needed? And have you considered tha this might break
>> existing parsers of the file?
>>
> 
> Thanks for the review.
> 
> The reason for this change is simply to make /proc/buddyinfo self-describing.
> Right now you have to know which column is which order; with a header it’s
> obvious. This is similar to what /proc/pagetypeinfo already does, e.g.:
> 
>    Page block order: 9
>    Pages per block: 512
> 
>    Free pages count per migrate type at order   0 1 2 3 ...
>    Node 0, zone DMA, type Unmovable             0 0 0 ...
> 
> Regarding existing parsers: the patch does not change any of the existing
> “Node … zone …” lines, it only adds a single header line before them. Most
> parsers match “Node” lines and ignore everything else, so the risk should be
> low. If you know of any existing parser that this would break, please let
> me know so I can address it.

What if there is a single one out there that has hardcoded to skip the 
first line only?

-- 
Cheers

David / dhildenb


