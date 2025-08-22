Return-Path: <linux-kernel+bounces-781386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53307B311DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6995E2CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35BF2EB5C1;
	Fri, 22 Aug 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkVYBeB8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EF223DD1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851510; cv=none; b=Vvjm65PmNGPxLTymcU6Chnf8q/7qxMYjWnbbKcHG1B3tJk5b/YeRnHrBnmRj1IaWESiZU4dMRK2y9Q23CqHufX1WlL5iv2UirOdlNJHRtu34ht7PgRpNUEfaCQt0ve+DElFTcJKt2Bze3d49tp+EYNcUobQU46eiDMMxOAGGJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851510; c=relaxed/simple;
	bh=hqLtAJ9wABRlEYOn9xK6DZ0YTbB/5G/61j0q4mx2/lg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LRTZFw/vyK59sp2cG0ux5la+6VpHxhbeDrbHKTc7qWgAs/zodZWRhCTAkMl9rvn2+Q5RaNLk995VQErU33VpULwXzo29Nm/lsfQLUvMVArdvRCUPpJy4deI0FMwzszXNNfAeHSc5P8B8N0cgvRZaJrpcfoLbZsqoTrbowX2znhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkVYBeB8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755851507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBfUDrzwH2ngC4BBoj5LBB/d7iuKHS4QfXfLqrPHiM8=;
	b=IkVYBeB8JJeqI6GUad/g8nICaY6g0zy740TQ/bKLK3auVi6H1J/3hmMi4J0IgTLwrBi5r5
	FAJoX5Cp9I2L+sIyVStOjVOAksEmA1WKGUXT+A62xCFKzZ2sdidEAZj690xUyvugVipGAq
	kj8QTP8Du31aMdy0t+0oJODin26plPs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-R1NU_GY-Oj2TPvaRY-ud3w-1; Fri, 22 Aug 2025 04:31:46 -0400
X-MC-Unique: R1NU_GY-Oj2TPvaRY-ud3w-1
X-Mimecast-MFC-AGG-ID: R1NU_GY-Oj2TPvaRY-ud3w_1755851506
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d903d04dbso28668146d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851506; x=1756456306;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBfUDrzwH2ngC4BBoj5LBB/d7iuKHS4QfXfLqrPHiM8=;
        b=db0wwHOBziI6CNcMpanATqMgCdIEES6CiupX4wWDsZp16ea8iqCnpExNx4oJvF9ZPa
         jTsq6xLhBGx5l82s5Lt+FgkCFIqHLmR/LlV6SuYRHG+/ifwXF2mxk9uKmDk3Gz6RmuyJ
         7PKC8jSsbRsmUPaW8i8MDP98OZWVD8kgoNVLBSdekZJs23+O5070fetJ3bR2ShOe/jVe
         OWjiemBZKnYZGGbDWvuN1G8xNVVK8Zbutqknshyq44v45D6wf05Z6WhG80QGlYOBYAU7
         nsx9mvZBG/G9ztH6lNTFtry7hnWAeZ7rtFtn3vhuvxokk4nDQB3NAoyl1Pz0Ejvt/R0m
         d9UA==
X-Forwarded-Encrypted: i=1; AJvYcCV8viHkLazuhm1yp8OG3dNg9C0Js0+KdNDa/lWjydUsgq5/Mms7mevphZmNLHcGNreMCcMoO2MfsctJk9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vIbNImI4Tt+LApxtJGCOtB8q/JE2sOkQtORmbZoF+0Bszsdc
	XgAYzrT3sbdBlmy5d03hx+sb5c1DwmPZQzkUDlNSPBFf9ER1YnpU9bCzNl3TH1rij+ALjGrhn78
	YHDQU5Sd90Yge65jnj6f1LR4n0Fy4rzY/NodcPbYpF8sljCZ+UvWHeZ6IUPUp6MauwQ==
