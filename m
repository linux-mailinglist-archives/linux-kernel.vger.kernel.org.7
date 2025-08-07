Return-Path: <linux-kernel+bounces-759441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A57B1DD9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09BF18A0F23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C42264C0;
	Thu,  7 Aug 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXejDDui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD24202F8E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595692; cv=none; b=C3M995hcbIaQSBmy0Xrvx5Qy9TDAaiLciRGlUVHM2DTu2LpVCIY2RmaFbxrLNOoEPPSWS6EM8ObJ6oL3A3QimyGz4ozi0l0gRNnFB5lmZKUPrtTpWCNCBV5xG26sWjgBfrA5beVmXHajOLsymSBZg8Zi7wZuOy0hL3F+H5PVcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595692; c=relaxed/simple;
	bh=vZACSK3AllLxn0ZdwMjSdJYKACXdWU1tgohD1KIrbRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnebemsPO1YVJWrgszqqm2ZfN3dR1Bow+PUC77OOvjRmUBWir6bfWT+02RAb65l5pnjQ9HJ6rxC2JNO/yqbIpmkOAxA2PpC+p9NYuLR+mf+w5eJiWuytt84Xk/GwQJyBOgfv9NrUYsEky7eiawOii8A2bivofh6WE+rnLwCR3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXejDDui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754595689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PeYHKw89L3v5zGQ5eALX6EboGtf9gJSw2vDV44gM3pA=;
	b=KXejDDuiYJpfwqc9aNKQBgz6Wp3kmEis5T/rrc2zCbo9NQwqEr9H+r02B1LMjHe60D6GdS
	I8PXizAYGOeH6tP0iS2ahZzpsEm2vF7dBrUbXBXPVMyHOs+a5dMqzHK3+NFlkVO9GYD2Ul
	+tJTTtikPMQWiQ+BBHm7fjxe+tO/VpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-6KzZWJYxOWKvdlhJomO7jA-1; Thu, 07 Aug 2025 15:41:28 -0400
X-MC-Unique: 6KzZWJYxOWKvdlhJomO7jA-1
X-Mimecast-MFC-AGG-ID: 6KzZWJYxOWKvdlhJomO7jA_1754595687
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459d7ae12b8so9378275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595687; x=1755200487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PeYHKw89L3v5zGQ5eALX6EboGtf9gJSw2vDV44gM3pA=;
        b=Mce2ekg4CuJvY0yxfs/DC1E2cq8Mre7LLbCIf823/+bMgsq+tj4dXQShpTOqi0o5dN
         vq0NA9Q4W7A8jR1MaU5/JNWFWZOhUO7ESosknrd8dr4dFe9fx7/9vo6GItglws9kjpI1
         mGwQOSFb15+rXJ1+7a+DPCZvoxKvcAnDqmLb5CEoICpOely55ieKrhz9k89ibfNyVGvS
         eBt1KhbSnv+U3MkO3eAMgdk/U7h/FXqtqR7/ixO4nNIU0YmnutKlI6uzXXqv3vZfsWEt
         ZlDqvVb6APaTep26jvXM+NDMuib5QeqzXpC8OHRLnIX5hJ9rlnwg1yRp3CZykWHZllni
         IE6g==
X-Forwarded-Encrypted: i=1; AJvYcCWgbysJxI+uu8vv6dIGXNgVLN6oRed/MFJgOV5w5vcgI2R2ftEBxwDy9tB1FhqfoYasBggtz+xubKRnB3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASdB/kns8isXs4DOQk3uMR1IIvSeOqZC2gVV/cGzE4CP/97eU
	nN8/Nf4YTx04mEUlDpJMZKu5CZX2p52+NC4sG2sRALYm3xbbPUKVupqvos+kKBePm9cctaCj/N0
	OaPY3Pp6cL6QuROhwSMIvD4yqHSpRwU8sAGCJAVrOKWB5+LZM+lJ0lRa99Qu4KbOjdQ==
