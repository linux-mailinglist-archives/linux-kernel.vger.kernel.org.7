Return-Path: <linux-kernel+bounces-892180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB8C448FD
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF650346306
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108DA264612;
	Sun,  9 Nov 2025 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjfgvLd6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcMG2mQF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547323B616
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726832; cv=none; b=DRbWgqps+hgauwWqQPY/ESjm0Vvc5RIzOc4X1UmrFzhFMSrJ5SrbQXiYAJGQwKprF/xWqRa13BA7lh71C0qnvelxZ7bkcfUMwy0Q0qRMgG5IVb6zwoKxbcSL4osKhAuaNjMG1DDQ4fPy6THAszPk1N+KqCCV/ALKWrRRjJKB3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726832; c=relaxed/simple;
	bh=9luPoLzeiDoXjZ1ghvRixZ9O4UWqQdIzzwf5oTAyncI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUjNAl7rW1DuUUQbPwzND1a0jIOVbXWMk40a10f9M0O61P4DcuwfwXHstd/cypX/J+bmTpc7MI9zHdRtl+y/mgpoeyZE+eVSsH3Pte+lGC82gZAvv5uz2fENwLEibymsi9Um3JJuuq6wncOW+HoblNDQhn8mMf3phYkQcw1izEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjfgvLd6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcMG2mQF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762726830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9Vrh4hLm6Gal4VfKPd/BvcKzpt3wbNXvBBiFNbMLpY=;
	b=QjfgvLd672QWUWqDpV2bHwa6+jHSUIYZ1Zt2AWp/yEMdHXFrOY9EuBXpwH9J0uFEcEfNJQ
	3cxiGnvkSxwFDJW7IFafVyQX5cgKpUB91q7NsX5osi/SuQnQdZp0AEM1PBeQSlVCh9grPL
	7P2Tmya0kmp+3aUr5qYJmfJ+aezB3gI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-EFXnGnqGMO6EPjwrnzLsKA-1; Sun, 09 Nov 2025 17:20:28 -0500
X-MC-Unique: EFXnGnqGMO6EPjwrnzLsKA-1
X-Mimecast-MFC-AGG-ID: EFXnGnqGMO6EPjwrnzLsKA_1762726828
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f587dc2eso11850465ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762726828; x=1763331628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Vrh4hLm6Gal4VfKPd/BvcKzpt3wbNXvBBiFNbMLpY=;
        b=EcMG2mQF1kjNobtSeYI5uiyiWjIg7Sk2O5RMaflSDOUPTeb5uZqs98tTPc7hfXWv7Z
         1uv+5RmzUTF0Cokbt4Cmof3o2hIlGf5Z0T7a41dtThr1sch/FtvAQb1CQ0OXc3dpeasS
         GFjx0s2Wc3ZVhPZ5JG2eQlPFyZHidQJptQsx4VqbptQGmYBfXiSEGfCKVTYxXZ4XpTNW
         p4s/brthxvj9m3Q1olv2kJvPfCTr+hBNcWFSPxRjlytrrQnrvtCJbxoZgQwCZh5x6QK3
         A0El4VRV9poy9dXaeDZeTkdQrOpvgDMAtHYzdRHeKI/wQueEg252IIfxIf1EC7gUosZJ
         fJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726828; x=1763331628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9Vrh4hLm6Gal4VfKPd/BvcKzpt3wbNXvBBiFNbMLpY=;
        b=az5pXbZ4mEFx5OpoRWEuOiZvzGvJ48xUmYbRky6CfRFTfc6CWO+mUh1Si2sBA68P9e
         JMBQsyMYHkoz0m+5wHR4xb7DyZOIJz6r2KNdXEX8xN/jS4sdId17ZObH/ZfgLO+2YA/1
         sny9iJHeCiEArXFxyFSx1vrHrEsQSqAs3p65lltYZuQTmFiVw2nfrxgpQIywcUzoMHt+
         F2/aMvh7tGglspUcnI/2YgdDT1udOK+SBhVPy1DwI0q1Iu/Ao0kkMNMeDJm27P1mOvzD
         K3Ul2Qog7v5MhSHNgOT1w2Bmlzt1MnaXas0O+hiEvD7nvtC6EwJ7GFoq68EMj4DRQGUt
         UO7w==
X-Forwarded-Encrypted: i=1; AJvYcCWUbDCwX2uchinVF93TsoS96nyt0MAxuujzFwavKBrqmk8t440tcQ+iAUax9gwadIekNkuWfqQyNcAXcCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWO5TYUWuaIQ5cC3BfZ7yLmDVgiFrZ7s/ZDjm13Z8mfKqHsYyH
	ALGYJmVsZMJEt7sqO3YXJJKKBwBIo26bKkRbWkKViYfzfnQYbsoEWRHw0SFeyOIAlnbN/DIj7KJ
	OjanWI3SW1JyXIFAv2Z9RJLrw8Wwumr2SCeuAMKV7iFiKGuzYv0IA8/V15y0cKtOc+w==
X-Gm-Gg: ASbGncv9Ve4mk4b96iVkD42e71BTzCQ3dO2HZFAOuQq3rt84G5/raTvDJR0bpobhsa2
	YGuzxkBsnOG8U47W986RkP27IK47w3rL/dNbKBmoh0UT/bxUr1VUeD1nLz48+X1oVN3l+1uUmw7
	oZjBHg34Xh8zt/DZESoiQEHZHcEiJksIpfGja90VWES94qbGJm5VIZbMUcxPiawP48ipmg96yDJ
	pUGuuP40SOPApzm3s9crEldcIcu4j6TJnBn8xIFmMWoHPvwGtxAKJEuavqB65XK7p6Sq+upfJ/9
	TQB8wrknrE1Z4UCXa28oOoHeBzCP2nYWotupPW5SWE6a3WvuumFEh1doGNkJ9BJRpqwz93IGKYp
	eU5GmltFrdAyuglAa2CjR33VScIMXXy3coJuA0GA=
X-Received: by 2002:a17:902:e5cb:b0:295:b7a3:30e6 with SMTP id d9443c01a7336-297e562871cmr79572245ad.18.1762726827608;
        Sun, 09 Nov 2025 14:20:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwTISJ2La5PhmrXo8AgSy/Yt85FoIYmCW5lG5+yT/l4xv4t8A7YS357AfTy+jnJLHP7TlYiQ==
X-Received: by 2002:a17:902:e5cb:b0:295:b7a3:30e6 with SMTP id d9443c01a7336-297e562871cmr79571975ad.18.1762726827220;
        Sun, 09 Nov 2025 14:20:27 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b90asm121886565ad.23.2025.11.09.14.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:20:25 -0800 (PST)
Message-ID: <0d3b5565-4f38-4af5-80b6-66d230b68edc@redhat.com>
Date: Mon, 10 Nov 2025 08:20:12 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] arm_mpam: Use a static key to indicate when mpam is
 enabled
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-23-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-23-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Once all the MSC have been probed, the system wide usable number of
> PARTID is known and the configuration arrays can be allocated.
> 
> After this point, checking all the MSC have been probed is pointless,
> and the cpuhp callbacks should restore the configuration, instead of
> just resetting the MSC.
> 
> Add a static key to enable this behaviour. This will also allow MPAM
> to be disabled in response to an error, and the architecture code to
> enable/disable the context switch of the MPAM system registers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 12 ++++++++++++
>   drivers/resctrl/mpam_internal.h |  8 ++++++++
>   2 files changed, 20 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


