Return-Path: <linux-kernel+bounces-763108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D37FB21053
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D9B500184
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303F311C37;
	Mon, 11 Aug 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ssqf59N1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17313311C31
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925573; cv=none; b=WCN0M8hSVpKbpPqm6T5FQFKqLykCR0goY/+q/oErAXQcC+pxu8DAuRfJXyEmC1n4mVotWG0RNJSU3p/K5UBESN99LcE4tRNXmDIG0D9ffKC2JY+usizNGMV3dnnBHsh957QDNpYPuPWeVgANvttTzX13HAHS4sz4qMfb1iRHqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925573; c=relaxed/simple;
	bh=ZE0ZB1gwerJKhHCVZKWW0QK/GvBh44dZ7Ti0ixZDbVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4qkI+XlSTOMuRdy89N9dRi3dkIXZuooQ/E7C5LuGfu3MwjnBWhnmAbxYniZ+DhIzAvfq5Nbf9JceKRLYxtIFpzOpl0vI2oO4KIa/Rl2bnm88xGGb7pfMHRnE2UCvKpm5BFa77LZZhd7MFbd1W6bEU9eaLc6vrfiZ4dSbC1IeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ssqf59N1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754925571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U4rMKr5yqLMBPEtbuZGwA+jfkHDQ63mNAqigiwiYs6s=;
	b=Ssqf59N1vLTu1VjglSW6UOqNW8FbWkUcE1UvkPW7Xuxwb381RdDhHgJbEj80HjJKPrn3Dy
	1mMCSR3qWagR/rsYCLuyI8cz+V2Wim8MmQT4s4NYRgWebtXki4iCVlONkK2pgK+POKPdQa
	caInvT8XBaOrQo1Z3Rd8wrNyXm9c+8g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-c8X3ykUgNM2_ADclc-kD7w-1; Mon, 11 Aug 2025 11:19:29 -0400
X-MC-Unique: c8X3ykUgNM2_ADclc-kD7w-1
X-Mimecast-MFC-AGG-ID: c8X3ykUgNM2_ADclc-kD7w_1754925569
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7851a096fso3237611f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925568; x=1755530368;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4rMKr5yqLMBPEtbuZGwA+jfkHDQ63mNAqigiwiYs6s=;
        b=gTB/1jXxpT362sVc5Gxd47uZ1q4xvnufdjTjC83ka8jOFeKl5oGQDGBIt6a8PE6wPl
         QUfFudXNs6WYKPwV8BAe4z85LtwyMapBGZ58xhZVnPWUKQo+06Djt/Y22GD5LVA9wf6n
         j33vNDOm+u7o1R27PeI8o4u85hpgnaRJ1iELdN3nAIxGbIFW8Dr7JBanMxK4buDqpAhp
         j4SsmPG7Qn4+aw3I1nmVel0a5S2UDvsjppxjpwLb6zo2tH/SXpte5mjJcGNh5YzSjlWb
         P/JOc84Qe+l1Uphb60GktRZE0JVMYzJOZyP/dfsQbMvPTyh7VkZqdr08lqLebb4cVR5u
         I3LA==
X-Forwarded-Encrypted: i=1; AJvYcCWEnOFKi9Y1nsB9nEFzeZtrMkLVXvNk+kOBoHCHrNAowG+UKMYA03rq8nxJn5E43zlaFD3d4AYhe5hvbQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQG2gUjF7C/4j65LlvqT9KtQ9lL2aYAOYn5xK303c0rXK1CO+v
	swFuM4FrL5IYnjrm/cNrUxdXO659s2D8TMHShOHvQbEbDoYSNq0crQOJUQahRBNRkexEfIEkHWm
	KnyJEWtsxpo6okdGegwffUsBGFQz2wkJe088wSxTd4zFjvWg7EboyxxM68ZkF0Sp8tw==
X-Gm-Gg: ASbGncuHhp8UlZ9FXAJVlsOgdxL66eNWFkbnZgGw40ES8Dv+v3d5LF8vAW3WJMlqhUH
	nd9aoh6V6F2KbxBx7SMROLlxaA2SHNQv0M25VGCZ7fSb8LvKVVbMW6NU6HuQQ/4pln+fNInNnmm
	VI1SCs2clMNhCrWKrDdQV6Psz3q8ESNaFsMXG0nZa/d8ALUO7k/2zlHZSE0hJc9cjXtQOH72oRd
	FpXVAoxWyamYd1lZZ1WFzZmhFkXDchzNxgGrkpwA1tljSbKhxb17hzJmn9afet4sKk1Ac2qwPM8
	YtRdnb4WPYmgPWHZE7PyT4AFpPphdQYqR9sBZ+eKw7/ZcD5TlM1jqUdp6YnCJ9OkS0Y7CwxP15D
	TSzdH+Jweum/Lz29u5zT2Aslnku3i12xpa3QynbrdCB8jwc2SGI8721qYRiiHeWRBX/I=
X-Received: by 2002:a05:6000:26cd:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b910fdb7b4mr108589f8f.3.1754925568679;
        Mon, 11 Aug 2025 08:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlqejcEdMvgiK2RYwo1jOG2sniAVxTOTKJkporZZgppdpArjBWuTEEn/dhIFXsBoJSphIeVw==
X-Received: by 2002:a05:6000:26cd:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b910fdb7b4mr108564f8f.3.1754925568267;
        Mon, 11 Aug 2025 08:19:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e584302csm279863205e9.7.2025.08.11.08.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 08:19:27 -0700 (PDT)
Message-ID: <dbd8c326-8848-486f-8789-3528dea2bb28@redhat.com>
Date: Mon, 11 Aug 2025 17:19:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <CAGsJ_4zuEcgg7U0yCMu6ayKqRPACtvuzUsC9vUxBk2PgMzaf_Q@mail.gmail.com>
 <47ce3db2-38ad-4a6b-917a-c6300fc39543@lucifer.local>
 <CAGsJ_4w_c3AY1Nw7EhYH3rf0jjqgZ6AYLdr3xuonF9SNgWckDg@mail.gmail.com>
 <0babf2ec-040f-4f7b-aa76-f59e80274333@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <0babf2ec-040f-4f7b-aa76-f59e80274333@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>
>> Unless the previous contpte_try_unfold() was very costly and removing it yielded
>> a significant improvement, it’s difficult to see how the benefits would outweigh
>> the drawbacks of vm_normal_folio(). Does this imply that there was already a
>> regression in mremap() caused by contpte_try_unfold() before?
>> And that Dev’s patch is essentially a fix for this regression on arm64?

Fix/regression might be the wrong words here IMHO, but yes, this code 
was not playing nicely with automatic cont-pte folding/unfolding , and 
now it's optimized for that.

-- 
Cheers,

David / dhildenb


