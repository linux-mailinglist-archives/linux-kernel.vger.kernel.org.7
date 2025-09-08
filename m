Return-Path: <linux-kernel+bounces-806649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABA0B499E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C166168E50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F527F00A;
	Mon,  8 Sep 2025 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="j1Fm6Hel"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51727A906;
	Mon,  8 Sep 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359402; cv=none; b=sSdYoz1FKj+1RILcdnZv2GegXnuhqxXIMRLWDy8JrQ0ETxqlwWVE6q3TwYf7zSsDb8temCFWhfAAdKSfyGWDrCyELX0bPisvTmNkd1GiTSFDyvEGCkxKC5FWxe7wA73/QiJHFHuyzqgICG5EPf1R0iNOgtYLO7UoSdq4SpWuGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359402; c=relaxed/simple;
	bh=Kj+U1UniU/Kvc8yHAJyifBQNCQvgC0UBsXIUp8Lo78o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5vo23eZQvy6dgfTiDLx/dt167g1lSq18Gszns6E9G48URAAblAVvEMEoZcn+dj+1UE+Z9xKwk/sVNiF7RpUZasACRF2XuXgvHfjimKQzRGcMk4+eyA9ix5j69y9Gs7BI35DyMju8l14E1s0ZWtqrkyPSYbcExSyN+DxhMeePCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=j1Fm6Hel; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (xdsl-188-155-97-38.adslplus.ch [188.155.97.38])
	by mail11.truemail.it (Postfix) with ESMTPA id 75263233E8;
	Mon,  8 Sep 2025 21:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1757359395;
	bh=TSFMz1YsRrecVdcFsDR2zMYv9+JcraECHD1VyUZRDF8=; h=From:To:Subject;
	b=j1Fm6HelbfVbg7SK5RjhBl2NR05zf+V/t89C6ar3l+BQ8F5E8tu1hNAvi0IYcD1Bz
	 TgbeG1pXuw/t87/CbnuPMQVu7aB5GEds2LxUQSndzxJl1Uz2bcN6RPqcUPOflKimkB
	 TucXL8JW0H8XyDEA6hO2DMUWEmAZrka1dNsZpN+fLqb+eLVF2qTzgvBGfPTXFnpuy7
	 tf3sgMHRAMw/sbNsJ1V8Rrn/3zg+acU1bTkWT38hZIpvutVk9b26aFb7Uy/otU9sBG
	 iBEIgOUy54m2YOaw48kaj+KHoAUUZu1WjUtO7WCZ8sHDK7s+b322K1Gf/OtNWT+cI0
	 0mh4JvxlZfE0Q==
Date: Mon, 8 Sep 2025 21:23:13 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com,
	u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com, d-gole@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Logan Bristol <logan.bristol@utexas.edu>,
	Josua Mayer <josua@solid-run.com>, John Ma <jma@phytec.com>,
	Nathan Morrisson <nmorrisson@phytec.com>,
	Garrett Giordano <ggiordano@phytec.com>,
	Matt McKee <mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Li Hua Qian <huaqian.li@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Baocheng Su <baocheng.su@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH v4 13/34] arm64: dts: ti: k3: Rename rproc reserved-mem
 nodes to 'memory@addr'
Message-ID: <20250908192313.GC4217@francesco-nb>
References: <20250908142826.1828676-1-b-padhi@ti.com>
 <20250908142826.1828676-14-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908142826.1828676-14-b-padhi@ti.com>

On Mon, Sep 08, 2025 at 07:58:05PM +0530, Beleswar Padhi wrote:
> Currently, the reserved memory carveouts used by remote processors are
> named like 'rproc-name-<dma>-memory-region@addr'. While it is
> descriptive, the node label already serves that purpose. Rename reserved
> memory nodes to generic 'memory@addr' to align with the device tree
> specifications. This is done for all TI K3 based boards.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


