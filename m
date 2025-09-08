Return-Path: <linux-kernel+bounces-806735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D1B49B22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6295E170B13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297442DA77D;
	Mon,  8 Sep 2025 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbAtJhy5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F682277CA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363624; cv=none; b=PzbbkLJ+tDK9zTen1GFQJbBHo9twAu6CtZ0iygKMgU/PsPG+m2Dc+iRsFEjoTIwGJTOH2eSn3pKBJI7kmijdbUGxYCWJCXMPIrsjZbANpMAZbTlsAhuLQLjQ72MVdotshBPAAbuTJMkXzyeMpERscvH7RzTWnwp343y2hUXW94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363624; c=relaxed/simple;
	bh=3sTc+qXaLOHGeLgl27T1DhIBpeJuOmTKIGmpv8cu4tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hByfhpYydUxKVZiBxKaGinlhdOQOwPukozOtZTOdXTTLJzI3rFh8arircGlZostSisADJeJILH5I6GuSzN51I6KqZo/ux73/q1f84C+fhBf6waFI/Neo0USgkdLle/20Jgjs/fQSkLOsKLJFHQDqfu9EHlKGvlK4MeioXiYMXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbAtJhy5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757363622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cHPqwmnHSstA5stVCqP66sCY4AX/amrBThkXwUSdq4A=;
	b=AbAtJhy5uVYtqmz7l+sBEmhDoAJq0r490W3oGrXP+PhzkLbOh+ar2hwpP8M6EJu0FFwWN3
	4Bi/lD9dcAjm9yax4L4kTBqzFcDzWVfrRmqugiN9k1TTFYs6wFtBgZP0Wlwpb5Xtb0/J+G
	wXfw9aNk7drciHnVYEX8qSXSJtUOn0A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-sM6YB0XAOFuWMe28WwsK-A-1; Mon, 08 Sep 2025 16:33:40 -0400
X-MC-Unique: sM6YB0XAOFuWMe28WwsK-A-1
X-Mimecast-MFC-AGG-ID: sM6YB0XAOFuWMe28WwsK-A_1757363619
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so37938405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757363619; x=1757968419;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHPqwmnHSstA5stVCqP66sCY4AX/amrBThkXwUSdq4A=;
        b=hXdR4IJchF74na7dTCGtjR07Ctv9vAOPxNnjTVn2LjLIYySd8u90SEZ3vlJXIVxvyd
         xiJGegnkZdoc+L+UhNGYHVFreLO8sOBxWvek0YRgATDfm7rf912RNwTdwHvh/mBBE8re
         VvW8/2Xylb5rX7HSqtqMraSMh0qyIX1l4YJHqnGV7CIrkNm+OxoNwmeoQ0cbd5fce+Tt
         VHmWz9jHCM2PI0VB8Nj7MB+TUotKgkuXmVERj5o5NoCv5X41Hqm1Cwid8dq1nTD3Pobw
         BOCR1bfo/JHVrPYxTKJOhffQX111TofY6ZoCrCNFii6GGYwdHN2+fTDrTroKe5fZCnjX
         NShg==
X-Forwarded-Encrypted: i=1; AJvYcCXrwOq0TrDo6ZJyxKAci/FUcfpa8WNGkmh9KFciwSsS/uIvU6JP5HK4UcVVMCxaX9m3Ki++P8XDHD9JNV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7urZgyl54eaObbvlKdK5/ehm9hTrcCGl3haYCXqmvO/oG7++X
	pRgKgz2syzB9ws/4BlD5FpC9IK/0B48FVikqzW81Gvsyyg9oV8J/UQgeWxHMPIY5pfctiKrZh32
	+uJqVIB2xP3mY4pF5F0f6T4k/SkhtVKEcXxTB5NrYyBIQtaOs1NFW/PMfvbYF2TVczA==
X-Gm-Gg: ASbGncu/ot5H/Jh/89pTnQ2THghnpZqXLK1CMJAThmPqfVMCgf0cnIWGuNq49HOCTLL
	vHeSd5Er8QqHv/e11RppeZya+AmyJia/Qcm73erzvglOsOcP+S5iJJdtf1lcAwbJCQ0fTW7Thxa
	fOvBKqf6T5z8v1vTdkXTHO2UZrnA0Ltz9KhtkWibXC2o019ZGIq8JcaIibLGm59767DKbK1AHIZ
	anhMr3DVYm13DBCpLBhX9qm+FA9jG3jul5R8cv3zk3QZMRh5S9uH2WilxPsEC7l7DVoO9TPzAGS
	AzDTDapgEmPgC6qyz4IdEqlTiJdSmXk9fYaEwdlq8fl1Bfj7VFk5LqfxgX2WHxICwYtKAZw=
X-Received: by 2002:a05:600c:1d16:b0:45c:b56c:4194 with SMTP id 5b1f17b1804b1-45ddde8984amr78758645e9.2.1757363619483;
        Mon, 08 Sep 2025 13:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHojw/7zMS8q1nBZVWmxulh/3tuG5nzWGKxu9Rz7LjIUliDj5x4LVgR4QAaf7xyXOYsL8WMnw==
X-Received: by 2002:a05:600c:1d16:b0:45c:b56c:4194 with SMTP id 5b1f17b1804b1-45ddde8984amr78758485e9.2.1757363619114;
        Mon, 08 Sep 2025 13:33:39 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ae98.dip0.t-ipconnect.de. [87.161.174.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcc2f54sm96042895e9.2.2025.09.08.13.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 13:33:38 -0700 (PDT)
Message-ID: <57a2bd9f-cc05-442a-93ab-0b1e4eb5c6e7@redhat.com>
Date: Mon, 8 Sep 2025 22:33:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Jann Horn as rmap reviewer
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250908194959.820913-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908194959.820913-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 21:49, Lorenzo Stoakes wrote:
> Jann has been an excellent contributor in all areas of memory management,
> and has demonstrated great expertise in the reverse mapping.
> 
> It's therefore appropriate for him to become a reviewer.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
> I spoke to Jann off-list and he kindly agreed to become rmap reviewer :)

Nice!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


