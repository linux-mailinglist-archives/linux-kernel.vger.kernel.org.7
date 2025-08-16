Return-Path: <linux-kernel+bounces-772190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E337CB28FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6172567A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A22FDC48;
	Sat, 16 Aug 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMixcwFe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F91D63E4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364425; cv=none; b=oVmBKOff6Zjgd5uWIpWSHyfVt9rSruyQq9hdGQNqzMZ3Px0Qj59/S4CjBAXrjEKJtAa9m4lge0beOKwMa51KsD8o8Ls1g8rpIh+2eCVSJ0mOLAu6bo3E0yTE1lfJW3/qrfP/voj7c9RqbI/4ICSTm9QBtgazzLVtVbY3/YUQHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364425; c=relaxed/simple;
	bh=IW5CEFcQA41Q2Ke55rP3xWn372igkq64QCoh8bb25Ac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wk4U6t9gnN9IxOdNXfINRn+0/VErsO1n4CMTnHUaJ+IURjtBtC+GY7AsmaLcP1L60daPct4sqHGJexXutcLJkr32QCcQi15ZkG1dEWI8jROzoTYxhTDqIJAOfXM7plDNLAKT4gZ2DfJB0x0/BdRgzBsqN9XTX8vSqrjY6CuRQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMixcwFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755364422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2cgk6Zbx0vB/BGOo5PYZi9awyuAzqjuvaL4aveRfbkI=;
	b=MMixcwFenB2EpZI1KUgfG56KSj4YYuqNkB0y2lDqb73JyzbueCtJEKbzBKpdJhFivnp2RS
	iewbBaO3lKoCYavlOBAmIB7nCczyI1CWwybIL1PnExy8nIEM2nt0U5JT5LtR/COPzPK6ly
	rhzEcZN2/K1u6pIRCSKaY1xZ64Srg2M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-c7dRMtgWOkOF69Jcwcja1Q-1; Sat, 16 Aug 2025 13:13:40 -0400
X-MC-Unique: c7dRMtgWOkOF69Jcwcja1Q-1
X-Mimecast-MFC-AGG-ID: c7dRMtgWOkOF69Jcwcja1Q_1755364419
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9edf80ddcso1354862f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755364419; x=1755969219;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cgk6Zbx0vB/BGOo5PYZi9awyuAzqjuvaL4aveRfbkI=;
        b=p1zNXbgCrjZ5LaJP9KVH+zGv3AKvQzRRtGY6smKVA3WTuP+3R4v1xTFvl1Y/c/fU2G
         fDQCORTFb4FfCJVv1VU9EeTx/HLJLbOx5GePHHEDlDMahtx/3t22yQKOumTb3DI2SkmH
         pl0CBm598Mcb5eo7+n7f+Jk/sZzSV2NH4S9sSyUjNQvzzVxiEXirKfKoaqZuZW5iFcxW
         I3n6pEbB1Knf+SCzb/F5wRvmzVZiDEqkXdQX/BYQBls2MjUFDtlrHRx2UzEYJWZGXtJd
         18JiaQ7a/6r1g6GbsEtVkZuyuNKHnouzGX5TGouVadDZ319g+f1Gyu2u0MJbUUamaMDc
         1DiA==
X-Forwarded-Encrypted: i=1; AJvYcCW/UPJJWYF/EXSCaei8IT9ZBw5yfeICNw8ObpTZ0i+52F6BJSaUQMQB/8zp+7e6MvuhtQpd3BNnRlro1aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsY4EGQ3Fno8NyqNJfBzDENyXIyOMn6fhlm6WTbX+HJ/OE7wX9
	wzB1J1faT+/N9G5/CiMxDKuXiXKPwuVageZTLUZ5mHELzpOxm/tXNBKI1NtWd28WqQQ3yfAuFJZ
	8g3yUWcdeE0R62D49EYDbDckg/apbNtulWlB52EOude41Eya1N7bnGS481/ZoVWLnhtcRl4ie1A
	==
X-Gm-Gg: ASbGncv5l2wLQ3a5PC68DuIcvfiCoA4ZkvV1aIyknCjsGby53e9o69E6tw1jaJCfPVL
	cnrSegQXS/D4hlytn7eT4KB9jFLurZqeXcXIVSj6UmJvLa52ogQyD2+APD9NMZASNDKLHUf/QC2
	RXEDrFmuoCuKIHFpFL60L+2bKJGUW4h9lpIn2ek022Ti8MyZm/LRX1SRToAtb8hfe7I7XQy517o
	6rRVrsGW9wURNgxiM7A1jjtOyrqPn/Sy6YrVWjn6DnHZbYEVJjSPtdL2ulWKK2FviGmc2YGWvEC
	JpP4TEPaVAy2I6HIUAB1RvbSxjA0rxLS73vq5vDJIOXJGRr+rXVlap8zGcuQLTvi3O2apO8PvDz
	wkcIAIYIgzwlbhp89STaeG2ok15otXqBQBAqXKl39ziQ/0288TT9NzHHFJNJyIMzrg/E=
X-Received: by 2002:a05:600c:1c14:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45a28ff178emr9712025e9.10.1755364419371;
        Sat, 16 Aug 2025 10:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF90eN2Nz0toFUZwAqn9DD5dp3Ri1E/8xuFSl/glYZ2CcKQtMM8PsgWaRo64HcVxwKlIeLsQ==
X-Received: by 2002:a05:600c:1c14:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45a28ff178emr9711895e9.10.1755364419003;
        Sat, 16 Aug 2025 10:13:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1cc22739sm107942655e9.27.2025.08.16.10.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:13:38 -0700 (PDT)
Message-ID: <353ad5f3-2864-4f2f-bab7-5836aceb7f1a@redhat.com>
Date: Sat, 16 Aug 2025 19:13:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
From: David Hildenbrand <david@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com>
 <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
 <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
 <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index a1d2625b5c391..c391435ce9942 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -256,8 +256,10 @@ const struct movable_operations balloon_mops = {
>    
>    static int __init balloon_init(void)
>    {
> -	movable_ops[MOVABLE_BALLOON] = &balloon_mops;
> -	return 0;
> +	int rc;
> +
> +	rc = register_movable_ops(&balloon_mops, PGTY_offline);
> +	return rc;

Staring again at this hunk, the temp variable is of course not required 
here.

-- 
Cheers

David / dhildenb


