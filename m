Return-Path: <linux-kernel+bounces-819973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF87B7F847
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD3B526BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 04:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA082676F4;
	Wed, 17 Sep 2025 04:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgixDBAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4F1F4C90;
	Wed, 17 Sep 2025 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084578; cv=none; b=efMhu+dYxBc/w390jb+ESMA5NPnS721riQzt419Sr32sMpsZVY4J7EQizokuZD3ekNby/C2Us9CM4TTEkICXxBkh9x/LPu745JUPLjse3I08sH2063+0kFj4In1SMwrF14Qm1aP0XSC/htuG9svUHcfN/IQNnG1TJu6xuDq/zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084578; c=relaxed/simple;
	bh=6iKUJefCEfN6dN0bjyWGNmIlwawpbU6TIZlivM2qAv0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=qRyHxN5NVcHoaFLjzP9M5GTFWxbnHgIcsDXmLNP5/nEODYQN7VGeE4TXpFhFRDCQyBH4YzVpJle46VPJ7Vi0Xu6YDG0VnloG5adQuqQ+yNMlnMKAK1TFOW9atoibXwo4DFzBSY2lMTcOf60oNsRuf0c/ywXmbkL6+dbOXsx5/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgixDBAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00976C4CEF0;
	Wed, 17 Sep 2025 04:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758084578;
	bh=6iKUJefCEfN6dN0bjyWGNmIlwawpbU6TIZlivM2qAv0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kgixDBAV4DcV+vsxuyDQuN9mAKXk+Fwp1Rj7x5YjbvblULsWAjF/aqf4SdHA+PpDb
	 xk6vGGX2Pdx3p0E6YVCaxuf9Npu0VVrTCj+g6jBSg4IS/a+GDGRM0aEzmu6edX0sb+
	 TT0qZcVpdp0GVLpmFTHtS2mZjfEa8B03vsV1Kh5dlnL8V6JkVuZxgJJstbKNy4AUDl
	 PJP3twPd6gCUe25poKni14DRAuiG/qn+PKKys2pNGF20j8V0BePISlvbx/+kDqj6GY
	 NTzE0nbNhO6j5bAs55i9Ua3Eo4y5mz5bdi9u0ho52p1NplYz4sR4/DrcwyfKSj2soL
	 eEeRl/PG2KFpQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0695ca65-536c-48d9-ad1b-49452e67a6f9@microchip.com>
References: <20250916080545.9310-1-nicolas.ferre@microchip.com> <0695ca65-536c-48d9-ad1b-49452e67a6f9@microchip.com>
Subject: Re: [GIT PULL] ARM: microchip: clk for 6.18 #1
From: Stephen Boyd <sboyd@kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Conor Dooley <conor@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev, kbuild test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, SoC Team <soc@kernel.org>, linux-clk@vger.kernel.org, mturquette@baylibre.com
Date: Tue, 16 Sep 2025 21:49:37 -0700
Message-ID: <175808457715.4354.11044142356915096975@lazor>
User-Agent: alot/0.11

Quoting Nicolas Ferre (2025-09-16 06:19:11)
> On 16/09/2025 at 10:05, nicolas.ferre@microchip.com wrote:
> > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> >=20
> > Dear clock maintainers,
> >=20
> > Here are the first clk changes for 6.18.
> > I don't think they have conflict with changes for the deprecated round_=
rate()
> > to determine_rate() topic.
> > They are in linux-next for a couple of days.
>=20
> But... this series depends on this patch:
> https://lore.kernel.org/r/20250827145427.46819-4-nicolas.ferre@microchip.=
com
>=20
> Which will be part of a pull-request to-be-sent soon to arm-soc (which=20
> is part of linux-next, so the build error doesn't appear there).
>=20
> Once the pull-request is done, do you prefer that I do an immutable=20
> branch between CLK and ARM, that I queue this at91 PM patch into the clk =

> pull-request or that everything goes through arm-soc?

Whatever is required to build the code should be included in the PR. If
the same commit goes into arm-soc tree that's OK, just make sure the
branches aren't broken if you checkout a commit anywhere along the
branch that is sent to clk or arm-soc trees. Broken includes
functionally broken.

