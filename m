Return-Path: <linux-kernel+bounces-814832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038ACB55918
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606521C283F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD427A92F;
	Fri, 12 Sep 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3icHVmn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A9220685
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715794; cv=none; b=dB80UciE6VN9vO63KE0LaGEHjY5VKhb99FGSn4+ryoYk52CO5yf0CiY+glE0DbVrVeShUdLyxJC4arxONdVKcQfWLUdLnbp3tmMDgpgOZuFr5wtvco+VWJCSkifKpd6WgiAGd9gKDO/cdn8RUTNDZH790B281vdPuMis9W40fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715794; c=relaxed/simple;
	bh=975rLZ/crgWlCXiEG4lcMWnfUSP2uBBlhbiQ/lUTN/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkzuXKXgFKoJdAqMDkKX2DVEwaMeMRtgCx5imX7Baa9tqi8hRJDQbgqqPOx+Qz9RVnpm8m+7HuksmhQsBaSlVe4O382o3Xzbh44sX7J6amfL3DJVMkzBuNh13xkEr32xvgyZhp4KAIw5+iTntMiGHHl9fzY5uksD33cgPqVp42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3icHVmn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445824dc27so21047365ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715793; x=1758320593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNNz2LKIxZ4gQ2Jb08OrP2M90WgN4MOeVyOVAJNK1qY=;
        b=h3icHVmn/JrRJh0k8V4ygFIywjheSrFmqDh7rnMFZ1W09jedMLYZ1JD9gcJwMHpb9v
         vIvFDFJmDQWEgpvyJlRgi5iaAoJkrdRTBdN/pfk+X4OE7xie3Hetqo9XWT5KKaTY1AUC
         +OtoHtXlUyufQbayo8X3kNxHXE1QYuU0rkmUuAiqAr2Up06D+wkWUZE2OLFHIi2/yoAu
         Os4OJ342ZV0Xd0GYSbygM2obc+IMhCMW0AG20He9LcZW7EjSgiX7n/nYLcKGNhO5oZaF
         G6LHFfpca570wUqW6nqA6KL3FbWLalQr/gaLxWwUE36B3qXqygNzFU1z/JOPl97NP6Qb
         ODyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715793; x=1758320593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNNz2LKIxZ4gQ2Jb08OrP2M90WgN4MOeVyOVAJNK1qY=;
        b=jP2RPHnXulPSFevxcbsYRlPPddimvh6bofVjT77FVXsLiYJCk6f26t0KegAPWGl+xh
         DcnCUlWYCcQ1oZ93P5B2Px8/B/RlAfrLh1uz2iTUFkR016FhgWGBcXJloA5cWxRiB/y+
         a1p4u0YDyHHTGWgt2nzwjzYW2Qq0LD0vdrGOavUEv6ydDBeusuzXewUSj+HwlxlEKXMK
         BPgmUyWwio9hpDPDTCb8IgZWPXSdueR31RI6E2V5TNGVbe1sq4BNeUUWjZCXgcW8836o
         zW2yJlt8rgmEFkpAfAIMwQyrj4CpsLUL6a9N0u93Nz2ABj8akLNDLuxxY9fMWg0XFJ/s
         ZWmA==
X-Forwarded-Encrypted: i=1; AJvYcCXgEl79e3jpGsW7UAJzeuUuqQu0Jjx8dq69gSd2uFcfwsThlDAwBirnaM89/rCHRS3q2+4Hz0X/hUWTW80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiz+HUr7cWzZ94pbQOkb+MjmYlowghrVCCdXMf0yBMPJjBMgiU
	TXZUyNwntKsBLIy32kelaGAyHpfW3dmsSvJ174wefPeNUaCXQ8I3nWY=
