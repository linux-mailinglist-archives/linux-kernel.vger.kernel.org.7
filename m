Return-Path: <linux-kernel+bounces-816471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71198B5742D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49D64404E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627162EFDA4;
	Mon, 15 Sep 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJRQgNbV"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAB2D3ECC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927502; cv=none; b=rQd3K+6LU/o4BxfJE/LiKKHQP1DqlRrSjkeoFSGzWtA6Gxo5PDsN+33JhIPArmLJteuR5JWtjVhWm+rmxWnIrA/lP/x3jhlu84huhi7rfA3gQ2DSH4L1ikGymkXmGLk7B0sRJJZJLE5Yw0WQrHFvVr0Pa86+CDVzjjiD0f0g2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927502; c=relaxed/simple;
	bh=IdmjxnVRgFKvYi4EvbH9O0PCSB358ZLwIm/ltyiSdjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c83ShmBLqgjLfwkkOKD6t1WgFgHkLkoJ5rYwL5AJDc85U60HFVkJTRXo70iGVFNAg2882gAaboDU7Uz+my15LOqi9rKScmP44JpZs5RnFkr/gJbgIEPyYh8TDEK4b2huQBJ5rurenZMxkSUNn9sKmmCxWNmpgEOlTfpk6ivuh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJRQgNbV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45e03730f83so17662705e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757927499; x=1758532299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCn95BTIPllEJXaRNBR7O2ZaWejHXVv/vaw1O/ijRvg=;
        b=YJRQgNbVSCW1Aw2sHdpmp7CE4kKj2wSPBrYTsZcw751vTPUTvKfemtSmi7uKvEmwyp
         c8TTDom1E/KLrZ2szUklmGG+sNPS2jNWKncMtgAdPv36tM4MMMQQmy0NJ/WwUrgOczQV
         Wi8GerIp0hGeQqFJfkbz7mZw00p9Bhu+7JWLCagzaPx5lx+UuJwiIhQDwR+90ST6xC19
         n0AqVldPbFmR8cOLeYCz+DvHhWq1Q4ci4zkPG5/2OqO39KWEP88sdDc3hk2gEcPQUoBY
         8nzp4NCUpcwAGEZlIJm6CCM2tcmTDCJ7dAYjx0ccKrCl+RpN8JOuOfa1D6A23KKrVYz/
         +dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927499; x=1758532299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCn95BTIPllEJXaRNBR7O2ZaWejHXVv/vaw1O/ijRvg=;
        b=OWmF78NcMpNAkTWbRVKsO/m9qpbEH+B/7cnUoQAJynVloPIRm/8vfDJFzaV/GStWXQ
         NLrhvuVSr6RN4Wke2z4bs9V3NgGNsIz3z6z+aQo8GscWz/csSjVZpenTioTPcH9U61MB
         kjQLeqT/Mmhvbl0v4RdboeMJ6gr4Fu14mcCCmaXqy0k8R/x3nEALh6y8+RraMDpRx3z1
         1KwpIDreipNcQBKyTc74DmtYCBVkq+ALloZviKYpSVa9E0pE0bKX3IClI8FnV5IDLsL4
         qExWNRAoueKJhpNRBgL4NsI0YbjQYvyAqbq0lNlRr1LBCMALvlX7h4V1tsKelKB+MT31
         27uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7y2X0ZKJdDhijx1mY1sgZf7HAHsRsORnmrXffcIF7njXNDYoKM1FhL2vmnJomaCDbYZOyMhPu9QWnYKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8QIAeLBaTrRGVeIRN2rwnL3X2ooqMtMKfjXC8g2v89PPFMcc
	8xrkOcEJfhhltPIdLoGsol0DpedsepYXbHhsSE31lIUiIXu4n2k5Zc68
X-Gm-Gg: ASbGncsgHsXpDdLlgBUTXwgE8uzZRuWq/b/VDQoQOieMMLnVC4FHZScyvZcnoRaP6bD
	zE2pCUWiCzOwCxAg/6miWDlBLios+/D4L+7sRPwerYjCLfa1sQwZBiSuHt50BiPvapoVTYRSQl9
	RoaB7774XO5LL6anBXudGGRXFtAackiw3Ryj0+Xb51F2G8RChEVWyS6KY6sxFBfwXI8ndizEAiR
	5ZTrDa+UQ4co37wUU8G7t7d4EKXPY9y2fuuuvR+wOZpckwfP9HmyJr5bNz49GjFYUOJSDFbGVXH
	xqyDRfpUcLpSfJ94YaNiwKdyQy5lsCxgWdE2m/Tu9N2aHKhtk3o+mMgGGwgZJq0X8JzZL4YLAn9
	6zLCKt6R6QnzjlScUDT5d5P0tqm/0BfVqLw==
