Return-Path: <linux-kernel+bounces-867251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D1DC020C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBC83B589B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AC03321BD;
	Thu, 23 Oct 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDmUQnKm"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDF32AAC8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231988; cv=none; b=j2n4MElQTSm6oY66XwlmYV7psnkwfccdOLkMvBLGG/5g3a14NagDlfd1rXVw9I6SU7GG6IsOkcnpWLHyc4THDjB7o54YFuJOAOkI+VcjfMVvEc3226cMsr1egfQMW4khHLc8/wF8ZtyyHXwKye4k7rtdX4aGyphdJDVG+HH+4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231988; c=relaxed/simple;
	bh=MvqFL77ZOpbzsQ/1SAvP195IIaFnAZVIetxFNQjBOxo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QmOtJud1lIN3KTrUW1FdO9wxyMUXxj0vEtrpPA9LqDdK3zO6C+75ddGHUhQPxTi9BopHGq3cNSWeNpdybIg9dfUaCHzjztTfrLg3QDULQAvCp8i4tnu/KFus/by8dhcIcIiHArVZQMPsF5kdvsjmWqlxt0omub9F/lqFsDfXm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDmUQnKm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a1603a098eso639055b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231986; x=1761836786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mvQKZArUDl984Y6+2a44gK2373aPFXu4OMsdAqeqhEE=;
        b=lDmUQnKmDhJ1d1CXwn9n35a64uUWYw5EQ6xSxdAf2Ot4bg4Pv0KSsFKVXtfUV/SaVI
         O8GymYJcK/3mD0UHX4s/9x3I3/HHSqKirL1aaOOQYUCr09wKriSiN+Y5THpzxeY/W9OS
         Tgex+GSFHB1+pNBSIqV3lE060wrgjhuD9EQ/0NE2L2UTFQ5sdPqJQnOHGM4cY9OxPdIt
         ZSrtHuhEfrNLZ26uZgUr7CbWwLVePXUyEQpXBroCriVFdKgCDFNfMqKgCBocIo8GaPvO
         CCtZudNzlvjoBvzVXxWkquT2PjfOdgPxJfyE/SftDNpAzXN7pS3epV/EMmh06b83+aiO
         5KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231986; x=1761836786;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvQKZArUDl984Y6+2a44gK2373aPFXu4OMsdAqeqhEE=;
        b=HccUf+kunsx1n+5MS3ccrchBSgvaYgqtxMkRwq+cxXXJPMjZOJdkyJEurrjuHqaNn4
         bH7AdN6Siminv7A/NdzzKkSH5UYrp7FxzB8YN5EsWOghYaj7B9j4oCRm0+QquPHG6Avb
         QFeTf2oMcNsfq6o+ZpXxpzn8Es0eMfpqLiNiP+7t1zJ+4hy+uXy0U/JQjx7vNr+DCMwK
         Kem3OrRfS74ISuEhh0CpGHH6hNVt+zDSOapRIdiKdrT+EkTRX9nn7qmyocszb3i/7+hh
         yZHVB8zXIu6J80r+wSyjLvVyRY7iRPo0sRkF9LlA0WgsAf2c8sBPzsP1Qz4VwbNLNraX
         aDjw==
X-Forwarded-Encrypted: i=1; AJvYcCUwv+ED438aHlH/fYl7yEwuxxLw8hXzjskyvttOh/OwViqa0n/YHLNe/ShiOK5ApD6GgVzoJ6WpH8WnjTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVhRDVj0MAhIN1yZ1KFOnnoGzHO/t9axrJo8849hRae5nWsoM
	GJvhlN3Aa5VKDsnWuFzMKmqGi0A2Pwe5K6p6X65s4QAJo0lqrSsbNHS7
X-Gm-Gg: ASbGnctVXUPsi+xdWjtlqtvtDMUWjCzZlbNlLc31xMU5hAkNmb4diBJzmvAy98FWmBL
	B4i9wDHhhLskPWBUgZjtt+/pCNkJaeuN8nbT7ZhvOkT6PeS8wAI0cRkedf4aNg4Jz0tBbqwH3G4
	FIGwfIGcZc+O0LAIzEx1IP2xmveCgxCia4kGod8ql6p6phDpusB8Cq8oCNnW1WDcA6UZAXn09Q2
	LZuRHMfVburfJsmuFDGs/ppQu4GKsJ1u7p9jziyjE5+09lZ78H6PU/4IirG69cXnfhl7f8fLQVc
	Jb3R7cvwAFU+JEJ/LEEurfiaiFZ/egIYXqANmYXYVNXOLGXxAa0ptKu0TLvTjAfE1MeyFirUiSy
	dQWg5dDYmJnQ200bA6/f1S4eXaOVWSkL/VeoBKyJ8qQJYI15a8Zy4OBR4zEt1R1rD+E2AqoNXKM
	QvSrmUUw1RIb1eV/bwTAVc7T71ZHtUBy4NBUqZpmpqplBDMCDG7dU=