X-Gm-Gg: ASbGnctA/nHlcyglNInxd7k6nPgrFa2wSgV1xKPsPc46YaprSevuKuCYzO8+VrJwA4b
	tPxRDgYd9xPQ3vlrV/wHz8Jp5aX/HbITQbRZUZ7jqlbGzA9fbyRpCqoTMJ2S5xnY11VvznU1oYq
	CvHQ2Jsz67jtFpVyMsljBvc1DnEwEnB1UAw6hvfx0ThJXXeEw+IDbqp0c+Nb1PzIN7csXIojCgQ
	J5hbYsrNqUrm8ta45YR6EMJvXmR8P8OJZhbWlMnCmZyiQjOFKNUPncOHrLlDxsa30pU7TAV4mnS
	dlCcnvmn3ceZmS0VBAgPU0agQgZWVvS8vJ4/Sw45Ypuv4SETEwtmrlE3nNN5QWAFf8wCsOCVv1Z
	55C+twE09Noc/JZcC1ww4NgPGtFgVbJBUa0XS3aFALIgLhOEGAkkjx1UejcUj9WhKsAAGkR31+V
	sutMWQJi6+bERptqNCFo2xonLEd5RGhcOsoiY0NMmk5+gluGf9DuOjVG7rD59Az4cKX6x3pfJIP
	jBbTQr1ISH8+dk/r2dNMPA0FA==
X-Google-Smtp-Source: AGHT+IHjj4OcXZCby1eBKHFLR+sqWj7uD9adskfcLEg8FrukuNMZQMOs22KWMCIzEOzROeKLlPJ0Ow==
X-Received: by 2002:a17:902:ebc2:b0:249:2c76:54fc with SMTP id d9443c01a7336-25d2665fbc1mr55841325ad.39.1757715792473;
        Fri, 12 Sep 2025 15:23:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25d49093074sm34148285ad.149.2025.09.12.15.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:23:12 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:23:11 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 3/3] net: ethtool: prevent user from breaking
 devmem single-binding rule
Message-ID: <aMSdT7lQDvLNEvsv@mini-arch>
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
 <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-3-c80d735bd453@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-3-c80d735bd453@meta.com>

