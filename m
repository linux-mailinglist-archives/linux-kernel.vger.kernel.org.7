Return-Path: <linux-kernel+bounces-820364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4CB7CC28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB34E1BC4ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB832D5BD;
	Wed, 17 Sep 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERoodyij"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66C306B01
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102044; cv=none; b=TsfTGiaPKKHa262H1kRsPxEHGajOSK0g5QhUx8GpCQKRBR0qFXlRYOCHAbNeO5nA5ORjehss64ygHas6/MWSpnhpxbw/K7V2hUegDxEVr7dsunJBKczW55bLtT8P2LYX3xVmIZO7vFPdj/TaVPy1BAMsxeDZZ+rd9JT+6Zz63yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102044; c=relaxed/simple;
	bh=zSjy7JweDiNuMf5jSMkd9oxm+C8V6Vitiz++md+Z5wA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCTcOTiXQksdzlAy39NcBbvALdegyRJXHMrfwL8/X1UdUTWzgcYyWi9YzC1Emd1WESK+qkCxo0SifgCBAzFhXIzV+/LL8RwozFq9SOa2yAIkNYX3dpr9KFNT7ll42MQaCYLPil6UjjNCs7Sixnz211VNWaNZax1PmXBQnuan1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERoodyij; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f31adf368so17950935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758102041; x=1758706841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5jQzjfISWXhmjsCWqCbC/EKcBa3nhvEnsbsmWDiienE=;
        b=ERoodyij9l6elDm96pZmjoicW11zuXES0xakR0gZ7eir1MityQQSHczT5364tELhkI
         M7kU+1aXeCnf2I6XXiN8m5U8EOcSEV3aJaG4HPuAHdm59RofChn6nhcULVyPcv1XJdY/
         WKg1rqmX45He4/DEcxhMskAgppemfZHb77JcTqKYU5NGbkRz0XxORq3Cjla7/WWuHU2N
         A4ZZi8QC91AQy3H3i6mIIOiMslImfd9KOuY8p7COLTeNnf7W4Zm+3qmaEKJb9+z1cRwi
         rqVWVVQlBtQZJEey4jO+bN0YCp+/fvvlO452llSwy2r987CItldKtdIW3sdQdOdJw8RF
         tJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102041; x=1758706841;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jQzjfISWXhmjsCWqCbC/EKcBa3nhvEnsbsmWDiienE=;
        b=ZxJRYXBb6AslLG59UW51Brkk7s/4Zu4SJAyUFU0yjn8u6odQvoslZoJmNjLqibejsM
         Jb57MqWFDhQcUvDIs6kEH3HguyRaMxRooj2MdvPPiVfHKlq7nIo4NmKgQrGGuCR3WPRi
         8PO6OYGEXNlf8FkG88EZPMcbDUVGYHs7eofMkHx7vZ+BYyqzaLAdfSqK5CVtCl5+0jKF
         ame9fPWrEGFZ2fNR2urnWpIb+fu9RU/wkY/C6ATcGSMxsWvdiqHe0QT8i9sIQFzGWDqu
         Sf/Dv4oblaomZ2hETEVCx+sMS5IxUbQC5NelkjRMWAtygXpEllUQTLkf3U9b2QsNcwEj
         AjHw==
X-Forwarded-Encrypted: i=1; AJvYcCWoMQC7DbM1BiedP4uk8wspLCF350Ruyo6+zP6zpGcF8buFJqIDF0jNkhtdisJo48fxwURj7BBh41RmWSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAu+eV4664ktYO6HunjA8sxP0yWSynE80q+IYA7gU25zHcPa5b
	zbse3QmbzbC/ICWiNld73eEapogYU/NP/hRDQ/Oyj7ytdHyLaLBlDM0l
X-Gm-Gg: ASbGnctYbwu+6l4dPtlphCWTjMSbMqpB8osLiMJ4N63+tioIQvJzweQ6UspEFlNYr0j
	f8WaKBhbANHyR5pcExNMeY7A+3PEFXl2QniX3pKDEjpMB4F7No92/WEZVLKwiRe38635Ch8qSPc
	2ZLxV4QfxlTFUhd//CTvyLCCl9B1qkJXPIziIrOZ/Uvq3i3K/Hv3UGsLtUeMIqG5uR8P57F8fyp
	cRdqy3rt1WEIxDVtWCR4xNQ636I8bYnt720Cp6hBOrCTAR6vYsS7hX8G8ZKWRfoazRhuALtLKgM
	/P52cacH4lc6HvU17aI/pfosH8B6iJaFTsmED73oVDhUrEuKQOJwmvcSRBYLCxaCLAKaVoJK1TH
	5h22pHWqXjMI132ZmCjgLOhwq0G26l2DILBhqCmJzgNrb0tVR4PsKbB9OBbPciGfzN6fT2Q==
