Return-Path: <linux-kernel+bounces-737244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00215B0A9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DAD5A4D69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6E2E764D;
	Fri, 18 Jul 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wlirihv7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66A2951CA;
	Fri, 18 Jul 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860852; cv=none; b=Zk64IYI+VBMZf0+waOMK9hSNx95fUUCKMgKoMaMdi0LklNNQM5g8IV4fNqYpo8BMaBTc1Bnnv3qFpR4ojCPcqtcfoWoJ4fXxyCe/GhpzWRtd/QPtE1KZY8dcnQpkz4PMsUHYGV+TZoSw6XvfSp6pXPbRqvYKz+3rvCMu49u7Czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860852; c=relaxed/simple;
	bh=U0E/UkXN9tZDVC+Cvo2L0bymR6SulDUIwFpdsD2rypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNKWUZRRnzXMPMYbhrL944J6d7nI238s1Vjq5gfGVmw7pNUdlq6h0mjoJHpvlAfVit3PcTNeC2a1jmdJ26SXdMtYKWzHM+bulMpyPEa7bElSZVcrSbop8BfHjQe2IDCI7Bb7nMuT66OUB6c1AsKZ2RCcTnOZTN9yY/qeCBCXO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wlirihv7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=YSPaaQKD+1KQwE0RoZaqBfGqciSCheGL4nggpnlyPHk=; b=wl
	irihv7J6I0SLdkRjKy8NvcQcyBKNBcFfGm9BxhDwNRKoOd9xRwUDTbrxMTMT1+uzSjAlkcByMLc37
	1FZG1tjoPTw0PBHCXGXHE/tBnQldrKWr2s5qmaF5AD3E+FB/iGmXPQ0luHxn0L8/H9ggfdgEE6rIw
	UOXdspGlKsOBbtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ucpAz-0021D4-Ci; Fri, 18 Jul 2025 19:47:17 +0200
Date: Fri, 18 Jul 2025 19:47:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christoph Stoidner <C.Stoidner@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"upstream@lists.phytec.de" <upstream@lists.phytec.de>,
	Primoz Fiser <primoz.fiser@norik.com>
Subject: Re: [Upstream] Re: [PATCH v3] arm64: dts: freescale:
 imx93-phycore-som: Delay the phy reset by a gpio
Message-ID: <07a0c325-03f5-4b5d-b6e7-9477aec4e5ad@lunn.ch>
References: <bf0eb48fc72f4b0abbf62077c2f1fe4438579746.camel@phytec.de>
 <967484d9-4165-4b75-bbb7-a203c36e8beb@gmx.net>
 <517be266ebc3b55da53372a76a139245f8945cd8.camel@phytec.de>
 <5afa6d62-4a3f-4c28-8165-363075ac36d8@lunn.ch>
 <a948b903766a82897e5fc17a840ab40e29f5eda4.camel@phytec.de>
 <8e448625-b4ad-4bf1-8930-6fecdedb1d8d@lunn.ch>
 <78ec24d09d129d52d3442f6319cf1ef5b6ce7f3d.camel@phytec.de>
 <739f93d0-4cb4-4f1a-8792-84502d4beefe@lunn.ch>
 <626bca58-e481-4d6f-9bb7-252c040f4b3b@norik.com>
 <ad5e7450c5cf3a2f9a5d3c23f7219eb08be31062.camel@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad5e7450c5cf3a2f9a5d3c23f7219eb08be31062.camel@phytec.de>

On Fri, Jul 18, 2025 at 05:33:05PM +0000, Christoph Stoidner wrote:
> On Di, 2025-07-08 at 10:35 +0200, Primoz Fiser wrote:
> > Hi all,
> > 
> > is there something holding up this patch?
> 
> I dont see any blocker.
> @Maintainers: If there is any missing/blocking point, could you
> please comment.

This _might_ be broken for NFS root. But that can be fixed when
somebody actually has a problem with it.

	Andrew

