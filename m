Return-Path: <linux-kernel+bounces-861622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C545BF333A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B61718A1DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3A2D8DD6;
	Mon, 20 Oct 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQv+Sa6J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924D1C3C11
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988411; cv=none; b=BPxx02DWIKbCNGnvTX6rwKoUX2TaMLMQQi9ROGb96jSkJGwV0nQsGrjL6AzorFCPg7tp6gKdyXt80f9A2+B594QTZYAr2PhgmdEgaHWr04cmt+PTiLNjj7IHOtXjcqp8cGVUSVlD/OpDVuhpt5esjA5Tvk/JK9O6D6DngGvMq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988411; c=relaxed/simple;
	bh=vxL4eTLs7yhxNYDXcAIfQ+nyLiInBV6G9WxtlOGz4q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJSscCqmOz4Bp75CxYEWaI1egrjii2NdwZaDUmW1kZ2ohBYic6u8Hp0t2l/nMmacQo0g7pJ7ndKjOokqyyNG3sv1MGpgxR13cQnR+QwL4FaMzz9M0hbh1Bor5A0dTdELZ6IhyHWMLeowuNJTjCCbqX6evN8YRO1XpSkwPpjUpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQv+Sa6J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760988408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UTXB7/q8p4TNL9vNa5DPOotMkbp1a/zM+v7YOiHTFsA=;
	b=NQv+Sa6JQvu8B8wBvZGp75fqP2zfbw/izR09vrM8hYnI8B9sIBllSbN4bwo6pwcSOQ+ndC
	4mdWJstn4zCtjYtVWF320Vawl3/vRSm+0RylL2X8pVESX9hB3JkBf9hXqyMsaLk1RpEg3h
	WWyPG8988tm8V8INwuQgD7m3MtRmZT0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-IQaNfCdiP5CxvQS3EQuChA-1; Mon, 20 Oct 2025 15:26:46 -0400
X-MC-Unique: IQaNfCdiP5CxvQS3EQuChA-1
X-Mimecast-MFC-AGG-ID: IQaNfCdiP5CxvQS3EQuChA_1760988405
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso54764755e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988405; x=1761593205;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTXB7/q8p4TNL9vNa5DPOotMkbp1a/zM+v7YOiHTFsA=;
        b=s9AXDeUKuM5J3oDkyjJCO/HOtJ7rlkeHv2Gu5iRTNCndfA2lxYVOtRrbe4UCY3UDX/
         1XkjyYExskd4hRjNKYO1tF5TfM+04WawHIRVZH8GzQhzZdPG6cgoxqPqsNWvXlA99zjw
         QxihI5BDKpW3EPszvqIQagfXGf7VaVSWVpgv6mHdZKZtHeRnu6m9mm752BDSBpm+figl
         xo8z+/fYOcSiBSPHL/uR5qWsYQq2XP54PffeZ+tf2W0wyPqPJ2udGWdHK60eexCi7ooQ
         wSPYHZxrImMjH2rb/i4BCxyEvgXUYyZfMdUOjdp8cZ1vQEFqV/GADIAZmRmjOvxTnb7+
         avTw==
X-Forwarded-Encrypted: i=1; AJvYcCXfrNsMtWHsj0aYGSXCz6SY9aaY3Rz+JSf0KLwcZGKbNL6zqmO28b6Rx8ckefxgUpuIgKr+eza0I095dAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZt/ht7HwC1hYXFVp6CiSaGj3vCllPfVpIGPuDC8sWktZWyw+7
	3qyBi55dk64XSG6ZW9rymxd8xJINNzACDNauO/QgG4sBSvBB6K2OC/U7klWDpBTHSVfDaEe/sj3
	1yrlUqNbGlwq69qmdrEUus1g5MAFD+DPuDkti0v8CgPcPUAnZ9lGD3REFy+4dQluVoQ==
X-Gm-Gg: ASbGnctTXH6WIQ6hk8esOzRjOyPg1QiVK8QA3NXzdRvSHMHiM/dPafMOs8sa65ws5OV
	+n/OUzZdbXrsJBz/RcNFk2dNblJGw9FRdC77VeZ+5vUGnMP7Dxv6RNcSk6iplZlPdXxFJ/neZwX
	kkqeSL0ap1LKvc55sH+e7H3sVr291ID2+T2fTym9dB7J1hd36Dg7SrqUDwF75sANu6BNi/OtgfJ
	Dv0Gl7N2QjYWU2MCtfj7eKwLcTIjWKVHnBbrQnvI7wz0yQBOtP/Q8Wih/9/4dFrnb/QjmgTyjX5
	kfEfSTH9EZ3NIm9E080fCsge+XnhdZhnVZQMsFaAyaMHWr7udzMuo2eXwt6idRSOGcyLvhC7iPg
	IbS1tt5z7MMz6pyMe0oAQc9XZU6oeUlXDnHzicbR34nJZhiFf9Qg+nNFT4K4yn/H1v9I+GVQtcO
	koLUs/g/d1TvCVjqqTbeq5Jwya5jw=
X-Received: by 2002:a05:600c:8185:b0:471:14e7:e988 with SMTP id 5b1f17b1804b1-47117925d0emr107430325e9.35.1760988404970;
        Mon, 20 Oct 2025 12:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfhRTNhNg7YWVfxTym0dxgSdzchCcacq4Q770pmVWsBNDJLEfc+4CUgQteSBDZjY1EjbrX9Q==
X-Received: by 2002:a05:600c:8185:b0:471:14e7:e988 with SMTP id 5b1f17b1804b1-47117925d0emr107430195e9.35.1760988404582;
        Mon, 20 Oct 2025 12:26:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ab11bbsm2352275e9.1.2025.10.20.12.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:26:44 -0700 (PDT)
Message-ID: <7e43294a-03d5-42e5-bec2-5fbcfab97b69@redhat.com>
Date: Mon, 20 Oct 2025 21:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_isolation: clarify FIXME around shrink_slab() in
 memory hotplug
To: Manish Kumar <manish1588@gmail.com>, akpm@linux-foundation.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251015175041.40408-1-manish1588@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015175041.40408-1-manish1588@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 19:50, Manish Kumar wrote:
> The existing FIXME comment notes that memory hotplug doesn't invoke
> shrink_slab() directly. This patch adds context explaining that this is
> an intentional design choice to avoid recursion or deadlocks in the
> memory reclaim path, as slab shrinking is handled by vmscan.
> 
> Signed-off-by: Manish Kumar <manish1588@gmail.com>
> ---
>   mm/page_isolation.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b2fc5266e3d2..2ca20c3f0a97 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -176,10 +176,16 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>   
>   	/*
>   	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
> -	 * We just check MOVABLE pages.
> +	 *
> +	 * This is an intentional limitation: invoking shrink_slab() from a
> +	 * hotplug path can cause reclaim recursion or deadlock if the normal
> +	 * memory reclaim (vmscan) path is already active. Slab shrinking is
> +	 * handled by the vmscan reclaim code under normal operation, so hotplug
> +	 * avoids direct calls into shrink_slab() to prevent reentrancy issues.

This is the first time I hear about this reentrance issue.

How did you come up with this explanation?

-- 
Cheers

David / dhildenb


