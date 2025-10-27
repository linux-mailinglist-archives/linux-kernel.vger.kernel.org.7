Return-Path: <linux-kernel+bounces-871985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED0C0F049
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F124019C211C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76677286D73;
	Mon, 27 Oct 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GILp9eu6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7362620E4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579814; cv=none; b=RXEM1IA1pRb9KQNLxX87Got5GFQGDvAQ3/20Ji/AEJ48te7Je08SX8tF+DV5BV3QOLoZp+FyU/i1UGgv/DbrL4nhJbT6BGLTYpEVOq51RuF6C2MHW1k6pVibvEgCH6Ozpz7IAC2wa3aGykc/mRgV0HyV0Vwx4VAVeef7VapGRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579814; c=relaxed/simple;
	bh=vESuGZF+Ixh2NbMcc6XzutqaQR/BiSg3OOTXXwxKZHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYX90Gx+wqtd/qndrPur+/tDPJBuVIok/DrjCywm5lOO6EhColVR27cqBt6S3MZFBSrk7IFs4lZrtmP6BToHhBkTOXjtqU2GHymq8BPVfbk/BhMLuNoRr+ZsK3KqrP28zwk79uUvKFIC1DmiJcKuQuVpLQG+eMZ13AVtyXIW1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GILp9eu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c89p4IzYtY7pzZo+jzHGxHZt7mqwdmnQ49p8S32D88I=;
	b=GILp9eu67HGpUu2e/ch+W3CNy5oACmosXvex5kp1JB+9Hw8sWIgbytGX4sNz4f063Xeih/
	zIz1PqaxtCkWmO5zUiBXXO/Q2TLsQsRWgbCur2IEObo03PI4SmVHN/4TBkNOt12lqReu5l
	1MhGMBfq12jeIfx0WiRJ7IYboBWKTUQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-cfpV7npWPQ6uPhbipTmpFg-1; Mon, 27 Oct 2025 11:43:30 -0400
X-MC-Unique: cfpV7npWPQ6uPhbipTmpFg-1
X-Mimecast-MFC-AGG-ID: cfpV7npWPQ6uPhbipTmpFg_1761579808
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429a7f1ed1bso15374f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579808; x=1762184608;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c89p4IzYtY7pzZo+jzHGxHZt7mqwdmnQ49p8S32D88I=;
        b=Sf9kdCsMpbI569+XWgmD60lT3kH52gWQHTgjD8iNtWXrsaccKEfA2gaFYuVQAFZwae
         OQcnMRLeploAPXiPOAW1pmy1HPPf2ehSybXiJMkKXsry0hltR7UF3wUlUjscvPPSQTup
         mC5VuWSBa65sDfUcgtKubLxwTvAPoaTtMZm0sgVrf0Tu059rWFvCMgP39hEcFCeARq4Z
         Xg/H5K+6Yox28buaNBxHWb1n7Z1Mvwqu20YG3llCuaniWcBlOmU6r0GSWHR7ZnvDwyBu
         dtXOYN32R3LiNQDVbVyyQ1iiEi7kWDupTIkwNPtvgBuNApUZWXaXfArWSTNLuk+RMpaX
         Mowg==
X-Gm-Message-State: AOJu0YzLtSWmGXp4oukL0IKHWKMzVyyGzGjuRk6v1OJTL8Iz5i50Bj+x
	zAVzBfjeF8e0sbRn6sFtap5jui15YVAJeBrf/FFVVx0NTlLPKtMIdfvdpkNir49zb0sa9MMlvo+
	/ZtiIc7UIOAb+U+BfMA60AzSdPyq/Y3vBXgnF6KMaXkY0sKeDQrye0/8I8oQV+jrF4Q==
X-Gm-Gg: ASbGncvvS0Sbav1+q+iGN1EqDKauwS9OZiQxYUsjuNzjiivCmJ5iPQ4es1ln74+Pot/
	DCg4bDa1cXM1Cq5DlD0UdS1ZyWa54F0GNNn4lBpT7oAOhgM8oGqYdG5eh44T6taevBi5sWB48jU
	BlKOmsMJrcZmNrQW/2tjuUPcm5qLV3n3E0x0YhKiYvijW7qPYDmWaUJIg9HwkDrvTGP77/nK9Zz
	ViBHJkr5EshesUZ0ZYEjRxu4MEIsVWPA0NBgud2CxebxPW6HFxITddqaIoEfDSJS06Hk3paVQTE
	RwJSn3v9VYRAA2q3hxzHl8iuJormO787oV6L0MkkA920K1J5MynyfuxBvmQkDeT6dBgcLn7H/x+
	3kQIPL/FELu+o4ociHLDchhLg/KVen9ehyvy2fcYKy9AxMqQDiOR5vASruiP+/ajNxF3Os8Stl/
	8L75Ll9LyLwnz+MQjlbV5c1YHI/wI=
X-Received: by 2002:a05:6000:1886:b0:428:3e62:3204 with SMTP id ffacd0b85a97d-429a7e76a7bmr138980f8f.36.1761579808272;
        Mon, 27 Oct 2025 08:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQAxqRr/rHiIk8Be8Oqj92G4ty8Zz+XoADT70JNYzG+ZSCLbG8+dIoqG8BUmFlIVgFfrJuzQ==
X-Received: by 2002:a05:6000:1886:b0:428:3e62:3204 with SMTP id ffacd0b85a97d-429a7e76a7bmr138955f8f.36.1761579807836;
        Mon, 27 Oct 2025 08:43:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5985sm14768245f8f.25.2025.10.27.08.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:43:27 -0700 (PDT)
Message-ID: <2de17512-3df3-4ee4-9912-8a8f7ca5b648@redhat.com>
Date: Mon, 27 Oct 2025 16:43:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 Wei Yang <richard.weiyang@gmail.com>
References: <20251024192849.2765667-1-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251024192849.2765667-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 21:28, Gregory Price wrote:
> We presently skip regions with hugepages entirely when trying to do
> contiguous page allocation.  Instead, if hugepage migration is enabled,
> consider regions with hugepages smaller than the target contiguous
> allocation request as valid targets for allocation.
> 
> isolate_migrate_pages_block() already expects requests with hugepages
> to originate from alloc_contig, and hugetlb code also does a migratable
> check when isolating in folio_isolate_hugetlb().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> ---

Nit: trailing "." in subject

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


