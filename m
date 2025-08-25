Return-Path: <linux-kernel+bounces-785218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3394CB347B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A60680911
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3D301493;
	Mon, 25 Aug 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCqCW9ef"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6A301029
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139900; cv=none; b=c7biwh2ffwErfaTT2S+Jg8zYNJnwgHO7ndzq/H44JaWvkFzv5VB1737AhNtFcpPMVpoYy2HUspWGEcD2VbapV7vkICP3k2NufVIgx48eUFYHypgBPJAPmVp0caA5G9+1jpY0/NPdKgL8nvme/b88O7fRs0xNdtGd/VvbPxZclCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139900; c=relaxed/simple;
	bh=rS4NLGQ3cm29c9I48A79rEOkkI867Y/jwCSJgsLNGuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeaJXgDF3pLNciaQFFpE4s8Z9gIooqBqLSE27CzqFSBc17NnqgVVmdZnAaDEtSg0Hr63adY8uWZLl3reQW5nrVPfqIoz6Vf4C4UML5kVwUH1dUzzp7m6C8KS6FlE5ectu4SuL61xJqEhGC3SaBK8KagvpTr3JbDzaj8qu+qo2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCqCW9ef; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756139896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOqQsOl1L9WBuNz/tsq6H1vvCCd+3l4jHwQMoFeSBs=;
	b=GCqCW9ef7d/mAG0tMCm03Zh5mgj1OVfbDKsfa1KYd3Fjm3/KGVr751bpygPzyl5y14Jt64
	WFtX9FFA75bi0s7wodS1BieHhdhy00PxoB5bE2ZOKcfu/NaeRhXrjG8FG+hYh0mIRfKq4k
	NHvgo1KHrKL2nk8PwLw7D0psC6wvVG4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-UFh2y0dqOCSzmmlRqEMH4A-1; Mon, 25 Aug 2025 12:38:14 -0400
X-MC-Unique: UFh2y0dqOCSzmmlRqEMH4A-1
X-Mimecast-MFC-AGG-ID: UFh2y0dqOCSzmmlRqEMH4A_1756139893
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c79f0a6084so706330f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756139893; x=1756744693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsOqQsOl1L9WBuNz/tsq6H1vvCCd+3l4jHwQMoFeSBs=;
        b=vitMIuj93nUuwhSoPMLpmEyC6sEYPmjM14CR9vFpf2UFk+yr0ATVjXtG3JmB4sG3v2
         0LAqYkH7rDj3zTUDQw+qcAA9dMwnClZ5oqM5ZOFPs07KjDoVSFAtB3L/ruOZnOOul9fh
         +ccdrz5IrEjTP+ESFhbPvrg2v7kTqftWDmT3ZejKLFfjaNmvL5aSR/2TSRSXRSGOPIhT
         REoeJIu4tVe4AwWBW+WBZ5xaaS4BTrZsEqJziOcc53gUA9x2ozTIX72AMezyDUpb9mwK
         HUFTaSIIKNHoKAiq7OhT7j+tch5hn1X3OVsUhz2yqbVrNEqEoez9zXQNWTg4vc+HUhtn
         PIpw==
X-Forwarded-Encrypted: i=1; AJvYcCUQxr57B7IyEeuiKyvKic+WucxbGyGnA7wgGkec90MmiIfygabYl1hUMPJFiQ6aqIQzfvZhhbybc4x9eb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKSkTmbTRJ3XNjAgzfWHSQXQRLlcN4bJGyQI6sMbYbBKxj4TYI
	ituLgTZqSC0nunKvQP1voqTb+DJa+Cap3EqVTSPG8ZYmSWgb6xHmJb5WIRCUXVc6SftPmDO8llw
	B3QnynqNovONSpFuUm3pOZSvQFnXWbLq+r4Lj9Odk+c9v8x4Y7lZoMPEFmZVJiZ9B4g==
X-Gm-Gg: ASbGncuV8zVgYna3hT/1Y5lDBhbc8GdGy+jRhk+ZY/BGpytMRRkG8a50k6GV/i5Rp4d
	dyZFTxvcAkvziCBoJDNyjY7HmG/88pQWdR62KUC+QFuzzKAWj1OZZ5tBSMCRjx5j2wpmZRDlIEf
	V/c664RAZwqp11IdZQXFeqHw+ABXBFvC5mnqh6KNXpAacwCHrY1fKjR5iMQp5tku9jrCpqYqzF3
	DpwRHWja2ZEh+GoQs9xVcKNV5sn/QoT+Ahyqujdzxhe+dQyGRoStb3YkrUr+3PYMvT7scOJ03sj
	y5FlGvA8x5dr0vHqaNwHh7Uv7gMeFINWJIW1POW37ZoZKCnASR0ov5ujyjifgoVa/ylcNZmR0Td
	BDpLbgfBmZw8=
