Return-Path: <linux-kernel+bounces-865398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF22BFCFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E81189A3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB2224677D;
	Wed, 22 Oct 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieo4gqk/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079235BDB2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148333; cv=none; b=LJ/vIsPmsKImcm781wC+s7wjlEIcRVyMTAV5cStmaH/B35+fD3jJUpUey24dbSirbVjvDzQ9+cZMjGa3ok0MCDMXPbT7t4jkv5xmBiwXMZ2lfpbAE5ekhZStQYOIiKIWt1613xnMqvTyDznmT7Pqlms51lylwKa+/fIWFTq7Csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148333; c=relaxed/simple;
	bh=M2ad4TNbqndSNU6O9h8RDvtINbP3SwSMD9zdf7PJ/kE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9kEwYgieY+GtatO/UxsOXB55n8bchLPaDGtasSBH5sxMlRowakPKJUFubzuBHGM2O8lbkBlUs2IsaqFrfXXGjkThR/70aOfFGverLyoIAOsbgLv6Np6xKvy0GykvJ2iGLh40dbcd3OPYl7o2WIV3eb+xJdY8+05GSSpBJoLd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieo4gqk/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47117e75258so36492535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148329; x=1761753129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g5kr/bQI82p4aOoVx3CaPnWuXCBcZLFYX+TGL7tLi7A=;
        b=ieo4gqk/ezt/NQKIRYTfCey9E2IEWA0CMN3eXndRKhikzxwDhZ+BG2cz0cdRsEGtiY
         2DgbzUXfRytZXFQlwsTzVD359XPFGKHZB7Im+bhbDTOU3ho2Hk5NX7MY2Y89pCZcmewV
         WwlyDqJiAwGl0+7rx7qmh5ECjFUPyL/Npf/wE3KGliaTbUIT0vIE9b8qebqF5z9QzKSd
         DaiG91G4QETwwdkD8empu3Yehmi/Xv3W5W879N8JKKcAqus3QNNo3pVYO9viiMZV/onm
         TXTq/5m03J4aewn9iahL4EUhwQKY0mr0yvLo97p1syLnScMY3EjtLiaiBqFDWKb5OvJL
         joMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148329; x=1761753129;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5kr/bQI82p4aOoVx3CaPnWuXCBcZLFYX+TGL7tLi7A=;
        b=e1O6qtf/7FtYPHJUJ3YDwwNPhXnTtBpth4Yx3xN8FLxceDaL8xv25AgxJq4euCKlMc
         YwtPl0hKxgL6xa3yxPUDez5pxowF6NoB4ixcomh0PBAIC5OkhpiBuIHw5wFK9Jjcg6KU
         Fp7DgnrQo8cPR3lo5G1cwriq1slZ5t9ms5aJ+jNTF7FBGPufMZZrYnd+49edwW7KIXKH
         G2vgjS621KVvm7wKm1t4T20SGr9YuTBZ8sdJw6My92Gt6x0gF2MnDEVtmUj/uLP0OO1H
         uu5ZkJMgjpNL/TrnrRJgemFNhLotFIzeC8ACBsr0AoACXFKQLDgf3gwOBuST+Z7Unote
         hKEg==
X-Forwarded-Encrypted: i=1; AJvYcCWErnMVCbPicAc787JUBNf5NuZFzWH4S9fvrf1s9PKgvwcfRxpB0F99nuqgiMIz5KGPJGkjlzN0o2k/LdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQnwc9s+Gcd42/HIcu/ulWawjqxmCjAP9zb+nt7gTxmyQCeZ2F
	eAt/6yVNFkjVZYTPebniZre2Jnk2hoV39jcmP6EIEsn/JEbcucn0v56zJ8sBYA==
X-Gm-Gg: ASbGncsisn3N/dRaxXBuvCh30MjXMV7u49wtk9Jsiz2xs628K5eXTc4o2v5nHRDxTyN
	+oTxxMW3sJaSB0orBLRHZiU2WD/dOuPwnX0uUjSnBO87q1gNGuQbrSiYvK3zP/ta3n8XQCAvZrs
	G+ZgDhbQ3UiKcYJHCTYjCfRefgf3+da29N5dwSn7SWvhmci1vM0l0rYN8qEia2va4z/cL806OEe
	32msMIvdnkzMN2TN6X9m9BECkbmdo3z25xjyZaJwjhuCjHMTsHTKE3muxnp0gTTZE7IN/FoBugE
	5+jokioiqhwMYRu0isKBUYNkmc2GCfnZ4nG11RsnmFRbY7bECNMOVI+puoKyJ9CCb4jysvt3YZH
	SObhsm1z0p8G+TF4pfDTMY3yanuf6u1dHkdqY76UoUpKWxHDPqLPx5zXzaEIKaxD5fflKM30Gru
	4mrVBC0xF3yGHWLiFhrTq5Yz79FSHPHGcKC4fp+lvf/0YogcIRsw==
X-Google-Smtp-Source: AGHT+IF2VkMFb1grUIsz9Ob5/VnZ+J8LZJM9Q4gOUJAoOT2z3iABDCrdKLQP3lhX3uW6IN4Sf6xW5Q==
X-Received: by 2002:a05:600c:8b0d:b0:46e:39e1:fc27 with SMTP id 5b1f17b1804b1-4711787442amr156532835e9.5.1761148329287;
        Wed, 22 Oct 2025 08:52:09 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm26175138f8f.31.2025.10.22.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:52:08 -0700 (PDT)
