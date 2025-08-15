Return-Path: <linux-kernel+bounces-771083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D57B282AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A958F1CC16F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32128A3F2;
	Fri, 15 Aug 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="C1RVc9on"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DE289803
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270521; cv=none; b=J2Zplrqx9wfCghkr3WVOkyNbZj7klAPFtnzX1BegG64OCotkfIGzf8cSJj8BX68UdpNPlfDrNHduczqfZSU7d8NesnNotP8nsnh78umFK6t4dOUH8G0qIIi314iFcZ+0Dc+CyW0galyAsPUxvenE4naqdFS/TDuCfm1RLy0fCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270521; c=relaxed/simple;
	bh=wxXY4tEGwganMnpiKU8Ayd+L73yT/MpiUpiLzweyTx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDk6WMk//OM6AxdfKM5tzjbKOsExkVuB/s2LjT+SVlRGSzoEI7GnsbZjN6RnhNhKxRvqdNPEV0l8YEgvqjScXCKt5hRBqY6o/0ejwAInNyGhH0ZIx0B89IvYF2PL35LK+imL4Z5GWunxIEJqMQ4mQD7k0ploS93+r1OGR8qdE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=C1RVc9on; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so4283131a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755270514; x=1755875314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvYymIzLnJigupjUPWkbrLGydSeNzR7fRIJx+eQRmEI=;
        b=C1RVc9onz/M86sN91Ek7JRoEF86dRLnQdhY0FShJL5A9YAlHQ2ClSsbsvxzmosqedL
         kAEfrg81xKdPsfwcgf6XXePHbdulXFyTM583GPWP1mtlrFzYQohhm80NXZE9vKKUbikf
         gO//ln37Tbu9sigNmftbwrX8AOea2gHz7XlB5Je9gRJLoo0a8uyUHsmCsjhWLh+kXtw4
         UnH7HxAuy0oZ7I/ggSwU/Qu/N3IY3uaLl0H4H3W/SsWvNm4zBmSDybu3XORN7j2bgmnO
         Avtj8e1Wal6qB/4kNpX49EhJw4RZ2WnlQRaCKuDXvkbTBGH8RFy/N1I4DaVgv4wHUNd9
         tteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270514; x=1755875314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvYymIzLnJigupjUPWkbrLGydSeNzR7fRIJx+eQRmEI=;
        b=AivP3bNM/QQe8gSQptDlVjuVxaT9KCqvtwxgAs17T9O4rmeKkUqp/NjFCYVwbMue74
         QFyKnRNOSv5Wb9WTDFrGPDHBRCZBn7Cs2p+7ktracSO8PI4/GVmGIOnOe5twNkZmzlMp
         fZjg0EP76nlINoxWT8wXXdihgQnbXSDf5/3MkEvm7zhLKnblS+9FMyhrkzVIEuWDkLe/
         1v1MeLAuxfc51cUmq2xHFbxMFqHKBNZOKfJMF57WIHkHaxWh7WRi28+rD0GhJRvYixif
         c+u/2y5trgr3mVA8AWp7El+8LNT1kPCGgh8yfLFFEkGRq4N0ogaqeIHf/0CGqNzyX9wk
         v8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzYK9OwwYYBSwhOb4BsFyTKTXTShVVthRiUcDbGlX0MRsy6SLTicN5aWRM4zr4q1Kv1u9KmgR5vmzqjiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEGfPcK0xzHCPI52IZ9L/EBHxiO7o8i0W8R60gDY2jJkJCnEr
	PDmYyGXJ02nds/3bvQcT8GtyNtgXcDDYAB1c9MZwEPAlxOqFz1yaJmqRh8HafXDIXbo=
X-Gm-Gg: ASbGncsPCO073OPoxA7xmrUCZJFOJB5MNcBnyKKVavt3QvCQ5x24+/8fR4xS03X1s7I
	K16Wop4laPXG4TiLUIruBCo3QkqmDEJNayEUN/Z6hthepaOO1Eaw0Zt6N6ANw9/JnEt20Cq/RNm
	+2sFh7n7VBG0ZCu7sVpso37CtrL4ACk/pWP2QiMQgebAr0HQADfmQI5hOlqBTsScYX4TYWlxWPJ
	ZegmlTokmm/8WOdLh+RHDvPdFAqs6dkL7HMzQHr1MOyTcZUNIIe7YBAye58RxxkuXGeZeYWGljm
	pki0UUYYvs93+HqtoLVaeSgLfBZI4EO2xh3ZCmz8M5ZZhv+alAaBz+MQTirKw4DHlM0uv7LzQtE
	+2N2P1PlUy1TN4dgyJu7Vlocjsg4Nc9vEqrcPzV8=
X-Google-Smtp-Source: AGHT+IGg3ipRv25chD0V0TpD5T6M8dl0rPLRTtfh63vVqHF23z3Qpb+K6dK+mPlUqX6NaiNGb1oPjA==
X-Received: by 2002:a05:6402:2188:b0:618:780f:e89d with SMTP id 4fb4d7f45d1cf-6189199fa41mr6105149a12.3.1755270513688;
        Fri, 15 Aug 2025 08:08:33 -0700 (PDT)
Received: from [100.115.92.205] ([149.62.209.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae5casm1791561a12.36.2025.08.15.08.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:08:33 -0700 (PDT)
Message-ID: <9680221e-e702-41b6-8401-9e940e2f3290@blackwall.org>
Date: Fri, 15 Aug 2025 18:08:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: remove unused argument of
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250814042355.1720755-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250814042355.1720755-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 07:23, Wang Liang wrote:
> Since commit 67b746f94ff3 ("net: bridge: mcast: make sure querier
> port/address updates are consistent"), the argument 'querier' is unused,
> just get rid of it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>   net/bridge/br_multicast.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1377f31b719c..4dc62d01e2d3 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4049,8 +4049,7 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
>   }
>   
>   static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
> -				       struct bridge_mcast_own_query *query,
> -				       struct bridge_mcast_querier *querier)
> +				       struct bridge_mcast_own_query *query)
>   {
>   	spin_lock(&brmctx->br->multicast_lock);
>   	if (br_multicast_ctx_vlan_disabled(brmctx))
> @@ -4069,8 +4068,7 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
>   	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>   							     ip4_own_query.timer);
>   
> -	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query,
> -				   &brmctx->ip4_querier);
> +	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query);
>   }
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> @@ -4079,8 +4077,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
>   	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>   							     ip6_own_query.timer);
>   
> -	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query,
> -				   &brmctx->ip6_querier);
> +	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query);
>   }
>   #endif
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


