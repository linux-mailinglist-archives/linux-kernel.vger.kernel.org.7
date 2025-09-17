Return-Path: <linux-kernel+bounces-820388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC6B7D23A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0A43BCD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADA345754;
	Wed, 17 Sep 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jm0V5c7E"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05A21C9FD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102740; cv=none; b=EoquvpeGwYGa51ZxsNNsP9y3HBpRFt9GRYEWPvLv+J5cCCzzl7XZsLlNkQ3vW7inXdto2PmcWXAqg5iuAyR56szh2L46lDRrRrahJ7xD0TqnSyNsMH18SYJIMdDD2jR5r70xZyVyEJHjahHzC+1fSDaB+LT8C3D3PrqZpYi1S2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102740; c=relaxed/simple;
	bh=yRVgBxhsfRXWMvPI/gNFnwX8qmyCe94NzBNJGzx88+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urdZo0OgfwEZrofR6MHuN/2cF039MuLs6oeBGeQ/VJVd2T5wSJ39cP56L1GaFmfBA4CQvcUWbLoucpJGWqOLhHBRYTT/xzrnzrPxcJsVN5I7NWyzJtbJwCbVkC/uep5HLK44v3buZ90qd1NELF05xlCVmay8lVvGD9L0mq+8SFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jm0V5c7E; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 90B521A0E8A;
	Wed, 17 Sep 2025 09:47:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 655AC6063E;
	Wed, 17 Sep 2025 09:47:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 462A9102F1A2F;
	Wed, 17 Sep 2025 11:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758102433; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yRVgBxhsfRXWMvPI/gNFnwX8qmyCe94NzBNJGzx88+w=;
	b=Jm0V5c7E6m16Q7z2YqnrJqGWCeDmHnBNA9vbh7MSRz3bi3eZ9yJ+tDsAZowIJ2hzPPFB1n
	AAmH3/NWJERfum+f5j9ahyNxGZ5ky5aeQFwyfibqwt4283S5efjsFs1+IR/jqlPJZad6LH
	iNHMVfKMqjZ+5j0EUMByfJI8zW3mOl9r0vLHrcGGPSugZyzjNMKlfCARkFUvAPNJSKeo0g
	sMyappaxT8ZFDdsSYHyA6OwiiXKUUVMzz8k45ILFpxbraCi6ilUXgb1rI68lxXrIKf/yIO
	wAoWkIbEAbqWUrJ3sQmBPnUmMqbTk6pnnf3MUWUgiFm3eBF8qn7xT+OUnhM47g==
Date: Wed, 17 Sep 2025 11:46:55 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
Message-ID: <20250917114655.6ed579eb@kmaincent-XPS-13-7390>
In-Reply-To: <20250916165440.3d4e498a@kernel.org>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
	<20250916165440.3d4e498a@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 16 Sep 2025 16:54:40 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 15 Sep 2025 19:06:25 +0200 Kory Maincent wrote:
> > This patch series introduces a new devlink-conf uAPI to manage device
> > configuration stored in non-volatile memory. This provides a standardiz=
ed
> > interface for devices that need to persist configuration changes across
> > reboots. The uAPI is designed to be generic and can be used by any devi=
ce
> > driver that manages persistent configuration storage.
> >=20
> > The permanent configuration allows settings to persist across device
> > resets and power cycles, providing better control over PSE behavior
> > in production environments. =20
>=20
> I'm still unclear on the technical justification for this.
> "There's a tool in another project which does it this way"
> is not usually sufficient upstream. For better or worse we
> like to re-implement things from first principles.
>=20
> Could you succinctly explain why "saving config" can't be implemented
> by some user space dumping out ethtool configuration, saving it under
> /etc, and using that config after reboot. A'la iptables-save /
> iptables-restore?

I think the only reason to save the config in the NVM instead of the usersp=
ace
is to improve boot time. As Oleksij described:
> I can confirm a field case from industrial/medical gear. Closed system,
> several modules on SPE, PoDL for power. Requirement: power the PDs as
> early as possible, even before Linux. The box boots faster if power-up
> and Linux init run in parallel. In this setup the power-on state is
> pre-designed by the product team and should not be changed by Linux at
> runtime.

He told me that he also had added support for switches in Barebox for the
same reason, the boot time. I don't know if it is a reasonable reason to ad=
d it
in Linux.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

