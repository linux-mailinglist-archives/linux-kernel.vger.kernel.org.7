Return-Path: <linux-kernel+bounces-892179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736CC448F7
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2BA3ABC48
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D06263F5F;
	Sun,  9 Nov 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvFz2vBN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxgiBrhT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DB23D28B
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726753; cv=none; b=MjtN9F7RdWId9YUhed8Z+sz0YFYgfTtfyGIup4ep9xE4fImCA0w3+BN+lUR2knUgOnwK1njIb3+xxRvjVneVmLiCB5dqNSoR8DseBR1jYhncK431gyi+ejSDA/AYVEvCK++eIP7JdFXXUi3RQo+zYAKdwInwZa22oRuWZUmz8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726753; c=relaxed/simple;
	bh=QE/+0abjW5eoE71Zxfuin2niGVpl9T4KA+kCsri14Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4RqpIofquN6yYi2b4RdlLd6PzwiiZMbxpGZJfStoZuJDHOpcSL7EzzMl+NrAioq0CM5VWJtJu2b06VeXipIvnxH7WljkkAvTQRn7Kk4K880qKSBMm1ugl52y1+EMW4CUTU42fLm/oB2wLbFFYwIVhvLR3Xc4dO8UIDZLiRvIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvFz2vBN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxgiBrhT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762726750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKM7r/eHjTb0/Gou42j2GR7IW3Ghd2XntavEBYW+1Ys=;
	b=OvFz2vBNQSBAiS6u3tdJiFcbI9Zt4Y1FlZPFJZz9sx5TIkQ7GgFAt8smzjn5NE7bcN82z4
	ey9QtcNpJk1bT6Whx47GBhS15O5gxADZ6+EQoBj9d7dKIVW5sy1lWZuOuGuAzdJ6ranuVW
	V36sLMa6zDvI/zyMRHIlyY770AuvAdA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7w9kQ3liPp68I8j_9DXGZw-1; Sun, 09 Nov 2025 17:19:09 -0500
X-MC-Unique: 7w9kQ3liPp68I8j_9DXGZw-1
X-Mimecast-MFC-AGG-ID: 7w9kQ3liPp68I8j_9DXGZw_1762726748
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so1858048b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762726748; x=1763331548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKM7r/eHjTb0/Gou42j2GR7IW3Ghd2XntavEBYW+1Ys=;
        b=bxgiBrhTtPkzwhX8XHVAP+x+k3iXYXSj+bCml/jz5i5dyd5Ja/ZQlSQfRP2GSwqN3l
         fHc2ve2ul4E7nRbvcmVjpHrIyrzI9fEFrXvgbBo97dN7PKzuBY8UQKFZTbJl0KgcOM0V
         USjTJEQY7I+DoVqXIdmKLQecyKAKyX/8chLPTnM74RFUzCAQQyMc9dw9Hxsd9IExWMCC
         R1fZO3ZzyRcxPEXuMZIDvsN+4n6+4y6Td1l0jFjN/Vv0sSLyYEeqjX+95Y8qcLKcvwjZ
         9Eu2V3KjYvwXgaIlsn+fSfa8c44cCuc9Sf78vD1RX/bl1zPrNOUhao+RBqV7UQCoQbK6
         MecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726748; x=1763331548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKM7r/eHjTb0/Gou42j2GR7IW3Ghd2XntavEBYW+1Ys=;
        b=ktCcSmrh07H801DDTLludRp/jzXkzNNctUazPdECtqsCzFqsYPjsUkTDYZ052yBMUV
         X/56v+m2JUgcAf0lDQQAT2v3WttSMgTLc5DnDuAf+0hyghw76b0MF0kZzU8111tANDC8
         f+uX44dVP7048YWtu5kCjcUrel1YMFULSg/gXLV3LeF/kfNF4IJewR4+8zz4OtS7aC52
         8f4RdOVOkBZYnx7f1NSo00/OP5zb+FJgmzPowLGrD+QudpeKZxFfvTRM2Xa6VWAyOuvY
         FLHloP26Qj0uzdNr/+JLJvVv5fzPYH72Z1AxRxpECl21OfjvoDUWhJuzSfrWzIwDCNJB
         ri4w==
X-Forwarded-Encrypted: i=1; AJvYcCXYRw/6GD8z/ABdrUNDfudmIUPOW1uYAlnWeB+iOW9ymnqFdhGfhCLQer6+8PQrclFGjxTYPwIxxNjcqeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztM8nwViUaoPxPR/h1sv8Tuj/wznEMsqaa+dvHEmXzmfrtfc6E
	NySbyxuED3rWS79wYn9ySf5uSnmfF/CyEmBmkQb7iLiw6vs+bCAt+AGvQuaAPfHibpuIAEckVC2
	ZnDSaFeJuFU0n7SaUJPGU/stSbrC6rX4wsAbA6c3JsqrYQw1kRzUcFYldfMvl9Dz4gw==
X-Gm-Gg: ASbGncu4XNtjvaV2iLRcqWSMGIMZyQiFDVob+GPSgPFzPAbJ7XIdaVilTD/Ep+W8A9n
	Zo+ZcE04dlo9QGi1osV1HlCO6cYzq+W0uX2z5UqUKCS70d6pdzIlMYsh9z+LoQqTPwbf3+4urTZ
	q3UpnkX7J2TiieNPps2MAkaim/QWGohCQaya62vV8Ee3aBmQicEJqgcXWJqwUe6J/rHDrby+W6o
	pm1CNLKZ7msT1ETkVqPCDO4ePuzpxo3ftecCXza2didilPWwoO8IyhFR4rrVdFDOYdEsZ3JOGn1
	Do643XlLmQBqc3xumuOXzQ2PwVvJI+SXh7CRBehgpzRbJmBQRJX9kfbgq8tXKLFhjkSYpDPGZj/
	A0knxK9S71B0DA9Nh39Mka3AlUgJShDlvQdK1UXw=
X-Received: by 2002:a05:6a00:1745:b0:7a2:882b:61b7 with SMTP id d2e1a72fcca58-7b2271831efmr8565511b3a.32.1762726748096;
        Sun, 09 Nov 2025 14:19:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3MMgt07dX68/canq5/Ysh2apHwPj31+tbrluUxA4S3hEDS8XL1dRUO8GV8pg/gcyqccPa0w==
X-Received: by 2002:a05:6a00:1745:b0:7a2:882b:61b7 with SMTP id d2e1a72fcca58-7b2271831efmr8565468b3a.32.1762726747711;
        Sun, 09 Nov 2025 14:19:07 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e15sm9508628b3a.14.2025.11.09.14.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:19:06 -0800 (PST)
Message-ID: <9ae6ab72-e714-44d5-847f-f2b1253ce4fe@redhat.com>
Date: Mon, 10 Nov 2025 08:18:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/33] arm_mpam: Register and enable IRQs
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
 <20251107123450.664001-22-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-22-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
> 
> Only the irq handler accesses the MPAMF_ESR register, so no locking is
> needed. The work to disable MPAM after an error needs to happen at process
> context as it takes mutex. It also unregisters the interrupts, meaning
> it can't be done from the threaded part of a threaded interrupt.
> Instead, mpam_disable() gets scheduled.
> 
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
> 
> Once the IRQ is requested, the mpam_disable() path can be called
> asynchronously, which will walk structures sized by max_partid. Ensure
> this size is fixed before the interrupt is requested.
> 
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Add tag, thanks!
> Whitespace changes
> Use devm_mutex_init()
> ---
>   drivers/resctrl/mpam_devices.c  | 280 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  13 ++
>   2 files changed, 293 insertions(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