X-Google-Smtp-Source: AGHT+IG1Z5gfPhstZ8Qe0/f0tZQDFllaZrwj1CdOj/WzkKpXcRN9xT6g090i2kZL7HUgri/YALYN1g==
X-Received: by 2002:a05:600c:190e:b0:45d:d9ca:9f8a with SMTP id 5b1f17b1804b1-46206655f96mr10607395e9.27.1758102040358;
        Wed, 17 Sep 2025 02:40:40 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm30833585e9.23.2025.09.17.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:40:39 -0700 (PDT)
Message-ID: <68ca8217.050a0220.81571.9fda@mx.google.com>
X-Google-Original-Message-ID: <aMqCFMC3zeBPyOCQ@Ansuel-XPS.>
Date: Wed, 17 Sep 2025 11:40:36 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250917092807.uui2qwva2sqbe6sp@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917092807.uui2qwva2sqbe6sp@skbuf>

On Wed, Sep 17, 2025 at 12:28:07PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 15, 2025 at 12:45:36PM +0200, Christian Marangi wrote:
> > It's conceptually similar to mediatek switch but register and bits
> > are different. And there is massive list of register for the PCS
> > configuration.
> > Saddly for that part we have absolutely NO documentation currently.
> 
> Please add in the next revision a more convincing argument for not
> reusing the mt7530 driver control flow. Regmap fields can abstract a
> lot, and the driver can select a completely different phylink_pcs for
> different hardware.
> 
> I don't see in the short change log included here any mentions related
> to the mt7530, but I'm not going to search the mailing lists since Nov
> 2024 for any previous discussions about this...
>

Ok will add additional info.

But In short the FDB and VLAN part are very different. The FDB logic to
dump entry add and remove is entirely different.

And the mt7530 itself is full of unrelated function (specific to the
first revision of the mt7530 switch) so I have to move lots of code
around.

If asked I can do it but I have to also introduce lots of extra change.

> Also, let's try not to reach v20.. Please try to collect a full round of
> feedback from people who commented before when submitting a new version,
> pinging people if necessary. You want to make sure that their previous
> feedback was addressed.
> 
> > TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
> > TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
> > TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
> > TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
> > TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
> > TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
> > TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
> > TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
> > TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
> > TEST: lan2: 1588v2 over IPv4, Sync                                  [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv4, Follow-Up                             [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv6, Sync                                  [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv6, Follow-Up                             [FAIL]
> >         reception failed
> > TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [FAIL]
> >         reception failed
> 
> Do you know why it won't receive PTP over IP? It seems strange, given it
> receives other IP multicast (even unregistered). Is it a hardware or a
> software drop? What port counters increment? Does it drop PTP over IP
> only on local termination, or does it also fail to forward it? What
> about the packet makes the switch drop it?
> 

From what they said there isn't any support for 1588v2 (PTP) on the Switch other
than L2 (that I think they simply forward)

I can ask more info on the topic, will also check what counters
increment.

> > TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
> > TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to primary MAC address               [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [ OK ]
> > TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [ OK ]
> > TEST: VLAN upper: Multicast IPv4 to joined group                    [ OK ]
> > TEST: VLAN upper: Multicast IPv4 to unknown group                   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [ OK ]
> > TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [ OK ]
> > TEST: VLAN upper: Multicast IPv6 to joined group                    [ OK ]
> > TEST: VLAN upper: Multicast IPv6 to unknown group                   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [ OK ]
> > TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [ OK ]
> > TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [ OK ]
> > TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [ OK ]
> > TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
> >         reception failed
> > ;TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
> >         reception failed
> > TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
> >         reception failed
> 
> The same thing happens with VLAN too...
> 
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
> >         reception failed
> > TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
> >         reception failed
> 
> And over bridge ports...

-- 
	Ansuel

