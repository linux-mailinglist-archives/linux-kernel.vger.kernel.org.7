Return-Path: <linux-kernel+bounces-749483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E7B14EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92822168BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BB1C3C11;
	Tue, 29 Jul 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7w+EVmW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F01C2335
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797491; cv=none; b=FHY5k0BzDHG63au/LChwQaTrlpjOmI3Mm75zBDzA+yHFXScnW3Xm9xPJVI0Q8NanH0Oxc0Do5kylLaotEw+n+G0USFCMCG1StksPriI7otdCnEOLbFiKPorFAUAA0X2SbZesA0Ym1LfA02oaMEfxj3vKJOkGJR+IhNplVI7Y20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797491; c=relaxed/simple;
	bh=D8y+HFblsFRCGPIGJKPRmabb5Ykt2vVTKa94c4udzuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPVRdx9Or2x4usT2UqkF8fBq6hGEcVduQbFBEb1rLwfWn2j4/eNtBNW559Onk+opgdXY3O9OfJCDpmhaCKOZVhDwWhulacQS5OR77k2Oa80Ho04VTgLfGN1Epn2EreYTnt0DGug1uG6Cr0UOUDRYCxbCxCTWPvds6lmjXVYBE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7w+EVmW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753797488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rsCCUQApP9CC8DKwwUvy60D3l2hcvtSPFJWH4AWrj1E=;
	b=f7w+EVmWN88DIKuaEHpq8HWSmlAERF4j0zZ7y3lPRIZsJbjqA3n4ZVq44MbxfVdnCzK7h6
	W6phb6LG7g8eHP4FNiZwnCVc9v2gubs8yQ7vFIZISHryADPNV352HmB3MuUW4ug3ekEAQD
	7sO6s42ktyjztPf/ceS/FsXcCcROs10=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-JnGG8v24Mjqouav_LKwawA-1; Tue, 29 Jul 2025 09:58:06 -0400
X-MC-Unique: JnGG8v24Mjqouav_LKwawA-1
X-Mimecast-MFC-AGG-ID: JnGG8v24Mjqouav_LKwawA_1753797485
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so444840f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797485; x=1754402285;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rsCCUQApP9CC8DKwwUvy60D3l2hcvtSPFJWH4AWrj1E=;
        b=mDKjXALeVv3bf7NbgXjsVX8WB41ykHoJ37ATupQpCXVJZKbIWDIaLvLkQquGRFDWCI
         pzWH8Fzm3IIkploLgAmPIJVcr3q20RsSwzQZrGJWbEQLZa+EDMONV0iNng6OvvzLDz/8
         Vzqf/MVG5o1eSrM0DJRZvXrgAacsQb1h8ekXbB0upfpZXoEUYNT389Ha8lOugVEsngyc
         L2uI39iQBBBCOReWLGTGnYewujmDzNDOebU5Mq/sM6IkKzkMbglBfKhUJ5Nw6ygNNmMe
         ThgBz1qcDngdStjtjYXQhaHKoeyL/jcz/8bIt3nlhzAAXxTPavhdGS24Ei+2dgTGe6be
         tIcg==
X-Gm-Message-State: AOJu0YxifNSL3IBJHSNFnyGBH0g0aGXux3IG75AaxFw5R26zAOxIXgP3
	mR849KoSNCrHTSjatkd0x0CpwnZjwyWP7EmWy+bjsTHgSU5yyZbKyd9Y8U38dA8iF6oIyi09LzF
	9EkkhM20SsmGw7ZiOzwOX4dGAOaMt88yw6c4wA76kGmFgOQ4G2yviUTBvZEsloHzlvQ==
X-Gm-Gg: ASbGncuPqKZfYlbmklOPZhTpKNKB2mYC7vsAaOwmbePvzCjHkDCUbSk8JyYqnY8r6XZ
	l3F12lWe+jRuigdp8zyFNprYvIGI/4+44peXR7zTXmq/7C9OsFoDZ8Cn4OpgK4R/t/IQyxeMtyW
	78mpjkQvUanV707GZu6OszGeUHUCd2fREN7pR3N/ZELnrF2Zz0KkAjvn4QqpEv6HzGn1gr68k7f
	Qrt90Jd5cOQh7BDd36qokAe6bXJeV/TwVokyErRDpu+Pb8rate3Xu7j7gRXlzg1Qt8l26pdTY8z
	tHDxPG1AoKu7wjlMepN1fqL+nJj5VAvtuCLk7lZDoDBddOoL02TWTiLxremu4S9A2X7uuilP
X-Received: by 2002:a05:6000:26cf:b0:3b7:90c7:325d with SMTP id ffacd0b85a97d-3b790c73843mr1932667f8f.6.1753797485025;
        Tue, 29 Jul 2025 06:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6/lwTxd6DH/vJTkaLgAGz/uaV/Fd14fWfaZW5uHWl0CIlnqV9QqBAeHRZ55YhVyNGyUmhVg==
X-Received: by 2002:a05:6000:26cf:b0:3b7:90c7:325d with SMTP id ffacd0b85a97d-3b790c73843mr1932579f8f.6.1753797483137;
        Tue, 29 Jul 2025 06:58:03 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b788f5f28dsm6505110f8f.10.2025.07.29.06.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 06:58:02 -0700 (PDT)
Message-ID: <1c821e8c-1d9e-46ca-b0ab-3a897878d883@redhat.com>
Date: Tue, 29 Jul 2025 15:58:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /dev/zero: try to align PMD_SIZE for private mapping
To: Zhang Qilong <zhangqilong3@huawei.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20250729134942.900517-1-zhangqilong3@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250729134942.900517-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.25 15:49, Zhang Qilong wrote:
> By default, THP are usually enabled. Mapping /dev/zero with a size
> larger than 2MB could achieve performance gains by allocating aligned
> address. The mprot_tw4m in libMicro average execution time on arm64:
>    - Test case:        mprot_tw4m
>    - Before the patch:   22 us
>    - After the patch:    17 us
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   drivers/char/mem.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..c57327ca9dd6 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -515,10 +515,12 @@ static int mmap_zero(struct file *file, struct vm_area_struct *vma)
>   static unsigned long get_unmapped_area_zero(struct file *file,
>   				unsigned long addr, unsigned long len,
>   				unsigned long pgoff, unsigned long flags)
>   {
>   #ifdef CONFIG_MMU
> +	unsigned long ret;

Can we call that "addr" like we do in __get_unmapped_area()?

Nothing else jumped at me ... so I assume this is fine?

CCing mmap-man Lorenzo.


-- 
Cheers,

David / dhildenb


