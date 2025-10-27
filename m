Return-Path: <linux-kernel+bounces-870887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A70C0BE82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF7D189B30A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319C2D7DDA;
	Mon, 27 Oct 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="QuQ5dThh"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6701C701F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545300; cv=none; b=Pvy3TZufwnqEd4wZHLoRbuL6XcR42fLyjqdpF2U37sW4QfZXPtjcmy43QyYJSbpMUOrz7QZQkiW6YBQG+lIH3yZgiA4dFtX51s5WSnB9QQaNZfcytfkA7iBxL7xXSrOX59Vcpc+2pdb+C82a0nCDHn5Rir6xuD7jTa8v4j/MURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545300; c=relaxed/simple;
	bh=5XT8CJzUJB6nvVvVmvtxIz6ke4BVepzM/qAnFjWabAA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plk1Cz0riRXXPNeka00ClFrjv1jmfZ6LUKXPkOhdM2T65AV+4kp92jL5YuhpXex9i2tw5MZ/NkjJezGeAlbetbWKfQbWAuTD425NDPcWyO9XD/tMxdtUcv7M+5AGAT2hIYrZLXYRQOqqDMFvS1tLXBtYE2szV+8MTFCjKggCL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=QuQ5dThh; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761545210;
	bh=l3+MYw1gSrGd76gzuuq7j2y+q9z2WnobGN51l903Alg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=QuQ5dThheXeI0UvbraPlrrU59bBZ3xKZvcypL54LpAG0JItBTB8P1QhUNZqhKt+gi
	 uy2hkidR0S7GMXhvf3aJ/er030A4X1d/sU+L4Hzgkg98EWLaoLbwR0+70b4w5rY2px
	 X2clxeg2+WTI0JWmntSGBcIUbPp0uIMRd7EFR4Wc=
X-QQ-mid: zesmtpsz8t1761545207tc173d1ef
X-QQ-Originating-IP: kaW+7dLJIqioSezBmW/uoXxbeOrYpMqkQA962FFA75o=
Received: from = ( [183.48.247.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 14:06:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17316863097272151893
EX-QQ-RecipientCnt: 12
Date: Mon, 27 Oct 2025 14:06:46 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <751AB506001CBF5F+aP8L9hBdTaVEko73@kernel.org>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net>
 <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
 <aP8KqZ1hlqfQVPii@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP8KqZ1hlqfQVPii@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MKzYG8XJzx27j0WWC65akscbY+LZtJglnWV8yCkpERTiSlc6AP1TKEu/
	k3+9fQJd0y5KIcL9UmcRn+IJhBnLkplgVGxaU/Z72cT3+r/j3/1HzKBnVX+L6aJZPBTHKGM
	4h+BzlINtHDE5zVMv0avvivCetlqpnNwFLW7LlYmcbHUOJTfi+dGoghFa2to0P39H/Z4XiZ
	fZw2jULovbnvakmh3wz+g8WOD+I4nJ0Nvnsrjyvyoc36IOG/rYep6y1lbwLerumyDGmV1B/
	xbGjAF/Ljs6IaeupMUeF1nNHatiKfptuuP/xyzOFOYZ747l522H2Vifl+bqlcbEXOnraPw4
	3MIoJS073nt2M1nLza8usjqPgdZgTH3VNm4dKDNv8liyFM5qAou5U5DcAtosrieHm1fwPMd
	xnme1Fx/bSfWrAVeG0Vrrf+aPtMNUOtaLnRkzimRE+16q1Fu/8YNT+1WZDcnUAJyXlEPK8Q
	31Hzut6Gu85ajobu9M8T1sYNJ7rtj6OBtH3co1VQUjhbYnPIGqX0rsy8h1JQZZvMeSYavK7
	kcjdLBVpz4HOk2yDsTGCfvJ/LxSI55qig8+am2SXCtUSeqmBjvF0/otk4XPgKSTFzfvDNPJ
	v8q2hsbd8CwOeZNSz5KoBzDicEMXkWcx2NZGrXQn1bBFPbBrEW++6KmnfwVHwh5A5C6LsRl
	mBfjOifrgDhPxPHuN74KCUZmCWKOlqibnOKqG11cs6yEyMS9ReVfP1hHRNh23frwx39Pbyk
	hZUzNrVzAtcO9n0Mh7Nk5Q0od/E0nkGBuFe76oTOG9pUVjgiTBtERB9VNNgH+WB7hf0mXb1
	rQCTw2lTCbYgWplpGDZaXQVWiMZoUpgtZyw3BYwfHonRc7r7NzIIKlwvPQU0mLwpCruIxuv
	Wx46tgqDnBt3t40FLzkwAhZA0E6ZgvYP8du15co1ony85fw28kca1tgMVvrfFIPAK1Ystt4
	7StzsZ+Kh38Cg6Vxa2YxnvDa/h6WF1x9XwgvupS/14OlVRNJaXE8SdXCld/C+mwG4P6HjkU
	i8m3jj1D2YjKyZRynDgbnUuo2bVvNgdIxeR6mYZog4aLa+aow+PoqqN5A6X7ZvaWrRDsJhp
	c2ik/5JTEXQnyUNnumRTo8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Mon, Oct 27, 2025 at 07:01:13AM +0100, Aurelien Jarno wrote:
> On 2025-10-27 11:20, Troy Mitchell wrote:
> > On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
> > > This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> > > chip, which is commonly paired with the SpacemiT K1 SoC.
> > > 
> > > The SpacemiT P1 support is implemented as a MFD driver, so the access is
> > > done directly through the regmap interface. Reboot or poweroff is
> > > triggered by setting a specific bit in a control register, which is
> > > automatically cleared by the hardware afterwards.
> > > 
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > > v2:
> > >  - Replace the "select" by a "depends on"
> > >  - Remove outdated Reviewed-by
> > > 
> > >  drivers/power/reset/Kconfig              |  9 +++
> > >  drivers/power/reset/Makefile             |  1 +
> > >  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
> > >  3 files changed, 98 insertions(+)
> > >  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> > > 
> > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > index 8248895ca9038..61c16f3d5abc7 100644
> > > --- a/drivers/power/reset/Kconfig
> > > +++ b/drivers/power/reset/Kconfig
> > > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > >  	help
> > >  	  Reboot support for the KEYSTONE SoCs.
> > >  
> > > +config POWER_RESET_SPACEMIT_P1
> > > +	tristate "SpacemiT P1 poweroff and reset driver"
> > > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > > +	depends on MFD_SPACEMIT_P1
> > > +	default m
> > default m if ARCH_SPACEMIT?
> 
> As explained here, this is equivalent:
> https://lore.kernel.org/spacemit/CAJM55Z_BzfRo5aKf2VrneTymSizwDQq6OfMK_LNgyoGjp43K8Q@mail.gmail.com/
> 
> But I can make a v5 to change that, if it's the preferred form on the 
> SpacemiT side.
I missed that conversation. Just keep it!
> 
> > Or default ARCH_SPACEMIT?
> > I believe that reboot and shutdown are actually essential functionalities,
> > so it might make more sense: default ARCH_SPACEMIT?
> 
> That was already changed in v3, following a request on v2:
> https://lore.kernel.org/spacemit/CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com/
Thanks for your link.

                        - Troy
> 
> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

