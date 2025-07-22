Return-Path: <linux-kernel+bounces-741462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67390B0E469
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243DA1C86682
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1E5284B3B;
	Tue, 22 Jul 2025 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtwS9TSo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100E280CC9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213995; cv=none; b=so7h9vcxZzZC/ayINENavPQIBxM5Ajsu8CXONreGQ9ZMagyC/2+rMuDFArPfmswx7RYEqd/s2U7leIZE+bwEIziGMckV3N3G3VBZWgnmxGuvFDijfzB3uXpi00DD+ue4xxUG1g5ZQh6cvuwb/UNHlmJLCSSv1hm5bHEebrtyJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213995; c=relaxed/simple;
	bh=Ko//QsIzqaoxvloKDcHNOSVDdwSx38ncEFR9vg3f0Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MinPqbCeq6UuHzCreBCx8LgUCdx4vDidUU1t0AtZMI2mQp2ymtU7qR2a2hp3V+166/TKcJcJF0xE0GnM1b+pveIYhfqpNkG0Eyvs0PU0yiKvB0pr5F+VbQ+a6lt2IlROwQl/O1ha2SIRRVdzSyoPfFxGRqkQwJVcjyawhubCMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtwS9TSo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753213992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TdWjMJJ2t2kjmQGDaZjJdxIytGVnbPWFviDNWJnQ46o=;
	b=WtwS9TSoZU3JxSLlatV7UdASP4fuGbZoM0CA58vVb4vvZ8BTWHgwoDUu60dtZBvoWljbVE
	s1Hr84b45mgAsxo76vxgueqGXWzCfuJTgNGaDmboxXlGajWRrkXWrBdpOZl6o+Dnya0T7s
	U5xjtxaIm1cth6CA4CF5j5sXu+eh078=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-kHtPHUk3OyuJN-B8s_UgRg-1; Tue, 22 Jul 2025 15:53:11 -0400
X-MC-Unique: kHtPHUk3OyuJN-B8s_UgRg-1
X-Mimecast-MFC-AGG-ID: kHtPHUk3OyuJN-B8s_UgRg_1753213990
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso1359465e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213990; x=1753818790;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TdWjMJJ2t2kjmQGDaZjJdxIytGVnbPWFviDNWJnQ46o=;
        b=Z6ePpagfX3n4KPIFVTLwuay1fI2nj++T1fKYJGJd4FOQXMyqMSwbxk04eM+BtxXB7B
         mdD+rA54zWnV/78S8TFNU0mdCORNq0u67Jly+rHCNjfb1uhASduryG6KM42zhAESeQwA
         qafKmDJMaDfuOpNkPH4tV0DWKDkrCZA77crtbSejgxOCUkO6AbGuFmT5O3E0gNiYDq18
         poldSYwC+X7D9KjYQ54LnrekFNLTzCOEIg3lZKTinTQ+1Cxcp9b2SqiDIanAvTXLNZom
         F3dsI0gpbfCWYebsBIi9YKwXkzT4XXYyZO6+rrJ8zWNUzFEUQrKmYiXa+ZhWLU+BY8GN
         x2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWdiE1ccWm/R3j70N86D99HeBJeZNzHcLqJk8WyL8lOEonz2mS6JD3h7UNu/gEhYgrTkSnUxubkHDXCMIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfTdlpFi2gHIN0V4EWpwrBvGZDfs+J5sY3VJHTyJfw5YnOdGZ
	fNRL5VlC8/R/sGvmlYVMbTCFftKfAYGZSyw2xc7dul1UfFMVkeo+w9mYVZ2CeSuehbLNnz04RK3
	DV4CI9Y3yXx8O1Mit2LI9SZM0LJZeXsAvwjyeBaV9Ucil1t62aMjj93Yq+n6+nmvb7g==
X-Gm-Gg: ASbGncuFTNYl5eaTgQzXIXtYMU0Mchp6FayyoAG29I0rkguNi9ibFb1L1vVYo+9g5xl
	lONNcEiuvNxdCowIBRnKvNMIsiGaq6tLSqdscgvGFOwl88W1syCCZRRlJYJj1emZckfWSU+1E+L
	Y3/gBl2cinco8XF5Frvk8bU7lWrM0BI9uqGop2ncs6J23y0dfgvJZw9uwFt23OqjLQACHrpGKSW
	JgMvv1yuujnFKOEjdDR8UaC5AWJgY5QzTt4fLzBxVwM3Nzb7th2U5HLIQfP9pC91raHFdK9ZCSg
	BeGRIHadun9OGXdzlZgvijb/2+v5sIuzrEYhh3zY4rrbWztH6lgH5uvSsgiXl0VzCY30lzvsW1i
	siG+VZl/KIv0e887uFZkERdLShbl6dn/NpzPokdUOSX+3rALHynLpqToSd92HTLxOjN4=
X-Received: by 2002:a05:600c:5024:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-45868b0d92amr1431355e9.6.1753213989690;
        Tue, 22 Jul 2025 12:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsLOFOwTTLmBWwHiT96TIfOP+di28wWAJf4G5/QX+/wKgzO9fEejkJpG8dI/c4Tq3iZBLNfQ==
X-Received: by 2002:a05:600c:5024:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-45868b0d92amr1431125e9.6.1753213989183;
        Tue, 22 Jul 2025 12:53:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45863a131aasm22793985e9.2.2025.07.22.12.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:53:08 -0700 (PDT)
Message-ID: <24f6b0a3-68f0-472c-a4de-6776997c3eab@redhat.com>
Date: Tue, 22 Jul 2025 21:53:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add missing files to page alloc section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
References: <20250722174143.147143-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250722174143.147143-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 19:41, Lorenzo Stoakes wrote:
> There are a couple of mm/-specific header files that were accidentally
> missed previously, and some page ref debug code also that ought to live
> here.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


