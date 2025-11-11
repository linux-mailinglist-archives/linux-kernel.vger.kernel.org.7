Return-Path: <linux-kernel+bounces-895151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DAC4D143
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A64EC4FAD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B88B34CFCF;
	Tue, 11 Nov 2025 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi0zUZRu"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990334CFA0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856998; cv=none; b=UpjVNWE8PihzDJ/kZRMfB735A7Y5oGvoyiC3PvJ2sA+KNUp6NcAGTW/fIMgn4p50vPFp5UVMBfDf4mpcvi1/lk7PbZQSc+z+Ipcgq9Qo7kcTC7DKP8UlVcdOuZd+QRuAV0wgxarMxTuRQ1Jf/rHAkd6NFFOsZY3/HEVyJflo/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856998; c=relaxed/simple;
	bh=JpT5+Q52uFzIEER8lnGSXWYhh/xPIlMmBmAdHm4bm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImLOPJQ2tbF3SdnjDg7zLHC/AHp5fDd4JHFd5aPKRMRa0OJK3xOquiQ+QvdYPtBmqCW4tt4gSb3radTS/fUeJdh3FeZ02M8Cqs/xzWdeIzhoAQFSJx7/HtBLguTTYBQn3/T5nBH0ILqfq9mp+95aL5a83DHLLbbghTBYgV21N9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi0zUZRu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3298502cso240517f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762856995; x=1763461795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFutPZPVcfe1PqaSlwPzNed0vfcXYkJ75DHHS7eesdE=;
        b=bi0zUZRuEPj3GTFlcW3pWJvM9vNMMsZ/L+L5UsKgknKl6FPzxUwgTGALnVztTtoAzB
         qoZVEA1o307Q3US8Q4zMWwcdAXi+e9+aalLqmmgfAv8/V5rvBl4FYVVWm6YbroIc4QHm
         9v4pHT/5TgAf5i/K10+LhqHEachzg8bV0CPZPTENodkNU/uVJdQA7S90kHGiMsK/tWha
         qnxyO0YldmzGR6t+t6lR2JKFF00nWyjxma+XZYa0B0y+Q7gHLLOKmPSU1EH1IiaHaZqB
         /A39ZSpCMzFHiXYfV/7w+oyzV+YMeXSjHnhWYfvbJPv7122YzJAqVD7JxN8DszbHAzI7
         0YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856995; x=1763461795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFutPZPVcfe1PqaSlwPzNed0vfcXYkJ75DHHS7eesdE=;
        b=idUn8qJeqZBylpF4uJ/ZTXY++lbj+gpSDe2/PNnannNqs2D0+v6Lp5FGgXcE0J8Y6d
         5p8XqIfKCbHQIZ2tkMrDR8R4vBe8DlSyn63x3pCw8WRu/UfdTcuhDGJKIPVoNiOqoRUp
         o0ef8GqTdaE4q6rSJR7PVJisnHaRxn1O75XzuhLeQZnY54+7H6V4O6oFYIYayjrQ05T4
         kGwplEvUyD7BdQe9MsbmTdkBhAFqfXFTlNAMPU6+AFB6WPi842wLjvc6IBVUWrvIaisZ
         SD1a0w0Ke2O3qr1FOqBnpa49JmNrgMndP3is39K0H0hyhL7mpK0IRkfXNCDD12MLMBAH
         P4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQDJa4z2dInFdlZ6bS20vhV2/uuqAODy46ZxQHBXCbdq8wmMHPFlDjiImVvxr+xlLCrM3OytAau2FM7vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zV7SbwNFgaIdPRK7uGXc7lJmoUB8nNwyNuBhWe5oIzwVxiZh
	b0Hjp109tbhoKm8hSp75FmAlVTmiUoGe/RZ21SyHj4t0QcuuT9ovuRVU
X-Gm-Gg: ASbGncvRcvVC0Gg0IoFZ/wPAwxqFUl6MOCbbFM1DPkbyjHhsTwHF6/Jji7Slpxjf2dJ
	ys9I6NaiRSn/3hosxSW0jWmiiidlc8bnYK6ElAnsHjdWMRYad4bzOj/Tv0ok8FVpJgfY6MDIHqD
	DhykO+65QEmZ7FX2y2DJ3mpHi52WpOIuqXBVSfe+gLsTzbnF/3DNh7uFu7igelnw0gUWZJ3pp2o
	t+azQ/LU3/9mWu9mW0OV46rAbefP0Zc1Q6JDwgpircSb8L7h7RDHmtxz+aCvhYEEf7MbMmWAjDm
	9fkKddWYx1569zrm05cf4x/QD0SO0PoHTrKEBRk7ARCEeLQdyof3wYDjzn/+dpgMTEmDT3pvC/a
	hx0/ZEXoGUclhrSWwaNFYIEgH0uUH+Qf5meBiypbNdPcNv6fapF7TVdnRkefj3eqmYpZKY1rs+t
	p0QMA=
