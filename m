Return-Path: <linux-kernel+bounces-762091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F2B20205
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10F2170303
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D62DE6EF;
	Mon, 11 Aug 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYo+ZDq/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54C2DC348
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901671; cv=none; b=ObHOpxgkiYyygkaj9yducFC6L1j1l4L4ZuDVoR6v0dicsJNsGCETzXchOXK21QfPCfq+bS0nXzVVXcIX690YYJo5h5FQt54N9au4EizNd/LFLEDSCd6pEJZ8P0IJ0bYC5I2lIrs1igDYTxUz+bVPaPoo9ugXQoTNsDT2hAXzeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901671; c=relaxed/simple;
	bh=I+6hKnSAOT8DmAnBQnUqsrWi0oIaDTREn40HGJNPF5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjqkFz5bvMBGM81P+bx5DQsnoXAP6YDy1gpVwcJHnlt7JlGbyoXPwqHXUocSdfzjOEaUna303JHpk4T9jpUuET8tPIig49sN0nYMPhf2XF693YpONdrwWWse7+h0sfwX69Ziais12nR2GOHxyzhY3/dSSku8HNhaKiWP14zK5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYo+ZDq/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754901668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zxLpCqZMNmDoDJ1iE4RjOi057qTqSgyDD/7XZbSrpzs=;
	b=eYo+ZDq/G5NuEAp9DYfSRL8otol275QjZABynL9uIDi9fWQlgpsNsLO91q59IGpBTb2nON
	lZEkdK7auDcdwmC6/zpE9BdsoHqW8HfflN8e68//9vUKiGog0j54VI2QUrwue+4xITrguC
	eA9OdylCDbkLXz2Y5XdCndSerLKeXCM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-5yjK3k0KOsyslNoMa_a7Rg-1; Mon, 11 Aug 2025 04:41:07 -0400
X-MC-Unique: 5yjK3k0KOsyslNoMa_a7Rg-1
X-Mimecast-MFC-AGG-ID: 5yjK3k0KOsyslNoMa_a7Rg_1754901666
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55b947b5586so3546816e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754901665; x=1755506465;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zxLpCqZMNmDoDJ1iE4RjOi057qTqSgyDD/7XZbSrpzs=;
        b=TxzO8I2Its3NuGBwEwCrkQW73HlQkf/mWvRsT8/PJ3PmWxBmDi93MgLhBxB512cGkn
         o8s1wjwsm6h1dWjUpnRdegxKSnFmRFgjfVCtSbuFGXL8mNTnjZEjVEgZHX3jCPhYixpK
         RRQ3Q+hPLaFSMP4pmHNN8wobjQj1Yzn3+bs3s5Pz0VBLptgovMM4FQYIt0QPTZtzH/YC
         K33zedfEWZMiMfZsQJUGxhiFwjN9d3jXbOXwLSup7qQsbYltGuRAnMZRD2uzM21QzGl1
         9z0rlZ/WTzgZ9DTqc1i3GzTceSa9ELB599evOE9Tm9O5W3cF4+jQgqVvo7+/mQ/i97BK
         V1WA==
X-Forwarded-Encrypted: i=1; AJvYcCVCeyROFXSHl34tR9KrZp1YOIp6A5GWbbgYu/akwYvsrLHtA915ylEt9lowwrv9UJx+zaQ1GyG7K9aFgDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgD/pMVrvMBwhG4VofCpsqTbItmJWRYNZiavIt/LuZpOKjrbkM
	sIlcm89SlTGIADVR9KnfPo34tTgrxJqZ9SD8xGYd5EJ4go5fxslrIDRrLbU2/G2dlAtT0l/3cAN
	cqO5I+1KvvN1/X1ItYm4mGhC0YRD5W4TVBUE0gePIA5xgKndUqJeARGiSgiilZVrdbQ==
X-Gm-Gg: ASbGncvF516kWKZx97Cgep7GSNLQOFEHwd57PwOqw0uCwBgnzj8gNszj12WaKyuLM8s
	lkpOy4V+eQX8SBkiACXvc1y2tl304WXFOg658qRzuqQdmbkSB2S5ckjQGPMTYxTUhmtP026zaO/
	qxF2C4Iqpj6j3M89O6Z8nNTKPA0LA2v/IkMSKZI408Hq97KRr8a20vocTvg6xNSUAP0Y6DwGzlC
	BD2Xpeuus62U53h3/8PYo0PiMq3tzkssho2aBeGMnlLvT99LZ9KmQQrDsiSzyuHSeLeQg6ywSFi
	2k6SQoXDAvtCu0ZEroo80/KnPKlUP8byKxpMODWs8qj01tfFdCejCNURh7mOwoNHpeC4c8vpmXC
	ke5AAU7wSTch//vxHf3BXFRYg6+ftie+gHaPW+qZQD/kEoXqvtGrW0C/5HJMUC3Y/2NU=
X-Received: by 2002:a05:6512:3d23:b0:553:2c58:f973 with SMTP id 2adb3069b0e04-55cc016008fmr2795256e87.52.1754901665500;
        Mon, 11 Aug 2025 01:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/fZRrwndjnLBh1r2I7omkHKsEMqLQlX1aVWcSYS/CQSX3iDeImRxXBNUBP1Cm+AH8ex/oMw==
X-Received: by 2002:a05:6512:3d23:b0:553:2c58:f973 with SMTP id 2adb3069b0e04-55cc016008fmr2795212e87.52.1754901664758;
        Mon, 11 Aug 2025 01:41:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm242806725e9.11.2025.08.11.01.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:41:04 -0700 (PDT)
Message-ID: <2d84e83e-5fca-402b-a01d-811003c2551e@redhat.com>
Date: Mon, 11 Aug 2025 10:41:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] mm/mincore: avoid touching the PTL
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
 Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>,
 Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 linux-kernel@vger.kernel.org
References: <20250807152720.62032-1-ryncsn@gmail.com>
 <20250807152720.62032-4-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807152720.62032-4-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 17:27, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> mincore only interested in the existence of a page, which is a
> changing state by nature, locking and making it stable is not needed.
> And now neither mincore_page or mincore_swap requires PTL, this PTL
> locking can be dropped.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/mincore.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 1ac53acac239..cc4460aba1f9 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -153,13 +153,13 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   		goto out;
>   	}
>   
> -	ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	ptep = pte_offset_map(pmd, addr);

I agree with Jann, that if we move away from the PTL, we better have a 
very good reason (+performance numbers).

-- 
Cheers,

David / dhildenb


