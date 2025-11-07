Return-Path: <linux-kernel+bounces-890587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F58C406A1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEF314EC289
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C02C11CD;
	Fri,  7 Nov 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElMoTB5k"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97141199FAB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526723; cv=none; b=dURCW+gxO7gl8N+Br0LNoqohh87Uf5W7580cLJfsiGWq3JKL36huYOWSqolINlSz/nYL5zCU25i/oRTAS+5w3D/h1w0xcK7SzMGgzsD0KTj1jc4ZR9RnFcLwzZ/0lGHuHgO6Y+OGU/ptp+tylODqNUMV/2Qcr90gswCh84GVzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526723; c=relaxed/simple;
	bh=6O1TcXTbOgqWbsU4rjkfXAPlc8g7enoi1UXN88VVvg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly0qqNVWzecu3WA57DoUvpPRADGLynIQsox1kZK6ivZdrImlSnRZAB2xXBNXk1NydWH7HB6TorPvvwvMUXJ3EfHGBZcy0O9NE3DDodTv/fje0Mcm1bdNXKzVYsbqqa09XlcuSAwe8Vcqe7J5hCZzs05cT7C/8+E1VDzSZowuRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElMoTB5k; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4770e0b0b7dso713955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762526720; x=1763131520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0A91tQqzTtqn7s4KHmgo7JGmxImEk5tXNG651T+iqbs=;
        b=ElMoTB5kIMvrXEx59GFtu52UJFjOqcL7adTaJYGIFW5sDgs0hZkZsY4HYwHJSUOoFO
         E1xt4Ee196Bm5ncb+T5DK94JFMZVIKYbbriHOqq+352zGkYeUu0RQV813N0uPfMUFhfP
         3O1KeHwxPqdQ9bM+muu3apyc6JZEkY/8oXlRw69EM++kVCtq3Si6R8maCutiCHEGCdXa
         dhT9Hoteta8erDmib8XDRKHsoWtxneCbSx/QCithv2hmO7ImdC5fBhYzvxNbzVPjX/vm
         jUBspCLDn0CfbVnaFYltsBCq/Vcq0hQBEl8Nx5ryTGVhX+rRC/j+RkucMJnVwg+BuUYb
         exsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526720; x=1763131520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A91tQqzTtqn7s4KHmgo7JGmxImEk5tXNG651T+iqbs=;
        b=T0yJdnC63pho9sIYpw5n4eS2Qtf+veKRdaHyslmV+s6lU+o/8UBKmrw/JwSAXhga+K
         N8gfhKPbC8Q5DWlDnfuU2JtaXKjD89Z1lXWSNpg+ueFT+JT/zgu67r0azyz1uD5NqTQT
         IpG2Es1w3a+kLgZOj7u0hqLIrEO7Qstxt4UhQhChIe5v762PweM81e+ZWMNxAuPO9Ql+
         LPb5GBNoYqkb9E6If35TJGDag38zOhNf6oKFJQw/EmgnKEpim/RisUhUCiiTz5xCmJ/K
         bzrRRx4OV8rG9xyE9j56AFoMrb/jGt0DTxELkUbjaY4FwYjbdbql3DXYDAGOGcW/Yp+T
         tdkg==
X-Forwarded-Encrypted: i=1; AJvYcCV3n2i2W0Y1hnfoglTjXFUjagepGsZJyA6ZDalLqjylBqho9CrZ4XxuuI1jyN0aPdVMIlhwlvj3TzKFZLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsrmqTQTPcQBNSFrWZLomo99Lu9ysXL575F61P/aNJWsFtdwS
	ASH6HedHAUQg6YF13KeX2hWePC1iQR1Tz+zRytJ+/sHqqt75BPrpTpjB
