Return-Path: <linux-kernel+bounces-762673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85988B2098D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4A3189A6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362822D29B7;
	Mon, 11 Aug 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jB7ocoBy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335A2D46A9;
	Mon, 11 Aug 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917429; cv=none; b=daZEE4HD+D1VJ1uxPSUGK65VnM4R7JtzuqrTbc8S+m2UfRkKEjN09uYSunoo3Sc29iWQPjLwdk7emEbysOfezvu9AX8p+ezctQkyB3fMJOjTU0/LnrRAD/LYNKVwyUX0XsWvIaxydCuWuoMPz/1es3BIvDWnkNJ5Pg++goU1eBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917429; c=relaxed/simple;
	bh=lVkf+PItwfKe/9taFbPMgz8DF8wc1+E4sk2PS8MIVuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYxp3RCNWhWsbqD2X9OdXgK0KsUroo5vvq3fRxoqaMEqcapz/MlksAhRVoEyfeE2G6JBPIeqstVuOQSMQvgANWv7WpZLrfHclHpeLVY+zRijYaIjkDqtmsoSxufHKhv1+HbeHwUUB1bk7jtl6v1dAHLjuupw/EQDnsO4jeA2Hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jB7ocoBy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=zqifTpDaQhWEUMpUlGKro4a6sMf2oQed5RETrkmaP4A=; b=jB7ocoBy0jyhkKMHmY6LE+HubP
	c4Mr/18h967h9VLLwinMbOjQI4AVp+uWE3NZ3O/7k4HjyrqN050E+B3EXHuRkACnGbqvtr1goE0VR
	LqGupZiZbYisc6eOX21769LVJR25mbO93JBN5rgDOi/r1AddDoIDaBhtXwk9nfaeR8+fGFmDnZkkb
	iqxW0Opt8IQUCQtx4IdlPlyOlbsb1Fbs+8pivjENBioDb7ou2lQDMHWKBVq7poKkdVDRL2wuIPLTw
	pGzD+4n2F2cx6HNx+IpxM4UcG9sd1uG584j+G3t5cGrFp7ON3y2rJhVySpEfaCBEG7fly0we3ofo6
	NLvsSDTw==;
Received: from i53875a0c.versanet.de ([83.135.90.12] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulSBb-0001JS-NF; Mon, 11 Aug 2025 15:03:35 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: amadeus@jmu.edu.cn, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 naoki@radxa.com, robh@kernel.org
Subject:
 Re: [PATCH 1/3] arm64: dts: rockchip: disable display subsystem for Radxa
 E52C
Date: Mon, 11 Aug 2025 15:03:34 +0200
Message-ID: <2784232.uZKlY2gecq@diego>
In-Reply-To: <20250811130108.462673-1-amadeus@jmu.edu.cn>
References:
 <3125650.687JKscXgg@diego> <20250811130108.462673-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Montag, 11. August 2025, 15:01:08 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Chukun Pan:
> > What actual problem does this fix?
> >
> > For example we also enable on-soc iommus all the time, because they're
> > on the soc and don't need board-level properties.
> >
> > The "display-subsystem" without users looks mostly in the same spot.
> >
> > So I do expect a description of what problem gets fixed that this needs
> > to be disabled.
>=20
> Disable the display-subsystem to remove this error log:
> [    1.382440] rockchip-drm display-subsystem: [drm:0xffffa3985873555c] *=
ERROR* No available vop found for display-subsystem.

ok, that makes sense then

> I will improve the commit message in v2. Do I need to remove the Fixes ta=
g?

Nope, please keep the fixes tag

Thanks
Heiko



