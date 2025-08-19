Return-Path: <linux-kernel+bounces-775697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941ABB2C3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14415C0588
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DEC305056;
	Tue, 19 Aug 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcZGbqH6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22883305043
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606558; cv=none; b=rNP2AcNLIqhHU3neXIAtWHZONDgh6owezV4I2IFe2pE+lfHj1Lk87oehQD57DdwPxM1Hk94y0cTqjFGLUqH3kjzX2M/QP6XwQjGtk790M9A9ZbXdXmr3ImGoqVISuv4GSsmJ5cdVlQaLRN08s+g43WbqsbUtk0E6jGzTLKW1ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606558; c=relaxed/simple;
	bh=G+bd4YDVDBo2XB6h9RwVWN7LmR3m66WklQDGFnO8Qz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjTCAkmJzXExeI9mSIFZg3JNlvHjzrQ+r2PA1Yg2Tz2a3BaCeH7gWAnw56WkiQmfhHZK2d3thCXK9JTXqBUals70OkDad369quxrd1yOFPkVFzH3SZ9aJQprK5HabVuedh3VrCD0LYe5oOIWtmvVlLY5eHmvxXJVGV+Mr5KqTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcZGbqH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1278CC4CEF1;
	Tue, 19 Aug 2025 12:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755606557;
	bh=G+bd4YDVDBo2XB6h9RwVWN7LmR3m66WklQDGFnO8Qz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcZGbqH6ZmpD6ptzknT3CUg7DYChHoSIIbvenvUrq8GFpO853VYZVPdz6nkbC6trG
	 Z6IV/UWVbHzxZg32RlljV3Mt3Kgj2prkCP3k8XBetOKWzxj9fge9R0jpq58dwD2f84
	 KViCTcG9qeeti5zy3bIeslQ5bdkn8ZoTdA+L3KnRk0riJ/nUTZWwzf0SX6/1dnrsAC
	 XY6CJpitjTHrj2Vxdj3LiJEPa0JMLqo51ITEKKb77kQ2jPaolfqWqgVhVZ9macoZ2E
	 tAW8gW8ZKu29dtuSEewpphijUMbW+q0waPXr9No5FnG0lTUMShqzd+TnYe8reFpdqF
	 pc8+6vfwQRtuw==
Date: Tue, 19 Aug 2025 13:29:14 +0100
From: Lee Jones <lee@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] mfd: simple-mfd-i2c: add compatible strings for
 Layerscape QIXIS FPGA
Message-ID: <20250819122914.GB7508@google.com>
References: <20250707153120.1371719-1-ioana.ciornei@nxp.com>
 <175395237951.1066658.3222139000178153711.b4-ty@kernel.org>
 <d7uflpa6tqhreqqbe4veqd7gik4p5oydonpc5nd5snw2bp63k3@iabo5bmcxqdr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7uflpa6tqhreqqbe4veqd7gik4p5oydonpc5nd5snw2bp63k3@iabo5bmcxqdr>

On Wed, 13 Aug 2025, Ioana Ciornei wrote:

> On Thu, Jul 31, 2025 at 09:59:39AM +0100, Lee Jones wrote:
> > On Mon, 07 Jul 2025 18:31:20 +0300, Ioana Ciornei wrote:
> > > The QIXIS FPGA found on Layerscape boards such as LX2160AQDS, LS1028AQDS
> > > etc deals with power-on-reset timing, muxing etc. Use the simple-mfd-i2c
> > > as its core driver by adding its compatible string (already found in
> > > some dt files). By using the simple-mfd-i2c driver, any child device
> > > will have access to the i2c regmap created by it.
> > > 
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] mfd: simple-mfd-i2c: add compatible strings for Layerscape QIXIS FPGA
> >       commit: d3a09d5e5ce66a91acfdbcf09d7193d2167b69c9
> 
> Hi Lee,
> 
> What tree should this patch be present in? I did seach
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for it but no
> luck.

It was probably in the staging branch -next-next.

Also the subject line was changed to match the style of the subsystem:

  6aa6f19e7670 ("mfd: simple-mfd-i2c: Add compatible strings for Layerscape QIXIS FPGA")

-- 
Lee Jones [李琼斯]

