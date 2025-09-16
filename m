Return-Path: <linux-kernel+bounces-819192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F472B59CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DC23A974C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB9372890;
	Tue, 16 Sep 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0KhIQ4M"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ACD372887
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038252; cv=none; b=Rt/NEGTtYUzmPokLrUrl9j/hz6p1zDiNPyoH+6QnQApvrDoIwNOczwbUeCYbgei6GcAkIzwE9dwJryY7CUCOBkSYX2lbvWTXJnkWnzGljKHEf8/ZNXm/jqEfk3JAiY8Mge/WRIgnzopi0FPzAfZkZLUv0Mf48dTMX8ZEWBiJxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038252; c=relaxed/simple;
	bh=XVY1KPWzJ/YGZWIZ1wzyfJJiEKD3gbCAYAId4zKeaqA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kHyI+YbtzpB2q1V+gWz6a6kFCY2xiwuoS6TKepCR3bw9+EiYmMDwPgyE4z+LGnbYBb6cp2GyOmePr9JRx5CEPQOslcCGhlc1Fszsnu0H45+okNgW733HPXb4Y+xeoE1rNFbbzch6PPtDoGnfpZ0cuZtSc0CHrAZKkE2wmq8Njfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0KhIQ4M; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8112c7d196eso595617485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038248; x=1758643048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wd2MJRnYQ7MsJqmQ1xoFKuUpX1v3JB2kIz+Wo1AJiQ=;
        b=a0KhIQ4MrOIA+sD8SktR/Fp1VJ3qra253/3FEJr4MmN+8le+i+MuUwMjeLi+iacyEn
         TyQ3qOezT1h91I9rRIbxS4gYb1SyUUes3d8D3ZeJ4gRkITgHkjUFtDhZdQg9+8YcnAj9
         rOJR2+dj2Xefaz48dsgOmXpUqqT/+Yrei/ZPVdsJBCcyrUag6PnFTzXpCu1buQwfJYqA
         yfPdhLUaJo9UdhZKmGF8u5gUz27XkEjSTvN+9E/HLl/RLMBcrRTyBaEvzwhtr8N/hfIC
         8lpXEpO7R7Q17YEVtCpNwBm1vnEoZLK9n4bycSVDYwbB4AtCBA5THoSqfXLMAun1ulVq
         I5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038248; x=1758643048;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Wd2MJRnYQ7MsJqmQ1xoFKuUpX1v3JB2kIz+Wo1AJiQ=;
        b=H+Iih56S0P2Wa5M9XO1g1dOogoDT1oLaTFifufirGmZm560OJmJ3sIdukeNoj0Pino
         AGIGsVpaGfFqOMZsOIH+icBwKBq7oU9Q9drVWPlok5XaYl30s5RUBdL/hHk0J+RnaaE8
         IyKqubTdShkpkG0ipMFj5sc/zZz935+Pvs2JgUBbB3Np4kXl9oK7eLGjRIWGtD4yPZR7
         ZVPQgPLA/BTol2yzwLfSxjQwN070J9rvTfl8Bv95CThuTT+3mQi+e6XbeAyUfPNwxDFc
         kVdVEKc5ndp2aeBM4trA8mJkx3VBYGro+RokTOGicxRYbHnNj9y5BLzcy8tHo5nx7f2B
         OOig==
X-Forwarded-Encrypted: i=1; AJvYcCWcZWiK2rlZnMZfGBH9cWRLzhhvOH9xIYy9f7rtxc+C4ZRexK+IqJs6RPR2188JrhHZaE2UqCBUal7Y174=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqSFQjz0cKyZEagb9/vsHMWyCnEYXjZJdgFsfJaJJO0jVp2CG
	e058XEch4UAOV0OkHNsAqyYyKKtCSrq3h/p8tDwku9vUR1jLf/8er3AR
X-Gm-Gg: ASbGncvAbmq21SQcz/pu8r6fTMCRaLQtJ3jXuGlfficVRQAFS3ipbgdk+7TeRHbPAMM
	WxvatrFsCBLZpaKC5pycD/oJ81j8FKxN+KtDqYJtWGtR15bGh5XAhmCp3/tqBgHi4YCW2MTdcAj
	K3Or5ygaunKJh9U4m5unI2aDKSOxIZoEWRczmkW+IuXSqqSe+KpGzgh/BJIP2NMPINKIThI71Zb
	f5Z6UCOg1A2cW2Vk0JmgMv2xdRmrRyeaN7MRMRQ3+q2g9qG4H1UETUW38JMdfMgEFQNfNKfYVAn
	FHgXvU8KtaR3Lp3bQwECzXP2mWA7a9XxmrWtf/VeMckpoowhy/HjCuao9HqRrYA98RvV8RfOlYx
	XsRqfXV6mjZfWAbZB+41o6bUJ0CTI3/JPyWPDLRzNnvllVjqtviSXxfaZlaT+jmYpIwXa279DJN
	jJnQ==
X-Google-Smtp-Source: AGHT+IErkEmH2qweZbpoDH0eSCZcXupsbTMzDfQwVn/43HSM7sskhY8O/6av8pU8QmfW7VI+ZOpgPg==
X-Received: by 2002:a05:620a:a093:b0:81f:eb9f:86de with SMTP id af79cd13be357-82400944ad6mr1715608985a.47.1758038247603;
        Tue, 16 Sep 2025 08:57:27 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639dab3e8sm84155821cf.24.2025.09.16.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:57:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:57:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com
