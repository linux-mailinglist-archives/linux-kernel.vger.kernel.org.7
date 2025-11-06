Return-Path: <linux-kernel+bounces-888634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1FC3B91B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB536233AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282E1D9663;
	Thu,  6 Nov 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc6OLvtQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2611E0DD9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436520; cv=none; b=J7r7wnOlyfioY8aRFTgehK6m/u+4qqoPN+ytz0JY2+Mtv4n+u3ZcVp7MEPICHNSLeGtldbxNlyF2eechA6GpLLL0tnWGnJQVw4g7qDnOlPeLTkkuRRXemH957CfGCt0oWFFA8qGCUuolVynL4+Qb+MuDPCcL0T95nmOO7DFFazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436520; c=relaxed/simple;
	bh=6hV6kY+ahJi8gWBScud7O7eR6CXS/5QOoZDmLYaWPQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpJpbrL9WewAeTKTPn4k0Ud7Wi+t5Jyhi46flsyRCMAaPkcF00ZN23oQL/iJ8L8WtnJ5uBP1p5yEtnBd5xh7UVXpQFwaah4ALEOujVV/SlJPbWXEeE+LER3oP4kR1FYsqbWMsRKhBEZJGDnbSJvCREIbTJ1D4WuJNw+o+lf/q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc6OLvtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684A1C116C6;
	Thu,  6 Nov 2025 13:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762436519;
	bh=6hV6kY+ahJi8gWBScud7O7eR6CXS/5QOoZDmLYaWPQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gc6OLvtQi0QCOqxWfYLJWvw1EF1ug0YqysQ3Q631AlkVrtKCKf28cW+ZprLR5LQKK
	 Y+CzrC6cRTCgYgHeFs4U083fy3VWMhDmIVw0zDkukb//KC114W4tbqbJeZ5thUQnjl
	 tbkUjTuPjRDrxH02hOy1eZxmqEc5NM3O4oH191KCC8oRRbQYy2Nb4u3gaKAbbL83QH
	 354Jxh5az0XhgPQcYi3jki/Y1TlYDgR+INnfQlMt3XgJvMxRSU5FiRFG796N/Nioo7
	 v5fTbCtG1RGhSkxx7eBACs0Jvz30JRxrlSuNGz5nr68V6pxWOFsgMLZ0HDG3oFtV6X
	 idRBKEWvV/9QQ==
Date: Thu, 6 Nov 2025 13:41:55 +0000
From: Lee Jones <lee@kernel.org>
To: Eric =?iso-8859-1?Q?Gon=E7alves?= <ghatto404@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: max77705: support revision 0x2
Message-ID: <20251106134155.GM8064@google.com>
References: <20251014043255.176499-1-ghatto404@gmail.com>
 <20251023131732.GN475031@google.com>
 <CAMQHOhdzaak3c_jMuOXnukrE9LnCKvouOiAy8g0veRS2eQ3ikA@mail.gmail.com>
 <20251023142144.GQ475031@google.com>
 <6D713FE3-EF65-4A48-A04C-E69396BC56F5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6D713FE3-EF65-4A48-A04C-E69396BC56F5@gmail.com>

On Thu, 23 Oct 2025, Eric Gonçalves wrote:

> 
> 
> On October 23, 2025 11:21:44 AM GMT-03:00, Lee Jones <lee@kernel.org> wrote:
> >On Thu, 23 Oct 2025, Ghatto wrote:
> >
> >> On Thu, Oct 23, 2025 at 10:17 AM Lee Jones <lee@kernel.org> wrote:
> >> >
> >> > On Tue, 14 Oct 2025, Eric Gonçalves wrote:
> >> >
> >> > > Revision 0x2 has been tested on the r0q (Galaxy S22) board.
> >> > >
> >> > > Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> >> > > ---
> >> > >  drivers/mfd/max77705.c | 4 ++--
> >> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> > >
> >> > > diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> >> > > index e1a9bfd65856..5201a4c9c3f5 100644
> >> > > --- a/drivers/mfd/max77705.c
> >> > > +++ b/drivers/mfd/max77705.c
> >> > > @@ -105,8 +105,8 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
> >> > >               return -ENODEV;
> >> > >
> >> > >       pmic_rev = pmic_rev_value & MAX77705_REVISION_MASK;
> >> > > -     if (pmic_rev != MAX77705_PASS3)
> >> > > -             return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
> >> > > +     if (pmic_rev == MAX77705_PASS1)
> >> > > +             return dev_err_probe(dev, -ENODEV, "Rev.0x1 is not tested\n");
> >> >
> >> > What happens when PASS4 is released but not tested?
> >> PASS4 doesn't exist from what I've seen on the max77705 header files.
> >
> >Not yet.
> >
> >But not having it in the defined does not mean one won't exist in the future.
> I don't think it will, newer Samsungs already use a new maxim controller.

Stranger things have happened.  Let's take the 'better to be safe than
sorry' approach and future-proof this the best we can.  Let's do a
proper bounds check for supported devices instead please.

-- 
Lee Jones [李琼斯]

