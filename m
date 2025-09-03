Return-Path: <linux-kernel+bounces-798013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8AFB41861
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC9680507
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8DD2E3AEA;
	Wed,  3 Sep 2025 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhXs/FjG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825F2E2846
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887975; cv=none; b=K+uJdRuqfRndPJ9K3CyLHm7ZFZJ68YWYJZubzSyhmpbUvRqml9gqjJIHrPgfsRC7c8YUiCAy7TmlCliVOk59yFN7+WrxG7kIgjozD4UxmaqDBYP6r8lhL4v8XnXwOW2/y/PWyCt8rOjpTprywdHjfbJYNo6qQDCUBsBRiu3bikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887975; c=relaxed/simple;
	bh=pk6iffNeZHd26fThASpLl7bnLtQuEW+CYAbvR3iEnVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gydBuqtEBkNRgIJNKzqToILNhAob386fsLpI3Vvk3XMoVzv4SiLtR0h0zDZDRNTwE6jQMq3WXF/n3NMkSvkopsl+Tk/C8nfdIDEFWkgavs8GszpwcxoN+tcfr/P1Anbd1VdpVJxU6L0/6k22QeCSS3VMvaonqjMJbCjdM9DA3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhXs/FjG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756887973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiF4X17MAgeDzab0iosntA9Q/n0cbzxTmlw2m/AGEGE=;
	b=RhXs/FjGzCq4vQ5tiYj2Kn+D9BIk/ovbNBJRBGjQqqOLZfE+AX7HgUk/P1faeOSzhb4Y+8
	rMJB0jssbVUIYqnCUFrjtaiF6ynpWpdj4JokJpQuZv0SEfi0o1FD8aLGWbexYg7aAuDKjs
	I+n5IqeuKh3rYMgFurqESvS5/It2XZw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-NJeRR6wuMGeuCV3E7Fk7Rw-1; Wed, 03 Sep 2025 04:26:11 -0400
X-MC-Unique: NJeRR6wuMGeuCV3E7Fk7Rw-1
X-Mimecast-MFC-AGG-ID: NJeRR6wuMGeuCV3E7Fk7Rw_1756887970
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55f6a61e239so3008941e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887970; x=1757492770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiF4X17MAgeDzab0iosntA9Q/n0cbzxTmlw2m/AGEGE=;
        b=X3DSjoizq2dwzSNivBrseqx3TD3fQ6bD3fnSDo84l0bG9r8ESXqrRQWkeKjR2YH77U
         C6sa2poJxyB6FOfDCfVq9Pa6rYij4ka7pAz0RuOkp3RbhBsQY55IxEErBdQ3ByMGfQJl
         YzfDZ95W/6bU+axzdkYLiJNEalLqFB+jE7W4LebCvAKEh0JGJyuNFwty/lDkP47SZ2RE
         D90nLxGwnSugs0laRLlxxdeJVp1o3ff6mU8wTBzbiz49NBLxBLGeiyWpquQSwIew/3Di
         s4X4LgF3tm55f6o5Ii7TzHO/w+wFfyB0chk0JqH3tei3wbAmZUKFkbohJCMKp1Ug93Pt
         htQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp100yKm/XbocIg2oqVBjZOfhESGxrt4X0WcXnqFStLI/wjdYkDEFSCbzx1Knb3SxSYjZRaEl1rPv6i1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMQGsNxJSr7AWduMN6pMiZyW3mMjXWKzaN+l3gXEpdMt2ATnw
	6cLQyhIGa5O3UiDOgeJ1N8lB4Br03WKRV/FGeGxI9wx7wBFVZaQTEZ+ar28SSg/EgYZXvsK1sWI
	XBOOiBZQw6uxux1gXE8pYPHXZ71seQKbtj2OBUaTjqkB7KBBpPUo1IFGMeLSwoih0
X-Gm-Gg: ASbGncs77456Y6G9QFRKu7mv5TxEk+kV+FB2oTCA7zbx+o04elyZgEdBtt++ObhiRab
	+XaCljcikKlTMIrrJik2Qnsmdv4lMI3UWwQOx1ZgawPlO9F4O9aGwFj0UQOl8VTHMOnZICUJ/iA
	gOYsbdYt6CIzGrm9NLlu0EorpHvhsfaxWN/CjZXuF0ZUnc9sBJvQBIw9PGVbu8R9CcMrk1+rScC
	MewJdV7UzwuewbDQBEWEdn/atgnMSlX0vCiRhAK7oOrrSFxMl9HdlnpP7J5x4bFHNADJnEGTFCA
	1Uxf+5XzLcsSk5D2TAn9OL7DScfMWDPqO8osqIJMNJjQDBv0AF0ybPfPC8zPWnJavw==
X-Received: by 2002:a05:6512:6401:b0:55f:4faa:b630 with SMTP id 2adb3069b0e04-55f708b9a35mr3755397e87.24.1756887970185;
        Wed, 03 Sep 2025 01:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/J8D+PycrrERqH27xh2tlYz9vfDI8vGXXWnNGFn0lTfvQ0eYEz+wc2QoktugLroVCaVR9Q==
X-Received: by 2002:a05:6512:6401:b0:55f:4faa:b630 with SMTP id 2adb3069b0e04-55f708b9a35mr3755384e87.24.1756887969707;
        Wed, 03 Sep 2025 01:26:09 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad525d1sm352909e87.139.2025.09.03.01.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:26:08 -0700 (PDT)
Message-ID: <ffac73b3-3c2f-402a-beb3-a98ba92c5335@redhat.com>
Date: Wed, 3 Sep 2025 11:26:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 05/15] mm/migrate_device: handle partially mapped folios
 during collection
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250903011900.3657435-1-balbirs@nvidia.com>
 <20250903011900.3657435-6-balbirs@nvidia.com>
 <ea6caec5-fd20-444c-b937-6cab61198c46@redhat.com>
 <6a178e78-9ccd-4845-b4ca-1e84f7d31b91@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <6a178e78-9ccd-4845-b4ca-1e84f7d31b91@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/3/25 09:05, Balbir Singh wrote:

> On 9/3/25 14:40, Mika Penttilä wrote:
>> Hi,
>>
>> On 9/3/25 04:18, Balbir Singh wrote:
>>
>>> Extend migrate_vma_collect_pmd() to handle partially mapped large
>>> folios that require splitting before migration can proceed.
>>>
>>> During PTE walk in the collection phase, if a large folio is only
>>> partially mapped in the migration range, it must be split to ensure
>>> the folio is correctly migrated.
>>>
> <snip>
>
>>> +
>>> +				/*
>>> +				 * The reason for finding pmd present with a
>>> +				 * large folio for the pte is partial unmaps.
>>> +				 * Split the folio now for the migration to be
>>> +				 * handled correctly
>>> +				 */
>> There are other reasons like vma splits for various reasons.
>>
> Yes, David had pointed that out as well, I meant to cleanup the comment change
> "The" to "One", I missed addressing it in the refactor, but easy to do

And of course now you split all mTHPs as well, which is different what we do today
(ignoring). Splitting might be the right thing to do, but maybe worth mentioning.

> Thanks,
> Balbir Singh
>
--Mika


