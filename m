Return-Path: <linux-kernel+bounces-678811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A21AD2E60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AFA1713ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 07:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8A28134A;
	Tue, 10 Jun 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0AaChWa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6C27F4D9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539331; cv=none; b=g6LYND3W49J+ng1Sc+yRwsfrLYzPETUdxKGP4wfMD1r0PudoCkPrUBPAA8TvQ2eI/1NzHWM6IqpIUBHfGBCylZwhopkOO/S0DZ+UlhfEDegvPMmaLzxAUG+xI/gQqJVrmHkf5mLtknE+CE4k3HFeNx0tFY9V8cHX2dudxDn7khs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539331; c=relaxed/simple;
	bh=xQbvZeSHM3RYolBkpBXRlfe+LIYFbtOOpWq3KIdjhBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJPNT6jYXnIUV4c2xeGtFeeBaszgZVXxiCCvfV5MY4WjvypwrwbBoDaiDz9E85sUiX6dX3F6ie0JCKQyUsyWczsKfDoXGYwsX/O7gT44JcHasMUTG80DgSyulR6yI+ojwm70MMs3ykoOOY8Bm80+w94CsVUaHC0RovYJuyoKs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0AaChWa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749539329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ImRFJ6RQNPV9ZNjqCgZezRqNBaCjAqbJZCKLHufBnCU=;
	b=M0AaChWaRGgK5PAXC1CLdW/Fa1Pl1EjG2yU02sinn+f5v0oTbe41GDVkFNwHMIQPfYB4u1
	PpgzqbLPXPHsHolTRuc5ots1aVDyQEbvGsPECa8uXyDTV6WVzWxt9kgpj8N2X8+9LD6zLg
	eQmMuFmR/2dj0zsReWYIm1r2bZCgtKE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-kYgPUAbaPf2HXPck5ra-XQ-1; Tue, 10 Jun 2025 03:08:47 -0400
X-MC-Unique: kYgPUAbaPf2HXPck5ra-XQ-1
X-Mimecast-MFC-AGG-ID: kYgPUAbaPf2HXPck5ra-XQ_1749539327
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a503f28b09so2426670f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 00:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749539327; x=1750144127;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ImRFJ6RQNPV9ZNjqCgZezRqNBaCjAqbJZCKLHufBnCU=;
        b=UCIbgtbQA0KYZecpU38lwsY45kYp505fBIjkK/s9BXDzUgntb0HgqOMxuqw7ob5Nd0
         SD/An42wG69Jr5nwhOZQlxNf3UseWDLpYLAkUveYQwuLreqJPiBwFvkeniLcKg/NyD8n
         kuWKk3enIAl/EaDxx+KFgs9uMtS7AKada72LUGOyqH34Vr0sx9WCoEmHJW5bdf/5xWRc
         WxWEMsMqDgEUdkzmICqcXM/J2n99InEUk4e9UGPbi5rCjqu2NYZ6NmwubbO8j7A4eG4z
         lAEJ2EpwXSGu8+plXDco6XTROQywjc+Fj8VX9IFfcyioU/AKMiMdvOOljULf29/GC41J
         eiaQ==
X-Gm-Message-State: AOJu0YwKfIQvWCiQeBeXhiotswVjiuIdwWO15UbXy70Qwm6s/sW/TNHL
	/4p4JeeO+3UZlh2OuwHIQSW3XHASKI4ruEbc3WWCrVttZZajvI/ZnpAjanwXBOHCsiOQQjn+SXO
	ixTpTrkJxMM/P6Eo2/K60oPc7QnICPv79+lfW3WhvKYLTdWl3hOuMgvPhvWBEIiDoCw==
X-Gm-Gg: ASbGncsJtEuy5cVlJk8+TmWBj0Fo9taik93o6/SmQ8OyYMl455XMZGOpapB9EIzAbms
	kxWXGHQwStev6mpVVFoOGw4ZymED5Ted1hX8wyFGlByio7aSz9UbFJLukkcl4jiycxOYMN5DBCN
	xq6gJrUfQj7Ck39vTPzjFOU5kpqmakJTa/j3Y7vPHb9Z4frJPFFPajj4PhfqCn9AwLRg5hxwtwm
	QceshWspwKk9/UAsEULvocHMJKdb5O26Ps3osqA/q1Woiosrp/y7T8YSJdMjWTjb515Y3SUPAAd
	4iK6NB4h2h7PQcZ+zEO3qmbO2kZg56AkvkmcVy0RfNgMtrafRQ6gKpw=
X-Received: by 2002:a05:6000:2913:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3a5513e84acmr1912716f8f.12.1749539326746;
        Tue, 10 Jun 2025 00:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIidhT8xnBe+V+l9qRFpn0YRfhyqfVV09ZweuAJbnpcj3sGCBd6dndn6LzPSTR9fheoc6sXQ==
X-Received: by 2002:a05:6000:2913:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3a5513e84acmr1912691f8f.12.1749539326355;
        Tue, 10 Jun 2025 00:08:46 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e056138sm133067405e9.5.2025.06.10.00.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 00:08:45 -0700 (PDT)
Message-ID: <398d49f6-00c8-4bd8-ba30-62cbf0efee46@redhat.com>
Date: Tue, 10 Jun 2025 09:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
To: Shivank Garg <shivankg@amd.com>, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org
References: <20250609170806.447302-2-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250609170806.447302-2-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.06.25 19:08, Shivank Garg wrote:
> Replace open-coded folio reference count calculations with the
> folio_expected_ref_count() helper to improve code maintainability
> and reduce duplication.
> 
> No functional changes intended.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   kernel/events/uprobes.c | 5 +++--
>   mm/memfd.c              | 4 ++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4c965ba77f9f..c978c8c27340 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -434,10 +434,11 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
>   	/*
>   	 * When unregistering, we may only zap a PTE if uffd is disabled and
>   	 * there are no unexpected folio references ...
> +	 * Expected refs: mappings + swapcache.
> +	 * We hold one additional reference (+1).
>   	 */
>   	if (is_register || userfaultfd_missing(vma) ||
> -	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
> -	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
> +	    (folio_ref_count(folio) != folio_expected_ref_count(folio) + 1))
>   		goto remap;
>   

With the comment removed (the caller holds a reference from GUP) or 
simplified ("Caller holds an additional folio reference.")

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


