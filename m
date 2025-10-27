Return-Path: <linux-kernel+bounces-871853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D5C0E7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514171897285
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175830AAA9;
	Mon, 27 Oct 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0bSv9LS"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89F23BCEE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575856; cv=none; b=SJuQNGkszX7drwoQ6yCJPa+j7qt4Av8R4lAtlXEPo8EI3ft4p+EDB4f9TOGocf8r0iZpcK6ueukYVefXsHFFKSUJE0/SkvtnybdEcTA11nr1YSEY6gekpAZHdF1QG1VYKkSzLG7+PGqemShDB+ZRsdtKESAk5CsLr3Qm+4InF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575856; c=relaxed/simple;
	bh=adn7NhSXM4F+uMTSsRmO9V9GvUSLky72zBSuV3U4ELM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4Af9x7i9odJ4ZGpiJ4ExlreLhngBRPBjVXb2EcnQ+kzJlRSF3SnrHOpo/UrHxLo9ahtm9VklkhuhVRyNPzaM/mNQrZuPUwM9PVanpl3zcJF62FZSMyBuxwVZbUg4Wp98OI+0jhB2/F6Ey+os0eLB3sxWUVF3RLm69yrA3zb0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0bSv9LS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso3877177b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761575854; x=1762180654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4B2eLu4llGXCU4gdWSthJqBowpW96zatbh6aox0b+bY=;
        b=e0bSv9LSMLGnUeVspq1SLeSkr751kmjCy2clTjBW7kOYOko7npqJfCEHVKqhoJ2N3n
         znpD9EBNgOSTUzCNmcEJ5vf74Oi6sqshROnLL9bRoPDzeQplihCKvUX2KbmVyPzLY4MR
         7fMdsZn3oPCvWQhJDlNJZhSx583KCFrH9yBlio/8FE1OT1s+B6BDMB18VUy1/B8c49b2
         UgST7igncY1DlvPoKPrX6YUZ4oRq19MUkrasDH3LodHdRbCyx1FjmG3YYxaJaoKNX+LQ
         dRFp8sky/Tn7VgowolRlhGeR+K7AHlVLp96s/R88rt2lcL5AnUHm1M+z1ascOi+ZMaK1
         13yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575854; x=1762180654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B2eLu4llGXCU4gdWSthJqBowpW96zatbh6aox0b+bY=;
        b=YI7lzWlKG4MYkNn+Ci+t4JodQ1L3kNfo1Kiu79+YR+pVsHXfF7Gmko4DxbaNSDlhKc
         NCNMVDf7H66MZMdntGnHcGjPigIjP3QiAzjFdvrmfiRtRV2ZJTOvlQWK1uNq0eK7vlst
         dSTjHn6/H/NxwM9i49PalgU0GNw1zJUxTZxC7hLDniPZlkQr45mOprUQSef5etPFlgP8
         cCoNHOKHpVcf8dhgw/z0cV9Fh1XCrx4S0IhySxSKRhauVOLWUNejOkpo8/Boszt2Ps5+
         oGuUQ67hQX999+yCrEAVfiAFo8EQkczCbtuL7+2MjuKsZpgYKpbznBVz20CO3mAEyfzl
         +2cg==
X-Forwarded-Encrypted: i=1; AJvYcCUc/vdaTZW4Dc6RvWaNmQP2OBn/+Ng8mxZVlAwxlTh/johIWbXJQWyaNg3b/mtDM/TN3Rx4WJHhb0gIOX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycr1snJdRgXdm1K3BOheQZMHPfYdo8VTsWBvwWkP0FecLv6UYL
	r5+pjqODt9daf6mk642FA41jtDy0NXBYb+IrTYIcaFr58KED+ukX7Tp4
X-Gm-Gg: ASbGncud3auTo2evLEktFPGAUzBAEv7aB6yTMQbN3fhptCAHX+nn/ohrimTvVpYe7fE
	yyjf5VZo5Q8AcgAYjo+fgpGWqv26csxAgYFAqAb9jklolmbCxYjVrI6ic4uVR0jUzPll8AKVOZq
	1HaPsC0cfDhh55l2X4xiIWtJk0BmkLvkVxCT65syA4qXjm9B2JCjXkRyQ9xKmQg1qYJANKzg0Pg
	s9jZ6nyKNTjmhjTRnp8jKRVSOji6PkBzH78m06fn/v++vlSZQtWOpZPaWcsydna0YnPFMZby9RA
	1q5j3yMgnGuvpp23jJFni5c0edU6ecDYeSyuYnZR6cOtIagk0n4nHthuULyO5F3fs0vBZRKkkHg
	531Q5yqHLGwR/378LqZIjpaohVfIx+biCfE58TsONTdZNAgMMQVY4afgU12eNI2D7Or3IiGEFyH
	2QDt6GA+8IZJTIxE0ns9mLAGYsq67nrgsIHLR89c4qprgVtv1+31bo67ygPwBs/07DuXISIGKZ
X-Google-Smtp-Source: AGHT+IGTA/k5UQ2FNEr9mRS1Wz3fIDbx1lAqcpQR27aZ9cZE/UvwNhDm/mbd//iNK1nFji1/GqjjHQ==
X-Received: by 2002:a05:6a20:72a3:b0:334:79cd:fb13 with SMTP id adf61e73a8af0-334a85047abmr48082035637.4.1761575853948;
        Mon, 27 Oct 2025 07:37:33 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087cdbsm8438806b3a.64.2025.10.27.07.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:37:33 -0700 (PDT)
Message-ID: <b74b46e7-63e9-4330-b330-09d14d45fe9b@gmail.com>
Date: Mon, 27 Oct 2025 21:37:24 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
 packets
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <1761527437.6478114-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <1761527437.6478114-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 08:10, Xuan Zhuo wrote:
> On Fri, 24 Oct 2025 22:06:49 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"), when guest gso is off, the allocated size for big
>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>> negotiated MTU. The number of allocated frags for big packets is stored
>> in vi->big_packets_num_skbfrags.
>>
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>> length), we need a check in virtio_net receive path. Currently, the
>> check is not adapted to the new change which can lead to NULL page
>> pointer dereference in the below while loop when receiving length that
>> is larger than the allocated one.
>>
>> This commit fixes the received length check corresponding to the new
>> change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v5:
>> - Move the length check to receive_big
>> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
>> Changes in v2:
>> - Remove incorrect give_pages call
>> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index a757cbcab87f..2c3f544add5e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   		goto ok;
>>   	}
>>
>> -	/*
>> -	 * Verify that we can indeed put this data into a skb.
>> -	 * This is here to handle cases when the device erroneously
>> -	 * tries to receive more than is possible. This is usually
>> -	 * the case of a broken device.
>> -	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> -		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>> -		dev_kfree_skb(skb);
>> -		return NULL;
>> -	}
>>   	BUG_ON(offset >= PAGE_SIZE);
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>> @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
>>   				   struct virtnet_rq_stats *stats)
>>   {
>>   	struct page *page = buf;
>> -	struct sk_buff *skb =
>> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>> +	struct sk_buff *skb;
>> +
>> +	/* Make sure that len does not exceed the allocated size in
>> +	 * add_recvbuf_big.
>> +	 */
>> +	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {
>
> I think should be:
>
> 	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
>
> Thanks

Sorry, my mistake. I'll fix it.

Thanks,
Quang Minh.

>
>
>> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
>> +			 dev->name, len,
>> +			 vi->big_packets_num_skbfrags * PAGE_SIZE);
>> +		goto err;
>> +	}
>>
>> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>   	if (unlikely(!skb))
>>   		goto err;
>> --
>> 2.43.0
>>


