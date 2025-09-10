Return-Path: <linux-kernel+bounces-809711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE4B51102
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A891B267A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C030EF85;
	Wed, 10 Sep 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5dMNMS1"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67043090F7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492424; cv=none; b=Y9qKc9AQgmK1nA2vIFMx6MUDmpWHIuWZbaffc+O88Q/J420ub1BeMb21SZKEmP95oUjGP2/SxT4rjUqnmREUo4iwEn3lyPOogYv08yC51xxmSu4y950kHh2XvgQm/tUfCAdeLZeE+FFyVQoVA4A9UAJG/UUGcQIUNE8UvY0mjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492424; c=relaxed/simple;
	bh=PAz3im+y19NDT+YMJxSBDJens7K9RovOUhC6XNb8bys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chvJGN37hxMvtH/4gaNRmVAXVWB/A6rYvvY3ZtFQsOQk7K5gEuLTBHugZhiXsVQS/1LfUT9t7lFNGXJCPPNBnkZvuw7XY+6uUd8Gy8YGpRFQdtvUznL4FnnrBezPHEh7gS4sxc7KEdrZsSuMiU3O3f9JJu13Vn5dRviw6PiuA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5dMNMS1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b00f6705945so78291066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757492421; x=1758097221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L/ZiHIMyXmxKkiSLCWK4pWAdvwcf6C/7sfjkt+r2Zs=;
        b=E5dMNMS1V1mwGjFvwsOC7Q8EV2jIm4VGtmzMbgcvbUemkURSwAeqRTwVt67gc0P/yr
         PCpDNgjzQVSs8/RC+aK1EW5mqFLIoxlxbYQdbK7CRihE9A950SQBxA2CP3r7q1L5CcBA
         sVLX1gb7jUV8IPjP4UA/OxuLuCLHKLk04K5wYR29AeW+MThz+obX3mhO2bInHhCUMBRl
         JkA4fkMTgaIm3Jwt1tdqv91epv+TcYjH37Ig9eDhUo15P6XW2MR3zdAo3j2gsoCqeuDW
         cZRq5wn1TLtvl4vCSRI2eiXrw9tkhGs6Z79jc0e8DqNTQp2QNBgqI3F4ymSLM+xn+AAX
         E+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492421; x=1758097221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L/ZiHIMyXmxKkiSLCWK4pWAdvwcf6C/7sfjkt+r2Zs=;
        b=AZUYQVKg9KGW1fAaa9kW7zn3SrxmGgs4VURrfpPCdTgF3u9bWbk0PRFoqfS6WRDFse
         UkbfBl4CeWYWNCae1/XtVD18LLU7fWTuxXqLsx3fQbSfnIsyfsSfwv0qUtuQNbjF/JIc
         u89h7Y4sqciUxTw89XYsM39KyhuBZBoHTDuUb+H9HcCuQErB3s6fhtEF22wI3t/RzU4Y
         9CfCoavGSWTWTCsBGotofa83jzWeo00bnYc8Y5eDPWiwogICk5Y0bavPh9BlX0IKt/AE
         TiG60vefIxl0gqJ3zusm8fk3V870Th5hy8OTKybPVcIUPwvcJ6OcmAJ+gRdDF+jWXxsk
         /+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/x6smSgOguFotfnxbSPzwyRlFysNBa5pJQZ8kvAshDBpfS3sYgN1Agh6owkFU8nYM9QCf5d3K8+h8BWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwxAgw/T9nu3YfuuAGxr8kJRnFwjeHfbBBnnPToJdZlHOuYky
	k6aEVzrCyML2Y5do0Lmy/dnNGnqf4rtXjO9uE7iH9W/y1CvuIlI4dJVq
X-Gm-Gg: ASbGncuSq9QrP2LvNtO9OyY6lVzEYYbk+L4u4gsBFRV6pdFYTzBkBuvwNTSWTtRpGr4
	eUoO9WUKoYKEuP30WmOSG/XwTSdKovP5tA+SEXt4m+vnx99179CFRypK+cA02iHCaBfYb7z9IDC
	JnCeNq8faqWEkHOwPR4OF0SWa+fJDv6ntxIkrfHCYZdTUSdwRV+h0G1l5M4mQWp6J3GBTndiEaF
	pkGBwxtVJVJZflx78UHIJOe7OlTsRgcdgIUQCSOPuaZxLTg8R6f/cVB8J7M7Yj/jZGdrZjDQcHB
	D3ffuFMwZFIEiHZDyH35xR3ZnCbu0dSmAFVxs4A14OFQgU9+dIyEzFAWPFVDal9zvyNUMYQNIo2
	96jGlKR1wtnmicnFIw7c5/4nc2A==
X-Google-Smtp-Source: AGHT+IEZ6Y8m9czCHfXyGir/VeA90+bvrcMtK66llF0DDBp7AdUVUAE+7FZ2p8xLZJOlSOvaso7zZw==
X-Received: by 2002:a17:907:9718:b0:afe:b131:1820 with SMTP id a640c23a62f3a-b04b155985emr758644266b.6.1757492420788;
        Wed, 10 Sep 2025 01:20:20 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:6669:35e7:fc93:9b1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ffa91sm122826066b.91.2025.09.10.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:20:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:20:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v16 10/10] net: dsa: tag_mtk: add comments about
 Airoha usage of this TAG
Message-ID: <20250910082017.hjlq3664xvg5qjub@skbuf>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909004343.18790-11-ansuelsmth@gmail.com>
 <20250909004343.18790-11-ansuelsmth@gmail.com>

On Tue, Sep 09, 2025 at 02:43:41AM +0200, Christian Marangi wrote:
> Add comments about difference between Airoha AN8855 and Mediatek tag
> bitmap.
> 
> Airoha AN88555 doesn't support controlling SA learning and Leaky VLAN

Is there an extra 5 in AN88555?

> from tag. Although these bits are not used (and even not defined for
> Leaky VLAN), it's worth to add comments for these difference to prevent
> any kind of regression in the future if ever these bits will be used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  net/dsa/tag_mtk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
> index b670e3c53e91..ac3f956abe39 100644
> --- a/net/dsa/tag_mtk.c
> +++ b/net/dsa/tag_mtk.c
> @@ -18,6 +18,9 @@
>  #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
>  #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
>  #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
> +/* AN8855 doesn't support SA_DIS and Leaky VLAN
> + * control in tag as these bits doesn't exist.
> + */

I think it would be good to present the AN8855 tag using a different
string, so that libpcap knows it shouldn't decode these bits. The code
can be reused for now.

>  #define MTK_HDR_XMIT_SA_DIS		BIT(6)
>  
>  static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
> -- 
> 2.51.0
> 


