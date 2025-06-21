Return-Path: <linux-kernel+bounces-696805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5726AE2BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D9E1893872
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167E246762;
	Sat, 21 Jun 2025 19:55:52 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0127E1
	for <linux-kernel@vger.kernel.org>; Sat, 21 Jun 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535752; cv=none; b=mNpXGXtG1vn9Kww89//Mg98WOyjRZINJ2PP5RxW5n8gbKsz4ScZWtjQ6hliIdnBE8OPXrmtKU2gPYfio5AqpYOn2bBCuA2xq+qePV9lU+VpqKI6Lucr9KNRa8UNRe2IwMQFe5xNZCxBwU9lmsBMX5R9tN29Bcq6zqTb+qy9mccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535752; c=relaxed/simple;
	bh=XN9dgj8KZxF+ZFA7X5ypPmDNQHGVkzrlJsyw+f1Ohzs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpo4ZE8Hyp46QXDkpnmUA5fKliIEq4YEURD2oNkk1BLuyBqvIywnjwg07IBrzkKN13FCf4ueDGEfIbSJtqUmS7wZbQ/vRvpjy35SnyKbH8OidPxTOM1+8MBDMLMk+m4AAwwvX8gh/VlPJvP2w7lJMmTvYNc1YWp8p+bmiSjQn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id b672fed3-4ed9-11f0-a5a7-005056bdf889;
	Sat, 21 Jun 2025 22:55:43 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 21 Jun 2025 22:55:42 +0300
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v9 07/11] iio: accel: adxl345: add activity event feature
Message-ID: <aFcOPky_EsatfsJu@surfacebook.localdomain>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
 <20250610215933.84795-8-l.rubusch@gmail.com>
 <aEq_SJMDzPYGSMu6@smile.fi.intel.com>
 <CAFXKEHbdeomMfEBwO+Cvkn5dkN4h47CEAMfmEGQC2V82zQ+U8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXKEHbdeomMfEBwO+Cvkn5dkN4h47CEAMfmEGQC2V82zQ+U8Q@mail.gmail.com>

Sat, Jun 21, 2025 at 08:06:49PM +0200, Lothar Rubusch kirjoitti:

[...]

> > > +     ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     switch (type) {
> > > +     case ADXL345_ACTIVITY:
> > > +             en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
> > > +                     FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
> > > +                     FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
> >
> > Something happened to the indentation.
> > Ditto for several places in the code (upper and lower from this).
> 
> What is the matter with the indention here? I'm doing `checkpatch.pl
> --strict --codespell` on that and don't get an issue? Would you expect
> cases like the FIELD_GET() calls on the next line, linked by a binary
> OR, to be indented by yet another TAB?

All 'F':s should be on the same column (since the email already mangled
[not by me], here is just an example).

             en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
                  FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
                  FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);

> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (!en)
> > > +             return en;
> > > +
> > > +     /* Check if corresponding interrupts are enabled */
> > > +     ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return adxl345_act_int_reg[type] & regval;
> > > +}

...

Really, cut the unrelated context in the replies!

-- 
With Best Regards,
Andy Shevchenko



