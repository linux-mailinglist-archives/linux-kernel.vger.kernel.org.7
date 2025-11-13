Return-Path: <linux-kernel+bounces-899973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6075CC5939B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D9CF34F49D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517EB346E7C;
	Thu, 13 Nov 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsOAxkeI"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263B30AAB3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055070; cv=none; b=AwR3NdpK8QHCVDqz7E/QVJScuJkZfuCrpl7493wmMOgz2f2UyKomGFej7t2tjyTOdTBMEIrYQyrDjCyoDzn1v5VYn/c73xcFD2gZKscXicmZsGSluLOk3/I5taLyTbmfIh5Q38z4j8Ll0EfFD9qRdczsZ2599WKQUy77wYqsNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055070; c=relaxed/simple;
	bh=XAtOyJI0WQ3sgK78fW2Uwi7DxHqSxXhyLy1fwArqA+I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NKuNBlzrMwNE6ZmQUq2j9Y5bX8QrIJJz8lgFrZARxhXGHjJLX8+FEnTjbASPv/UcLOFpv4GRTPRfAcG+3I9FLp4uxkWkyYOFz3y+BtjiBH6gvxW0S/85r4tKiScH74wcsJTvAM0RgXSzHRJVjgXE2KwSnnVR/88xJcr00fxdMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsOAxkeI; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787f586532bso11470127b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763055063; x=1763659863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K7+oD30MonOt9TxD+/IIU01PfOYIQejOmUfS0Y1z+3A=;
        b=KsOAxkeIV3tribzISi2W6VFkHuEcSSNldz35T5qel/ZFG1EE+f00hoUizn4ez8Qq34
         dlZxKY3vZ2Q3FczAo8mrE7Cf3dAip1qAy9Klpb/GxNYAPMJNGsmVABlgzPtkJgYyfKL4
         sKDZWXkXkJTJglE9q9qC6bqvp0ava0dNe71SfO24uLB5H/Mdpn2Pn8uxu2lp9DgapX9j
         dQNs7r6k981DxC1IDm9/C+HNdKV0BOKSuu6YGX3r1u/CPt1wi8yu39ckfRIl/sjD5Zv5
         25O5VYaL24ySGnGtvl6RxHbP+lhB3NWXUDh3JNfgBUE0KC3RhV5lS54Hc9j5+PmKK67F
         xe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055063; x=1763659863;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7+oD30MonOt9TxD+/IIU01PfOYIQejOmUfS0Y1z+3A=;
        b=oR3gAz/i3bAavGH+vILsaVpNDP5eSE0p+8u83HgRSj2bPvr+2TMd6Am78j/Gp0dRVa
         swfhphazhRxvu3OvJDCQVqppJrqLD8UGLIO35LqtEHL2xQwXAHPDHhwNv6sZliLrY6oR
         VsH9D1jRdUnqqcbl0+ilbnF6gjWo8+Y4yh86RYVuUmhwBCrovH8hJ3CGHWlebYp2UvXl
         Fb0mI4UJ5MQL/RUun/UY81AXND3xcYi4PE5sHT2rCI+bEU9/SEpMjC0P8BAQkJdbFz+I
         gqjLTv0X9QeajWqD/0wS1MIw5zk2EQOgnCHyDYXE0q8d3omDtQ0/prDrHez2OGjv+jT4
         CHDw==
X-Forwarded-Encrypted: i=1; AJvYcCXcthiB+054eK0qAn7u6zS5zuukvUc0NNC3wVbNDHqo89XRURPtdLCkjj0gGryWOnG4yD1NhYHaRrA5lFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBp6ZLCZs93Uc3GBIw8+Hij+oFx2lDtPpcGQs46YrIMYDlxDQr
	zfgD9TZGgX31AWcYrkiyoglQaFlR7kZrqv1XwFNVE+YqbSTOImluBnk6p0KTiVq5rV/JkZzh25Z
	Pjcg2lp6/cpooM5p1iG4GWCZ+ODl/2Gs=
X-Gm-Gg: ASbGnct0Uwq1x1BpIGBrWvtXw2WOmxqRTAZc9NCwN1nLzt6Aq9co71IVYkBEkx0S1Rm
	PAwsAeM+GFe81IuvZw7OjIy+wiI1QN03Z4ffgY/t2e6ogy0HA0Thi3Txpdm/jClqx/nAHQ1RE39
	DSiWtrPjvLQiyyPhXnVDJIELUYOIErE1F3qoORRRy60PWEA6VAdoyMv97G4ILfNHdY4w/fRRos7
	UrFxAMmaDGF9/vGFruJu8KM8EjaNN8GkvgrUifjV+cckY/OyIpyFk7+JJvp67qTLv/JGdkVYJnx
	4sG54CC2gujG5dnZfT79rrstnw==
