Return-Path: <linux-kernel+bounces-795936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25551B3F9A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388B53B4A73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522782E9EC0;
	Tue,  2 Sep 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fj6UO1+X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15631F948
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803987; cv=none; b=YNUtTam0YsfF7+9+sGMtoowB8wBAUs8EiPHuG26xPivy/Ris1Ux6rEv35NpSaylRFHXswSaddFmn9AvnY3DSik3+aL6Avgs5d34O6wmDZN/1MG7D1NWLJK3iJ3M5ydhmRoWFTHQc+WwMUXJVl3k2+Ebri/y6Wn9Sr7AXaQcNw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803987; c=relaxed/simple;
	bh=M+GUWjGSoxUiV0q/jx8I1r2hPXBYd4Ap6fVJOwy/Ve4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1Wq+9Mle9nlWb6wsYb3NvmiXAEy0XpIO5UWr1yrcJPZFJRnuvj/phJPX4YBB/+byHd1qfq97OfZGk74nFbEpMeHj23hhAtsIJgehHuwXTjYcqUzgTRw1WZkx1kpaFPdjWbANCYV8XnitkVXv1KOrRdCHYDutORaS+hRdjn2itQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fj6UO1+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756803984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lw+TgGPA9m83rrPJxFL67Me2TH+0qzayEhRMRZt18Jo=;
	b=Fj6UO1+Xzcsl4lE1S5Gy1QSzlkjO98eWmeU6MG11AI1fDInHrz0rlLD7M0QyNRXRseZBIc
	ROGAovw+hetIHM1XB3JpGKTwe8iyUJFAWEbWymSceYMdEZkLkOMnSyJAc8PxfHjOTqv6rH
	s2r7mUY03+6XODyDj1X4QTNktzCkA5k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-oOTapZ6DPwCKZ3W_mwpqAg-1; Tue, 02 Sep 2025 05:06:23 -0400
X-MC-Unique: oOTapZ6DPwCKZ3W_mwpqAg-1
X-Mimecast-MFC-AGG-ID: oOTapZ6DPwCKZ3W_mwpqAg_1756803982
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ce7f782622so2076911f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803982; x=1757408782;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lw+TgGPA9m83rrPJxFL67Me2TH+0qzayEhRMRZt18Jo=;
        b=W2KFNkV/gZ+QdYpYGFbtJdMLYh1GJp8u3153Qa2PlCAVgUi+5SIfV+F5sm5Bd5NhGH
         OCI9emwb0qJjYdoIfwtisDz69gQN23ripLbO1+iP5XR5G6+xJ1Xadywess8/AxAZ7gox
         61NbR7EfYWLADSChP0Mc08iwTgCxGloRDXb86KtNGXwRnvmgwcNvHs3IjAULX5LB8Lto
         TrUXWCVpK/5gSNsPcgAv5UibDbyZK1Av+Ab3pLoLVSVIcv/Dteg6yIrRgMIjpUfc308C
         vjPbbpbrqva7TMsLwwrYoOXTeNNkQ/ZMSB29qNZs9VMmm4v2wWWx7h3Mk/UYkWtUKrmO
         BjwA==
X-Gm-Message-State: AOJu0YzJE2X/c/f3SYvOpBaLXEC71aV7w3GhdPu+t//qJ0j08dej+dGB
	T4YjJ3OOvW1tk5WKK8Ul7JEGxTM9HCjzxNAbh+3K2aT72NwDp5Ky445wZKZffFvLzLFkAPk/+KB
	eV06af17lslndn10txT+yzaElDnddF1IbuWib9w1yYExHLDUh66UAkq6iTgFyPyCSNw==
X-Gm-Gg: ASbGncs26GnGAAF6R0eL93qQpWXR9m613wLTbIuchFZya7MmGbn2y+x4E09n2EYJ/uz
	HHtc0SVmU3dY44mNErPhed7unRSCXq/5AceDKb6xkpz3H6KaPRiEcZJndzIwSPtROSe+HSZvFmQ
	LoMV2PFMX9ixCt12rFwPEI75Wwd5JlYMQVlsL+iqFZkPFmOOtUgZAZ5ezKMMco20MxOANitZTsi
	s0kNHkuF0b2o3I23KUX06G9APnVWufr73ud3VHOdYYO0AjrPoA1Pe8ncZ7RBBmsVuMfS0rHqg1C
	oTmqpPlZFJhC81ykEj0ZoUXUr6wGxLrSXs9uJOYyZwYmPXoX/AQDBd+G0jzGEdC0Gb0O3ycFR1K
	lpd6mScdUmYdh3749fwCa1/kfbfxoSmPsKK5695o7xavrVqpAeWS0N9xqPCHUQ3GpdvM=
X-Received: by 2002:a05:6000:2908:b0:3cf:3f1:acd8 with SMTP id ffacd0b85a97d-3d1df8281e9mr9399432f8f.28.1756803982137;
        Tue, 02 Sep 2025 02:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyW9riAT2iFuFssRMjNWNJBp/HthxIq7RSmrdziyCSMPX23wcSGgenXtzWkh/pnL+2k3HStQ==
X-Received: by 2002:a05:6000:2908:b0:3cf:3f1:acd8 with SMTP id ffacd0b85a97d-3d1df8281e9mr9399394f8f.28.1756803981694;
        Tue, 02 Sep 2025 02:06:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5816sm18703055f8f.25.2025.09.02.02.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:06:21 -0700 (PDT)
Message-ID: <40f4a688-42e3-4556-979a-209f0ab24c2a@redhat.com>
Date: Tue, 2 Sep 2025 11:06:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions when
 THP is disabled
To: Pankaj Raghav <kernel@pankajraghav.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
 <1acb705c-4846-4a12-9e90-f7853da8a295@redhat.com>
 <cdbc4c22-7a6f-4c01-8d2b-550b643318d8@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <cdbc4c22-7a6f-4c01-8d2b-550b643318d8@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 10:59, Pankaj Raghav wrote:
> 
> On 9/2/25 10:43, David Hildenbrand wrote:
>> On 02.09.25 10:40, Pankaj Raghav (Samsung) wrote:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> split_huge_page_to_list_[to_order](), split_huge_page() and
>>> try_folio_split() return 0 on success and error codes on failure.
>>>
>>> When THP is disabled, these functions return 0 indicating success even
>>> though an error code should be returned as it is not possible to split a
>>> folio when THP is disabled.
>>>
>>> Make all these functions return -EINVAL to indicate failure instead of
>>> 0.
>>>
>>> This issue was discovered while experimenting enabling large folios
>>> without THP and found that returning 0 in these functions is resulting in
>>> undefined behavior in truncate operations. This change fixes the issue.
>>
>> Currently large folios that could be split are impossible without THP, so why should this be a fix?
>>
> I was debating with myself whether it will classify as a fix or not. I have had people tell me that
> I should mention it as fix even though I didn't feel like it ;)
> 
> But I agree with you, we can't hit this issue in the upstream kernel. I can remove the fixes tag in
> the next version.

No need to resend, I think Andrew can just drop the comment.

I'll not that I assume with any large folio support (except unsplittable 
things like hugetlb), we would require splitting support.

So calling these functions would rather indicate a bug I think.

Fine with making them return -EINVAL.

With the Fixes: tag dropped

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


