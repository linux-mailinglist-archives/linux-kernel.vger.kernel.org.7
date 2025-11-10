Return-Path: <linux-kernel+bounces-894288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DFC49AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB33A6FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045582FF172;
	Mon, 10 Nov 2025 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/cMdCJC"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66919CD05
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815692; cv=none; b=akiJZB0NDm89y3SDTQZhQgo5+X7nGGacxw7CWzC4pP41+zMVFN9y968TTmamJAc4YCGWoCEPUhC5fyMgjJx2pPJENh5dKa2oI4eKBfyaCW2SvEFs/b1fB9iYNU/j18AsC/s7rLGJVfztY8tSNLvI4BHBZ+RL185HYUkNGbi9Hy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815692; c=relaxed/simple;
	bh=YDyt0ignDie+Sp7OJmrOTRTs8PU5wIhTXPeVinvnHyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVjwumikSTO+dvx7W8kxj6VbMEJBizpEfNJZU4CRW4pvSRIAt9xl/Es+Bg2l0aLiRBHpp0UfNbM/8+ORzdXyk/kAhxDI5UB8gf82SBYEs7cxM63b0Nflk9KVegBqiw3H8CeOVtA9Tp5cd/khCcjWGX0EaptJdjbXevz48DgCQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/cMdCJC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c84bf326so299966f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762815689; x=1763420489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35lZlJg1c3UneSfoREWljih+bHJcaa9Q1ULrC104ugY=;
        b=j/cMdCJCwsweH1iQOsmXVWeYsjw5UmMCOIBjEQYevKtSEDY1X9LeEXRfR4UjwOMFSJ
         G2NxZyypwxoRMJGWzPmD/EA3ULHcvc44JbAsvMhKXBM5hWW3oaO2b43R7bIayDi3q246
         UqCBhTpyzv5pe918YGcMBeCnU8VG2j3T2Mo0T6VuUMdHAQONfaiax83JxvijbUXpzkSn
         /GHcnbGbvWCspfk2YRfsFPXQ1MOUW/xRC7pVc3ifkYnK1J3GCrryp1wY567DSQ6PKHhC
         agIiD28GwA6t1pC3Xbx/660RL90N0DQoFbqIb6Y/vnoS5PE29DCB3KiK9UWjMBlf+fIj
         RSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815689; x=1763420489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35lZlJg1c3UneSfoREWljih+bHJcaa9Q1ULrC104ugY=;
        b=vhLRQBHJJ2hgeMmSBk4vL2IGvqhF/Cv51AqFsIAsyX695pAQKqXZ8dKJzP+uNq4xsb
         Uaj3sRqkAkEjtx+sSWJIEjgoIClZQuUJnQq+v51Ytw3GID9DbV5ZmGcX4Xr5xZZ5+a6f
         QP63qUTKbj/YP1Zg2wpWa5pInpO/sG6kNFnCS7as+iGldkgW5IUdf4F8jr8SiStqwXPZ
         jeWvkqyQ4Xt4Znepn6C63MAQLpnpeioXPq7ba94IanilkqR88+Qkl/x3BayftNIo+Q0x
         SISKH5B8KeZkKYr993EhRdffaB6opDpT46vIpHNWmMXjl6SdZ3Zq5icKGZyjq/KXJPPG
         WCDw==
X-Forwarded-Encrypted: i=1; AJvYcCUw2ZNxZnmQrkL/iz9gFLKcAgg3rjRirqGdfRrxcrb/PBrNXhfbrgjRv4q4ysqBArZ8uRnpVxCzXB/1GBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7t29bhqTtxAK6rMmaAh8A/dpjUD7wOCp1H5CLxEB69y1I0N3F
	7we+Nd/DTxk2CQg4j7jEq67vcn4N1ngvsTdf/7pPtN4xfHfrMBQWTyU5
X-Gm-Gg: ASbGncvOFh5qU2EGHqxTa9wzNZsIcbb8y0bNN5GhxYnnZoLEMwyAN7zoIStVY1Lkqqz
	m1qvRf4xX2NtQqZw82eqOdjHAjAWz/Xcyui1fvwjsbQ1P47FYx9wkCK9eqnSf69rkPXOkiWITYC
	pjiJ/M5ZL0kUXgAg5AK8blWjDmsGzp0/cxiAo1Fy3GbdtBwMOS6qJTDYZPY7rwq77yqAKWG/9xw
	OlRst0HHe30becudsnYjfgpxhemAIqOlvQ3R/RncFc568v/U41XxIsJN6rYaAL7vNyhpC/qmffm
	1Qdz0CbuilrxG2TPXKqA36HNf6/MyoL+HeazUqH/n7STWZYn5NPHXht6TCvNZ61pp6zPiH9NGyG
	s2W1rw4Ys5ZQFYYwi+3aYWRLrEON3DEEBzekjcMk95pQ6W2cSEI139ngwlVp8P1HDcYMp
