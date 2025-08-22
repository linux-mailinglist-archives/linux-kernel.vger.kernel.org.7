Return-Path: <linux-kernel+bounces-781379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD6BB311BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8715E10D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663082EB5CC;
	Fri, 22 Aug 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd9gNNsY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0201EA65
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851213; cv=none; b=ssKBMosJMYhsf5YaQMqln+uqEAyZlq1+bkKZnLWMkj3nDMJDNbedirxEecXlIGNyvlbrTX7/0gyiEdx2b8p7e0E8xM3u1UXW0SRNfau0Fx/DmB5BF9zjNRXCAy0Si1KMVKDW3xqHxy1yawUAzLS+JDi9jb4/7KFsxufHUVZ8rXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851213; c=relaxed/simple;
	bh=Cu8xo//SuFYNe/yq/cf/lP09igfl1ZhrHUxrSpyAdQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgWxvt6hyoHbTk53SY7Vu5G2a/45vgmbYe4CJ5sv1eeQZa4GdpY+49kGIKd293nhNsa3Bdv6MC0rlBKIH0SEAouZXWyW3RMG+1dzvF0Saum/yZPJ1Eurep51m3dpkFuGYFbRz8uhgUg/CakFYPj1PcUFHKNoYKm+b+PaH3HC1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fd9gNNsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755851211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lT0Vt6aiyXs+DEMRvuBBLV7w2IbA5/N0O5+Xoi7IwY4=;
	b=fd9gNNsYIMcNsR9assTvgDN9MlDJRnyXg2J+5hCBgHnIq482Z+sKM/8JRMRm/vm5Omoyn2
	RKlQTHLE8QB7XFh5DkUHKI3ymOV29G1alFOGw2gQKRI/g/gKxRZirgotHU8M4/Z/N6Cavh
	rOn09u9ncg8zY1SzeuhLcWa8rlXWXSc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-XYX4Le40Oz-VGM7Tewtw2A-1; Fri, 22 Aug 2025 04:26:49 -0400
X-MC-Unique: XYX4Le40Oz-VGM7Tewtw2A-1
X-Mimecast-MFC-AGG-ID: XYX4Le40Oz-VGM7Tewtw2A_1755851209
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70baffc03dbso39846626d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851209; x=1756456009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT0Vt6aiyXs+DEMRvuBBLV7w2IbA5/N0O5+Xoi7IwY4=;
        b=Eg37abtmLbleRVnn08uq2NC24OouD3HnaRWviDkW+6SsC+b05bAEAwCMS1F2zgLwRg
         N1hTRI7VWgeSweYguanSMqVXMKEvzsHEPD3311wiAI+CmSpl58geVuayg7i6balKY2PM
         1F0ufgL86jclVOckAOpbNEG2ingcyScdhhbTFnMWRzqYJ1J1jOqaH2ECwlZXR6ArQF5r
         KfIAalXxAlH39cyqvdDJGWqze/u5sBU9oeWO1W4Eqd6Og6sW6fr5rnExFCisOB4mfalW
         ZBQyygrWcOAgektGFhwk2wLL2SHU4Lxm3TIJTA8pxhITsuPfA36r+PniYVYHJg565cnF
         FyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVWUu58EK0MBBOqDzZj0IGFLK6uJ4WZiDL6/w7GHws0KegXkKixvtp63XzyqdD29sT9cc/v/PSiTY4KgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBDB9fM24kiRukUcKOw+qQcPx1TedwnK+B8zwufNFUHmIouHz
	dccw42ep4TTD+z8psOfztnH84vNMdUxpuNrtXv/vI0bb4CgOtURz+HJ7zh88SUTSY1KVZyMSSPR
	bSKZDuU1wmMdQruepkynYNN8pisuq7yGVqQQUdXzjgxHzGEz/xlJeQD8WXZNOV8BpnQ==