X-Google-Smtp-Source: AGHT+IGut5UdtaPg5QbZcWX7MUocWV29lStqS7ui1MJFm9Kz4cjLkWJMGOfw9rr3hhx6QpVtMAEIjA==
X-Received: by 2002:a05:6000:26cf:b0:42b:2deb:829 with SMTP id ffacd0b85a97d-42b4285611amr1239922f8f.3.1762856994563;
        Tue, 11 Nov 2025 02:29:54 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00b:be00:7a51:464b:5aed:5e38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm27760824f8f.40.2025.11.11.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:29:53 -0800 (PST)
Date: Tue, 11 Nov 2025 12:29:51 +0200
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
Message-ID: <20251111102951.lkexwdk5btdqdt46@skbuf>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110230124.7pzmkhrkxvtgzh5k@skbuf>
 <CAOiHx==ymTyVbs7UmNH28UgxcfnMQBtt6qA=ZnKvEF3QLe_z8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==ymTyVbs7UmNH28UgxcfnMQBtt6qA=ZnKvEF3QLe_z8w@mail.gmail.com>

On Tue, Nov 11, 2025 at 10:53:00AM +0100, Jonas Gorski wrote:
> Hi Vladimir,
> 
> On Tue, Nov 11, 2025 at 12:01 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > Hi Jonas,
> >
> > On Mon, Nov 10, 2025 at 10:44:40PM +0100, Jonas Gorski wrote:
> > > Documentation/networking/switchdev.rst is quite strict on how VLAN
> > > uppers on bridged ports should work:
> > >
> > > - with VLAN filtering turned off, the bridge will process all ingress traffic
> > >   for the port, except for the traffic tagged with a VLAN ID destined for a
> > >   VLAN upper. (...)
> > >
> > > - with VLAN filtering turned on, these VLAN devices can be created as long as
> > >   the bridge does not have an existing VLAN entry with the same VID on any
> > >   bridge port. (...)
> > >
> > > Presumably with VLAN filtering on, the bridge should also not process
> > > (i.e. forward) traffic destined for a VLAN upper.
> > >
> > > But currently, there is no way to tell dsa drivers that a VLAN on a
> > > bridged port is for a VLAN upper and should not be processed by the
> > > bridge.
> >
> > You say this as if it mattered. We can add a distinguishing mechanism
> > (for example we can pass a struct dsa_db to .port_vlan_add(), set to
> > DSA_DB_PORT for VLAN RX filtering and DSA_DB_BRIDGE for bridge VLANs),
> > but the premise was that drivers don't need to care, because HW won't do
> > anything useful with that information.
> 
> It matters in the case of VLAN uppers on bridged ports. It does not
> matter for VLAN uppers on standalone ports.

Ok, and what would a driver do with the info that a port_vlan_add() call
came from 8021q and not from the bridge?

> > > Both adding a VLAN to a bridge port and adding a VLAN upper to a bridged
> > > port will call dsa_switch_ops::port_vlan_add(), with no way for the
> > > driver to know which is which. But even so, most devices likely would
> > > not support configuring forwarding per VLAN.
> >
> > Yes, this is why the status quo is that DSA tries to ensure that VLAN
> > uppers do not cause ports to forward packets between each other.
> > You are not really changing the status quo in any way, just fixing some
> > bugs where that didn't happen effectively. Perhaps you could make that a
> > bit more clear.
> 
> Right, I'm trying to prevent situations where the forwarding will
> happen despite not being supposed to happen.
> 
> > > So in order to prevent the configuration of configurations with
> > > unintended forwarding between ports:
> > >
> > > * deny configuring more than one VLAN upper on bridged ports per VLAN on
> > >   VLAN filtering bridges
> > > * deny configuring any VLAN uppers on bridged ports on VLAN non
> > >   filtering bridges
> > > * And consequently, disallow disabling filtering as long as there are
> > >   any VLAN uppers configured on bridged ports
> >
> > First bullet makes some sense, bullets 2 and 3 not so much.
> >
> > The first bullet makes just "some" sense because I don't understand why
> > limit to just bridged ports. We should extend to all NETIF_F_HW_VLAN_CTAG_FILTER
> > ports as per the dsa_user_manage_vlan_filtering() definitions.
> 
> Standalone ports are isolated from each other, so the configured VLAN
> uppers do not matter for forwarding. They will (should) never forward
> traffic to other ports, regardless of any VLAN (filtering)
> configuration on the bridge, so there is no issue here (pending
> correct programming of the switch). Usually isolation trumps any VLAN
> memberships.

So we would hope, that standalone ports are completely isolated from
each other, but unless drivers implement ds->fdb_isolation, that isn't a
given fact. Forwarding might be prevented, but FDB lookups might still
take place, so when you have this setup:

