Return-Path: <linux-kernel+bounces-764498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C8EB223D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D11B643E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F82EAB6D;
	Tue, 12 Aug 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxyiJVIS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3E28726F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992568; cv=none; b=mHVyWVueNId6NJeoLVR1tfSHA7a8wNBXrqXZTO4ApLfnF5b3g4cTdZBE/EWTsttFEjojy5hbWGBbTAR0ywb5w4WPElBZjqmtcWzs2Ae+U2G/w0Yo/uElXDlEHlKObF4TWBhur68I/PZnYmCYaKDL1YCTQnpVVdzHrbku0tk9/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992568; c=relaxed/simple;
	bh=HWb3xi23hSoBArVmr8OBU1OUlFYK/4KX8UidlJ/V7tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jde0vUGaHbZ8hfyZx/+rro+AVltBbbKmwtbiFOvifeSsvRADdHSZen6wIR45KCQDt3Vuggs/y1VVXtHhcAqzqBaNCnzWjbixJ8vGZD3cgIExwRyvSjxjIam7r6tQo0MV4lS0TMebBI4CZYeZcolcvOPHAz7Y9WYQmFNFLdB6dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxyiJVIS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754992565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcroCdbDdLAJtbYY5wsUtVmzj5oZXmeQISjQCT4Dk2o=;
	b=DxyiJVISkTztys/xfImxpy075tSj+a25iDPOt1esnn7qhq67CCpPoMKCpK3k/8insacH4c
	3w3DsHEXh4AnCWJP+oZ6Y7FmI1TOT1XaGVYwPZ6yvFHEV4UjoW32C6z1IufhZAKK9Rsgmj
	8u6pesqLm7E/mQsfYIyqBEzfwVkcGhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-zjZQoQ-TMyq7tG1gQSnDmA-1; Tue, 12 Aug 2025 05:56:03 -0400
X-MC-Unique: zjZQoQ-TMyq7tG1gQSnDmA-1
X-Mimecast-MFC-AGG-ID: zjZQoQ-TMyq7tG1gQSnDmA_1754992562
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-458f710f364so34898565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992562; x=1755597362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcroCdbDdLAJtbYY5wsUtVmzj5oZXmeQISjQCT4Dk2o=;
        b=SKcOgl3IJHGikyTj1bMV2JH9D1s0LIuwZ9X+/O+4XYi8UXbczPODeqGs5Ll9pgpskm
         ynCBdwy+qTeRacIpTDNwZP+nbuFIU1cL1T4GikpD0QIifkutQ34uNbPBLxsHob1dcreG
         IFvQyqee23fvRR6jGtPiNDhE74RVcYWBdZRzPfb9aeWz4glNJK1W8ssattFLr8fSmjMd
         MA19zPb7ktdhQ7tj3CAqKNTXLI/cwTQrSzrFQbkQsuVnJ0IfdV57oB4Zu/LKTuJQ5Vn2
         xT9KX3fbLxZTmc8IOo9limOyM4F8IJJgAAQqixNMftaW66FXAjAdgIyR6Af36IJXy53f
         7xhA==
X-Forwarded-Encrypted: i=1; AJvYcCUBc1EChKhHRja28+l9x93znOxc1XD7iOK+b44FjLsJRRdL6AHRium+4M8+Fki6kHwpc0sho+jf9gnLLoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfV0nfHVJ9LKDEQUYRXyGptCWjOQ0ByKzjTAAvqcVsQ6VEm3jz
	lbcEynAdgE+aAH6puVUzj1rU+ii7XHJzfj+PMc5koZXxkwByDQRi+11DoStOu5MPHmGxPJIvEtH
	melt7N/Ph5jeAi0jb/NJgd/qovgkpZBtfURo3Zg/vkC3lS5VIPo0fNXJFwgrWeI+O7Q==
X-Gm-Gg: ASbGncsDj/evhUcXcb8vQnLxY1TqxCNTSTIFZzZoxCKhLQ0N3Kbvp+lPZThBoSGsWyb
	X5XVEBsUEpg8izAAx+8geIoFI1p6YQu1FjJNvD8MvzuM2hL+XUdFNTj6Vyy/pxxkV5CaDCWXW1h
	T+Afj5tkW2t2svcmmL7T3KgzayzE/YMNYNN1tgv/YAyXGJ4STCRE4z6autxemjfB/ZUBwl5f31Y
	KkMQe01fEJ3ZjdagmSZqbU5IRJw3Pg+bb+F3kLdQrnYhzdBqAlgk7fhdNKF1DRRxMLOm0JhYeeF
	sqfaQxO+MmjcoLc18Gd4HMwuCxmPzPAwMISjOIZm8M4=
X-Received: by 2002:a05:600c:b99:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-45a10baf6ecmr26693975e9.14.1754992562220;
        Tue, 12 Aug 2025 02:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENRzAL/VjP3UDkzezzv7O+gqQzDoC3ydmDX+MYqXmh2wK5sVfHxPNITbIdTaggEZYdNUateQ==
X-Received: by 2002:a05:600c:b99:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-45a10baf6ecmr26693745e9.14.1754992561823;
        Tue, 12 Aug 2025 02:56:01 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm43629578f8f.47.2025.08.12.02.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:56:01 -0700 (PDT)
Message-ID: <a45afc9e-f508-4f87-9462-112f3439f110@redhat.com>
Date: Tue, 12 Aug 2025 11:55:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] phy: mscc: Fix timestamping for vsc8584
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
 viro@zeniv.linux.org.uk, atenart@kernel.org, quentin.schulz@bootlin.com,
 olteanv@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 7:46 AM, Horatiu Vultur wrote:
> @@ -1567,6 +1592,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
>  
>  	mutex_init(&vsc8531->phc_lock);
>  	mutex_init(&vsc8531->ts_lock);
> +	skb_queue_head_init(&vsc8531->rx_skbs_list);

The aux work is cancelled by ptp_clock_unregister(), meaning the
`rx_skbs_list` could be left untouched if the unreg happens while the
work is scheduled but not running yet, casing memory leaks.

It's not obvious to me where/how ptp_clock_unregister() is called, as
AFAICS the vsc85xxx phy driver lacks the 'remove' op. In any case I
think you need to explicitly flushing the rx_skbs_list list on removal.

Thanks,

Paolo


