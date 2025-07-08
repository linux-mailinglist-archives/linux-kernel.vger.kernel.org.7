Return-Path: <linux-kernel+bounces-721438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A10AFC930
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A61AA2A31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C032D8DC0;
	Tue,  8 Jul 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD0trDaV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01C20B1F4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973062; cv=none; b=W3wANuYmKCTHcyg6bTOVrrYdKzlRjA1m7KSm7IqEAbocU4DswP2UY3t0AGEmOPgVRQfYDBvJhVdpx2dqQEPK3xhQnlSRDxKADJJi0JBTAGKUOlGcbtvSe+IsD2OVvP0X0ebzHd1irpLIQ4g1lWawDTeKR16KLRj+l8SsUtV0vX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973062; c=relaxed/simple;
	bh=I3YlaLMNbIntcC3nHGYxd3PhL0m1vzFc22REJONgU9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O32g5XpU8KjblXDAdfojb8lZjLsRkzdWDducOjQmT8+CPmCM27QYsfD77O6VrVcIVmn2a8bpJrCIUMb0ClSrdfsBIcBF2b1TgLYIuf4Ph58XPrCRwxYtEmWV3y68oNrvtZtPjXbIQlfwXhCT05oYo0loq7XR4O7YjQAkXYtY84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD0trDaV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751973059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCCSM5EGfPIeP6kZ4qXJFewXUNSwRA78to6oWgtBl/o=;
	b=PD0trDaVNcHXt5T4H+TUP1slFWegSnYE7ZMdTtE5zPZdJCv+IDOKxKygiolhRPtLZnB374
	UyGpvpOOSXL/2hUZ17sFF4CLDdHCz2kY89DBNjmxwviHDdnhbgADHT/7GxM7wsFn05pjDJ
	dFeM7ZUjlmpRjtIr4LJZGMcFzgkZxnE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-fRi9SRizM3WfayNVIzDsbw-1; Tue, 08 Jul 2025 07:10:58 -0400
X-MC-Unique: fRi9SRizM3WfayNVIzDsbw-1
X-Mimecast-MFC-AGG-ID: fRi9SRizM3WfayNVIzDsbw_1751973057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453817323afso24732185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973057; x=1752577857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCCSM5EGfPIeP6kZ4qXJFewXUNSwRA78to6oWgtBl/o=;
        b=Hrfh87OCuHQxl69P4StUmcKzPlEQnjYqpMInJ/XuxEzzxK59ghcrs0LOztiswupZjT
         j89hK+5kqQK/fJRYDy2jbZodhRko9VL3wwPrALjWrnYuWXyPjoOZo0Jl2Bf/BMkkAYSp
         mphxgK5MP1FG0wUshrixwpwJXVw1dnZImCYGhOWVnUgsK0QTakX++Uj94NX7cPpX7BFd
         I0Z8rDRYMcfmAohkWcdGfPNVPCR4dTCq/iAX7XHd+1UlFOyo0iKqlDRoBjoEBMJneyGr
         6HB/mpdIC1GrQugj+4CN974WGsoZsnbkiIx0Oup6LJMziyWgopa+ubxQIn80V/WDRq2N
         QAAw==
X-Forwarded-Encrypted: i=1; AJvYcCUbNI1QCJh+AhjTuZdoo7kE6VqtFapWmyS3rEQylcLKzFvjhS/x9Gc1ijLFWUi4mJprRN+hPQ/a93PKnpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxM/tj5izkscodbGNHVWvfCc0Wlownq9F7S8HALc2pq/8oXHJ
	8epp2bBdAILqDDdUS3cn7Jyy1nrkRg/K0erik2jC9o0r+D12+SjPAgdKOYco83K/ASRZu3twb+a
	jyqkLEGKCFkPB7+qmTBZp5r3rAzE0otBf3H/PZvCuGt3iPsKiK0SE8iSKtHFVcdNm6w==
X-Gm-Gg: ASbGnctBpuk5gEm4EJRrku0/ozOFDZe0P0ILtQx4HF1awiAlCXw760c1S3rY/PvyuPs
	oQAXzfPWv6nxbwgJetqY8UuL443byfQ03Ng08ZYWKNlZO2Gvft3lXpL31hCOYSLkb3MUf4+bNu1
	FdgISH2WDYtMlI7FE3nM75uCSxj7jDfHKNuewR+0muDFK5gcNI0ZTM8wBfuJCJxuoYs6uRjUbGR
	AKXTiCS1fOceQQbqnjtLc/3lQkBMLugbP4WIY2sErvmyyYsnqEiyLX6eESC5BTrMCnCAcftvjOv
	5I0MryEWqDGgzz3vvArEhTgaiugeo9/IkEUK0M6+z3UXYGvRiwI77EALWbR7PAcZdlX2Qg==
X-Received: by 2002:a05:600c:1d8d:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-454ccc7ffc5mr42390595e9.10.1751973056827;
        Tue, 08 Jul 2025 04:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaNulokkynI0xWQ9J9Q5uhDXLP6/QZtP79j6yK8Ti/Akkv8f7oR/DstuNuGnFQRRxDD3e+uQ==
X-Received: by 2002:a05:600c:1d8d:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-454ccc7ffc5mr42389995e9.10.1751973056363;
        Tue, 08 Jul 2025 04:10:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3dd1aasm18697345e9.39.2025.07.08.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:10:55 -0700 (PDT)
Message-ID: <617d064e-99e4-491c-8fe7-d74d8174d9fb@redhat.com>
Date: Tue, 8 Jul 2025 13:10:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v14 04/12] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250701114957.2492486-1-lukma@denx.de>
 <20250701114957.2492486-5-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701114957.2492486-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> Changes for v14:
> - Increase the maximal received frame size to 1536 (for VLAN)
> - Use spin_{un}lock_irq{save|restore} when altering dynamic table of the
>   switch and mtip_adjust_link() as both cannot be done when switch IRQ is
>   potentially enabled

Why?

 (the previous one alters entries in switching table
>   the latter one may reset the whole IP block)

What really matters is the scope (process/atomic, bh, hardirq) of the
relevant callers (the functions that do acquire the given locks).


> +/* dynamicms MAC address table learn and migration */
> +static void
> +mtip_atable_dynamicms_learn_migration(struct switch_enet_private *fep,
> +				      int curr_time, unsigned char *mac,
> +				      u8 *rx_port)
> +{
> +	u8 port = MTIP_PORT_FORWARDING_INIT;
> +	struct mtip_port_info *port_info;
> +	u32 rx_mac_lo = 0, rx_mac_hi = 0;
> +	unsigned long flags;
> +	int index;
> +
> +	spin_lock_irqsave(&fep->learn_lock, flags);

If the _irqsave() part is needed (and I don't see why??!) than all the
other `learn_lock` users should also use such variant, unless already in
hardirq scope.

[...]
> +static void mtip_adjust_link(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct phy_device *phy_dev;
> +	int status_change = 0, idx;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fep->hw_lock, flags);

Same here.

/P


