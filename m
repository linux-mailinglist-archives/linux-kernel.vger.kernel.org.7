Return-Path: <linux-kernel+bounces-842004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E8BB8C22
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 007A54E4033
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4C26CE0A;
	Sat,  4 Oct 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyoyYHcY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849FC1DF271
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570943; cv=none; b=aQC+sC83JRprQPNsvFgYj0LRgRKwUo3X081L7S9OmEM6cPTr8seUG7VjDH/4s4qbuVBG2AckmN1dHTFJSpMJdX26G4TeBXCqQi1eh1ZEqINN9QIkfadhHZRrSHf4klEERixE67ngm5fGsJhfyNZsrLGZvKtj6+TR0GMseH5U+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570943; c=relaxed/simple;
	bh=pKkpfakyL+A1ewDNEjGcrv7FwiqTyJwovBb1pw9Id2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXeh0UlzHxgRp4skQvoHvkV2elHypxl4GPIupT2/pOgX3NBte7Kws88fKHTUhmUXEXn9U7FLbIFjNbsgJCgmVorI82yynOOGpzn8pglrhykj5ndWiRcHrCqZUNTYGRsUeS2qw3IgR3+8glJ5L7zYrGlCwewDY6EE3yCGrckZOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyoyYHcY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso478916566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759570939; x=1760175739; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GslXQjNzh/AIqv26b+mMupzmqLiHs7UYgH8GeJMNm98=;
        b=TyoyYHcYspUzqpL+St2x5AzpJtbIEJDDv/p9n/lt+J+OEnP7PRYKYxWbTDvIJ5hr4G
         UjeTfJ2UH2niKy9nE7XGxDnZ+B0gQyR73MtdGlSq52FoRmoY71cBrikijz7bXcv6DTEj
         z91+oXw9xhMLZ0O2jGd6jwBxzgd1MdahCxDfIRu1BDLeobYGk3HjwwnofY35ZMSu4VcK
         r9ZLYkzMDDxXALdWnBjN4Cxb9a7RWKjTaXSSzdAxLdiiPSCf6aofJzVrNiBu1G86veZ7
         dhyi9w5yDVs3G069rkbAfPXMAXfllvIXjTt6CseCX3/4RE+G54jZ/hUry6Gwv4ZknzIg
         nWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759570939; x=1760175739;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GslXQjNzh/AIqv26b+mMupzmqLiHs7UYgH8GeJMNm98=;
        b=k+/ikC4HS77vTEJ4aRKCThSI2oZ9o/Kx+p3EZ/c5BGKqLd7vlLQmZGufl2DzdR2i64
         4/cJjfglMlkyfojOpVKI7kfjeQ0M/3Ir/nik57neLPq9KeRLL0ih6Id8gbXSlAESrDYB
         UFgr/TAbYsqSt0MLjm1mmfk9vVXX/ew0/NbslrJEvw7AQO+x8ZIb9oKKxfageKdF7d0L
         OjHArBAqL9Ipy2oTcfxFN+1y9jNB9g2+YN3HFVU8Eo78au9ArM7dox+hDw9uyOkBguve
         Wf9oCqz5ZUtxeqW34RSQQInqh5+boOT1/iQNgtl4LmTYiVBfeO9HrPesc/TGK361XZeC
         ogFw==
X-Forwarded-Encrypted: i=1; AJvYcCVlRg4N7bZgJUQ6TIFpK6nG/0gFsfNnK39YpTrPFsuRc2x2ZjGvZas85mMUa9jg9820oTO+CmgJlyJIfOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYpVPeWRUecNnbMFBKsTKNvZPViDGp4z5YOOeOg//6DNKtZR8
	QGPSZAMGQZ3YJhs7+LQuT1agKPVyX2XKQXg4Xdsc6IuXDjtHhz1AUuCN
X-Gm-Gg: ASbGncv5/AnU09khESf+Fe+5XpRZr2fVWlnW3bZ+NADTKpO1JP4EW3xJxky8m2lFbo6
	7xQynvhpBM2duC//Ukf6sFvec7e8q4vbvkfMYTPZkxXvBAFfwj6+9AEWkSmaBoIf6aLU7+7pMFc
	28NgtoSbmsxI71wTNYeLRloCzQKuipSo0xub8evXBNTxCYktsP/5A/3gIRsx209fOA8Z8YsFWxA
	0cEssno7hYFzRQpXnBAxCv2EPJF9XhwgvO1/t7Untdo1+QJUjKXV8Wy3JNPlrjzZ0UxpYd/W7f7
	yunV3wTwKfocAA3Hj4U1KFV8P6JUrF7boAHNfidwsMOIUMWzAISzH3Br02NAmlHcM3Ij7Nzol6T
	IwPWXcKgbH9UHzvBXkZyFKtDPI84v0yaLXKv95nRX/oq3eSV/Iyxx39op
X-Google-Smtp-Source: AGHT+IELMv2JCHsGDeiciQPnXFlCugQOB1G8gJd+aFMXhX5vxBQh2qDM8E/2p3liA1SXVMjKe+xQxg==
X-Received: by 2002:a17:907:9728:b0:b40:448d:cdb0 with SMTP id a640c23a62f3a-b49c33501c3mr693267666b.41.1759570938685;
        Sat, 04 Oct 2025 02:42:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83bd0sm654284866b.24.2025.10.04.02.42.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Oct 2025 02:42:18 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:42:17 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
	ioworker0@gmail.com, richard.weiyang@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into
 a new helper
Message-ID: <20251004094217.bah5q2zxczrqontm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 03, 2025 at 10:35:12PM +0530, Dev Jain wrote:
>
>On 02/10/25 1:02 pm, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>> 
>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>> and __collapse_huge_page_isolate() was almost duplicated.
>> 
>> This patch cleans things up by moving all the common PTE checking logic
>> into a new shared helper, thp_collapse_check_pte().
>> 
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>
>In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for

This is true for the first loop, but we will unlock/lock mmap and revalidate
vma before isolation.

>an anonymous vma, is it even possible to hit if (!folio_test_anon(folio))?
>In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
>till the folio_maybe_mapped_shared() block?

But it looks still valid, since hugepage_vma_revalidate() will check the vma
is still anonymous vma after grab the mmap lock again.

My concern is would VM_BUG_ON_FOLIO() be too heavy? How about warn on and
return?

-- 
Wei Yang
Help you, Help me

