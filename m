Return-Path: <linux-kernel+bounces-770836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD148B27F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2904B622399
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C02FC86D;
	Fri, 15 Aug 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzpN/hjP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550A23956A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258302; cv=none; b=QuGtJwLajXQo5Ll+nHjDoQ9+mv86ASC/RMVmu6XHZ1uxy0/7Xgd3Nl2fSHrkzcrdden7ruMg5lDdo0h6zwhTMO0KhVgVSPwYWsqe/jnPT0Tkh64F+pVH1hLWp7SVB6NkTN1GAMmeefFPKws3HRavaI3gr05YnkdSfnevYWBWZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258302; c=relaxed/simple;
	bh=hdys7JHtHWpJhsHJmaiNOaZ3mnS/PRE9lEfAg6d+ZL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJdmiXYsi7aPdS+deLGe7TV/gWf9VWjR8gPx2vZ7eQM32P13fNsaN4Ew7RgqCnR4xdpwgW5LP6rtEXJKoHirf9tXSksZk3NS1y6pAEHyXBazazOksPTrG2ELDjcB1UoOH4vUIPTLNJSfOAV5BEKSIIDLXeK4Y8+H8qx+I1b+MEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzpN/hjP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755258299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoWrtxZKHP46PuU52n+MBoU/cYPThUo0BkEpIvYfLjk=;
	b=TzpN/hjP9a2FWJIfws37n9FhLRX3y+OtT50PF28GE32e0vc62v6xCk/u/A0NvUnheohSAL
	vwPzBzy09o9fxkefJjorrkRMZyIx4SEeTQD++YIaqFWwJ53In8Z35cjGRrynzdBseZXx51
	YKi2Nvs7sebH3puGa+Q2iRaXO3+Kgwo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-iLgZ6lmvP0-bDmu1sols-Q-1; Fri, 15 Aug 2025 07:44:58 -0400
X-MC-Unique: iLgZ6lmvP0-bDmu1sols-Q-1
X-Mimecast-MFC-AGG-ID: iLgZ6lmvP0-bDmu1sols-Q_1755258297
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-333f9150cedso7617841fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755258297; x=1755863097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoWrtxZKHP46PuU52n+MBoU/cYPThUo0BkEpIvYfLjk=;
        b=MHyqrCYre0REY9pESFyVPZIFTYuax+JsAuZ2IjCSQe+oJbeSry8nxkqnoYpCOZ9ZJF
         ud6YSqUGI1+96A6dOmRD68r8iJliisj8WC/O4YYk9KXAo8Uu+D3pBSHK8bxAg7PPnn5z
         nGK76xTQp6v79xLGad20XSEYpXgYq1EmXGRoUpUDVA/0IneKbUqLoY2+rLbeyVfZSlWS
         2khaeqd7FFaiZPk0oH2fX2kcfUKzdtlTkKB30VLGhryWc/6Q30y57mGsbH2LSlztHHLL
         QrPexOagSx/2eTVQreBbg3mue4Yn+BrWFO2jYUMHyJ852ZI+1m5Y/h3QCUVLaCOUPezJ
         TDEA==
X-Gm-Message-State: AOJu0Yxk7t1PWbIPzd5zpEraqyoLnBGdqTre9Zsmm5uEYsQObmVAmk/z
	x4bkCmL2p3uZxS30WVWkJIHURN3fwqtaRkNJo68SzTq4Bs33mds+DN5Ds3r7TY4HLVC0DM9e8Oi
	LyCUJ4nnDh4x6b2t2m2IrHFX1lWZJfvBMMigynP2NzKP1HWg+wV8ULegSjSqW6y/L
X-Gm-Gg: ASbGncuD2wdwSda4rbYR+iIN0j1nT/ny2rQ8BrUIjMLfc/AuQpUvHp/O5ywt8Wyc0FT
	MMMDjvJeeRXSVcfdotfCHNI8SwX2A76wvL33LMvSFRRzVnif6aU+ojawH7sy3ATp494JHgNADi+
	+RUF6xBpfmdDibDdUvk6jrWyRtwfQMou7EczBp4bualEnFTpVuNzM1F9F13hlvz3JZ0l+m5NqBa
	lkllNhhwmupWALSE0BGIDp4DFuOt4u5d1tEh3GdaGv0QVbXJp+pO6QmtR9Fas7e0i79ZQkd4gOk
	Lizwp0YYq2wg+1HhHP/k1h4UnHxX8Ix+tlabX9Q/LdXkQDFYixkdIcRhH8dX3A8g+g==
X-Received: by 2002:a05:6512:3b96:b0:55c:e6be:d632 with SMTP id 2adb3069b0e04-55ceea3faebmr400610e87.1.1755258296827;
        Fri, 15 Aug 2025 04:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3D3NMqi0KpJZph6yZf3k5y3mxGkKOd0EHNuLEzJEbyBl6SKYpmYQlIaH9LALZ3KS2+RknGg==
X-Received: by 2002:a05:6512:3b96:b0:55c:e6be:d632 with SMTP id 2adb3069b0e04-55ceea3faebmr400602e87.1.1755258296301;
        Fri, 15 Aug 2025 04:44:56 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35fb71sm240902e87.53.2025.08.15.04.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 04:44:55 -0700 (PDT)
Message-ID: <c629f600-94c9-4cda-990c-83e429a2b9a1@redhat.com>
Date: Fri, 15 Aug 2025 14:44:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Migrate on fault for device pages
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <e57cfe5e-2031-422f-9c50-f5a03a467cb3@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <e57cfe5e-2031-422f-9c50-f5a03a467cb3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/15/25 14:36, Balbir Singh wrote:

> On 8/14/25 17:19, Mika Penttilä wrote:
>> As of this writing, the way device page faulting and migration
>> works is not optimal, if you want to do both fault handling
>> and migration at once.
>>
>> Being able to migrate not present pages (or pages mapped with incorrect
>> permissions, eg. COW) to the GPU requires doing either of the following
>> sequences:
>>
>> 1. hmm_range_fault() - fault in non-present pages with correct
>>    permissions,etc.
>> 2. migrate_vma_*() - migrate the pages
>>
>> Or:
>>
>> 1. migrate_vma_*() - migrate present pages
>> 2. If non-present pages detected by migrate_vma_*():
>>    a) call hmm_range_fault() to fault pages in
>>    b) call migrate_vma_*() again to migrate now present pages
>>
>> The problem with the first sequence is that you always have to do two
>> page walks even when most of the time the pages are present or zero page
>> mappings so the common case takes a performance hit.
>>
>> The second sequence is better for the common case, but far worse if
>> pages aren't present because now you have to walk the page tables three
>> times (once to find the page is not present, once so hmm_range_fault()
>> can find a non-present page to fault in and once again to setup the
>> migration). It also tricky to code correctly.
>>
>> We should be able to walk the page table once, faulting
>> pages in as required and replacing them with migration entries if
>> requested.
>>
> The use case makes sense to me, but isn't the sequence always going
> to be racy, by the time the pages are faulted in, there could be
> others that have been marked non-present or do you intend to lock
> all pages during this operation?
>
> Balbir

Yes the pages are "collected", so locked and ref taken as soon as faulted in.

--Mika

>