X-Gm-Gg: ASbGnctQzHtlwfnLXypWkpfA3C2pqpvs1boOSZ9kwVk+8rlt+0v4IKciMHM7TS2pTHs
	co/PTcQJPFGQqEEHcZPj3ttYm1kI5zQFY0w2gOOAUPjThorRUuHT12o9YC/x9vLxPW2Qqjt7k43
	ctUYlR5AN8TMrMCJKb9IbtWEmrmd8UHVrwI+b+9Yu55lpDhQZwTEHVtMoytsefCELAT9HmPqx4R
	bKFdqn/xxP5Jw5fd5cb3FSsCBJoVT2yEqsM5WZaG5OP+evCX1a722qqUiOy3Dj2tSFjWciCkE2m
	8GSlxUjG55LwYpdl0PxbMKodQnpIVCibiEcFUKQ34zCHjYOWhTQuZ3f8xxpA3nHxNqZyYOosCCJ
	KbmSYOtXydOg=
X-Received: by 2002:a05:6214:dcf:b0:704:a1c6:fff3 with SMTP id 6a1803df08f44-70d893b7e8cmr65023886d6.15.1755851209050;
        Fri, 22 Aug 2025 01:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbuSV5M3uUv5uKHoyxUj5Lwj/G/7tQhGlA5XRvn/4WeYWUt+BF1kAeN6hrGRVpk3imrKmvZg==
X-Received: by 2002:a05:6214:dcf:b0:704:a1c6:fff3 with SMTP id 6a1803df08f44-70d893b7e8cmr65023666d6.15.1755851208545;
        Fri, 22 Aug 2025 01:26:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9086433sm121691916d6.24.2025.08.22.01.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:26:48 -0700 (PDT)
Message-ID: <d986135a-d0ee-4878-9fc2-958f35d569da@redhat.com>
Date: Fri, 22 Aug 2025 10:26:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250821073047.2091-3-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 9:30 AM, Richard Gobert wrote:
> @@ -442,29 +442,26 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
>  }
>  
>  static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
> -				 struct sk_buff *p, bool outer)
> +				 struct sk_buff *p, bool inner)
>  {
>  	const u32 id = ntohl(*(__be32 *)&iph->id);
>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>  	const u16 count = NAPI_GRO_CB(p)->count;
>  	const u32 df = id & IP_DF;
> -	int flush;
>  
>  	/* All fields must match except length and checksum. */
> -	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
> -
> -	if (flush | (outer && df))
> -		return flush;
> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
> +		return true;
>  
>  	/* When we receive our second frame we can make a decision on if we
>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>  	 * an incrementing ID.
>  	 */
>  	if (count == 1 && df && !ipid_offset)
> -		NAPI_GRO_CB(p)->ip_fixedid = true;
> +		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>  
> -	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
> +	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
>  }
>  
>  static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
> @@ -478,28 +475,30 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
>  }
>  
>  static inline int __gro_receive_network_flush(const void *th, const void *th2,
> -					      struct sk_buff *p, const u16 diff,
> -					      bool outer)
> +					      struct sk_buff *p, bool inner)
>  {
> -	const void *nh = th - diff;
> -	const void *nh2 = th2 - diff;
> +	const void *nh, *nh2;
> +	int off, diff;
> +
> +	off = skb_transport_offset(p);
> +	diff = off - NAPI_GRO_CB(p)->network_offsets[inner];
> +	nh = th - diff;
> +	nh2 = th2 - diff;
>  
>  	if (((struct iphdr *)nh)->version == 6)
>  		return ipv6_gro_flush(nh, nh2);
>  	else
> -		return inet_gro_flush(nh, nh2, p, outer);
> +		return inet_gro_flush(nh, nh2, p, inner);
>  }
>  
>  static inline int gro_receive_network_flush(const void *th, const void *th2,
>  					    struct sk_buff *p)
>  {
> -	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
> -	int off = skb_transport_offset(p);
>  	int flush;
>  
> -	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
> -	if (encap_mark)
> -		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
> +	flush = __gro_receive_network_flush(th, th2, p, false);
> +	if (NAPI_GRO_CB(p)->encap_mark)
> +		flush |= __gro_receive_network_flush(th, th2, p, true);

Minor nit: I'm under the (unverified) impression that the old syntax
could help the compiler generating better code. What about storing the
diff in a local variable:

	int diff;

	diff = skb_transport_offset(p) - NAPI_GRO_CB(p)->network_offset;
	flush = __gro_receive_network_flush(th, th2, diff, false);
	if (NAPI_GRO_CB(p)->encap_mark)
		flush |= __gro_receive_network_flush(th, th2, diff, true);

?

/P