X-Google-Smtp-Source: AGHT+IEQma9G6zyLe5B5+knpc1yWfr5aR5BU3vkO3qP7bT+V9QSLPfBL8FC6/0wnkteYkj7c71E+qQ==
X-Received: by 2002:a05:6000:22c1:b0:42b:3e20:f1b1 with SMTP id ffacd0b85a97d-42b4284b840mr542714f8f.2.1762815688455;
        Mon, 10 Nov 2025 15:01:28 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00b:be00:af04:5711:ff1d:8f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b330f6899sm13053908f8f.21.2025.11.10.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:01:27 -0800 (PST)
Date: Tue, 11 Nov 2025 01:01:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: deny unsupported 8021q uppers
 on bridge ports
Message-ID: <20251110230124.7pzmkhrkxvtgzh5k@skbuf>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110214443.342103-1-jonas.gorski@gmail.com>

Hi Jonas,

On Mon, Nov 10, 2025 at 10:44:40PM +0100, Jonas Gorski wrote:
> Documentation/networking/switchdev.rst is quite strict on how VLAN
> uppers on bridged ports should work:
> 
> - with VLAN filtering turned off, the bridge will process all ingress traffic
>   for the port, except for the traffic tagged with a VLAN ID destined for a
>   VLAN upper. (...)
> 
> - with VLAN filtering turned on, these VLAN devices can be created as long as
>   the bridge does not have an existing VLAN entry with the same VID on any
>   bridge port. (...)
> 
> Presumably with VLAN filtering on, the bridge should also not process
> (i.e. forward) traffic destined for a VLAN upper.
> 
> But currently, there is no way to tell dsa drivers that a VLAN on a
> bridged port is for a VLAN upper and should not be processed by the
> bridge.

You say this as if it mattered. We can add a distinguishing mechanism
(for example we can pass a struct dsa_db to .port_vlan_add(), set to
DSA_DB_PORT for VLAN RX filtering and DSA_DB_BRIDGE for bridge VLANs),
but the premise was that drivers don't need to care, because HW won't do
anything useful with that information.

> Both adding a VLAN to a bridge port and adding a VLAN upper to a bridged
> port will call dsa_switch_ops::port_vlan_add(), with no way for the
> driver to know which is which. But even so, most devices likely would
> not support configuring forwarding per VLAN.

Yes, this is why the status quo is that DSA tries to ensure that VLAN
uppers do not cause ports to forward packets between each other.
You are not really changing the status quo in any way, just fixing some
bugs where that didn't happen effectively. Perhaps you could make that a
bit more clear.

> So in order to prevent the configuration of configurations with
> unintended forwarding between ports:
> 
> * deny configuring more than one VLAN upper on bridged ports per VLAN on
>   VLAN filtering bridges
> * deny configuring any VLAN uppers on bridged ports on VLAN non
>   filtering bridges
> * And consequently, disallow disabling filtering as long as there are
>   any VLAN uppers configured on bridged ports

First bullet makes some sense, bullets 2 and 3 not so much.

The first bullet makes just "some" sense because I don't understand why
limit to just bridged ports. We should extend to all NETIF_F_HW_VLAN_CTAG_FILTER
ports as per the dsa_user_manage_vlan_filtering() definitions.

Bullets 2 and 3 don't make sense because it isn't explained how VLAN
non-filtering bridge ports could gain the NETIF_F_HW_VLAN_CTAG_FILTER
feature required for them to see RX filtering VLANs programmed to
hardware in the first place.

> An alternative solution suggested by switchdev.rst would be to treat
> these ports as standalone, and do the filtering/forwarding in software.
> 
> But likely DSA supported switches are used on low power devices, where
> the performance impact from this would be large.
> 
> While going through the code, I also found one corner case where it was
> possible to add bridge VLANs shared with VLAN uppers, while adding
> VLAN uppers shared with bridge VLANs was properly denied. This is the
> first patch as this seems to be like the least controversial.
> 
> Sent as a RFC for now due to the potential impact, though a preliminary
> test didn't should any failures with bridge_vlan_{un,}aware.sh and
> local_termination.sh selftests on BCM63268.
> 
> A potential selftest for bridge_vlan_{un,}aware.sh I could think of
> 
> - bridge p3, p4
> - add VLAN uppers on p1 - p4 with a unique VLAN
>   if refused, treat as allowed failure
> - check if p4 sees traffic from p1
> 
> If p1 and p4 are isolated (so implicitly p2 and p3), its fine, and if
> the configuration is rejected is also fine, but forwarding is not.

Sounds like something which would be fit for
tools/testing/selftests/net/forwarding/no_forwarding.sh.

