Return-Path: <linux-kernel+bounces-772339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A4B29186
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCAE1B263AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159D1F91C8;
	Sun, 17 Aug 2025 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b="bu+CI9fu"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A71D86FF
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755404999; cv=none; b=EX5HzLsoa0OnczYRdyrR8JAr0v+fKU24R9dbH0cj+8vptjs3/5Im90a7/aLcJpKnroYN52zgN0AXoBgkm3KsIdSjGUk+d/+szYh6mwloF/EpB5anotDsX3nKM8Kkc2J2YsY2SLNiXatCfDSPjqwv84R6q4KA/ziBb6AS00raU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755404999; c=relaxed/simple;
	bh=dJsoDn9ejss6xZxq1+PO6yZOjAfrmBEGOzoE1pFfCOY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mkVsuseiJeVQLVirtOsmRWHfZh8xr59EBRBApHuHbF+cZCBrUmd7AJtiXH1eJHK58DZwULH/fTY05EC3OsyLFIhKYs5tiyx4Yoh4LfQNzwARtie/sMIlue8sGqx6Sg8s7znbLykwq6KjSXGHQHe12gUkwxLUUb2QlX6hcQ7Pa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io; spf=none smtp.mailfrom=coresemi.io; dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b=bu+CI9fu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=coresemi.io
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e8e2d2dso1868058b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 21:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coresemi-io.20230601.gappssmtp.com; s=20230601; t=1755404998; x=1756009798; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7tOnFcQoia7OLIfjY0GXgnbZUBsSDQdwxwR729Y/e8=;
        b=bu+CI9fuicYGql7eXCSSIHIhAnefx+/szl65SWoI3A/eRgLojNwzGAZnNuNp4KfYeb
         5nsFX2jTA79wYBcpGrBDT9J4z1pVvTPc8V6RBUNFd4U6DDlQq/jPWfosMEcQqx/6UNd/
         uO+O9RP6NIRdJRgHEQas79AvX4WjG0Z8wLxoz9joWS+k7x/RFwRkRWvsj5GaD50rrIcS
         b9+tRO688Ch3A1WZlazCSTxWdJvysUbusuZfNfWGkK1PL4hZKqPInIUY6rTn4IxKcEdq
         5U0nr0Gl3lOvb36HYFw7wqdyX5oLf73jVvDWMvlu2rKpUxZq44IpmOJVA9K/oS9NpLgV
         /HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755404998; x=1756009798;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7tOnFcQoia7OLIfjY0GXgnbZUBsSDQdwxwR729Y/e8=;
        b=U8J+BwDra/WLmFjIxiEUkY20qcgU2PTdpoxDw+y4YEP2g+ROoBmtGlfx2KRCbX2k95
         wtc3yTNl6QmbXnWRqCojF9UYwluXtwzbPfaRqjFU9UwXmheYke4607dEVa9l0tsTJjpP
         BsJi28q/OjwIrQsmg231SjvpNy1gLEdyxS1Ca1OV8YKIRzgL8GebTBfQkEKY/eieDWHV
         Ct1l8H2wA8KAOqspEgSZZBQsvybV21o07zHSzMa++qYz7kYmCnWWCkysyniSIsGr5/Eu
         qVFSntmWhz3OhXn6C2AEvynaoZ32TL3CI3hBx7b0VazDrTUnagvXawyfR11zhOYBQ3Wd
         JgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN7qsATGXpfQR5yjc1SEz1giLIXPF8SVYAEZXSGczTXx3kixef6BhopgasN7jSraysPGOWNX7nqGBTi3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQliBSCyv6N0VJHBPp5Th5VOxavqZVl+LUnoW7qY67QG9JVuNF
	4r4E8h6KGdwhcKuXljkTZWAC8NEP/+LXMsUIX2ZmSu6Gd+3kXo8osrRaf/j3I0kpUtk=
