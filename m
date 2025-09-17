Return-Path: <linux-kernel+bounces-820435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830BB7E023
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F122F1BC68FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0043570BE;
	Wed, 17 Sep 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmB8g4dY"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05023568E9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103844; cv=none; b=k82uowqj+5XJbbK+8QH5GeBNH84qmx8eJFxmNXGUKPMwKWIzL/8rtjgEbF1InS0RfPiTFUExv0u0O+zvtTK6Zr5v3JZReQd2wRJruIAH/o1Iqav6SctUat2ucoevTwzUqFQPhWYzYgnQu6APLHswwX9GUSIuPMM7asBWW8Yd6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103844; c=relaxed/simple;
	bh=rpTHsBn3VeoWp8btufcMUAi6QPK0DZFIiRIjDbjNa5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9Fwd+SAFS9bUJqFDV72US8GUk0bG14pHWHH9Yk4JdqM85SeFxAgDKdRiGEJCstm9b3d8f6LkS3+5nPMVlH6hJsKd3onU7Y4fNMB4s1mACNh+47y00sioFVueoSv/7yOeWxP8XkK+TlaBIWltxmWkwcIGBXwOq6QLqz930hyYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmB8g4dY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ece2861f01so2161f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103841; x=1758708641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkQ5W8f0VgiP6PCTsWWJrbImt94RgIZfxXIr4G30wgQ=;
        b=DmB8g4dYm/SDopagobjr54/iDqaoFxuKOn/4OnRIOjIZpFTfoQz+yrhKGkSJLrn6j1
         rLeWHg7lPgztz9d9LtPEAE03cfCmQJ7v0Ti8eZbjHA10AkHBCdjdDN3l/+5sGm41iMBL
         UqGVDKELA+L5EUnjfKGotSfn/D82FQa9MjCDzT4e/PXOV9pyTcrfvItx9tyxfBbfiVWE
         IdZ+wSAnaUkzdezPr67rXPK7I92U8gVwlkRloJuOMyawVtV3ytozboIesX66J8HszpSw
         IxCE1AI6DaxnxOydhyLzGUPof+s72X//fnFsmzBiQyYgeNdvTPBw7O6XTn20GYXVxqTw
         TLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103841; x=1758708641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkQ5W8f0VgiP6PCTsWWJrbImt94RgIZfxXIr4G30wgQ=;
        b=SRJg+RjWU4859fR6yXorLRsoF/x6P3nWI2DiDZL8lI3xX+/jvgXlRNc0jv4cP3qUk+
         RvY3NNTgkXpOqTyZcMQjvBB/pPaJ7eNHf4aE3kXQOGVqpC7uowNABLpvbAOOxJKN37jM
         tHD8mzZnl5/fj6rcxNW+0KbTNI2SCDw1WYbwhe7EFQsD6TiJcjhVcJhc2Cf/O59q4/y/
         NRPK9Xo9sqeF8LZfBQ5j1NayvN4f5Zm19G8hlCMyW5Ust4n/ej58UweG1vb73UpK0KEH
         uxmSfylv4mcAHLqyCNcjBuiYfqsKThlveax+FB41mQ+zFfw6gMKi2Qs1ibDso02Gy8Rj
         1pGA==
X-Forwarded-Encrypted: i=1; AJvYcCVL3EGjgVtQnzyVC3RLRsBVewptYY5qD36Vg8/8to0anowcW/mduQgvUzb7ICw8yA+cIvao/hlDqEoDxTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+umMBTeTj/I1RJoUuPoJsDgvoliVwJjXctDHjQdJYO3XT0H4
	LuNo078KIsAtNX7bsbpm3TJ3lppd0UqdihUf1yGnGoEziZAN63tumJeK