X-Google-Smtp-Source: AGHT+IFsidDvuOCz+MG4jnFkcxt8JfyZwP35D2o6eA6gkXKCxY0urqtYVEMTdk14UB4A4mWqHiIo5vbUe9K3bheP8cA=
X-Received: by 2002:a05:690c:6f8f:b0:788:c07:2518 with SMTP id
 00721157ae682-78929e66819mr2085127b3.31.1763055062543; Thu, 13 Nov 2025
 09:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Date: Thu, 13 Nov 2025 18:30:51 +0100
X-Gm-Features: AWmQ_bm6MhuRBoEbeEn02QJrMla9RuqDmDIlbn0Yt7eze9EuiHC6qN1NFtE2XVU
Message-ID: <CAN9vWDK=36NUdTtZhPMu7Yh15kGv+gkE35A93dU0qg01z5VkbA@mail.gmail.com>
Subject: RTL8127AF doesn't get a link over SFP+ DAC
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a RT8127AF card from DIEWU:
https://24wireless.info/diewu-txa403-and-txa405 .
The card is detected just fine:
[125201.683763] r8169 0000:08:00.0 eth1: RTL8127A, xx:xx:xx:xx:xx:xx,
XID 6c9, IRQ 143
[125201.683770] r8169 0000:08:00.0 eth1: jumbo features [frames: 16362
bytes, tx checksumming: ko]
[125201.688543] r8169 0000:08:00.0 enp8s0: renamed from eth1
[125201.715519] Realtek Internal NBASE-T PHY r8169-0-800:00: attached
PHY driver (mii_bus:phy_addr=r8169-0-800:00, irq=MAC)
[125202.277034] r8169 0000:08:00.0 enp8s0: Link is Down

This is what ethtool shows:
Settings for enp8s0:
        Supported ports: [ TP    MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
                                2500baseT/Full
                                5000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
                                2500baseT/Full
                                5000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Auto-negotiation: on
        master-slave cfg: preferred slave
        master-slave status: unknown
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        MDI-X: Unknown
        Supports Wake-on: pumbg
        Wake-on: d
        Link detected: no

and `ip a`:
10: enp8s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
fq_codel state DOWN group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
    altname enxXXXXXXXXXXXX

And that's it, the link never comes up. The 10G Mikrotik switch on the
other side sees that the module is inserted on its side, but doesn't
show any change when I plug in the RTL8127AF.

It works in Windows 11 and it also works with the r8127 Linux driver
downloaded from Realteks website:
https://www.realtek.com/Download/List?cate_id=584 :

[129318.976134] r8127: This product is covered by one or more of the
following patents: US6,570,884, US6,115,776, and US6,327,625.
[129318.976175] r8127  Copyright (C) 2025 Realtek NIC software team
<nicfae@realtek.com>
                 This program comes with ABSOLUTELY NO WARRANTY; for
details, please see <http://www.gnu.org/licenses/>.
                 This is free software, and you are welcome to
redistribute it under certain conditions; see
<http://www.gnu.org/licenses/>.
[129318.988293] r8127 0000:08:00.0 enp8s0: renamed from eth1
[129318.997092] enp8s0: 0xffffd49ec9140000, xx:xx:xx:xx:xx:xx, IRQ 137
[129319.421629] r8127: enp8s0: link up

ethtool with realteks driver shows something quite interesting:
Settings for enp8s0:
        Supported ports: [ TP ]
        Supported link modes:   1000baseT/Full
                                10000baseT/Full
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  1000baseT/Full
                                10000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 10000Mb/s
        Duplex: Full
        Auto-negotiation: off
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        MDI-X: on
        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000033 (51)
                               drv probe ifdown ifup
        Link detected: yes

auto-negotiation is off, even though it's enabled on my Mikrotik
switch. "ethtool -s enp8s0 autoneg on" (or off) on the realtek driver
succeeds but doesn't change what ethtools status shows. "ethtool -s
enp8s0 autoneg off" on the mainline driver does fail with:
netlink error: link settings update failed
netlink error: Invalid argument

So while I have no idea why things are not working, my best theory is
that auto-negotiation isn't supported (properly) and the mainline
driver doesn't support disabling it.

Thanks
Michael

