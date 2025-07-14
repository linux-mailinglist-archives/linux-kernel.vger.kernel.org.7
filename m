Return-Path: <linux-kernel+bounces-729999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9FB03EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD78117219E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD7248F5F;
	Mon, 14 Jul 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLdXHezr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AA24888C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496881; cv=none; b=q2BqU6jcWzqiL/xO6GdMFO+CvyzIYypj6l7/DuIeKK9U1BI9wIO16qGIwUoV082dXKd0ndZC0mpdfKM5cYpgWguYuUV2FCkeiuBt0TmuAp180m/DDZ2EWYJxO4y36kGNtJIAUGfVLHb3yf2HsaRaUlkHTgw2gTLWaVRvFFFz7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496881; c=relaxed/simple;
	bh=EU/9ZDtsuN6eH1IZPhEa5PdVZBdPTGac/TKiXXM/Z6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HElT6scRmr/7h8eDhBDSuK/zv1b69b/hVII+UFjzZZ7IGp4Z1o4XarAnK+q9HrWdqyPJhyp2loTuiJWCUg1c79IeWaNEiRMc074uhKX+z/i+4T+dovy/8qKUB8RtbTiPc0DrTM1x5Xb7GqmL8Lpsd0cdjm3n2B8rCAYXfpWNric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLdXHezr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752496877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AlhL0g61tcP/asJxs4tblcpuvuh9N/0WRyDkg4z1yL8=;
	b=NLdXHezrvLn/Iw/YvURPfaUK5eiNlTO1EW0oGkP+qjaPqpIKEwG5dBEojw9DBsB6mu3kHH
	uVjdopNoXAPsGxnjzNPWXWyddkhncM66gEEPpVzDm6Zz27jorT3a438khaRsa58a+h1SVU
	FBXjRAloDxMogDF2Nk+gE0mQMM3Ljxo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Wh1LlTWZN6uAKs8_vbd1Sg-1; Mon, 14 Jul 2025 08:41:16 -0400
X-MC-Unique: Wh1LlTWZN6uAKs8_vbd1Sg-1
X-Mimecast-MFC-AGG-ID: Wh1LlTWZN6uAKs8_vbd1Sg_1752496875
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4561c67daebso2422315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496875; x=1753101675;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlhL0g61tcP/asJxs4tblcpuvuh9N/0WRyDkg4z1yL8=;
        b=HvHlEzf+rw2twCeXpKWJJy/8avcar6TtMwzq3BCj07lvjQqS8F6xYactpw2nOp9y8+
         rcmeU8MPqq2tgvdcjx6ezTJgYAbOXDR599kfeOznA/rHA7RNNzVDEs/oJmEUPjdfKWG6
         dpQm1PTfKsu8pKmI7zg4CwV+iUsWgalx+/Ebh1LGnpx5osQM1Ns9bKok+tAwcKwGVX+U
         SNrhIkJLliqgF3IIbVxuYhQXObngwubunzED5RRhdM7b/VdUQ+LaSBLl99NYkl54fZex
         IL9Vz3jYKkhcoA+z5RMbujt9ZC66D+QdC5IBgDF5F037UxBlZDGjxz+UhuMaes+VuNsu
         RhEw==
X-Gm-Message-State: AOJu0Yx+IdBhO3TGN/WcRvlc/DOEKIoOjJ0MVXFo2k1ZHPZh1EgdsIP/
	fmlbDt3tvOZtF2ICaeke/o6tqtPUpf/1iKFh4CyVcpTeKWfLxL16LtZ9znsSLKbznNy/tVrCaXI
	F+t0i6d6w+eB1w1uR430NQGSOrePrZcnXQ8/YuDxvKVQqv0KbV22gGA1ntf0RprBScg==
X-Gm-Gg: ASbGnctIqWz9xS0vFvofjKKJHCpK4bu7aId+9lQBkhVF1zEQVB/mXq0IhpOW2iQfztm
	m8SZR87XvcnHNFdpM5mZ9AaHys27OsG74jQnQbn8bkp4hxBqKaZMEr7crcqOwR+HNP6rsgZnv/8
	5uSZBO69Ny0F6p5CwmDsNi8Er9oooop1ZmCY+Gc6GaTkdTO4WsYxo73C/t+pSQLe9669Qt6nlpf
	vtCnHE1hpt0KnpAsSOuRCO3hkzK/iP9qe5KUVCIV9OgjqvlfQfg30ol3jbwB0Klr9+1A5cx9cfj
	88gsydSQdlFt3chaJIXIY2QO4zk1Pnt75wWq5x9NR0T/+0sR4Rw2o0qTy3eSq5sJpcx6TVqaEaE
	xSWU6JktOaCKq+r6UVcak7Fj48GV+1r8nerQG/vdq7oVGRIWvEaAcyG+ZFSB8zXJ3
X-Received: by 2002:a05:600c:3f07:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-45615a19f78mr50490965e9.13.1752496875395;
        Mon, 14 Jul 2025 05:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7DuhvnhvQSDasJMYJlX2NuMhbqjgqBZ9IwWcjRy08mrRHLkhE2Ly+4rRmtT0k0blUgZ5iBg==
X-Received: by 2002:a05:600c:3f07:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-45615a19f78mr50490335e9.13.1752496874860;
        Mon, 14 Jul 2025 05:41:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd466154sm129926275e9.12.2025.07.14.05.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:41:14 -0700 (PDT)
Message-ID: <3db65a9c-4ee4-4bba-ba8b-f1171f942766@redhat.com>
Date: Mon, 14 Jul 2025 14:41:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/14] mm/huge_memory: mark PMD mappings of the huge
 zero folio special
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-9-david@redhat.com>
 <aFu0H_AgdM2W2-R_@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFu0H_AgdM2W2-R_@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 10:32, Oscar Salvador wrote:
> On Tue, Jun 17, 2025 at 05:43:39PM +0200, David Hildenbrand wrote:
>> The huge zero folio is refcounted (+mapcounted -- is that a word?)
>> differently than "normal" folios, similarly (but different) to the ordinary
>> shared zeropage.
>>
>> For this reason, we special-case these pages in
>> vm_normal_page*/vm_normal_folio*, and only allow selected callers to
>> still use them (e.g., GUP can still take a reference on them).
>>
>> vm_normal_page_pmd() already filters out the huge zero folio. However,
>> so far we are not marking it as special like we do with the ordinary
>> shared zeropage. Let's mark it as special, so we can further refactor
>> vm_normal_page_pmd() and vm_normal_page().
>>
>> While at it, update the doc regarding the shared zero folios.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> While doing this, would it make sense to update vm_normal_page_pmd()
> comments to refelect that pmd_special will also catch huge_zero_folio()?
> It only mentions huge pfnmaps.
> 
> It might not be worth doing since you remove that code later on, but
> maybe if someone stares at this commit alone..

Yes, it should be removed in this patch, thanks!

-- 
Cheers,

David / dhildenb


