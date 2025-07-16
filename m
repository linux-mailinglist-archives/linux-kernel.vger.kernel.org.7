Return-Path: <linux-kernel+bounces-734058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DAB07C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FC31AA1409
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137C293C55;
	Wed, 16 Jul 2025 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Duva0Wdt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3610942
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752689671; cv=none; b=P88C1M2BYXij6Dzw4z8zLLnIpSxQJC5HIFr2W0g5YggBcddFtzyidbcF59qr2kJp0JgX6F+aU7A72krEdj0QpXhcybgy6m3S5g2/hP5YGS2KCl9MaKLgO1wgHC+T40/u4UR/P3KCgigvqBN9KvXnJqCSkTiqW30K/vGijDH+57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752689671; c=relaxed/simple;
	bh=MqEofIQv8M9UR8lOG8zC25gnBVa/a87wplkavVk2apI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sw0DWil8g7jh05zI1+/C6/Z15QMFnN0gCZ3h9pq7/GidSM1Yaghaaiob6EAgn3psPlZkRw9wmT0qyrIGTv802IA7srRNENbUCOXlloZz3mQfRCusugzZgZwCCPh0BvUoE9bSWmLyLKQzrzPRmieslcraCOQe1XeHMNyWJyQ4OrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Duva0Wdt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752689668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJlXYqPs7Pq3VOCFDHYdUl1qPeHQCNweMrgKcwXRJ1g=;
	b=Duva0WdtUuUrPcR0BmQKtYtslIpdq2W2+9lsdmW21+Kp9NH8anzbrX/XCk/MiD1NPEgwVi
	tmCLW35XoVtuKlVkFjXbVrMXiFnBxubVTavAeYxwv57048GnsJqGTBGFZz5/Ku86erFO7m
	nZetGop1AXPX3Ue4e1zbSP59+eDvN+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-OBFE1fa0PS2uqBB2qzBpRQ-1; Wed, 16 Jul 2025 14:14:27 -0400
X-MC-Unique: OBFE1fa0PS2uqBB2qzBpRQ-1
X-Mimecast-MFC-AGG-ID: OBFE1fa0PS2uqBB2qzBpRQ_1752689666
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so47018f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752689666; x=1753294466;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YJlXYqPs7Pq3VOCFDHYdUl1qPeHQCNweMrgKcwXRJ1g=;
        b=XPeLfM8z3G8f5pKAK5NihX1ikRC1xHok/AmZuydeYxlKzVD8pfTD57/idio3/zkijc
         L0qCbR0XdnW9Ld9xS+MFzmDhq0JxRWpPzR8MSSNyhGrBt2qtZjUi1LmkzPgnfXEihogl
         yd6Bae5GPUZ10HVEGEtFB3ogQJ6cPPH2X9zAtrBHiTY6ReR2oU5C+3X+UJ//sQ9zzBlJ
         7EeNJWKd3cSPXxsLT/SgQkcUIhamaTZ3DLe0ZBiGHUUvq9kwcZTjcw/dTUTfn/I91kG6
         3o4inqidB4GGXG0quVMD6djIS1wWQIUXb+kMlR97jZgwzaUFQjzbx3LHdcRelT/kzLTk
         ZMTg==
X-Forwarded-Encrypted: i=1; AJvYcCVV9dtmPidhxoxf3AMJ45iDKBPWujACEltfY9swjJeJbaXDSQ8EDCCWEE7Z+HtvgoiD/G8bWKX6MveOH1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQpTJNjofmiRbSJMxj+DCwFaTqlc65vYWsPT6o/IqgH+8xRNq
	mcO4I9VBgwpkMQizgROxr5hXzOW2XkY7bXQSKZk7U2rzUe9sNscOF45VQD/vgb0mygtMX4GlvI6
	/r17gm9n/O5VGLMMQBj+ifSX2tdJiv/ubH6k7md3KSIl0lSh7w5wm5y1A4iB5FujG/A==
X-Gm-Gg: ASbGncv1IGnmUT6ixot7qnCbDwtCkQFSzm3d6eUY8AnkRFOTlKjjGZw/CVKgQKj1N6F
	aQzTagK3YMOafwhg3G4vENVV50BKUiQmxXGzsEHfMrPEDbFN0P3l3Ab2sXU+VIyUyc6XRz4ndib
	z4/PZ9z3GoFHeRRZH4iBB9uRNKmKpMDgOsY4/X0NE7weaQwyj3oMhumk3ymKq569n+S0BEHf0ke
	/RRrce2dN8eZvMthNTH0JkC5DZb6KCZvr2rqXOjSy19UwPcDoY660NuCKTjEesxhhIIfRQa6SSf
	8wWtgZm0o0a2RGup/saqHIRzUYN5M6x0zraIKujf8ifO28+HaMus8QNugYraoF8Fy0sB5nuykt3
	1ovVXscqSTkN8TMGmJguYX4jOkMM5F/p1J5Mp19IPiF0utjOvRIwA5W7sh9w8FZy/PhM=
X-Received: by 2002:a05:6000:1449:b0:3b3:9cc4:6830 with SMTP id ffacd0b85a97d-3b613ea3ce3mr59775f8f.48.1752689666244;
        Wed, 16 Jul 2025 11:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs53CY8fblnEWr7zu7Fa4O92Dr33AAcDtGHdHy2XlF5+DFKJIkWdqEP/4mlPgF6zQ41dQPzg==
X-Received: by 2002:a05:6000:1449:b0:3b3:9cc4:6830 with SMTP id ffacd0b85a97d-3b613ea3ce3mr59751f8f.48.1752689665812;
        Wed, 16 Jul 2025 11:14:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9268sm18434096f8f.41.2025.07.16.11.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 11:14:25 -0700 (PDT)
Message-ID: <76d80492-e85a-4948-8c25-3885be23ca7f@redhat.com>
Date: Wed, 16 Jul 2025 20:14:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250716171112.3666150-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250716171112.3666150-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 19:11, Zi Yan wrote:
> Smatch/coverity checkers report NULL mapping referencing issues[1][2][3]
> every time the code is modified, because they do not understand that
> mapping cannot be NULL when a folio is in page cache in the code.
> Refactor the code to make it explicit.
> 
> No functional change is intended.
> 
> [1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f4f@stanley.mountain/
> [2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb642@suswa.mountain/
> [3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mandelbit.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


