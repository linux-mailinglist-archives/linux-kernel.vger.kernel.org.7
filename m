Return-Path: <linux-kernel+bounces-826827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6CB8F715
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6907A867C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613127BF89;
	Mon, 22 Sep 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtdL5xX8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBF2FDC27
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528917; cv=none; b=RlgpTflKoeXGwgmZBO5GTtUkbR/Hv3pHTxofABOW98UZMNeipVeS8WL8VObj+Kbpc0SCAmpyh3SNtu2nXiz7wg2axfv7OSXanl3+FBNlVpDfU+cjgyUyUU/Gt5QdXhd/7w8a595gu2PrIGJxFeZTC+fZfk4+DhXt8kSrcrP93E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528917; c=relaxed/simple;
	bh=JrwbMA9CofaP0MU/JdRKJ7hhJRS7WZ0jypv3E1foo1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4U/GHWMAMlX4bkYlkVhiFlI6N1mjzkAd1TgRDIyVeZvWD5Vks8DJfee2R65BLdlnEYMXpPxA5wze9JT4KA84Dr15hVS4pZf5n45RyqsKHm76hKIGVzLjCZ/SuMbNFMS3y3Nped1ZRPQaMNCLk4f1gQ4jst1BGcfPX26W/t7Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtdL5xX8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758528915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y4bziSJL9UR/Qm6TyxCwaAd6httEA1G3wcOzxZ9HxEk=;
	b=DtdL5xX8oIPzcMFSZPWpy8wnJ4/VGswSK3T0U+IdxekhcRLP5Wpmga0YfI2/7zA2EQJBS8
	I3CxLr3OREdfjj2C5ef4ixEw2jTGWMi+suH/MrbgSXNEPAmxpG/679cg973RtLFOhb7lyy
	X/j/f0Nz6h4KEAvuWVdh6rnTvTnWzW4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-kkgXACNhPdOfTjUlXghYUQ-1; Mon, 22 Sep 2025 04:15:13 -0400
X-MC-Unique: kkgXACNhPdOfTjUlXghYUQ-1
X-Mimecast-MFC-AGG-ID: kkgXACNhPdOfTjUlXghYUQ_1758528912
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e19f00bc2so1646625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758528912; x=1759133712;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4bziSJL9UR/Qm6TyxCwaAd6httEA1G3wcOzxZ9HxEk=;
        b=OLgbMFtutNvI8HhcGEbX59oPHBZYAnegMex/glX3OXUi3MBdIyDZanR636FV7I+fqD
         gGkkW97C08Cr9shQQquJ+l+XhKq++/Yj2t+Je6ULijCfu/jx53QcL3dnWkIBlTlH/Aqm
         5Et8kEdvnwhXERIr+h2GkwkPgXxb7tBbQ9B04IGUv1jpHbUDr4EJx1EzS7kHbM2CxJp3
         yUGRF4vAUdeH3niXt0oZxSPutY/gFkDqViAGDZ61L3wXRxxzUaHmPonR2e9btH3x6F2c
         rOwj1V6+BW2p3TnP0IGbfy9fkDc2JmyC0KOTqR4b4Bsb0V6aR8PAPqQs1he0mi0woc4x
         VWqg==
X-Forwarded-Encrypted: i=1; AJvYcCWkmvqakwx6NW8mp7vfp47XN9SCF5TMRgQTPCiDvon0yUn56Ym2OnzkomnrCivIRAvT2pdeDriwScRTizY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ll3z6ISP3/WuGG0xXvlOcnZhT31FeKrXK89MaNDLLme1rcC1
	qXZUMf71iN5SOSaXLBc5WPTKsNQOEkxykMb5D/6MuHZgOxZDLy3b6cU+jZRuzS8Sa8MkNYiq1P6
	w20Ch6sXhZ8NncWA8IcvHmeVOYSwzsgyFR+qXedwIffY3fsLY7VJ5CkOAOBBu268Fmw==
