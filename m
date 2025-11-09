Return-Path: <linux-kernel+bounces-891768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B208DC436D7
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 01:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95103A57CE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50E2F872;
	Sun,  9 Nov 2025 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPhDoLzw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A41g/iDT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8117266A7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762647929; cv=none; b=gX8fgPQbCTxAcgugJH90H82LsMeI5BIcYPc+UQWAL608Hmkwzhp/Osds9prc11cj+Z7pCnhKLmaCuiabeQ4Cab95tARCn55chXMn3Bub6SB4JYekXWqEcfn/F8UG+Bl7bFdpZTw9/l2jtK3A0T+KB9UTotOx7+893rO3yFQ36Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762647929; c=relaxed/simple;
	bh=ZhTnpJkzp9b9OpiEjTRFs06DDFrVsei3iY10Nu8Q1eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCH1SQqjVRB+rj3yQzoph/59VKwUsimezWmuZKBI1pvqaImhD9Q+eecYKs3fF/C3YZaWS95NqBqSXFZlxiLN7yjiCXQ4ZYdI1TxjB3vKIJoilbPTEIfZhukQd5SBsSwmOeU/AB6dz/hcQ9eDxjEyfEv5ekAQPvd3Q+VjEUTnNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPhDoLzw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A41g/iDT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762647926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjM2gkzQil19AomxuDInwTt2gkWOAouhNdKUHEv8N+w=;
	b=RPhDoLzwJh/LchEljvqQFEJoeBsGq+f/OkkqOZ+vwpuSpgo3+pv+ZjSJd06tF8YD371N64
	mbu7Koci9bE+i8QF23EjEz9cge/IXt8cX04Qp8RBFeTSws+77ro1PLxQAzRzZBaeNAKtBw
	vfNV068xZ4sVXcovfJut9JXQTY624So=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-4cXTOBdBN5-kHEfcID-rkg-1; Sat, 08 Nov 2025 19:25:25 -0500
X-MC-Unique: 4cXTOBdBN5-kHEfcID-rkg-1
X-Mimecast-MFC-AGG-ID: 4cXTOBdBN5-kHEfcID-rkg_1762647924
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956a694b47so25201775ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 16:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762647924; x=1763252724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjM2gkzQil19AomxuDInwTt2gkWOAouhNdKUHEv8N+w=;
        b=A41g/iDTp/JRzGsS3khF/3HnTEHaMb7MiwGNqOSc9HpYyE1B9+S745Jy+ar2vvMCiA
         8Id5+38hfGWKKsZkkpcsXYyLepF/GYyvqVVclms/bFlxdWOBG4PLnU+cRfbpW/dQqQU9
         OEyuTbowZHeVyR5NiU84AvYKCzv+/MZD8zAOlAvFlWguZjOYg/55FWq6S7OoBA4s73nN
         L+L1Of7M8U2c6jSSzNqV4eqKgeL2N+LLWzQB0PzFLI/zp4AwozYB4TvzD5AOqLJH6+uf
         NwtV2wl1S6rJS0PIJDYIcl6KiLLxrEGdmwLK/kZBPCxGQOai+Vdr6JXRSYha5vsBOrpF
         VVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762647924; x=1763252724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjM2gkzQil19AomxuDInwTt2gkWOAouhNdKUHEv8N+w=;
        b=eCVoez7kdWFE9nVFsKG4nZv5DXmUYfKIrUKUJRwEzwVkz2ky+1s5nDr5pEpQUEgXOk
         75Hm0vCy9gBPQuTCB7Id3qcJIcNMBL/QOSzcKqn53+MCx0v60EaSGY2oEaChCZVjc3sS
         eG0l+nb2v5emdY7dMmmwRz1vPcNZjxGpaREuzlBOY3NgAvPpI4CkOR4OMBoBdQlo6MLC
         JjdJJrNN8XLfzhFs1WK5ryPWlE9DYo6HGB8W55udNqPNso3HGcxkon4WJ9N+r9ws03zj
         a8V23gNViHFZRGe2DPJ58ykjwHfqOu+q/5AXWEUeQkQpvXhY3t9S0sPVi6grt3WIk0w0
         TxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEoK3J+w8OF69VmzUEuPERnRxoY9bsdCwTbYsTDooHDBfPRFXXniLdaxAysCK4+wgSjxi3mWTXY2cVuro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZRplRkGPGkoh7fGIdaVZpvPKDRSyUBsnn48EcFBJ4+Z9Xw7F
	4riKHb9q6WkVS1+AE2Y3KhvuxZNCVm0bE+zhAxyLU6p7msu+HOBGFeL8OTdkFqQCjJzePTanVQX
	HUgqTeGlaWbH7Tyl/lcOJlkdkNOqZxJzbAbDGt1CEQmg5voPYSBa8EKOOAboY3R651A==
X-Gm-Gg: ASbGncuDFrr9EA/0+BWpTEg+Cvg2EJMvv1jLdg+Y8vkIrI4qKm0ZePLHThUYA6oOxne
	gcN20yujYFmvhuxrENsO8v1LqSDkcAJDPL1UpsJ9u4JApo0AkQyqpUTUN5r1bgyG7SwRjvzJS4e
	aDGwlmpYAhdD+k5UqAq0aTshrSibN/pX0UnaCFxHmoJfaB7ZT5vYswrHEI8ocPmUlxazCxhjIBW
	AUOJEGh1RC9vKzEh8AU86ZsNrz+CcmB/c4ajxNFCvOFCC7mSlpfL3mi4vD8fINYZNteOjiRpWkl
	EPQvNP30pSQJfnEmoztlUQ++4gTz/91kjPlS3FQ9ECyG3S6NMm8y/kVrG61yP3VQe4TQGk0SIMp
	bzG+UCbgaXlgLSJh7Lwv2JXmkMYwUZuj/Dfl0XiM=
X-Received: by 2002:a17:903:3848:b0:295:3ad7:948a with SMTP id d9443c01a7336-297e5623f04mr54414985ad.16.1762647924328;
        Sat, 08 Nov 2025 16:25:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjT7Owo8XJeJOTrgWjvPtiXgZ1vBfz4lfqIxSQIjV8vhLk1OAJS8nDYaFPSxNIg+nMeJmM4w==
X-Received: by 2002:a17:903:3848:b0:295:3ad7:948a with SMTP id d9443c01a7336-297e5623f04mr54414545ad.16.1762647923976;
        Sat, 08 Nov 2025 16:25:23 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968253sm99440425ad.20.2025.11.08.16.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 16:25:23 -0800 (PST)
Message-ID: <6aae3021-4e0f-44a4-b842-8b8f952031d7@redhat.com>
Date: Sun, 9 Nov 2025 10:25:10 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] arm_mpam: Add MPAM MSC register layout definitions
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
 <20251107123450.664001-13-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-13-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
> 
> Add the definitions for these registers as offset within the page(s).
> 
> Link: https://developer.arm.com/documentation/ihi0099/aa/
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Add tags - thanks!
> Consistent naming of long counter variants (Jonathan)
> ---
>   drivers/resctrl/mpam_internal.h | 267 ++++++++++++++++++++++++++++++++
>   1 file changed, 267 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


