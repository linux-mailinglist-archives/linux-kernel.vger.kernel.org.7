Return-Path: <linux-kernel+bounces-852611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36BBD973F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3F91927984
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75A313E26;
	Tue, 14 Oct 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXHBtvVE"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF830EF66
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446322; cv=none; b=P7dJI/sKcmC8tgydOgPzwoU2lfNS86FTrIsKsSWzoRK78+19J6Ifdaxz3+NVu5TPbVq79pgahOdDKYwAoUO28SbjSiU1RC8AUBJZtJLD/X6bCuoyRceK83FYmTccLvjPE4Zb2CQvAJVs+o/ZlI2Mxuu+edqtQo1ReijGO2p9iOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446322; c=relaxed/simple;
	bh=lhZBS8xqXDtT7VbeKEzjyokyMGNBcF56sXqc2Q9DJ68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWXUqtwhotN4Jo3nDG6LD9jixSd5dsvcq9pCAamhQ4th9EkwEkPwXEDldbf/64OUJqMLhMxQEX9axHLr8KlSVd18/VBOSFS6m7qs/rbtAJqivfNrQ6Qhv7NSYViHW1SQFuBITLdojFWbw7f8Z6DyRlTK8rdX4gSD+c/rV2w9FOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXHBtvVE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so31903425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446319; x=1761051119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4vnL+R+LVejZqTBCW/1skmQQQlc0ydc7YfiCLUDn0w=;
        b=BXHBtvVEHAvK7Q8mmiYMJ16/vlxIoeSfAY9jPRq63rqfaWa7kEfrgh0fWWyDM0JKqI
         micUk2eB38L2gXyvom/wA1grjij6QkM5ucpC9ltqywt/NgoFiGoF7gD5IAHyWF/mLq64
         XIVoKnOnrjFmMCi67uGaDQ5h67+U/zuYKStcmGPjZ/wZzl7FFd0FjWg340EGH0S53WGk
         v+jW5oxqXIHKzIYR8vJu/Wei8UWKveHZo1wAhWRubqIX3avD504xMbQKEAkDFnOaHV1A
         UF+znnyPRNAoaxpYKM/3i8X6Z2pXbLhe2F1KguuumllWUYEPWcDfAiuhHJHZKh7S366i
         A6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446320; x=1761051120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4vnL+R+LVejZqTBCW/1skmQQQlc0ydc7YfiCLUDn0w=;
        b=XWBF6TkaYtb0bQAoeEHvtRdTPPJDvOsfnqvUVv+BMfwZY/DWY7PQwtjP07PzaumRzV
         236cPRJqzg/k8/QOVI+7vzJBCBSSx0B6ps3ZeKJW2R0x8lMCZN7a7FM5iIdmuhZXwvCL
         RdnxjsDxVL12/WVXqmimdsWHp2gyXM0VjuwJMYMz+dRbPblcJ+GYdrFTIaaaxnwAanu/
         qNNFXVbe9jyOV03b2punrk+He+3193EFmbbgwME06CWt86zfOejqH1Tef0DDgDd2543Z
         asKYwibN/xh3kkLp/urydWIG3oyojF7X45tJ7xTgwLVanrWxK4koUvcNMjfMkRKJbF1C
         2TOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjYc9jTEr60qWeGyERMCp/ad4l5FG7n0cJoBCtZoJSqrPrZDxNo2s/8qsxdRKye8FUjn1kZ+SFsO/3plM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtAswFwYMPBW8/BxudA2ufUSccr5WAOz6e62pWaqkzgHhZVSj
	MTUP4fx0GB5IdWVZ6P+l1STLeZSK91KATKFj9gJwWUDbQ9MKTMbQgG8C
X-Gm-Gg: ASbGncv/6kctY8LIFtgCbh/zkCALom2TDBIAQON/QT1kgKMmhBkO7aPdi1OX/PQ/l9Z
	XeKMq3/T0X5+9I78DF39NHXmwA3g7EYH+iB1Y06VCEEIofrd3k0xyHIUv/3PRHbyve5h17rrqmn
	3Q4Axng+uSIeNAnMmuuzjV4OU+v9kX2jihb0YrlkyQj56geKRxVvxDbTvoynO97NUV6MlwLYJBS
	q7/0apG0unNqSRkUcfEz4sn7UD3zh7NzaRKG46+0aOJwjQ9bkyJx1J27HrcvdyACY6nVWVM+X6L
	xb8ImuKorVGTsSvoEVBkqMBBe7MDGwmS/QCraAwZcoo22gJ2+AIZaqIfZNqRoYj3QqtFhYN27iY
	UylQ2KCcA8cFI35BUbYliLpeZo/IZXnSM4TbpjBJHTRv2MFaj7aXg9UdjH7gJgJ8BdR8fPslw1H
	UyIi/jJvgA
