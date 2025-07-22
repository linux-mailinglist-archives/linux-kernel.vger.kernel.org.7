Return-Path: <linux-kernel+bounces-740429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39376B0D40E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D654D16F299
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1C0298CA4;
	Tue, 22 Jul 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXfUWsUv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32C288CA2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171158; cv=none; b=ODmtsk47g8ELxE/+O2yEBpJ9dwLI0YQAGZfS8CBOaYjZekMOHEKDvSaVuTusu1hTfqeWmG8g40I69AxXqJ1pgWbS2O3cujPyFVsXfHbfPnimjE5Vwr9Ji3/EYxl1XhCph1L7AKmPGP1NntkzgVW/ZjDh6TmsV59VldcAed/AVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171158; c=relaxed/simple;
	bh=NhyVBJq0RbBHsCj4Hv91n9yYCh//7jqyYCsyfdC4Rg4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q9Sm8KznNxEL9cvPFHFQUbmqv0eBp8mmZf5JJsZNaHGFy55DX6OyVVcH5libo7/fD4u2BxsaaRPW0GdGl5O7Y1+HX7vCp5eq5LNIu25St/BkLjNUpoI4YiKD3OwV+OU9Skj7z+BXZDOjOO4+R9zHz/Mq2/Hb5xwtPrpA6B/1Dnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXfUWsUv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753171155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c7tvfKGQUm4YoUJU1QbX5YUPQXMkfmqVEGF88600kKU=;
	b=EXfUWsUvHWjZXxh05uEY2oIcKmZ+JoF/B4LMuLpWJJ7idX09M9Ome9pyLC5CBg//W96c+y
	A4Bf+RNe3VA3OqWxbuquj84YbsLVVCKdoq/zjCofFwH01rUlFtflnengw9TlqUR8KAJ5/t
	iEVMKOzc/09C3pt4zLGNeoJST2hko9E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-UZB3MlpMOnClga6VUKbyPg-1; Tue, 22 Jul 2025 03:59:13 -0400
X-MC-Unique: UZB3MlpMOnClga6VUKbyPg-1
X-Mimecast-MFC-AGG-ID: UZB3MlpMOnClga6VUKbyPg_1753171152
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so2606647f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171152; x=1753775952;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c7tvfKGQUm4YoUJU1QbX5YUPQXMkfmqVEGF88600kKU=;
        b=hICGJkC09NrEsrP5HXZR5ICEwC5aQiAd4q6qQAHmbErddxZwfGEZgelDnbyvs1+ROc
         IAu5PjaEqID07sR2Qnh2FtGPEp6jP182U45GOjNoBgOeVuOkO4doKrwB9AnSYtigfY4B
         thmrTglQ3sv1mI/AUHA9lXyjL9c4fLewuTvFq1zxQApWebP+pe/W8AwbjYJWPz03vMeZ
         t+Ky8uqj1S8Owi1CwEJplbhWLpt5TiU6l1yoLEiRsmhjhq0hFwUlq/clgyyFxm6+XsBW
         AKMovFZpW8f+EfuwvCqg3HK7V+Mq6WyqZlA5oZ8KA1K/bZdFvIJngVqvUEuGLrOKY/Hb
         Zv0g==
X-Forwarded-Encrypted: i=1; AJvYcCWTx9unhnymSbPL1a8kXI/EAV/V5s5YpAUmlBBfkgypQ0vteozO7oKo+W0LMHRUh1fzcozQvKm7fmbLVZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXenjicdg0O90RgWXlJQjlI50OU3lzwNe0D+pSNIYlqMEjG+sP
	wsudhRTY+UXvZnNok7pyFaxhWYSbiPsnLvBS83+fi67tFSQUD80CckD8OwerAaBp7r9zw1hKujB
	CYQS88ykQJhbX3CyR9gUcIs8U29W2oaqQ0j0oLIY6GJBO17/bOpEM1Ktx54QT4BhOmQ==
X-Gm-Gg: ASbGncuVaHNy47dML+G8fC08S7aAHFjuncBXDiHERz0XhPT5jVmky4bASb1RD8HwzcZ
	EzFxouW8DAiOwHT8srsqGhZ6eDNp+zKy9/GZToJuAld8ml4g633ez4O9iBSY2Q6/1IQiQ7DG4q6
	a+NcRQmZCecALYJwzYGpgyRLjsPHCgvqbaOo6ttgwR6hppicgwXdyVX1lwVhrNTiYzvAOfLN0c6
	aGDMFSofrwKYP4w+v6qBfshvY1NC29bkTPvBJK4Z4kmyd2NurZDjlgTB73WOi5p0yn3laDGwIrp
	+AqNE54mQYCGeGT+o06mTSdzc0YKqrykCJ4mOq9bL1CuzA2vDf6HUyu+gxLO6a/1YcKpnTOa5dB
	DtAXqs/5Y/YYVCAKkXCLJCB7RCyZOSwrAXjPGMZYqzQFQ9hZJodiRcxH+1C6g+0rq8+c=
X-Received: by 2002:a05:6000:4716:b0:3b4:98f6:dd77 with SMTP id ffacd0b85a97d-3b61b217fd7mr12320348f8f.36.1753171151912;
        Tue, 22 Jul 2025 00:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2sf5QLlZEJr07ey/1yKpexqTHy8UV5PCpiUokLHs9olPrPrd1PKqO/suIPMqhDpL4yzTVfw==
X-Received: by 2002:a05:6000:4716:b0:3b4:98f6:dd77 with SMTP id ffacd0b85a97d-3b61b217fd7mr12320321f8f.36.1753171151431;
        Tue, 22 Jul 2025 00:59:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e803cb3sm181199025e9.14.2025.07.22.00.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 00:59:11 -0700 (PDT)
Message-ID: <64b5b420-4c2a-423e-825b-b2c309274d71@redhat.com>
Date: Tue, 22 Jul 2025 09:59:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
From: David Hildenbrand <david@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
 <39a75435-5fea-4816-b484-477d400c3564@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <39a75435-5fea-4816-b484-477d400c3564@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 09:20, David Hildenbrand wrote:
> On 21.07.25 17:55, Lorenzo Stoakes wrote:
>> Rather confusingly, setting all Transparent Huge Page sysfs settings to
>> "never" does not in fact result in THP being globally disabled.
>>
>> Rather, it results in khugepaged being disabled, but one can still obtain
>> THP pages using madvise(..., MADV_COLLAPSE).
>>
>> This is something that has remained poorly documented for some time, and it
>> is likely the received wisdom of most users of THP that never does, in
>> fact, mean never.
>>
>> It is therefore important to highlight, very clearly, that this is not the
>> ase.
>>
>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> ---
> 
> Can we also somehow tone down or clarify the "entirely disabled"?

Ah, missed that you touched that already.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


