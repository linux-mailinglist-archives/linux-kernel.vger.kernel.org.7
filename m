Return-Path: <linux-kernel+bounces-745499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3DB11ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E79D16FC83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7932D1913;
	Fri, 25 Jul 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvSvaNlV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBB2046A9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435570; cv=none; b=BbTMYM+CNZy5HD7+tqdvzIA+scIxEkiZBET2k2gogT6vuz1kuALYqUGywP/389Bd+ze0UPHvIFOlWMWu32d7FJNzidLZKEDF2NW8Xr+bRlS23MtG3oiZbMTtEiqEU8SqyJYKxzW0Ex6HBT6zs6FOpHqBRc0SIGweuuutVfYzSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435570; c=relaxed/simple;
	bh=XNUkW1t5gkksaGBQ25FVnq++OttsdFoLIxmIhp1sxCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uaeii1/etguoRZicApWd7eqeN7PDJqMwj1twPWfzJMyju3b/LrIAeWB8NScaIvbf6dNlOQo8BEt9/80n3O608wzKULGFM2BuZ/NPkELoIIYuJ4sGjt5JLSW/X6QUEuKDwtgNWg8zpz7X/bAM27TkdAiafLm+S5vfwYYSXVRRFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvSvaNlV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753435567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fuI+073QUV8TlKCpgSMthUFjEGfbNKhBcsktNU/kgXA=;
	b=PvSvaNlVrlYpM2qZQF97vQ10KQFdZ5p9X2G1qercd80mdj8uadvzyGWLgOojchortZ7Wqz
	m56k8bk89+jkHkJzYVmnu8QRhdyF34PQOZTcziigqH/KmMU0lbKqadSn2YgUfAaRIXRTFW
	NBHWWJJz1NRZm1M18e6xZhl6mQT2r4Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-jPXkdyFfP6OmuCglSeEW1Q-1; Fri, 25 Jul 2025 05:26:05 -0400
X-MC-Unique: jPXkdyFfP6OmuCglSeEW1Q-1
X-Mimecast-MFC-AGG-ID: jPXkdyFfP6OmuCglSeEW1Q_1753435564
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso15040365e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435564; x=1754040364;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fuI+073QUV8TlKCpgSMthUFjEGfbNKhBcsktNU/kgXA=;
        b=QSfYLnhWXYa9psyB91b6t5PCMPWkIpLE5euDjieQILY6eAyq13q1eDnQ5wai9VR21D
         gX5l5m78OCRk8yQmdIWk4u2wJrENc1RzEbCvrw1oYBkYHt0V31I0DVMACxphfVhEG3u6
         3fQy5/YWDQhqLGtTqt93diI3ncGsk626SC6VceQOhGNlf/caut7X4+ubLdniiFDWqWvq
         gHM1OmEZotGoaiAquj66fZJQDOd7HY/nCMgEhRfyS8+ItVuBAaxGpTwE4S8Gpnpm2p0N
         Q8C1OnlwSCPPA6Ir/xBgjAylnQ5u9b/awZOQrfahU7itTsqM1gZ98tP89T2enKyb0U9K
         w1/w==
X-Forwarded-Encrypted: i=1; AJvYcCW8ofjTL9ixRVGHEifo9kqcTXIsw16A9f5ubxDYj+nKun3iPMcQ3njdkrdg8qEN4NuWL6++9JhKHFlIs6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6Jh8+iDFd8/k+P7eKbMQtaZ4DQUSkhQlDc5VeqrQjB6pG9ws
	Luf9fRztKZ08Mj+YKrIgFU3t4dC7DyHt7rQLXKQJAtZ+Xc5PILFJzu6zZzslcXbyF3w34CNSLVr
	rixQLaT5XGC3rDQIOwcr7udJEpePCfkT29rwGRY4l3R/V/eVPzM3q5CHk4rdk5IQ20g==
X-Gm-Gg: ASbGncvOGHfTBqvKgdezK3TEKUv/FOJquc2gustcOXGIzH9H+tPW90z/axyBH2gGhFb
	neLfYJ4xIkLMpx7jm2w/WRqQMmER4iqggSoxbLG0OoewE2/cPlCc3YBxeZsAFf5UEgjTPeJpkM0
	O49CKCkaVY9XCriCZoLalUgagQI6RPJYBx9n9ApYYvSSQCQQ/dfdSIy6NiH/QnJo0mYwLsCxO2Q
	RrmjzploWt9jJoY9zEyh5OQRSwGDcXVQNmANYcLbwl0vZV8+q0DI1ERoWRLLbyNX4kgijlRTPRU
	yl2TJ5jymhJjjE3BtUDpRfizRAgFAr8yqmg+1CZv0X+dHz+IkPiRA1mKXkMyLihIkOKeTX3hR1y
	JGimhEaDJzkZf9wc5+cjTjvxoIH7c8YDP2OiDtzK6yg8ahJtYIyEFGP6KZFsWjT51mDg=
X-Received: by 2002:a05:600c:358f:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-458786425d8mr3020875e9.6.1753435563936;
        Fri, 25 Jul 2025 02:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUt8YTfMy82kRyiKTD2nVMnZutqe5uKLRf5ukn85wELhiNYgYKzUj+SU3x+/UmHhtqJQUj7A==
X-Received: by 2002:a05:600c:358f:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-458786425d8mr3020605e9.6.1753435563442;
        Fri, 25 Jul 2025 02:26:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1? (p200300d82f1af4005a9fb1bf4bb399b1.dip0.t-ipconnect.de. [2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870532baesm47811275e9.1.2025.07.25.02.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:26:02 -0700 (PDT)
Message-ID: <f09131ed-6546-47f3-aaa6-73962f117300@redhat.com>
Date: Fri, 25 Jul 2025 11:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
To: Huan Yang <link@vivo.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Yu Zhao <yuzhao@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724084441.380404-1-link@vivo.com>
 <764c48ad-8869-4f69-898e-0a1c58684f7d@lucifer.local>
 <40cb7d64-0b90-4561-8e10-06a808a2766a@vivo.com>
 <87bjp93vb6.fsf@DESKTOP-5N7EMDA>
 <9a0eade4-8981-4379-8260-e673a1803d56@vivo.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <9a0eade4-8981-4379-8260-e673a1803d56@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> If you cannot prove that the optimization has some practical effect,
>> it's hard to persuade others for increased complexity.
> 
> To be honest, this patch stems from an issue I noticed during code review.
> 
> When this patchset was completed, I did put in some effort to find its
> benefits, and it was only
> 
> under such an exaggeratedly constructed test scenario that the effect
> could be demonstrated. :(

I mean, thanks for looking into that and trying to find a way to improve 
it. :)


That VMA walk is the real problem, stopping earlier is just an 
optimization that works in some cases. I guess on average it will 
improve things, although probably really hard to quantify in reality.

I think tracking the #migration entries might be a very good debugging tool.

A cleaner and more reliably solution regarding what you tried to 
implement would be able to

(a) track it in a separate counter, at the time we establish/remove a 
migration entry, not once the mapcount is already 0. With "struct folio" 
getting allocated separately in the future this could maybe be feasible 
(and putting it under a config knob).

(b) doing it also for large folios as well


(b) might be tricky with migration entries being used for THP splits, 
but probable it could be special-cased somehow, I am sure.


-- 
Cheers,

David / dhildenb


