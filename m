Return-Path: <linux-kernel+bounces-819183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA3B59C93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0551A3BC0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8F0371E84;
	Tue, 16 Sep 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THQGgY8y"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144B3431E7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037955; cv=none; b=HNqKUCsHdLFF0SJ19o3EQCvrhtC761d3J6OwGbZ10cEXSSO4/oKMICuWYfYRdACIBDR42pAuVpnsSQyCShEHNcr3bn+E/A6WxIIlR1re4qI7Il7dQVJ2TWPcf120Ay/Dz33Pi8ilfre4/4woBhXMqQ4D41KWTSQKnA4ltafmFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037955; c=relaxed/simple;
	bh=nR1ZFEufE4ofnGHk2aDecs2iP9ah7RkvglBXbgiMKPw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ct05qVgz5GLZGwct6BpYVg4lCO3PKgsssFImx2u4l5f0lSezEmop1p0SCcpt8FDWsUY5KSbDctZ8SWpXlj0rz9Jqf2HCW8X4MYm71QQnEDhEakXZ3KAFLNT7pIyQgMzMYglB2KpK96P8IVMJlqXv3OyAH9KLITzoFSKHI4mBIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THQGgY8y; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-77766aae080so27299766d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758037952; x=1758642752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/mGXlYX+Pbvs+W5uXA8yTpOWbPYK7Fgg7qIzWdUqk0=;
        b=THQGgY8yUOD2KfQ7IrOkKCaJljIg6JXJQTQVkDlRSENohONgoavIEvkVOdXt+cTQyq
         QCtYkFd++6drf6IvtpUvWs0vXm52DS6LROiOfa1TWu9GiojYQPJSny5bzIQhFlnLs7VQ
         7bqYEEPUQFJ6AJG5X6Zx1pjdulUkxWUVb6lNoFlIdSkUY7yM1IwgREx0f0VKzByzMYva
         GWTaHSWIR6WktaedkQ2qW0H3iBdSKuqrrjGaCVRKRsc0XjEE/jFMwZkkh2uWRDwG3+GU
         mpZBL7SqrLOyIJ8DyJ+MYavqWcTINVG6c8lFxRbme+dY3BlSLkRanXcjGKY81vhneq4T
         axkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758037952; x=1758642752;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/mGXlYX+Pbvs+W5uXA8yTpOWbPYK7Fgg7qIzWdUqk0=;
        b=WrOC79HIThGK9AWSxG7csJUWIQAFJNQoZTcHgOYIwrPEucWkR9qwApvqY5EckaPvox
         0h+APMhk1FEXU6mAr23Oo4/cHRu+xqnfvzzeVMaf7SC6/kDUPathcc6MtmY8FqfpPfV3
         /8RW5qbEVge8nNm+6zBjVGLYat6RfZ2Dm72TbEm7aIbr/L5wP/qEWAALw9a6Q9v6RqBI
         LtYo04YZOrWh4Vo+5Z8eG5rV4jQT/jWYN5yrB5pstec4T7DPn8UxYTZiUGk5QUL3oEZ5
         Gm2r94I1emjW8/rWnLjrfmAzKtVYMZe93VELQkdrtOZTKy/ahJXY8LaO3tbp6TWrPFM1
         T12g==
X-Forwarded-Encrypted: i=1; AJvYcCVZk6NXB3Dn+elwRLrUaUjvDr7f1zm4bMuXR84va69GqgYPe9leUXZMjjPQc8q0DEJGFykJjaFfLJLfxnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNRNYAhku67qM+3eQDb3VCImSrSx6/UPXGwdiwjUX++Ev4Ypi
	DV4sYCwW5+Y+KtUu1JE4RDWYMZT67RnaKQ8lMyaxWguuBsR4zvw9r4BU
X-Gm-Gg: ASbGncsK0D+jiuuHvBA3h10tSoqERLf1VZDiXBkAWFROyxLQq1QQXBXW87ComX/ftXh
	LAXev+lgUK1ZL976graeClUD+YYZRgWZL3H9IRdnw6+miv9Isawf9jmGKvKIQlzFIKij/UB+eoe
	qzg6LRfL74ZrUYhXb2YZdsClUExY/XNyhonI6mmO9YOAb1rbAw530Kh9bkgSQ5hv6fpMc8NEOam
	lauZciVKDOUdFK/cvgrr5eYQ6yAGITSNuGWbfZEK1cf4W/uhU3XqB7ZhR6LSk0svk8eQffKAYF3
	uD/3Nyurjfoih0NYR/aZz97Wijp+QLpPDVAyvbtYen9sfAAYf/0x1JTFjIsFsSvX+jIhZCb9NkU
	ud91aO33V3IkJ9Mjq695hkecU9Mor0HCi43lAkpSPwobpskNl9bg7W98qXXDzym7mfxdEcjNaSU
	7t6g==
X-Google-Smtp-Source: AGHT+IH772KZKNLehHGZBE8Uu96oBA14Rqg9H+LHQAvQSI/5dAUSbeL17+MDrex9sTyD5EPZCNa/oQ==
X-Received: by 2002:a05:6214:21c5:b0:789:2556:f992 with SMTP id 6a1803df08f44-78d5d35a9f5mr33826856d6.14.1758037952119;
        Tue, 16 Sep 2025 08:52:32 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-783c85f16a1sm37635176d6.14.2025.09.16.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:52:31 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:52:30 -0400
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
Message-ID: <willemdebruijn.kernel.39980903d76e0@gmail.com>
In-Reply-To: <dca173e6-f23d-4f54-8ace-74329439c7da@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.1b773a265e8dc@gmail.com>
 <dca173e6-f23d-4f54-8ace-74329439c7da@gmail.com>
