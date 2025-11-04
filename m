Return-Path: <linux-kernel+bounces-884434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C383DC30215
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BD31343E02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32866303A1E;
	Tue,  4 Nov 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZSW0fqxX"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF932298CC7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246907; cv=none; b=jZo5YMXDHLzS6tAy6O4mRye7a2y5h51bt/TOLteAqR1pwJDyZbylXhlg8N/qt98ckywpG6HB2AUDz1K8QC0He3qk4NFMVVrl9ypddSaXi6pzSUgazypYzXWaKakeX0ihkS6Eva4vFzoXQgzoBigLpSVRPa6fUMQYJhL5/DibVaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246907; c=relaxed/simple;
	bh=LEQ/ZUIkD0Ck5NZcd9lI29eGljV5AEUzqZJgxrEsExc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUkdWbSyEXAQB+rT006HTeE5tdTaM1BavDZBFp3PwlG33BzgilckRVJ1XbwWgiKb7Bx6iTUqBa3dKTiLysdViqB5QNYfEsQ4nHA2OqWw+t9FEnBODf6SkgwMlIKt1870tm5s6p8LUvOWsR1rnmrIIYoee53jH3UtGq/3hu8k7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZSW0fqxX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 340844E414F0;
	Tue,  4 Nov 2025 09:01:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDDAC606EF;
	Tue,  4 Nov 2025 09:01:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 217C810B509B1;
	Tue,  4 Nov 2025 10:01:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762246901; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZS4gepCjlUcRiOhvLWXBayriLrC7l2VxbH7bWlj0/+s=;
	b=ZSW0fqxXLnYYH72OUhdAWNjJBojfDnx1oxQC6NkhCkFWLbcQY7Kxeba/QDFrNvJ20Jbj1d
	Vo9fnvQNSzbIuP/j4go1yEAYHjr4F1hqwVRG4/JULTQ8GsGh7TEvqyDdcfvkjyD0MJJXH8
	+GYusObEkNqxtw2XNUJCp8RYvG7DRV1NW9BIuGH37rOuQOLFzaa/YPHZIq4PibDPza/y7R
	S1gD1uXZE6YfkCWe26JrSbipO00NOyMOz/GV0KzpjPxCvEvYbHJyhU+t9QHUMTTDlIquU4
	B5cs+G0QWZGtRNI2NcN3FK3d8kdN4NrAu7Lc+rCqU47oiVcviSruTy8zv0t9vQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 1/3] net: phy: dp83869: Restart PHY when configuring mode
Date: Tue, 04 Nov 2025 10:01:38 +0100
Message-ID: <5936504.DvuYhMxLoT@fw-rgant>
In-Reply-To: <aQnAFxSTyo6SofZ7@shell.armlinux.org.uk>
References:
 <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
 <20251104-sfp-1000basex-v1-1-f461f170c74e@bootlin.com>
 <aQnAFxSTyo6SofZ7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6208107.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart6208107.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Date: Tue, 04 Nov 2025 10:01:38 +0100
Message-ID: <5936504.DvuYhMxLoT@fw-rgant>
In-Reply-To: <aQnAFxSTyo6SofZ7@shell.armlinux.org.uk>
MIME-Version: 1.0

Hi Russell,

On Tuesday, 4 November 2025 09:57:59 CET Russell King (Oracle) wrote:
> On Tue, Nov 04, 2025 at 09:50:34AM +0100, Romain Gantois wrote:
> > The DP83869 PHY requires a software restart when the OP_MODE is changed.
...
> > @@ -797,6 +797,10 @@ static int dp83869_configure_mode(struct phy_device
> > *phydev,> 
> >  		return -EINVAL;
> >  	
> >  	}
> > 
> > +	ret = phy_write(phydev, DP83869_CTRL, DP83869_SW_RESTART);
> 
> So if dp83869_configure_fiber() returns an error, that doesn't matter?
> (This overwrites its error.)

That's a blunder on my part, thanks for pointing it out.

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart6208107.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkJwPIACgkQKCYAIARz
eA7K5w//aatB6IbWqJgwOSSrTQ6DnEuJ0N5zqk7SmCrlm6hVjrqpbUeKpsI8mqXo
Vjf4vOyigLTgXFFoS7BmIq0E+sgB7F6ZhQi/pIlsh4oCB4TP6/d2wq2YrW6JAxy9
nszWoPcPsjpXrhyRENA4jzfE161XPyzKgu63X/qQ5M15pJN/jDfN7in8NpB9QTH/
OjQClLNq3yQu72tynx3UnpP0P4mRX7YodPYaOGRXxVNeNDw12utrT9I9KrsFgOhE
PxXX19ughDPTX+ZEWNeZORdi/NW0AUEjmsvC6dXH3wmvhXGDh8qlxe5DuzxsHM5P
2ljpOR8Tq2kUZgEal9KDpuFmbTzPHWRtJlitLs9ZPmOImI+Shg18CBPoBeTx0efq
Bt+qYLJlKbCvyZE85e8gqrGGuLPntNl7juyNwdDYEqYPgUOdEtitBCeqnF4VmEgh
IhAj/YeqrBpNAflNOf0MPIVMni7BT7YSaCACp1QbKjEYe8nLjwra4R7gIhjaHXUp
eQq2YlIgTf1WJHUB9oDukWAtN72E/MpejlWBHwl7ek6u4Kgh8cQ8jaLN0YBePC9+
7WnHXK+lXzNlHy2/Y7sK+ExVDumSCgcHx75sanMsgbRGDtVDK8f6s7OIHM1k8+Fs
5Ud/HA2O8eC0Vab7W6GDArqk6GcG+9DO+WA2cwKUYY3XEQK6y8E=
=3f7a
-----END PGP SIGNATURE-----

--nextPart6208107.lOV4Wx5bFT--




