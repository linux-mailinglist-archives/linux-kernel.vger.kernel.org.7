Return-Path: <linux-kernel+bounces-788845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E4B38AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB04B6846C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E72EE61C;
	Wed, 27 Aug 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtzPvnbM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD272EA477
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326601; cv=none; b=W8bZiXATPryGQ0tGIh6mpdlwmRD0pmHYYO5fsCNbEbnoTNu4X8EZp9wck3UKM5Gpku5XMn+bRN1Lg0EZdtAgXjwPigbu8lhAOBCHeiBG4gywa1ldfkPJ1aMObZWmYREiH+o08pCxxGg0QgvUNmig4Pgg3l/m3jdzH0G46mR+YBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326601; c=relaxed/simple;
	bh=3WZpp71n5x4YKcKUBW25iOsmt4LK+4vP3KC4Ae2BWAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0Wy9thjJz7sW7BPy3qZ+LDURFXaDqovkTjugX8mZOGrRLpZKzrfYDxJs9337LSrDxj2ttETF6JWrviNmG5GbPGsUl/5Zok1Ip2+rNHHc3JdSmzOO0IxTj/I4A8Vxr4eHAdUrfimGbj9DR3mD2dABOdBnBHtGd6s85Dk0Pysb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtzPvnbM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756326599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PzokQis5ZL6qsKctP4Xs3z1Gldk6SHQ/UBTYZ2qmTrY=;
	b=NtzPvnbMV12Oqak9U+IsqIDeG8jPTcmWhxMabJLV627fs8RTQMPH7awTa9d7UL46Ce7xkH
	lk6aKmXJBtLHAsHJ0D7U9ErgWsV4j4TyuLtw/vJkcBTuWzr137arcwL0ekuIpTDA7hOhkg
	MWyKFCyrtr+qrQsyhY9eksSbkTUUZ/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-b_MLJRR3MaKqFMMFyOYvDA-1; Wed, 27 Aug 2025 16:29:56 -0400
X-MC-Unique: b_MLJRR3MaKqFMMFyOYvDA-1
X-Mimecast-MFC-AGG-ID: b_MLJRR3MaKqFMMFyOYvDA_1756326595
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b612dbc28so1343195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756326595; x=1756931395;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzokQis5ZL6qsKctP4Xs3z1Gldk6SHQ/UBTYZ2qmTrY=;
        b=q996xvkLt5UUUxQer0Te6xfEpARarw9XkuaDG4mW08nXE8Y3VpnzC/laEfOUWRrRx8
         WLFUe4B81yL2A3FIce7eiqdO3SU8cLG2PsA13mKbpHwI5H04PbHE6cURY7LQegBQIroW
         9omHCplWo6nd3heWwR4MWnoaAf7h35MZCjierXop9exYaw0BJJtRXRDH8aSGPcplUWtP
         kuIysyYCQ4sByc3lbK40MRiytb0O52JzuwPpedc3iAq9Z/70PJtumzvytwqBOz+xfOz0
         R8ecCTO2pZ/p6D/ps1dLP3SxlhI3vM/7uRuZcwB6Vg/3VJvvxQSogtPsOpQ20fZjf3h3
         cqcg==
X-Forwarded-Encrypted: i=1; AJvYcCXtnSGuVfT054qKd01akC+R6rLZuDX+0yHe4sAAKXz5h1uOmbWmCpznk6Fud3yH3V01n+JqtVwKtheZV/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHuWlYe5Se1Xc6VGewScQ1vGhVYDPAzYAl5SE4q3WRe5jxaAD
	ILrRhyB6nueUBCE3784z+DGrrU0No/6Ug+aivqmlDL/sGREph0SP7tENAG+LTF6pjlcMh1sZW5p
	9i+X0fQWc75PelNlYDjw3EjFh/X11B9Sh38/dJoakUaN7tFLMfkalgTodWbpzkfIi4g==
X-Gm-Gg: ASbGnctkSYxrfIE7+069TCmgm6qwioMUzNI9hIYlR++jDRnYC2Xq2D8GfT9ncGKRDOv
	5R9A4zao01rZGYWPMxSdT+WPmk2GHTAb3V2Opn28gWYvdKBho6zJ75famfbQtUNRbQwBpz/YAJM
	vm/BJkNy/1tbppG3O5FF7n9dBxJxO1UsszNfrHA2KX4du81mQ4HVonVVz6gfLZYeGi27RYhme10
	FrRsCK3eNqa7XC2P6N/jLXaN7j8C4G09tqr3ywvYhf+/AM13mmxxoBLeUFE+6eT6eDIccGeXoCy
	m/Kpu3XGeTRFWvPnB+2amuhtb+teXLY6fZECfyqawrn7GVJsaXVnLXAk7CjkYWb1t9KbNmubuld
	1oflIZOIYl3YE2ih1RjFA6n8sohPBdwoknqRoSwzX79uopCmWkHEO1P32lNVHOtTsT0U=
X-Received: by 2002:a05:600c:c87:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-45b5179ebb2mr190291995e9.12.1756326595158;
        Wed, 27 Aug 2025 13:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRZbz0F38PgQXgnCEw95o1suaGM69HCqab1SOSSbvnFH7ZiXZ+shWII8MvVCiecn8ZaBeb2g==
X-Received: by 2002:a05:600c:c87:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-45b5179ebb2mr190291705e9.12.1756326594730;
        Wed, 27 Aug 2025 13:29:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:d000:d4e1:a22e:7d95:bb63? (p200300d82f1fd000d4e1a22e7d95bb63.dip0.t-ipconnect.de. [2003:d8:2f1f:d000:d4e1:a22e:7d95:bb63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b79799c81sm1683715e9.4.2025.08.27.13.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 13:29:54 -0700 (PDT)
Message-ID: <5cdd07b4-f924-4207-a8cf-09b4fc26d3d7@redhat.com>
Date: Wed, 27 Aug 2025 22:29:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 07/11] mm/thp: add split during migration support
To: Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
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
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250812024036.690064-1-balbirs@nvidia.com>
 <20250812024036.690064-8-balbirs@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250812024036.690064-8-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 04:40, Balbir Singh wrote:
> Support splitting pages during THP zone device migration as needed.
> The common case that arises is that after setup, during migrate
> the destination might not be able to allocate MIGRATE_PFN_COMPOUND
> pages.
> 
> Add a new routine migrate_vma_split_pages() to support the splitting
> of already isolated pages. The pages being migrated are already unmapped
> and marked for migration during setup (via unmap). folio_split() and
> __split_unmapped_folio() take additional isolated arguments, to avoid
> unmapping and remaping these pages and unlocking/putting the folio.

No detailed review, just a high-level comment: please take better care 
of crafting your patch subjects.

This should probably be

mm/migrate_device: support splitting device folios during migration

-- 
Cheers

David / dhildenb


