Return-Path: <linux-kernel+bounces-756584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D7B1B648
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0101881CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408323BD05;
	Tue,  5 Aug 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QK34E/yL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D6238C16
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403760; cv=none; b=rnz1gUzNWyQhlCwxi6SurTtGgBWsu6925o43mvbNKb5p7hvzIBoIuXU7deHNy/x1lV8a2nlcuBsF52E84t2dgBjFiTkIye+xbs0Xgv8IJXD/0q2PljHkUUSNCH7qBr0Vxa8RybwL4JzvBZQbNAdQ0ctQNbhxfbLiCIvjZj+ZkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403760; c=relaxed/simple;
	bh=9gFb6clZPUJZFrqfwi5hiLweZ+qqLDqK7OfEpVXqvik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8dIRZ/28aDfP8hroE+JVzh7n5s1wm6rpiY6S63c7wUYk0kCOfe+iiZP6dYAhYLjjITUMSZJ/SbcAzyL58LhwsjcjrCD96YdU4OZkN5upDEGP8FSIWTEC8GvfpN2LhKpEzBaV+qccsUgQfWetXLuyn5oc0mDBBYy+Moi94oyHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QK34E/yL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754403757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/3xPpIBV/hBiBAcU5/ItEMTEid0VgLtoC+NgACKpt/Y=;
	b=QK34E/yL8EcQkTJ37Aplv8sqhDinpa2a4rGG0hOfCT2MqQc4N6DpoAzLLfY5et4RmxKit5
	1T/igUk4JFAglmFu2Sc85mXV+3yVmUe97Y7xwwt2fKbAjdhgVrSDrwoRJKXmBZ0WuZsHnE
	ko//piTQfJY8NXZo5fGEgMq9apRsduk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-kreBTOesM-Om4YAzbdP4ww-1; Tue, 05 Aug 2025 10:22:35 -0400
X-MC-Unique: kreBTOesM-Om4YAzbdP4ww-1
X-Mimecast-MFC-AGG-ID: kreBTOesM-Om4YAzbdP4ww_1754403754
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e30e4477so4999065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403754; x=1755008554;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/3xPpIBV/hBiBAcU5/ItEMTEid0VgLtoC+NgACKpt/Y=;
        b=HJh6Jb0ye+wPYgmdeW7Jwe1QXdJYbVoijL2ERb+IwYCyp4mrffWDTPlMPmgApuwu2g
         +76xNMmB6db4aqn8ososLdhQmzjV7FLu83IlEkmidtcsnguZXNHuz543abOoKFx8UXRL
         eQhlh+QyHK/rt9x9Z9zw4SwRtSyanc75HA01PC8iToZbFaCFqxw31QDGZQHgG/40AUYs
         FceSgpjMgF0iLy3CVufjTg5W1j/Q68VVrm/IxiheTZsBcw3EUVqJExrq57HGRJb2gomq
         j1DoorT0/WgLgNuB2d3T6MRC4GmYwaISoio/C0NMrzcobkAOkqEH2fXRSMl/fCgdbpDm
         D8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVal/wFbgEkn67C88khEeI5HJZ6qNIx/Eu5ODR9guwRWbxqyJvwsKSuVdlP99U8pgDA7HlRzIH5u8WX1SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ap5Q15W6+j0cjdIcg5IeE11zgIfBvMwE34RjcA0zy9qOEjG5
	tbJBF8Tz7pcoYpXXNKR/3DL0p87ZYpMO/YLjEl+JWkbxg/QnNb7FF3+U2d65Ab/IGPH17S8P1cs
	2dHJrkqVT+oxhgeQxfi8C47vMrQssRaeYF3UDcWG6ypySEwLOHP2GvVFOWbgOwSiIZA==
X-Gm-Gg: ASbGncuF3vMDZBro/UbKtMyWInshisgNqlpXTO3Z0ikxbQISWHMANmpmgTagYBVzZaj
	0LLRfYPsI8MDtWglamd1DMcBQrPQFiBcqBycMh8T7eQTs8uH6AsYSXU10r1x9KAMqb+5GOjcaAV
	IsOjihfkRb/lx7ppKyx2uhmDJwDPhHWBu5PtyZAlbRHcncl7J7YDJEG0/Q8hFE/shQPqppK2o4T
	ilna/reXQ1LLO0ph+tn1BIc/bRc2g0VAiwyHtpDSumKpj8yMU/gcxv+Z0v7WGcW3IW9Ft/Y/OGz
	HK6tPt9SK4gd66e6BuTKziiGQdxsL18BY8v2+CZzZsc5TjOPR1pRSthWPsX7KRjz+IhHNKYA3Cy
	iF2FMmMOJ4iRWLOu/hj97dt85MZnviFOCwsIL1OvNIhJGIfswNn1DfOx+WPWIjJN+ruo=
X-Received: by 2002:a05:600c:548a:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-458bbf67985mr111520395e9.0.1754403754205;
        Tue, 05 Aug 2025 07:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPLisIYjz4KozcRpExKiSuNlt/PZE8zt18fnhKg9QyKx9ufWqpxNxpVlVvjC1oPSuFzrXXCw==
X-Received: by 2002:a05:600c:548a:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-458bbf67985mr111520055e9.0.1754403753771;
        Tue, 05 Aug 2025 07:22:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5868fd7sm6559025e9.18.2025.08.05.07.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 07:22:33 -0700 (PDT)
Message-ID: <57582464-cfd5-47f5-877d-88918ffa2ec0@redhat.com>
Date: Tue, 5 Aug 2025 16:22:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lizhe.67@bytedance.com" <lizhe.67@bytedance.com>
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com>
 <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com>
 <20250805132558.GA365447@nvidia.com>
 <00999740-d762-488a-a946-0c10589df146@redhat.com>
 <20250805135505.GL184255@nvidia.com>
 <44157147-c424-4cc0-9302-ccf42c648247@redhat.com>
 <20250805142028.GM184255@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805142028.GM184255@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 16:20, Jason Gunthorpe wrote:
> On Tue, Aug 05, 2025 at 04:10:45PM +0200, David Hildenbrand wrote:
>> There are some weird scenarios where you hotplug memory after boot memory,
>> and suddenly you can runtime-allocate a gigantic folio that spans both
>> ranges etc.
> 
> I was thinking we'd forbid this directly, but yes it is a another new
> check.
> 
>> So while related, the corner cases are all a bit nasty, and just forbidding
>> folios to span a memory section on these problematic configs (sparse
>> !vmemmap) sounds interesting.
> 
> Indeed, this just sounds like forcing MAX_ORDER to be no larger than
> the section size for this old mode?

MAX_ORDER is always limited to the section size already.

MAX_ORDER is only about buddy allocations. What hugetlb and dax do is 
independent of MAX_ORDER.

-- 
Cheers,

David / dhildenb


