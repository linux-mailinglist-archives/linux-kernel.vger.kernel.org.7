Return-Path: <linux-kernel+bounces-859891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22ABEEE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E93A4D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D1024291E;
	Sun, 19 Oct 2025 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="EBetrH7M"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995723E229;
	Sun, 19 Oct 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760914839; cv=none; b=uxGgtT135bjnd0dr4ozh/9JzhuKJI9SpCN4eIX8HLSd00im5FpUJ3s6Fq0iI4RaizLXpTjvOHNMmJpARGdUcCGhpOuQugbGB5UbzFbjj5DkDSPNRutxiDKvy6T2/0LfR4hq4lwvdsn05OcojL69mWwTVvQdRN64h7Wr5hFaPqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760914839; c=relaxed/simple;
	bh=+NhEcWg4u0nKsTNjVJnm6EV0ePgVBJTd5Cm9zyp0Adc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmKztpafpHMK7Pv7xdwI1vWHm9fZJ48481UiR3NDVdINZJX5e1jVL3VYYjv4snamPgsWQ+zaiS4Rt9vTN/tgZOqzC590krCClOTm/Hrn/AY2qXSCmIJkVNMdky8o9+4VvZzNWwi9AOIKV6jbxazvaHAnQHIu9up84R0A38XpPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EBetrH7M; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760914827;
	bh=YL+/KBVBt7ybXFRGcP41DFJKQfuf10A0qEbi6RFqyFg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EBetrH7Mpg1i1zFMo8JaQBs+Cjt3hHOhLBkGvVSs7waTLYIOzg9cqMNtrXUZAOat7
	 zJ6rFaO2+KA/ZfRSDelAVV5cxNxEfrycVHUI2CFYGZD7Ch9+/IWskmiCxCwukNem8F
	 kPTVGo3/XVioCSuH67PQZZ2g1yW2DO2UQiHCf3I8/e56hejAHIGNjEVj0rI4rISro+
	 v2C8BN0ZR9tVobn3cUyCLbBKF47AqKlXWyabKdhiEXCD5r4NN84ic+0Q7Wn5RYmFsn
	 JwKp9Eipxql3mS9Ut+hwivy5RLaCu9IezcvHUCFkyA+LCdt27GTR5DluXFH6cSx011
	 KpY+zwcV3Impg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0C68E6CA42;
	Mon, 20 Oct 2025 07:00:17 +0800 (AWST)
Message-ID: <13566a08eeaed313ad789abcae1920d9b00483b0.camel@codeconstruct.com.au>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from
 round_rate() to determine_rate()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Masney <bmasney@redhat.com>, Iwona Winiarska
	 <iwona.winiarska@intel.com>, Joel Stanley <joel@jms.id.au>, Maxime Ripard
	 <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Oct 2025 09:30:16 +1030
In-Reply-To: <2025101721-twiddling-huskiness-4852@gregkh>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
	 <aMatZAX6eFI1RmDH@redhat.com>
	 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
	 <aPEZSY6RC-UVclxN@redhat.com>
	 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
	 <2025101759-runner-landing-374b@gregkh>
	 <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
	 <2025101721-twiddling-huskiness-4852@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 09:43 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 17, 2025 at 05:57:44PM +1030, Andrew Jeffery wrote:
> > On Fri, 2025-10-17 at 08:41 +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 17, 2025 at 04:52:37PM +1030, Andrew Jeffery wrote:
> > > > Hi Greg,
> > > >=20
> > > > On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> > > > > Hi Andrew and Iwona,
> > > > >=20
> > > > > On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> > > > > > Hi Brian,
> > > > > >=20
> > > > > > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > > > > > Hi Iwona, Joel, and Andrew,
> > > > > > >=20
> > > > > > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > > > > > > The round_rate() clk ops is deprecated, so migrate this
> > > > > > > > driver from
> > > > > > > > round_rate() to determine_rate() using the Coccinelle
> > > > > > > > semantic patch
> > > > > > > > appended to the "under-the-cut" portion of the patch.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > > > > >=20
> > > > > > > Would it be possible to get this picked up for v6.18? I'd
> > > > > > > like to remove
> > > > > > > this API from drivers/clk in v6.19.
> > > > > >=20
> > > > > > My (strong) preference is that Iwona applies it, but I'll keep
> > > > > > an eye
> > > > > > out for any unusual delays.
> > > > >=20
> > > > > This patch wasn't picked up for v6.18. Any chance this can get
> > > > > picked up
> > > > > now for v6.19?
> > > > >=20
> > > > > I'm hoping to get this merged so that we can remove the
> > > > > round_rate() clk
> > > > > op from the clk core. The clk maintainer (Stephen) mentioned this
> > > > > work
> > > > > in his last pull to Linus.
> > > > >=20
> > > > > https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@ke=
rnel.org/
> > > >=20
> > > > Are you happy to pick this up directly in Iwona's absence?
> > >=20
> > > Why me?
> >=20
> > I figured that would be sensible since Iwona historically sent you PRs
> > for the PECI subsystem.
>=20
> I did not remember that, sorry.
>=20

No worries.

> =C2=A0 The MAINTAINERS file does not mention
> this at all, and it lists many other maintainers that should be able to
> take this patch:
> 	$ ./scripts/get_maintainer.pl=C2=A0 drivers/peci/controller/peci-aspeed.=
c
> 	Iwona Winiarska <iwona.winiarska@intel.com> (maintainer:ASPEED PECI CONT=
ROLLER)
> 	Joel Stanley <joel@jms.id.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
> 	Andrew Jeffery <andrew@codeconstruct.com.au> (maintainer:ARM/ASPEED MACH=
INE SUPPORT)

Iwona currently appears unresponsive, as mentioned. Joel's stepped back
from maintaining the ASPEED bits as of earlier this year; I worked with
him to add myself as a maintainer there, hence the last entry, and now
getting in touch with you.

I can apply the patch and send you a PR if that helps, if Iwona doesn't
respond in the mean time.

Andrew

> 	linux-aspeed@lists.ozlabs.org=C2=A0(moderated list:ASPEED PECI CONTROLLE=
R)
> 	openbmc@lists.ozlabs.org=C2=A0(moderated list:ASPEED PECI CONTROLLER)
> 	linux-arm-kernel@lists.infradead.org=C2=A0(moderated list:ARM/ASPEED MAC=
HINE SUPPORT)
> 	linux-kernel@vger.kernel.org=C2=A0(open list)
> 	ASPEED PECI CONTROLLER status: Supported
> 	PECI SUBSYSTEM status: Supported
> 	ARM/ASPEED MACHINE SUPPORT status: Supported
>=20
> thanks,
>=20
> greg k-h

