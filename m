Return-Path: <linux-kernel+bounces-772561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC2B2942E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3605F7AD27F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A502FF166;
	Sun, 17 Aug 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StYakNUJ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729C2FC86B;
	Sun, 17 Aug 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755448626; cv=none; b=Hj3+LhDJf8DQFTRuB8/jgdDVIYwarF6qNCIVhcUkG28Bws92X3+yguS89j7ztxD21abPOqqDFQZoku3a6xbBRmHYZOTx4dbRUtr5C8FkWQGgSoe+3zytcP8mE8z/vAQ4t+iMQ809itJ2CvP0roPx5cLLLyCAmSqLMY+Z/3oqcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755448626; c=relaxed/simple;
	bh=+/Vmnj42oQV6Fm+uetYEn6odxvV0wTKF17MONO6nAQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDEEKyXukha8WhrChcU9V80qgTiw53q6sjz3MeQat10Ot+hUeZ1PGeccahiR9E6S7jVEB6XIglLACVXmCXeFBeIanXVmXgpfPMzln4o2Cy13av4jl+XbSZmQgjQJCyryWa9XQAcOvSWOb0lMk7AFy0FW+G7jJbmVvenM0dhCXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StYakNUJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b471737b347so2320226a12.1;
        Sun, 17 Aug 2025 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755448624; x=1756053424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu8NtR3SA6w/CY24HT9I4ClMud60N/2LWQULRPh/3no=;
        b=StYakNUJl4FwKR2SegLZmh8jrIf2UsHZPJ2nFbhS1ym5WU/OrXhv+pv4lCUj8HpeFL
         R8eLxh8NKmkRXGzvLlFfhOvvc6bYppG02e+emek/wFzkIng0EJAJNHlU5aNqUw+vpENR
         mvE136XDTQC5AEJ5pCdhCVvVDh9709njNHWO5eobzpS/ov0RDF8jEZsDIElxnlZzrPbx
         X16YkEOcpO387F+vK2sEDfo2nwxtonAFFepriUOAv0YN0TZbMvPwGDUg/9G+er8smUri
         RyG9xuW/mngBVWtT+maYhZqVREnItiGjQ8bBGbHgs4k5DlTpYl2FlE+QoT4SNziFqrzb
         EVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755448624; x=1756053424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu8NtR3SA6w/CY24HT9I4ClMud60N/2LWQULRPh/3no=;
        b=tu7qNnjTJVQT7ZnfYxCBWaio9mkRc/FHkB/bCv7jBFRwDeGL1/AUTKfW5QkHRdYUCH
         tOVVQ0j07vm+JBsq4x6NDtX+DzBadpvZBiwhhrEs49Ikx1vPKQYU0r1RPPzPNoppqmxN
         vR83I1tMpDZ26WYaUTs9SQ9mfI0RC+4SLPU+4cqtb9aMheheoAGL1ZbrDpcZhusHQN40
         60sFcHgzCaioBibydwzafMocGFtB5KltUePg2JWpbV8tUpIznhBJuI5uOgh1VO8JVaTn
         EsG15ri/U3f3KNYhk+OXZRp9BsXU9+jPNBqBRxE6VVDCI1bxfqdfKXduEElYkeAmx4aq
         ZOdA==
X-Forwarded-Encrypted: i=1; AJvYcCX15owxn+PIeZSvdKRb4tA4CdtZe8D49GClzI152VO0mt9CA1HRBDc0QifruS3FoYsIWc+PyqhiqDPFcshn@vger.kernel.org, AJvYcCXZQarB8q0nxiC97GFCNvYIuHLNJjC32/tvRywfJyB2LulqBUoR2p9aRxfuNCORvXah2CgbwWtPdGHY@vger.kernel.org
X-Gm-Message-State: AOJu0YxPsVIqldhIed9lemVLtfoDxNs5TJYEMr8NG1ZMKPmoCdtsAHly
	EyxkxjyVd2gcH7dkm491ZDpT+hYGG3rOTiD3x3G6gsc329cIusInKFzq
X-Gm-Gg: ASbGncufNmxNkzVTvLvh+K9wL/o6ChXKRmD6WYE254Y62SX0xA7fh4sGD7tBgzLCHrC
	ItWbEIYS9GvTpFhkq1mzWHpL+u/KbeRhbnXJKnrBxNd2z82n98ml9Ui6PfpFgD6ntHypDz+ZOjw
	o9tvRZx/vnvYy+/4FvYX9IV614E8Bnfb9lR0/V9/pWeeG8q7bjY9jIPLpI4GahUyZQu3invMwnx
	+nQ1EktV6HclHetemQqqb8kP5nggLriW8yjl5PhlEAOVVQyWs6SvXk4f2V8qfZJHZ/2WOFCjHNy
	zxe75/lrbNi2riIRYZHRHmHy0kv0X3LxC2qwGwtV+cxAjMLrObUBmSg0Bwl6gocsZhsAeQ74H/N
	N7t9bF/pmliwMT6/EbqvBIw5VfocWJ/aJidz/lAZZwLh23TjGDh2k
X-Google-Smtp-Source: AGHT+IFolnCZsYxa8DXtlqeL7svE1Vm9qN7zDI4nNsqND3PhWkhOt0P90tLwWgS8I5+brb7rz1uJHw==
X-Received: by 2002:a17:902:fc4e:b0:23f:f074:415e with SMTP id d9443c01a7336-24478e3f823mr71496235ad.14.1755448623914;
        Sun, 17 Aug 2025 09:37:03 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323632812b3sm1612946a91.13.2025.08.17.09.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:37:03 -0700 (PDT)
Message-ID: <e67860f1-bec4-4a55-91e8-61ade069f0a5@gmail.com>
Date: Mon, 18 Aug 2025 00:36:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme: apple: Add Apple A11 support
To: Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Jens Axboe <axboe@kernel.dk>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
 <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/8/2025 18:47, Sven Peter wrote:
> On 11.08.25 15:50, Nick Chan wrote:
>> Add support for ANS2 NVMe on Apple A11 SoC.
>>
>> This version of ANS2 is less quirky than the one in M1, and does not have
>> NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
>> SQE.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>   drivers/nvme/host/apple.c | 228 +++++++++++++++++++++++++++++++---------------
> 
> [...]
> 
>>   }
>>   
>>   static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
>> @@ -284,21 +294,8 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
>>   				  struct nvme_command *cmd)
>>   {
> 
> Please just create a separate submit function here.
> There's just not much code that's shared between the two variants.
Will do in v2.

> 
> [...]
> 
>>   }
>>   
>> @@ -587,10 +618,17 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
>>   {
>>   	struct apple_nvme *anv = queue_to_apple_nvme(q);
>>   	struct nvme_completion *cqe = &q->cqes[idx];
>> -	__u16 command_id = READ_ONCE(cqe->command_id);
>>   	struct request *req;
>>   
>> -	apple_nvmmu_inval(q, command_id);
>> +	if (!anv->hw->has_lsq_nvmmu)
>> +		cqe->command_id--;
>> +
>> +	__u16 command_id = READ_ONCE(cqe->command_id);
>> +
>> +	if (anv->hw->has_lsq_nvmmu)
>> +		apple_nvmmu_inval(q, command_id);
>> +	else
>> +		command_id++;
> 
> This entire block here looks weird. First you decrease the command_id
> directly inside the shared memory structure, then you read it with
> READ_ONCE to a local variable only to increase it again. Why?
Thanks for spotting! Looks like this is merely an artifact of how the code
is hacked to work that slipped under my radar, so I will remove the useless
codes in v2.

> 
> 
> 
> Sven

Nick Chan


