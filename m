Return-Path: <linux-kernel+bounces-878020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CAC1F971
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429D24647C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED010351FB8;
	Thu, 30 Oct 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtZlMuIi"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775332D0E8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820510; cv=none; b=XQ6LxOlAh2nKlj/lO05sxgUK4RJi62g8xI3ro774sCOi1/hkN5IhfElP593krj/K7lkRH77ZjdU45o7L586eGmnpOWfp34JyErPFN6NHY0NnEyQQ9Zz6mZlzGxxff9bxtIioNJBCZ9OukJa5GHrlYk1e8qHNAnPzaW74tIBooDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820510; c=relaxed/simple;
	bh=SZ6e+WXbvMDAvZNixEY7qjyYrMagzCDzDbDS4AZsWI8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQpnr7SsiN595bBZ9POOo5QlZKW+4sSr95XNxyPdQRxAyoh7gk5Fn7ys2MOe1MrBKFLTc54/vXesjrkPhTEPWTBFM86dNiBYWvr/l4fKGjupR1diCBwlh6vo6LrRZAJqZCqWJ38IpraheG81c+21hmOdf8WQdOytkCq7fVqNS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtZlMuIi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso878705f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761820507; x=1762425307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsPngKrFqfEFSGok7TSQm60g/euZJ7JcyyRZuGnNgBg=;
        b=KtZlMuIif2oarcFs92tXATxx4V7/B2kyFZnLCbwukioJ/zxndUSBEBo+k1Wia0WfFX
         HaJ0gSTUZL/8E2nlm3Uz2Bcc+0guuxaWWbvq+AbCx/YVpubmOu1xJuU5vgayPMBP04UI
         fxwqLaiR0GyH1jiVtsctCLh2zRhwEBLdy4ItGg7AnRed31i+lTkjmyBbzsJy2v97l+qE
         rmukQ50y6al50QS56HjIa3APOp6ThaP6Y2l+EbMqmCoMxYP7yV5V/5AFO++69v+yEWFt
         ac5Vtg+7zxyZqjS400+SKvbJ5wmK6mVwu7iuAKsi9kF6nQloDKaiNUROEq+D8WN0D2MX
         tX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820507; x=1762425307;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsPngKrFqfEFSGok7TSQm60g/euZJ7JcyyRZuGnNgBg=;
        b=rGbyfNx7LXHKIwLoqbMV1yTMcbJFS67EslO+lLqLAALZCxL7YA2xwi/3W5UfpcS4wq
         pzIcw4zFtrhUpjMWG9uHcO6HxsywLPIa+ITGjil9vbsca22xybZn9yeHRz5OfmfKTrFU
         v1qvh9Z1hZEBlQDKxV3hHVm82exeQ2MmVea3Sbig/LGy/yPQGgTW40vylxpbb+VTefwg
         IkMEwSkwvHSl/BWOSvq8HHQlw3poHYSLdGh5P0cD+zPFp7KWP69sEfovkLNJA8x6nLbg
         1Dl95r+q5M3T65Q7UM0sJvPjnWzqoc9DCyIzQtVDDP9EF/LmlX7gp9qr8c7RO9cKg5Yu
         KgkA==
X-Forwarded-Encrypted: i=1; AJvYcCX/s5XlgN8H+XdYRmUc2pUXz34dq25KxLXqUSYZtsFsHEaUfUXtHUTqpciW+FEFHhscidvZ/S5IyBZDLtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+smivGNKH7EmUwZtr7F53R5yE08EurRrlWoxnrybvulr6NMVJ
	yWoszk+0Naqaz63BKkMKYwqblbI9sz1ObxvKq+ddi9t3t4eQoY+al+ih
X-Gm-Gg: ASbGncts/AYsePEc1YHk9D5jMy14U2byQYwOUi1biU9TXXRlmfbHV9BHNLcKf7mmG66
	mpz9T2vZWMfdkjB5Uk+Hdc1z2eoGS6MKFJNvcD0EOd7nUPYXQdbZnV1hUHBtFhQW47ngV4uXPLu
	K1uSabVOYLsmcEAOxX5r53HhXEr2VfjiXmNUyM6TeZi+b5AFirvBvfY7UhzjZ/8lS0yYejBxS0a
	LEkTSPGGDyUZIKEyBO9XfIR7HoOexmDFASxiQNQHe1GVZFfLSzUmCR+JpQzjmBTlREEZoyrtUy8
	HTcS2sWFOnQ70x0kOKWUvdwgbh5rmB/TW/BKOCSzy/vgGgV8rHsR6U055OQ+r13Hctz5se2Ze6m
	0xKb3qVoQUWdKYX/SWUGS+fgQo9drSOB7vRQpO8hllpCKSWWYo6Vto1Lpak/nKsx6ZdIUP0c5ua
	O3F5t6x3QXknhMLxRJm5OdoDnpMAyl