On 09/11, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Prevent the user from breaking devmem's single-binding rule by rejecting
> ethtool TCP/IP requests to modify or delete rules that will redirect a
> devmem socket to a queue with a different dmabuf binding. This is done
> in a "best effort" approach because not all steering rule types are
> validated.
> 
> If an ethtool_rxnfc flow steering rule evaluates true for:
> 
> 1) matching a devmem socket's ip addr
> 2) selecting a queue with a different dmabuf binding
> 3) is TCP/IP (v4 or v6)
> 
> ... then reject the ethtool_rxnfc request with -EBUSY to indicate a
> devmem socket is using the current rules that steer it to its dmabuf
> binding.
> 
> Non-TCP/IP rules are completely ignored, and if they do match a devmem
> flow then they can still break devmem sockets. For example, bytes 0 and
> 1 of L2 headers, etc... it is still unknown to me if these are possible
> to evaluate at the time of the ethtool call, and so are left to future
> work (or never, if not possible).
> 
> FLOW_RSS rules which guide flows to an RSS context are also not
> evaluated yet. This seems feasible, but the correct path towards
> retrieving the RSS context and scanning the queues for dmabuf bindings
> seems unclear and maybe overkill (re-use parts of ethtool_get_rxnfc?).
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  include/net/sock.h  |   1 +
>  net/ethtool/ioctl.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp.c      |   9 ++++
>  net/ipv4/tcp_ipv4.c |   6 +++
>  4 files changed, 160 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 304aad494764..73a1ff59dcde 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -579,6 +579,7 @@ struct sock {
>  		struct net_devmem_dmabuf_binding	*binding;
>  		atomic_t				*urefs;
>  	} sk_user_frags;
> +	struct list_head	sk_devmem_list;
>  
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>  	struct module		*sk_owner;
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 0b2a4d0573b3..99676ac9bbaa 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -29,11 +29,16 @@
>  #include <linux/utsname.h>
>  #include <net/devlink.h>
>  #include <net/ipv6.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/flow_offload.h>
>  #include <net/netdev_lock.h>
>  #include <linux/ethtool_netlink.h>
>  #include "common.h"
> +#include "../core/devmem.h"
> +
> +extern struct list_head devmem_sockets_list;
> +extern spinlock_t devmem_sockets_lock;
>  
>  /* State held across locks and calls for commands which have devlink fallback */
>  struct ethtool_devlink_compat {
> @@ -1169,6 +1174,142 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
>  	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
>  }
>  
> +static bool
> +__ethtool_rx_flow_spec_breaks_devmem_sk(struct ethtool_rx_flow_spec *fs,
> +					struct net_device *dev,
> +					struct sock *sk)
> +{
> +	struct in6_addr saddr6, smask6, daddr6, dmask6;
> +	struct sockaddr_storage saddr, daddr;
> +	struct sockaddr_in6 *src6, *dst6;
> +	struct sockaddr_in *src4, *dst4;
> +	struct netdev_rx_queue *rxq;
> +	__u32 flow_type;
> +
> +	if (dev != __sk_dst_get(sk)->dev)
> +		return false;
> +
> +	src6 = (struct sockaddr_in6 *)&saddr;
> +	dst6 = (struct sockaddr_in6 *)&daddr;
> +	src4 = (struct sockaddr_in *)&saddr;
> +	dst4 = (struct sockaddr_in *)&daddr;
> +
> +	if (sk->sk_family == AF_INET6) {
> +		src6->sin6_port = inet_sk(sk)->inet_sport;
> +		src6->sin6_addr = inet6_sk(sk)->saddr;
> +		dst6->sin6_port = inet_sk(sk)->inet_dport;
> +		dst6->sin6_addr = sk->sk_v6_daddr;
> +	} else {
> +		src4->sin_port = inet_sk(sk)->inet_sport;
> +		src4->sin_addr.s_addr = inet_sk(sk)->inet_saddr;
> +		dst4->sin_port = inet_sk(sk)->inet_dport;
> +		dst4->sin_addr.s_addr = inet_sk(sk)->inet_daddr;
> +	}
> +
> +	flow_type = fs->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
> +
> +	rxq = __netif_get_rx_queue(dev, fs->ring_cookie);
> +	if (!rxq)
> +		return false;
> +
> +	/* If the requested binding and the sk binding is equal then we know
> +	 * this rule can't redirect to a different binding.
> +	 */
> +	if (rxq->mp_params.mp_priv == sk->sk_user_frags.binding)
> +		return false;
> +
> +	/* Reject rules that redirect RX devmem sockets to a queue with a
> +	 * different dmabuf binding. Because these sockets are on the RX side
> +	 * (registered in the recvmsg() path), we compare the opposite
> +	 * endpoints: the socket source with the rule destination, and the
> +	 * socket destination with the rule source.
> +	 *
> +	 * Only perform checks on the simplest rules to check, that is, IP/TCP
> +	 * rules. Flow hash options are not verified, so may still break TCP
> +	 * devmem flows in theory (VLAN tag, bytes 0 and 1 of L4 header,
> +	 * etc...). The author of this function was simply not sure how
> +	 * to validate these at the time of the ethtool call.
> +	 */
> +	switch (flow_type) {
> +	case IPV4_USER_FLOW: {
> +		const struct ethtool_usrip4_spec *v4_usr_spec, *v4_usr_m_spec;
> +
> +		v4_usr_spec = &fs->h_u.usr_ip4_spec;
> +		v4_usr_m_spec = &fs->m_u.usr_ip4_spec;
> +
> +		if (((v4_usr_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_usr_m_spec->ip4src) ||
> +		    (v4_usr_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_usr_m_spec->ip4dst) {
> +			return true;
> +		}
> +
> +		return false;
> +	}
> +	case TCP_V4_FLOW: {
> +		const struct ethtool_tcpip4_spec *v4_spec, *v4_m_spec;
> +
> +		v4_spec = &fs->h_u.tcp_ip4_spec;
> +		v4_m_spec = &fs->m_u.tcp_ip4_spec;
> +
> +		if (((v4_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_m_spec->ip4src) ||
> +		    ((v4_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_m_spec->ip4dst))
> +			return true;
> +

The ports need to be checked as well? But my preference overall would
be to go back to checking this condition during recvmsg. We can pick
some new obscure errno number to clearly explain to the user what
happened. EPIPE or something similar, to mean that the socket is cooked.
But let's see if Mina has a different opinion..

