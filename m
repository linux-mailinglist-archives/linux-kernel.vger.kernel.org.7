Return-Path: <linux-kernel+bounces-820354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA9B7C86E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465E83B8171
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C322F9D94;
	Wed, 17 Sep 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsxf45wp"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93752EC08E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101749; cv=none; b=aOSti54xVv70se4js2HqqCGe9RLMxSR9QA7pJNGyykfOfR+KGuhX4VInoBfub4w8x4Zw4jI2b+QZrP73a5/LNBoFfnTppNTAIEn1IhUsbMucbekVIRWVQBYs/isM8qGiI1Q9HxEBM23G4kYdfDX35/ctt8a47UtJUKKiJTaa++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101749; c=relaxed/simple;
	bh=HuRldwBM6nzFFA0zmpZrhXm4aliMRw2d/I0OOP4HU5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coUHBzsNNvUk0HoVtZFQTZJiHmQHNYHi2Cfu/lAR47CmfV8XJWEb9n9TzPXcxOg9Yopq6Muokkml+uiJL8eG7mf6vhdUiUhyLPTKt8nxYBh964vVNNLDfqS6E7ofIQU8xep4+oHIzLI3h4w/ZJEZEB9pr7WFEC9FjbN2W6eVRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hsxf45wp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecdd162cd1so128812f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758101746; x=1758706546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kOKVRqVF/Jape5mVrAokP6dL8C+/K6JTCB2Gbup70E=;
        b=Hsxf45wpjRYhq/81Wznx03QSJgInsoRpA2xMDca/BB2FYbxN8/lxvmGC4byySccjvX
         tzCU3vPJM0Gi4/vekBKRLE6TFnCDXVuiRc5S39I9YZvcQfbHopb3VHYE6FzTQRmeV3XS
         ygl7XI1F8vnYtHO05JwNfkve6ZdK9Ij3qimCRODmIpqPXiIp/SipSmPrSJalO3R+2VOb
         chdsoWvRQ3d/pW5ubQoaMzj1d6AboKP/VhUIWv865WPdg3gprBAjM8ey8PyjsOyDADJ1
         RZ9Lc15tVPOyZ6R63uE8UfaTWzQu4cCJarPkBvnvdLo9gUhlce19FRGS+2vHLgwXr5GW
         hJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101746; x=1758706546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kOKVRqVF/Jape5mVrAokP6dL8C+/K6JTCB2Gbup70E=;
        b=bOqqB6ECGuCZOFBAMWrWQNIow7mgs0YefHM5d3IvsBYpizNDJXh4/J6ov5MFVta6Dj
         dwuoJ6U0+D5uth7v9BjEP0k6i5Tr5XYXBoJZrEMm081gm2Gtuftiy4CVVo4ng0c0Wso9
         6iWPZ7jU/GSlgAfpwfal+GQYNRfj3QoGIkyjA/CgGAFcERUK5N0ggivuqIyrNOQjTgAa
         kv4pHxuz7Lv4QGGPLu/KWNdyc+0mzIuv1IIM8UWD/A9CpIeDU50Dydrhk4YWYOBkCD4m
         e+L7MEZHsSsMVEYSQt/1+OgtMqQebhaDAtSHXHard2IFm1bStLEZxqq36ubuVBMAJYf+
         2Tfw==
X-Forwarded-Encrypted: i=1; AJvYcCWR1kPLUKWvGHJr/1k3Jsh1TFZRjOmV0ULmDy1NJBxs6BSU6Pn3hEYzHOa7BWGn6kNtsgCPF+szbvmo+O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Tn+u9CCH6vEYgHrE/b2DObZUmuSbuiZO9yS0yZXUo8UCq8IK
	3Oq/fOdQfvVbBCqBCqq0uzUZFWVlIOeUtk7HKZMAqvxzY4D5p2AEF3I5
X-Gm-Gg: ASbGncvHeiXPnddW62CCCqe7mAuehOgb70RlY8ANSEWVFyHXp7fIuU1uw3a9aVk9CKW
	GwwTx4kXxX+xM+4SGCIxuzqeXWkdTF+fLSm5Pyd0fCUlq8/bUFTF07kLMVuDPQD/FeqKrsV6PcC
	0X6z7EAps+3mXAzSU1vKinZ+1vpnObXnoturDtKmYaexezkP9MKU36a9hNV1LfvgCrW+2yFwAxo
	SVbUgeRA0yHhS4BH/ikS6iZy92jFXMj2qEJR6FuxbKa/kpf3/QGa6Oznbk/z9LrAn3VrTHhAMJ9
	SJCmh01NdoNIOrrRGEst61Bw/Tqhata+JsXJlD7+GURe25O4cW7nsg3KBY3YOHGVWFVG9G8VeGh
	3TozGP9hXBshOcsk=
X-Google-Smtp-Source: AGHT+IEKahjLn3hsskZUX8TpZV7OWQwmwyggAkHLtboEKsU7Lmkmo3zfNysZqXWAk/VpjouU5E9mvw==
X-Received: by 2002:a05:600c:3b27:b0:45c:b565:11f4 with SMTP id 5b1f17b1804b1-462024536a4mr7576795e9.1.1758101745594;
        Wed, 17 Sep 2025 02:35:45 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461394f6081sm29238745e9.20.2025.09.17.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:35:44 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:35:41 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 4/8] net: dsa: tag_mtk: add Airoha variant
 usage of this TAG
Message-ID: <20250917093541.laeswsgzunu3avzp@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>

