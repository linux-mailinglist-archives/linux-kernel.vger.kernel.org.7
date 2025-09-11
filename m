Return-Path: <linux-kernel+bounces-811719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D14B52CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC26A17845D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4E2E8B71;
	Thu, 11 Sep 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBhU17mq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39851D8DFB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582397; cv=none; b=KrPmLdtHkJV4/S6Dcbf1/aAcVjNdWfTSnPemSMFGcGXRBxB8AyLA/VrSmP1z+baeSibTr7Q0M1tBMzVMbFGMFBKMZizJZhLdI9+ZTjOn1yvsCnd3Di5+r/MBY11YGq4Y3ZWWDNCTBso8etzm1byggP1C6nFEEJ/D2X8CwNQAi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582397; c=relaxed/simple;
	bh=r5S+D08nhdy00jx8pRER3XEb2UaAieSDvWL9Ucn+Eww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElMZYPYi/LREhsR9RBF5mVLozLn+IEn2yBmfeUkwjY5gZjzDmRb1BPH6HBusiWPlltiU52cIiiiL5vZtrIc2gkT2QtIZvHV10ml/I1UP5VaBKhvSIL5mA3SC4CsN581NlPb22ovekBv3SuKj05dPS4xnsnvtAOJ6S9UfT/UfPig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBhU17mq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757582393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jqvxrFGoKwzq6HOXbEZWonCN2PoHo7ME/A2UQBvA62k=;
	b=GBhU17mqG5J4ZuBcJo7I16wc7JhcaldC/bpq2RYrF0SjgIC91a2Jf3NKq2m1rVBzM5lj7o
	ETnoRLNjWKW8GKDKWVyg3bHInUy/VtKtNpblz7GIgWv+0ZVm37qnV21hlFGDOnGQ6l+XAd
	yYkB/9bsSdQ+O0A5CGLVa0rCqcgGR7M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-fzloCmaWMPiGQ2nlQMnvQA-1; Thu, 11 Sep 2025 05:19:52 -0400
X-MC-Unique: fzloCmaWMPiGQ2nlQMnvQA-1
X-Mimecast-MFC-AGG-ID: fzloCmaWMPiGQ2nlQMnvQA_1757582390
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so3376305e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582390; x=1758187190;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqvxrFGoKwzq6HOXbEZWonCN2PoHo7ME/A2UQBvA62k=;
        b=xTN0WEzfmIKLkHPY5yYusyPPu+uJ8HKJizhQn9COPlxMn7xeJws76XEMlJKeG+0w3C
         qnpXOaxld1vcF2tP59sf3tyrAKUfC964p8EHc+W98i/9l7YQpI4J000kLbUgbMbA8HfB
         F+qZDLemkYGdzJbA9coLKQEAA26hOHtK1UFOc/tHdLtTaPLFUTmgkqxPlsbNy2m/M+No
         no0+0r2HfgxxHM5u2jYDL2it6gaOdsZLNwzyxlfgIG3k47BIwUIE7j/f3+J056ktlxLY
         vloJ08sHROdKHqe3ZL+2G0npe7dogyf2iL17F1b8kPOZivJrI8vrrjKxXP/hdCUVcCOQ
         75jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD1abjFoBRz2IJV7IPqncA1aU+a97tY8qR2z5SvsBHW0IgWd4SrEuIHqcGB6rh3P8ydDTvR/C052OBnVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTr6ZmTWC1vpteENzyp5jk88NMj+AbzJQg19jE9zfx/NcZ57n
	5yQpKlfDAU1/FJdMDUbawj71e8zCG4o93sPzZrGgQRm0T8bkMZFoSnH1utHLf23B0nPLem80yl7
	u50d+xP+rxg1hZxKw/hG6E26s5vZAkMhwGjEXxJx1cfG02fSzgt4+1RjAtVJz6pKE7A==
X-Gm-Gg: ASbGncuedGW+/BeIi7hbGjbdVZa72lwT+yNAdiO1mhQt/LuLinxGP76mO4OyV6s/SS2
	ry/Ut72ZpnlObU+bMQs9FKaD7/p1+4g7RJyq4FehD8sgQJ71eG9DgZRFsZf8IgBYqvi2hI0zPsA
	Nw8g0b1lYEUZap3DO1+U9pggiJCkMR9jr3P/3zRs/iG+8YQEppqoi96s7U69OHbr4xNgU3eyzIA
	VDR0CRKdb5Ke+OkQlwlqjeqCDO3Dr4t5Ix/pYzjC7FmK9+4N9J2oZLd1yK/nm7DD7HmdGlMjssh
	Cisvhl/a9MMyHqvTvwi6LOOTpKjn9ABypUX9Bi/+fEDpAUC0Z154d9v97Q02C+DCl8KFe9+RKRK
	gpBK9RiS00RA6VUi0qITcoAM4ovrVXODumIqZw1wMiANrUoqjocKhQnDm64Fkov54Vps=
X-Received: by 2002:a05:600c:1c2a:b0:45d:f88f:9304 with SMTP id 5b1f17b1804b1-45df88f9508mr49652715e9.30.1757582390015;
        Thu, 11 Sep 2025 02:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElPcM9LFtALiOOskZX2/Ss/9NXKYHViXTmcmi6lQqEpUEj+KyQ+W4vYPkCN10SgIv6EX1K1w==
X-Received: by 2002:a05:600c:1c2a:b0:45d:f88f:9304 with SMTP id 5b1f17b1804b1-45df88f9508mr49652285e9.30.1757582389541;
        Thu, 11 Sep 2025 02:19:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01519a47sm10642965e9.2.2025.09.11.02.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:19:48 -0700 (PDT)
Message-ID: <185efd78-56b6-49b8-9c8c-b5363ad70a6d@redhat.com>
Date: Thu, 11 Sep 2025 11:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] mm/mmap: Move exit_mmap() trace point
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
 chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-2-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909190945.1030905-2-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 21:09, Liam R. Howlett wrote:
> Move the trace point later in the function so that it is not skipped in
> the event of a failed fork.
> 
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5fd3b80fda1d5..b07b3ec5e28f5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1310,9 +1310,9 @@ void exit_mmap(struct mm_struct *mm)


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


