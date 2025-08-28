Return-Path: <linux-kernel+bounces-790003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C77B39E24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4473B2420
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EBE310628;
	Thu, 28 Aug 2025 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSw0sKFt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703030F937
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386348; cv=none; b=fBSES1tN/LCe8BT5onot87l18oWkn8afOcBtbOeVhRQzaxf3QssnI7caOJhmjDqKicr5N+2Z4laAB3OkFD26dRCWYX6edzITEhyLKJXJ/+1HWiBzSE6OGD4K3IdVhnKcFukGTQdsUko9IubmDiCGiQBkZ9pUV+j5qGciZ32JIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386348; c=relaxed/simple;
	bh=YV9zhY5PD8lGNt7FDHGMzwZAytTSWukyRNYOhlAOAMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPa5W+RbPIU3wJx+Xvfb6FMSBgU+rPLlDDDv3WBBnP21W3OyMf9k2jzvZmTf2EYPDEflrHgbXBRV14B+yBM2rbgbXRWti50PXcgGKZbkPjgiQY2beEeKZTQKvBc0JMCdTsEgRmf/wszgjtuj6WDklKygCMVadKlOy9+YdzRvr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSw0sKFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756386345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=861GkdmB+NIwMtr2UAi3S0IDUthi2cqLKfhuV8qX7c0=;
	b=DSw0sKFtIhq4PSPm5Bg0m4kHW+sh0Jo47k9FEKFniZDUTMgIx51ah5FJfhRW1v59Rnv75A
	8WZKGnw/6Yqv1ZmhMPTvF6IOjKlJgQzDNjcd7Z8uO2avD4lgqifhWGPTMXTClTXRoBQb/a
	7X9Hg1qPs+fdRChrbNXwt9XiF28DTMk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-pgJtG4DvP_uKGFjbuneLYg-1; Thu, 28 Aug 2025 09:05:41 -0400
X-MC-Unique: pgJtG4DvP_uKGFjbuneLYg-1
X-Mimecast-MFC-AGG-ID: pgJtG4DvP_uKGFjbuneLYg_1756386341
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso5954835e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386341; x=1756991141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=861GkdmB+NIwMtr2UAi3S0IDUthi2cqLKfhuV8qX7c0=;
        b=Kbp6+3xTkemS53huemyEdx5hn2STxtYUBKUNVkul74p/HoSNve33jckVhxYh2DxLn6
         fCCG1ePpyw7rCJvmd/Ys4LG/aHDuGx4d4F/bTc8LjHxW4nkGcCQXymU998CJr0X8PjN8
         ZwxGYvLsUN5Etyzg5To3Bq7hjeGJUscwLug3F1c7hYNCAitW8y0VfcGkg7rT5/+6AaxW
         mUbh8f/4PQjc3L2Mn3s2nwOgxgFOnX+M3R/VbrpvJTG6nrC93+WkyIaMB/WxtY1lcKK+
         4zyl+dk4j5IBhs3JjX7PtULLTmAVX99oWIEHQbBONSNLSw5dxi0zUQLnVLy3wc2fEXXQ
         WMQA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Jule2KPvpAwhpg7bTN0CM1erN0nbk3qf2nhGezCScgaNzrSVXbSmc2B2FBeYyGqYOo+/Oht7VlXq1uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDcbtXO2m+XjNllujBlN0IU/rks2xKJQgFDo5zrjkZCjv8jtc
	w/flbwwlA2iFMNrAouuz6JuDJJVbJt25So9s/IGrDcHEDUSTlEL5MlkycAtOyQfXqavgFLwSL3g
	eWW5BUDU88yUIkiqTlzci1pOAH+2MsMLICgl4Sr3DsI+fnQqYrp1AYN/1YIqECqbhHg==
X-Gm-Gg: ASbGncsXNQ72PYL6haz7QLkEb8XuyeSMCZLPiIBquget/A9wB2/2IU40Au/eLMiExQN
	PJsCq2zqMuUDN89ZIxy+vvb0xdpWTvbikWd7If3Tp3mYlKgha2P5yH/9y++edjNvkgp4BYmOfjC
	zXgNX/bvjfw21NuWpMa1iz7VY3+5maU0I235088New8VgJcIafqTrFFixW3e/1KJLwCmjD1Stt6
	kH3Qwn/jdD/tkFS8ujWkOwINdSrhxqXK6b4gkV3RLsEUg0e9hAwBc1OW/pnWYUEXVbcbUpLeQSM
	BUwOD+gbwP6VmI3YQveyMFMgH7yw0K15EadOwA5641RrzMpREqGDmkEx+qj4cPJI0lMzEZhmhes
	GUzZ/h9XxyhI=
X-Received: by 2002:a05:600c:5493:b0:459:eeaf:d6c7 with SMTP id 5b1f17b1804b1-45b517c2e69mr181132185e9.26.1756386340707;
        Thu, 28 Aug 2025 06:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESD5cfz4wia2THU0g2lr6pD0o/ztQaWOm5Q0ecdtVEYA44uql7myhoP4Io/Nl/yebIzMXMIA==
X-Received: by 2002:a05:600c:5493:b0:459:eeaf:d6c7 with SMTP id 5b1f17b1804b1-45b517c2e69mr181131845e9.26.1756386340299;
        Thu, 28 Aug 2025 06:05:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dcad5sm34253745e9.18.2025.08.28.06.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:05:39 -0700 (PDT)
Message-ID: <28817d7f-986d-458e-9fa5-581566706008@redhat.com>
Date: Thu, 28 Aug 2025 15:05:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/6] net: dsa: lantiq_gswip: support
 model-specific mac_select_pcs()
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <1291bfe0609de9ce3b54d6c17ac13e39eff26144.1756228750.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1291bfe0609de9ce3b54d6c17ac13e39eff26144.1756228750.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 1:05 AM, Daniel Golle wrote:
> Call mac_select_pcs() function if provided in struct gswip_hwinfo.
> The MaxLinear GSW1xx series got one port wired to a SerDes PCS and
> PHY which can do 1000Base-X, 2500Base-X and SGMII. Support for the
> SerDes port will be provided using phylink_pcs, so provide a
> convenient way for mac_select_pcs() to differ based on the hardware
> model.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: no changes

FTR, the above statement is misleading, as you actually addressed the
issue reported by the kbuild bot on v1 :)

/P


