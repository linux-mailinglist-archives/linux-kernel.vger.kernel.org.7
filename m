Return-Path: <linux-kernel+bounces-836270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC1BA928B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6703D1895FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF930506C;
	Mon, 29 Sep 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzxkQUhZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A23002D7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147730; cv=none; b=sOV4z6c1aS7CMJRLKnJBv5Zb62vupmn/Cik4QHk24TpM6GoKZ9vSm3oSD/VI2V9ZQIFimia2y3usfvEF5yy28F4Z68+kiQlbWc1IdT/VrV6sR6bDbhguT8mSulBv74faIV4yXi17QMC3l27oCouPvUTWqzHVxU+MTejT2gAUusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147730; c=relaxed/simple;
	bh=YhMDe02a1VtShALTTCTedfb+Z+4tQM0CYjy3gPxPyb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKQ2j5R8wyAkB8VgRnY+UxQ9OxnKelC43qAunpZjbKAF0KKcaXOWTrH2ZU2c3yicUqbOeIQE+hCuWyFeKEScPfU7fnYQPnT8jbDTvZ7HEAHNT+no2crHaESJHp9bX5yfHSwd/r0YrXxD4tOdidST1KZldLaexlpGcpjiqBE7M2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzxkQUhZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759147726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/2C8z3BvZ37i+W1qRKrfd4nTUv4+udd1r6DfyndiPFo=;
	b=YzxkQUhZrDLtWB433x5+zeN9By4M3ogP0cjvEx8TYWy4BmhtebmWOJdcC+tmN89CBfyHfW
	8EUwPkKQE1+4sddq7z1WL1YJPVPzRgYIVOUwO5QOjJkgvBnheKu2RPw4S5zhc5162Alnne
	T4KOOIupS9wJyY55ub3gUZE2tzP49OY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-V-nOjR1CM86M-Etbz3xSnw-1; Mon, 29 Sep 2025 08:08:45 -0400
X-MC-Unique: V-nOjR1CM86M-Etbz3xSnw-1
X-Mimecast-MFC-AGG-ID: V-nOjR1CM86M-Etbz3xSnw_1759147724
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so3876724f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759147724; x=1759752524;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2C8z3BvZ37i+W1qRKrfd4nTUv4+udd1r6DfyndiPFo=;
        b=WPSGWii4cioeLAVguiTMhhQb3XcexR00qc1E9wBBMMH+Vgai85S3W9PxcMjk5hBEky
         e9dzJ2bLHvU0oU76HzqjMYAM2l5mLB2avwX9G7+NsDEJlI9Y5Ovq7j1oshOXff6Wvhk0
         1LybyCYjJyRQzyY/yVLnAMxPAPo74bOVNQxXokKU+Vqp/D+k1XV1nfYcb+st2o53eVHK
         SxeP8xDTgZajJFFfvO+oVEZs0UftN7yMJXIlJEPIyWb6/ibGhovs4j2OJxbIU2EzH+Ey
         Yc7GnCm8N8fdn2sCljtPNQimJcznYAspGoooFG+96qCYoR5DctZ4/+BuhVzZb4PBBp8J
         ySlg==
X-Forwarded-Encrypted: i=1; AJvYcCUv77ozgnIMlcoUhP3Vu4BD5eWW5978eDVr8UEHmVSTMFc9oNAJ0IYlDZ9CAmAsFpmsaaI2DGi0jw1r6TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsn0EtuvLeOv7Y9MuWwjJNXDbRlLbz48ihie7/8iDoEGeGdZf2
	GNmwpbg9JsvtmZlrvR4/ROP/9NZE4ObWkxv0Jk9zzWrf5/r7ezz5crv4buwSnrb4P3GQHtbNd2P
	M/FQJrOjKfGLPZhyJq3F33em1AYTai2LM5vgGSsllspWRe6wHtLobwqGqol5qUgc2lQ==
X-Gm-Gg: ASbGncvNrlb3J//0e0XGIcLeL8A4KdLRbyejWyfH6avVadPssp45qApH+3lMCo4lo9A
	9uM72Vv9XJyF006FP9SGjQhQhMugVh6ov5XBCMzq77y/rWAM0q0DzvfMgkVMPZgJVY59VUgLhTg
	0MtemMyWgGjGyK1v8vM9tx9gUJqFHaby4VeRaIAKuj0Ld9uf8cn3RmdgmFizWSmMuT7Mgc1Nm5k
	KsNFGtLwJrWbo9PdJ/DAKLZaM6qbei6HXTC4q4Xbpooi/3ic/FNpsvZ3J4FU62nawekdlv+68ZI
	e7gmg/2EfeIcdX9Bh07jLo1uUioyrESiVSoShGhAcuhnRZvgINohsbyTmcxUHxrKXw+Ldz6tnQ8
	80fVKaRI3/fmNNT3RgGyXxcoZIEH1yqaoSEX/J8h+FSfYU0Ji/JPmZ/acTZCmWyP+6bOk
X-Received: by 2002:a05:6000:22c5:b0:3ec:d78d:8fde with SMTP id ffacd0b85a97d-40e4ce4bademr16036220f8f.44.1759147723996;
        Mon, 29 Sep 2025 05:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXL74x6Ol2HLL86/jmUACklwVrE0RHmZV4bM+T2zEkgMHV4wxha4M6+wdviHiMVFGWvfQUA==
X-Received: by 2002:a05:6000:22c5:b0:3ec:d78d:8fde with SMTP id ffacd0b85a97d-40e4ce4bademr16036193f8f.44.1759147723585;
        Mon, 29 Sep 2025 05:08:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f39:1500:c90f:7794:3c33:4164? (p200300d82f391500c90f77943c334164.dip0.t-ipconnect.de. [2003:d8:2f39:1500:c90f:7794:3c33:4164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2bf35sm18195490f8f.53.2025.09.29.05.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 05:08:43 -0700 (PDT)
Message-ID: <267b0346-41ca-44aa-9fcd-91b02c4c4b53@redhat.com>
Date: Mon, 29 Sep 2025 14:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/mm: Drop pxx_mkdevmap() descriptions from
 page table helpers
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250929120045.1109707-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250929120045.1109707-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.09.25 14:00, Anshuman Khandual wrote:
> Remove pxx_mkdevmap() descriptions, as these helper functions have already
> been dropped (including DEBUG_VM_PGTABLE test) via the commit d438d2734170
> ("mm: remove devmap related functions and page table bits").
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


