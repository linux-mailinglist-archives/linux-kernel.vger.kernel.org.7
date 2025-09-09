Return-Path: <linux-kernel+bounces-808049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD6B4AC8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FB11C2217C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3043C32BF46;
	Tue,  9 Sep 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g63hbSzY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E21632BF20
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418217; cv=none; b=cI80khWt0SkFYbvC1p1cZtMYZZSigVYsIKiaz1QuFB+W5RExb+y1pzvwi9IuNXNZ3x562h44df92E/G7kQtpgz3pr9JgRt5KakJzKcpqYD4tNzCxcOM7YDlSWjsbMoj6o8FnS6m16QQzPwMnbcWwI564i+3PYH9mDlhc5fwUi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418217; c=relaxed/simple;
	bh=Inx6cgrkShQnbg5cQvua+6FFGCNnU2WKAhHUl1xxUJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKxu31zu+4zduvvLOtJBIYku4N6FmgHx/WtXnKnK53jwkId79mwsrvTgCGhS93VB5F8oMPg8Bg7kmwbgqCeiqXKYuAwedGHD1+L9S0AQZojt3+Ae9I/BmaNAkmwIeaIgnZWdaByf/iMmVkM+/iWF9QxtUFrT5j2ZNjnDqMv2sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g63hbSzY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757418214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZfsNktiY5EeJ33gIhfo8w6nygoXQJt9oz6VGjfkKEBQ=;
	b=g63hbSzYtAOzxqTf/aFkxx1KNSi/NJ2J4789Y77DnBdt0epeTBqEIU+wCR4XWiW5gOgNbf
	yVgeG9vshbaH6cn3mC5xgU21xq3Nlk64VPHb/FI3yJDqRDh3nUoW5qbJ7kUVnF3mDqedFE
	VrZCw6MkKl+aCGrq41SzbYAuTm0Lh6U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-JYlzBZ6cMsqjLRn0oboVnw-1; Tue, 09 Sep 2025 07:43:32 -0400
X-MC-Unique: JYlzBZ6cMsqjLRn0oboVnw-1
X-Mimecast-MFC-AGG-ID: JYlzBZ6cMsqjLRn0oboVnw_1757418212
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dcf5f1239so21454245e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757418211; x=1758023011;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfsNktiY5EeJ33gIhfo8w6nygoXQJt9oz6VGjfkKEBQ=;
        b=NpHGESvct9MMgdiyjwijQllt2oFJEXnQHlB7xvFFCBFZg8Yx9+w5qxqbNOTGpxW8gp
         BzhA3Y624I8stzkiTLt3nywhrMgnpCqgoj4KbYAAOwciDYVZk1YMvd9SW1gf4A4JRUUr
         lMjJZ6u2YyjN8w0+4j/pMuNSByKswFfljoDit22zzhSYCRXKHFkb8jCh1qBDioeJy9KL
         FRO3RN2XbDAVG+WmhbSe0YxAdlPqPVtKrVOjsshV4bnZ9hOV0VSHkGR9qgPmX4oAOwGf
         pzPlyvs44M8G3wSdxCFujsB/aNHHC9uFeY8agIqsZuZY4Yp9W+DGNIKIebdE9ffWulrA
         yiGg==
X-Forwarded-Encrypted: i=1; AJvYcCUg/cUJ13en78kA/oQSq3Zygr4wSfjfjeaPVoIh//8id4RASuc4whJlRCJf0iBAHuS/ZsYkpRXpKN73bNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgh+kibBCEArnZZ2dah2ilj4buwDcEO8cT07Wy+LgP4vcVP5dX
	W3bFefLwpPqIm1WTeaBk5kpsZsFDL1w9C4Ua9ey0BtQRAm/QPxTgqx47xCl7sQTnVYebVyd1YQS
	dR7FpaHBlTwAlsjYn/naukiRAVcweFJcksEEdAfm0pbVLq1dvqSTz/c6V3teyrGcrvA==
X-Gm-Gg: ASbGncvi8LYdT2e9C0HO8dKiup71NROmKMJFceWTfyZyS0/lLhrwuRCTDzDDVTguwlc
	4w90+9oELpXS/qieBZF/jMp8+QFFRmCvQqMaH/ZSTKihR90IyIP1JiHWRWbGOleyQG9K6V/VCym
	vLKWxpQaG9bwYfNtexq2gt/A664dbZ158sB0gGgjhx35dRILn+qzs+CfUaKcmangJnX8f5Nym8H
	wHvjcWz1+Rn2shsT/caPeGoddW0+kHCy2OqVL5V/BEJ4GwvRu8SPwhBGf/Bw7fSmkUIL0Owsc3C
	L31sZqbx2heEGKSnWzW8RXZZOFo2IKQMZSWtTJTZSryQU+5NnkOv2I7nWl1ivPgepTqqsQ==
X-Received: by 2002:a05:600c:45c9:b0:45b:97d9:4127 with SMTP id 5b1f17b1804b1-45ddde88188mr92336225e9.1.1757418211536;
        Tue, 09 Sep 2025 04:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJoKdOB5PemUWBhPxYUhvzLBwqsvjrZuiiRzLKO/WI4N7BBAhfeDUq9Rg/ZPYt77RdwSoTMQ==
X-Received: by 2002:a05:600c:45c9:b0:45b:97d9:4127 with SMTP id 5b1f17b1804b1-45ddde88188mr92335895e9.1.1757418211082;
        Tue, 09 Sep 2025 04:43:31 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a41f.dip0.t-ipconnect.de. [87.161.164.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f607sm2331885f8f.51.2025.09.09.04.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 04:43:30 -0700 (PDT)
Message-ID: <0847f0b4-a02e-42d7-9bf3-797a753d3304@redhat.com>
Date: Tue, 9 Sep 2025 13:43:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 2/5] mm: uffd_wp: Add pte_uffd_wp_available()
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20250909095611.803898-1-zhangchunyan@iscas.ac.cn>
 <20250909095611.803898-3-zhangchunyan@iscas.ac.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909095611.803898-3-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 11:56, Chunyan Zhang wrote:
> Some platforms can customize the PTE uffd_wp bit and make it unavailable
> even if the architecture allows providing the PTE resource.
> This patch adds a macro API which allows architectures to define
> their specific ones for checking if the PTE uffd_wp bit is available.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   fs/userfaultfd.c                   | 25 +++++++++--------
>   include/asm-generic/pgtable_uffd.h | 12 ++++++++
>   include/linux/mm_inline.h          |  7 +++++
>   include/linux/userfaultfd_k.h      | 44 +++++++++++++++++++-----------
>   mm/memory.c                        |  6 ++--
>   5 files changed, 65 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 54c6cc7fe9c6..68e5006e5158 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1270,9 +1270,10 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>   	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
>   		vm_flags |= VM_UFFD_MISSING;
>   	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP) {
> -#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> -		goto out;
> -#endif
> +		if (!IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) ||
> +		    !pte_uffd_wp_available())
> +			goto out;
> +

Same comment as for the other patch: make the 
CONFIG_HAVE_ARCH_USERFAULTFD_WP part of the pte_uffd_wp_available() 
check and better call it "pgtable_uffd_wp_" ... available/supported.

-- 
Cheers

David / dhildenb


