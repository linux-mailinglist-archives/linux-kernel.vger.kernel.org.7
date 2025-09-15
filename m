Return-Path: <linux-kernel+bounces-816400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E11B5735D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001903ABF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05562F0C5B;
	Mon, 15 Sep 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2HBUacn"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651F2D3212
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926032; cv=none; b=uQDB54EW4qEeQxzFi3wRBQAy3QINKRyyA9GGP5Y64qMkRkPFiYetXUs6uXSMXutgeLf6Rbv5f4rDoLayBLnYotKcCfyd1ODiA1Lg9qAok2mc7aERa+rasoPAmd7jnVpgF8Zk99fbQwXyquQCyFWWEs51GQyN3qebFTdoen1n/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926032; c=relaxed/simple;
	bh=RhNIq7hnZGcjn/f5Zl3RQLnfgLR/SNEk/Y5YGAQMLT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J10F6/ClOCDvfcsREgGiyPdblzyZ+HeLRM/HnUFQz6DNp0RF8ZXxILCPMz5Qrapv/9ehClTRs2bJpAwQw0bMu6TbMpApukg+EIbMsoDOHWBBJTxdH0tNpyqwwxN+Ht/XpYYr54dKte21lYA04PjRlHVc/hQWReSykfw5r0rJKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2HBUacn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so952489f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757926028; x=1758530828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeWCrHcuFJQca7c3KHuqecD6Yx1TOdfi8IxgxCePYwg=;
        b=b2HBUacnSGIRfc7L8sQSBV5Jeq9T4dGtncirTPrIowfylfZWmB6emZP3Zm5D+QlTOE
         iA48Sqd6hpy3Qw9Rdv2l5PqkeEelEITlZVGOZYECQUi7dsS4tiqchW2CAGY61KL0C0L8
         /pUdsNwTQ8LlAzMEhjFQuh0csXGgu1+GXcE0JFHKmFpy7Rd2gVFIt2zlt/fdNxpGaD5M
         lJ/vByo2b6juBC23bGeuYQVeLCwdQF3wAxkOP5WfjO8D5V8ztgbsIkpPJgEwbFd3IaPq
         cDHiM87TAyLWqVekrlVrXOGwCbkv38f86N1ibGMOZjMKFkJltmlL6FHIrtHGlUZgeNb8
         JMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926028; x=1758530828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NeWCrHcuFJQca7c3KHuqecD6Yx1TOdfi8IxgxCePYwg=;
        b=vLwzYxszW0RygOmc9hDnUbl3M6ntSZtwd2q4X+jpMsSS6avsYwQQFXYJ4a26+xhis0
         McCwNEKKA8dwyBJEaQ6ltiCHAMBZvoGtakIyRilLTX+ULYGKL0BTPO8+ABpbbq52Menm
         XbOcPUa/ahYQYUNPfCyDWGz4U8+z3iRzNhdxlyMPvV2pii7ihbtwOuGOsGRnmmf8SC6w
         oyWFeS9Gz74oO/rbQCZ/ulrP1arvMY7uYGbMWd4s8zD7jyfeXODG/kfb1HdkyrUpFJ6x
         HnDxei25wksXpTUMhJY8daXGRaN0ephhao6DSDWZlr9jmnfEd+nupX3NwGAlsbtPxDi7
         QBmw==
X-Forwarded-Encrypted: i=1; AJvYcCXvi2roMJhdVMf9N4VMXlJSuJjqJ51HPlyyGx2+GRh2NU+2q2pN7HEPusLZoYa1lORR1WPXGsTj7/Qxs0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YytI9NjtysSEI5ByuK08G5Pqd3/1AwraSWABexQHJzGhLLuw6oR
	Xn4tzhRGEpbLTdn58Tzq7GHE2O9OEMFGRghz4+lqzVN3v7ukFOGaBXRj
X-Gm-Gg: ASbGncvMtLKWYhht2qXsmPHkQjcJTh53w8pO3KP+aT5omaw1w+9/zez1PMHjQghfDFV
	jileY7evPWw/QhcRJhYlAxlWtaJZLYevCINU7oNF5ajGf2Is3bXn77YVfCJD03mXzbFhq1we43W
	WPr+Ugq/KiXn/29k6MhfwEsr2hVCo6WJGjOFgoara4oKCRn/y+oeRo1rYO/jKYsosbywSu7P/6V
	a/rijYqNQWdZLlGbipOKO9y1OoHOyv8FwQamGojJQyhDFzmtThcp9cWFk1PT9XedKHXGMCTUHdF
	R0msl6kNqJB+AVTkqn7brTrTYe6qViaBooA4nYKPyyDhgA+PUtBsrDbgLSgHYskGr6HNFBoiGVE
	GHF/9bfzujwQMkYHN6g0UTe3SzLk1InKSuQ==
X-Google-Smtp-Source: AGHT+IEnR35kGekzsSQOOolWkENuf20h1eCcMTRZ6YwYt7+OxdsvEvVafLU/W3jYmP/qjG8iaSVmxg==
X-Received: by 2002:a05:6000:26cc:b0:3e7:458e:f69 with SMTP id ffacd0b85a97d-3e765a08312mr11273339f8f.56.1757926028001;
        Mon, 15 Sep 2025 01:47:08 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7b42bdc5asm11523113f8f.21.2025.09.15.01.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:47:07 -0700 (PDT)
