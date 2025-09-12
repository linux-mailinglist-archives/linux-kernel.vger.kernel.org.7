Return-Path: <linux-kernel+bounces-814013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25766B54E35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EBF172CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460319D8A3;
	Fri, 12 Sep 2025 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPTY7oBk"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA552DCF53
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680718; cv=none; b=bpFrSTMabKhMwmkxuU5EISaLm2eJTIM7wW5k156oPi6f/VJ45a8xqxLYfoUe5PCpvoMMaugz1fNDNdr3oZ/c3ZaNLFMBZ7DZ+B8OYxjGLxemPdadHAzeSnwdh8tgkt+HTeuoPzkv9hzwp2uyxS7apodmVLdRgvfaEdkolfwPJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680718; c=relaxed/simple;
	bh=vlZU6mwycI3sYqwmq03oUvOqfxP28cDyni6GsHHu81c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joLM5hbxntxW+rsqYqjswoZI0NW+Bp8b7LY8R7Xvh94UexKd04w4CmuVbuJ8N0gL4iVox1rLKtk/Krz9wTwtw6AOMoX+oP2GcLyuWwZZzsxxP0eHB/RtKyb6pn36X31eduMFG0p1HHHvQ3n9MWwKzM8MAPY6Iqx6kA7qBoj+6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPTY7oBk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45cb5492350so14198685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680715; x=1758285515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAnrydUexcyAjL7DssRTYDuSCNo/x9rFYwKFSV6SRH8=;
        b=NPTY7oBkYzwhiYRuoLICk6C8XKJ/xMxizVKuM/svqMXVkgXyjO5MR3ZNuW8XoCgWbT
         USMHLllzBUzBMt06E6FGD735FNnMC8VggXvU9eyr8ehG/PYfb+gN12GfxrsFgIatp1ic
         hcDZCaQ5wGsuAlkklen+pL0i6LCgW7SCwv+LhyTHNlrhtqPfnHzy6wrRt7pG44dKd2+b
         NWhMXsvAq/NewSr63/mZSj78dXw+BidQqs2iOsFH5WkNXLxJcrf2I/u1Y/f0g4X5rB+A
         RiiGAdcNMtpnQHLjQd08KFObei04gV3dCYf4VeWGCHoUivKTgDttNjhsZEtHK57KlZJ1
         cydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680715; x=1758285515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAnrydUexcyAjL7DssRTYDuSCNo/x9rFYwKFSV6SRH8=;
        b=jwxFtnuxQlNoY/C9VcGkxDr51pB/YFG4LnbXqY94VEjrFS3kRClWEPj+hu2FSGiXmG
         aOGOvc5BqTsk8pYz2ZBwb9ImNsYNlv2PdB6dAWmJ4M8EEKYmjb+k+YpPMxFQ5L4+Xu0c
         qSW+dWjJmc95iwXjvJLMOukGtoxBbsYp3fTE3+D9dswoz6jdwJD2crYruSO55sSk6Pr1
         dhHa3vx3wfXE/J8O5iM/cJB1+UqJemIVGmUvvdQwuadfylbBIqWpOthD7lLTX+TTf/An
         CJhC6/uICX81Z33rMBgx+TgHLYZ3bkNeS1fa196+KDunPEHLaSB4tL/ESRo+J742B3nv
         kE2g==
X-Forwarded-Encrypted: i=1; AJvYcCXtcHtpEAmJii18t9ZmycJUfzerkCUyHlbTKNWoGcjGg74c1BVeRbJSgzMCJm5z1PNv3BrDbvLInhb+3+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAN9o95c6CVenCtrwceBn7hVu7p6EgKuF+oiY4GvpbSvoO7FN8
	zZOKZ3U6gdwDvkvMTSOsr7ISNN9reG6yOOyIT1h74CbwNsozh2WCEVp/
X-Gm-Gg: ASbGncsWYNc7/i3ftwNcnQAFHiEHP0+GRXjXIJt8mA1DB8udaNdd3HXVN2cshIK5UrH
	Uq+TRFhtb6t8XiNFPHwq/vJneb+8SNPILWOYU3boa4MpfLVBR4l07SFPed7HM1JIgh7ZOYAR6Is
	sHF0NysEi7eCIMdqoiNat5zrK93JtKK9LZWwySiDSe2fL4TfrhO8qv3JHjaeDaKh62pCOMUUev5
	kAlKSTuXvvZr3DINuZ02R0mkeiZv1ZWGC/a9m1tXI8vn/7Yl1HtAA6bQ+0cCoMqcP2K5J00s1Zw
	S+usjBWJwpAYOv+N9uOVXXpyLZIDfIinS4eq5cfzOh6ZpgNKp05IrOP4sQ4ZFAsuxybKnWdpBMj
	W9MPRDaKxeLU5Fv9ubTggb6hyAwucGjYozm1rgcGwngbw0imthXDHmas6te4f6HHvrQ==
X-Google-Smtp-Source: AGHT+IFWxDz1WpfOR9wcxxeAHVv8OxZAheEP90QH0SyYPYpZEU+CfRw1UPv58VbrLJGV5nmhjNdmmw==
X-Received: by 2002:a05:600c:1c13:b0:45d:db2a:ce30 with SMTP id 5b1f17b1804b1-45f25971c61mr4461155e9.0.1757680714973;
        Fri, 12 Sep 2025 05:38:34 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:5f19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ee8sm65173895e9.18.2025.09.12.05.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:38:34 -0700 (PDT)
Message-ID: <58ca289c-749f-4540-be15-7376d926d507@gmail.com>
Date: Fri, 12 Sep 2025 13:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] io_uring/zcrx: fix ifq->if_rxq is -1, get
 dma_dev is NULL
To: Feng zhou <zhoufeng.zf@bytedance.com>, axboe@kernel.dk,
 almasrymina@google.com, kuba@kernel.org, dtatulea@nvidia.com
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20250912083930.16704-1-zhoufeng.zf@bytedance.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250912083930.16704-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 09:39, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> ifq->if_rxq has not been assigned, is -1, the correct value is
> in reg.if_rxq.

Good catch. Note that the blamed patch was merged via the net tree
this time around to avoid conflicts, and the io_uring tree doesn't
have it yet. You can repost it adding netdev@vger.kernel.org and
the net maintainers to be merged via the net tree. Otherwise it'll
have to wait until 6.18-rc1 is out

> Fixes: 59b8b32ac8d469958936fcea781c7f58e3d64742 ("io_uring/zcrx: add support for custom DMA devices")
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   io_uring/zcrx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 319eddfd30e0..3639283c87ca 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -600,7 +600,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
>   		goto err;
>   	}
>   
> -	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, ifq->if_rxq);
> +	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
>   	if (!ifq->dev) {
>   		ret = -EOPNOTSUPP;
>   		goto err;

-- 
Pavel Begunkov


