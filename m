Return-Path: <linux-kernel+bounces-857486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DBCBE6EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 871EB4E359D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105F30C37D;
	Fri, 17 Oct 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VIz76RX4"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C523B0;
	Fri, 17 Oct 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686080; cv=none; b=qSJRDDu694Xy/v5EtoHt/x2N/dxyX87bn2AMxkgR+gOrGa+9TqANqN09YpwXfLzS2lWgEoXVRT/lYCY44mJH+LTJbZFFyLiWYjuEpAdTj368SWklx+Mih+eNrVSYy9eBb4QpCopLjRGyWX29vzpAZtOODAT/KQEUV7MbzvgPa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686080; c=relaxed/simple;
	bh=CeYmHe2krBmRJ6wb9noy1AZ7ZcEqcmhOzbisZa/Zn0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+1678OaYS8dRpmCdSCqgbq7Haqvo9ALeFrPtVuRnBj00jqKJBhpyJyqr3VS8PIAxPUB9x49/Jc55IwXrSSXTifkp+FamKzrv4IhdCJi2xJA/wGGlBvHxmAbLkVD/nJx0BigT82XoJTHPomn9wxhgcuu0J1I5NvXGpEg/U/9kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VIz76RX4; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760686074;
	bh=CeYmHe2krBmRJ6wb9noy1AZ7ZcEqcmhOzbisZa/Zn0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VIz76RX4NyL2/lwkpiHUBHlniXsm88NzdohT42OCC6jZRkVCnmCAm4q1QezGJxiQF
	 nqGCL0odsbY+KGW4RrQLUsHZucGbEgWn81mOIQ/51ojlQU5SXVg+kQiD4MYH9tfuBw
	 V4VNH3h6CNDZ7QAhpn8X1sYr2VmvG6QJZ/YbGgj4tBgNwhz/PEqHcPFJ/QHfFNE5T2
	 tUTed0LwGCB5RDYXq6Rukc9vgK+nLeSoCbzkVvzlDQKXStokEeve3blocwxA6qE7Fk
	 wUscGyg7liKXOBf/W1insVDfobbK/YdlbH13XkV5IuebXQoQONRTSrDd+mkDQfdWsc
	 x18V1qULiQjWw==
Received: from [IPv6:2405:6e00:242d:9743:e1f6:2067:ab3d:5861] (unknown [120.20.206.235])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 651866477A;
	Fri, 17 Oct 2025 15:27:51 +0800 (AWST)
Message-ID: <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
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
Date: Fri, 17 Oct 2025 17:57:44 +1030
In-Reply-To: <2025101759-runner-landing-374b@gregkh>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
	 <aMatZAX6eFI1RmDH@redhat.com>
	 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
	 <aPEZSY6RC-UVclxN@redhat.com>
	 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
	 <2025101759-runner-landing-374b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 08:41 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 17, 2025 at 04:52:37PM +1030, Andrew Jeffery wrote:
> > Hi Greg,
> >=20
> > On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> > > Hi Andrew and Iwona,
> > >=20
> > > On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> > > > Hi Brian,
> > > >=20
> > > > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > > > Hi Iwona, Joel, and Andrew,
> > > > >=20
> > > > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > > > > The round_rate() clk ops is deprecated, so migrate this
> > > > > > driver from
> > > > > > round_rate() to determine_rate() using the Coccinelle
> > > > > > semantic patch
> > > > > > appended to the "under-the-cut" portion of the patch.
> > > > > >=20
> > > > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > > >=20
> > > > > Would it be possible to get this picked up for v6.18? I'd
> > > > > like to remove
> > > > > this API from drivers/clk in v6.19.
> > > >=20
> > > > My (strong) preference is that Iwona applies it, but I'll keep
> > > > an eye
> > > > out for any unusual delays.
> > >=20
> > > This patch wasn't picked up for v6.18. Any chance this can get
> > > picked up
> > > now for v6.19?
> > >=20
> > > I'm hoping to get this merged so that we can remove the
> > > round_rate() clk
> > > op from the clk core. The clk maintainer (Stephen) mentioned this
> > > work
> > > in his last pull to Linus.
> > >=20
> > > https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel=
.org/
> >=20
> > Are you happy to pick this up directly in Iwona's absence?
>=20
> Why me?

I figured that would be sensible since Iwona historically sent you PRs
for the PECI subsystem.

I'm open to other approaches though.

Andrew

