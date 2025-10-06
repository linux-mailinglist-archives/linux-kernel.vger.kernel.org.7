Return-Path: <linux-kernel+bounces-842700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4690BBD531
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0D01894737
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF125A357;
	Mon,  6 Oct 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNFdBaGQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2C25D540
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738812; cv=none; b=eDzSDgnYT3zUSvAlmA51lGz6UCqMQXDkvuMaohEqvGZ5jG/oOTfqG+DArD+i7Oub/RcGj+/8H0uZu0urjVz+whcAxeyCJe5MGeHHX/ENY4KopVhesNGWPNSruVaPl2f8pFG+2aSYlYQCG7NfHcZtzrXj3QZZYtAHvh+aT2smIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738812; c=relaxed/simple;
	bh=IQpsYo7lxZER6wZgaZHTlAFv56STsKGc7DFuUVDD2+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrUGy0GX7IlIZZMkH1En6XlSgxK6mOseDu1qk/hGV85D/qPEJ41g36QhM31QhXoub7ilmP/A3CZXfdSvirbJM6PMHZ2ZlALhGhU7mRr3Fkp727nPI9AMjMFKfijR8VVh4Sw+h+8mj6ewU7Z55IMje03J6W9s+TxnROKj17Bw+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNFdBaGQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SNWbwJVOYd0DTW7b9TuxnJLCSZ5L6JONscYQCHG9VH4=;
	b=UNFdBaGQBH3DRDcUK9bKvbPxyIpt81/6zZ3/a3gxBq6R00ZtV5CnGekG0tSU0pBBUUypuF
	E/MJaRlC+dr8HM13jK9phTn0QjaSue9RcDENqVqd31u9oSjynDEkYvRSR7KFLTruX5BUtT
	abLhUp413zsvWJYrxXyqzYEVAbKc9JQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-udMDlgfCO0KYg9r57guHrA-1; Mon, 06 Oct 2025 04:20:07 -0400
X-MC-Unique: udMDlgfCO0KYg9r57guHrA-1
X-Mimecast-MFC-AGG-ID: udMDlgfCO0KYg9r57guHrA_1759738806
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e38957979so16696305e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738806; x=1760343606;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNWbwJVOYd0DTW7b9TuxnJLCSZ5L6JONscYQCHG9VH4=;
        b=LZt+g9TQKNzp8bv+1INlw+QCyl8VqSySOsp6Hx/m6N6zQs8UBvMk/Ruxdiaoqdz3/E
         qsWQSzjf7scyT+ztkQKLh0+JsSCBcq7IYKLqBLE8+LMQVx0leFUUXeuM+VJhPUMBdRPI
         dCKk8tKIciJInyMXNhWiYTGTwej0GGPqVjs17Yfm/fNOKhu+vVuPNdvALVUdBGEyZym9
         LDV+sY1JVTsbWV/k0athCPXbPDukvQ+Iub3nMVSbtfmIRX236fw+DsUSkfktNCgtYDIK
         qV18m7KrFbfde3+WVKVj8jTUkbXGr87VXh4NMVzt7IeacK3FYkcTCvzaw9v6YSnaPPAA
         5HaA==
X-Forwarded-Encrypted: i=1; AJvYcCXA/KOus8Un2iupFuQHj8Js8SHH6fwei2u4BNl0Xdfz8v21T8ZEdBOngBITs8UNs/DrbCf8YcLrxOMNcZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/c7Sc/Nk7gb1yrB+vXxAWQn1fbl4cUVATHkQm9C9eHgtW+zV4
	a1LXpMYviBWlsggnkfsUlwLsk2zSPXKKIH48PrBsKAp5aFo1c+Z3/MoUBJ7VtFgVi2zjW5O85VK
	PfjsN2p3EXOxxW7UE8ipxVekAKfu8XgXS3qOoQZ52Ws+Irf7xiYaB7f7fwrAFJOagRw==
X-Gm-Gg: ASbGncvLsTjqF1h4MuCpI4FNmSlDf1dRXJTosoFVKKltM1Np/dCqOkE/Uxxzv+FeC7s
	UDp33zCAW3GDNaGXCeV0ntK7+clJv3Mh/3BOOcFXASKcf3IVwX12EN5Qglr0J69LJRsTm4NnciN
	MIQdMCUmKqWCoQ9UeYygTL38KhiK7w6DaW0mBA95rNQN1mnogJR5kmwJ1aZBoE9meotUXyD/aKU
	rKaitafn0Ja582sxHeGop2V5Av6CkoaSZY0InrvbZ7xHQ0NeldoIIMN+O6Jpa7luycchWJ7asam
	XuyipvyoStPzuJDMcg3JQK7bNrfRoaSTwMJSatxSuL5qbFIRLp1bGqVDzryc89IVmXwLkQjrrAM
	um37UAbA8
X-Received: by 2002:a05:600c:34cc:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e7113f7a4mr99635735e9.17.1759738806045;
        Mon, 06 Oct 2025 01:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZGMW4G0SvfowBsrSVBanCS1k+6aA94DXgDYJc9v/1gFNyYsZQC5pbzAfDOzMb6sJmk9iJJA==
X-Received: by 2002:a05:600c:34cc:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e7113f7a4mr99635405e9.17.1759738805597;
        Mon, 06 Oct 2025 01:20:05 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm239387935e9.5.2025.10.06.01.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:20:05 -0700 (PDT)
Message-ID: <d398bcf6-30f2-44a8-9721-1c4c763951b6@redhat.com>
Date: Mon, 6 Oct 2025 10:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Consistently use current->mm in
 mm_get_unmapped_area()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251003155306.2147572-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251003155306.2147572-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.10.25 17:53, Ryan Roberts wrote:
> mm_get_unmapped_area() is a wrapper around arch_get_unmapped_area() /
> arch_get_unmapped_area_topdown(), both of which search current->mm for
> some free space. Neither take an mm_struct - they implicitly operate on
> current->mm.
> 
> But the wrapper takes an mm_struct and uses it to decide whether to
> search bottom up or top down. All callers pass in current->mm for this,
> so everything is working consistently. But it feels like an accident
> waiting to happen; eventually someone will call that function with a
> different mm, expecting to find free space in it, but what gets returned
> is free space in the current mm.
> 
> So let's simplify by removing the parameter and have the wrapper use
> current->mm to decide which end to start at. Now everything is
> consistent and self-documenting.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Yeah, that looks better to me.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


