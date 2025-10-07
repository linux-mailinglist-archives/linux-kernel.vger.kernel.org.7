Return-Path: <linux-kernel+bounces-843872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E033BBC075D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE373C3A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9CE2264CA;
	Tue,  7 Oct 2025 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5c0RDS3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F22A932
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820708; cv=none; b=KSRPKKnL1MrnHOyTZuow8Kq4Cj987uQTSLm0hXGHCna4EH5IhK25rFM6pV5Fmz3Wx9opqWX7GmblvebLvK54+dN/stbQhzo1bQoJTKg2DPbk2BkaJZj/hg7OD7Wa8GdbVSLeo9AlnoDJcdSgaO4Jkq55rqHAeTPKUmbrnu7W0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820708; c=relaxed/simple;
	bh=FkM5uzbJAzH7gFPIxoYqvl7ZAi3ftOKukHYK7izfrJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5ptg2vNUJYCDyLwjGAIPp52DOO/oKOVvu0llxD6lxX2gD929tLe04eHilBvAt0x9eshSEt4b7j/kSHa8G+dEW6zVDfucOGb/KdJ3MmXXXA0Hcq7tkzRcrNm5bozBU9IlbPOm1yg1Xrt34R7TE5fDz3gZkJeOs/ctXSSHXgNjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5c0RDS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759820705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LsgJYQtRkFw1giZqcBq1dAAAg/ofM8wyV73TVWhQW04=;
	b=L5c0RDS3PTiMciV6/BAGhdCdAtb88XoIB8VEIslx/X1LWBtMU0Ujh5KckYK5dJ1br5My7L
	beJPYneR3mVBYZ317KLZ7QDRSk3u68UgPL3JKD0TlnM+H6UGEJyAQZlYAnL3aTLWGIYa6J
	wNDuopIF1lcMaym3Nmc/JmXIGZqku1Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-350ZtI3MOMCrOXr9GWUpmw-1; Tue, 07 Oct 2025 03:05:04 -0400
X-MC-Unique: 350ZtI3MOMCrOXr9GWUpmw-1
X-Mimecast-MFC-AGG-ID: 350ZtI3MOMCrOXr9GWUpmw_1759820703
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so3499085f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759820703; x=1760425503;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsgJYQtRkFw1giZqcBq1dAAAg/ofM8wyV73TVWhQW04=;
        b=kXvflmTaOTMnShjWRYwbYMu0aNrSrUHXR5WD3MGoBEtvCv7UDvQKUYySQ7COXqXc/d
         QVibLzdhuVsTbqi6TMZXNFDhvJ392wI6ij1oPJyN0v+S8fvle8t06gzmU2xIGrXK2H8r
         nc8tTVQxf4aOMl/6cFsnmMc7zv0Jyig57LaTpw/Oezh2MJIWIbv/gBMytLHGd5w3ejnD
         R6soU5bhhEnpmmP3O22kAHaz6UU8riguhVtCVmoCOyYK/aybKmTM7Q7ydUs7yO+V+1Wn
         NOCnk/jNQ0Eym+Tybn26HxTdkbOw99P4c+Poq+O2wz4GMK2ZaAUZT3zEYTNtpR5NjMnP
         Mtrg==
X-Forwarded-Encrypted: i=1; AJvYcCUOxSuNl3pz3dCkq6zGfhyXJIjBYbb5Fcuzzc5a4mcfDtXXjfHXv50xqrXhX4IGidfJvBlyOgUBIJXiklQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgE4i5rPAaEZ8GxjDRVsFkAl0pUpkIKwpI3s3OkD7w7xqwauKG
	tDJ3lw5EoBEnQ8rAFYJASc98vNvIG+0CzDCVRqEvJfrY4wCAmrkWWuAtZE/+aJNKufQz1sxKTKj
	V/5RzDD0q6lfWGMaM4iFvb8BeyHvuWd8E8wukFl/4WUTLCiaSRYCLXVN1GTbUEZE7CQ==
X-Gm-Gg: ASbGncuA4n2ZX9r0UsnqomLnHCpUyCOh0lNEYcHUs/8CKBzvq5Fabj+coHghslRXerA
	HVYhddlHauEBvLvKgJn3/sVhZXzJhRc27J4LxIwEqNOKgCoqjJh6WX3wCV3Tcy8yMH5ufKu6h0w
	Lau8EpYf5I324HBpjxesAOLvV7oJFZQgSL8XAvtYbQYZUPJJ8IR2xjFjs1DfCeVQTXAr4h0a1AB
	EdRub6mwdhuymzpUgc1Scq6DvwvBLHn7vV2XALu3I4JJcWerbIIdMOOPMuImc8t5Lj2e1SSq8ub
	HUYvPeywuN2loUHRoeeevkqphcqaPZ1ss0qfhsFYZIoWfqY3p4xlq3PGAsTxYemYT3GSDepEcwu
	pSJmkb6Wh
X-Received: by 2002:a05:6000:26d2:b0:425:7e40:1e02 with SMTP id ffacd0b85a97d-4257e401e18mr2592447f8f.7.1759820702912;
        Tue, 07 Oct 2025 00:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEe+DSQyJlOgCA3XBbLClZSzFhKAVyYRCSZG97sGm0NN9M2K3Zt/pnRoF/CTSO2PMEqPUlag==
X-Received: by 2002:a05:6000:26d2:b0:425:7e40:1e02 with SMTP id ffacd0b85a97d-4257e401e18mr2592437f8f.7.1759820702507;
        Tue, 07 Oct 2025 00:05:02 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a029a0sm286626055e9.13.2025.10.07.00.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 00:05:02 -0700 (PDT)
Message-ID: <deb6c0a2-e166-4c91-9736-276c9f1741c9@redhat.com>
Date: Tue, 7 Oct 2025 09:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
To: Yunseong Kim <ysk@kzalloc.com>, Byungchul Park <byungchul@sk.com>,
 Hillf Danton <hdanton@sina.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <20251002220211.8009-1-hdanton@sina.com>
 <20251003004828.GA75385@system.software.com>
 <20251003005230.GB75385@system.software.com>
 <3b66d603-543d-4616-92a5-9e6e32f116be@kzalloc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3b66d603-543d-4616-92a5-9e6e32f116be@kzalloc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.25 08:32, Yunseong Kim wrote:
> Hi Hillf,
> 
> Here are the syzlang and kernel log, and you can also find the gist snippet
> in the body of the first RFC mail:
> 
>   https://gist.github.com/kzall0c/a6091bb2fd536865ca9aabfd017a1fc5
> 
> I am reviewing this issue again on the v6.17, The issue is always reproducible,
> usually occurring within about 10k attempts with the 8 procs.

I can see a DEPT splat and I wonder what happens if DEPT is disabled.

Will the machine actually deadlock or is this just DEPT complaining (and 
probably getting something wrong)?

-- 
Cheers

David / dhildenb


