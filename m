Return-Path: <linux-kernel+bounces-899956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A4C59203
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98FD535AE03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90F3431F2;
	Thu, 13 Nov 2025 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GVJnbLJ6"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51D2F83AE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053966; cv=none; b=cHI7s2oxvqopv2IOfyIYNCtvA1cJtpZiDNTv98jVSFO/4a1EgYemdx0f5/rT4b+tSGPPwLTPsRhZUs3J5YhhDI4SXyFQQox7utgbKGhmmWk5okHb172qAiKVdEMTqXklqEEt1x/00UtVjydYxW/v3OPREwMDR+Fof06IIvm3A5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053966; c=relaxed/simple;
	bh=0VC4dmzU+Ey9Ygdim/pTVXAzfR7taHPmdRqGAxfsOcQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FzCI921m3CWepDDFrAUEM7tuPYrg1KZ1EnqxwKiv39vMjROfk85L+w2IfEVaMcO8gtpDFnJosjhp13+LVWCYmseo+zlrjHZLfr3a3IvSgRw8tc9smDqG423IpFUEF5m2s165a7wMDrTBOLJm1n8BG9Wf0CgMDZeVWX/FuO8Emf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GVJnbLJ6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-948e03b096dso9791639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763053963; x=1763658763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7e3BcbCwL4WqFcaayevnA/yDxq1SWODYXV/lEdC4NZI=;
        b=GVJnbLJ6PusS7eiRbhdFJxeW8ITF+vZSHocHDPBZsKi6NHIRKUZ1sbq40oSD5yU4ws
         41mUMR+oTGxEHTujntURJV7tWR5XYIisjokecLjtKomCIryOXF/yWU3+ux1dgFNpSch1
         DIg40kg1NPQcje5pYZNWcMwlGFT797NsHbUwLO2P7Ui1JOhl7s5MmjxkWqunIs+mqvUH
         +J0+pTGeNua0GD0C+tZ82oQkd7/RdR2vVxXtbI/M12HCXz17J3+Lg6KUwpURIeEyhKr+
         PUpczdMiqK5IKPwNuQ7O7R/cVT9MdmDB5KPVQYw2gqjRaDFtvQsnX2s6hrp5FFaOnjkw
         akIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053963; x=1763658763;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e3BcbCwL4WqFcaayevnA/yDxq1SWODYXV/lEdC4NZI=;
        b=rhzJLNlzmN89PC4DDiiCZgRa0IWPDGzHq1V7cxfqXbtw0JKGFz6EehbI1OT1wmPhBj
         dVBUmDpb5yYYMPVInUCvLaCL+MwIsMMPhzWn1ldhrvwP9UE3X5y5d7e2jecF21C/SOAe
         blZNHPpKuXVx8F/X4+I8sFnfzCGJJvWEV1+33kF1JXlvzHZeoOdnSQm9D+tgWElLio+C
         VIdVakQRfb9DG1snLXyMjdc4CHUElh0Tvz2Y7qUctO6AEON1Oz7Ez+uljd8TN4hvqEfG
         8dithqD01zgbJWPxC3heDayMI4WZkHPk9W9RpQCU9aX1p3d2jNiaoFuBN4bCdGiBjqwT
         1/3A==
X-Forwarded-Encrypted: i=1; AJvYcCVj1DJ796dWSrbmN0FiJIucd4ebT4MZMx8Y4DrM3t3uNoSNfvWj8Jtz5/sfl2f5kGsdBgzwjbanS+y4Zx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RfCjtgG7CT6z2zSyDLXdi53102AUhYF3kvv/HKN7OjfODz3c
	ezxp4M3KPE/BOwIWA8Ara7rjd+gsFPGpxz8C6sKZglsYiqwYUr/J0O2n0mERgqQyQF4=
X-Gm-Gg: ASbGncuMjihqhOElVvoMklLmij2fZE6PyMcVov50C3SWAUTz8xwEjQmcj24CKFc9A9Z
	4ypjDrJt5JqYBjbZWon4B231qhPlBWp+OL5eDh94gDTF73rXAKz+0tpMimJGLjXMlGUPMwdnIwy
	euzVetDvbXPYJtTxPLTXi3AFTumP5gR6tQO5dWAQT4lRgHOrAyET/WvHiNomOfP+PbFinhC82TN
	0u5CZpJ7ZueOS9KcqEzgeGsK7snUnFPQXyiBMUE38FV99mrdZ2HeBxFikW87U+41Des12mACCua
	Pcw+ajy7ShGN/ybcLlEQAPKOX06suuUMF3UcsLRNAOonThnv8LeaSD7/vQ4OYnYUzklQXM6oK1U
	0goleTtym6pPrupw6cxYUT49yb0MfdQhj9foTArB14kj3+NmMkEmByJiDzU+KWZVV7dDYa3yW
X-Google-Smtp-Source: AGHT+IESfdDpCl3TykV3jnebGBOgzapv9FYkIKAhNH+gAKGVBuzPG8lrd5CjZsSJSCN84KOJrH4GFQ==
X-Received: by 2002:a05:6602:2c06:b0:948:cbd2:3b84 with SMTP id ca18e2360f4ac-948e0d87a37mr14748539f.11.1763053963524;
        Thu, 13 Nov 2025 09:12:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2ba690bsm82035439f.8.2025.11.13.09.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:12:42 -0800 (PST)
Message-ID: <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
Date: Thu, 13 Nov 2025 10:12:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 9:39 AM, Jens Axboe wrote:
> 
> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
>> Changelog:
>> v4:
>>  * Changed double "if" to be "else if".
>>  * Added missed PCI_P2PDMA_MAP_NONE case.
>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>>  * Removed REQ_P2PDMA flag from block layer.
>>  * Simplified map_phys conversion patch.
>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>>  * Added Chirstoph's Reviewed-by tag for first patch.
>>  * Squashed patches
>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>>  * Reordered patches.
>>  * Dropped patch which tried to unify unmap flow.
>>  * Set MMIO flag separately for data and integrity payloads.
>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
> [2/2] block-dma: properly take MMIO path
>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb

And now dropped again - this doesn't boot on neither my big test box
with 33 nvme drives, nor even on my local test vm. Two different archs,
and very different setups. Which begs the question, how on earth was
this tested, if it doesn't boot on anything I have here?!

-- 
Jens Axboe