X-Received: by 2002:a5d:5f55:0:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-3c87fbf31eamr3414108f8f.50.1756139893171;
        Mon, 25 Aug 2025 09:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxWufFp1U5EgXmP2NfBWHpN3YSozzioAzI3CWWgAwRfKMbNgAB7JyDJ5t5no/W/0GjLgDL5w==
X-Received: by 2002:a5d:5f55:0:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-3c87fbf31eamr3414088f8f.50.1756139892691;
        Mon, 25 Aug 2025 09:38:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711ca623asm12165054f8f.59.2025.08.25.09.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:38:12 -0700 (PDT)
Message-ID: <7edcbbb6-ac6f-4340-9629-c73ef5f12da8@redhat.com>
Date: Mon, 25 Aug 2025 18:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, ecree.xilinx@gmail.com,
 dsahern@kernel.org, ncardwell@google.com, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, willemdebruijn.kernel@gmail.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250821073047.2091-1-richardbgobert@gmail.com>
 <20250821073047.2091-4-richardbgobert@gmail.com>
 <4feda9bd-0aba-4136-a1ca-07e713c991b7@redhat.com>
 <7935b433-4249-4f3f-bf22-bb377a6f6224@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7935b433-4249-4f3f-bf22-bb377a6f6224@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 3:31 PM, Richard Gobert wrote:
> Paolo Abeni wrote:
>> On 8/21/25 9:30 AM, Richard Gobert wrote:
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 68dc47d7e700..9941c39b5970 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -3772,10 +3772,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>>  	 * IPv4 header has the potential to be fragmented.
>>>  	 */
>>>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>>> -		struct iphdr *iph = skb->encapsulation ?
>>> -				    inner_ip_hdr(skb) : ip_hdr(skb);
>>> -
>>> -		if (!(iph->frag_off & htons(IP_DF)))
>>> +		if (!(ip_hdr(skb)->frag_off & htons(IP_DF)) ||
>>> +		    (skb->encapsulation &&
>>> +		     !(inner_ip_hdr(skb)->frag_off & htons(IP_DF))))
>>>  			features &= ~NETIF_F_TSO_MANGLEID;
>>
>> FWIW, I think the above is the problematic part causing GSO PARTIAL issues.
>>
>> By default UDP tunnels do not set the DF bit, and most/all devices
>> implementing GSO_PARTIAL clear TSO for encapsulated packet when MANGLEID
>> is not available.
>>
>> I think the following should workaround the problem (assuming my email
>> client did not corrupt the diff), but I also fear this change will cause
>> very visible regressions in existing setups.
>>
> 
> Thanks for the thorough review!
> 
> To solve this issue, we can decide that MANGLEID cannot cause
> incrementing IDs to become fixed for outer headers of encapsulated
> packets (which is the current behavior), then just revert this diff.
> I'll update the documentation in segmentation-offloads.rst to reflect this.
> Do you think that would be a good solution?

I'm not sure I read correctly the above, let me rephrase. You are
suggesting that devices can set MANGLEID but they must ensure, for
encapsulated packets, to keep incrementing IDs for outer IP headers even
when MANGLEID is set. It that what you mean?

Note that most device exposing GSO_PARTIAL can't perform the above.

>> Note that the current status is incorrect - GSO partial devices are
>> mangling the outer IP ID for encapsulated packets even when the outer
>> header IP DF is not set.
>>
>> /P
> 
> WDYM? 

In the following setup:

TCP socket -> UDP encap device (without 'df set') -> H/W NIC exposing
GSO partial for encap traffic

with the current kernel, if the TCP socket creates a GSO packet with
size MSS multiple, the wire packets will have the outer IP header with
the DF bit NOT set and will have ID fixed - for all the wire packets
corresponding to a given GSO one.

/P

> Currently, when the DF-bit isn't set, it means that the IDs must
> be incrementing. Otherwise, the packets wouldn't have been merged by GRO.

Note that GSO packets can be locally generated.

> GSO partial (and also regular GSO/TSO) generate incrementing IDs, so the
> IDs cannot be mangled. 

AFAIK, most device exposing GSO partial don't increment the outer IP ID
for encap packet (the silicon is not able to do that).

> With my patch, if the IDs were originally fixed,
> regardless of the DF-bit, TSO/GSO partial will not occur unless MANGLEID
> is enabled.

I think the above statement is a lit confusing, S/W segmentation can
happen even if MANGLEID is enabled on the egress device: for FIXEDID
pkts, with DF bit not set, both the current kernel code and your patch
will clear it.

/P


