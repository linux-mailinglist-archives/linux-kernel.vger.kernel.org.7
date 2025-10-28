Return-Path: <linux-kernel+bounces-873457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF68C13FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9191F19C098D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831542264D3;
	Tue, 28 Oct 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoYo3AVO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAA2E7F2C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645473; cv=none; b=kkQn6Jf0Ipx9FDWZWbBd03g8vMQSV0RILKFBVqTkxhQFq4rjY42dCq1Tch+edUytZt8/oVG7KvOgub3MMaPNhQh5pN4/au4UWbRqMnVm9+a2hA2rdPicGT56+qY52kB1yGUmofzSBV4/0NbsX43h1Kr1jHuO3Lp/Kn7EIJt6RU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645473; c=relaxed/simple;
	bh=mfTHpsTxrS0GRVOGyogmOgzNBE++mmmkoqWmimNeCDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWUsskIlb85+fUOoL4i1Fs2GDDEJlEWZ7RamXRd8e5B54Fcc6bON4ZGQ+QO2docyUXdopDd1wRTOAwIMPsaDLwDPk1sHhHaEiHTN5M+dTM2vU2TQQXtoam5fnummlQHu3PhZySca5STD3AKsY+C1PzNFYHCD7Wj7Xlkqx7RRRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoYo3AVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761645471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56vwggYHsixFZVV59LtI7c2gTMZmsoUndn9sUNVFrqA=;
	b=CoYo3AVONzDfqKlDwm6sWhJN5H502a6rCq84yDLiQyfSC20P2n/ZxB2zrQu20tdYmJFeO+
	4ZXLB9LWd2BqIfmnyjAKxcGVBbpwGsEMLTA8D5qXGCL0Go8KbDfgeuc3mCHpSyjZG/22Pj
	9HqKDVWl31CKpiAYzEcKflWyrkGG4uo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-U-iBB3lAOkqAc8alIGc0aw-1; Tue, 28 Oct 2025 05:57:41 -0400
X-MC-Unique: U-iBB3lAOkqAc8alIGc0aw-1
X-Mimecast-MFC-AGG-ID: U-iBB3lAOkqAc8alIGc0aw_1761645460
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475e89435e0so8657765e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645460; x=1762250260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56vwggYHsixFZVV59LtI7c2gTMZmsoUndn9sUNVFrqA=;
        b=RXo25h0/uFN4cBnytcQQH/fTJVcXXCjomuHVJ2dUN+8w0mrvlGgbEWQiP+eP4iAJp8
         VyfI3htYooYsd6Kc1JWWcTQVwyknvBDDqRWkb614chMs1UIL0feI7Nm/CTMuLKWnrGhb
         epZ5OSk+O1P8HSgZbwSx9+uBFcNeOFPcLfoj5PUBFGMZxVRuzhfUMO/6gLj7667TRBBC
         U5pzsfO4byhD7LexLTgfz4aVcnicSDglClzupNDGGNTu6jaQ0+KGzsuNqNLY0pd+pm6O
         LdDpsmbvRy8v3OANarYF+D5Wo9OCorUjqMyy5kN/ZC59SZ0cegh6iefjiBOJ0qcVZmwM
         MAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFYshMD2ZPyEwZu0+1scwGRnDeo5s35ZEo5cvwMCO4QJyzKlWcNRH5VrzddKXyMn9fpCNSc+7sdWNW4hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKTyahrnoRltkI39iEohqRyRts+ZpMNQgZRSh+edox+YK3i9X
	W1/rO1MTZkGBMkXiWblqo+gmGZBDkTYRRI0WDMrpv5B2+aCho7j3dRv2RpoanWOnExPYntW/r+G
	f+YLy15p+Wo06gjwUYl+AiXWj7a3aNkTK8/zKD+MYLFm0wiiMq89Opuh5blvnFJfpxw==
