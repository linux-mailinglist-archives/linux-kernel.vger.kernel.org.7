Return-Path: <linux-kernel+bounces-860507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5CBF0472
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08062188EBED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8402F83AF;
	Mon, 20 Oct 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO4RffEc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EB2F6167
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953356; cv=none; b=LrhfRcEh8OQVQRin5cJD3vhlaH1IubibOW3AtnQak26C4MvpsisRddjrRhmJg5MGogDsCYnUV2np7GkG3MCMONtEQG31YwCGTBaLi1aiTc3C4Ix3/OL7EPryRwaWYavQLeV1TH4SOhq0D41rl0K7lEVeKnTgRiItYrP9EdvynFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953356; c=relaxed/simple;
	bh=O16OgnzIsM2oetzx1CkT0B+lRTOeZ901gdACEQ8n2sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liPljiE2N81smFNtIFY+AKSWDyBqWiVEyJRHkF6DX0C7Kd7K2qPd4qa5BAhcy54TPbL2umFmAxtPvGudTdh5kwC5CNpUpY/6aS7NSTRc8N6stMXcEKP62lVsW92J/FdBh1bWnH8XFxtXqyPL1bcxBMJWuebJ16q8ftjUNIV0x1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cO4RffEc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760953353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jOBQ4PbHnqHIUCLaqEIn37FTR5dtbF8Dc9Z+ni8VzRM=;
	b=cO4RffEc6KiysO1ZMnWXUZyQwwEEzXf5y0jgZTg18bJX7uu7Lrf6BxXL6XbHdB3L6L1GdT
	hXaBF5crh7ewYjHI9rzga5cpKvbpMt/IeJvGN128LJeu8k/9VGK8AKYo7f4VHSgUmm4gg8
	ij/GwDN0/9M7+VnqwbvKLYYqu3GM+m4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-QwcZAeQBMEeOr4teNdnlUw-1; Mon, 20 Oct 2025 05:42:32 -0400
X-MC-Unique: QwcZAeQBMEeOr4teNdnlUw-1
X-Mimecast-MFC-AGG-ID: QwcZAeQBMEeOr4teNdnlUw_1760953351
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42705afbf19so1564261f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953351; x=1761558151;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOBQ4PbHnqHIUCLaqEIn37FTR5dtbF8Dc9Z+ni8VzRM=;
        b=Kn6Hk3klvx/CRDXW8xM0n3ITKy0UiMIS2Sy2tR1StkaVboCyl8dP3uj4xS+l2f6WkU
         b7TRJaetpKi/Z51eEPKrQ8dwtuPcX/9dfqmijOpDliX4MOXLNBxcLjjFhc5dgwC5IsAo
         4Ew2tyVrCpJTvYN5OR0hdoipErjLMNwmM6NKw14DeG7Jqp02ygBTvF36Et+ObH0nOAyu
         wMO5eeRtX7EjLSF1Km3NbG3tEL7r87E9I3JJNlKyzGqUIgzI1ioQ4/NaIoKKo3l8MwvY
         +1T2T6SPWIPlk0Fn2m313xgZVMOvLsl90e6W8AMiDJ4Pr1TAIAjLYaUvhEX2MmHHuFm/
         P2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVbPa3y+F+XZrFAl5ICf1p8hdrYIfUpXGkdT0MxzMIfmhv4hFbZ4kkdk+WFw2ozFD7hz5k0+swk4ufLVo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPAu679qcypUIIgbSETkHg9L149v6RRXsCD6C1R918++a8PXZ
	DrV1wp7Q2jSHWKJac9e+Qd3i4NA0rK587VDeCGkyFAq/fVxerG4BvCEYBCFSvLWqzg2OBxmyAUI
	nWXSOd0d6lgC/8x27tBT+INsU3Zmn94ROtS3b09q1VXV/zwvVHXDo/TvOPTL3zclBzw==
X-Gm-Gg: ASbGnct9V9b+PVGn8en9YIp7qQwkv+dOtF+ekOcMzpWc7IqGQboe268PQoydu/vpN0Y
	aEmLuPkMSJ8kqvoZ5fDE/9S37hSiIJsU3ItGbXryS9oUTlJ/nN/9nr2MBMJbH675PWw4TH92RdL
	7zpDY67lFZ167DhXs/tN6V9uNpsZjBITGA0uXBFSN7S9jAJNem7wh7j15dDotGcipMThEgLhu/5
	kR24r7Nk1jWz+W3WPfhvxq6XOwh9RlNnQ9sG6jep/qs6X7hcu0xtf9YvOkSJZTjlJ2EVNSGb6Qy
	OONgxaJgy7r6QEwOeVjlJHHcL17SuB1URb3TEth+fok/CyCB0QHhC3EDGsM2xA/AG9yQNNXGUrr
	OVRXmsbb0VhZyqkM8x5PtcFL+gLSdeGkn18laJ/NEm02uMqy4FbTeh/aw/lymkDYmzKo0CN0XZu
	wj0W5ELeanL3kkwIJ2qcPbjS0lNgg=
X-Received: by 2002:a05:6000:2901:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-42704bc0cfcmr8773938f8f.19.1760953350969;
        Mon, 20 Oct 2025 02:42:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzHP9dNMLiAI90dFnuyKuwg2ijCy6uzjGDm2wugIYXFE5lmk2eMaJ7ZvkD5SNR6GU+S2J79w==
X-Received: by 2002:a05:6000:2901:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-42704bc0cfcmr8773910f8f.19.1760953350399;
        Mon, 20 Oct 2025 02:42:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm14619574f8f.28.2025.10.20.02.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:42:29 -0700 (PDT)
Message-ID: <320b8572-bdaf-4aa9-83d7-701d18a9628f@redhat.com>
Date: Mon, 20 Oct 2025 11:42:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Andrew Morton <akpm@linux-foundation.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>, craftfever <craftfever@airmail.cc>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
 <20251016140735.d7d4c282f0fbf22954a4b4ee@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251016140735.d7d4c282f0fbf22954a4b4ee@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.25 23:07, Andrew Morton wrote:
> On Wed, 15 Oct 2025 22:22:36 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:
> 
>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>> to locate mergeable pages. This becomes highly inefficient when scanning
>> large virtual memory areas that contain mostly unmapped regions.
>>
>> This patch replaces the per-address lookup with a range walk using
>> walk_page_range(). The range walker allows KSM to skip over entire
>> unmapped holes in a VMA, avoiding unnecessary lookups.
>> This problem was previously discussed in [1].
>>
>> ...
>>
>> Reported-by: craftfever <craftfever@airmail.cc>
>> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> 
> Is Fixes: b1d3e9bbccb4 ("mm/ksm: convert scan_get_next_rmap_item() from
> follow_page() to folio_walk") appropriate?

No.

That commit is not the problem.

The problem probably goes back when scan_get_next_rmap_item() was first 
introduced (likely when KSM was added): it simply never was optimized to 
deal with large sparse memory areas.

> 
> The problem which is being addressed seems pretty serious.  What do
> people think about proposing a -stable backport of this fix?

We'll likely have to backport it to each and every stable tree. We could 
think about limiting backports only to kernels that actually allow for 
enabling KSM for a complete process.

So that would make sense to me.

-- 
Cheers

David / dhildenb


