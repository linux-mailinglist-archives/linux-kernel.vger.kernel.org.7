Return-Path: <linux-kernel+bounces-736390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A3B09C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3987B58EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584121931C;
	Fri, 18 Jul 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkoRzBjp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65281DF723
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823424; cv=none; b=T9I9KoVq3QbKhkwwxhmlxmwmxKaAydcJLa4WH0vLL/GQvQVOHTBJLmWkicmKYLOmW16M2TI0E7m+ILg1R4lJrLa8dKb6dSiY6EO7o/X6UtRvXj5yotWrgick2sA8IDz6k78KOBmPRS3O3QD/ZnZIQyc3AjAvnJeO1nTBEYRGbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823424; c=relaxed/simple;
	bh=+5GVM2z13TdFDiMNx8W6S0f7dOx3O3V41XACiqAPp6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXd09Q1kaCgjyxUlOlKxd0gM4QjSNDv0CMadFUzq9OCGVDo4f+LSDyluNlkG4QOVMH6/WLPFODbxlvwlanghazOuY8yT65DlKKKi7vIEWh+m9cIAGwR6K5wVWUCFfGmQdCrdFf27pqV/JO1t10PdeakeIUhzN3rPONE8G+Q2yyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkoRzBjp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752823421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9RrBmzunL6zDwpq0gyC63RDwoM41jxR0aq1ACrL2Tfs=;
	b=SkoRzBjp9CqKILfDJXkyTcGt0AS8zpkGJk0QNjx9tKkBOG72PGxoY632rSueDteQ6487FG
	H65DojPizOMFKTgalT5fYQgdtVOPL5z7tmq/VYYyALmHABm41cCl4JV07GHRQYJiPtyNlA
	Kz3JzUuT1TOUWrLAb4vx2iLalSRh0TQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-hqRDsjvTM728dcrBoP8lUg-1; Fri, 18 Jul 2025 03:23:37 -0400
X-MC-Unique: hqRDsjvTM728dcrBoP8lUg-1
X-Mimecast-MFC-AGG-ID: hqRDsjvTM728dcrBoP8lUg_1752823416
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so1112939f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823416; x=1753428216;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9RrBmzunL6zDwpq0gyC63RDwoM41jxR0aq1ACrL2Tfs=;
        b=Dn8napWv7jLzcE04lcAdEsWMZ1Pj9N4I4wp/cv9ojAirN3iSDlaSyKlzEdsnakJm5T
         pd1oyzjqXbEhFdiDkxjQfHAhWOYbZfrqIevSTCLIUX/gXllcFKritxh+LkyfFqwkL0XZ
         MFex8Fy2Cp/Dd9MUChJRZ5ulGaG0VR3Khs/k3cCDI2/iMPP/dVAAti2m3UEksHSTRm/R
         MYiXMFoP7+bYM4IcHBaDfRgMNIZG4GHJtCjV+gda/npfwI5N8njliSkA7sB8+PCZkaOO
         wF1M0lK84X1ofihDkL/EHLKcOh9+eh1CHHfkRzc0Jp7YQ01mCMtmoYTOkjj2EmkSbcSz
         m+BA==
X-Forwarded-Encrypted: i=1; AJvYcCXk8F6nPMCje190eGN78XKMbK4TckDUCGIgB4DK/zq5GXDxvgeQxOxYCtUfd6wvZfSOaXP0zK/1R1m+zPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yYod3KTYZzEzKRuO51sI1UYV4iwnr5LDUub5su40IelEyfe0
	am5GR5T/twZFCUBEbOAcVreZ+5zkHKfiMJakcB8EirglgYHxTo1SrFP4dmss4lke31gB63tVFmV
	ZvLKoDPOhVeI2xhPwwWOwYJWs4U1xwk++pGRQPorrucK5PvbhnQpF2epMrRLxuz0mIw==
X-Gm-Gg: ASbGncu4fGJmVdEfhyx11dcWap9T+bcQ0BrJuN5Ka5qkIxPcdCB6axJ8ynGAraaZREr
	ls1uqPu1/70hfceXmH42Kq+nz7r+LW1+KEmlpaYpVB4dbVXp+pHxiRpvD4YLWcSSc0iX8Vt18/k
	lYm6VpFFr42iRTNrTAhaXZXphK9kIENmfIbkRr69LmWGhcAJIgbkSVxwi95aFwffvhxCKu1JCBo
	ZfDy4NzV6d9VvrJjiqUBj+aSG4Sj+m9qab5jiuqyL0ey340Hsgv1GutQL3cMflas3w/o0kZyO79
	mbz53fEmCw0ItHS7msqyq/QgLopjUZaDuKc0Z3gNnLHZM83V2hC7atknR7/1LzxtsffyXVsRyqn
	KbZiV0Pl6Bi5AmFuo9WhCknL7kzNmFYRtXVIwa7HBU0SpHabCitK++B/mbm/exX+WUCY=
X-Received: by 2002:a05:6000:3113:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3b60e518b07mr7444601f8f.58.1752823416379;
        Fri, 18 Jul 2025 00:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPLQJZzQJGEsBHKh/thGKZkG3kVil5IpltpWb3jW6yuo1iOm1PVuY5GWv9nLd1miTHeqyQsg==
X-Received: by 2002:a05:6000:3113:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3b60e518b07mr7444569f8f.58.1752823415807;
        Fri, 18 Jul 2025 00:23:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25410sm1037849f8f.1.2025.07.18.00.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 00:23:35 -0700 (PDT)
Message-ID: <baef9a6e-4073-4bb1-baa9-ee560fb4f4f8@redhat.com>
Date: Fri, 18 Jul 2025 09:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] mm/huge_memory: deduplicate code in
 __folio_split().
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Balbir Singh <balbirs@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-4-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250718023000.4044406-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 04:29, Zi Yan wrote:
> xas unlock, remap_page(), local_irq_enable() are moved out of if branches
> to deduplicate the code. While at it, add remap_flags to clean up
> remap_page() call site. nr_dropped is renamed to nr_shmem_dropped, as it
> becomes a variable at __folio_split() scope.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


