Return-Path: <linux-kernel+bounces-848012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BE6BCC412
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A1B19E768E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC82673B0;
	Fri, 10 Oct 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKHVvXpP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0651BEF7E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086967; cv=none; b=pM32WnksQuzVvVglQiqtJn1FzTn93GQkL2EAGPwBS/TbV/azautZwNAWzh8Bq9SIx+AQ4ydbFxPcHFlsfm3v6tPRe7YahzTJW9FcnFZiEUmSK5JrhjYaj/IdQ2T5vP6diqauitI4He0v28ieep5J11iYvrvdOQ07RBvauiQJQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086967; c=relaxed/simple;
	bh=zQ1wDzEbXc08xJJfoVWzQ9v2/JgPYXXMmtNl8WK51RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQx+0PcZ0owpLrrJ33xAChSx0rPLaUXRSMcO6GRj9+H+WvarqbQDqoD9ps5ZSJKHtoDKt/v4Qu1oRUIcumqjTcX864KpeYD61PEFSSQVQOsq4PDsNScEZc/U3p6g0riXTa1c4eFo32Qk+DudVJ3c5ZmeVg7/zbp6z9AMp0r6mME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKHVvXpP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760086964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HW5td0SWXdCvZ05NdV55x6S0j9wHlZDx+Tv+YWgnDiE=;
	b=FKHVvXpPkUklVX0DZ5zs/NW5uYSsehElA3c9OSnOWg+5P9ArrfEF2A0lchuBKs3XWJbCpP
	xLs5vlFhRASMU6MhjHOGHADdV4q83IfNgNIsm40rxS1lDI2a3aEa/1CC9lMOAZlhDz7dKA
	ft0A55IV2jNxFrPMUXfgEP+Sdw5q1YA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-fDwLFSPjMz2WQv6ZRwIM5g-1; Fri, 10 Oct 2025 05:02:43 -0400
X-MC-Unique: fDwLFSPjMz2WQv6ZRwIM5g-1
X-Mimecast-MFC-AGG-ID: fDwLFSPjMz2WQv6ZRwIM5g_1760086962
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e39567579so9306195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760086962; x=1760691762;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HW5td0SWXdCvZ05NdV55x6S0j9wHlZDx+Tv+YWgnDiE=;
        b=Pq0um86yvZQ4+MEdiVhLXpf26INofUL3l7BBJyGeN/F71EGknCeJFbyKf9TKxHkEj1
         leqmr0tNKb6T5u4eyZ9p/onsEr1225vvW1rOdvTV38sRRzj9tRH5qzYMrktw4SMFyVvd
         pRLDg5HifyVJb76YsdBCfshYFSSbLIRk/RtQTHRl2XzE7cZVditzAV9+6m9qRKtjWDNK
         +lZu4JIIvfWoSj8h9eMoWMjyv0krVZbWJOLEC6BY4CloydRZfb6AG5hpMNYYXFibjHFg
         iCGpLtDFKorYOgU4r977zASww/pPBpW7f5QqTaMig54HULtvPoe6WcjcWaZbrpSX1wQK
         EnNg==
X-Forwarded-Encrypted: i=1; AJvYcCXcPxlshPWiLTP5KP3LSen5D6SGWnJP8yhr3QFJud3u2MWU3ZOM7iqxBFRR+oMIrpa/apTE+41vLaGMuvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXxkUI3oFAJ8+WnMvu2CLhCu9dVCHE02Kh7+Eg04WpfNpAkQj
	H3f1nlsauMnrapAWauFHJ/7iuqSeLJff5G38bZPHBomOHRQ8GmDwYkFxc7BXPzu+c63t99Z60WG
	H7wbDg6RVsir/cUv+C+rp3EG1mPYsnyPe6VGTY1+mObhG6sFbu3sFz9tlmV5LIldSYw==
X-Gm-Gg: ASbGncvhzjN8ThIJ+UtiDYnv99L4RcHnYaclg8dBl7Jc29t8qsRRdO0yGDPsDpnobct
	e5VH3lvXkiXj843syh3BPAxnrs1t4G03PdQc90FDZN4ATghBbDpx0XrriKalbX/2F1RU5e9SHpv
	EiiGa4806OXgvfNu+mhl5jd6LAeOOYLjGiNrXnytuSqrCNLTvW0s73F383yifYbqFgWvTS/cvO5
	3hAmqFcUpeA3sGUbQ+g7tXDugA4dNoMUdxM4SljfZIMbJmb1GNJCV1N8caH+Le1luY4N5+Xb8aG
	LLDVVW9adZUUz6AntD8rfvVfsgFdR7JfeZ9Z9I4b+2rp7WrVeLD0fgzS0hIC0eNXesCuRRod9PP
	Csys=
X-Received: by 2002:a05:600c:621b:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46fa9b08c13mr80512805e9.30.1760086961941;
        Fri, 10 Oct 2025 02:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcNFVwacUWgdTF5cZzdAVjtZQjHGkGYmsKNypeybnL+F7IrjK7WBQw0hVHz78I8+aMAo3glA==
X-Received: by 2002:a05:600c:621b:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46fa9b08c13mr80512595e9.30.1760086961539;
        Fri, 10 Oct 2025 02:02:41 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb48a6069sm36473545e9.20.2025.10.10.02.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:02:38 -0700 (PDT)
Message-ID: <1be7d08f-7de4-4f7d-8897-ef90d2188d5a@redhat.com>
Date: Fri, 10 Oct 2025 11:02:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Support dynamic (de)configuration of memory
To: Heiko Carstens <hca@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-s390
 <linux-s390@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
 <20251010082422.9132Ab1-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251010082422.9132Ab1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.25 10:24, Heiko Carstens wrote:
> On Thu, Oct 09, 2025 at 03:18:35PM +0200, Sumanth Korikkar wrote:
>> Hi,
>>
>> Patchset provides a new interface for dynamic configuration and
>> deconfiguration of hotplug memory on s390, allowing with/without
>> memmap_on_memory support. It is a follow up on the discussion with David
>> when introducing memmap_on_memory support for s390 and support dynamic
>> (de)configuration of memory:
>> https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
>> https://lore.kernel.org/all/20241202082732.3959803-1-sumanthk@linux.ibm.com/
> 
> Andrew, David, we would like to carry this series via the s390 tree,
> including the fourth patch, which is common code only.
> 
> Is this ok for both of you?

Fine with me, I don't expect a lot of memory hotplug changes that could 
interact.

As an alternative, we could route #4 separately later through mm.

But this one feels like it can just all go through the mm tree if Andrew 
is fine with it.

-- 
Cheers

David / dhildenb


