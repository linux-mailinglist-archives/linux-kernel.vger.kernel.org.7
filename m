Return-Path: <linux-kernel+bounces-854465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB166BDE743
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D37D3C1D43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E30C326D45;
	Wed, 15 Oct 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7kOLgJ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1431BCA9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530951; cv=none; b=JIhq7ro76SyX8ER+0vA7HU1OuBQ+Y/bkJY+UQTKkGq9pwtIhsKegSMTDMgI3ArTbLwUQ9m10bargbJ+UTA8dRR4t3WvCcfu0Q7ilhUrA4pGDK0E77YqXdpdGGmXxs8pOuJ4OKWJ1pWuSsy1WH0Vb2rZW8YaCXVicmyHLneartEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530951; c=relaxed/simple;
	bh=HArUhYMCM9Tf8f3tPf1TB3mr5PwlrGMvG0r2piocOsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ym8kTnta8pqitLha6jnLdA7/ycUbvrfyFltXKb06adkhRu9Goil/UodyaUSNq7pfSKC7Gq2a72zMafI+2KgxQIFUZUrJjvMaopBMQHkFzKhVJXMUGscPLL4dpsvLTizxOADukMN0a8ABy3VREOACArtDhcLWchtX86f9xUJ4HhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7kOLgJ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760530948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iJIT5ZHVJDyQvT7NeT43ejVvxQTOh2WUzsnVYFXK6u0=;
	b=I7kOLgJ3uy6M9Uxbdo7lAl+Yc19PkARfHHTV2KGlw4YZVyUJPPdJZy0LLJMcKRxVYg5U0k
	cuozfsLuFvX1FrQ2pFtr6WwF3ZB7Ta0rh7JscIddG/Q88tjtwwj0axircx1IXpqXsiFnjd
	FTw6idspE5Jgd+SscSzXBGvzDo2HlHs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-xHDiftS2Oba1wyJQZ2xzwQ-1; Wed, 15 Oct 2025 08:22:27 -0400
X-MC-Unique: xHDiftS2Oba1wyJQZ2xzwQ-1
X-Mimecast-MFC-AGG-ID: xHDiftS2Oba1wyJQZ2xzwQ_1760530946
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso45667855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760530946; x=1761135746;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJIT5ZHVJDyQvT7NeT43ejVvxQTOh2WUzsnVYFXK6u0=;
        b=jh+iAsTPWW1I3vPjC0t4q9OOhbojjxdp1M3NhGbnbVyublxTk535AFFSchAfy7DW8G
         lT6kfV543adyGia1pH6Tfb33r3bElIU4sUcN2tY8B19OTFjJEDxzB0GWkyTkIS6kSQ/X
         HBmWFlC+vAJMLPFwAaNDCirwobVUe1rjABc/qOM+do/HiqzvzI/ZEl3wYtYkLL2fHy9R
         mFvhz/3mlizjWs8T2ix4acIOY89FFKp36hUKi2oYZUALIiQOT4TIdzF+3gpIhdw5cpUY
         P7Bdbd5E/KKUgoIl60TUD8rJj8MsXFmV4RiAew/YT199VWkj4+/oNyKezq+e9XvzB8kr
         E1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWLj5sx52lZOuY0uW3+Abu79UeOGh9C63lmVZqvztYjtLHdRz8fTiJ6vnklyRjrFaDpUostaKOMCGfo0Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxTZTbs31cmYxVBkYzWhvqaGU0XZv4G8Co1MaiLINcsna4gBf
	6K0cir/7WbefTpIet2+hpbLWxAd2LuEGL4C0a/bI2kW5N9ZcEmvFSWGPE8gn+gdr9pv/tdRzmrC
	ZOJvn4clOUo2Q5MYLHXDM4aPTz7xaEG+bhLOxySn3Kk/MQB1ho8YTetfQQEN//0O3uA==
X-Gm-Gg: ASbGncsnyfRS5sA2B3qoUGxzsO9RerQuHQufFa2+IqfZe5f4trOVxEeWDiQECdLan7r
	Fzj4An0QJlvoVcjA2GHrtPahzbG4/PbmNaonD+V7CiZ9gkVcJy7CYSqNfy1bI7cQNIOXd7wphDb
	6ATqkxKl93rSV52ETs7VWT/uHyZfwkaUEru7ORrLNZtvVfIjS8DNUkg5i8NVrfWmJJL3H+KPHJc
	OWYDcQP/WOUMkYFSXxb+Sb8AGaWelo5c/pzuz8DzXY8hCVZxkn2fVicU9STKzvqUv1cayxeJWfn
	KU6qlI6CdjF0UOchruXT12eweZCi2+fAnaqNwCcjKuJbA3BQDgRJYjfPzkHhKVQ=
X-Received: by 2002:a05:600c:a47:b0:46e:45ff:5bdb with SMTP id 5b1f17b1804b1-46fb4816974mr150652935e9.8.1760530946269;
        Wed, 15 Oct 2025 05:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKC5+HlkfIgPUZjNMJXRAqxnI1C8MphzQ2ar4bKN3XqMc4aOndmUgQdYilOQE2UMODbf2nuw==
X-Received: by 2002:a05:600c:a47:b0:46e:45ff:5bdb with SMTP id 5b1f17b1804b1-46fb4816974mr150652675e9.8.1760530945875;
        Wed, 15 Oct 2025 05:22:25 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm29263452f8f.2.2025.10.15.05.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:22:25 -0700 (PDT)
Message-ID: <86ab6678-94a3-4150-8847-4fad00e09452@redhat.com>
Date: Wed, 15 Oct 2025 14:22:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251014151126.87589-1-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014151126.87589-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 17:11, Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> Changes since v1 [2]:
> - Use pmd_entry to walk page range
> - Use cond_resched inside pmd_entry()
> - walk_page_range returns page+folio
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> [2] https://lore.kernel.org/linux-mm/20251014055828.124522-1-pedrodemargomes@gmail.com/
> 

Can you also make sure to CC the reporter. So you might want to add

Reported-by: craftfever <craftfever@airmail.cc>
Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io

And if it was my suggestion

Suggested-by: David Hildenbrand <david@redhat.com>

Not sure if we want a Fixes: tag ... we could have created gigantic
VMAs with an anon VMA for like ever, so it would date back quite a bit.


Please make sure to thoroughly compile- and runtime-test your changes.

-- 
Cheers

David / dhildenb


