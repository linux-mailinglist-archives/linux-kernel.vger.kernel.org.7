Return-Path: <linux-kernel+bounces-720122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC78AFB761
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C2E1AA2E5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B42E2EF4;
	Mon,  7 Jul 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="j1pWe0rB"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A11F09A5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902164; cv=none; b=SVXNtCOH9wDTcEqI+YXGAaaalw5GPtDSWRQmLhdQQmR0kdN52Kj8WUlEWm4QhBcDyAKWbo+vHexrq9jxkTVE+I1f79VEMoX6xgI831b7u13CjIjjKEofXXB1WZapViAzi8dkgrtqreRCSlw72ZjUOFpMdJT9XdTHYQSM+5djZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902164; c=relaxed/simple;
	bh=m8H0ULdbJ8jHkYqq+C6UljYy5F/UGJU2zP+ye3MpbBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X81jxsB9dnc/TL1UdawDy8LVpqQkL78PEv54Nro4LUel4a3QTIPqorycKBDOjnTjdDFzaksBdmp6iCSpCz3SPQAijjoyaPJcS1ViAbzUiZoYqegep9ft11hhMBwha3Jiv4pyDRqj2Y3z8DlnjkeKJLCUVzcWO8VY+e7FILEOSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=j1pWe0rB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450828af36aso966155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751902159; x=1752506959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EMFHU+dA97rkmxgkbzmBDm7ndl2Ec9MUhuSaGtPZEAY=;
        b=j1pWe0rB2Ls62jHLW4290O2U8bPSJ5tZFV3W6nV+LsTNP7i2ytUKfLB32QVw2oKpLP
         9dsZ0cNKDHXl+d3U1tVSaiXTkE0H67cOzfNS95LqI3ytR1RgDBPjlEdQ/yT7AJrqiSRt
         2fSWo7m1r+wNY56QZMK1ULuzVmmVupE6JKwJGn59jZ4bRRhz9BHR6oThiCGo1uLaaUrH
         pZbW9pGH/hzGdswZ5Eo8Xw2+0RjaORE4dh7bEW2ELss6J35+m9Zt9jjtdWafpHmgmWNn
         I7y4JEYSLEUW2DsoQPh3cu1n+liH5BhM9jTbXMP8M7uOzr7xvVEFyQOtzSzcFD0QYlGb
         5vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902159; x=1752506959;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMFHU+dA97rkmxgkbzmBDm7ndl2Ec9MUhuSaGtPZEAY=;
        b=hW5/tU+YZKoy6cxYEujz3uytTPrRQbwHtamR5DwSfDeVLrYPLvBpnEKP2cYKhYx8Ak
         /6knOA+QnT+qp2kn9yTmMmYGdVTRTlqaJl4J+ivlAA2l8+krNB0DYs9EEmv/eWtWIqA0
         45Bz42gMRuhlPLWMcTi1RKDPFwA57WepjSqqBAk7zOx0ZWtXh6wcnDl3ewuj12Iz4IVN
         HxKpC5GVMBXdIjnYbCoJhxblz0QoLyAA10Jy+EMo9H6qNXox5AqMEKAwVvskZIQ2f7oL
         CxzeBwgxFWIZpNgOJ1j8UZJJtX08OuSg5jTspnmm63kAyIxANgqfu/7S4vFSSaO463vG
         X6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Gazr86wwPx80q7qBO8ABBAmpl2X4swfabJAfz3ik5cxyWJ5dExf7XBby6biqVBmySFpQn6TXODy5JYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJu8YDWllr6eIFRQDgVOWw4KKbsp8Y2QRw4Ih/amH+3izjJLn
	0MFc/xgEHwCgzK4XtE3kodh119M2DevkmHmGAz3ssm5FEkv/R0fk6diIfLVcadlq6CQ=
X-Gm-Gg: ASbGnctcWJdzEadTiMyPazU2/rWp+ecSq+dqWashd95MMx80yKqQflcRIYBtOWMFKCO
	HwwEHX5KZkXxjmjMCV1Q1sPt1Lg/fmm/W0afUgxSzymrtBp1P+IgCUfpdnjivLd9F6ijje9o8xp
	4sCDRGUBey9ubn+E4KbuxcO/l48BO+LI0Q6yr+teBrHkXN8bwx7yAbu6XYNhcSvH1OUjFRcRKEP
	FdukHvvuO/AxY8xtCljir3rAILL3x9cLj8l0te4gLKGEQVM32/qZbgooRh2RV5NjixFwT+LPlH+
	UpziCCrQMOAmhckBoy3xZTTjeM0aZ0n8AYRjoUT13pHqMFQIMS943xKxyb3b3QH8ck8BS6lVBU3
	1DQzA5CRBccDOEjU2w6jsA4Gh4+N0zRjgDCtYV+c=
X-Google-Smtp-Source: AGHT+IGKebV8E4EnA7t55PON6APQeMax4Qk+HjyzcFLok9rczjr1cjwmPmWX20487WziMMXLlS4ZLA==
X-Received: by 2002:a05:600c:64ce:b0:453:8ab4:1b50 with SMTP id 5b1f17b1804b1-454b3096aefmr39191445e9.3.1751902159060;
        Mon, 07 Jul 2025 08:29:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bfd2:635a:f707:acde? ([2a01:e0a:b41:c160:bfd2:635a:f707:acde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99693fesm145125845e9.7.2025.07.07.08.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 08:29:18 -0700 (PDT)
Message-ID: <00783d46-96a4-4653-a09f-4bed48fb2cee@6wind.com>
Date: Mon, 7 Jul 2025 17:29:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v5] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250707094307.223975-1-g.goller@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250707094307.223975-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 07/07/2025 à 11:43, Gabriel Goller a écrit :
> It is currently impossible to enable ipv6 forwarding on a per-interface
> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
> enable it on all interfaces and disable it on the other interfaces using
> a netfilter rule. This is especially cumbersome if you have lots of
> interface and only want to enable forwarding on a few. According to the
> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
> for all interfaces, while the interface-specific
> `net.ipv6.conf.<interface>.forwarding` configures the interface
> Host/Router configuration.
> 
> Introduce a new sysctl flag `force_forwarding`, which can be set on every
> interface. The ip6_forwarding function will then check if the global
> forwarding flag OR the force_forwarding flag is active and forward the
> packet.
> 
> To preserver backwards-compatibility reset the flag (on all interfaces)
> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
> 
> Add a short selftest that checks if a packet gets forwarded with and
> without `force_forwarding`.
> 
> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

