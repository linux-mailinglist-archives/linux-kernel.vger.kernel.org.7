Return-Path: <linux-kernel+bounces-840896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B4BB5ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F0A3BEF4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B153BB5A;
	Fri,  3 Oct 2025 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b34bfuQq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3552C18A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759451028; cv=none; b=Di79P/0k4OuLNZqgUymPvl/5CmOt5oS3sB7kZ1MXyuURql2AbLaEPoX5NoRPoqmmW/KP4srMwnrbiVhgBVl8yOkk3w6RXXGlMkG01WiFPWIIT/+mhVbnqmk5ZdkCHBmzudSSgKqE+eZI+HNDERMXw7hpqKFYdp9bYYvEFz4e060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759451028; c=relaxed/simple;
	bh=zXZs1CtthDzGW2v/IfUMZJ7TaahHQ2FhRN4cM3MZucA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtWY+s4TkzWOP8Ai7kRB6Bm0CMF2GCyd0lSu+cOYSnVIq30QfNRRa4X95yBu5xEyGhC8cLuiU6J6SEsERcPg8DcSA9UhSAod5zfNF90CRVgihVmNvybdmEpkXRDyAAXffxgCEj3SratDNiLvz+SWHel/UB76t8wanf5Ufl0ZLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b34bfuQq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759451022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ4GF21x3yH2fxgUvO+kT4SV03dtv6uBvlTIWHIhWNI=;
	b=b34bfuQqMS5eB6X/+1fcjsKJkNbq18tyf2onXS7GAzBSBKM9Ykv+BVpRuz3bqYtrZrnAJV
	2/zDrBYbeAOsbR8nvDuJ3VsmiLE5lrRY8L8Oiekm1GgqImn6uZRbxypvAe1LpKyb9jpocN
	zW16elmyrb79b8I08HuNVdvaAdtHwgk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-UPLiGzYINx6rehxZjyppbg-1; Thu, 02 Oct 2025 20:23:40 -0400
X-MC-Unique: UPLiGzYINx6rehxZjyppbg-1
X-Mimecast-MFC-AGG-ID: UPLiGzYINx6rehxZjyppbg_1759451020
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27ee214108cso34559235ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759451020; x=1760055820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ4GF21x3yH2fxgUvO+kT4SV03dtv6uBvlTIWHIhWNI=;
        b=rE4OU937I9vPtMLjTSk//9Lx0Fqm813qTAGkGUze47tvXRkWfWl1J0I90Q3qM4zXoH
         gNDmWSgETW/5fZvZAx2MnHiQcX4DDlQSsLYTwwru/vtTI+jl2pfqaShQq49HlaTe752I
         ph5uqY/uu7XPgR5t5efdRhMxzlytXIuuDjxbX5C6tEGhr5TAE2P+/xRDOnBvVncIUwGT
         38UiG32sp0v3UY7HnVSku3cTs52Dpz0gywcNB3ObPCj6QU/s+ksq4L+7jps6/tiaj014
         QHIDrgHzWaB0emKjGqOu1AbX8eySZp1cRQguHz3NsgoXMM5iroW1bey/so8hYqWJasJp
         fihQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbkxR4KVgFwfzmehY9rE217jYN0NS9HdwvrNcQ/CXWu3WEEFgANcLTQcj7KjsQXH5gQU7HvJbNm4mWLsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICmXlk2Sf8Z3Kz0ThjrS87+LAmUROd4UAOfBSfKE4ZA7ullI/
	HTfB1Xeg8wk4zJAh/aV3LGyeDgwy3M/FFgYwehmXRmtDNdvkniInD/VuyavMKKe37IslD0pgUiN
	pUfW5xUxQ6QcNJG2G2JiNuHKEjRr0TUIIkvixZTGrCVroSIhRK2vQJizhtLyRwc2BXQ==
X-Gm-Gg: ASbGncsvUFDVviNd9gaBosSl407qqCyLLNU1+RNJ2E0GYKwpuUWT1s1GKpOtyNbzbp6
	UyCnliGqo94dfzt9e646ZYVpR+tvhRlvsmByvW7xCQfBoZcZxsqdb+4xmbhYnJvC0trwGdePUQo
	EtVWdsiN9hiUpLy+VAgspwdEaQjgjsGS4GjXGZO/I9VmaGTK7csnQb0IWqgWT00M0guxfEqWeim
	L/shX0HMwKSbEE0q/vWgjjJqNyJG9sj2nMocRtj7lR+Y3GhZouG/tRYMwn5ShixU7aG1lDaTIJ+
	GHZWWK3nHyBP70S4c4mrdDnuj6DWv6P9DKe6JVFUpcaWSKb9WDMgIH6MzXCZ83vFxKyyDrQUZ6U
	655p7dmcFCw==
X-Received: by 2002:a17:903:3d07:b0:268:500:5ec7 with SMTP id d9443c01a7336-28e9a5b9441mr12159385ad.2.1759451019781;
        Thu, 02 Oct 2025 17:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5T0f61djQ+l8nuJX+LHXogclh1AUcAAg1KdLhGp2cAXJedAcNcCLa6griCMec76R0JF2mkw==
X-Received: by 2002:a17:903:3d07:b0:268:500:5ec7 with SMTP id d9443c01a7336-28e9a5b9441mr12158855ad.2.1759451019403;
        Thu, 02 Oct 2025 17:23:39 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5e36sm32448375ad.114.2025.10.02.17.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:23:38 -0700 (PDT)
Message-ID: <81262452-d780-4e85-b153-b3b8d16eabae@redhat.com>
Date: Fri, 3 Oct 2025 10:23:26 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/29] ACPI / PPTT: Find cache level by cache-id
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
 <20250910204309.20751-4-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
> 
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
> 
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Droppeed the cleanup based table freeing, use acpi_get_pptt() instead.
>   * Removed a confusing comment.
>   * Clarified the kernel doc.
> 
> Changes since RFC:
>   * acpi_count_levels() now returns a value.
>   * Converted the table-get stuff to use Jonathan's cleanup helper.
>   * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>   drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  5 ++++
>   2 files changed, 67 insertions(+)
> 

With existing comments addressed, especially those from Lorenzo Pieralisi:

Reviewed-by: Gavin Shan <gshan@redhat.com>