X-Google-Smtp-Source: AGHT+IHmV7fyIld8QJGetoS158dw1CSCpgxRIKYp/OAxuCr3SCHqN63NNPoNTOeqZvoqcH0dXWwUhg==
X-Received: by 2002:a05:6a21:4613:b0:334:a9b0:1c87 with SMTP id adf61e73a8af0-334a9b01d07mr31195853637.1.1761231985521;
        Thu, 23 Oct 2025 08:06:25 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4? ([2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c13ea9sm2360547a12.16.2025.10.23.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:06:25 -0700 (PDT)
Message-ID: <9598c7ae-fda5-4b7f-8e49-751ce7d5eafe@gmail.com>
Date: Thu, 23 Oct 2025 22:06:17 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big
 packets
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
References: <20251022160623.51191-1-minhquangbui99@gmail.com>
 <1761206734.6182284-1-xuanzhuo@linux.alibaba.com>
 <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Content-Language: en-US
In-Reply-To: <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 21:39, Bui Quang Minh wrote:
> On 10/23/25 15:05, Xuan Zhuo wrote:
>> On Wed, 22 Oct 2025 23:06:23 +0700, Bui Quang Minh 
>> <minhquangbui99@gmail.com> wrote:
>>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>>> for big packets"), when guest gso is off, the allocated size for big
>>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>>> negotiated MTU. The number of allocated frags for big packets is stored
>>> in vi->big_packets_num_skbfrags.
>>>
>>> Because the host announced buffer length can be malicious (e.g. the 
>>> host
>>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>>> length), we need a check in virtio_net receive path. Currently, the
>>> check is not adapted to the new change which can lead to NULL page
>>> pointer dereference in the below while loop when receiving length that
>>> is larger than the allocated one.
>>>
>>> This commit fixes the received length check corresponding to the new
>>> change.
>>>
>>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for 
>>> big packets")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>> ---
>>> Changes in v4:
>>> - Remove unrelated changes, add more comments
>>> Changes in v3:
>>> - Convert BUG_ON to WARN_ON_ONCE
>>> Changes in v2:
>>> - Remove incorrect give_pages call
>>> ---
>>>   drivers/net/virtio_net.c | 16 +++++++++++++---
>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index a757cbcab87f..0ffe78b3fd8d 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>   {
>>>       struct sk_buff *skb;
>>>       struct virtio_net_common_hdr *hdr;
>>> -    unsigned int copy, hdr_len, hdr_padded_len;
>>> +    unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>>       struct page *page_to_free = NULL;
>>>       int tailroom, shinfo_size;
>>>       char *p, *hdr_p, *buf;
>>> @@ -915,13 +915,23 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>        * This is here to handle cases when the device erroneously
>>>        * tries to receive more than is possible. This is usually
>>>        * the case of a broken device.
>>> +     *
>>> +     * The number of allocated pages for big packet is
>>> +     * vi->big_packets_num_skbfrags + 1, the start of first page is
>>> +     * for virtio header, the remaining is for data. We need to ensure
>>> +     * the remaining len does not go out of the allocated pages.
>>> +     * Please refer to add_recvbuf_big for more details on big packet
>>> +     * buffer allocation.
>>>        */
>>> -    if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>>> +    BUG_ON(offset >= PAGE_SIZE);
>>> +    max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>>> +    max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>>
>> Could we perform this check inside `receive_big` to avoid computing
>> `max_remaining_len` altogether? Instead, we could directly compare 
>> `len` against
>> `(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE`.
>
> That looks better, I'll do that in the next version.
>
>> And I’d like to know if this check is necessary for other modes as well.
>
> Other modes have this check as well. check_mergeable_len is used in 
> mergeable mode. In receive_small, there is a check
>
>     if (unlikely(len > GOOD_PACKET_LEN)) {
>         goto err; 

I forgot about XDP zerocopy (XSK) mode. In that mode, there is a check 
in buf_to_xdp.

     if (unlikely(len > bufsize)) {
         return NULL;

Thanks,
Quang Minh.


