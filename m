Return-Path: <linux-kernel+bounces-671057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3A0ACBC59
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 22:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DAB1893375
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F3221297;
	Mon,  2 Jun 2025 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/iZFO5R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74141CA81
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896383; cv=none; b=pYh6V32pwBmZBsVGr8HtKwZt9rmbdAjdX1iy8uDTmlx7y7+SnvCr2b39vRLcZVO8YfkoNh/h9HG0XkdSdnAWliI5Zyklj2fs3pCI5XQGXeWtzdzqg+NncUBDQsFQV3j5j5mgZw+otK2bPww7ND/f834wTX16iowGoOzFkIU4iiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896383; c=relaxed/simple;
	bh=LdiIhh93dXCCm2PcWMurrWqKc4LYxFEu5GqgNS9PHno=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CFJXDh0iBM5mtdvX3skIFxCIQHXUykzovzGJhBk166JwheUy/F1wSuCJlZ8IVYr6taOjCSYdnf8DibX7DdcDNBwVZhgb1HPMH2pJNJtgLWglLw816e7OWxnoEAVDRGZGdbP3z6+Fw7Bh8R66oZWfpiG2Iq+pxc/m9l90HB92t6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/iZFO5R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748896380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rV/xn46OPX4p3xq3mkWtZ8NGtbJKFadJJeI/QsB8Plk=;
	b=Q/iZFO5Rc4J+/fMsTK6L1ltAI3X0BdozH5RZJHjdBdQGqdOj+ETc021foyXwf0lLCo3UtZ
	gAf+MtAP+Iw9ptPWU2T5jAv7BH6N6CdaOZFUnfWbchBj5Gqt+BalhewyqBqYWkdiWyN99X
	DHFh92PwTx9m6ZPdoeW4ibfWZsMu0AE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-76clD6tQM0y_bI5ptJWcCA-1; Mon, 02 Jun 2025 16:32:59 -0400
X-MC-Unique: 76clD6tQM0y_bI5ptJWcCA-1
X-Mimecast-MFC-AGG-ID: 76clD6tQM0y_bI5ptJWcCA_1748896378
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so1076378f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 13:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896378; x=1749501178;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rV/xn46OPX4p3xq3mkWtZ8NGtbJKFadJJeI/QsB8Plk=;
        b=N+I+eoiiAhsTAFfGc7kc2LyzPvhAjvNtdIWkmpJCxu7If0JJ71EP1ckZ5kY6zgW4w4
         6S0b/6X4xDyyliO043FvPHJ3qvgFj99N0nBmH+L/EHagWRcYNu/H2j4t9QLM+Omh3q9Y
         i1MEi4kSjBP9t1YsTbN6oJOvhd7S5yfIR7Ra1kN5TpEJOpxZrC/m49joxCD3y+iaGVjA
         2/iN5tEHfzXS2dUOgk4LN6HuGkAALzBbDLsVquljFLZTxjLVyxM9SpoTioJwMHehRGar
         STvKs8xcUbp939vbkvmhHsfLxKc35WSVQ7iBqAx42+GGtVe/g7xbxUUJD8o6tKAsaOqD
         mu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbCSdbclp3ztGALFo+Ox+QZ8LLQ2QRF6Qz6OxgtKdie6V+lDF09wT8UfaOekeU1EdiiVHaKQPZqPVPJMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHT+XuD52P1M6kaw+O9DxDfBpw88pQF5bt5ixmSYPFf+/78MVT
	4dFs3YJzSmry//rilKy1Jrz5RH/Mj6Rcg+YDKXfKXQUG021ppgJIa+Y4Mg9pcc2aaifX61Xgvqg
	R/QNC34Us7hOaajCZJDcNbPx5ygT6HAgdOTeOlFlV/wuuJuZvjid04geVMAWn6hk2Ow==
X-Gm-Gg: ASbGncuGYnDavZcB0C7z+P5EEvH9upEEYIlu/ajrrN1DdI2rYKt46vma1n+lGX0n4YM
	Se3SINdKDayj5yAj/+rwwmpwrq6OnOAVsZjN7+xwkA9Q172LCG6VoHUpXM9ec5rwD0hi3T4iebJ
	K944xxl+R8QF9f7D6Sh9kSkoLVLtc6SoniImFPh84x0sTxEfEz9UJPEKnh/eQWDqycwe+XwH57D
	n35pgqIh/on94fT/tfIxI+z7ZncC50G4CfZyUDgQFEr4/J6KA9iPEovHxUHbBzC2tZwRVMIIDHe
	JnsL4K0A13+Pw8bDjitEnEYv1WkNILADp03Ymedwfk8EL1mQohNG+eQJb1qm+NhDzfO1rC2wElE
	LHHdcEMmwRKfbG+6GelrIpPM+l/IOIUaE05HrZ0s=
X-Received: by 2002:a05:6000:2507:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3a51419e594mr6704f8f.15.1748896378414;
        Mon, 02 Jun 2025 13:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKGMuCXnK5YSdjQL2VvSTmgIciOLzGBriUAeXPzCZMHVa3TD18rFDC3ib6WqfRPIEUfRZ+WA==
X-Received: by 2002:a05:6000:2507:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3a51419e594mr6658f8f.15.1748896377906;
        Mon, 02 Jun 2025 13:32:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73f83sm15508352f8f.49.2025.06.02.13.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 13:32:57 -0700 (PDT)
Message-ID: <842b8b5f-fe0b-436b-b8d7-64b215bdf9d9@redhat.com>
Date: Mon, 2 Jun 2025 22:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
From: David Hildenbrand <david@redhat.com>
To: Pankaj Raghav <kernel@pankajraghav.com>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <20250602050307.GC21716@lst.de>
 <aa6fcbdd-5b1f-412c-a5db-f503f8a7af72@pankajraghav.com>
 <04a27029-df1e-43a7-8642-15f351121438@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <04a27029-df1e-43a7-8642-15f351121438@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.06.25 22:28, David Hildenbrand wrote:
> On 02.06.25 16:49, Pankaj Raghav wrote:
>> On 6/2/25 07:03, Christoph Hellwig wrote:
>>> Should this say FOLIO instead of PAGE in the config option to match
>>> the symbol protected by it?
>>>
>> I am still discussing how the final implementation should be with David. But I will
>> change the _PAGE to _FOLIO as that is what we would like to expose at the end.
> 
> It's a huge page, represented internally as a folio. No strong opinion,
> as ...
> 
> MMF_HUGE_ZERO_PAGE vs. mm_get_huge_zero_folio vs. get_huge_zero_page vs
> ... :)

Just to add, the existing one is exposed (configurable) to the user through

/sys/kernel/mm/transparent_hugepage/use_zero_page

combined with the implicit size through

/sys/kernel/mm/transparent_hugepage/hpage_pmd_size

-- 
Cheers,

David / dhildenb