Message-ID: <a18a6bef-0262-4c72-86c9-8df72c8c7415@gmail.com>
Date: Mon, 15 Sep 2025 10:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
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
 <20250901113826.6508-3-richardbgobert@gmail.com>
 <willemdebruijn.kernel.277f254610c6e@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.277f254610c6e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Only merge encapsulated packets if their outer IDs are either
>> incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
>> packets.
>>
>> Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
>> for unencapsulated packets) and one for inner IDs.
>>
>> This commit preserves the current behavior of GSO where only the IDs of the
>> inner-most headers are restored correctly.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h      | 30 +++++++++++++++---------------
>>  net/ipv4/tcp_offload.c |  5 ++++-
>>  2 files changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index 87c68007f949..322c5517f508 100644
>> --- a/include/net/gro.h
>> +++ b/include/net/gro.h
>> @@ -75,7 +75,7 @@ struct napi_gro_cb {
>>  		u8	is_fou:1;
>>  
>>  		/* Used to determine if ipid_offset can be ignored */
>> -		u8	ip_fixedid:1;
>> +		u8	ip_fixedid:2;
>>  
>>  		/* Number of gro_receive callbacks this packet already went through */
>>  		u8 recursion_counter:4;
>> @@ -442,29 +442,26 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
>>  }
>>  
>>  static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
>> -				 struct sk_buff *p, bool outer)
>> +				 struct sk_buff *p, bool inner)
>>  {
>>  	const u32 id = ntohl(*(__be32 *)&iph->id);
>>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>>  	const u16 count = NAPI_GRO_CB(p)->count;
>>  	const u32 df = id & IP_DF;
>> -	int flush;
>>  
>>  	/* All fields must match except length and checksum. */
>> -	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
>> -
>> -	if (flush | (outer && df))
>> -		return flush;
>> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
>> +		return true;
>>  
>>  	/* When we receive our second frame we can make a decision on if we
>>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>>  	 * an incrementing ID.
>>  	 */
>>  	if (count == 1 && df && !ipid_offset)
>> -		NAPI_GRO_CB(p)->ip_fixedid = true;
>> +		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>>  
>> -	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
>> +	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
>>  }
>>  
>>  static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
>> @@ -479,7 +476,7 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
>>  
>>  static inline int __gro_receive_network_flush(const void *th, const void *th2,
>>  					      struct sk_buff *p, const u16 diff,
>> -					      bool outer)
>> +					      bool inner)
>>  {
>>  	const void *nh = th - diff;
>>  	const void *nh2 = th2 - diff;
>> @@ -487,19 +484,22 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
>>  	if (((struct iphdr *)nh)->version == 6)
>>  		return ipv6_gro_flush(nh, nh2);
>>  	else
>> -		return inet_gro_flush(nh, nh2, p, outer);
>> +		return inet_gro_flush(nh, nh2, p, inner);
>>  }
>>  
>>  static inline int gro_receive_network_flush(const void *th, const void *th2,
>>  					    struct sk_buff *p)
>>  {
>> -	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
>>  	int off = skb_transport_offset(p);
>>  	int flush;
>> +	int diff;
>>  
>> -	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
>> -	if (encap_mark)
>> -		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
>> +	diff = off - NAPI_GRO_CB(p)->network_offset;
>> +	flush = __gro_receive_network_flush(th, th2, p, diff, false);
>> +	if (NAPI_GRO_CB(p)->encap_mark) {
>> +		diff = off - NAPI_GRO_CB(p)->inner_network_offset;
>> +		flush |= __gro_receive_network_flush(th, th2, p, diff, true);
>> +	}
> 
> nit: this diff introduction is not needed. The patch is easier to
> parse without the change. Even if line length will (still) be longer.
> 
>>  
>>  	return flush;
>>  }
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index e6612bd84d09..1949eede9ec9 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -471,6 +471,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>>  	struct tcphdr *th = tcp_hdr(skb);
>> +	bool is_fixedid;
>>  
>>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
>>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
>> @@ -484,8 +485,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>>  				  iph->daddr, 0);
>>  
>> +	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
>> +
>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
>> -			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
>> +			(is_fixedid * SKB_GSO_TCP_FIXEDID);
> 
> Similar to how gro_receive_network_flush is called from both transport
> layers, TCP and UDP, this is needed in udp_gro_complete_segment too?
> 
> Existing equivalent block is entirely missing there.
> 
> The deeper issue is that this is named TCP_FIXEDID, but in reality it
> is IPV4_FIXEDID and applies to all transport layer protocols on top.
> 
> Perhaps not to fix in this series. But a limitation of USO in the
> meantime.
> 

Yes, I noticed this when working on this change and there is no good
reason not to do this for UDP as well. I think we should address this in
a separate patch series.

>>  
>>  	tcp_gro_complete(skb);
>>  	return 0;
>> -- 
>> 2.36.1
>>
> 
> 


