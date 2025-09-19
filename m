Return-Path: <linux-kernel+bounces-824317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B08B88A44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6216EDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A421CFBA;
	Fri, 19 Sep 2025 09:47:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398711990C7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275232; cv=none; b=Eq2gZ62TzFcBLYBiXnndHS2/udqrMiyKAH81AjR+wHiYtD/UB3uVnDL2mYVvp3R5pZT2nm2CQMMb0Z6SzG6coRWAZViwNeItlQMnxO8kBq1UtvTL4VBQVSHr0+cu5Fo/yYh9HsDuQE8JAfgLEgEZumgV2tg5WRqIDgt57DZojiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275232; c=relaxed/simple;
	bh=clV/2usYaINZmF9NL7aE9dLqGU/w4dBhhYjTesQwgCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6Rxh1vstJbNlRd/9XwzWRMJ3P+me3bLJd6TyS3c7Cq7bbpME97bVMp4WrN4tBMy0k6cnZ5fOEJBujsnqc4ANEUtuMIkJR110sacZWik1LdVwHyQUgyR7klkrYVoF5hVmOsTSRg6rr4vagDM/USjl1I0WdXpll9nopd4M7IBlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1uzXhn-0004Ap-6o; Fri, 19 Sep 2025 11:47:03 +0200
Message-ID: <1159aa58f8a0ab69f9327a98ae3fbb973f6ee36d.camel@pengutronix.de>
Subject: Re: [PATCH] arm: gen-mach-types: don't include absolute filename
From: Lucas Stach <l.stach@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 19 Sep 2025 11:46:59 +0200
In-Reply-To: <20241114130021.2802803-1-m.felsch@pengutronix.de>
References: <20241114130021.2802803-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Russell,

can I ask you to kindly reconsider this patch? The generated header
ends up in various packages, not just in compiled form where the
comment wouldn't matter, but also in its raw source code form.

For embedded build systems this mostly affects the debug packages that
carry the full source code. More general purpose distributions like
debian ship this file in the linux-headers package as it's part of the
kapi and they want to allow out-of-tree module builds with the header
package. All those distributions have to jump through various hoops to
make those header packages reproducible, while this patch would be an
easy fix from the kernel side.

I don't think the input file name carries any real value for any of the
users of this header. Especially now where mach-types is essentially
static, with no substantial changes in the last 8 years.

Best regards,
Lucas

Am Donnerstag, dem 14.11.2024 um 14:00 +0100 schrieb Marco Felsch:
> Don't include the abosulte filename into the generated mach-types.h
> header and instead make use of arm64 note. The motivation for this
> change is Yocto emitting a build warning:
>=20
> > File /usr/src/debug/linux-raspberrypi/6.11.7/arch/arm/include/generated=
/asm/mach-types.h in package linux-raspberrypi-src contains reference to TM=
PDIR [buildpaths]
>=20
> So this change brings us one step closer to make the build result
> reproducible independent of the build path.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  arch/arm/tools/gen-mach-types | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-type=
s
> index cbe1c33bb871..fdc4805b9d98 100644
> --- a/arch/arm/tools/gen-mach-types
> +++ b/arch/arm/tools/gen-mach-types
> @@ -24,8 +24,7 @@ NF =3D=3D 3 {
> =20
>  END	{
>  	  printf("/*\n");
> -	  printf(" * This was automagically generated from %s!\n", FILENAME);
> -	  printf(" * Do NOT edit\n");
> +	  printf(" * Generated file - do not edit\n");
>  	  printf(" */\n\n");
>  	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
>  	  printf("#define __ASM_ARM_MACH_TYPE_H\n\n");


