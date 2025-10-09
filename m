Return-Path: <linux-kernel+bounces-847386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAEEBCAAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64F794EDA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E47257448;
	Thu,  9 Oct 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4UattuO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C402571A0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038025; cv=none; b=b6bPNCWV6qGT4ZbQNs8y2K2VZWUZ7sbjBU62Tzf+o+NXzYW3LE/PZND6IZ8HUwmrJ/EwI0KD45hTX1yvd0ulLFK9VsPq3K8feXbELPtwxWR3UCwIZgk4ILQnafiNuB8Y5WUQcdSNtK+7JAn5ub/o0JJ6KT3ZcPiWTDf7DNrU3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038025; c=relaxed/simple;
	bh=AuZ1xHfQENYaRe3ExOrzXIdB/SUMKJjJgeKT3WD7AnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0/5ZrkIwAs2XaLicbvFqKaTlsFuxG6h6ydeHFQlWBWvkVseG+yHodgYa8FB9ny9ZSSkHV0D3lkqHxryaO8p7a5NY4CBsuJfnL6UgfPUhHtkcCReZacGn6IyGLsA8/gJR1AK6rsDfYtdYU7m4pTmLjYIhdKE7t21nKjUHlH0OFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4UattuO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760038023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kEnK6fpozBhIAiBgrIzZuihFNuo5JowklnBGljzyNCw=;
	b=C4UattuOick6YnwOlHxixa+awPAZfhTiMrP9yAz01Oq+Xd+CYwPauskMYA/zHPZa52zMtu
	vKtM2yw605v6tyhrn1ggAIVJhNoUcOJz8Rzh/LdmeEpVuZ3SV27gGcM8QWCkzVqSXq/Q8a
	IX7+z2o6d36fPV2fi/Kn5/gkkMz30IY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-O6Aubvq0PxmEe8cVcToETA-1; Thu, 09 Oct 2025 15:27:01 -0400
X-MC-Unique: O6Aubvq0PxmEe8cVcToETA-1
X-Mimecast-MFC-AGG-ID: O6Aubvq0PxmEe8cVcToETA_1760038021
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e407c600eso8474745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760038020; x=1760642820;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEnK6fpozBhIAiBgrIzZuihFNuo5JowklnBGljzyNCw=;
        b=LJ/m2agzC6yiARaLBbiRkNS4/1o5nI3Hb7JVTpf4fvESs8IgWezR7mRSqVltMBOfui
         knOWJp579i8t/rLcmWLBpVyU92sXnplbUcdkrCCRxS5OJ4HLD9+YfWi2843GnTItNk3A
         Gvtfm/6VT1AlVIwEuDszL8QD7NtUDnrT6L5oOqfPRmaJrT4ZrbnLOBQvkLv1eT5MZudZ
         bwOpcuo3qDOorPDb4tEdJM9kLxLkWdWsS28BFAazOfxoYXbbHBWxBAY1iBkA4PgPv3rT
         mDU3WLVLh2sX8CKshGNEGWgH4UiEYxH6SVExZU8XiqA8FjyLwbu58axxTbyXowD5tNAZ
         Mamw==
X-Forwarded-Encrypted: i=1; AJvYcCXK9D3uNmN3cUtzgvPE9btYGmqC5NFmwS0AfB2vmkVvdaGbXCoWh2F/A/nuCPqFxkoDB2O1X1WRc5etxo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmTWJqVF68/Cd5ngiX34zT31/TagCmPZYRZ44tEhNTwyA+SzQ
	CtdroshjBXWXp7E3NaPcOAcDZR4YtgA0qScSvBeHwAqkJPQSSTbgYEQ6CjTaMIna52TFhmbyaGH
	e/yCDjpPCkBMnx0fwgP1fsGscedlHfRkspfq3iv1MWbCESZlZtf++p9Wk84NV85yW8Q==
X-Gm-Gg: ASbGncsx8qXf/xGyA9/GwvDGOzcCey5bHWVhcA2q1j7ALEhsxeumxEJ1bNb+eTJ9Jm4
	6lVJyUVoMjoxW+mZIAawisCd0OyrMGhKFDnErRAYeUkSGA/9TqnwMPLUGQSVTxLPvqaOsrsm9gd
	IZXnTR2LQaEu98GqlYf+BPA69RKiw00yWmwuPxNZxXx3pIC5++Eo03784Zxu+ALnTEmZJceUTle
	nj0vEJkCIYXGNQoydL7L548DbAsl1pzOJu1sRAcWai9LpRNGS8/9OPUsOfg+WQglNWlwfwSVysY
	Ojmh/tb44sAJCdcNODGwxTrozEVNeKxlaLfzgZZQBHg0O4KTsav9oSQimCRc011WsMJ2DaELvp3
	2f6UxhRid
X-Received: by 2002:a05:600c:3d87:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46fa9a9ede8mr61532995e9.12.1760038020404;
        Thu, 09 Oct 2025 12:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq4yODAxz2pcaMx7a04UaAUODwZat3HOAUOtZRv5icQqy/NoE4KlujCgSLikJjIvHu8XTYew==
X-Received: by 2002:a05:600c:3d87:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46fa9a9ede8mr61532735e9.12.1760038019986;
        Thu, 09 Oct 2025 12:26:59 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm12434105e9.4.2025.10.09.12.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 12:26:59 -0700 (PDT)
Message-ID: <94851383-7496-4e98-acfb-a16cbfe7523b@redhat.com>
Date: Thu, 9 Oct 2025 21:26:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] x86/mm: Use pagetable_free()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-6-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250919054007.472493-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 07:40, Lu Baolu wrote:
> The kernel's memory management subsystem provides a dedicated interface,
> pagetable_free(), for freeing page table pages. Updates two call sites to
> use pagetable_free() instead of the lower-level __free_page() or
> free_pages(). This improves code consistency and clarity, and ensures the
> correct freeing mechanism is used.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


