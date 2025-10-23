Return-Path: <linux-kernel+bounces-867168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269DFC01BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED3C188C1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693932A3D1;
	Thu, 23 Oct 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRRzzGui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B42C08BA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229310; cv=none; b=EYCZlUzabdyc1MDB065Zit/HDpqe/FZRGIQMhU9+FiQKXtCbemqUxqUGi+603HZhXYzMBVQKwnl7mJq0yDYj+kAlodSnV/1Tfy+XW+PphXSInfuJgjiLKUsEhtc1mfFPsTKozjJp8WDLHU3sKmLEZXmEXmg7PEoYGnDzisBR25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229310; c=relaxed/simple;
	bh=vdJwLpFoHQimvg/JUa3pAzFx/xqVPGx8OyOLun1DNHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+TmfONNW6tQ2UX8I3q82QY96+eRtDKtgPAQUKOxfjb9A/NxAkK0gb/oxIqfPAU9oI8WhKmQh6988Kbg+i+FCQeE+EEcylDxZX1QkLOlbC7zeVJl69GKy93svkpw0J7fvv+HtsikEQbM8+MdpOw08JO2w26v9POkxXisnhmRJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRRzzGui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B880FC4CEF7;
	Thu, 23 Oct 2025 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229308;
	bh=vdJwLpFoHQimvg/JUa3pAzFx/xqVPGx8OyOLun1DNHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRRzzGuiyGu3MWU8Ci6b0fk2sVswgBtyVmyv/YL0Tyrrs+PzT5BTzfPYk68SGSg6J
	 vPPP7S9ABCJqSEJ3qDr5sGU3sW1h6fHrgbf3WUeNkA6WMNN9wD88H2ad26oOyXyePJ
	 dgB+jLvfq4MKszYUjxKgtTpGNQNX1HxnO3hAWFiV2kvPjbVOxvg2wLZUvNpjZA7qeP
	 C86j3rzcl0yI7EnzqsQTQOVcXar9TwiRmCkxHgM6VpNGy7kG/0LRj0ybInZ69gk6yN
	 r2hmZE7aCE4l64CpaQuwECkwO6/lXBU+ZCy/iR9O6vHy2RvHH1WXO49pwxwHQhP2mp
	 cQLE0ZtyGSBNQ==
Date: Thu, 23 Oct 2025 15:21:44 +0100
From: Lee Jones <lee@kernel.org>
To: Ghatto <ghatto404@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: max77705: support revision 0x2
Message-ID: <20251023142144.GQ475031@google.com>
References: <20251014043255.176499-1-ghatto404@gmail.com>
 <20251023131732.GN475031@google.com>
 <CAMQHOhdzaak3c_jMuOXnukrE9LnCKvouOiAy8g0veRS2eQ3ikA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMQHOhdzaak3c_jMuOXnukrE9LnCKvouOiAy8g0veRS2eQ3ikA@mail.gmail.com>

On Thu, 23 Oct 2025, Ghatto wrote:

> On Thu, Oct 23, 2025 at 10:17 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 14 Oct 2025, Eric Gonçalves wrote:
> >
> > > Revision 0x2 has been tested on the r0q (Galaxy S22) board.
> > >
> > > Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> > > ---
> > >  drivers/mfd/max77705.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> > > index e1a9bfd65856..5201a4c9c3f5 100644
> > > --- a/drivers/mfd/max77705.c
> > > +++ b/drivers/mfd/max77705.c
> > > @@ -105,8 +105,8 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
> > >               return -ENODEV;
> > >
> > >       pmic_rev = pmic_rev_value & MAX77705_REVISION_MASK;
> > > -     if (pmic_rev != MAX77705_PASS3)
> > > -             return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
> > > +     if (pmic_rev == MAX77705_PASS1)
> > > +             return dev_err_probe(dev, -ENODEV, "Rev.0x1 is not tested\n");
> >
> > What happens when PASS4 is released but not tested?
> PASS4 doesn't exist from what I've seen on the max77705 header files.

Not yet.

But not having it in the defined does not mean one won't exist in the future.

-- 
Lee Jones [李琼斯]