X-Gm-Gg: ASbGncvZGeY7EEVbq5Kn/vx4C1wNgcQgMjcP96ygEpfSkZUy/5ijwa9QR/qlvbv8vEO
	BjhVcoB1iuxpMu/MGSKQHRZ7C+zSKZlxSyNsPPRAnSCeMf164e7K/7giRkC7JjpcW+L4T8p0XtS
	iDcfMOWnDSLXsmSUiUiHtNMWYtDaxgCzdrxJR50NbMX2L37nq1liXUlu0Uw0FXUbkMpWFY2EeU2
	RCNGeZ+KchxRrlliFH+gDkjW+Yt1x+AIO/OLLT+FZlpY9FRw4l/JKzjXVNvEBv5N5shsHQm2K3a
	wImh81U26KsMDxKWz6unzeZm4oFAJ8lzFHa0bVkKkPMzoGCNz2FO2tANoxkF1Gssdlccb0P/trE
	MZ/ODgAFWEqQhSuetfQlPJ5uIivx46KO0DHggXVCKZzTAom6a28Igvk8ITWb2jx/9vcM=
X-Received: by 2002:a05:600c:a4c:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-459f4f26472mr1728545e9.26.1754595686834;
        Thu, 07 Aug 2025 12:41:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyQsr50pqCVgGsQY+sBGaUVLZfT/YAV41avTGHKvxWeW+KAmNO8+R4RWGQ6C3gl5IURhlxKw==
X-Received: by 2002:a05:600c:a4c:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-459f4f26472mr1728395e9.26.1754595686434;
        Thu, 07 Aug 2025 12:41:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e075047fsm79496325e9.1.2025.08.07.12.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 12:41:25 -0700 (PDT)
Message-ID: <ee3d7b32-af47-42b7-bd27-0675c065d736@redhat.com>
Date: Thu, 7 Aug 2025 21:41:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 21:20, Lorenzo Stoakes wrote:
> +cc Ryan for ContPTE stuff.
> 
> On Thu, Aug 07, 2025 at 09:10:52PM +0200, David Hildenbrand wrote:
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
>>
>> Wondering whether we could then just use the patch hint instead of going via
>> the folio.
>>
>> IOW,
>>
>> return pte_batch_hint(ptep, pte);
> 
> Wouldn't that break the A/D stuff? Also this doesn't mean that the PTE won't
> have some conflicting flags potentially. The check is empirical:
> 
> static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
> {
> 	if (!pte_valid_cont(pte))
> 		return 1;
> 
> 	return CONT_PTES - (((unsigned long)ptep >> 3) & (CONT_PTES - 1));
> }
> 
> So it's 'the most number of PTEs that _might_ coalesce'.

No. If the bit is set, all PTEs in the aligned range (e.g., 64 KiB 
block) are coalesced. It's literally the bit telling the hardware that 
it can coalesce in that range because all PTEs are alike.

The function tells you exactly how many PTEs you can batch from the 
given PTEP in that 64 KiB block.

That's also why folio_pte_batch_flags() just jumps over that.

All you have to do is limit it by the maximum number.

So likely you would have to do here

diff --git a/mm/mremap.c b/mm/mremap.c
index 677a4d744df9c..58f9cf52eb6bd 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -174,16 +174,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
  static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned 
long addr,
                 pte_t *ptep, pte_t pte, int max_nr)
  {
-       struct folio *folio;
-
-       if (max_nr == 1)
-               return 1;
-
-       folio = vm_normal_folio(vma, addr, pte);
-       if (!folio || !folio_test_large(folio))
-               return 1;
-
-       return folio_pte_batch(folio, ptep, pte, max_nr);
+       return min_t(unsigned int, max_nr, pte_batch_hint(ptep, pte));
  }

  static int move_ptes(struct pagetable_move_control *pmc,


And make sure that the compiler realizes that max_nr >= 1 and optimized 
away the min_t on !arm64.

> 
> (note that a bit grossly we'll call it _again_ in folio_pte_batch_flags()).
> 
 > I suppose we could not even bother with checking if same folio and 
_just_ check> if PTEs have consecutive PFNs, which is not very likely if 
different folio
> but... could that break something?
> 
> It seems the 'magic' is in set_ptes() on arm64 where it'll know to do the 'right
> thing' for a contPTE batch (I may be missing something - please correct me if so
> Dev/Ryan).
> 
> So actually do we even really care that much about folio?

I don't think so. Not in this case here where we don't use the folio for 
anything else.


-- 
Cheers,

David / dhildenb


