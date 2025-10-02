Return-Path: <linux-kernel+bounces-840350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D35BB42C8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB133C647D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEEE311C37;
	Thu,  2 Oct 2025 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVuuoU/u"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5E1957FC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415677; cv=none; b=HuWVE86qvw+ca5g/oRhWbmfmLHLhQkgFrQhOaoKKmmwwFeuVeJUTbyNE9vpELnmlMHgOw5ey0rr/3a3PZpDSEBl3gQKfuct8J/Aw3J9oT1n1+uUs69+4jDeiS90pSm9YPDedbTwZ0dAM3lXO+od7OWEXb7qWZiiVt50sQF8CeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415677; c=relaxed/simple;
	bh=v29BTQVafWnVZr/eWe5e8dNUo9xboyHnzAK3KYBxvfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WOo5gaDn2cuic4U98pm41hLSfJcQmMrJ8yk6AoVK6bVBsH6QW3VI1S5XM38gwQ4wMgUa0pm2iPRYh0PdrrlYSTFaYj4ltHah5wOg5WPfF5r/Mnf+DXM2fJ/2moic2Vj0O8Oonbnsiz45OWXtbnZKZOagTHK9CWiYMtCXPbDmUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVuuoU/u; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b04a8ae1409so135813866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759415674; x=1760020474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccAYPxe52zBmW+CF4aFxuUujdoprfZQhiZMBpUVmHbM=;
        b=qVuuoU/uXkFC74/1Tyc2epMIZ8Lfw91dqXRzghGLqlKZTSw7F9mXLSQqtyWTsTt2PM
         I5VHc+wubwVLN5LN78E3Dc7ogbN9nK7uM0TOB4LPK/6vnGfDV/4R6Ns9WnEqALgqpENi
         elEXRZXADjCXNINtKY36qPaYAaAntRl9C01mm6EXUNpXYpI4vqgvOgYlKvIhDqRoPI8L
         s6LccjU5by+3WIn5AALB8/Gsq7nc/+SgxudnZKef5Nu2O5HUY+P/YhLf4C0SxUTQNk6d
         vOUEVje531ageJ4rYSpThmkp6OwGw9moLZQ6o4RDCmpHkOxjvUbhGnJrmvDK7ahPzrQU
         65eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759415674; x=1760020474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccAYPxe52zBmW+CF4aFxuUujdoprfZQhiZMBpUVmHbM=;
        b=lzC9eq5LQKfJTPfhLCXFmizALJVZ964mhUmC1OyTkM5eipkUSUsmSq+8eL6gTguF+z
         olBgWwQ9P5iFhiBLQiuSf58rhTO32X5/kIk6eZSWsU1PKxJnSSK6ZZYo3iKCFrcKnzGL
         ldeJDez1jB1sBvaSYQ/1hyfYAu6JXr9PH9GDkWAyPG4cHnouMN/611lHBGbnUlvAQkmA
         E6JB4lIDZIvMbsi2povy7luRFDIHh/+G9RtqGrrJ5Yn/CmQZ5o4AcQJZE0/kVRpufJQR
         eu8kzO4nuBvTRb6lHleiwRhpChbqJeVhCChO7jeTDJfQH06csjR9ns+EPF+AY6Cbtqkl
         9Rng==
X-Forwarded-Encrypted: i=1; AJvYcCXXFWRwNRCjXESIWAe7ukN7Xqu9dSU8jVU/M0yxqE72d7YrgfY4tUeRYGtsCi1FaPnxY0FtB3fTcs0w4wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvrRs2+hL140Hkr5qo68Qb1YixSWuS/67R2cLDTefp//kqzK/
	b32uDt7vcWjMFgTKlVmzBci+Kv+AbpavfJaYRMIJRCOxuWSbBNGKjxB6hhEFKc/ZBmcgYjt//hW
	gS+4Ybjj5dUsjTw==
X-Google-Smtp-Source: AGHT+IFdG6GPcaMbq+nXyD4vqbM1JFF0Ehtb9l8N4ZAbsP4Fg7J26kq4QoNXh1x8rjPxUFgXCopP4kBq7GBFoA==
X-Received: from ejbbn6.prod.google.com ([2002:a17:906:c0c6:b0:b41:568b:f49d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c14d:b0:b46:dbe3:e732 with SMTP id a640c23a62f3a-b46e8c7fe49mr988799866b.48.1759415673921;
 Thu, 02 Oct 2025 07:34:33 -0700 (PDT)
Date: Thu, 02 Oct 2025 14:34:33 +0000
In-Reply-To: <fb450443-07c3-438c-888f-30540935da15@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-6-2d861768041f@google.com> <fb450443-07c3-438c-888f-30540935da15@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD7WSY2PPABG.UK6GJ98WZS79@google.com>
Subject: Re: [PATCH 06/21] mm/page_alloc: add __GFP_SENSITIVE and always set it
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: <peterz@infradead.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<mingo@redhat.com>, <tglx@linutronix.de>, <akpm@linux-foundation.org>, 
	<david@redhat.com>, <derkling@google.com>, <junaids@google.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <reijiw@google.com>, 
	<rientjes@google.com>, <rppt@kernel.org>, <vbabka@suse.cz>, <x86@kernel.org>, 
	<yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 1, 2025 at 9:18 PM UTC, Dave Hansen wrote:
> On 9/24/25 07:59, Brendan Jackman wrote:
>> +#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
>> +#define ___GFP_SENSITIVE	BIT(___GFP_SENSITIVE_BIT)
>> +#else
>> +#define ___GFP_SENSITIVE 0
>> +#endif
>
> This is clearly one of the inflection points of the series.
>
> To go any farther with this approach, I think it's critical to get a few
> acks on this hunk specifically. Well, maybe not formal acked-by's, but
> at least _clear_ agreement from at least one of:
>
> 	MEMORY MANAGEMENT - PAGE ALLOCATOR
> 	M:      Andrew Morton <akpm@linux-foundation.org>
> 	M:      Vlastimil Babka <vbabka@suse.cz>
>
> ... or this approach is dead in the water.

Yep, I agree. This is where the chicken-and-egg thing I mentioned in [0]
comes into play though...

[0] https://lore.kernel.org/all/DD7SCRK2OJI9.1EJ9GSEH9FHW2@google.com/