Message-ID: <willemdebruijn.kernel.1fa5cf297a68d@gmail.com>
In-Reply-To: <4b2c5770-ab53-43f6-8c68-7e2f4a912d8e@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-5-richardbgobert@gmail.com>
 <willemdebruijn.kernel.d5fd7a312fe9@gmail.com>
 <4b2c5770-ab53-43f6-8c68-7e2f4a912d8e@gmail.com>
Subject: Re: [PATCH net-next v5 4/5] net: gro: remove unnecessary df checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > Richard Gobert wrote:
> >> Currently, packets with fixed IDs will be merged only if their
> >> don't-fragment bit is set. This restriction is unnecessary since packets
> >> without the don't-fragment bit will be forwarded as-is even if they were
> >> merged together.
> > 
> > Please expand why this is true.
> > 
> > Because either NETIF_F_TSO_MANGLEID is set or segmentation
> > falls back onto software GSO which handles the two FIXEDID
> > variants correctly now, I guess?
> > 
> 
> This is true because the merged packets will be segmented back to
> their original forms before being forwarded. As you already said, the IDs
> will either stay identical or potentially become incrementing if MANGLEID
> is set, either of which is fine.
> 
> >> If packets are merged together and then fragmented, they will first be
> >> re-split into segments before being further fragmented, so the behavior
> >> is identical whether or not the packets were first merged together.
> > 
> > I don't follow this scenario. Fragmentation of a GSO packet after GRO
> > and before GSO?
> > 
> 
> Yes. One could worry that merging packets with the same ID but without DF
> would cause issues if they are then fragmented by the host. What I'm saying
> is that if such packets are merged and then fragmented, they will first be
> segmented back to their original forms by GSO before being further fragmented
> (see ip_finish_output_gso). The fragmentation occurs as if the packets were
> never merged to begin with.

This explicit pointer that fragmentation for such GSO packets happens
in ip_finish_output_gso, which first calls skb_gso_segment, is
informative. It again turns an assertion into an explanation.

I think you jumped the gun a bit on sending a v6 right with these
answers. I'd like these clarifications recorded.

> IOW, fragmentation occurs the same way regardless
> of whether the packets were merged (GRO + GSO is transparent). I thought I'd
> mention this to clarify why this patch doesn't cause any issues.
> 
> >> Clean up the code by removing the unnecessary don't-fragment checks.
> >>
> >> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >> ---
> >>  include/net/gro.h                 | 5 ++---
> >>  net/ipv4/af_inet.c                | 3 ---
> >>  tools/testing/selftests/net/gro.c | 9 ++++-----
> >>  3 files changed, 6 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/include/net/gro.h b/include/net/gro.h
> >> index 6aa563eec3d0..f14b7e88dbef 100644
> >> --- a/include/net/gro.h
> >> +++ b/include/net/gro.h
> >> @@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
> >>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
> >>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
> >>  	const u16 count = NAPI_GRO_CB(p)->count;
> >> -	const u32 df = id & IP_DF;
> >>  
> >>  	/* All fields must match except length and checksum. */
> >> -	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
> >> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
> >>  		return true;
> >>  
> >>  	/* When we receive our second frame we can make a decision on if we
> >>  	 * continue this flow as an atomic flow with a fixed ID or if we use
> >>  	 * an incrementing ID.
> >>  	 */
> >> -	if (count == 1 && df && !ipid_offset)
> >> +	if (count == 1 && !ipid_offset)
> >>  		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
> >>  
> >>  	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
> >> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> >> index fc7a6955fa0a..c0542d9187e2 100644
> >> --- a/net/ipv4/af_inet.c
> >> +++ b/net/ipv4/af_inet.c
> >> @@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
> >>  
> >>  	segs = ERR_PTR(-EPROTONOSUPPORT);
> >>  
> >> -	/* fixed ID is invalid if DF bit is not set */
> >>  	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
> >> -	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
> >> -		goto out;
> >>  
> >>  	if (!skb->encapsulation || encap)
> >>  		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
> >> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> >> index d5824eadea10..3d4a82a2607c 100644
> >> --- a/tools/testing/selftests/net/gro.c
> >> +++ b/tools/testing/selftests/net/gro.c
> >> @@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
> >>  		iph2->id = htons(9);
> >>  		break;
> >>  
> >> -	case 3: /* DF=0, Fixed - should not coalesce */
> >> +	case 3: /* DF=0, Fixed - should coalesce */
> >>  		iph1->frag_off &= ~htons(IP_DF);
> >>  		iph1->id = htons(8);
> >>  
> >> @@ -1188,10 +1188,9 @@ static void gro_receiver(void)
> >>  			correct_payload[0] = PAYLOAD_LEN * 2;
> >>  			check_recv_pkts(rxfd, correct_payload, 1);
> >>  
> >> -			printf("DF=0, Fixed - should not coalesce: ");
> >> -			correct_payload[0] = PAYLOAD_LEN;
> >> -			correct_payload[1] = PAYLOAD_LEN;
> >> -			check_recv_pkts(rxfd, correct_payload, 2);
> >> +			printf("DF=0, Fixed - should coalesce: ");
> >> +			correct_payload[0] = PAYLOAD_LEN * 2;
> >> +			check_recv_pkts(rxfd, correct_payload, 1);
> >>  
> >>  			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
> >>  			correct_payload[0] = PAYLOAD_LEN * 2;
> >> -- 
> >> 2.36.1
> >>
> > 
> > 
> 