X-Gm-Gg: ASbGncsKXbUvAc4L76rxKutYaWkGLxIiak5Lz7BjmPEqsch/H8NPhohJCxVZ4pOcu9+
	WVUnkOHphi1D5/KkzQG6o5u4N98wjpf1GvEu/XT0hq6KapSeggRlINvxRNVHYUTlzAs85lM07tF
	XhDGbIB37dOieBPQBbNtmOUXLNeDZz0w5JuhhflBclXGJWpEAnnY9VwCc8zXmQYcOKlktv7OqZD
	VOACpJGcM0CFfSSRpOcO1jRz/PEVukarTZv7vgmP71aMyY+nciBc8dTDPKyAmsZMy/Lg9g6eIb9
	+zJ9K1Cd2waUMdRHPdAedvJT7mEjQXbbFyktGpaLF0o6bE06MiPbp3D4h14xtFQqk8u+fX2UkyU
	bl+VyS1MdLZ8JFwiQN8Qzv0KHgsDy1p8ueoLm2TQRpgFMRi127/R7+DCzLUIK7Lnc0Q==
X-Google-Smtp-Source: AGHT+IGTkulwbSKlMNKTgkK2+N/a2tNWqVdcaDc/+0IBx3cEbIkK7JZwpjqo8gKvMk5mXlc40TvNCw==
X-Received: by 2002:a05:6a20:9143:b0:23f:f7ae:6e24 with SMTP id adf61e73a8af0-240e6311cc0mr6485220637.29.1755404997708;
        Sat, 16 Aug 2025 21:29:57 -0700 (PDT)
Received: from smtpclient.apple (p121132.f.east.v6connect.net. [221.113.121.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73a0a7sm5134883a12.28.2025.08.16.21.29.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Aug 2025 21:29:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
From: "D. Jeff Dionne" <jeff@coresemi.io>
In-Reply-To: <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
Date: Sun, 17 Aug 2025 13:29:42 +0900
Cc: Andrew Lunn <andrew@lunn.ch>,
 Rob Landley <rob@landley.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "D. Jeff Dionne" <jeff@coresemi.io>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC855B2C-37F3-4565-8B6F-B122F7E16E25@coresemi.io>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
 <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
To: Artur Rojek <contact@artur-rojek.eu>
X-Mailer: Apple Mail (2.3826.700.81)

On Aug 16, 2025, at 22:40, Artur Rojek <contact@artur-rojek.eu> wrote:

The MDIO isn=E2=80=99t implemented yet.  There is a pin driver for it, =
but it relies on
pin strapping the Phy.  Probably because all the designs that SoC base =
is in
(IIRC 10 or so customer and prototype designs, plus Turtle and a few=20
derivatives), the SoC was designed in conjunction with board.  A bit =
lazy.

But they all have the MDIO connected, so we should add it (it=E2=80=99s =
very simple).

Cheers,
J.

> On 2025-08-16 02:18, Andrew Lunn wrote:
>>> Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both =
MDC
>>> and MDIO pins connected, however I suspect that nothing really
>>> configures it, and it simply runs on default register values (which
>>> allow for valid operation in 100Mb/s mode, it seems). I doubt there =
is
>>> another IP core to handle MDIO, as this SoC design is optimized for
>>> minimal utilization of FPGA blocks. Does it make sense to you that a =
MAC
>>> could run without any access to an MDIO bus?
>> It can work like that. You will likely have problems if the link ever
>> negotiates 10Mbps or 100Mbps half duplex. You generally need to =
change
>> something in the MAC to support different speeds and duplex. Without
>> being able to talk to the PHY over MDIO you have no idea what it has
>> negotiated with the link peer.
>=20
> Thanks for the explanation. I just confirmed that there is no activity
> on the MDIO bus from board power on, up to the jcore_emac driver start
> (and past it), so most likely this SoC design does not provide any
> management interface between MAC and PHY. I guess once/if MDIO is
> implemented, we can distinguish between IP core revision compatibles,
> and properly switch between netif_carrier_*()/phylink logic.
>=20
> Cheers,
> Artur
>=20
>> Andrew


