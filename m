Return-Path: <linux-kernel+bounces-756371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EADBB1B332
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6676518103F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D62701B1;
	Tue,  5 Aug 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TU5YsPbY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C023C50A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396226; cv=none; b=mP+I2djeeVxB+Fv1fvz7rWNwOlVRyi94Yw6yuEGdjkDTlUEOlrYpikAaZLRz+9xcuOvUhAXCYqZVsxKa0qD1rkL5OTVnJqB3YVPfGFZ4M/lJ9qYNJZGrpW0K7eizjcaJWfrOOZe1kBaSw71S0+W99o8byl9THNNLx/rC8rGSKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396226; c=relaxed/simple;
	bh=Sc0MxiMy1EvxaKJuID6F83bz6E1qgx5bjiAYdaCLoi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV9O0vjTrDiFwKMc8l102CfdUI+l4ResLmPg1GzYJIf8gg48muMOrAH0MsQ6S6ADcL3nHYWk2SNaNGIqtEthi0q85UnLS7apwkSLkjfUmsTpuSzQmwxYeiJsdJVYbuFodUEGRGd1H4gRoQIW5j3BgUIk/gHBVRp1iHBG9HjgXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TU5YsPbY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754396223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hnpdZY3v1kEaD9q23EVotFIxNBvlTwoCxf5DTi1K58o=;
	b=TU5YsPbYgLbMy8CqN/zcqzPQ7KqD9nj1a2MNzDZsyQ8ePPwqWPcMaziWoKQzJC0H+t9hhF
	jGEUPUSxGHynocEsmjNBpH5AcLLSWmxKy5Fe3p3a72uOQzXQQtuG7g4tbAaC2UhGHRb7lf
	ioZf29AzrkRALvGN4e+gah/1MTncJbM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-d2p_vCOjPVu2sk5wioQvYQ-1; Tue, 05 Aug 2025 08:17:02 -0400
X-MC-Unique: d2p_vCOjPVu2sk5wioQvYQ-1
X-Mimecast-MFC-AGG-ID: d2p_vCOjPVu2sk5wioQvYQ_1754396221
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459dde02e38so8646135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396221; x=1755001021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hnpdZY3v1kEaD9q23EVotFIxNBvlTwoCxf5DTi1K58o=;
        b=qG9BzpD/kAUOylfOK+PBuVD5jp2klHLt5VUlb8P7AvFyiX8T5HR3GtHcdlgz4EDgex
         Jg1ed5f1KMgE+6AxFcqjQBFqbbW8vC/hf8jVAt84XuiEc6y8kYLgDy66CN3ejLGTIsyb
         DG45SyLxxs7fDzGOPkSXFYaKHu+SD7VeFl4Rw3Jodljx9tj65iazEWLseqYskY5/d1Ol
         frN7q38LuHrpqRbfZzYs7NOksOz0w7gnK//36a6CxEmJtOvQuy2wIab8AY2YUJw3sD0c
         JOP4xll42AX8AehFKubalD4Sv4l4STdUrNYeb9MC/c37je52P6dzomxnViDudgfplO1S
         JdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1KJrjFVPCjgJdsiuSLM6BapLkjJJVxqCAq9SlktWgeGFb/1X1ZgRMuQzRjNbFyeV+DjZ1Dgq9AxeXgYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKbWhHlr6OeSQNNU3okdUYaZtgciilMOkJPHVjN9PYhkxbq3s
	zOLOksoTz/7MF3w0NOyovz4DxSwKOvgJl3mk3DJUE8G6lWQSKud20xDATjc5KSq/AmQVrtyRpC4
	Wdd9qFF6CXXsaj64gJrFz8HU1yFyuBsRZlSfEg4lnuBdJ/+va8xjw0CV7+jUA0fRZ8A==
X-Gm-Gg: ASbGnct5FItPxfc9b4PyZ5soGsnr8eF396GoMGPrQofIJWSRwGlBaWo4yXBuygyy4L0
	LjdfkWG3/LN9K2c/kcvmXO1t30NbWklC4mhnt5uT9H2aia3DgudY293qNLy3vZ9fb4gNDYC7csv
	vY30ZSMj1SK4BnToak5MOQpFPSaWamPSrJfEsDP4oTzWE6eOfsczC8P/cunzuybGbM9hUTYsSDs
	B3yS0B/+mXXu6pC+fG4Jrq4bbf4NdovK+0XyXR8mwv1qDoRMYh1Gb4syr0MDTuPLg0GcwnsXm6G
	pJrxFlyohUuLaLWoYLVxtgSVUDsr2QZN/is8ZD8VD61+q4qICZE3EgS1KllhdA/+CwKVzNHT7+s
	80WgsHVPrpk/do6XzA+LokeWveL3A6771gKp5K5lcpNQziPGz0i9lQg75aauidiJ4/Bw=
X-Received: by 2002:a05:600c:a4b:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-458b69ddcc4mr99532125e9.9.1754396221156;
        Tue, 05 Aug 2025 05:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrqOQ8A8qIGLA2mvtZF2b3QEhwpenSBEb9wQuyaM/Fmf5K8F5vu/aZnLwJYmcbo9s9KE3dZQ==
X-Received: by 2002:a05:600c:a4b:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-458b69ddcc4mr99531735e9.9.1754396220689;
        Tue, 05 Aug 2025 05:17:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e471sm1481245e9.26.2025.08.05.05.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:17:00 -0700 (PDT)
Message-ID: <7cb06105-f2d3-40e9-94ae-3d497b9d8730@redhat.com>
Date: Tue, 5 Aug 2025 14:16:58 +0200
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
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Donet Tom <donettom@linux.ibm.com>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <eec7e868-a61f-41ed-a8ef-7ff80548089f@redhat.com>
 <2c795230-5885-4a1a-a0f9-c8352b9e7738@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <2c795230-5885-4a1a-a0f9-c8352b9e7738@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Nothing else jumped at me
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
> 
> Thanks!
> 
> I will wait a few days and see if it has made it into mm-new and rebase and send the next revision.

Will only happen next week, after the merge windows is closed. @Donet, 
are you planning on re-submitting you series?

-- 
Cheers,

David / dhildenb


