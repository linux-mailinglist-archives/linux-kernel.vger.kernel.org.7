Return-Path: <linux-kernel+bounces-726887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A064B01263
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A528D1C487D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF31ABED9;
	Fri, 11 Jul 2025 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXD7i6Y8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C61A5BBA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208995; cv=none; b=CRIJ6Dj6ilsusno3MAhgZWjjDAJdeyXUq87fe3wTibZ5fSsBUiuZUkuJrtbRSYC56/9j3ttn2F/dQ4R72h3OTbPRoiWjOpOTFgCAxonkYrOSl6uEuliUpQ8q73gRro5f2sAIv81ozoYhjec9HiasMs2jN6RRL4mprhPRId/81Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208995; c=relaxed/simple;
	bh=RyWqqwq8t39Vt83gk+N0g7r7DBbWV9O2FNjh5oQRfF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Stodvxz8Nu8QFDJuY0JOTQQwbXOfWugWPkzpEHmZ/M9DiQaXj8tK00MQLfZTIa2Y77jIJqYPKH8A6aTIMw+i/wG8KzTtxS/EWXp0baQhkBJysYBW/9ttZ+Zr6aJBHrN/bEwTDseoYcGpZZnDmUduO8rWk+qPx7OyVA17cgyLlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXD7i6Y8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbZ9SvWH85rz7pzEHlCaiUlISqHPHEAa0deLhB06W88=;
	b=KXD7i6Y8JddEDjdbiSBmsiT1/pXpI6o59ddjxrWi8XYKwBmRNV0ET8vifgDU/nTWO8eFUR
	RxRP9PCod2WD9QPZYjqRf8BmE8eNJ3XqH4iP1uNIeax6dYJlCCv4EKGPK88wfy7ldImpKN
	xeVjwXRDt2Z6dDjPl4zVefekdb4tYK8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-4GlVAN0aPyulnZKR0QCuHg-1; Fri, 11 Jul 2025 00:43:11 -0400
X-MC-Unique: 4GlVAN0aPyulnZKR0QCuHg-1
X-Mimecast-MFC-AGG-ID: 4GlVAN0aPyulnZKR0QCuHg_1752208990
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e1d66fa6so15900665ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752208989; x=1752813789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbZ9SvWH85rz7pzEHlCaiUlISqHPHEAa0deLhB06W88=;
        b=eRpyD6xONKiCvpMUk7+QbtSpNEOrVPBOUN2CPF/Vp708r3PzylVeye6gy1jmQ+cJvF
         d8QWlE87zWyf0kdf9+yFhlvVTrMgKKKp8DG2lSvUYAP3urHbI0uJZZRHiZDX1ejBHFoT
         vKvVv2LdTQqUJPRFeOmPaNyzNq8JSIABBd27AHv5272AC3jBzM0DEJ+GFEIuF76Kosdi
         YHfn+RXsfeqekuSMddEaR/QearZK0qh/uLRSrmzEXqzA6j+GKAhQdjP6HuFVLeayWlIK
         /geL/xBTco8d2vr+dUP+9AWTAgynBc5iEDwmVDjNe+QEqz1/tR4jBAGfofC7udgNRbwY
         1+nA==
X-Forwarded-Encrypted: i=1; AJvYcCWd48L+RvKS+iIiiiDBBRGKcObQaOXGWKCJf2vJ8MyErMcu9E5M55RKm3kjLXnRj2CbH+k4jZZ0Y1LQTLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+szOo088ZTR/o45w7bcdEYXnWFWbyFCAJOXhGmYwce9mqTtR5
	gkQlv4rO7QBBuvF0XJbDkUsRyKSdRln5DyNAknxCVMS88yBlJh7/Ov7r+FbxfIAKRi2xnsBqZjO
	aQP2jTIfTJ23PJmX5iOeK+yqWbPi+IFI7GwmTJyFUjKAt3B0LAOKi1TiMN2/3sdvkvYmhtwCVpA
	==
X-Gm-Gg: ASbGncuQCQWTFI66yGLm5G3tBHF2x01AHw/lq9fGiKK1tPtf2PFmoP+RW0z1NHW1FLq
	/vld5oBkwmxyxX9I0N6TCZQQhI8DNWZKphELPBmjLjCTXtc0J3K6JdbHa9jfInwPXfdET8O0tYk
	p37GmKwvNvP+YoVkXmpX3HOtWUGjUNHbsn0p0KFEkVxIDcdhm35sl6fF3RsuXtzqwL0mMWmXDrS
	P8rYNUEPYAldSVe+NSu2fLOQX4eC4xfl7MIewJii2xV7h/FQkxJeQOZ1TRQ8ODZjZ21b8CFFB1A
	/5ir7QO0r35UrXRImQlI+UBMB6sRyOrWL7m4die0Zrs/3foFpTt/4SlgPbTmOjhJCU93yOAO4qO
	sQPA=
X-Received: by 2002:a17:903:230c:b0:224:26fd:82e5 with SMTP id d9443c01a7336-23df0969b83mr12742415ad.48.1752208989068;
        Thu, 10 Jul 2025 21:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHizryBeLtJH7qq4pQR4W0x3Z2mnmKKxgw7ZpGypAdGcCGs32uL2u9Yrs/3xBqiO9BbA7w3gQ==
X-Received: by 2002:a17:903:230c:b0:224:26fd:82e5 with SMTP id d9443c01a7336-23df0969b83mr12742285ad.48.1752208988737;
        Thu, 10 Jul 2025 21:43:08 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4285d7asm36020595ad.29.2025.07.10.21.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 21:43:08 -0700 (PDT)
Message-ID: <c28a5c5c-19ea-47e1-8894-957169f9ca96@redhat.com>
Date: Fri, 11 Jul 2025 14:43:03 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: cacheinfo: Provide helper to compress MPIDR
 value into u32
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, sudeep.holla@arm.com,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, WillDeaconwill@kernel.org
References: <20250704173826.13025-1-james.morse@arm.com>
 <20250704173826.13025-4-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250704173826.13025-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/25 3:38 AM, James Morse wrote:
> Filesystems like resctrl use the cache-id exposed via sysfs to identify
> groups of CPUs. The value is also used for PCIe cache steering tags. On
> DT platforms cache-id is not something that is described in the
> device-tree, but instead generated from the smallest MPIDR of the CPUs
> associated with that cache. The cache-id exposed to user-space has
> historically been 32 bits.
> 
> MPIDR values may be larger than 32 bits.
> 
> MPIDR only has 32 bits worth of affinity data, but the aff3 field lives
> above 32bits. The corresponding lower bits are masked out by
> MPIDR_HWID_BITMASK and contain an SMT flag and Uni-Processor flag.
> 
> Swizzzle the aff3 field into the bottom 32 bits and using that.
> 
> In case more affinity fields are added in the future, the upper RES0
> area should be checked. Returning a value greater than 32 bits from
> this helper will cause the caller to give up on allocating cache-ids.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
> Changes since v1:
>   * Removal of unrelated changes.
>   * Added a comment about how the RES0 bit safety net works.
> ---
>   arch/arm64/include/asm/cache.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redha.com>


