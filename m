Return-Path: <linux-kernel+bounces-654375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D873ABC785
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 20:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035D77A9D84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38A20F077;
	Mon, 19 May 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkUoLFtH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416552AEE9
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747681182; cv=none; b=qWNnLc9xe6cgJgUuJk1wSTTsMJKc6asgU9e81EsTK9kkJb4UgrR1R+9T0uWbG0pEKFuYevT5I6T0cIRi2K+NuFhhiwDx2llgyOpVjZlPQgH34xhoWno78dJgmCuITTlhvv+pRokk+hRff0U1TZOGeNmP6zgIjiM3liFcwakPk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747681182; c=relaxed/simple;
	bh=lP/2jDXCf3Sb7vbcuVLXF6p4vhZ6NTP652T2UCV0QNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCDwtI4098hTa1KpIgZzbNlsH6hOybHAwtugALQ/tDd8JKfO0CD9N5qUl0tgrxxBdQSqX9fqJOLiS6yo769gurPda4Twk7rR5KhDcHPCK4U1Dz8yK59zb2HvxIKfNJbjNK3oIGZxZ6tPyvLwk+6AT76zG+0gxouEx66db9iSlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkUoLFtH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747681179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X0Qk3+ymMKfgujs1vuiAbuMvJLkr0y04FOhPHdnkwSc=;
	b=EkUoLFtHOfu+xxrTZQOVgoQIW917fdPNGu3kMPyq/hmOeNKlADhnhmWyW92uAGHUHqZAeJ
	EwyhKchAKRWQINCQ3e570itlNLkv2naOUSuWGhl2bRD+FDc+2i7V/eIHCHyBpiH0pVnn6c
	+Wc1cZHljlWgoYiooVM3jahrt5AaoLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-QSVun5WSMOag6sobafTI0g-1; Mon, 19 May 2025 14:59:37 -0400
X-MC-Unique: QSVun5WSMOag6sobafTI0g-1
X-Mimecast-MFC-AGG-ID: QSVun5WSMOag6sobafTI0g_1747681174
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso38375405e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 11:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747681174; x=1748285974;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X0Qk3+ymMKfgujs1vuiAbuMvJLkr0y04FOhPHdnkwSc=;
        b=I9qF0Cf4/oF4GdnixB9sZuURi/7r5g6kyHM8OEgcUb9bhc9fiM6T20QKUKo9X2TD94
         HF63SoovsyE4byKhRvVtiJE8iqNRHZscI+tZHo01n2NmxdLtT8mNeYnClCoSXfI+zYQD
         2Iv7F9X0lAy7owlL26jXZls8tbIOG/gyxif/P9sqMhnVZ65OQW+R6fqi8cR1U8+BrSQp
         /e08JcEX7pIotNoz1Mp4O/9n+jHVBGEK4Zm2z+O1FZEu+9s7v+KnQNBhmAkzlbjbRiuA
         DtOqzt5tIbLnBxPu8NWa8F9acfjSRygTwEdg53d29z38RHlHkAe/vsQXXCUPE8qb3uJc
         FZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJrthL6Y9/iYoc4Xad3R3kEjccemIZUSxmzdMbUKNgs5VRWx2NLlvsr/7FSNBB0qsFrkUc5GY95E6CQ+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IiLvPfQIZAeFFbJ7pYiYYCQGuqiOREM3sz1hDFVdbbBaBrzX
	mtiCXXqlD8sHxq6807Isd38D0lEKT8XDs9D1xon7NP7wlFz/J9rhf1AG7LtyEVyqFJF4UPeiP3d
	glahrHTrhmpJ3sfV8yio2fczc0eH3BTMeu9SMHy5nF1vpWdxIDgGibwXtYTfzCym6UQ==
X-Gm-Gg: ASbGncsi/O7u3fIpH69WkSq8GSa+K5PReBF+kmAfbiCFMwLmtUD2r3Zle49U6P2CjnL
	G4prGOQrksd/Zse0xN6fmtOCLqpPMwHoomnQ2Omd4NwtcTO6J/lqr00iJIW3xSj17IuDXpa0LFK
	Hjn+2UzaG9n9Ijf+fVc0y8rHe9Z/bFum9QvxNgrNJEWqB91Uqoa7ZSFkjJRaBfl29F5hzs+Pi2H
	BW7z7u/tuPXVEsNYxbJUSYhQQiGMdp/e3AQyjSoJRaEkGM/XP61biopyEPuyMv6rgjhponqfyg0
	Tiq3lzdP6FuZOyPgDx/u4UH9bGt4ae3xLchE41l0+PPqRrCfEYZs+D0/t1Cb4xh2nezcC6bP9Wj
	IYYxgMMYH0dOGn2a+dgfjtjEWaOD/qDM9tIcQQi0=
X-Received: by 2002:a5d:5986:0:b0:3a3:76da:32b3 with SMTP id ffacd0b85a97d-3a376da331fmr2195998f8f.18.1747681174506;
        Mon, 19 May 2025 11:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUwd5DmDCrWqDk782Fvd284ghiMbFSA1l7ydnuebYBS00RZnMHD2oMIoWNw/QJBYRcVq1hKw==
X-Received: by 2002:a5d:5986:0:b0:3a3:76da:32b3 with SMTP id ffacd0b85a97d-3a376da331fmr2195970f8f.18.1747681174134;
        Mon, 19 May 2025 11:59:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d26esm13969960f8f.13.2025.05.19.11.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 11:59:33 -0700 (PDT)
Message-ID: <e2910260-8deb-44ce-b6c9-376b4917ecea@redhat.com>
Date: Mon, 19 May 2025 20:59:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
 <2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> I am not 100% sure why we bail out on special mappings: all we have to do is
>> reliably identify anon pages, and we should be able to do that.
> 
> But they map e.g. kernel memory (at least for VM_PFNMAP, purely and by
> implication really VM_IO), it wouldn't make sense for KSM to be asked to
> try to merge these right?
> 
> And of course no underlying struct page to pin, no reference counting
> either, so I think you'd end up in trouble potentially here wouldn't you?
> And how would the CoW work?

KSM only operates on anonymous pages. It cannot de-duplicate anything 
else. (therefore, only MAP_PRIVATE applies)

Anything else (no struct page, not a CoW anon folio in such a mapping) 
is skipped.

Take a look at scan_get_next_rmap_item() where we do

folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
if (folio) {
	if (!folio_is_zone_device(folio) &&
	    folio_test_anon(folio)) {
		folio_get(folio);
		tmp_page = fw.page;
	}
	folio_walk_end(&fw, vma)
}


Before I changed that code, we were using GUP. And GUP just always 
refuses VM_IO|VM_PFNMAP because it cannot handle it properly.

>>
>> So, assuming we could remove the VM_PFNMAP | VM_IO | VM_DONTEXPAND |
>> VM_MIXEDMAP constraint from vma_ksm_compatible(), could we simplify?
> 
> Well I question removing this constraint for above reasons.
> 
> At any rate, even if we _could_ this feels like a bigger change that we	
> should come later.

"bigger" -- it might just be removing these 4 flags from the check ;)

I'll dig a bit more.

-- 
Cheers,

David / dhildenb


