Return-Path: <linux-kernel+bounces-750475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4BB15BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E96B18C2087
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82326CE18;
	Wed, 30 Jul 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lwr6NR3W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9119D065
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868040; cv=none; b=pjjFmTvEAgfoqvFpVM/tWwI6aF5ZSOZpkZTLsy+CggHCC+YYiUwRzXpHS+HTrjOcqDHL2lMXadO0pmcFT7xGFLW44hkodpkD59TbZtB7nUUKMDfuerP2Fmf/VTar5lz0ItEboMa5TwzjX1z1h8qvX2Vu5ptK95R2GVciJ0zquV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868040; c=relaxed/simple;
	bh=fYJ5cWH9eVhTJD0OFuFvafGAL9ud5pxaw4gX2NyLip8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ngxo8LI87st9ji8Fzy48DAGcAxXGIrDQxMUUESAfk5lO1QBi70KSqZIkozNSv2R7KzSdsUjnwwi/j5BwIs3ac3JGuBE7getx57MR/YBHxx0tE5zA6kDTbChcvpgJ4fumk2ww/e4xQgEY4/j+ayBUTHV94AEOGH8Ir9fcCo4v1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lwr6NR3W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753868036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9dB3I85IIjWNvE4JIQHQQw5CakHFieVehnVtVZ1A800=;
	b=Lwr6NR3WSl6eBHEFSsnzS/013HQXS7VscM1X1upIML5P2gqx5lvEBu8cgFjDjuJhjTMwPd
	Wcp7oxXnjnHiU2CBT7CWoi7gKZBgdpcOwXeFQh5IhfxVRI3BJxIhlACyIcrdjVZEL+VF/2
	Z4mqjVKlEcmaKs/9iDFVZytO5bdfers=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-o1tN1iVbNaCutgl9lekIZw-1; Wed, 30 Jul 2025 05:33:55 -0400
X-MC-Unique: o1tN1iVbNaCutgl9lekIZw-1
X-Mimecast-MFC-AGG-ID: o1tN1iVbNaCutgl9lekIZw_1753868034
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45896cf24fbso2723475e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868034; x=1754472834;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9dB3I85IIjWNvE4JIQHQQw5CakHFieVehnVtVZ1A800=;
        b=Z5sx12Axi8CAsV0ItDa5RG4RJdylKsp9Op6DQv1rren5iBW8FpSOv7cqw31WjvGk4h
         niCMMj/MBVzm7ARd5LjWyRAdgp09gDhXjkAeNO5+FLt5F8bRl4DFZY4sO+8Gy+X7gTaM
         pHw3JebTTOV3iol4Flts3+dABkFsm0J/tmc+wwvY32k3LLA1W18qDYANWvNsE5xrCF1T
         GIIR9HWLw4F5TPmVGn7KO9M+Q3hvD/uLOgOsLhVpOc6S/6eDdlv4shtw1K0UJdQDePMW
         GN1Qf3zfCssvxDu2ZONth+DvsygveZIH0XOfo9PJSa9Kwqmy5oFvxi4m3GNFFjs+uz85
         2Z4g==
X-Gm-Message-State: AOJu0YyXWB90l6UF0fJLKZ3vI8tYfSceaaordq1zRi6cf1Ipi3PV7W11
	tDgRRj1VMzVPQs4GBrSXND82bSn0Yv7WMgPDyatsqKx8YwiChkt1ah/sX2wgglIPUBXAQ+0a43p
	48kyMIxLYscR/nn8rL0qIssKXErZoMAYmTS+WALHVyYjf3w5+S1zk9/MSsPBjYeoxgHZkmKTclm
	UcL1U=
X-Gm-Gg: ASbGncstAAQ1Yfl+1jycATxso8KSzj9z7+4ccrInAVw7luH85CREA2NJlTs4XpD9iuo
	M8dEksabhBok/gYmNQ12txA/xkWHByDLQ/M2jcIbsoE+OgRq3dWr6eWBkpe4r1CfrLcV1j54zjD
	7iwf2HlrCBavuIGh+WHil5tOsgpDbPSUgiFlKTjQ35Drvqy/hfBUlbVtLnP77SOxxfcSibJftcL
	fiJmP6lLWVxxy51qf/QRJ7Dqd38xibE4DkOx/RKYJy0kl/IDEWe4sHWt/idP3nnVKdMd2IoY4aA
	04lne0NXPEGj+hZWDbzirUsLznWripDm3bShufZDc7YoRpb7qUW+XClxGMwSfQ==
X-Received: by 2002:a05:600c:c4a3:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-45892b92f27mr25932395e9.3.1753868033770;
        Wed, 30 Jul 2025 02:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZSG+Z046FRHGgcF7sdTdkrQP1JKAyuyUZaQmC3OED0RsGRysnOCOYp4QBSHYN4g2LAf7jrw==
X-Received: by 2002:a05:600c:c4a3:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-45892b92f27mr25932115e9.3.1753868033333;
        Wed, 30 Jul 2025 02:33:53 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953b3471sm19091135e9.30.2025.07.30.02.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:33:52 -0700 (PDT)
Message-ID: <eeac8523-801a-4b9a-81f4-6539ce1955c2@redhat.com>
Date: Wed, 30 Jul 2025 11:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend v2] /dev/zero: try to align PMD_SIZE for private
 mapping
To: Zhang Qilong <zhangqilong3@huawei.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20250730091905.383353-1-zhangqilong3@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250730091905.383353-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.25 11:19, Zhang Qilong wrote:
> Attempt to map aligned to huge page size for private mapping which
> could achieve performance gains, the mprot_tw4m in libMicro average
> execution time on arm64:
>    - Test case:        mprot_tw4m
>    - Before the patch:   22 us
>    - After the patch:    17 us
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
> v2:
> - Add comments on code suggested by Lorenzo
> - Use IS_ENABLED to check THP config
> 
>   drivers/char/mem.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..c27cc89bd02d 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -525,11 +525,18 @@ static unsigned long get_unmapped_area_zero(struct file *file,
>   		 * so as not to confuse shmem with our handle on "/dev/zero".
>   		 */
>   		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
>   	}
>   
> -	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
> +	/*
> +	 * Otherwise flags & MAP_PRIVATE: with no shmem object beneath it,
> +	 * attempt to map aligned to huge page size if possible, otherwise we
> +	 * fall back to system page size mappings.
> +	 */
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return thp_get_unmapped_area(file, addr, len, pgoff, flags);
> +
>   	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
>   #else
>   	return -ENOSYS;
>   #endif
>   }

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


