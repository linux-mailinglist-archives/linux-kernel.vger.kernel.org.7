Return-Path: <linux-kernel+bounces-818893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A70B597B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8757116522A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92ED315D37;
	Tue, 16 Sep 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBGcJ5WX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BD2EA17F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029566; cv=none; b=lW9/sYCl2hfCa1GwzsO2YGV2TdxtJ+1YL++EkBpGr+8QMYlpx+EUDOps0V/tmm7FBbUEvgbo+0+mM6e4vCuezHX7NKmKNOrpD3y3y8jMTgTNd2TUKbxjbe3INs3c2p1LJ2VgX+awFM43jxoz8oa/DrpE296qO8xE5eXPxQ31HD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029566; c=relaxed/simple;
	bh=CX021c9/rKCMHX8AKyztYOJLxciwY9Y8N/sJjPa12qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rh0PzP7L+wemOEkkP6OrVBXeHMvkVJon1v1bFZ2ydnWKHVTkB6vYu983erEwz4Ch3pi/PJHLz2rJcHNu26yV8LLPR3EdUSbJd4h/teMehD6+YBGghid/KcSRQVaKF7QhI8OgwDbj+g8hlm52snzmqTt0+4IlB4VkATsKtC7vYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBGcJ5WX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758029563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2H4EDcUVkF17k/vdLszvwCOsmnxB4WVC8IE9QIOrYc=;
	b=KBGcJ5WX13HuHxUfSSi4bg97Ip8eOMhORr0MFmqK3EAkF4WVoy9a7QG0XxKKPzlFUYovRq
	RPGVTCAfZLHamPEvCSrpADW2OFjYrRrfnnTFNoFCVKz6fnNS0fMSXH3Sn4eJhRrkOvy35p
	CvAEaQKnUfxi9ymHBbDX4j1UwttU0yk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-qBQje9boPryyLF4kFRcO3w-1; Tue, 16 Sep 2025 09:32:40 -0400
X-MC-Unique: qBQje9boPryyLF4kFRcO3w-1
X-Mimecast-MFC-AGG-ID: qBQje9boPryyLF4kFRcO3w_1758029559
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45df609b181so46039705e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029559; x=1758634359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2H4EDcUVkF17k/vdLszvwCOsmnxB4WVC8IE9QIOrYc=;
        b=wxLC9iJLGYWmpljetlxy2XBa0kGKM+hAZArzZb0++DMOZo8ju06wOXN5A/ug/2ImHK
         vsVpGZUygOc/RrmL0sstH63cU3fVJxQtHjPPbrhqQVRQGXoplM/mRnZ3IuhTAkZ6RvDq
         MX9Qg4/zrlZxvW7X3FtkJq+ry1nwt2nsOcDjl59juZDMyfBjSrHB3kD5p9QEYjE8vZ1o
         Af5Ng72XYOboIhVtmJgtiNnWdWPZQ5pFRR0ZgTTk317DS1DiC5t10neexEO/AA7/ICYD
         r+CVF/0ouzHG8wwgRCcCG2bAp6z6ZlavBYgFE7JJc3+j5QDSUV8h63mValuUmgbbjMKn
         s3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXZtRvv/UP+zgsVY2WVQphjegaz/jsjgpNkPu+/syebj9K1Uo11p/Tzjsvzoac2IPzgMNHR9EuFQMa9eBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqD7QC9M/2OM1fdNiLdKQ41sfJS9bA/smZH5BUlgGgt0pCu/0
	Hn1c8qrrTNeLo2dW0LAaxXqtkPLl2ykCynCFvCHVOFa6nGJlN52o/QWbwLWKX0KIUkoXwDNQkfO
	i8rmrlanNNc8/nD3xDmwxCdQ1D6p6a1tGmvZRnBXUlZAxe0YRGibAZI1USQM3+6I2TA==
X-Gm-Gg: ASbGncvwBnC/+KvHdR5P3NanwKzC5PFNJzW67nhgIRC2LqzU1L05C54Whu5VyxIao9D
	gy9GAxIq8jBAUbj8DA+qcMUmgPW6qMMJNkZQZzM+A/7EusOi8N0Q/zvo+3c56w6031UgIpePF78
	+q+sOMOKnhjVvESA1exOYL9W2o5p3XhVeM4adB5ixWmF9E6LYcxDsCMRUkhFOke2pUkqaeOCqyW
	78sHe3wFzXmAdEUIBexeoCmMhokSv9kLFgZBsRfHwAi1WsEeFDCNxzOzgdAM3gSI+LQYX2vmrHT
	gc4ZRMS7b7G/8Z4piAMeeX4PbdEt9co0j1tqh0DB6FwiUnpVcTu4Ev5nOr6hvQ6Tp7GgQ1ni8IO
	qhOtJjMcesUeO
X-Received: by 2002:a05:600c:190c:b0:45d:d5cb:8dee with SMTP id 5b1f17b1804b1-45f29261e30mr112032885e9.33.1758029559146;
        Tue, 16 Sep 2025 06:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzTxl253dNkLkka+f2ooOsbl0VNJgaq4utm5LVxBMy7i49xYcMwKe5bQMDEMEUAfRBx18+hA==
X-Received: by 2002:a05:600c:190c:b0:45d:d5cb:8dee with SMTP id 5b1f17b1804b1-45f29261e30mr112032495e9.33.1758029558697;
        Tue, 16 Sep 2025 06:32:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d7595sm218745635e9.24.2025.09.16.06.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:32:38 -0700 (PDT)
Message-ID: <64e2cf5f-b2e5-43b9-aea9-a937f6ec1508@redhat.com>
Date: Tue, 16 Sep 2025 15:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] phy: mscc: Fix PTP for vsc8574 and VSC8572
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
 vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, rosenp@gmail.com,
 rmk+kernel@armlinux.org.uk, christophe.jaillet@wanadoo.fr,
 steen.hegelund@microchip.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915080112.3531170-1-horatiu.vultur@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250915080112.3531170-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 10:01 AM, Horatiu Vultur wrote:
> When trying to enable PTP on vsc8574 and vsc8572 it is not working even
> if the function vsc8584_ptp_init it says that it has support for PHY
> timestamping. It is not working because there is no PTP device.
> So, to fix this make sure to create a PTP device also for this PHYs as
> they have the same PTP IP as the other vsc PHYs.

[...]

> diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> index ef0ef1570d392..89b5cd96e8720 100644
> --- a/drivers/net/phy/mscc/mscc_main.c
> +++ b/drivers/net/phy/mscc/mscc_main.c
> @@ -2259,6 +2259,7 @@ static int vsc8574_probe(struct phy_device *phydev)
>  	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
>  	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
>  	   VSC8531_DUPLEX_COLLISION};
> +	int ret;
>  
>  	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
>  	if (!vsc8531)

vsc8574_probe() is also used by 8504 and 8552, is the side effect intended?

/P