swp1.100     br0
 |         /     \
swp1     swp2    swp3  (bridge vlan add dev swp3 vid 100 master)

and you ping station 00:01:02:03:04:05 from swp1.100, you'd expect it
goes out the wire on swp1. But if swp3 had previously learned 00:01:02:03:04:05,
I wouldn't be surprised if the switch tried to forward it in that
direction instead (failing of course, but dropping the packet in that
process). We would be saved if the tagger's xmit() would force the
packet to bypass FDB lookup, but that isn't a given either...

As I'm saying, swp1 can have NETIF_F_HW_VLAN_CTAG_FILTER set due to any
of the quirks described in dsa_user_manage_vlan_filtering().

It might be a moot point because I haven't verified what are the drivers
which fulfill all conditions for this to be a practical problem. It might
as well be the empty set. For example, sja1105 fulfills them all, but
sja1105_prechangeupper() rejects all 8021q uppers so it is not affected.

> This is purely about unintended/forbidden forwarding between bridged ports.
> 
> > Bullets 2 and 3 don't make sense because it isn't explained how VLAN
> > non-filtering bridge ports could gain the NETIF_F_HW_VLAN_CTAG_FILTER
> > feature required for them to see RX filtering VLANs programmed to
> > hardware in the first place.
> 
> Let me try with an example:
> 
> let's say we have swp1 - swp4, standalone.
> 
> allowed forward destinations for all are the cpu port, no filtering.
> 
> now we create a bridge between swp2 and swp3.
> 
> now swp2 may also forward to swp3, and swp3 to swp2.
> 
> swp1 and swp4 may still only forward to cpu (and this doesn't change
> here. We can ignore them).
> 
> Bullet point 1:
> 
> If vlan_filtering is enabled, swp2 and swp3 will only forward configured VLANs.
> 
> swp2 and swp3 will have NETIF_F_HW_VLAN_CTAG_FILTER (as VLAN filtering
> is enabled on these ports).
> 
> If we enable VID 10 on both ports, the driver will be called with
> port_vlan_add(.. vid = 10), and they forward VLAN 10 between each
> other.
> If we instead create uppers for VID 10 for both ports, the driver will
> be called with port_vlan_add(... vid = 10) (as
> NETIF_F_HW_VLAN_CTAG_FILTER is is set), and they forward VLAN 10
> between each other (oops).

I didn't contest that, and the bridged port example is clear. I just
said I don't think you're seeing the picture broadly enough on this
bullet point. I may be wrong though - just want to clarify what I'm
saying.

> Bullet point 2:
> 
> If vlan_filtering is disabled, swp2 and swp3 forward any VID between each other.
> 
> swp2 and swp3 won't have NETIF_F_HW_VLAN_CTAG_FILTER (as vlan
> filtering is disabled on these ports).
> 
> If we now create an upper for VID 10 on swp2, then VLAN 10 should not
> be forwarded to swp3 anymore (as VLAN 10 is now "consumed" by the host
> on this port).
> 
> But since there is no port_vlan_add() call due to filtering disabled
> (NETIF_F_HW_VLAN_CTAG_FILTER not set), the dsa driver does not know
> that the forwarding should be inhibited between these ports, and VLAN
> 10 is still forwarded from swp2 to swp3 (oops).

Is this the behaviour with veth bridge ports (that VID 10 packets are
trapped as opposed to bridged)? I need a software-based reference to
clearly understand the gap vs DSA's hardware offload.  I don't think
there's any test for that, but it is good to have one.

> Bullet point 3:
> And since having uppers on a bridged ports on a non-filtering bridge
> does not inhibit forwarding at all, we cannot allow disabling
> filtering as long as VLAN uppers on bridged ports exist.
> 
> Does this now make it clearer what situations I am talking about?
> 
> The easy way is to disallow these configurations, which is what I try
> to attempt (explicitly allowed by switchdev.rst).
> 
> One other more expensive options are making bridge ports with VLAN
> uppers (or more than one upper for a VLAN) standalone and disable
> forwarding, and only do forwarding in software.
> 
> Or add the above mentioned DSA_DB_PORT for vlan uppers on (bridged)
> ports, regardless of filtering being enabled, and then let the dsa
> driver handle forwarding per VLAN.

But you still won't get ndo_vlan_rx_add_vid() calls from the 8021q layer
if you're under a VLAN-unaware bridge, so it doesn't help case #2.
You'd have to remove the ndo_vlan_rx_add_vid() handling and manually
track CHANGEUPPER events from 8021q interfaces.

> This may or may not be possible, depending on the hardware. One
> workaround I can think of is to enable a VLAN membership violation
> trap and then remove the port from the VLAN. But this also has the
> potential to pull a lot of traffic to the cpu. And requires drivers to
> be adapted to handle it. And would require filtering, which may get
> complicated for the non-filtering bridge case.

