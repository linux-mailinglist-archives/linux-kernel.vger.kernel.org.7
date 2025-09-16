Return-Path: <linux-kernel+bounces-818935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0372B5984D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7431E188971E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735F334720;
	Tue, 16 Sep 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPG8QG+A"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240F3218A7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030815; cv=none; b=PMLczwRosIFtFhfINeUAjZWKdzsMoMAcmGwwPSIu8sYfqfTObYdI08DDwBU03ZykPq0K2gS83PZ+Ae/i6P5xMe85udXrJC6i+MQnOMKkqGlSeUgQAcpBph5KjeQhyg2NlPDEoBj0b9vKZFUjHMcoIoURTRSCVvRraP8x+BKEF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030815; c=relaxed/simple;
	bh=zmbvb49IeeOyESGBcfHqaA3NfX6J0j7u/p7UgQNCKCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASOifp1gGAFZSUh1j8SIIP20cem0DwoG5EqwTpP/XUbeJYJWCi+gyZGidrY8KoJM0ublSR3OrLtraNvXAFC800ZBhKp8Qd8mMrBreT79cAfEx6G56cmPVdBeZf1oVF5HnKAbx4HbNtFrGgVDip/WcZt5n2i0abO4LhM0mT6wpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPG8QG+A; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so1581006f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758030811; x=1758635611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbOqW/N5SrxnkUMTlhv0qPouv1IVrVTd6BKNTP3Kvvc=;
        b=bPG8QG+AKeex0ja9c1ZwP84OZkdtecE3wipirDp0LmZInag/xdSSbwMahjl/9TWZeX
         OCv7xjLafm2Ux9gGDzOVV/FDuccf3TkbiIKGUoI5YxZ7SmOnThlYuD/91mCVzg25IvWn
         6FOs6Vjt5zIglHHsOcUZEambXZC+CzwzqabjPKyCdrk6jB46IRfGChWPAhSeC17KlSPN
         +gafxf/WYOQiiETMgsqHjkL2uHiV8MKBx9iXq5wv5jt1ZtMw9pnzuSd1aEdEC+qsZ/XC
         VaJe0svUdLirij+58gcGJhByGXw7FvYNVZHx1jcvpSJyscOQntoahHFeUeMEB2udsChu
         BGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030811; x=1758635611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bbOqW/N5SrxnkUMTlhv0qPouv1IVrVTd6BKNTP3Kvvc=;
        b=P/840zu30mtITFYMHdlfXJocCoKdBKUTKPyU8ixuabgrP4OILBj6X19syTOVQ9W4SZ
         jFsLQbCH+h4UvjCG+M+ma0SnFp12mD3UWNFwxNMg/r33JBPOAMFqPT0UuVT/kd/huwAy
         5Tisf1Ss+sswYUE17A8TeH9PssJJ8r41KT10o7d3TnBltQZdxKBG+NXxiFyvWURy1rEW
         jMSs087Zxgth/Yy9BXHG2DcN9pXTHr+OUWNI0GZ0gTODXypF3EqfU+vhYvY0iHevy2To
         zAu0/ioUeWefJvK/qW/KLIb+LlP5nVPr+wHBqWXHhFWtYRCfKYhfRJOXaP7Ao1WmHDYA
         R2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyn6arXHbhbmGcZCigFR3eXVxKSM7pRuA4xJlTJ1sxLMmlyO6rT84LCEC9nt6wKzwjSumlHXgqwcoRq0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysN9f9Q1jEbvX3knvNJ2DQvYDVUpWsHFRZWMmtNfvAfG/HqL9t
	042UrGEYon+72TBfE0qXXBDtpZDmCnc0GRGd2Jn+6rMjBUrq1miHuKzV
X-Gm-Gg: ASbGncuOReGPasTB0atCnmETku7xYnU3S3I1V6uAptxRiO0EY9WYT0uAHOhwJ1Hkyt6
	cB7sTc/aFefv2kYXr34VXeGkR14mWLtu2o9lL61trF6X0TG2JOgpR1cHx23lr3jHVgNjTZMePpF
	Dx9nPKLgJJyCt+VCjfpAsyVi/w3ISMehgsfy7G/kfPRXaXPq/XIEP5KewZBlEX5heXHyplvjRe9
	bhNfhLQynmw1FiJdJaP4DgDQUgRk6sx58x+gFyschth/DsLjzEHBMP/lblQqgXDBCXsy1RYyBAI
	Fx00gXPmpp6IKkY5UjcRjjKyMavmXeoCQOiwZviGWgMYGPPfI8Qy5UEDyPG6/FLvYNEHe9YI/Xe
	KVpT/yQ+ml3n0JWdL7x/I2ze5PbyliN+Pkg==
X-Google-Smtp-Source: AGHT+IHy6QB40r36ed9Cp1ALANrI+6S8gqwrZ50ik7DfqXSHvOuRtzJ/EoBpWSCvOSi0lDjDm10lpQ==
X-Received: by 2002:a05:6000:4009:b0:3ea:c893:95b6 with SMTP id ffacd0b85a97d-3eca04743f7mr2229713f8f.27.1758030811194;
        Tue, 16 Sep 2025 06:53:31 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f29174de1sm136858115e9.2.2025.09.16.06.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:53:30 -0700 (PDT)
Message-ID: <4b2c5770-ab53-43f6-8c68-7e2f4a912d8e@gmail.com>
Date: Tue, 16 Sep 2025 15:53:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 4/5] net: gro: remove unnecessary df checks
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, ecree.xilinx@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-5-richardbgobert@gmail.com>
 <willemdebruijn.kernel.d5fd7a312fe9@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.d5fd7a312fe9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Currently, packets with fixed IDs will be merged only if their
>> don't-fragment bit is set. This restriction is unnecessary since packets
>> without the don't-fragment bit will be forwarded as-is even if they were
>> merged together.
> 
> Please expand why this is true.
> 
> Because either NETIF_F_TSO_MANGLEID is set or segmentation
> falls back onto software GSO which handles the two FIXEDID
> variants correctly now, I guess?
> 

This is true because the merged packets will be segmented back to
their original forms before being forwarded. As you already said, the IDs
will either stay identical or potentially become incrementing if MANGLEID
is set, either of which is fine.

>> If packets are merged together and then fragmented, they will first be
>> re-split into segments before being further fragmented, so the behavior
>> is identical whether or not the packets were first merged together.
> 
> I don't follow this scenario. Fragmentation of a GSO packet after GRO
> and before GSO?
> 

Yes. One could worry that merging packets with the same ID but without DF
would cause issues if they are then fragmented by the host. What I'm saying
is that if such packets are merged and then fragmented, they will first be
segmented back to their original forms by GSO before being further fragmented
(see ip_finish_output_gso). The fragmentation occurs as if the packets were
never merged to begin with. IOW, fragmentation occurs the same way regardless
of whether the packets were merged (GRO + GSO is transparent). I thought I'd
mention this to clarify why this patch doesn't cause any issues.

>> Clean up the code by removing the unnecessary don't-fragment checks.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h                 | 5 ++---
>>  net/ipv4/af_inet.c                | 3 ---
>>  tools/testing/selftests/net/gro.c | 9 ++++-----
>>  3 files changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index 6aa563eec3d0..f14b7e88dbef 100644
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


