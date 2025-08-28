Return-Path: <linux-kernel+bounces-790725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52EB3AC50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F3618903B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F2340DAD;
	Thu, 28 Aug 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSEJAX4A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FB34165B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414809; cv=none; b=TIwry2w0HzyrYn1KHiq5E4Eko16/zkUxbeGjJWsXFc7HclY8IUu7AgecFB/eMWH+nCsHssnM84IlKpLVP72Hr2ayoerad5N9vOwYk+kpL5HiaF5CC5bDXupmGnfU4K6N1iZVyhppcSeHHZMe6YmiZK22x7c6FV8FZ70kUVV94P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414809; c=relaxed/simple;
	bh=so8wCnvzh5/RJGlIoT1pOsQtywx1s/axLfjCBz5t1yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVjd1n61Vb7855bDWDefoLDXw2VoYdxhaNGhpQAyw6lfSi9d5AIrpaGkmYu3mIA+jo23r9valiYCK5fh2CGzZiMzU7Ei1wKftvK2fTaQC4N/1cldopD54qvwlro8uVp4azB22NwXV7W+jZdzBA8XaKhg+f7MXcFAb16Wuu21eAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSEJAX4A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756414807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mkSDgbg7xWQW+ISMkJybRnH1oyxatG6U4F5HRgnHqwM=;
	b=RSEJAX4AXFKpHERtAYZsABeuGcifT0TuUocHBtbAoc6hOJHtJQHkXNM7JCJzNO01/wKf0d
	7xwqApY9g8lipMPt3IBY+2XOUjgT6NGpDNeBACqdAgm2Ut/azC1YmDPsyQk91v/nQ+IboK
	z/7KZzGYPpiOxu4cw58LXigrtglvd/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-nbqB8LjENWGdhOsYwCeW4A-1; Thu, 28 Aug 2025 17:00:04 -0400
X-MC-Unique: nbqB8LjENWGdhOsYwCeW4A-1
X-Mimecast-MFC-AGG-ID: nbqB8LjENWGdhOsYwCeW4A_1756414803
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cf48ec9fc1so78711f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414803; x=1757019603;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkSDgbg7xWQW+ISMkJybRnH1oyxatG6U4F5HRgnHqwM=;
        b=tAOEJgpLJqIZq7rJK/qnqkp3wIElrS+fBoQ9hBwdrCmPJNuBzsVoVEBiK6sJdqdnRe
         t3qVeOfOYL3z7i3adgLZum4cwELKEYnxGx7HRtGhJH5uPuZaU6Fht4Y0AgYJkx+69LJX
         s0krudHCauN/q9NaHQRImkJFxEHEUhquQqCvGybBt1Wvj0DG+E7ecpesmT8ltQ3sFM3H
         /UeZ/QUEtbDFS6wf3pX2L9Ji7Td5XbvZyOk1H1FB0GdpVPOcT/6qGjfI0ivnopCbcYV5
         KQe6AEsSA/ZpW9vrPB+tXeJQanDMB2ncKkpWGl5Mdc1ty420rpDvXRHsOfouhg2M3Q+M
         dx3A==
X-Forwarded-Encrypted: i=1; AJvYcCVGIS6iVKp6cE6YWssJZrNbmY020FK1//y4XwByYxWkSsHjhEutErzQLWYELJziaehxRoyyPgQi7fSxUvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xoG43iz/kZ3saKfYefa1YeZivZi7kzGWeZAMMmVamVUQxU9y
	gVWech474rMgQSnhm71Ke31v3l0VYIZ38ueJohRCoqQv7UGYmiQGbYS7oC3ze/24WxCNUl1oun6
	JI3iMsZlvu3bV866R0X90N2G8EZl+0daKx4WEwco7vpnIdEC97baXwpqXdwL60g2m5w==
X-Gm-Gg: ASbGncsi55eC1vSTeBMdSnv434rGAK28Hr3UFbCJVfulV6VZAc5qcNmHs82lOadPN6R
	MDPlxtTF5p8qasz1jH2Int/QaWBnaIOsQeNixIk2Peziill1QobEzEnekS8yg9uQhHvdmLN0Jo7
	2KLWKpEBzBUMg+TwqTHWDhno38LHBId0ZV4xzpKotwV04EU/GCg093/kEfdxYCUR5DmdEVEDusj
	bq1rkWWvfxGrUDuZMDGqfdXJmloppGrY5tC1eGtHcZ1V6uILJgptYdCenn1Ib3tmN7KBG/d3sH1
	gb6cvMhJ1AnD1ZMvu5WuKwH53xt6nuBeixvGL4Dnwy2I8tq6QCW3wJ1OXMoHHo15KX4rQRLPeIk
	fLJrYV3xJhXwSUWONETEJT9heBKeX9gvXavrpr3USx4jd9e3+noFGwuQKhVQWGt0HqYM=
X-Received: by 2002:a05:6000:2512:b0:3c9:3f46:70eb with SMTP id ffacd0b85a97d-3c93f467c6amr12443215f8f.52.1756414803102;
        Thu, 28 Aug 2025 14:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6weiB8uQZLlY/pBc/wBfkqXIMndGWCy+/j+66w0gqGxnhnpdmegVfF1S2/N2OWbRnBL2yuQ==
X-Received: by 2002:a05:6000:2512:b0:3c9:3f46:70eb with SMTP id ffacd0b85a97d-3c93f467c6amr12443198f8f.52.1756414802646;
        Thu, 28 Aug 2025 14:00:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9c4sm613412f8f.48.2025.08.28.14.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 14:00:02 -0700 (PDT)
Message-ID: <7ef927d8-190d-4b22-8ec7-dcb9f5f75dba@redhat.com>
Date: Thu, 28 Aug 2025 23:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] mm: introduce AS_NO_DIRECT_MAP
To: "Roy, Patrick" <roypat@amazon.co.uk>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "tabba@google.com" <tabba@google.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek"
 <derekmn@amazon.com>
References: <20250828093902.2719-1-roypat@amazon.co.uk>
 <20250828093902.2719-4-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250828093902.2719-4-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 11:39, Roy, Patrick wrote:
> Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
> set to not present . Currently, mappings that match this description are
> secretmem mappings (memfd_secret()). Later, some guest_memfd
> configurations will also fall into this category.
> 
> Reject this new type of mappings in all locations that currently reject
> secretmem mappings, on the assumption that if secretmem mappings are
> rejected somewhere, it is precisely because of an inability to deal with
> folios without direct map entries, and then make memfd_secret() use
> AS_NO_DIRECT_MAP on its address_space to drop its special
> vma_is_secretmem()/secretmem_mapping() checks.
> 
> This drops a optimization in gup_fast_folio_allowed() where
> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
> by default"), so the secretmem check did not actually end up elided in
> most cases anymore anyway.
> 
> Use a new flag instead of overloading AS_INACCESSIBLE (which is already
> set by guest_memfd) because not all guest_memfd mappings will end up
> being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
> can be mapped to userspace should also be GUP-able, and generally not
> have restrictions on who can access it).
> 
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
[...]

> +static inline bool vma_is_no_direct_map(const struct vm_area_struct *vma)
> +{
> +	return vma->vm_file && mapping_no_direct_map(vma->vm_file->f_mapping);
> +}
> +

"vma_is_no_direct_map" reads a bit weird.

"vma_has_no_direct_map" or "vma_no_direct_mapping" might be better.

With the comment Mike and Fuad raised, this LGTM.


-- 
Cheers

David / dhildenb