X-Google-Smtp-Source: AGHT+IESaUzzzN97jkFB4AyHPl8jIeK4DpYfr+xMeimLxz4XvTZuV9U4wyHB6rScPa52l5uDwp+EVw==
X-Received: by 2002:a05:6000:2c05:b0:428:3e7f:88c3 with SMTP id ffacd0b85a97d-429b4c9ee77mr2317234f8f.50.1761820506460;
        Thu, 30 Oct 2025 03:35:06 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm31832354f8f.21.2025.10.30.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:35:06 -0700 (PDT)
Message-ID: <69033f5a.df0a0220.25fede.548f@mx.google.com>
X-Google-Original-Message-ID: <aQM_WCsuEDykB4e1@Ansuel-XPS.>
Date: Thu, 30 Oct 2025 11:35:04 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/2] net: airoha: add phylink support for GDM1
References: <20251023145850.28459-1-ansuelsmth@gmail.com>
 <20251023145850.28459-3-ansuelsmth@gmail.com>
 <aP00w4CQdeX9GIJA@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP00w4CQdeX9GIJA@shell.armlinux.org.uk>

On Sat, Oct 25, 2025 at 09:36:19PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 23, 2025 at 04:58:49PM +0200, Christian Marangi wrote:
> > In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
> > that is an INTERNAL port for the Embedded Switch.
> > 
> > Add all the phylink start/stop and fill in the MAC capabilities and the
> > internal interface as the supported interface.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/Kconfig      |  1 +
> >  drivers/net/ethernet/airoha/airoha_eth.c | 77 +++++++++++++++++++++++-
> >  drivers/net/ethernet/airoha/airoha_eth.h |  3 +
> >  3 files changed, 80 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
> > index ad3ce501e7a5..3c74438bc8a0 100644
> > --- a/drivers/net/ethernet/airoha/Kconfig
> > +++ b/drivers/net/ethernet/airoha/Kconfig
> > @@ -2,6 +2,7 @@
> >  config NET_VENDOR_AIROHA
> >  	bool "Airoha devices"
> >  	depends on ARCH_AIROHA || COMPILE_TEST
> > +	select PHYLIB
> 
> This looks wrong if you're using phylink.
> 
> >  	help
> >  	  If you have a Airoha SoC with ethernet, say Y.
> >  
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > index ce6d13b10e27..deba909104bb 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1613,6 +1613,8 @@ static int airoha_dev_open(struct net_device *dev)
> >  	struct airoha_gdm_port *port = netdev_priv(dev);
> >  	struct airoha_qdma *qdma = port->qdma;
> >  
> > +	phylink_start(port->phylink);
> > +
> >  	netif_tx_start_all_queues(dev);
> >  	err = airoha_set_vip_for_gdm_port(port, true);
> >  	if (err)
> 
> phylink_start() _can_ bring the carrier up immediately. Is the netdev
> ready to start operating at the point phylink_start() has been called?
> This error handling suggests the answer is "no", and the lack of
> phylink_stop() in the error path is also a red flag.
>

So I guess the correct way is to move start at the very end of dev_open.

> > @@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
> >  		}
> >  	}
> >  
> > +	phylink_stop(port->phylink);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2813,6 +2817,18 @@ static const struct ethtool_ops airoha_ethtool_ops = {
> >  	.get_link		= ethtool_op_get_link,
> >  };
> >  
> > +static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
> > +			phy_interface_t interface)
> 
> I'd write this as:
> 
> static struct phylink_pcs *
> airoha_phylink_mac_select_pcs(struct phylink_config *config,
> 			      phy_interface_t interface)
> 
> but:
> 
> > +{
> > +	return NULL;
> > +}
> 
> Not sure what the point of this is, as this will be the effect if
> this function is not provided.
> 

Sorry I was confused with the other OPs that are mandatory or a kernel
panic is triggered if not defined. (for example the MAC config)

> > +
> > +static void airoha_mac_config(struct phylink_config *config,
> > +			      unsigned int mode,
> > +			      const struct phylink_link_state *state)
> > +{
> > +}
> > +
> >  static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
> >  {
> >  	int i;
> > @@ -2857,6 +2873,57 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
> >  	return false;
> >  }
> >  
> > +static void airoha_mac_link_up(struct phylink_config *config,
> > +			       struct phy_device *phy, unsigned int mode,
> > +			       phy_interface_t interface, int speed,
> > +			       int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +}
> > +
> > +static void airoha_mac_link_down(struct phylink_config *config,
> > +				 unsigned int mode, phy_interface_t interface)
> > +{
> > +}
> > +
> > +static const struct phylink_mac_ops airoha_phylink_ops = {
> > +	.mac_select_pcs = airoha_phylink_mac_select_pcs,
> > +	.mac_config = airoha_mac_config,
> > +	.mac_link_up = airoha_mac_link_up,
> > +	.mac_link_down = airoha_mac_link_down,
> > +};
> 
> All the called methods are entirely empty, meaning that anything that
> phylink reports may not reflect what is going on with the device.
> 
> Is there a plan to implement these methods?
> 

Yes. For the internal port there isn't much to configure but when the
PCS for the other GDM port will be implemented, those will be filled in.
This is really to implement the generic part and prevent having a
massive series later (as it will be already quite big and if not more
than 10-12 patch)

Hope it's understandable why all these empty functions.

-- 
	Ansuel

