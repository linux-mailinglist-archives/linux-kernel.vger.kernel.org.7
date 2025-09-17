Return-Path: <linux-kernel+bounces-820339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE7B7C418
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E18463A07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDD32D5CA;
	Wed, 17 Sep 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVBdaj0v"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89B30C63A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101296; cv=none; b=IBuNnfs808cJy1iN6fqduQMkgcaSUVuMIaY4BIGFeiktP6pcTIQn9ODt29qKuQ2Vdwz+0P8DmuaIBqHa2vJmjOJrXA1zt1NfhBfke9u0IZuJov4WVOFPo8ETQUgCTRt9M6SVJamk+oU6ragxHLnfTK1DgqRzAYiGDbWHbgPzmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101296; c=relaxed/simple;
	bh=BvQk4uuZWQQsyS0bgCtnD8Q2EwGdUDl2hTU4IVjcj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5prTmSPp9j7PmbgMqroK5AePyVO11ix0yv8pE6fsZu52QILUXbMHsaujIGQAopl79iT0EXvq/tozPPQa/PnFFy5p1ncxNwsB8j8ZWhsKM1hgwyF/2CoSESSNQH8m2A+wc4mcFDH4pwMWaTIxjJs66HQTD0UHNeUPM19pmklGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVBdaj0v; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b00f6705945so90661766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758101292; x=1758706092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o12PIdH5jrLINYaBDIAtrFJQyb2acUWsg9n32mRR/5k=;
        b=JVBdaj0v/hbdVqguRjn5NCfyLNTxtb92X6WozyadXPvjm1nA2NMlGS90yPHrzAmhga
         1Lyoabc15pQmnhheTJOk4wcAHWmO+CgdNy6s8LEFAZvzGZekBr6sdob1FCrxJ7rh0ZmX
         I9Srq9Hzkn6SxPg666qvtIiJ2eWYT9jVlM2ZngQcMGRjjPIQCaKglmuPDHglI0ExRBP9
         KYp4XiqR+xoVDPRtx8+s1ob69xsjHM/BffPrSGs1fXHZnXGflZOHliwsH2F7UWtsAa5s
         ExtsxTARDKVsO+Sav4OiaCVvP+EvkcVDh23Pa4bmIEXVVulzMmXXuEnHc8VpFgvTI/4H
         8TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101292; x=1758706092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o12PIdH5jrLINYaBDIAtrFJQyb2acUWsg9n32mRR/5k=;
        b=lf4vtEl3VZ6N0uERfOGXtZQsQMStXMpkpe2QOoD3G1Dkmr6fCBFqnlB3MfNy0c3ddA
         i9/zW3taCflmwwH3GtTsL2gb92zaqtWrZbn8DfiNgN7+RE99IMHja+52p1iuWDS84Dxt
         N6WPq0nzuN/Ota/HdmKGaTb8WMkNJaiIku4L3XLB/I20vD+DQ4v4z5mYBphgGvJr4DUn
         4cIO8U387/5pCXt9bKMzh04wPXqN3IOLiHCFrpczMRWvtxw4EkhczkROT9zhRviZ+6AI
         bBkbuRK1t4pgzkctiaXI/G0hAT4/LUd5ckMOazJ6PDlvW+MpVuatggr0kEe8eKJN6ooq
         sPug==
X-Forwarded-Encrypted: i=1; AJvYcCWosjMLhNDt55FcfjR6RLWGRjcusL1h2ZmpWlmnzn5LKAl1eZnNdOe0d2+Lv221MPqp+ciSwFJRR6Mhhf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOPhKMFcURKUlcSKZfqJ7U8VOKHUFqoUe5VtGZO1G8xotOP1O
	q2/f6/094c+K9XutLISb0Sz3geGquP4pAzHx4BDtYv2xmuKHHkD+X7Bc
X-Gm-Gg: ASbGncvO2PwXf9zudh9X3rNltv8O3xE/p4URHVT7baeJ8D64urrcn88V1w6fZ2KAZrc
	pYWX/F5nxdVokIZ4tCsPi9KYbMqAkHGtBHqdm8boZYgT4/RMPSQhmzOSXH9IYweiP8ASTjvk3z2
	OuZROvj+ks259qY1eqhL7bqSTHz781fwm1d9LvvJnBhWCq8gElbD0HrI8JISZIWCC2OFCL4zgPR
	Jfmoz4tH4K0k2h6TVZiSyaNubBGVfevH2i4Mqv4cw2+z2S3wHrCEsXMM/U7NAsK0i5C7cRIPci1
	oIVTfC8gWFWzGpKp6E3W8Rg0hJoyBIhM23RzRk2QXNjQB5vDJZH9ZPs1E/rooJn7tBpWUkzl+4X
	mpvm8iEeDAUtg0IQ=
X-Google-Smtp-Source: AGHT+IHvszT87WzP63vcOaexO/pLxfMWcRX57JUYYOxi6z+V5togEaPi0QjDbwzVUWpwnuisJKwZww==
X-Received: by 2002:a17:907:7f9f:b0:b04:7b5b:850a with SMTP id a640c23a62f3a-b1bb5598e03mr85457666b.4.1758101292043;
        Wed, 17 Sep 2025 02:28:12 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1c40fe2df8sm74103266b.18.2025.09.17.02.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:28:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:28:07 +0300
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
Message-ID: <20250917092807.uui2qwva2sqbe6sp@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>

On Mon, Sep 15, 2025 at 12:45:36PM +0200, Christian Marangi wrote:
> It's conceptually similar to mediatek switch but register and bits
> are different. And there is massive list of register for the PCS
> configuration.
> Saddly for that part we have absolutely NO documentation currently.

Please add in the next revision a more convincing argument for not
reusing the mt7530 driver control flow. Regmap fields can abstract a
lot, and the driver can select a completely different phylink_pcs for
different hardware.

I don't see in the short change log included here any mentions related
to the mt7530, but I'm not going to search the mailing lists since Nov
2024 for any previous discussions about this...

Also, let's try not to reach v20.. Please try to collect a full round of
feedback from people who commented before when submitting a new version,
pinging people if necessary. You want to make sure that their previous
feedback was addressed.

> TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
> TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
>         reception succeeded, but should have failed
> TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
> TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
> TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
> TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
>         reception succeeded, but should have failed
> TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
> TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
> TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
> TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
> TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
> TEST: lan2: 1588v2 over IPv4, Sync                                  [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv4, Follow-Up                             [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Sync                                  [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Follow-Up                             [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [FAIL]
>         reception failed

Do you know why it won't receive PTP over IP? It seems strange, given it
receives other IP multicast (even unregistered). Is it a hardware or a
software drop? What port counters increment? Does it drop PTP over IP
only on local termination, or does it also fail to forward it? What
about the packet makes the switch drop it?

> TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
> TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
> TEST: VLAN upper: Unicast IPv4 to primary MAC address               [ OK ]
> TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [ OK ]
> TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [ OK ]
> TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [ OK ]
> TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [ OK ]
> TEST: VLAN upper: Multicast IPv4 to joined group                    [ OK ]
> TEST: VLAN upper: Multicast IPv4 to unknown group                   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [ OK ]
> TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [ OK ]
> TEST: VLAN upper: Multicast IPv6 to joined group                    [ OK ]
> TEST: VLAN upper: Multicast IPv6 to unknown group                   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [ OK ]
> TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [ OK ]
> TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [ OK ]
> TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [ OK ]
> TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
>         reception failed
> ;TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
>         reception failed

The same thing happens with VLAN too...

> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
>         reception failed

And over bridge ports...