X-Google-Smtp-Source: AGHT+IHuR3WQVz7I46/sPhKiL+ybrfYStZYlG10jCx/8wiURkkGlKfhXHZbv/80jd39X1bHQWzXbzA==
X-Received: by 2002:a05:600c:8a1b:20b0:45d:d3a1:70dd with SMTP id 5b1f17b1804b1-45f21221e50mr73711465e9.35.1757927498431;
        Mon, 15 Sep 2025 02:11:38 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e813eb46f3sm10356821f8f.23.2025.09.15.02.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 02:11:38 -0700 (PDT)
Message-ID: <63632c0f-8577-4ecd-8431-7d85fb464bab@gmail.com>
Date: Mon, 15 Sep 2025 11:11:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/5] net: gro: remove unnecessary df checks
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-5-richardbgobert@gmail.com>
 <willemdebruijn.kernel.868af9542505@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.868af9542505@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Currently, packets with fixed IDs will be merged only if their
>> don't-fragment bit is set. Merged packets are re-split into segments
>> before being fragmented, so the result is the same as if the packets
>> weren't merged to begin with.
> 
> This can perhaps be reworded a bit for clarity. Something like "With
> the changes in the earlier patches in this series, the ID state (fixed
> or incrementing) is now recorded for both inner and outer IPv4 headers,
> so the restriction to only coalesce packets with fixed IDs can now be
> lifted."

This restriction is unnecessary regardless of this patch series. I'll
rephrase it anyway.

>>
>> Remove unnecessary don't-fragment checks.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h                 | 5 ++---
>>  net/ipv4/af_inet.c                | 3 ---
>>  tools/testing/selftests/net/gro.c | 9 ++++-----
>>  3 files changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index 322c5517f508..691f267b3969 100644
>> --- a/include/net/gro.h
>> +++ b/include/net/gro.h
>> @@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
>>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>>  	const u16 count = NAPI_GRO_CB(p)->count;
>> -	const u32 df = id & IP_DF;
>>  
>>  	/* All fields must match except length and checksum. */
>> -	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
>> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
>>  		return true;
> 
> This is just a cleanup?
> 
> If so, please make a brief note in the commit message. I end up
> staring whether there is some deeper meaning relevant to the
> functional change.
> 

Will do.

>>  
>>  	/* When we receive our second frame we can make a decision on if we
>>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>>  	 * an incrementing ID.
>>  	 */
>> -	if (count == 1 && df && !ipid_offset)
>> +	if (count == 1 && !ipid_offset)
>>  		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>>  
>>  	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index fc7a6955fa0a..c0542d9187e2 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>>  
>>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>>  
>> -	/* fixed ID is invalid if DF bit is not set */
>>  	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
>> -	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
>> -		goto out;
> 
> I understand why the GRO constraint can now be relaxed. But why does
> this also affect GSO?
> 
> Fixed ID is invalid on the wire if DF is not set. Is the idea behind
> this change that GRO + GSO is just forwarding existing packets. Even
> if the incoming packets were invalid on this point?
> 

Basically. Such packets are forwarded both with and without GRO, and since
GSO restores the packets to their original form before forwarding, there is
no reason not to perform GRO. These checks are redundant and are somewhat
confusing.

Note also that FIXEDID can only be set by GRO, and before this patch, GRO
didn't accept packets that had fixed IDs with DF not set, so the GSO check
was redundant anyway. With this patch, the removal of the GSO check is
necessary as otherwise GSO will not be able to restore the packets to their
original form.

>>  
>>  	if (!skb->encapsulation || encap)
>>  		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
>> index d5824eadea10..3d4a82a2607c 100644
>> --- a/tools/testing/selftests/net/gro.c
>> +++ b/tools/testing/selftests/net/gro.c
>> @@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
>>  		iph2->id = htons(9);
>>  		break;
>>  
>> -	case 3: /* DF=0, Fixed - should not coalesce */
>> +	case 3: /* DF=0, Fixed - should coalesce */
>>  		iph1->frag_off &= ~htons(IP_DF);
>>  		iph1->id = htons(8);
>>  
>> @@ -1188,10 +1188,9 @@ static void gro_receiver(void)
>>  			correct_payload[0] = PAYLOAD_LEN * 2;
>>  			check_recv_pkts(rxfd, correct_payload, 1);
>>  
>> -			printf("DF=0, Fixed - should not coalesce: ");
>> -			correct_payload[0] = PAYLOAD_LEN;
>> -			correct_payload[1] = PAYLOAD_LEN;
>> -			check_recv_pkts(rxfd, correct_payload, 2);
>> +			printf("DF=0, Fixed - should coalesce: ");
>> +			correct_payload[0] = PAYLOAD_LEN * 2;
>> +			check_recv_pkts(rxfd, correct_payload, 1);
>>  
>>  			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
>>  			correct_payload[0] = PAYLOAD_LEN * 2;
>> -- 
>> 2.36.1
>>
> 
> 