On Mon, Sep 15, 2025 at 12:45:40PM +0200, Christian Marangi wrote:
> Add variant of the MTK TAG for Airoha Switch and comments about difference
> between Airoha AN8855 and Mediatek tag bitmap.
> 
> Airoha AN8855 doesn't support controlling SA learning and Leaky VLAN
> from tag. Although these bits are not used (and even not defined for
> Leaky VLAN), it's worth to add comments for these difference to prevent
> any kind of regression in the future if ever these bits will be used.
> 
> Rework the makefile, config and tag driver to better report to
> external tool (like libpcap) the usage of this variant with a dedicated
> "Airoha" name.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/net/dsa.h |  2 ++
>  net/dsa/Kconfig   | 11 +++++++++++
>  net/dsa/Makefile  |  2 +-
>  net/dsa/tag_mtk.c | 36 +++++++++++++++++++++++++++++++++---
>  4 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index d73ea0880066..bf03493e64ab 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -55,6 +55,7 @@ struct tc_action;
>  #define DSA_TAG_PROTO_LAN937X_VALUE		27
>  #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
>  #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
> +#define DSA_TAG_PROTO_AIROHA_VALUE		30
>  
>  enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
> @@ -69,6 +70,7 @@ enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_KSZ9893		= DSA_TAG_PROTO_KSZ9893_VALUE,
>  	DSA_TAG_PROTO_LAN9303		= DSA_TAG_PROTO_LAN9303_VALUE,
>  	DSA_TAG_PROTO_MTK		= DSA_TAG_PROTO_MTK_VALUE,
> +	DSA_TAG_PROTO_AIROHA		= DSA_TAG_PROTO_AIROHA_VALUE,
>  	DSA_TAG_PROTO_QCA		= DSA_TAG_PROTO_QCA_VALUE,
>  	DSA_TAG_PROTO_TRAILER		= DSA_TAG_PROTO_TRAILER_VALUE,
>  	DSA_TAG_PROTO_8021Q		= DSA_TAG_PROTO_8021Q_VALUE,
> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 869cbe57162f..7d63ecda25c8 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -98,12 +98,23 @@ config NET_DSA_TAG_EDSA
>  	  Say Y or M if you want to enable support for tagging frames for the
>  	  Marvell switches which use EtherType DSA headers.
>  
> +config NET_DSA_TAG_MTK_COMMON
> +	tristate
> +
>  config NET_DSA_TAG_MTK
>  	tristate "Tag driver for Mediatek switches"
> +	select NET_DSA_TAG_MTK_COMMON
>  	help
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  Mediatek switches.
>  
> +config NET_DSA_TAG_AIROHA
> +	tristate "Tag driver for Airoha switches"
> +	select NET_DSA_TAG_MTK_COMMON
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for
> +	  Airoha switches.
> +
>  config NET_DSA_TAG_KSZ
>  	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
>  	help
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 555c07cfeb71..7aba189a715c 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -27,7 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
>  obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
>  obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
>  obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
> -obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
> +obj-$(CONFIG_NET_DSA_TAG_MTK_COMMON) += tag_mtk.o
>  obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
>  obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
>  obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
> diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
> index b670e3c53e91..32befcbdf4be 100644
> --- a/net/dsa/tag_mtk.c
> +++ b/net/dsa/tag_mtk.c
> @@ -11,6 +11,7 @@
>  #include "tag.h"
>  
>  #define MTK_NAME		"mtk"
> +#define AIROHA_NAME		"airoha"
>  
>  #define MTK_HDR_LEN		4
>  #define MTK_HDR_XMIT_UNTAGGED		0
> @@ -18,6 +19,9 @@
>  #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
>  #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
>  #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
> +/* AN8855 doesn't support SA_DIS and Leaky VLAN
> + * control in tag as these bits doesn't exist.
> + */
>  #define MTK_HDR_XMIT_SA_DIS		BIT(6)
>  
>  static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
> @@ -94,6 +98,7 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
>  	return skb;
>  }
>  
> +#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
>  static const struct dsa_device_ops mtk_netdev_ops = {
>  	.name		= MTK_NAME,
>  	.proto		= DSA_TAG_PROTO_MTK,
> @@ -102,8 +107,33 @@ static const struct dsa_device_ops mtk_netdev_ops = {
>  	.needed_headroom = MTK_HDR_LEN,
>  };
>  
> -MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
> -MODULE_LICENSE("GPL");
> +DSA_TAG_DRIVER(mtk_netdev_ops);
>  MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MTK, MTK_NAME);
> +#endif
>  
> -module_dsa_tag_driver(mtk_netdev_ops);
> +#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
> +static const struct dsa_device_ops airoha_netdev_ops = {
> +	.name		= AIROHA_NAME,
> +	.proto		= DSA_TAG_PROTO_AIROHA,
> +	.xmit		= mtk_tag_xmit,
> +	.rcv		= mtk_tag_rcv,
> +	.needed_headroom = MTK_HDR_LEN,
> +};
> +
> +DSA_TAG_DRIVER(airoha_netdev_ops);
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_AIROHA, AIROHA_NAME);
> +#endif
> +
> +static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
> +#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
> +	&DSA_TAG_DRIVER_NAME(mtk_netdev_ops),
> +#endif
> +#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
> +	&DSA_TAG_DRIVER_NAME(airoha_netdev_ops),
> +#endif

Unless the few tens of bytes saved matter on OpenWRT, I think this is
overkill (and you went too far with my previous suggestion).
Two Kconfig options are unnecessary from a maintainance point of view
(and config NET_DSA_AN8855 isn't even selecting the correct one!).
I suggest you register both tag drivers as part of CONFIG_NET_DSA_TAG_MTK,
at least until the differences increase to justify a new option.

> +};
> +
> +module_dsa_tag_drivers(dsa_tag_driver_array);
> +
> +MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
> +MODULE_LICENSE("GPL");
> -- 
> 2.51.0
> 


