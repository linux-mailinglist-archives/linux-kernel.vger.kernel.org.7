Return-Path: <linux-kernel+bounces-825914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31207B8D199
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE97F7C1F82
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441727B325;
	Sat, 20 Sep 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="s5thakUD"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4F217F31;
	Sat, 20 Sep 2025 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758403998; cv=none; b=VJNHlOB0eAyR174NvOlmDtWigvXURJ8OOmzAnDN9iLMZ12I7m1F4MA7NaZ0dJwjPvwzkkiHZNNy0jo789tCDs34plII9lpiFI2EviVr3krWlGk2+FD6l4IxUQcBITA9AN13f7/7EX8JeSL7DEJYSd0vZVm1J1MUITk4JjWQj4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758403998; c=relaxed/simple;
	bh=p2/ybG0RHxAJ08YaYKCJpzdX+zyDCdbz+ZUD+7CtDk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2UGayCQp7/VoPh21JZEN27l8pTpCiflPwt7ZqX/draAGrzd9iDEdhHKIbOJllW+56864uniQ42y0SSf23vhSmVhWGtnsZg6pkH8rszovrmQ7XUlnS4evSGSeL+wD2zVBXgVK+x6OUc0HwIwBhWuyHnH4uqIkoBJNQnAlfqu6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=s5thakUD; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0u0WtBYfxKuBWXFjhGe31EGazVvqGWvYvXE0rpSZyR4=; b=s5thakUDMnwidVJJ6boJma5QoL
	feiGX0N8sy+N2c9SiMG1yaBoq4MFLXktOPAB1+Tfm2I6/PlYazlsie2RdOnOOh6LL0feVSeRz4QQy
	O1xShuBEa/YvjqxGlX5BCsfCO5KfLldBfXCIiux3QjJ0jRAzrNQj1WeoGa+YUh/YWq9EJeC5S95ux
	MJhg5f9EAJxCvrcLXX8c+eczfSQqDO2N0+ttgzGywaSwVUkQj8gbM42XBEvC0i/9QM4ge3pZsUo82
	iliYxg7WlcFBnH1BEg4XbX03MRQKd/D/BcmhylOfjCDAnr+zwLCqwZCZ8Y/ckM6dC00UFcK6+i+fX
	luedEP8A==;
Date: Sat, 20 Sep 2025 23:33:07 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Mark Brown <broonie@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, lgirdwood@gmail.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <20250920233307.0c425863@kemnade.info>
In-Reply-To: <79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 20:58:07 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Sat, Sep 20, 2025 at 01:43:10PM +0200, Andreas Kemnade wrote:
> > If regulator subdevice is not ready early enough, devm_regulator_get will
> > get a dummy regulator device, not the real one needed from the regulator
> > subdevice, so defer probe in such case.
> > devm_regulator_get_optional returns an error in that case.
> > 
> > That fixes things, but looks odd, therefore RFC.  
> 
> No, this is buggy and broken.  You should only use _optional for
> supplies that are optional, the clue is in the name.  You need to fix
> whatever is causing the device to be instantiated to ensure that the
> regulators for the device are described before it tries to instnatiate
> the device.  Normally this is all part of a unified firmware
> description.

Just for learning, yes, it is an abuse of the _optional for non-optional
things, so a dirty hack which should not go in, therefore RFC. But what
happens more than having the hwmon device endlessly deferred at worst?

The wanted regulator is the one defined in sy7636a-regulator.c. So it
is all an issue internal to the sy7636a.
  
Both subdevices are instantiated via drivers/simple-mfd-i2c.c.
I see several other solutions:
a) call device_is_bound() on every other children of dev->parent, if not
bound defer.
b) do not care about the regulator api at all, just check whether
   the corresponding bit is set before reading temperature, return
   -ENODATA if not, some mutex is probably needed.
c) do not care about the regulator api at all, just set the
   corresponding bit (together with some mutex locking and counting).
d) copy the of_node pointer from the parent, add a regulator phandle property
   to the node pointing to the regulator in the node itself.
   That sounds like your idea but is against the current dt binding for
   this device and afaik it is uncommon to have mfd-internal things wired
   up this way

e) something clean, simple I miss

Regards,
Andreas

