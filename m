Return-Path: <linux-kernel+bounces-835324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD0BA6BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A379F3A6FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35342BEC59;
	Sun, 28 Sep 2025 08:50:17 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B18220F29;
	Sun, 28 Sep 2025 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049417; cv=none; b=SMchrwSxK2DiRO3Ija2VA1xEy3D45u+VZbxT3kmaYYgXi1KeeoA4OYEdgzrboOGh+rEvu4sZVWi6sz/6XQ1WiB0dKa8O+NOPZvmOIvQdbWxTrZXWELaA8JRmMVos5e19XHaCJMxIR/tIrmSGjkqBiR68JT3JD+zpkwR3o5lZGq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049417; c=relaxed/simple;
	bh=P8TMQigKcbvYecEtdV3i9zLsC5kWD2Y4YfvF/HLWBNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7hr50kpzIN7pddoQt/SJkyapf9frDZf1yaiij8SBa7FlWkh5hi1tA/ovukL4p1DZdDmLZZsuVj62HDgMihpxsofVoBK0tFPGg3gsW/yeDZyXxLTFugKzOdgGpnVFNtQMEI8JJDMq4WeKXZG6zEen7QZrKMEV1F0P+95c5IKxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E00AB340824;
	Sun, 28 Sep 2025 08:50:14 +0000 (UTC)
Date: Sun, 28 Sep 2025 16:50:10 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add MusePi Pro board device
 tree
Message-ID: <20250928085010-GYC1344940@gentoo.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com>
 <20250928080003-GYB1344940@gentoo.org>
 <3074FC8521909735+aNjsSWwkd1aH-moh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3074FC8521909735+aNjsSWwkd1aH-moh@kernel.org>

Hi Troy,

On 16:05 Sun 28 Sep     , Troy Mitchell wrote:
> On Sun, Sep 28, 2025 at 04:00:03PM +0800, Yixun Lan wrote:
> > Hi Troy,
> > 
> > On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> > > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > 
> > > Add initial device tree support for the MusePi Pro board [1].
> > > The board is using the SpacemiT K1/M1 SoC.
> > > 
> > > The device tree is adapted from the SpacemiT vendor tree [2].
> > > 
> > > This minimal device tree enables booting into a serial console with UART
> > > output and a blinking LED.
> > > 
> > > Link:
> > > https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> > > https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> > > 
> > same as patch 1
> > > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > ---
..[snip]
> > 
> > while you are here, I'd suggest to push as many features as possible
> > instead of this minimal DT, which say - PMU, emmc, ethernet should be ready..
> > (ethernet is in next, should show up at v6.18-rc1)
> Good idea.
> I think I should split these into multiple commits, right?
> Like, PDMA and EMAC should definitely be two separate commits.
> 
IMO, not really necessary, but I wouldn't mind either..

-- 
Yixun Lan (dlan)

