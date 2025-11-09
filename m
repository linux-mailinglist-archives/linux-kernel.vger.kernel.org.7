Return-Path: <linux-kernel+bounces-892206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E433C449E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F8E4E543E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5F26E6E5;
	Sun,  9 Nov 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDvvapwv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB9kLryJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD825DB12
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730210; cv=none; b=ilizVqV2ymvVM7f5GWS6riWN31an+XaPAmLaPpbw7Z+5ileQvDJ7MmloCS66tzv0/e50uCM18u6S9sJ3b3ClQRfnXryfHbk7sXm5a8q+kHVHNDcnk7h/wlz1lTQXCKeguRf08YqBND6SWSb2M48AGSEiiEIm/C70XvotlcVsrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730210; c=relaxed/simple;
	bh=eQzZIUSfykKTnBoKIiXY7tR2Sa2ZPN7TE0zOJotU6uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0uyWHjHYpc6iQS0MRRghAQEceIYiz608L4rbAPIFllxCophpD+hp6lV53wjEAGnsk2dwq+5L5XZIjV6s8V9OsEdkNQVEfNYT1HJSOc8AEPh30Ig+FDR7MvQtiryqDLQRMg/egz3KaKFdyI7HZMNknPR+8dArroERvdCL5gwXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDvvapwv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB9kLryJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTqh8jmOS93oohVyFSekWpawat5RQCgtELIur79S/mY=;
	b=EDvvapwviOx4B8lXXByHsO5phYnkZZy52nVIcVvev9uXPfOTEqRD6DKEqGhcw8EyhFw1wN
	f4TX4eHOZTzNKhARm9NS/KdT2FTaRDhChI4Zb2MQOkm3blD8OO6UDzk4fIK7+nMRKWF3CC
	LI4Q1WgE4FUTF5h/1/SRFKv1hJg3pAA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-Ezfa2M58NoyIPoGKYFt31Q-1; Sun, 09 Nov 2025 18:16:46 -0500
X-MC-Unique: Ezfa2M58NoyIPoGKYFt31Q-1
X-Mimecast-MFC-AGG-ID: Ezfa2M58NoyIPoGKYFt31Q_1762730205
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295595cd102so64064765ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730205; x=1763335005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTqh8jmOS93oohVyFSekWpawat5RQCgtELIur79S/mY=;
        b=VB9kLryJ69zXcXsQKMz39y31NJFls1vu/TV70qNrGud3b3+8kLCZtiC7H8s+d4qnC+
         2ziJgXi+n1KeTg2HUYAGbjEJ9EShAIeY4HA2k6LYaZB4/NeZnZWCfJ6PSlBTMn+/xS1g
         vNvu1l+XvndocRwp89vGoH4WQOhCr1ZDOwzlV4J9Q2XEExCSAHQSoP5kQwBObnWINuMJ
         +TLXp8KQSLI4JjXddIvDqYie1ymy7z1B/Fo1/x5aeF5hDecpG3UQbI2KxXdsezNzYkX0
         UDNicBQFghYahSotnOkKjCIqXJsJ7ZikV0XS3viYtrq5twZ+9diTFgGRcqKYwG8YFNA2
         9W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730205; x=1763335005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTqh8jmOS93oohVyFSekWpawat5RQCgtELIur79S/mY=;
        b=uZnth2+RsV91IvAayCGjMDHuLhAztGFDWg7tZApCClwQMu8IsHQhaGQ1O+IpcIuy7k
         +ZNSilQuxnNVbBwjYsHAg1XZ0UFXjwEDvw3fBkpYNHdec9FS/guR7g7jxlC4SNTMKzdv
         A8/DA9P1MhgOuC3kNN0L21my1XtX8gkS1S/mxTNTRDkXWf5SRkOjqYJFjKeB+uV50IBW
         2oZM9SHm42uqt/C+1ebwZN0TOxP+dwulW5T9BW22VypeBAMdqdelBse8anZRT01MDGzt
         a2r6oUiDQf/Xl2fAoJuEGYrZXKnNZSTeaC/UgFHoDow1XCB+mF1KiuasPl3WssygAnZz
         vNCg==
X-Forwarded-Encrypted: i=1; AJvYcCVFIwryEHA8YB5YbUQ/PaaMuqgQBki6hFOFZl1UEwRvE9oIt0hca7qpLScoqxYkBW0rBDY2fUKoBAcN7yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbyDR4J22EiAm3kyeeIFmM251dPFvEhqFfe0TN/HvrH/hnAP7
	cGzrTR7qHCHZIndThOtZv7tRjtCrTbbhnz1O6Fx/KPSoMweAf1zaksqG4nM7cKJ7BpWDSr1Shqm
	dPU7F7Hbc9HxY8QrXZ7n7ZcfUpL0537eR8MH3DvxF5hiKWP4MNCTCvaE/GZfMrf/H3A==
X-Gm-Gg: ASbGncs1lK0PsH3HI0SRhvA3VXW+/SpKyibHXYciER0JqCdpeYzr+fogWeO9ygGrd44
	bbaE858C9wkD4nLI4D+GPGDDUWpKomiW2jIYT655DidSGJFVSKWBKQM1IpMi6DIaaLWfxN6RX4L
	gFiypqVkYf8QI7LvuRbOeHy6mwb/KTGzPnhyVF9gW/aAQ8P5E7jZYy9NgxFxLxGFyA6n+Ss2Dgg
	D9zHVFO3B9k7RgNsBrHrJr2WWFsYwDzT3imnxlAT5FIMrkAjfVo/lqYGfenaA2IDhXc2Aqz9pem
	sgDe1SxHgq9MEvnVnff7PeA2E7Q2M9BT2uaeS9rFK0mHL0S2Ha7BvAbVWNFBplSNajKIXJBNS5D
	pfeF33BwYRDiCW8bkWxQrw0CC1AZKi3num3/60yU=
X-Received: by 2002:a17:902:ec82:b0:295:4d62:61a9 with SMTP id d9443c01a7336-297e56aef0fmr84827585ad.38.1762730205526;
        Sun, 09 Nov 2025 15:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNnY/CNaLSySWvx3SVi4rlFrYuCp9os4fjr50iYp2+FkzGPAxbALNV0IsAj3LaGTB1bS3PNQ==
X-Received: by 2002:a17:902:ec82:b0:295:4d62:61a9 with SMTP id d9443c01a7336-297e56aef0fmr84827125ad.38.1762730205135;
        Sun, 09 Nov 2025 15:16:45 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc1833sm123856145ad.97.2025.11.09.15.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:16:44 -0800 (PST)
Message-ID: <3448db42-cc36-4d2c-b6f9-b2ed85bf9227@redhat.com>
Date: Mon, 10 Nov 2025 09:16:31 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/33] arm_mpam: Probe for long/lwd mbwu counters
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
 <20251107123450.664001-30-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-30-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> mpam v0.1 and versions above v1.0 support optional long counter for
> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register has fields
> indicating support for long counters.
> 
> Probe these feature bits.
> 
> The mpam_feat_msmon_mbwu feature is used to indicate that bandwidth
> monitors are supported, instead of muddling this with which size of
> bandwidth monitors, add an explicit 31 bit counter feature.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [ morse: Added 31bit counter feature to simplify later logic ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Only set the exact counter length that is supported
> ---
>   drivers/resctrl/mpam_devices.c  | 34 +++++++++++++++++++++------------
>   drivers/resctrl/mpam_internal.h |  3 +++
>   2 files changed, 25 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