X-Gm-Gg: ASbGnctZX7Xj3sg7FuKA0t4Tt8+8ksVJVJJqKguGLijk/au+1qgTTv57QY9IVe7a6et
	VP3zCrwNVtmZ6hP959GPDoXaBF8/bfkhIFzwwFU6DRqrR7QdzMRI2FgS0nr1+SNXt9AeaXsXXTa
	MzxirRzh7lB58G53FWuHmWa9rY65gHPAreXOMc4NWVBhxodP/wFN0HTbxECRUz+7lsYzU4geyOy
	eL9XVw88f/YuLIo5l0GxcOYH7poFJEoiXn2GD+Pf551ow4cfqZA1mo5D+i5leDtHnFaYXt9T0Xp
	577+aYQ+OuywIQ9Sufn6tmPrPk3jejBLTJA+hUCp+WzZhXcXrRydrshl5NcTJyR3/n+6b5llqkg
	Enaz6UcN38/c=
X-Received: by 2002:a05:622a:50f:b0:4b2:9b6b:2e87 with SMTP id d75a77b69052e-4b2aaa5659dmr26798351cf.37.1755851505338;
        Fri, 22 Aug 2025 01:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgcD8gwiIxzXXKRCMowVi2ZH5iMzFmtaYO9GHaU6rujY/dSEy2icuZXX41HvTRFjjT1QARHA==
X-Received: by 2002:a05:622a:50f:b0:4b2:9b6b:2e87 with SMTP id d75a77b69052e-4b2aaa5659dmr26798031cf.37.1755851504761;
        Fri, 22 Aug 2025 01:31:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1ddd9fsm1306550985a.71.2025.08.22.01.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:31:44 -0700 (PDT)
Message-ID: <f3084a47-6c63-4ef4-948d-52835fa4c722@redhat.com>
Date: Fri, 22 Aug 2025 10:31:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
From: Paolo Abeni <pabeni@redhat.com>
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
 <20250821073047.2091-3-richardbgobert@gmail.com>
 <d986135a-d0ee-4878-9fc2-958f35d569da@redhat.com>
Content-Language: en-US
In-Reply-To: <d986135a-d0ee-4878-9fc2-958f35d569da@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 10:26 AM, Paolo Abeni wrote:
> On 8/21/25 9:30 AM, Richard Gobert wrote:
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
>> @@ -478,28 +475,30 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
>>  }
>>  
>>  static inline int __gro_receive_network_flush(const void *th, const void *th2,
>> -					      struct sk_buff *p, const u16 diff,
>> -					      bool outer)
>> +					      struct sk_buff *p, bool inner)
>>  {
>> -	const void *nh = th - diff;
>> -	const void *nh2 = th2 - diff;
>> +	const void *nh, *nh2;
>> +	int off, diff;
>> +
>> +	off = skb_transport_offset(p);
>> +	diff = off - NAPI_GRO_CB(p)->network_offsets[inner];
>> +	nh = th - diff;
>> +	nh2 = th2 - diff;
>>  
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
>> -	int off = skb_transport_offset(p);
>>  	int flush;
>>  
>> -	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
>> -	if (encap_mark)
>> -		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
>> +	flush = __gro_receive_network_flush(th, th2, p, false);
>> +	if (NAPI_GRO_CB(p)->encap_mark)
>> +		flush |= __gro_receive_network_flush(th, th2, p, true);
> 
> Minor nit: I'm under the (unverified) impression that the old syntax
> could help the compiler generating better code. What about storing the
> diff in a local variable:
> 
> 	int diff;
> 
> 	diff = skb_transport_offset(p) - NAPI_GRO_CB(p)->network_offset;
> 	flush = __gro_receive_network_flush(th, th2, diff, false);
> 	if (NAPI_GRO_CB(p)->encap_mark)
> 		flush |= __gro_receive_network_flush(th, th2, diff, true);

whoops, I rushed the above. I mean:

	diff = off - NAPI_GRO_CB(p)->network_offset;
	flush = __gro_receive_network_flush(th, th2, p, diff, false);
 	if (NAPI_GRO_CB(p)->encap_mark) {
		diff = off - NAPI_GRO_CB(p)->inner network_offset;
 		flush |= __gro_receive_network_flush(th, th2, diff, true);
	}

/P


