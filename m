Return-Path: <linux-kernel+bounces-670601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1FFACB1E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6CE16D744
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF4A238145;
	Mon,  2 Jun 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OoiQ0HZv"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F623717C;
	Mon,  2 Jun 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873403; cv=none; b=f1zLCSynr8K8DsmZazz6XRTulcRKWpZMYyh8FoMdct3R2gLoczU6c4IEqB8u3G3D3UxRmmFknGd6TVCmgCkmfiWstSbvf6igMPDj2xDZzoVXZ/DYPR8588q24tB2z+pLBd6VY1TEeX8NqK8tG/NiXkCMmFQ07Y2Wu96TM259jY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873403; c=relaxed/simple;
	bh=PxCJhN4QIn0+J0O0hiZ/KtHe75Qkfx4OQ2FM+kfOu0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXFe5xBTzcAorcD+//Nn+IU1dkXuGxp2PgqSgFVelX62oZTHO89c+jWrGuVr0S86FgvypPTW0ln7NWwWy0DotN2L3PVEmLsBqJ+B22Jp8tuDKLIZf7krqxNjmhQ7QT2ubdGwzvLlvSq+QFNe4837CHtnyRdNjUFtDIy2B9iXydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OoiQ0HZv; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B6DE51F96B;
	Mon,  2 Jun 2025 16:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1748873392;
	bh=7bmHYRTYQ/Vgcw0BO210tlbJzBv60oDYcfpRFcOEYPk=; h=From:To:Subject;
	b=OoiQ0HZv6DPRGuvM15a23+xGhXQbsI2Vwc4IUxzTDyFEJhaEaqKNv4OSGJkN28kIW
	 JAjJetrnYHF85xHcbi67uFquuVJmNUyGt8lLiQjRlP99rXK+jUU1p5WInvGwXTY1kP
	 VC9yBIO3RpSCus7XiNuV886pyXGrJS5IUpoqO/Qzu6crRaEMuGFAjbMhLBJb/TVXEB
	 /p0psAFMbEuRp0KI5y1bjqi78Lu+9o2yitSTvZaabX18wa6b1LfPcSG9wyPQK952xQ
	 Gm2BBZfYUMaQSw/+Yz9v/ZOJSp6WuFEF0kAodXFfimyDHaFt2VlAG2WqfG3/4VU1yJ
	 r9f3hM9MlZ+Tg==
Date: Mon, 2 Jun 2025 16:09:47 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH 2/3] hwmon: (amc6821) Move reading fan data from OF to a
 function
Message-ID: <20250602140947.GA58087@francesco-nb>
References: <20250530-b4-v1-amc6821-cooling-device-support-b4-v1-0-7bb98496c969@toradex.com>
 <20250530-b4-v1-amc6821-cooling-device-support-b4-v1-2-7bb98496c969@toradex.com>
 <517a6335-9246-4de6-aab4-24949eb7277f@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <517a6335-9246-4de6-aab4-24949eb7277f@cherry.de>

Hello Quentin, Jo�o

On Mon, Jun 02, 2025 at 03:21:31PM +0200, Quentin Schulz wrote:
> On 5/30/25 7:46 PM, Jo�o Paulo Gon�alves wrote:
> > From: Jo�o Paulo Gon�alves <joao.goncalves@toradex.com>
> > 
> > Move fan property reading from OF to a separate function. This keeps OF
> > data handling separate from the code logic and makes it easier to add
> > features like cooling device support that use the same fan node.
> > 
> > Signed-off-by: Jo�o Paulo Gon�alves <joao.goncalves@toradex.com>
> > ---
> >   drivers/hwmon/amc6821.c | 58 +++++++++++++++++++++++++++++++------------------
> >   1 file changed, 37 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> > index 13a789cc85d24da282430eb2d4edf0003617fe6b..a969fad803ae1abb05113ce15f2476e83df029d9 100644
> > --- a/drivers/hwmon/amc6821.c
> > +++ b/drivers/hwmon/amc6821.c
> > @@ -126,6 +126,7 @@ module_param(init, int, 0444);
> >   struct amc6821_data {
> >   	struct regmap *regmap;
> >   	struct mutex update_lock;
> > +	enum pwm_polarity of_pwm_polarity;
> 
> Do we actually need to keep the information about the OF polarity?

...

> Otherwise I would have said we just need to store the "computed" polarity,
> the output of amc6821_pwm_polarity instead of going through the logic every
> time we ask for the polarity.

I would do this. This pwminv parameter is already weird, given that this
is just a HW configuration, and we have it just for legacy reason.

Francesco


