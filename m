Return-Path: <linux-kernel+bounces-840889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB9FBB5A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0929D3C5EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD093AC15;
	Fri,  3 Oct 2025 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rp9uKL8C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BD31EA6F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450662; cv=none; b=rk1YSlsHPXdEDudCrPdgSHiznd748bYs53r33aWlRfYKh/RFPozrxZeP9Q455UdxviFwiJIJ0uDdc0KtimNKb0hbaMOWgIjvyM5UJPDqOlNVB/JPvp4Rl/8A5MFXMALsxuLKgluHog9qE0MBdJ0uIaJe5y+fCYMZyQt1rnQWfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450662; c=relaxed/simple;
	bh=vMDFerzdP8VHE03joxXkumgXWrhNKPGaMdosOIrdU+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bm/KUicPMGnRWb4unIR2f0df8YjyiVYkkKkaGXwLclJ0Fhhblu2Knzi7bNMzRNAV9s0UwBaHpEtaM8Bv9LbBFFhI6LzOmDzorySs+lUvRgluytw0Rk/UZsgRMMdiBZbGcumbycgvZMIDML7IGuXY6M+0JqXeFtbEeiaWEMAfkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rp9uKL8C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759450655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxESuiqnyWWA26ID9dPTIMFHWjBzQCaSkf0/moxm4ak=;
	b=Rp9uKL8CmpVzcSK+iQui1UzlRuMurYZG0DfkaHkMyMSFzyHtE3oxK/+4VGv/LkeShxYqFp
	N245VK8VlbjNQ6qCeHwnUXO4vTtu4IZAxqFt4EO15PClAIuuatOV5aAcmnjeWjPoXjBj5e
	zJdwP2PC016LJ052iFPJiLOFsTen7co=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-DvYew8jCO1mNSwDVY_mIrA-1; Thu, 02 Oct 2025 20:17:34 -0400
X-MC-Unique: DvYew8jCO1mNSwDVY_mIrA-1
X-Mimecast-MFC-AGG-ID: DvYew8jCO1mNSwDVY_mIrA_1759450653
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26985173d8eso23300755ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450653; x=1760055453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxESuiqnyWWA26ID9dPTIMFHWjBzQCaSkf0/moxm4ak=;
        b=Bsf47Y6g1YcfnhaEf+NhHdk2Rga56jKTFe6VwnSQNHqiRg+ZQ//td8SenLZE1jtVHY
         1FGSreGoDrq22A5EOqkcz0NNgtpNuTIUXz7yYrrDytIAAUJWFXVV2SJe2TFsQCuxIF9d
         qBgF52dgwcfaDQ9xoi50O3Mnp6pQJcbT17z1QWeR68arLaovAmXznCIeCRF8onrztvqJ
         P1337i9Ud3IpCPjCAHdRpTgbBR2K+22cP/l9UOpXqHdAoHQRl/OJYqACD4mtPGSZPnmJ
         BbDwZszLSP9YXSgeAhtrlZ5ZpuQXBfxSfJR+YMn0vbHE5l3xXfJbCvcgR/nc0bzwMrrD
         ZPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0+/36oKHgGnnC5Pw9+rbBgRoyvOoPo3SG7350QaSDDYBFFFfwKrCpsgcY8grLZJgm7Wp/G+kUif9XZXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbV7lTkaCV8xdQexkRV93Pbbx83l9KEa5ZUIJUcqQSi1g/Vasv
	l8ZIm39AjwBEPZ7uA9t/WOz9Ib0WNbj9NLlh3HmfYuQewj53Lkq2SASc/GT04Nrnm8Il5+kCxs+
	Kl9WpqNDy+qn7hm76Ny2TgSe6XBMHsyVlOY6PKmUqVEJ79m6ypLGFOJu3qBxc9OfhNQ==
X-Gm-Gg: ASbGncvjLAyMM9WbNwNsCsfeO5vVWsxAsu352bIAvWybG9Td6o274VT/5VJh806ga7x
	bzQ4oFtzHMoeQrgkDwrjnXsUVx/D8vn5Jcdgp8dC/k8FUT6wa4KypHfOhmy9BDjmUMd+3JZptS8
	0RU/lcvUQn13Yl3jXBsbSsg+DCH8jo7YGMBNhymFsucg2MEpFd85ygREkbNdF2nCCBAyLmAmlSk
	gVwJAkIm00WrjUlg3gx43hGz0x4KCRsgaqw4goPrXX+FjGr6MthKiatu+JKEWG9GJgICO/EcEZ5
	nOgR53eFel+RqoIgO0Wt9w+Qdm9ZUwNeVu0L/0JgfHTrtuuUEt/19aVKBbjFKuL4ZUwvpfr1pFq
	BQ4vJOnxNnA==
X-Received: by 2002:a17:902:cecd:b0:27d:6f49:febc with SMTP id d9443c01a7336-28e9a56096amr14497455ad.1.1759450653596;
        Thu, 02 Oct 2025 17:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZHBudX+t5P5dhIAoHtlCGZ+jK1znqx2KJ3DZHFAw2+dbJ6/l4LnIeuh47XhZ6VySQT/LLTA==
X-Received: by 2002:a17:902:cecd:b0:27d:6f49:febc with SMTP id d9443c01a7336-28e9a56096amr14497255ad.1.1759450653268;
        Thu, 02 Oct 2025 17:17:33 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8444sm32362015ad.86.2025.10.02.17.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:17:32 -0700 (PDT)
Message-ID: <37614dc9-91dc-445d-b289-1346e216dcae@redhat.com>
Date: Fri, 3 Oct 2025 10:17:20 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/29] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-3-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> In acpi_count_levels(), the initial value of *levels passed by the
> caller is really an implementation detail of acpi_count_levels(), so it
> is unreasonable to expect the callers of this function to know what to
> pass in for this parameter.  The only sensible initial value is 0,
> which is what the only upstream caller (acpi_get_cache_info()) passes.
> 
> Use a local variable for the starting cache level in acpi_count_levels(),
> and pass the result back to the caller via the function return value.
> 
> Gid rid of the levels parameter, which has no remaining purpose.
> 
> Fix acpi_get_cache_info() to match.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> ---
> Changes since v1:
>   * Rewritten commit message from Dave.
>   * Minor changes to kernel doc comment.
>   * Keep the much loved typo.
> 
> Changes since RFC:
>   * Made acpi_count_levels() return the levels value.
> ---
>   drivers/acpi/pptt.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