X-Gm-Gg: ASbGncvIObRjGdyXa+IPZpDweJdhF92oyqhYlM6Cjbm5gDz494z2XeCs3p6HVjLvpf5
	dG12K45xRIfsZN7KJiXG6EuesiKX+kAsUEiZPmLpOMppYqWV03aD1CSp9+g6oeSysIuoGhFSSUM
	aIjffKQIl8MVU94Rn/YzE6qjfQdgiMaR2pobsKnykyxt0m0B3wgNBwFCRcyy2X907qukAQF6PLK
	N70n54MFn5eknFzJvYjV5yhDGo2IdC9LMsfSv699U4oRdXrzrYdj7rzE6UbK7X14cohN/pRpZee
	LJqJgyq4NKT+bfPmJkNRYskAUAyP6L4C57jr8z8YWH9qsoRKojaYj0JirPHneW0Nv4C6OLe9/WI
	I7LlATZmg9DbnNw1Fc7hJeCzI50mZNrZzUTJyN3+T6YxzE4/sL80/Fk/S7GDbpa3t1IzXJA==
X-Google-Smtp-Source: AGHT+IHMo1jI7YYI7Zmf06/FZDipFnklmsyWsU9ypW2XbgzsiHTg/PR+Ked7+pCoTNPE3KZOskYWXA==
X-Received: by 2002:a05:600c:1c8f:b0:475:decc:2a0b with SMTP id 5b1f17b1804b1-4776bcca3dbmr19350805e9.3.1762526719323;
        Fri, 07 Nov 2025 06:45:19 -0800 (PST)
Received: from skbuf ([2a02:2f04:d406:ee00:e029:cf52:5797:9254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e86fc9sm44641605e9.2.2025.11.07.06.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:45:18 -0800 (PST)
Date: Fri, 7 Nov 2025 16:45:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Jonas Gorski <jonas.gorski@gmail.com>,
	Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode
 interpretation
Message-ID: <20251107144515.ybwcfyppzashtc5c@skbuf>
References: <20251107083006.44604-1-jonas.gorski@gmail.com>
 <ce95eb8c-0d40-464d-b729-80e1ea71051c@lunn.ch>
 <CAOiHx=kt+pMVJ+MCUKC3M6QeMg+gamYsnhBAHkG3b6SGEknOuw@mail.gmail.com>
 <ec456ae4-18ea-4f77-ba9a-a5d35bf1b1fd@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec456ae4-18ea-4f77-ba9a-a5d35bf1b1fd@lunn.ch>

On Fri, Nov 07, 2025 at 03:07:48PM +0100, Andrew Lunn wrote:
> > There is allwinner/sun7i-a20-lamobo-r1.dts, which uses "rgmii-txid",
> > which is untouched by this patch. The ethernet interface uses "rgmii".
> 
> Which is odd, but lets leave it alone.
> 
> > And there is arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts,
> > where a comment says that it has a BCM53134, but there is no such
> > node. The ethernet node uses "rgmii".
> 
> aspeed pretty much always get phy-mode wrong. So i would not worry too
> much about this.
> 
> > So one doesn't define one, one uses rgmii-id on the switch / phy side
> > and rgmii on the ethernet mac side, and one only defines the ethernet
> > mac side as rgmii.
> 
> That is reasonable. It is a lot less clear what is correct for a
> MAC-MAC connection. For a MAC-PHY connection we do have documentation,
> the preference is that the PHY adds the delays, not the MAC. If the
> switch is playing PHY, then having it add delays is sensible.
> 
> > > I would maybe add a dev_warn() here, saying the DT blob is out of date
> > > and needs fixing. And fix all the in kernel .dts files.
> > 
> > Sure I can add a warning.
> 
> Great, thanks.
> 
> 	Andrew

+Russell

Numerous past discussions seem to suggest that a MAC should treat all
phy-mode RGMII values all the same, as they all mean what the _other_
end of the RGMII link has skewed. To apply RGMII delays on a MAC, the
'rx-internal-delay-ps' and 'tx-internal-delay-ps' properties can be
added to the MAC OF node, which absolutely explicitly refer to what the
MAC does and nothing else.

Various compatibility schemes are implemented by sja1105, qca8k,
Microchip KSZ, rtl8365mb, vsc73xx and most recently Lantiq GSWIP, all in
order to tolerate their old (many times unique) interpretations of
phy-mode, while respecting the delays from the explicit DT bindings if
those exist.

Since there is no 'correct' way to apply RGMII delays on a MAC according
to phy-mode, my advice, if possible, would be to leave sleeping dogs lie
and fix broken setups by adding the explicit device tree properties in
the MAC, and adding driver support for parsing these.