X-Google-Smtp-Source: AGHT+IHGhuXiI705ZMy4gT9FBX9BE9BgWkwpuFDltW+qidBa5CYSY2HjmkpobxQOHA/DrJoT1AzhIA==
X-Received: by 2002:a05:600c:1f93:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-46fa9a8ca9fmr177984195e9.7.1760446319404;
        Tue, 14 Oct 2025 05:51:59 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49bdfd0sm239969845e9.10.2025.10.14.05.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:51:58 -0700 (PDT)
Message-ID: <85a85b35-3862-4260-833c-267720125817@gmail.com>
Date: Tue, 14 Oct 2025 13:53:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/24] net: clarify the meaning of
 netdev_config members
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Breno Leitao <leitao@debian.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
References: <cover.1760364551.git.asml.silence@gmail.com>
 <fa4a6200c614f9f6652624b03e46b3bfa2539a72.1760364551.git.asml.silence@gmail.com>
 <572c425e-d29d-43e5-930f-4be7220e89fc@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <572c425e-d29d-43e5-930f-4be7220e89fc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 18:12, Randy Dunlap wrote:
> Hi,
> 
> On 10/13/25 7:54 AM, Pavel Begunkov wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> hds_thresh and hds_config are both inside struct netdev_config
>> but have quite different semantics. hds_config is the user config
>> with ternary semantics (on/off/unset). hds_thresh is a straight
>> up value, populated by the driver at init and only modified by
>> user space. We don't expect the drivers to have to pick a special
>> hds_thresh value based on other configuration.
>>
>> The two approaches have different advantages and downsides.
>> hds_thresh ("direct value") gives core easy access to current
>> device settings, but there's no way to express whether the value
>> comes from the user. It also requires the initialization by
>> the driver.
>>
>> hds_config ("user config values") tells us what user wanted, but
>> doesn't give us the current value in the core.
>>
>> Try to explain this a bit in the comments, so at we make a conscious
>> choice for new values which semantics we expect.
>>
>> Move the init inside ethtool_ringparam_get_cfg() to reflect the semantics.
>> Commit 216a61d33c07 ("net: ethtool: fix ethtool_ringparam_get_cfg()
>> returns a hds_thresh value always as 0.") added the setting for the
>> benefit of netdevsim which doesn't touch the value at all on get.
>> Again, this is just to clarify the intention, shouldn't cause any
>> functional change.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> [pavel: applied clarification on relationship b/w HDS thresh and config]
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   include/net/netdev_queues.h | 20 ++++++++++++++++++--
>>   net/ethtool/common.c        |  3 ++-
>>   2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>> index cd00e0406cf4..9d5dde36c2e5 100644
>> --- a/include/net/netdev_queues.h
>> +++ b/include/net/netdev_queues.h
>> @@ -6,11 +6,27 @@
>>   
>>   /**
>>    * struct netdev_config - queue-related configuration for a netdev
>> - * @hds_thresh:		HDS Threshold value.
>> - * @hds_config:		HDS value from userspace.
>>    */
>>   struct netdev_config {
>> +	/* Direct value
>> +	 *
>> +	 * Driver default is expected to be fixed, and set in this struct
>> +	 * at init. From that point on user may change the value. There is
>> +	 * no explicit way to "unset" / restore driver default. Used only
>> +	 * when @hds_config is set.
>> +	 */
>> +	/** @hds_thresh: HDS Threshold value (ETHTOOL_A_RINGS_HDS_THRESH).
>> +	 */
>>   	u32	hds_thresh;
>> +
>> +	/* User config values
>> +	 *
>> +	 * Contain user configuration. If "set" driver must obey.
>> +	 * If "unset" driver is free to decide, and may change its choice
>> +	 * as other parameters change.
>> +	 */
>> +	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
>> +	 */
>>   	u8	hds_config;
>>   };
> 
> kernel-doc comments should being with
> /**
> on a separate line. This will prevent warnings like these new ones:
> 
> Warning: include/net/netdev_queues.h:36 struct member 'hds_thresh' not described in 'netdev_config'
> Warning: include/net/netdev_queues.h:36 struct member 'hds_config' not described in 'netdev_config'
> Warning: include/net/netdev_queues.h:36 struct member 'rx_buf_len' not described in 'netdev_config'
> 
> (but there are 4 variables that this applies to. I don't know why kernel-doc.py
> only reported 3 of them.)

Thanks for taking a look! I was a bit reluctant to change it
too much since it's not authored by me. I'll be moving in direction
of removing the patch completely.

-- 
Pavel Begunkov


