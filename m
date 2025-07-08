Return-Path: <linux-kernel+bounces-721547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB4AFCAAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7624316169E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59C2DC35A;
	Tue,  8 Jul 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONMI6l5b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8742DC34E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978575; cv=none; b=c4HYBKVcUr6922sV9CvFRrtWP9/NmnUDMI6D11111tl6gGn6lDQjkp9mjgmRWjUm+awbhg/DqaMi/AXhBmHLxGweuoRPnhZzMKgczpHOU719VTebxifyCjg9Y/x9ZOHWn1JJrKkTsMrsXUIfTwpXV0KF1CQXu6R4bc1T0LsUq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978575; c=relaxed/simple;
	bh=8g4vn3ZDUODtyoPkY/Svu/49CBMLH/221Qgo/PiP00c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEjGSy1i80gFCaNtS2Cpt1viinQM7lTYmFkmv91s3GLY4gKB810EhzPBjpGojXhmXP5KJVxNDCQqMwUpZqBYBRSGPTpnZJk5f4R7a0oDuqgDMJ63GjFOpCU/6V17BjQBHO3uolXb3jI3qlazlsrGeGSSiorPW5J0CEcmvMiImvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONMI6l5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751978572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWLsRndpeoGO2uIFdq/dfQXQifzyLaZJlU9awKNwcpM=;
	b=ONMI6l5bNlGvGd+JSlfZxqELZjM3J0BtEXk8pWhMrklGTE3NEQQR//5BoGj5RFmLDxFFb6
	Z4ICmBluiJTKcOq1s/o5g2FIhPaNE5+RRVvrqwoE0G2bBc7sJt5nM5CyoLAhruRaf1hpW3
	Ls7VT4QP/dfjHSW+NuJD6PcD2MBLEWg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Bju0oOMIPXCN0azVo1xGPw-1; Tue, 08 Jul 2025 08:42:51 -0400
X-MC-Unique: Bju0oOMIPXCN0azVo1xGPw-1
X-Mimecast-MFC-AGG-ID: Bju0oOMIPXCN0azVo1xGPw_1751978570
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso25154075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978570; x=1752583370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWLsRndpeoGO2uIFdq/dfQXQifzyLaZJlU9awKNwcpM=;
        b=ImcmPpG6TRJ08g31wqwki0ec1jG/Rurxslpn/u2XsDRdEahKPYj1nKoFWu9/Xb/SSe
         byELfFSmMDFtD+jmciJdLawmW9UcrniNy5l7IJdlPRNGienjYlrQe2YZ6uqqcNo/GWAW
         kOFg2servJAq0t9+2l6u2heeptuvsPxg5dbjmaWRgqcW1AT+AQ07FIbEGESCaZYrFIhm
         ZYUl9RmOrRobnr9cSK95mieZSwRAx1QFepEcI0xaSAdx3bk5DvdzI0Q5epS0aEBGHiiN
         aOdcWvTRhjNwOqpXovJxqCkiYqKiN9EEwOPZM7kDogQ+7n15fReZR1nIlaW+IouMrW7k
         /3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPjRLf68UX98u9WgoLhejHTm2BJpUhvDKrRpnp3qUgPkzP/fUG9Sd7RWP67CERpcezNcoN+wen95Tv2h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2+oW8/7tME0XsJljKZgXU3ggvhuWD5J7IJYgLeiRaaFkOytu
	IpSB+WjKnIWJt1YH3H1khbaIAZsCArZHCtfnFniBpoJWpQiqCnGcmo4RNAGNZAOnGfVsBKr4xvl
	il8SStoL1CS7Z7VUvz5ZVls+tOCnvUJ69T4yonbkmu30xAUQb1lyDVrCa3JWjHpfMNQ==
X-Gm-Gg: ASbGnctzWh/SZoOQRIqnQn2CihKCFhZ6uUTqLCngd63ZMopRDHn1OnJb3GEw0w7aBXL
	OPGmM7vsDsWXlSu3DTZxLiyYXO4DbXQRDHXyA1DF7Z+7w9WM7MLFoeG/DP01EqYAmu8GZ7dw05J
	ob/PnfH+R3QD8hPkbseyaK1Or9W45ciRN1/kB4a68OjxbKRxMP48ktFK0aqU80ojZR3YtlmbeRT
	xq7vAjXatdFWYOlEXZXqQzTcTre4WtwwJJ+ZYbW2XuemkvlSqFsjZm/QcbKvZOcDU1LatUZmuji
	2ClHn2FQoYCE1ZToKOuDqjk=
X-Received: by 2002:a5d:6f1a:0:b0:3a6:d255:7eda with SMTP id ffacd0b85a97d-3b497038ed2mr13222648f8f.28.1751978570248;
        Tue, 08 Jul 2025 05:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvbTf84Wimwr7/D4of1QkgL7fnFOTTpydKkM49A2XO5oioaD4ieFQEj8+6K2A2VYzlnNverw==
X-Received: by 2002:a5d:6f1a:0:b0:3a6:d255:7eda with SMTP id ffacd0b85a97d-3b497038ed2mr13222622f8f.28.1751978569807;
        Tue, 08 Jul 2025 05:42:49 -0700 (PDT)
Received: from [192.168.1.43] ([212.105.153.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97732sm13195462f8f.59.2025.07.08.05.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:42:49 -0700 (PDT)
Message-ID: <ad66abc3-b90e-4eed-9e3d-f242c909e633@redhat.com>
Date: Tue, 8 Jul 2025 14:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ag71xx: Add missing check after DMA map
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702075048.40677-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702075048.40677-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 9:50 AM, Thomas Fourier wrote:
@@ -1275,7 +1281,7 @@ static int ag71xx_ring_rx_refill(struct ag71xx *ag)
>  
>  		if (!ring->buf[i].rx.rx_buf &&
>  		    !ag71xx_fill_rx_buf(ag, &ring->buf[i], offset,
> -					napi_alloc_frag))
> +					napi_alloc_frag, skb_free_frag))

I guess that if we merge this patch in the current form, we are going to
receive soon some automated-tool-generated patch removing the 'free'
argument.

It's probably better to avoid such argument from the start.

Thanks,

Paolo


