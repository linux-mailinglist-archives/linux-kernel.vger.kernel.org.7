Return-Path: <linux-kernel+bounces-788256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF6BB381DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B665E136C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BE2FFDF4;
	Wed, 27 Aug 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9mBWfNr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF01553A3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296071; cv=none; b=LrPi9eVXx79wRi64EIO33q12wwJlmQ09+0OWrk2tqCwom73MSrdtL7bvF4VhOEaCnwQkpDvTOa+qInirRTPWTOe2z5upoN+Qt8gwBbBpd2BKdZ0pg9BYqNQpO6XjE9X1lYHOrzL5i2qS8wwoFdIbYTIGuNIrQXYOWa0ywvUSAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296071; c=relaxed/simple;
	bh=Yu3OU8V5OSrBBmPo1v+PYWHQ6J/s81XMeRdZfnZyaYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7RFNZqof/VGVpKgFaDRpkvjCoBGYdbwLMJxZhqBM/IwLDHLcJXyx8G5Tvb3S9Sb90BtxzLGHxSMLrGfw0v9VOKjbGdHTJJ44IhmijzxNTZNvv6WYBTnVcZB2i1ebvLy3RZ4qa95TYpvbHNUBrVs3yMzWvPsCVtcFdyLrfFxzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9mBWfNr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756296067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NWINZR72AGUB423TkOc4D8qtFil+Ep+hQK7BWdIPlw0=;
	b=e9mBWfNrDg2ZKXqBd4zBdIcJgWOs29Ra1w9miTJAqMYWwkhH/vEEfJabCJXzOqsHbUi7x8
	ndlxkwrb1FGQxh8IHC9GY/2HtzFgKgMHqxOLUFmjvgd6ibVfOaCRR9RKUuYv6+cEQBGmz3
	B4OWXo70GLvKKt9LE9sTqtk8ZFNCPqo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-JBWAGuRENmS07l1DdkbX9g-1; Wed, 27 Aug 2025 08:01:05 -0400
X-MC-Unique: JBWAGuRENmS07l1DdkbX9g-1
X-Mimecast-MFC-AGG-ID: JBWAGuRENmS07l1DdkbX9g_1756296065
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70dccf2f31fso18570996d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296065; x=1756900865;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWINZR72AGUB423TkOc4D8qtFil+Ep+hQK7BWdIPlw0=;
        b=PcTvXWLihQsuDNPEMuFEtm+LcI9HOWdKoB7VeNvZHwgthaGxQ3qbOC95tvRbKyLGc2
         sfcnAUfQ2xJKxS3NFABRoNHYxV7VQzPQxrLRu+Kr1kAlVHN8xBzvLJgW1K/hF7M4dY6x
         g/zmeRu8Nz8/iFTYHAFdUE/wRV77HwLD0XjCwHr1Qk7sbUcUYmij9dV0Z7eQkGFwsq1m
         MUvpa7GRq9AbvQHND+OC/2AYqg01izN3EMrWuhJD5ka+cQuwiFgBFlZEfMvyAoYzdTc4
         7m8He22bQfGMcvuFBI4HejGAHZLFVS3pwQmEwrX9NFS6cwo+jS1ZbURd+AxcTy3KwR+f
         F5QA==
X-Gm-Message-State: AOJu0YyDkwJA1wSBhdQ+QkhGKcxao+K7Tmh3qP939047El3nulCC7LMK
	Ut8+Uf3SGNgIonZ6QtZ8dsNbP9ejYpMQRIWsEiOhKCQZsJVq6LLwFm9khVWeFCV1X7WNA/MG8Na
	Mn+SbiacwzuC99r/ygFDyaFNfBjPh1GTahHGq8WcGmA3zFh1a4T1ADKKeWkPLuYGgKw==
X-Gm-Gg: ASbGnct2QuqqPPgcR68nIei4d3B5n/fOtHpz8h8wDgcjOw0/QPIH/TwO4x9rvQargTI
	x1UQpCk3Xtx3U/4zkH05ZRTrpfXuNXeutgR8myXlopC86vCGX4dTUO0QZuispNLeNwe/Rg59ip1
	Q4kkaJ8DRalMvog6VlNr5EH1pi3G1itOrTaqwUda/1If5mevtrO4h5NwPhhKM+qUsABC0/RT5Ga
	Kye3ZHFvb0Ptu/9njInWFcdHdo0Hmo0dhqdaA+A9lv+n4e4KWdCcerl2EzHmEeUfaM3rDDgm2+e
	8/jI5kYMsfbzeqC/Q77ylgFoIQ462YRjKG2NNGJGVIU1Vgo2Yy+THOloa8A/Xg==
X-Received: by 2002:a05:6214:212e:b0:70d:c9bc:6281 with SMTP id 6a1803df08f44-70dd59c076fmr59734616d6.34.1756296064532;
        Wed, 27 Aug 2025 05:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcADX4G7Pyj6o8x+T3ZNqZCUs7nd2m7BaU5rckVG8ObCg+LGLJBVDHW/Z4oABiPM4EWrPqHw==
X-Received: by 2002:a05:6214:212e:b0:70d:c9bc:6281 with SMTP id 6a1803df08f44-70dd59c076fmr59733836d6.34.1756296063956;
        Wed, 27 Aug 2025 05:01:03 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714cb55sm81940206d6.16.2025.08.27.05.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 05:01:03 -0700 (PDT)
Message-ID: <5ee2b684-94d9-40be-b01c-b0538ced33bc@redhat.com>
Date: Wed, 27 Aug 2025 14:01:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
 <20250826205617.1032945-8-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826205617.1032945-8-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 22:56, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   drivers/virtio/virtio_balloon.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index eae65136cdfb..d4e6865ce355 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>   		page = balloon_page_pop(&vb->free_page_list);
>   		if (!page)
>   			break;
> -		free_pages((unsigned long)page_address(page),
> -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   	}
>   	vb->num_free_page_blocks -= num_returned;
>   	spin_unlock_irq(&vb->free_page_list_lock);

I think you missed another nastiness of similar kind in 
get_free_page_and_send() where we do

	p = page_address(page);

Just to call

	free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);

-- 
Cheers

David / dhildenb


