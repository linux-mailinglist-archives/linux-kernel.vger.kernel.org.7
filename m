Return-Path: <linux-kernel+bounces-744535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C228EB10E22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9885A1D003AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26362E8E02;
	Thu, 24 Jul 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQGpOvpI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA42E8DE4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369068; cv=none; b=DbhmKcTVurCflK7c0QhzurQcQyCtDmdKRZJfXN5C6DTShyK+J2F24xliD8H9bBUCo/DYCaV+D16LekzEsvmQYAw+uLt9MFu7af4hDV4Jnz/l/YtvBs9lrg8SC8A8VKE3KBvmuoxjolYxlj2hrYRm9KuP9sfqVf21j3LQggB3bms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369068; c=relaxed/simple;
	bh=U9WDJWXS8QeJpVynivvkUyg7jTc3ZVIvdnwAelQJlHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSgvjnYEhKEuwAmGXUuBsKuPWr3kKbedqsBHE/D9Yh86H5al6JfNsDJbpDrvMKSAq7CCGDSk2tx780/ZJvlUXGAUhmUYTGxeVxfFICEBKX2lSOSIkKiL3OuK53pDWVb6wKptZM0Mryt4rdzhnNSipYUtUjZN5I/FgLjzSHuK5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQGpOvpI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753369065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1lGxamDDy0opgT+qadzIayrtZVqdkgT47I3fgf4aIkQ=;
	b=hQGpOvpIPuKIDhAQvwvpb1v/vG+MoKVRCHaMqTqpdU3QgSPHwyvwJGGOrAvOJ6xvDsM9qp
	NJbBzyO7LnUo+Bm+gXq+P8dJpgSci9twQrr4oddxY0zzUDmipwreGKaZEQ8M/PKIHbH46V
	kh/0yrlyPZnTvbNF2m1FjQD1x5Woj5A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-JnvFmtIsPXi6ZLiU5TiYRw-1; Thu, 24 Jul 2025 10:57:44 -0400
X-MC-Unique: JnvFmtIsPXi6ZLiU5TiYRw-1
X-Mimecast-MFC-AGG-ID: JnvFmtIsPXi6ZLiU5TiYRw_1753369063
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so594965f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369063; x=1753973863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lGxamDDy0opgT+qadzIayrtZVqdkgT47I3fgf4aIkQ=;
        b=uESXgHthPLkKVkD1dbE5cLG+l61zeUhZADEKjekhFOpmC85/Nxo+eI+8o+9jn4NVtb
         Fxgg5J58klVDYC+NlgGdCOIKKB1E8yV6/+hHOGa6J3B5hUJEdvSAlvbUGt0x0PfQrYem
         /Y0HVo5oV9JvA4HO/5uVSmtAXOfxPpGorMbn/OIIcGHsJz4CRhXNutJdOrpCyvJn3NaM
         3xbd9XfwRwdmgjYsu5pjcCZ3/1VwD00RzjzKBK4Nboqja+xWw8bCr09hBR/vIHguuRdo
         LAc8sy9xlRi70W1AXFHZ95Es/B+kl+BDhCKisKQylv6CEIyowzGDJZhgeQYIUYBZCgcm
         Io9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7p7zNdEOI1DP5ZoashgVttWUGmwHSCjFgfOu7+s+HH7CyCL2lbHRfom8O71lkUTatwvpAtwTZlAxaLeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqq23PKMhEpMZdnqTAlAFHyVbGMPkQz/iuYK2rEkEFVgbWh8c
	c2/vDUqfgkTC8tj4t72eTbKnGKRrJg98T5VmCjZkG3jtn4BreJAmtCOb1jmGMZOMbWpAVZkcovT
	gghCb2l71d74m8KFq4W/VuGmKId4Vc50wqU9wkuxKRfle0Un9zLXmG6dlUC/08HBROg==
X-Gm-Gg: ASbGncuFefq41NivfY3CxlVqY9PLqfsyssajh+Rfh+peydF4Dx6TYMwX85u3CuLYzUd
	yT5Yb2+b+ITMBEPpREGMA8M2xN9qJa/Tpqam8C9dPZhvCo8UPYIc/3bZrxYiRDchn1sGg2reOhL
	PnEMbtfmL+dU3vHm1A+rbUP3WeGuX856GVS9lD1xmEN/kXm5VyEnMrz1R6GLnzQItsw9JjxSd9H
	CWmueTQD1cCpysLZmm4SCawFT00Wu8DKRKUxEt8mh8CqrRIu3fYJNj9Aq6afQkohxTHidPazgbo
	3xlKdDanO5pLHMMJAStW4qRiUZnwOxME2lP5G9gviL+QAQWL66nt9XcVNEpEZumCAI5IMlKzxdE
	Ovbx6D9weqcfMpnuX86vIxh7xkqpfAGdiWBCDL24S6p4hNS9a73Q2NTtwKGEFfJEB
X-Received: by 2002:a05:6000:2307:b0:3a3:6e62:d8e8 with SMTP id ffacd0b85a97d-3b768f27a20mr5858270f8f.55.1753369062990;
        Thu, 24 Jul 2025 07:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2atFpMErVT16ItrzQcgOWerx2msamlrVtc7HzqwG7fb/dpPWEMAcFfJa7kucnZsr4O4rALQ==
X-Received: by 2002:a05:6000:2307:b0:3a3:6e62:d8e8 with SMTP id ffacd0b85a97d-3b768f27a20mr5858250f8f.55.1753369062456;
        Thu, 24 Jul 2025 07:57:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:5e00:c941:d6fb:3e30:b42? (p200300d82f1f5e00c941d6fb3e300b42.dip0.t-ipconnect.de. [2003:d8:2f1f:5e00:c941:d6fb:3e30:b42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6e5e1sm2507906f8f.28.2025.07.24.07.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:57:41 -0700 (PDT)
Message-ID: <b2060498-d724-43c6-9e36-9b571eabc541@redhat.com>
Date: Thu, 24 Jul 2025 16:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove io-mapping
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 16:53, Lorenzo Stoakes wrote:
> This is dead code, which was used from commit b739f125e4eb ("i915: use
> io_mapping_map_user") but reverted a month later by commit
> 0e4fe0c9f2f9 ("Revert "i915: use io_mapping_map_user"") back in 2021.
> 
> Since then nobody has used it, so remove it.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   include/linux/io-mapping.h | 231 -------------------------------------
>   mm/Kconfig                 |   4 -
>   mm/Makefile                |   1 -
>   mm/io-mapping.c            |  30 -----
>   4 files changed, 266 deletions(-)
>   delete mode 100644 include/linux/io-mapping.h
>   delete mode 100644 mm/io-mapping.c

IIUC, you're dropping the MAINTAINERS entry in the other patch already

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


