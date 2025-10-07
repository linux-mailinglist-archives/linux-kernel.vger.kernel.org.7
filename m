Return-Path: <linux-kernel+bounces-844351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D40BC1A59
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CA0C34F990
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82A2DC783;
	Tue,  7 Oct 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AphBgvdy"
Received: from mx-relay09-hz2.antispameurope.com (mx-relay09-hz2.antispameurope.com [83.246.65.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1071EB5FD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846027; cv=pass; b=FEFEBTjP1vzmo1w92EXP8S/nc2jPXU6U5oxrVLlsDyK5SwrIIkBmKZMMULzw3iXfDOg7/IyQQGzKy6OrYDBvN/PRczKzBRC3mQyqA4d9YcAUXe8T970CYzSLmyL+EXnZZNCieGUnoDf2BqEKViDnQafLJ2ZIkQkGWmdYM/66D4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846027; c=relaxed/simple;
	bh=WmSuK2KgeZZKjS3RAHylOHbDs/ZtMx32hEmXNAnI9LY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NI55FDGjgeL3vJPfBsS9sCE1195Q2pO0MmgBB0D8yaemLcTn4SY2a5ol6aiutpm6Iqp7wl1DWSst/EtQz/bsDCX31wxTGrkuZ2Hwtos0xMdnyWiImiFIyGokWNDoEBbXxh6r8NLgQv7knY+MtFUZ3FbIqXSjf0pepTjzWbyL+HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AphBgvdy; arc=pass smtp.client-ip=83.246.65.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate09-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=DFvOQZa24W/AnKkgvYTUsj2VAl9wPNaKiNLZsjze+Cs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759846008;
 b=juleUW9tEOYT4hWbYrPlfa9kh5kYm+lKFNlBZIMqmw8hY8CJAL8Afy+XDlwESnRKNNr4G9zp
 Wdk0RTgRYa2KQvEmY5uzPGznOxcqkKYzZV9GGZF8vKqc1doc9gNOdZOJMUInsI0xXDdEwNMdbUZ
 2HZ8Jb9KiNlAk+ikcJWLheqawLbolj1pHMo1msGfO98zTO9YX3iGiui0GWq++e/a8U3C6z6LP3t
 sP6tIoUE6ZeG3CgcSsdv1rtypws9qNAvV7p0SaHoceJkVr7oiiRsoTYY+GL+t0VmNklDsYXtOEe
 sFwDiq4qt/eiuPvNK8N9PSzpGPP6oZ+5n5cuh47E3LqlA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759846008;
 b=q4zaNsgWGeU4hWHVYcDhOC8Ma/hoDU0JR7fLXIeaDDo5uzRnLbCiVfuNpDjXqufKg5Yqdo3M
 Z9J8Huabe/cbicuRQwsiEHPWl9KulgzjFaMAv6UKwIYcWS6kdw3EhTnKUqcp3nfvQIWDSLLnEVk
 7J7TloX9SJdVdLVkgwWkwTOcwQDgCU1A7TK7dpW5SXBVWl6bD88ZRfu2zGBEd2C5SuSQTlpK+m9
 +cfQz82s/I2HJMCiz2TOBx2d5sJIMENTkgGbJGV/yAxRFbS0Db8GYzAUKWEo0JBVBI+noXnvixf
 rcPTiRRddbrzwuPmYxlrPEvERxsNAIK1Eyhj8BtETMCjA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay09-hz2.antispameurope.com;
 Tue, 07 Oct 2025 16:06:47 +0200
Received: from [192.168.153.128] (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 55104A40A92;
	Tue,  7 Oct 2025 16:06:37 +0200 (CEST)
Message-ID: <09aa8945c41cdc0c518bddedf8d3489c1e521661.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/2] i2c: ocores: replace 1ms poll iteration timeout
 with total transfer timeout
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andi Shyti
 <andi.shyti@kernel.org>,  linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Tue, 07 Oct 2025 16:06:36 +0200
In-Reply-To: <7dbefacc-3ce0-47ea-b521-102320f49420@lunn.ch>
References: 
	<1eb320b6b7d3a12e62785893ea68c4d16aa2560d.1759838476.git.matthias.schiffer@ew.tq-group.com>
	 <7dbefacc-3ce0-47ea-b521-102320f49420@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay09-hz2.antispameurope.com with 4cgycF6Td5z2102K
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:a4c114696472c606f0b88d2546581029
X-cloud-security:scantime:2.016
DKIM-Signature: a=rsa-sha256;
 bh=DFvOQZa24W/AnKkgvYTUsj2VAl9wPNaKiNLZsjze+Cs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759846007; v=1;
 b=AphBgvdy+tC1wPLjVJZnjRsNM4YTM3eXjkm3tz3PP22ohg6DBw988iyYjC1uF0TUeJk7vh7N
 ZhnPRIxI4LFd7BeyjfiakS5yOGg0wHm1C+1HnObu5cGOXdzWaJ3ger96QNCEZ1eDse7uAbfBgI8
 AD2t6QvdFog82PbCL/1cGHMgNESSNzZ50cQcmsyYMuYxP9BzFgprC+O61qXfz20Y4RREiShXRQn
 P4fWYRWsAM+zWULskHAfTKS9VWPasKtZPbJ6flDnA+8p8ttosyw1hc6nmJl0osQZ9fDrCcsC2UD
 HrMVfE4FRZ+G6vUEnsqq3zlWgWw595Tyee6F0pob3REBw==

On Tue, 2025-10-07 at 14:34 +0200, Andrew Lunn wrote:
> On Tue, Oct 07, 2025 at 02:09:24PM +0200, Matthias Schiffer wrote:
> > When a target makes use of clock stretching, a timeout of 1ms may not b=
e
> > enough. One extreme example is the NXP PTN3460 eDP to LVDS bridge, whic=
h
> > takes ~320ms to send its ACK after a flash command has been
> > submitted.
> >=20
> > Replace the per-iteration timeout of 1ms with limiting the total
> > transfer time to the timeout set in struct i2c_adapter (defaulting to
> > 1s, configurable through the I2C_TIMEOUT ioctl). While we're at it, als=
o
> > add a cpu_relax() to the busy poll loop.
>=20
> 1s is a long time to spin. Maybe it would be better to keep with the
> current spin for 1ms, and then use one of the helpers from iopoll.h to
> do a sleeping wait? Say with 10ms sleeps, up to the 1s maximum?
>=20
> 	Andrew

Makes sense. I don't think I can use something from iopoll.h directly, as i=
2c-
ocores has its own ioreadX abstraction to deal with different register widt=
hs
and endianesses, but a combination of spin + sleep is probably the way to g=
o.

Best,
Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

