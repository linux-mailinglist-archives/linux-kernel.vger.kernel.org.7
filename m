Return-Path: <linux-kernel+bounces-739116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF4B0C20A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CCF163A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDB28FFE2;
	Mon, 21 Jul 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqEjcedO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE031AAC9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095601; cv=none; b=WC6X5Usq0z8PejJ/83RkPVppylBvcVFPlEs5a4POG0pezDoBm9QSMRtQ3KG9/Ai7JfyFw2cQ/bz0Jme7PqEH2gpdbOnWSn7b/FCu1OYjeE+3afXLVUI0E58J1x1k0c+HX2OO2FgRkKvhMmCqZRWX3nLexE+7RdOsF2YacCkX85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095601; c=relaxed/simple;
	bh=qNwnI2jeSvXX/p4AVgS/MqmiFMO598KRcl5/3bmE2Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V6gItH8qiOF0nYuFAG/IcKo39OdxYQyNXamEBjXo0GAKBDaETyhR/p3lqJ//I+wFgTVbTh5kPro7QtG/O9NpAkQgt7cl+8o9yh9h3eb4SwK/iGgpk3oai7/LMpXW+Dr+99zEjiMJCSE9rnTQjfR7cdXTiJLtgiR6Y4+20Mv13lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqEjcedO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753095598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YUwfrnEr54WO/D9KJE4ox7AeGC4PJKzGk6wzt45ZFEw=;
	b=bqEjcedOBYOwYj6h/htrNbXZwHnBFH1K2/533SxrwFk3qMrLXrHs7KUMSZmEGf2Oe0Tu08
	tQf+TG6WrQD09cFUyTSl+xwUXkBiooLNRn7HMZmRaLTaNeV//GZXDqqX0a5+m4Cpsq3VgL
	9iU2oa23ygmUYUuv14ZRsLF17nKp6ss=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-lsm6IIjrOGmHNk1zppGVSA-1; Mon, 21 Jul 2025 06:59:57 -0400
X-MC-Unique: lsm6IIjrOGmHNk1zppGVSA-1
X-Mimecast-MFC-AGG-ID: lsm6IIjrOGmHNk1zppGVSA_1753095596
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5780e8137so2335892f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095596; x=1753700396;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUwfrnEr54WO/D9KJE4ox7AeGC4PJKzGk6wzt45ZFEw=;
        b=V+PbX4hgzAeVXcka/G7mnWVihYRpLeKdBdQ9a8JaWMozGVOhm8SOvXUDtGzzT1G3NI
         teJTxl1icnWxg9hqvatsxuseGL/wtCm990oBBDpEYjgeE3aL4MTUL3TJM2BcsahD4UsY
         7GGI5tZWw1gEGs7FcNsV+F5S920a37SQPHCkM/BCFfMdwKnOnVTr9BHFl9l/6w72UQHl
         JF1NiFBmVOQuKjedODQa+YDOGjpgD4M3W7bJy5UMMLm3WhT4tJ0HZnLYtng7HG8SMLxo
         jryA16rU/bykr/6AjX04J/5W+iI433kHrdoBwQy96FJ6RKoegk5cC/+CWxyIFY+1PK8v
         pHGw==
X-Forwarded-Encrypted: i=1; AJvYcCV1a9gjuUa2RJC0r/Q1SS1JWbbrA+k7MmK0VPThcQ9mqwa98tdDOw6IT2CmZgeGwBgsx/umuf2efqmjJmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHckFV5Q/Zw1pltRfmNSKX/zGZpFac84IkXd1GIY64JxJiO6T
	GL36Q3zLy/OujHrFzoiDxKJqh3PS4USSenQ92Dv2ecGKK1Xqxj3kzhfr5Aty9KjtOA7Sj3lvMPh
	ctDV15GASO7l78XhaoYBgT4YHQNd1Y3HfOsst2maG/ekxfPKo3tYwwcHfraySoonmU3sVKuWGs1
	29
X-Gm-Gg: ASbGncsLVY+8B+lyBZmj4DEmOUFgbxgm9FEm4mLyjLh8vOy7lnV8onpkXYOkk/ri/nV
	uQ3HIaEnWqFIyBgVXbg6GJSIVhWqCfnqx4dlGy/QocFs0TyZtrOZ9o4D1anmlHrRwVP17BHxIFk
	yO/CfkoHxuAPz2llcswumY5eqNMMCv6mgNVugiaiUXd3oetQOK/g54ruRDRv8P+l5RzgcVNeodr
	ZU5QVNA60oSqrxYBGfi7ritp50g38Ue0qpdYBNoXc6YcgRskR2wGyFt3yQAkI7BAFlNpx/I2RDg
	uS26CInGURZWA7XU1GesnHNmBEQvKDdTGRXt35iDGlEqedGTGzoBZn07aUZnyiTWn6vHEKExOwD
	VMv9FwSPLDXqdy5oTgaKcGPWMGWpUIo7hmYrlK+N09f4rwJf40dEpSBeVe09mLYV4
X-Received: by 2002:a05:6000:18a9:b0:3a3:7ba5:9a68 with SMTP id ffacd0b85a97d-3b613aca420mr13323145f8f.18.1753095595602;
        Mon, 21 Jul 2025 03:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmVVaTtpJ46G9XBGQk7ELSRWjwZM1pjPX+4QunKQfxixsUoV7pyvlf4IJPfZzeI5Fg9IFNmw==
X-Received: by 2002:a05:6000:18a9:b0:3a3:7ba5:9a68 with SMTP id ffacd0b85a97d-3b613aca420mr13323114f8f.18.1753095595096;
        Mon, 21 Jul 2025 03:59:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm10197701f8f.58.2025.07.21.03.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 03:59:54 -0700 (PDT)
Message-ID: <2cae64a2-7fd4-46ae-b4ab-8924db99154b@redhat.com>
Date: Mon, 21 Jul 2025 12:59:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: cma: simplify cma_maxchunk_get()
To: Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250719205401.399475-1-yury.norov@gmail.com>
 <20250719205401.399475-3-yury.norov@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250719205401.399475-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.07.25 22:54, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> The function opencodes for_each_clear_bitrange(). Fix that and drop most
> of housekeeping code.

Not sure if talking about a "fix" it the right word here.

Acked-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>   mm/cma_debug.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index fdf899532ca0..8c7d7f8e8fbd 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -56,16 +56,8 @@ static int cma_maxchunk_get(void *data, u64 *val)
>   	for (r = 0; r < cma->nranges; r++) {
>   		cmr = &cma->ranges[r];
>   		bitmap_maxno = cma_bitmap_maxno(cma, cmr);
> -		end = 0;
> -		for (;;) {
> -			start = find_next_zero_bit(cmr->bitmap,
> -						   bitmap_maxno, end);
> -			if (start >= bitmap_maxno)
> -				break;
> -			end = find_next_bit(cmr->bitmap, bitmap_maxno,
> -					    start);
> +		for_each_clear_bitrange(start, end, cmr->bitmap, bitmap_maxno)
>   			maxchunk = max(end - start, maxchunk);
> -		}
>   	}
>   	spin_unlock_irq(&cma->lock);
>   	*val = (u64)maxchunk << cma->order_per_bit;


-- 
Cheers,

David / dhildenb