Message-ID: <68f8fda8.5d0a0220.3519eb.41e3@mx.google.com>
X-Google-Original-Message-ID: <aPj9phaGLkU3JMm3@Ansuel-XPS.>
Date: Wed, 22 Oct 2025 17:52:06 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: airoha: add phylink support for GDM1
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
 <20251021193315.2192359-3-ansuelsmth@gmail.com>
 <2a9e1ecc-2f33-432b-bf77-e08ce7ccd0ce@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a9e1ecc-2f33-432b-bf77-e08ce7ccd0ce@bootlin.com>

On Wed, Oct 22, 2025 at 09:42:11AM +0200, Maxime Chevallier wrote:
> Hi Christian,
> 
> On 21/10/2025 21:33, Christian Marangi wrote:
> > In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
> > that is an INTERNAL port for the Embedded Switch.
> > 
> > Rework the GDM init logic by first preparing the struct with all the
> > required info and creating the phylink interface and only after the
> > parsing register the related netdev.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 108 ++++++++++++++++++++---
> >  drivers/net/ethernet/airoha/airoha_eth.h |   3 +
> >  2 files changed, 99 insertions(+), 12 deletions(-)
> 
> You also need to select PHYLINK in Kconfig
> 
> > 
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > index ce6d13b10e27..fc237775a998 100644
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
> > @@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
> >  		}
> >  	}
> >  
> > +	phylink_stop(port->phylink);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -2813,6 +2817,17 @@ static const struct ethtool_ops airoha_ethtool_ops = {
> >  	.get_link		= ethtool_op_get_link,
> >  };
> >  
> > +static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
> > +							 phy_interface_t interface)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
> > +			      const struct phylink_link_state *state)
> > +{
> > +}
> > +
> >  static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
> >  {
> >  	int i;
> > @@ -2857,6 +2872,55 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
> >  	return false;
> >  }
> >  
> > +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> > +			       unsigned int mode, phy_interface_t interface,
> > +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +}
> > +
> > +static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
> > +				 phy_interface_t interface)
> > +{
> > +}
> > +
> > +static const struct phylink_mac_ops airoha_phylink_ops = {
> > +	.mac_select_pcs = airoha_phylink_mac_select_pcs,
> > +	.mac_config = airoha_mac_config,
> > +	.mac_link_up = airoha_mac_link_up,
> > +	.mac_link_down = airoha_mac_link_down,
> > +};
> > +
> > +static int airoha_setup_phylink(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_port *port = netdev_priv(netdev);
> > +	struct device *dev = &netdev->dev;
> > +	phy_interface_t phy_mode;
> > +	struct phylink *phylink;
> > +
> > +	phy_mode = device_get_phy_mode(dev);
> > +	if (phy_mode < 0) {
> > +		dev_err(dev, "incorrect phy-mode\n");
> > +		return phy_mode;
> > +	}
> > +
> > +	port->phylink_config.dev = dev;
> > +	port->phylink_config.type = PHYLINK_NETDEV;
> > +	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +						MAC_10000FD;
> > +
> > +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +		  port->phylink_config.supported_interfaces);
> > +
> > +	phylink = phylink_create(&port->phylink_config, dev_fwnode(dev),
> > +				 phy_mode, &airoha_phylink_ops);
> > +	if (IS_ERR(phylink))
> > +		return PTR_ERR(phylink);
> > +
> > +	port->phylink = phylink;
> > +
> > +	return 0;
> > +}
> > +
> >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> >  				 struct device_node *np, int index)
> >  {
> > @@ -2931,19 +2995,30 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> >  	port->id = id;
> >  	eth->ports[p] = port;
> >  
> > -	err = airoha_metadata_dst_alloc(port);
> > -	if (err)
> > -		return err;
> > +	return airoha_metadata_dst_alloc(port);
> > +}
> >  
> > -	err = register_netdev(dev);
> > -	if (err)
> > -		goto free_metadata_dst;
> > +static int airoha_register_gdm_ports(struct airoha_eth *eth)
> > +{
> > +	int i;
> >  
> > -	return 0;
> > +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> > +		struct airoha_gdm_port *port = eth->ports[i];
> > +		int err;
> >  
> > -free_metadata_dst:
> > -	airoha_metadata_dst_free(port);
> > -	return err;
> > +		if (!port)
> > +			continue;
> > +
> > +		err = airoha_setup_phylink(port->dev);
> > +		if (err)
> > +			return err;
> > +
> > +		err = register_netdev(port->dev);
> > +		if (err)
> > +			return err;
> 
> The cleanup for that path seems to only be done if
> 
>   port->dev->reg_state == NETREG_REGISTERED
> 
> So if netdev registration fails here, you'll never destroy
> the phylink instance :(
> 

Oh ok I was with the (wrong) assumption that register_netdev always set
the state to REGISTERED but checking the actual function it's totally
not the case.

Wonder if there is a better method to check it but I guess making the
requested changed from Lorenzo should indirectly handle this BUG.

> 
> 

-- 
	Ansuel

