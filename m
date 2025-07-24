Return-Path: <linux-kernel+bounces-744990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3AFB11351
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0333B3200
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE923B628;
	Thu, 24 Jul 2025 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8ktJ0JY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017A21858A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394173; cv=none; b=sFEMwKDxQoPYenfcBDgfvEyW1MjtJHv2NrZb2smGoxXhEHdk3jnsIJpXZsPYqfuy+lI0v4TC5OxdCPamJNTplamzCRQrlJv8yImpH5VlsaGxrCEj8PtHoKYeR7yi30nWHLl+9v4XoTS9tv7krnCQv3n6pPu9u+O7VyIf7PwPhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394173; c=relaxed/simple;
	bh=OyEn0ZzcBisPvK2osjxic9KU0NnF2AY+3vL1co7kyf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUKLCc9LMO4opecmax+lNxoGwl3eD1ASLccZ8kwvkEyg49lgMRZdJhnmCGNsMJNVWqgp5b/LJrRFv49C0y29kndWopYKK6tN54uOtghPR1Hj+7YGljeBOlYmt++rqW3GnfuA7zA0CTD9krjCdqZVnhAPO+MDI9TyRgRXzs9Nr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8ktJ0JY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753394169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TnIYE6isHOtcopFB9zBfVfcEC5sN5etTBxSjFpgZalU=;
	b=O8ktJ0JY/n/CYiPMbATYyYbygUTzSk7rP/PNKs6IwiRRvVpNyH2QmF9xRrvfY5MReRnUdw
	jzWyx3ZuxoOFivr7o47MojcnVLnO7Z8rbb6FlpZxwkiL7BUr5UqxjVqT4ZKEoZ3MvK4opp
	m+dIj2hbl56/aq0GPcfVYA6qnGb1Cyg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-ODtjQcFdNKqR8r91Cp1HWQ-1; Thu, 24 Jul 2025 17:56:07 -0400
X-MC-Unique: ODtjQcFdNKqR8r91Cp1HWQ-1
X-Mimecast-MFC-AGG-ID: ODtjQcFdNKqR8r91Cp1HWQ_1753394166
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so506575f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394166; x=1753998966;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TnIYE6isHOtcopFB9zBfVfcEC5sN5etTBxSjFpgZalU=;
        b=uoWbRRzuUaSimAYKu5KJEXhPNl7mD0rUBvuCIBpGfkbWO7mjoO3HZD4hUFOiRZIzip
         1nhQD5vgRrTMnVvoXv4WveL/lBKizYPHFJpp+tKF7JBkBbsFx67rka/8+TA1TWt35r7w
         nl0RCl46u6rDkcexye0FQMxFyaDPcUaaid9biRth14vb+iuOBVhY03NujPaPaYVXU7FK
         zXAPnqCj20xNM9N4jYnyWvyfj0b7TrnwSSGUwwo0mmdvBthzQ+rnB3otTKqTyuZV5D+f
         BH5GxQNcspV2lGM3aidc7BNHgVU/8qxmXiAt5wZM7PpMU9Y5D0VPX4ZSPvWtAFqqcEHZ
         e1Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUtTGvfjKeJQKkIdE5uosASGSkQ65cRObnjKIlIXkLC1yrh3PfZW4DCum6mjEQ2T7sqJr2ofMnmtRgstvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySq0nYTmyztfD3fIQoveRtRtrdxSi91XhHuhLQnPR28DS/XyQ6
	fcQhOolcfPYSW3/AYil//e1fi7SOqs3WX/j2yuDqkNzGfP8dprWHSViLGT3eghnaidNwt/9l4oS
	Q6TUWtgN1vxaAC4OyffzWAiARnetia+8oy+wrLVVcX9RdYTnbYq22um77IJUlsLRtGg==
X-Gm-Gg: ASbGncsRUR/+qAvBW8FDLwxQrdKh+rW9wchBXB82XaWoSdopfvcBRA4Pkoap6AxLXIG
	a84F/m5+WrG6KSDkZVuTgiF/P08dg7IouI4iClRkSrQV5LcwodvWf6otPg/zgJA4TRMOoouEaEB
	mzSiZ/r8YSEPfuhnb3Qpk5v1MapmQVfZuJ0UyhjRspzp3Ra8u3qSfnbFKUlXf+bw3OtIpTO83WI
	aE+GTo4plmQWISTEow6bx1yXQEIhHbVyy3zhnM91PVqSJJ+9j9u5FFf3vP2T23SmQo7wUDrda8G
	jrvcNmKPqGobnjEV6JxJSu0lPYIHpglyvkAcQYD7yB2hr04ZiI1NVuYA8F88Y773s1kIayKEmKL
	d478kQNejA0JfYBgo7FMIod2bQFHA5h7xqCyzWcfH1BbguSidb28tgkYj5i5kH74eeTc=
X-Received: by 2002:a5d:5d07:0:b0:3b5:dc04:3f59 with SMTP id ffacd0b85a97d-3b768f162b3mr6550284f8f.37.1753394166452;
        Thu, 24 Jul 2025 14:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpj0Q/qfPPBHUfZgfVRBY+U0T8fmE6q5msKr2mfaAw9QwTWSOib0nfbwpWlSY/Dv9OPcQx1Q==
X-Received: by 2002:a5d:5d07:0:b0:3b5:dc04:3f59 with SMTP id ffacd0b85a97d-3b768f162b3mr6550278f8f.37.1753394166010;
        Thu, 24 Jul 2025 14:56:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f01:5500:ba83:3fd7:6836:62f6? (p200300d82f015500ba833fd7683662f6.dip0.t-ipconnect.de. [2003:d8:2f01:5500:ba83:3fd7:6836:62f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705e39b1sm31164285e9.34.2025.07.24.14.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:56:05 -0700 (PDT)
Message-ID: <85c4a092-14df-4478-811c-f3789610e4b8@redhat.com>
Date: Thu, 24 Jul 2025 23:56:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 21:13, Jann Horn wrote:
> If an anon page is mapped into userspace, its anon_vma must be alive,
> otherwise rmap walks can hit UAF.
> 
> There have been syzkaller reports a few months ago[1][2] of UAF in rmap
> walks that seems to indicate that there can be pages with elevated mapcount
> whose anon_vma has already been freed, but I think we never figured out
> what the cause is; and syzkaller only hit these UAFs when memory pressure
> randomly caused reclaim to rmap-walk the affected pages, so it of course
> didn't manage to create a reproducer.
> 
> Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages to
> hopefully catch such issues more reliably.
> 
> Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
> unlike the checks above, this one would otherwise be hard to write such
> that it completely compiles away in non-debug builds by itself, without
> looking extremely ugly.
> 
> [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
> [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   include/linux/rmap.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index c4f4903b1088..ba694c436f59 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -449,6 +449,19 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>   	default:
>   		VM_WARN_ON_ONCE(true);
>   	}
> +
> +	/*
> +	 * Anon folios must have an associated live anon_vma as long as they're
> +	 * mapped into userspace.
> +	 * Part of the purpose of the atomic_read() is to make KASAN check that
> +	 * the anon_vma is still alive.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {

1) You probably don't need the CONFIG_DEBUG_VM check: the 
VM_WARN_ON_FOLIO should make everything get optimized out ... right?

2) We have a folio here, so ... better

if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
	...
}

> +		unsigned long mapping = (unsigned long)folio->mapping;
> +		struct anon_vma *anon_vma = (void *)(mapping - PAGE_MAPPING_ANON);
> +
> +		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);
> +	}

In general,

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


