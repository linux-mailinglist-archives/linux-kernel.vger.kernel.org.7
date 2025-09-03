Return-Path: <linux-kernel+bounces-797810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9AEB4159F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8D75402E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA22D879E;
	Wed,  3 Sep 2025 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9YEJPnO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E952D780A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882401; cv=none; b=t/sY9rYSlMFAmi0ONx+BC1uYlPKRygkSAcUsX+QM3MYwWGH4h9S+5Qp/XePL/ZzKbMTmjZIbPb7YuLgiSFe4azLPFXdzOJc6Ka8AThFvqOBMXYIm9+Q1Xu64vRm59s0PE+f4xqJDY9cwrOWEOEnAxvlk0Ioo3wNHL6zsIrCVU/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882401; c=relaxed/simple;
	bh=lecccFrNNfNidfxZtJJPrlf4MNn/Ek9m3mWoVrhT0E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXuD1qGnoynGjOfsE5eT4evimuAfQVRAhVYOsP+EdNjbZdkGPxKpB86NFJs/uveJRJjNLoeV5gFYiOakHWGFdi5FQN++U2iEbK/2ZWAplE6ZlW4sPV/Ydgmet9s5hrHzf8GhCKKpWMgR0cZNS7HTJdS8U7Yn2fCWFrKmTThwgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9YEJPnO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756882397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=70bJBQTFcg/ajHsnAIc5tswapUZv32i6/YxcawPABPs=;
	b=g9YEJPnOh47CeBUS10+dhKD24kLzHk91rpJtOs8/KmpW6DtG36Mol9x8BdpPkLNp8P78Ey
	wboAKUJCou3ffOPUyAJOustjOmM8Nnhrlzk3sOdUuYA4qTUloURYMvxQTsxrMPiRceY2qi
	qty3hzIdlkCgHWW9bhFIRWnLtbSvZUc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-FSspGuhRMtO9u21Q7dlaGw-1; Wed, 03 Sep 2025 02:53:16 -0400
X-MC-Unique: FSspGuhRMtO9u21Q7dlaGw-1
X-Mimecast-MFC-AGG-ID: FSspGuhRMtO9u21Q7dlaGw_1756882395
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so2924048f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882395; x=1757487195;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70bJBQTFcg/ajHsnAIc5tswapUZv32i6/YxcawPABPs=;
        b=VkUXTL6pGhuSKcgKcDLgwdCFkim1MYAwLXzUaKdjaR2DpyE2vfpc8wBBWfMdWvVbnE
         PSfukgIV0vBgJB78qBx8FfE1R9l7kVvvQKatnGco9a0SM0bc6oAKOlDdZXU3Clx/JAwG
         iVX8aBe2wL/+Y7SYe4l779TWHv3eat8KlOjslNoxfntD+Gj8uI3WHQi8puXIkv5mcIPi
         Btk8e21RiOA59/pOtbeHyY1EjHcYQVnQo6XCcg5SEb8NsdgBiSMhWmEib9kbe5AJYKEF
         LCI2fwpftZnIEEfDSwp86QamMCUBLclXMPyx/eshpTLUK49EqCdu+ELXFXyuZGfwuYOs
         eB3A==
X-Forwarded-Encrypted: i=1; AJvYcCVUEWIYLX4a1VoBak8T+5k2GhNy0J2xxUVnkx1iTkf87BPABtdlL3BSf4SEWcIyGqEv+sf25yseSgPXloI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyekpLB8moeToqZwPppqA0/oZnQNo0bcwt6cGabB8Axlz3NQBR9
	b0PfIAe4IUOC3qKPBlj5Qz+PdBjvHUr3p0kL/+/FQ4mXxMlIurJoCKBuiwM0Bl4UqDFLYAJhqPV
	ObkJ+l8K5WKIz8/FaZJgThgRrhUQkwFWR1PWLr970QzOwsgWi/UVy+TCC06hRnItfgQ==
X-Gm-Gg: ASbGncsiZCKYh/SC517EwXdBj2H3KlwIhbAhT+PcSYOjwop1CEmmeSqQKJas4FiJG8Y
	G3IuZGTE76pyMKwM+Lp34LQP0U0I8geWUzMPT3Z/Ks/07sdA2iM2aMgV3D6TzljdM4PxvzgnUH4
	90svm0XDhvRe51Ayd6SFG/r+oDqofR9pOr43KEQte6tNESu2Fuxe4ZcQeV9bYt3JEE2+zj7q3IQ
	TgrT8/wv+rl8vyCafKKP8R1EkCXgeUkYd0tVCUxLJbgqc5rGSLaMSZbGJrDkyN3TcduVbC7h22s
	pF67F5YK+DtwHXIY091QySmjhlPx1fsYpuY4bFIccXIDr0Q6Rh/wRlKb6OMOsL/XxIA61kw=
X-Received: by 2002:a05:6000:2dc2:b0:3d1:6748:65fd with SMTP id ffacd0b85a97d-3d1df34f1e8mr10111050f8f.58.1756882395156;
        Tue, 02 Sep 2025 23:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0yruhAga9yW6JCJcGMnqV+d1n+KmvFmXuUnB6+Zb3NwS+YvoUrM3+56P9Rlm9hylbXHe6ZQ==
X-Received: by 2002:a05:6000:2dc2:b0:3d1:6748:65fd with SMTP id ffacd0b85a97d-3d1df34f1e8mr10111031f8f.58.1756882394774;
        Tue, 02 Sep 2025 23:53:14 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0fbfb.dip0.t-ipconnect.de. [79.224.251.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dbead0b247sm2935180f8f.6.2025.09.02.23.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 23:53:14 -0700 (PDT)
Message-ID: <451967e1-81d0-40ba-b02f-935acd646033@redhat.com>
Date: Wed, 3 Sep 2025 08:53:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, kas@kernel.org,
 willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903054635.19949-2-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250903054635.19949-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 07:46, Dev Jain wrote:
> Now that all actionable outcomes from checking pte_write() are gone,
> drop the related references.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


