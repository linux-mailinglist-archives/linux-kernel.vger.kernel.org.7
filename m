Return-Path: <linux-kernel+bounces-871403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C5CC0D269
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E17C94F1B38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31812DA760;
	Mon, 27 Oct 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HShz/DsS"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738D2E413;
	Mon, 27 Oct 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564654; cv=none; b=dzx6nHdEMSwljnM3H8mXKu/UHkLkhAMg3Yanzzqyqo5+QUPutfeUSpn1tFjUyHK9U8mOFCDEXWd81pNfitFPyB/adXjn3F/eMdccXDD/DeMz67yy4W9lIeUw4kDOAIucDiViEdmFcM/F4m/BCWc5/Bb8E9xTPY5oMJofRMer3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564654; c=relaxed/simple;
	bh=5JT5bGJhHxHWJ4oceSxygK7M0b5cCaty9XqLik7s8lM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wt9jm+rtnB5ghtL/szoBXHZPbapvLCvMXrrht/qdISUrJct7hvIp6WlXKRuFTNN+617I2IZNElLUMDwMdGfVoHvYF5u7zHOMUYTLiYePQnftVFobrXIhipQcCXGFYZyQx4ZSy8nJtJVk53CQtE9h9Css4peJNrCAoSNQVulSK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=HShz/DsS; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MTyxTx88RdhguD3ryu42oVWhZuQC5HIj7TgqpTJYQKg=; b=HShz/DsSxdMlbnOeqfjFh2F1et
	+nrjgAlnV/day/HqexC9MBncYD9lelWGOdiIRrxYdvJnrQXOBM6mMg57JLp+QPS67090uitxNzLuG
	VwEnJezqbxqCzhLU7ys+GO12q3qhnQTjAmqDvCrUT/FsRFFpRQzbWrKs8aLa8sETIQk6XUC2MZHqk
	IqLUHLiZ1gdP9tC6VGZCja0H9Zt1jo97ywTG1wvpPD+lK/0slIIEC52O1jgD0BlG/RccH2CLtRZY5
	3PR47cKDKAeTE+icr91j0veZnozT7FVGuLwhfNc4sqHDR7JAT4170JiaZHLZbx7fVMzXbvUcTydQG
	ynDF+GLQ==;
Date: Mon, 27 Oct 2025 12:30:30 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Mark Brown <broonie@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, lgirdwood@gmail.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <20251027123030.7e876f5f@kemnade.info>
In-Reply-To: <aNOvddby_hpegvDR@finisterre.sirena.org.uk>
References: <20250920114311.291450-1-andreas@kemnade.info>
	<20250920114311.291450-2-andreas@kemnade.info>
	<79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
	<20250920233307.0c425863@kemnade.info>
	<473e217a-c6b3-4ebc-895d-85beab50267c@sirena.org.uk>
	<20250924090023.282ae450@kemnade.info>
	<aNOvddby_hpegvDR@finisterre.sirena.org.uk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 24 Sep 2025 10:44:37 +0200
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Sep 24, 2025 at 09:00:23AM +0200, Andreas Kemnade wrote:
> 
> > max5970-regulator.c has hwmon integrated and no extra device. That would
> > simplify things. Although it does not report temperature. Some  
> 
> If that's the only reason why it's a MFD I'm fine with doing that.

So lets summarize.
Regulator + Temperature without hierarchy = regulator driver with hwmon integrated or
                                            mfd                                  
                                          + regulator driver
                                          + hwmon driver

Regulator + Temperature with some kind of hierarchy =  regulator driver with hwmon as
                                                       aux device or
                                                       regulator driver with hwmon integrated



I am just thinking about upstreaming one of the other epd pmic drivers
I carry around with full power management in mind at the beginning first.
The difference is that temperature part in these chips is more separated,
so the other design patterns are more suitable. So it is not one bit
controlling everything. I am thinking about chips like the JD9930,
TPS65185, or the FP9928. So I get a good picture how things could work. 

Regards,
Andreas

