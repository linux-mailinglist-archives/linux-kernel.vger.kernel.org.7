Return-Path: <linux-kernel+bounces-892171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (unknown [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0E1C4488F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 22:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A26188AF63
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 21:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92635264612;
	Sun,  9 Nov 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/goHjhJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixGeWhET"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFA262D0C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762725378; cv=none; b=NCiYxmZJcqEZSigUvhVxEjr0px6lv4wA2eRLHUt1CSFRMqp9aGX7ERT+9Jzcr+KbKw4x0jOzoI1RzrfSLk1ehKrYv5ycPxXjhUJ6X9Vjv/Ir4WTSxV7dullKOTLk7s/AMZIaEwpGASbHSYfRDtpOigJVi3pkDWWae7KXxs0SKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762725378; c=relaxed/simple;
	bh=RJ6pxCqG6BxVkkIZQOEZtLfkxAeHk4urUpxfJNnK2l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn8TiRUHdrYv2eso3pr6MjRUyAd8qGvq0Nj0CANdW4cd8FRtpJh6B48P5aj9JhlbiD8Y8rP6++CGjQIbp2dv+LmuieSsXGZdmzxPZmKGQE7wjZDL77HIrF5Afl3Xo4ErCAtw/XY7XuvAhrUYO9vNMaJ0qzWz2rfEGPbJJwl0tlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/goHjhJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixGeWhET; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762725376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhpPhNi4Zx3/6UZKrb/xpV5iwVuaKBA/NFjZxSosM94=;
	b=B/goHjhJjVyCwcP9iFaF4CYkLjcDkdkI32jVbBOmShevlnD6XF43pUPQ5th8i9Sba8PbyH
	85lI4ApRa/McxVP4W6wzrN4MdOne2RdI/uIK+OmSCWPFH6RpliUQmEg2tHPXuUrtdLZAI5
	5fyF/xXpPhG0FoBXtzju7E9mQVJm0hk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-HaJohqW-PZWpuI2bWiioKQ-1; Sun, 09 Nov 2025 16:56:14 -0500
X-MC-Unique: HaJohqW-PZWpuI2bWiioKQ-1
X-Mimecast-MFC-AGG-ID: HaJohqW-PZWpuI2bWiioKQ_1762725374
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29809acd049so7320115ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762725373; x=1763330173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhpPhNi4Zx3/6UZKrb/xpV5iwVuaKBA/NFjZxSosM94=;
        b=ixGeWhETNXc40MBaPkc0Shc09bjJNsAn2s4BRvjhPKp0vmZVHs029WmhQXcglbocX+
         h9k0nTul42pxljTGEVkPT/p2rHM2V/2ATIXC9Lxe1NoO8ecVtogV8LWP6PjuiDeyrMHP
         7n7cmyzcnHT4MYyxSwxgLsvJs7HDz4w+W2rfHJ3jvnI4M8CUNagG0V9IXuGDu4rIcf5s
         IiabtOkgNRUV7v4MLrq2qzKpbLYIB9VWPCxVtekn9UBBazx9GpRtYxD7xHShSUbmZFar
         FnkAJ8OGh6kE7BdM9bO4ZZz6TNrOS8pOT3Lqqj1hbbAZ1jB2Kok+stejegUrzMj2VV84
         1Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762725373; x=1763330173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhpPhNi4Zx3/6UZKrb/xpV5iwVuaKBA/NFjZxSosM94=;
        b=Kpi5ZKQrumAWrIhmtmkn/Jbd6evmj9J2o03wjHZI1wr/sbVDl7h2PHm6+pW6IpNj3q
         rBqk2ff+fdxj4XeWoD/FcaGudHC05i7jrZ4VCbSintAHawHgbSi5lMi7fC4XQ3yRUzyK
         tzfCBAfMQRZfugerUy4gi4vlJc+yxnO0cYF4qkzV5xm4tZoOdyLibLYcMukpXnRmj+FP
         K+QtsNw9ImWmvUxkIpg2Xs4LIR39FfvIFr/N6Zr50PwjcADQHIIMCFf3VXeUUcM+rzFf
         d9c/jPixE2ZwJA5scFannBA2SFytwiYtXkzY4b9gNRe3QC4N8De1KREFQ8vd/vR/sxFJ
         rrmw==
X-Forwarded-Encrypted: i=1; AJvYcCWGb5uTJK1WUfciYl8mAyvK5dXHUVvCTIHA/oV++f+oJhKZ238rEpiXhk3e04J+ESOHe+pJtaUfydcP9tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQy83YgCmxeaVPDzQ5chqovNFL7lVOX+UDwZ2lL4Y0ToZJAE9
	ORUnIFE7InTpalbYKwHxxFelKC527kR2DF08WmhFX8iBhaKEkLxnXycMIwjI6wd1c+IJXp5AOU5
	+Tho5IOWcqgnbPAoIgICOU2GTprFaIapfrr3xEqYOvqlTbRlD7SpTDEqyHsAaIPJuXA==
X-Gm-Gg: ASbGncs5zF/nzP8fnp1YXMApvrp67RYvxFu+LOJDJAJMdcezui1gy/voxfZu3Ue2kVj
	CdfEuED5zD0K5bXSfPReIFSq4tXurXg6fhW5z25WQoO71/bfAB56XLbLzPl9NGOgAmx8ua/sCEb
	pjDiM7QjVba1188idajvLvw7vk6eTzO3fN+mURcmHXXYPjgNeEM4Do964Z5nhBUE6oBxscqpPSQ
	/2JjlOMKbX+2Ho6ZoUq7PGjxwCEDany9tIEydDDrQ80MjzO9QqUh2dUoJqHAjnK2l5ZfAz2wZHj
	/b4uEfJboyRjA/4+3eZUUZ89FFbPpQ3XLNTFJztr0huJ2aBYq6TgPvMUWqSqctshyIw0UignkCc
	xpkIoa94IVHn80g9FZkkx/AXN+YMQBwCifnAaFZc=
X-Received: by 2002:a17:902:da4b:b0:250:1c22:e78 with SMTP id d9443c01a7336-297e540b22amr85533325ad.1.1762725373687;
        Sun, 09 Nov 2025 13:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9zBiRG6e1hawt36vRNvVq/h+yltgd6w60xqY2Wc25Pn1yNF2w3fM8lwcZqfnQwOslEQEL4Q==
X-Received: by 2002:a17:902:da4b:b0:250:1c22:e78 with SMTP id d9443c01a7336-297e540b22amr85533115ad.1.1762725373347;
        Sun, 09 Nov 2025 13:56:13 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm123508965ad.43.2025.11.09.13.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 13:56:12 -0800 (PST)
Message-ID: <c4abf4ca-9bcd-4edf-a291-4363f8643386@redhat.com>
Date: Mon, 10 Nov 2025 07:55:58 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] arm_mpam: Probe the hardware features resctrl
 supports
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
 <20251107123450.664001-17-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-17-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Expand the probing support with the control and monitor types
> we can use with resctrl.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop the =0 in the enum (Jonathan)
> ---
>   drivers/resctrl/mpam_devices.c  | 149 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  33 +++++++
>   2 files changed, 182 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