Subject: Re: [PATCH net-next v5 3/5] net: gso: restore ids of outer ip headers
 correctly
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
> >> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> >> be mangled. Outer IDs can always be mangled.
> >>
> >> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> >> both inner and outer IDs to be mangled.
> >>
> >> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> >>
> >> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc
> >> ---
> >>  .../networking/segmentation-offloads.rst      | 22 ++++++++++++-------
> >>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 +++++--
> >>  drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++++++++----
> >>  include/linux/netdevice.h                     |  9 ++++++--
> >>  include/linux/skbuff.h                        |  9 +++++++-
> >>  net/core/dev.c                                |  5 ++++-
> >>  net/ipv4/af_inet.c                            | 13 +++++------
> >>  net/ipv4/tcp_offload.c                        |  5 +----
> >>  8 files changed, 59 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
> >> index 085e8fab03fd..72f69b22b28c 100644
> >> --- a/Documentation/networking/segmentation-offloads.rst
> >> +++ b/Documentation/networking/segmentation-offloads.rst
> >> @@ -43,10 +43,19 @@ also point to the TCP header of the packet.
> >>  For IPv4 segmentation we support one of two types in terms of the IP ID.
> >>  The default behavior is to increment the IP ID with every segment.  If the
> >>  GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
> >> -ID and all segments will use the same IP ID.  If a device has
> >> -NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
> >> -and we will either increment the IP ID for all frames, or leave it at a
> >> -static value based on driver preference.
> >> +ID and all segments will use the same IP ID.
> >> +
> >> +For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
> >> +SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
> >> +Any combination of these two GSO types is allowed.
> >> +
> >> +If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
> >> +performing TSO and we will either increment the IP ID for all frames, or leave
> >> +it at a static value based on driver preference.  For encapsulated packets,
> >> +NETIF_F_TSO_MANGLEID is relevant for both outer and inner headers, unless the
> >> +DF bit is not set on the outer header, in which case the device driver must
> >> +guarantee that the IP ID field is incremented in the outer header with every
> >> +segment.
> > 
> > Is this introducing a new device requirement for advertising
> > NETIF_F_TSO_MANGLEID that existing devices may not meet?
> >   
> 
> No. As I discussed previously with Paolo, existing devices already increment outer
> IDs. It is even a requirement for GSO partial, as already stated in the documentation.

Where is this documented?

> This preserves the current behavior. It just makes it explicit. Actually, we are
> now even explicitly allowing the mangling of outer IDs if the DF-bit is set.
> 

> >>  #if BITS_PER_LONG > 32
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index 93a25d87b86b..17cb399cdc2a 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -3769,7 +3769,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
> >>  		features &= ~dev->gso_partial_features;
> >>  
> >>  	/* Make sure to clear the IPv4 ID mangling feature if the
> >> -	 * IPv4 header has the potential to be fragmented.
> >> +	 * IPv4 header has the potential to be fragmented. For
> >> +	 * encapsulated packets, the outer headers are guaranteed to
> >> +	 * have incrementing IDs if DF is not set so there is no need
> >> +	 * to clear the IPv4 ID mangling feature.
> > 
> > Why is this true. Or, why is it not also true for non-encapsulated or
> > inner headers?
> > 
> > The same preconditions (incl on DF) are now tested in inet_gro_flush
> > 
> 
> This comment is about the IDs that TSO generates, not the IDs that GRO accepts.
> I'll rewrite the comment to make it clearer.

Yes, this exact statement would convert the assertion into an
explanation. Really helps a casual reader.

> 
> This statement is true because of the requirement specified above, that device
> drivers must increment the outer IDs if the DF-bit is not set. This means that
> MANGLEID cannot turn incrementing IDs into fixed IDs in the outer header if the
> DF-bit is not set (unless the IDs were already fixed, after the next patch) so
> there is no need to clear NETIF_F_TSO_MANGLEID.
> 
> This isn't true for non-encapsulated or inner headers because nothing guarantees
> that MANGLEID won't mangle incrementing IDs into fixed IDs.
> 

> >> @@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
> >>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
> >>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
> >>  	struct tcphdr *th = tcp_hdr(skb);
> >> -	bool is_fixedid;
> >>  
> >>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
> >>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
> >> @@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
> >>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
> >>  				  iph->daddr, 0);
> >>  
> >> -	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
> >> -
> >>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
> >> -			(is_fixedid * SKB_GSO_TCP_FIXEDID);
> >> +			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
> > 
> > ip_fixedid can now be 0, 1 (outer), 2 (inner) or 3 (inner and outer).
> > 
> > Not all generate a valid SKB_GSO type.
> 
> Since SKB_GSO_TCP_FIXEDID_INNER == SKB_GSO_TCP_FIXEDID << 1, all the values
> listed above generate the correct set of SKB_GSO types. This fact is also
> used in inet_gso_segment (SKB_GSO_TCP_FIXEDID << encap).

Oh right. Neat.

That dependency can use a BUILD_BUG_ON.