X-Gm-Gg: ASbGncseMNnn+PLrSDDMKAkTaG7HlMmyGuVwPJpzT4GEV7QNFWPwAWjRDg3u/z51V7r
	VsnoT93KrLdxpshfDYYjYPCDDKwtAlgEpztNaZ0OC+yYbKrbO/bsBlzLobvJGvnXQlZU5dkCTA/
	DSCHZi/J6GAxy+YLCh7OWjO9eSn9MfJLClh56P1u2LpMMfbcfM6Vf+UGvS/nVAXn+5iNMvd7IL1
	wWiQbN0UO5ELxHykcAlSXxtK0HZKJyXM/b+sv4UUVeeYcPgb+uKjcXzBwNqUz8ooVRz7CvFHzVZ
	K9j3rz+6QHGwTavtp0qklrWwyiwLbLKqJe6cZH1MW2UEKcs3kz+nPD2HLJE3XOE7xrhqvvXfq8+
	hLdnbxfgVxMVUvv/ALDkfa6NtJbWleMKA8MVdol+YdhBbWxZ0Fox6GQQrMKZXefs=
X-Received: by 2002:a05:600c:45c9:b0:45f:286e:49a8 with SMTP id 5b1f17b1804b1-467eaa88162mr121467145e9.30.1758528912077;
        Mon, 22 Sep 2025 01:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENAOUSzL/l8cJci7x47KhzFNMFxxaLQqca9eiUHlRz0tCsa6t/rZmY1rYxxG86TEOI2EXtEA==
X-Received: by 2002:a05:600c:45c9:b0:45f:286e:49a8 with SMTP id 5b1f17b1804b1-467eaa88162mr121466795e9.30.1758528911668;
        Mon, 22 Sep 2025 01:15:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee074121b2sm18833236f8f.27.2025.09.22.01.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:15:11 -0700 (PDT)
Message-ID: <91041fd5-ca37-4a6f-981c-74aa92bb2291@redhat.com>
Date: Mon, 22 Sep 2025 10:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] ARM: memory-failure: not select RAS and
 MEMORY_ISOLATION
To: Xie Yuanbin <xieyuanbin1@huawei.com>, linux@armlinux.org.uk,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 rmk+kernel@armlinux.org.uk, ardb@kernel.org, nathan@kernel.org,
 ebiggers@kernel.org, arnd@arndb.de, rostedt@goodmis.org, kees@kernel.org,
 dave@vasilevsky.ca, peterz@infradead.org, Minchan Kim <minchan@kernel.org>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
References: <20250922021453.3939-1-xieyuanbin1@huawei.com>
 <20250922021453.3939-2-xieyuanbin1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250922021453.3939-2-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.25 04:14, Xie Yuanbin wrote:
> For memory-failure on ARM, these features do not seem necessary.
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
>   mm/Kconfig          | 4 ++--
>   mm/memory-failure.c | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 034a1662d8c1..22eefc4747d5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -742,22 +742,22 @@ config DEFAULT_MMAP_MIN_ADDR
>   	  This value can be changed after boot using the
>   	  /proc/sys/vm/mmap_min_addr tunable.
>   
>   config ARCH_SUPPORTS_MEMORY_FAILURE
>   	bool
>   
>   config MEMORY_FAILURE
>   	depends on MMU
>   	depends on ARCH_SUPPORTS_MEMORY_FAILURE
>   	bool "Enable recovery from hardware memory errors"
> -	select MEMORY_ISOLATION
> -	select RAS
> +	select MEMORY_ISOLATION if !ARM
> +	select RAS if !ARM

I'm trying to figure out why we need MEMORY_ISOLATION at all.

MEMORY_ISOLATION is mostly required for memory offlining and 
alloc_contig_range()/cma -- it controls the availability of the 
"isolate" bit in the pageblock.

What CONFIG_MEMORY_FAILURE soft-offline support wants is migrate_pages() 
support. But that comes with CONFIG_MIGRATION.

And isolate_folio_to_list() has nothing to do with CONFIG_MEMORY_ISOLATION.

We added that "select MEMORY_ISOLATION" in commit ee6f509c3274 ("mm: 
factor out memory isolate functions").

Turns out we remove the need for that in add05cecef80 ("mm: 
soft-offline: don't free target page in successful page migration") 
where we removed the calls to set_migratetype_isolate() etc.

Can you send a patch to remove the "select MEMORY_ISOLATION" independent 
of any arm changes?

-- 
Cheers

David / dhildenb


