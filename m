Return-Path: <linux-kernel+bounces-865395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0961BFCF61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB19D4EDF09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E924469B;
	Wed, 22 Oct 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPqQGRIb"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A723E25B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148123; cv=none; b=n0gtN8e/06rysMRdXM/G6nZNErPLprOc9SAZ02DHTHVY0qUMqWvJAdusj+ZV6f9bNhKJWdjhOSivnfHqJ+x6Ck+Smsow4jqkQ46UxuJaCRUFBiWEXSNyuD9F3IePASya3YyGC8GJ4HwwM/Ntv0Wrz2oRmUiOfF6w1XIM5I+jMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148123; c=relaxed/simple;
	bh=8NETNIzuboOpJbg4ntKwpRaVfdFSebUPtGY6GIFfbZ8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJSPGBtWR5fKgHcl2K36K+nkgWJoMxzWRwQv4p9MpWryhmX8BUIL50vZmQHil1PrGEPM81G+tSlYxbuQVDi85SNmnZG6EWU+l4Wmv2sXLfzqHAswOGIR/fU5zY81srsNl9GzjfLR7VfE2B9tVu0/noNPcTP53VxwExn3YhOgksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPqQGRIb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4285169c005so930046f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148117; x=1761752917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XWO4yOCaMUYjGeCQQA0uyhzhbdrG4m6pu8cUif/JpM0=;
        b=mPqQGRIbo+1CjtS1Sa3gaVbW8i7CH10lFrgZIBwiz24ApAxIAVQuTWUwdjaltggExH
         w+EOF5R4KSyOOxSWnsvmCetp0NwR833AedjNbSPCO2NCTRGVJvN6f9wnsXqs4UYBjgeQ
         zq6F9ftYO8yB6H9rk2zo1cRbFCWgPqos+hP0mrc+HLn+aOVf+FM5YTPtf1PdMyLEWrDC
         OxEXijuL1t2oYWjH6uCij/rL9XcQ739OO0hMZrsIf6nZFMPMBhMTmzgoFTZLlbH64RIQ
         1PhhfgT6gAKi9rsi5O6ZkKMr02kytKpII3KEUr6mlw1omZlP0gaJUx73c+FMVeTBwG2W
         wLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148117; x=1761752917;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWO4yOCaMUYjGeCQQA0uyhzhbdrG4m6pu8cUif/JpM0=;
        b=hKjCzEuZpnHyvfBfEOBQxRrYCSHSRd264pi9dgYBG2Yjbyo5qfmwp+P5VhmUjf9mVt
         6zO7HIdVcuj+Cr6VpUghTKlFxgJ/FNmxJ6wuuZX5cvuPT4U45imENXK09xkL1hYgyE3i
         jnyy/6zFmCf+0FHolD8jqHzy4qfjtMOlupLVDidSKusytTmhVtl+tBSEKHoorX1izB3w
         vLO8HAwgixIvlfhZiIJj6CX1Zr7PL9WOO+8p2TViaWS/l4qix/Ito136xik6jj7etkmE
         CxpOUN939hZHbCrWSHlpc7lkrD4nDdrG7SsEGWZotEQCpHKBJc3vpH6+Gp76SvT4DFTO
         RsJw==
X-Forwarded-Encrypted: i=1; AJvYcCUgku8x8vNnmjPYQzTh5idLwrYSqC6OhXiC//qzvAFdAPNp1eDZYLa1wrpiioIjJ9VicX1hA9Ef1cMEYBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVK7Rul6D0atWoGYL/yFBLcIqgWnaVq8Yd29DVQQ/QD4n56VxB
	mOcKa8x8JbPuiZVxUAcTJxSLVZsU8LcGsjDI9n93Ht7qkvwkPxT5eZR8
X-Gm-Gg: ASbGnctNLolhETt16qo3G1/DWuLwBqGcEondhThmdYALCapUZ06173TRtTtKClDjB2A
	h3gW8rB3iWrnDLt/2BWkDvzuRO5LZhr3iuXJM1305XfYw76i40BzlpYWgzk1wp9LEQKsPxuPYOo
	0FfAVJ53QiJb06sG3fdEKaE4dRKt/yfErnTiXTY2+kDPion7CB2OeoOZtzNb4c5hQCTot+lfRxW
	sYa8t4Q+OoVsT9TJ2U92nrdWCS3rnCsi4qNphCXkWwGqzQPk46rm+rUB4czfDRexhe6xMXOD67m
	lJZqx3rAquDzJM+zHdzCVKsE7mS/yZKQnsRAOwLyRgXmrJXvvfCu4kpsFzjbtSpE6Np4X1CyJte
	iy1lHbVRJ40/+R8QlR8qJMiOZHVpNyDv5wgaVMtLsbUZ5iynlLBkrWNyUVxhrANS0NSnWzU3BOr
	o+MT9UT/W0n90gZt+zdvaVsgyBwLRih3nFw5pCkjg=
X-Google-Smtp-Source: AGHT+IHAoVbOJakh16O5eBX5PTSAHI2xQcrVoDpyDPxM5ZW2+gUYAv5HKBvRB8LcVZCJLd8co8c93A==
X-Received: by 2002:a5d:5d01:0:b0:428:55c3:cecc with SMTP id ffacd0b85a97d-42855c3d3femr1634009f8f.37.1761148116971;
        Wed, 22 Oct 2025 08:48:36 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm25309390f8f.36.2025.10.22.08.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:48:36 -0700 (PDT)
Message-ID: <68f8fcd4.df0a0220.60f68.1bc1@mx.google.com>
X-Google-Original-Message-ID: <aPj80atNusRChjjG@Ansuel-XPS.>
Date: Wed, 22 Oct 2025 17:48:33 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Horman <horms@kernel.org>
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
 <aPj8J5ntvDGLPYaY@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPj8J5ntvDGLPYaY@horms.kernel.org>

On Wed, Oct 22, 2025 at 04:45:43PM +0100, Simon Horman wrote:
> On Tue, Oct 21, 2025 at 09:33:12PM +0200, Christian Marangi wrote:
> 
> ...
> 
> > +static int airoha_setup_phylink(struct net_device *netdev)
> > +{
> > +	struct airoha_gdm_port *port = netdev_priv(netdev);
> > +	struct device *dev = &netdev->dev;
> > +	phy_interface_t phy_mode;
> 
> Hi Christian,
> 
> phy_interface_t is an enum and thus may in practice be unsigned...
> 
> > +	struct phylink *phylink;
> > +
> > +	phy_mode = device_get_phy_mode(dev);
> > +	if (phy_mode < 0) {
> 
> ... if so, this condition will always be false.
> 
> I suspect the correct approach here is to change the type of phy_mode to int.
> 
> Flagged by Smatch.
>

Thanks a lot for pointing this out. Also I'm a bit confused of why
device_get_phy_mode changed the args deviated from the of variant that
return int and required an additional arg for the interface...

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
> 
> ...
> 
> -- 
> pw-bot: cr

-- 
	Ansuel

