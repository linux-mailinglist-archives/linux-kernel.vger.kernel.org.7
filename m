Return-Path: <linux-kernel+bounces-789407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384BBB39510
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BCF163DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142529CB32;
	Thu, 28 Aug 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE9zGshK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508B30CDA9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365867; cv=none; b=Jtqf5kJ15f6wCeNm+vyVFIB6JHkNtLRyHRmjv1ulZ02NEZy72SwXOm1oKcbrVA9DJykz9L30FHWmSVJ5LUbevfGTrSEyZmlxT3MXF0nQJkScuz8o7NIRIvNSaS0FEXrVcgSgRKBjWQZg1tIbqLw4dPRowaXSVz1JpOdr6l9BFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365867; c=relaxed/simple;
	bh=J7uUeWCM9kIi1DO4ms4r5uJMDYBgE3A3eXLTFPHBEBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyJ8FGqib8iz+96pEEICACC7g1zFSO3OGahutzYtFIKoLP4kZbCJdjrRiDYLyA12pl7x0WFfhmllNnNI4IQUWvWWNQqgzkUdYShB0ADJia/vEMGbEZXYVvL5OzIe11ZpuCGYk0kwUXGLvbUX63V78kUF3SEEpz7klM4u0JatGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AE9zGshK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756365864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KIR1zw390cgYTtX2NX433kPJFGlwKkihK2GJLW5eSFY=;
	b=AE9zGshK4ENA0l3kvNMW/OwY2wnvaKbkvZoWkf+lzjZSzjCdJjcmZ1hABCPz5lSs1wJ9es
	gKm0mku0z/w3LhqIv20Si1w5n4L5sYTeeQWyIJRvaBWXxwG+RCH/LCMyTbC+8z98IIR9VA
	Y2vFP4HH4xQeElWmVCLY220oA1tvYlY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-on5NYWlcPj2zcPFdzdQpkg-1; Thu, 28 Aug 2025 03:24:21 -0400
X-MC-Unique: on5NYWlcPj2zcPFdzdQpkg-1
X-Mimecast-MFC-AGG-ID: on5NYWlcPj2zcPFdzdQpkg_1756365861
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f73235c84dso159089985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756365861; x=1756970661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIR1zw390cgYTtX2NX433kPJFGlwKkihK2GJLW5eSFY=;
        b=XttUkesyEDschmA+rgj5Dx9lzyJKk4cjKV9Vqsih+TNVyArAARZXwMpdQ/HCW0lqoa
         guHpQugvY5z+vn+UvElVtHGkCsnDEyqGwIUMAIXwHkR9neEwV929l+Yhyd8G7WrBuUWv
         Zsm941XrAodZ2yewgcp443ZmiX2vXlgJrL0DMdLaXsffVkpEstx/LunYdmJD4KzDR+94
         DZH9et63zjjlOQogD8NZKQczXXa3qWwktc9m9R3aoYQLLN5o70FfQiSZadV61qTLxbkv
         0FxtykP99ZNc272pbw5y5NTiKcZbZSSIZKr7mAtNPtfWJU22O5w4TdvT4rAIw8DdI+Xi
         W8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5VHai3erK/WoPSxfSpOMwy3yIfxHHrXSthJgtlbXtKtgxR+xk+Qvbzob2+PD9xZTS02vYFsqNLrqz02I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3FBMe6hpM8oRQJ/0uD2CmVV6H0z85cFF+q8v7zOPY+gaGC0zQ
	gS2/4pIwRBarQ40Q/69Xtq9Gz6HZ5ivptv1hF/dKLKkNDdBdOj7A4ZhV6RMrIqBAFK9NeO2OqIz
	DJcLmo3ml/O/fnD/e6hWxSUEuQdKJES7Dp47HFHoJ5iXw3JrQm+zrWJi7fOjbQ4HPSw==
X-Gm-Gg: ASbGncs9sqzOHgGUwc1qMUhzWGsAjkxFMSs9r/IIgoZjEPWrA6r+2b0KIXFRSHfiYWo
	h4wIDpIn4yo0ZS1/7IfoVMIwvwjpAXMnOSLStm5eDuPMuNmK468wmx8s32C8+5+qEFs6snKJWTC
	PLzdvW6I2tgY/69SKVgodCY7GfXFjrpEet1d4YHLylqTOm2yR/HfkuKbbA2szEGsabd7cLMQ1+/
	MBx1BvxHj4/8PGNy9NUhgps4AkuekIo+tg17Dok9G0qzDi8W2Qc/9hu8lUfEMrZRrjQyWvw0zbX
	361c81rsoZ/d/YH5DeWW5FVrIYzZbzkNLSM+lz5IplX/fqPfisSw0vO6+TAxuTzSYh4ZNCygr4l
	OCoxtOSoJgco=
X-Received: by 2002:a05:620a:319c:b0:7e8:7eee:7d66 with SMTP id af79cd13be357-7ea1106939bmr2934884385a.40.1756365860734;
        Thu, 28 Aug 2025 00:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp1cXuDbg+76UtB0I0QKS7x0PTyew3GjzbR0Qln5uscmVCmSfUeQdLjlZYLQmSpwwnsixrew==
X-Received: by 2002:a05:620a:319c:b0:7e8:7eee:7d66 with SMTP id af79cd13be357-7ea1106939bmr2934883385a.40.1756365860375;
        Thu, 28 Aug 2025 00:24:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b306eb3110sm335911cf.7.2025.08.28.00.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 00:24:19 -0700 (PDT)
Message-ID: <646c6431-274f-4923-ab9d-bf0116645745@redhat.com>
Date: Thu, 28 Aug 2025 09:24:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] microchip: lan865x: add ndo_eth_ioctl handler to
 enable PHY ioctl support
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822085014.28281-1-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250822085014.28281-1-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 10:50 AM, Parthiban Veerasooran wrote:
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index 84c41f193561..7f586f9558ff 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -320,12 +320,22 @@ static int lan865x_net_open(struct net_device *netdev)
>  	return 0;
>  }
>  
> +static int lan865x_eth_ioctl(struct net_device *netdev, struct ifreq *rq,
> +			     int cmd)
> +{
> +	if (!netif_running(netdev))
> +		return -EINVAL;
> +
> +	return phy_mii_ioctl(netdev->phydev, rq, cmd);
> +}
> +
>  static const struct net_device_ops lan865x_netdev_ops = {
>  	.ndo_open		= lan865x_net_open,
>  	.ndo_stop		= lan865x_net_close,
>  	.ndo_start_xmit		= lan865x_send_packet,
>  	.ndo_set_rx_mode	= lan865x_set_multicast_list,
>  	.ndo_set_mac_address	= lan865x_set_mac_address,
> +	.ndo_eth_ioctl          = lan865x_eth_ioctl,

It looks like you could use directly phy_do_ioctl_running() and avoid
some code duplication.

/P


