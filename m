Return-Path: <linux-kernel+bounces-667888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242CAC8B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CB1BA02FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E608E22F774;
	Fri, 30 May 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+pAZ8Wu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911522AE6B
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597634; cv=none; b=PNZJKXGoP6zI2ch0+/j8Fz1eF65AgFBHZ/l54qvv9qCfyJTMvZ2IdqhHniaGHkR2qk9l2c5ejfEoB0pvYNdnir0WUgxQSBK0ZfpDWuZZdMWMH55YiIPYlFwQRyzuChnMyaDO39a4IxTf7EkxCcbOmpHtpkvjtOnknvqhOO0fO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597634; c=relaxed/simple;
	bh=DB+1yl7APIInm8MCrBxZ4Qwh/WXcXEhVDIyFl5OmcI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oni6FwyTQy30YbYhUP/fr8VthbxxY8z4R1nRgyWOlTID6T7lgOBv5ekheNQzZF6TiQyZyIGdy3X06Fw0+DYyzhtSk7R03PV5IP9EHMJVfBPS/H0805SQOsqop2NiUpQYamoVDYNlge85eDh4hdF1gQARkrTF85LbNNPAWW2q3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+pAZ8Wu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748597630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3HsXX6R0HPP/biqLepMPHpr/VTNhNhquA8c3ePXroJI=;
	b=D+pAZ8WuD9J24oomtH2M3ZVs3+xWmPjRXiblHrzlpCKBeOwF2MqrydB4nO5ecYBGGi7hA3
	6uN3D98SD1AA3RATM83/XsTqi53eQQxdCKpvHZ5potyZwj2EkxTN8iKYOrdWm5v2hYDGJj
	62hgVe/yS04jgXbO2hf8fBGtMpJ4VYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-0Im-0xlhNzWE2dnzsEa40g-1; Fri, 30 May 2025 05:33:49 -0400
X-MC-Unique: 0Im-0xlhNzWE2dnzsEa40g-1
X-Mimecast-MFC-AGG-ID: 0Im-0xlhNzWE2dnzsEa40g_1748597628
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso774231f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597628; x=1749202428;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3HsXX6R0HPP/biqLepMPHpr/VTNhNhquA8c3ePXroJI=;
        b=Z7Cpu/a/eORPCww7zvUbGI2DjYNa7zmrmReZoJJpHJHbl5McWrXkSlE8/Ss2qvWBr2
         qvMXlcv06b22+gPPWa4pdjLCcDTa8t7sZiZfiGQ5clLwbKxu2O02b6kmCqUeMOTHpQua
         djdV1c5RAgCLkUC5wfSKkHCE4GEGdWgzwWz0dskVhnnxSa+pQ57Cigx8sSfCqL11dkAM
         vS06EgcqCg/rxo0N5jjGC6/ub0RiRiTArxKjWCf2wvtyR0EMzWZihkpxFSic7S/jrzXp
         N+JJpO5fJ6jlkODnxzilpfI8xlWxiXBZ16+xWLxOIkxCXFZrZOl+mHCE8lA6VqU8Y2h8
         pq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq6Fgm/p8d+aLYRhq5o9KaqYFHYbBR15S06Q9fzRUXAzSkxPYcomc1wHNqGYLzsjYSPZcRI/6jdMwoN3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQiDzyoxtJe3rb86CFtNNHb6v8zRt5flMna14G3bospvfC8g+
	YqFs1hqUoS6JJv8rSSqvgrw8GGXWPIpTdwMXAbfNTafJFvjPW2KNCq6aufUDhYAx/Np612jc5Vv
	x9imqKbHptoutPmB4b9XYT6+TDp29RjXRLXKigqIT7uxG/7UkZvgGEoJmhy939FrIEg==
X-Gm-Gg: ASbGncviETj0KcAzCc2iNuJ29mOb9pU3Ae19v3WnBQt2bAF3Af6MxrNhPnWpXe67ckd
	1IFxE3X7BdANM4xmJ1qrQ5xwZVIXapgic4bHVUvKCKlvaVeu3UBUYbXiHowHeMYBnzSdesfHO6D
	5hkiB/Z0SO5FRqEPCJzgwDI+Mi7di41032HjURE96m/H4b57+K24K62MBg0kmP52ryk/RErDZmE
	geovAsCT4+mcTO7Z1xJSuokbm00kCco8eDL/HFKKcnnlEWiUNiPke8YQtXTQ7AVkRIW+ImurCYx
	t9RAczheuvsBjnQGJ4C4IyEw1ZnDxwx5mjl2+kwepdJ1tnFFKPuelC/QpdoQDboZBjBKwM8pspT
	qxnmJ3flQGi0M/VV7bNdHkVg58Cmek3GgRFHQSqs=
X-Received: by 2002:a05:6000:188b:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3a4f7a366bbmr2070887f8f.34.1748597628397;
        Fri, 30 May 2025 02:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPLwoEcfpG65ruS1QubjzGQLrQH9J6REe/EFj1LtU5rHML/KjwauHHFCNN+LVLagp2fysdSQ==
X-Received: by 2002:a05:6000:188b:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3a4f7a366bbmr2070847f8f.34.1748597627996;
        Fri, 30 May 2025 02:33:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972d9sm4415633f8f.64.2025.05.30.02.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 02:33:47 -0700 (PDT)
Message-ID: <bbb19f59-54bc-4399-a387-1df9713fc621@redhat.com>
Date: Fri, 30 May 2025 11:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com, jgg@ziepe.ca,
 willy@infradead.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cb45fa705b2eefa1228e262778e784e9b3646827.1748500293.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.05.25 08:32, Alistair Popple wrote:
> The PFN_MAP flag is no longer used for anything, so remove it. The
> PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used so
> also remove them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---

With SPECIAL mentioned as well

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