X-Gm-Gg: ASbGncsWd31FqQr8xvmBGdHiKI2cqGOFvTSPHY9Fy3mTrGH00PtDUg+VFpJyuaJH4d0
	ImUGOsSP2/jNe6L3ig8wib29ErPE0XpJrkclJM9barmQPqOScKjWGCSWvezJpt+WnOMXB+sMW4t
	VliAgbvpGjxeXLM00jPnurSAOxJPJFEe7VV9B6uXUGCsVlsfROresjfqo+GVGTuYs0+2V24Wl5/
	4GCutyS1jvsOVryp6/SI4B/7leunE8wFjU7xaG8hutAIQvg16g7DSK+fGzhAgc4OA0BxC03r7z+
	aa1HbLJLwoGkw3ycy/tu7tH4g/DULo9NVKfE5OatVjSAPxRZfil0MOXULNiQ7Rq3S/AaeEA44kR
	7tOqFG3FYopPyc2d0yM07yxYY5TiyOHM5T8PgxXoW8ROHp40=
X-Received: by 2002:a05:600c:348c:b0:475:dd87:fa32 with SMTP id 5b1f17b1804b1-47717df6965mr24455705e9.1.1761645460301;
        Tue, 28 Oct 2025 02:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfvGvAXIxMGxMt5qnRV9V4eVSHT+20qORZtOfo2sFh3kW29aY8yAm1WYmSttOd9/cvNwTc2Q==
X-Received: by 2002:a05:600c:348c:b0:475:dd87:fa32 with SMTP id 5b1f17b1804b1-47717df6965mr24455415e9.1.1761645459854;
        Tue, 28 Oct 2025 02:57:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm22527595f8f.5.2025.10.28.02.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:57:39 -0700 (PDT)
Message-ID: <76d6ba7e-f428-4a58-bde8-77cca1f5c3b6@redhat.com>
Date: Tue, 28 Oct 2025 10:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
To: Tariq Toukan <ttoukan.linux@gmail.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
 <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
 <aPouFMQsE48tkse9@horms.kernel.org>
 <83aad5ca-21e5-41a2-89c9-e3c8e9006e6a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <83aad5ca-21e5-41a2-89c9-e3c8e9006e6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 1:50 PM, Tariq Toukan wrote:
> On 23/10/2025 16:31, Simon Horman wrote:
>> On Thu, Oct 23, 2025 at 09:43:35AM +0300, Tariq Toukan wrote:
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> index 376a018b2db1..fad6b761f622 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> @@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
>>>   int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
>>>   			 bool enable_mc_lb)
>>
>> ...
>>
>>>   	list_for_each_entry(tir, &mdev->mlx5e_res.hw_objs.td.tirs_list, list) {
>>> -		tirn = tir->tirn;
>>> -		err = mlx5_core_modify_tir(mdev, tirn, in);
>>> +		err = mlx5e_tir_modify(tir, builder);
>>>   		if (err)
>>>   			break;
>>>   	}
>>>   	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
>>>   
>>> -	kvfree(in);
>>> +	mlx5e_tir_builder_free(builder);
>>>   	if (err)
>>>   		mlx5_core_err(mdev,
>>>   			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
>>> -			      tirn,
>>> +			      mlx5e_tir_get_tirn(tir),
>>
>> Sorry, for not noticing this before sending my previous email.
>>
>> Coccinelle complains about the line above like this:
>>
>> .../en_common.c:276:28-31: ERROR: invalid reference to the index variable of the iterator on line 265
>>
>> I think this is a false positive because the problem only occurs if
>> the list iteration runs to completion. But err guards against
>> tir being used in that case.
>>
> 
> Exactly.
> 
>> But, perhaps, to be on the safe side, it would be good practice
>> to stash tir somewhere?
>>
> 
> I tried to keep the error print out of the critical lock section.
> It's not time-sensitive so optimization is not really needed.
> I can simply move the print inside where it belongs.

Yes please!

Also the printk is performed on error, should not affect the path
critical path performances even if that would be time-sensitive.

/P


