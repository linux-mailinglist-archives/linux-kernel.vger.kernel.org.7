Return-Path: <linux-kernel+bounces-586242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B859A79CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31B17A37B5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EEB24110F;
	Thu,  3 Apr 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZye6mhy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FA18732B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665054; cv=none; b=GmPsO5N+sdKf7UHUgFf3LXqiSs6fHzQk3EZ+2mqoYRNM8yxI1XV88lkYXEeS6LGgLqhKiivpipSzycJnJRUM02wvgteOt6LOijHNmAB/5RZSiiJ1J4brNhE+211k3+/nHDu8Se2kTcA5sqVZoxfH7NqlBBLv4eUgEGJLsHjfz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665054; c=relaxed/simple;
	bh=BmGXNVrTqxXAkUExqcGcIkfGVthayzRf/XdQRf0ErJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKYdqfCmUnwLKKSCKzB3zVlpNgm14XWZANU5aYluyPDOLm+88F2L7CUihaJAVjHdYF8QzOaVxmxU5mSR3ahVzExgtODx0zmIftW7bM9CTwg2Qp2JDch7VxWKKCCl4kkgufF/Eyvi7jap+ra9cu8+sxFBYKIf6pZm2RuoOXaObDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZye6mhy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743665051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4GpbdVAioAsBhxItBe3Gp1I1aqveVV1B4xHRWy2NlY=;
	b=fZye6mhylmx+dpbsv2k4N6OZMzqaOgsvd/qgqR3DLbEhi59sHTr3QISe97Kbsb37eQ8zkz
	LOCrYZC5lSV2SNy/d5dycRKQ6pMfY3l5n4acDkgOSsJDRl5qsmBRUyR3wLZ9wsafMeyTU5
	q6vcxp/WPWcnxpEcj91COc/s4cm6nYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-EFCFb2fEPDulzWYi0ENMLw-1; Thu, 03 Apr 2025 03:24:10 -0400
X-MC-Unique: EFCFb2fEPDulzWYi0ENMLw-1
X-Mimecast-MFC-AGG-ID: EFCFb2fEPDulzWYi0ENMLw_1743665049
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so2998435e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 00:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665049; x=1744269849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4GpbdVAioAsBhxItBe3Gp1I1aqveVV1B4xHRWy2NlY=;
        b=aqdDTlyQh87tzeXeD6Wrcj07BPMmHV0uCT4RLKIrP4ZZzoQV4OhHAHB/zfVAlMZfMX
         JhIHaCJHNiw+HB5iYBHXspOc0R17qtShZBygasSVjp1PlSdMb3PH/FJAf2vF4YeYxslz
         oiQ6QhzP02bwjEltZHiuVjVFvhVJCeqZEKLCGZEH0OLKII81VVur9mplIIBHdLepG1Xh
         HZNINMU8F1rvA1/pe8JrUohfcb6N0QBAWXZXIeLpOtpsXC1RKq0mU98NL49sLMlnCdm0
         C5HR9XsH54/MdKPkbGTC4TirETJFUOhWl7uV2Ti8eFh8BnzBy7wq14Ykxs8+qmIbG0Qs
         P++A==
X-Forwarded-Encrypted: i=1; AJvYcCWmsoyEKHjEq78D0LGMY1q+WyMoZiiNtmoFipkn62aa1VPxGNTG4+oJxgjx6WPhbcI3IfQ8pUjfIzxRHAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nW5a+heb3hEcZLS9Qz8qssh7MbEGCU1pjg1Vsb0xs/XuL/5r
	n/NNjxWkO24VOifhzCLMFKf5gtLXE3Bhre4z+vbMet1X1vmFCCF1ulUYxn7/VmngsrElz+PkoRK
	ippfvwVGPvXYzg2wn35TZu1Ud4reZUrLMXsX2COMgcFImiaeOqRZ/721m7R14Mw==
X-Gm-Gg: ASbGncvKNuYBOHr7D907jumcQ1koKljzDNp3oaRkARDTt6+ThnbtZ5DyEfQSKVthtvU
	xb1xewX3N5v1zBkQmZJNu3TAfrDq7uz24F9uD4OTx/sEOSrUxhQosweUxvNGXtbObKfkvBv454M
	Ral6KdP4d80UYP9TKms6Rn9eJJJdmIOmn4bcqNO+JYVxq1yKTf1hR+8Jr/WXo0aMYRnLSGNTdHY
	ivgNqJUL8/RwInSoarqFVI1a4NaNxgmPAi6UnXkPC5jIrrqj7al2abQJ+HVZ+shcEuXAIpLfJGD
	mkzP5ZXagzMIBlSBvfdF9pqNMaopqqDFEE2DUHHGAtCoMQ==
X-Received: by 2002:a5d:6d8a:0:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39c120dd036mr17302226f8f.20.1743665049159;
        Thu, 03 Apr 2025 00:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLjiN+esCynIJ2+bi2OUprGrFibkCQORORxWzFxwa+nAcvodEQofseNEFH/q+D6t/l5rRnhg==
X-Received: by 2002:a5d:6d8a:0:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39c120dd036mr17302194f8f.20.1743665048726;
        Thu, 03 Apr 2025 00:24:08 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d68esm975281f8f.67.2025.04.03.00.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 00:24:08 -0700 (PDT)
Message-ID: <4b3bea7c-110d-48eb-bcf6-58f4b2cd1999@redhat.com>
Date: Thu, 3 Apr 2025 09:24:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
To: Bui Quang Minh <minhquangbui99@gmail.com>, virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 7:42 AM, Bui Quang Minh wrote:
> When setting up XDP for a running interface, we call napi_disable() on
> the receive queue's napi. In delayed refill_work, it also calls
> napi_disable() on the receive queue's napi. This can leads to deadlock
> when napi_disable() is called on an already disabled napi. This commit
> fixes this by disabling future and cancelling all inflight delayed
> refill works before calling napi_disabled() in virtnet_xdp_set.
> 
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..33406d59efe2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (!prog && !old_prog)
>  		return 0;
>  
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	if (netif_running(dev)) {
> +		disable_delayed_refill(vi);
> +		cancel_delayed_work_sync(&vi->refill);

AFAICS at this point refill_work() could still be running, why don't you
need to call flush_delayed_work()?

@Jason: somewhat related, why virtnet_close() does not use
flush_delayed_work(), too?

Thanks,

Paolo