X-Gm-Gg: ASbGncsg/mEbRvXI1RIRcvGjSKC/+y1GDXXRb9qpBaUBn66Mn6GWgso76jVGxcwXNCm
	LSgokHlFCHYu6Vy48Kso+bqNaI9JCyvK1iCcxk8PpnGdpWBQvTjBAzKBgiWRA5XjP3MohFUXhD/
	7nzKjFDqz0PNnsEhlcOMiHCydJDxb5oZ7+0v3vJ6/r9MyKuOrwA/981ANPNGeZkj9I+g9Ini403
	Q7i0OCFL+uZDf37kcLDhxmR0lzabgMeJybnyqso1uGAVieplrYNiyyfY4MAJImf7t332rHIzZ+j
	A3/UTCk/I15CJd4NiTHxpjSIaCDIauHxZzMdml+FaFHdPunhUBSbqFv8dFRYa93lTDUQU0rxiIO
	FbWI2hn2E6Azip4A=
X-Google-Smtp-Source: AGHT+IEEatHJpLubzoy4lkQ0hIsi84UEkNPErsL1pNTYQeBGmM1JX4r+iiCRONDCh4wUnphpFnKYhQ==
X-Received: by 2002:a05:600c:c16f:b0:45d:d57b:69bc with SMTP id 5b1f17b1804b1-462074c689amr8001385e9.8.1758103840619;
        Wed, 17 Sep 2025 03:10:40 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm37511495e9.3.2025.09.17.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:10:34 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:10:31 +0300
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
Subject: Re: [net-next PATCH v18 0/8] net: dsa: Add Airoha AN8855 support
Message-ID: <20250917101031.drg3qairsrinucbl@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250917092807.uui2qwva2sqbe6sp@skbuf>
 <68ca8217.050a0220.81571.9fda@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ca8217.050a0220.81571.9fda@mx.google.com>

On Wed, Sep 17, 2025 at 11:40:36AM +0200, Christian Marangi wrote:
> On Wed, Sep 17, 2025 at 12:28:07PM +0300, Vladimir Oltean wrote:
> > On Mon, Sep 15, 2025 at 12:45:36PM +0200, Christian Marangi wrote:
> > > It's conceptually similar to mediatek switch but register and bits
> > > are different. And there is massive list of register for the PCS
> > > configuration.
> > > Saddly for that part we have absolutely NO documentation currently.
> > 
> > Please add in the next revision a more convincing argument for not
> > reusing the mt7530 driver control flow. Regmap fields can abstract a
> > lot, and the driver can select a completely different phylink_pcs for
> > different hardware.
> > 
> > I don't see in the short change log included here any mentions related
> > to the mt7530, but I'm not going to search the mailing lists since Nov
> > 2024 for any previous discussions about this...
> 
> Ok will add additional info.
> 
> But In short the FDB and VLAN part are very different. The FDB logic to
> dump entry add and remove is entirely different.
> 
> And the mt7530 itself is full of unrelated function (specific to the
> first revision of the mt7530 switch) so I have to move lots of code
> around.
> 
> If asked I can do it but I have to also introduce lots of extra change.

Ok, it would be good if you could point to an ack from mt7530 people
that they're ok with this choice and motivation.

> > Do you know why it won't receive PTP over IP? It seems strange, given it
> > receives other IP multicast (even unregistered). Is it a hardware or a
> > software drop? What port counters increment? Does it drop PTP over IP
> > only on local termination, or does it also fail to forward it? What
> > about the packet makes the switch drop it?
> > 
> 
> From what they said there isn't any support for 1588v2 (PTP) on the Switch other
> than L2 (that I think they simply forward)
> 
> I can ask more info on the topic, will also check what counters
> increment.

"Don't support PTP over IP" can mean a lot of different things, but I
don't expect "let's drop it" to be expected behaviour. Being a
PTP-unaware switch (which doesn't timestamp event packets and doesn't
participate in the protocol) is an entirely adequate and basic use case,
and we aren't even requesting the switch anything other than to receive
these packets during the selftest (no timestamping). But it doesn't seem
to work, which is bizarre. We don't even know if the problem is specific
to PTP or is more widespread. Maybe it has to do with the UDP ports 319
and 320, maybe with the particular IP multicast groups...

