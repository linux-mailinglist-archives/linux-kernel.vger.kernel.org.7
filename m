Return-Path: <linux-kernel+bounces-806645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95AB499D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F318B16EDB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D559B279337;
	Mon,  8 Sep 2025 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="AEva1hBP"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201CF17A2EA;
	Mon,  8 Sep 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359282; cv=none; b=lfpYLj0AgSBm6oOb5ET9wgFdMVemropvLqgfZKla5mwXPqTFqixbK3TaL5MexPpkKeTsiJ2XBz+10RgeKJQAS474jefay9yAEqiTVpWe+kRTbPqVJn5vSZIyYsubAMogJlgsFncdSMn33F/BCP+iq8TXqLKzuZF2XuAofPUzB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359282; c=relaxed/simple;
	bh=eGNGo9UmbpcgmCGZTBYS1wzSgvq07uLAlDB4ZzlkLuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icgDu3Tcqqr3N3vUFIK4mWhLy1HrcGw3g+DdgsObGUoBVOgdlCs1ENKq2em2giXyNm+9/L7PKsteI+XdpPfxcmOcjvIVJ6oUjawAdXQI8Avui/+E6Z8Cezv+0CcfwGn72CIY9id24w5qYcCGeuBVf7IEgHlfY1xqTY6vKk6oljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=AEva1hBP; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (xdsl-188-155-97-38.adslplus.ch [188.155.97.38])
	by mail11.truemail.it (Postfix) with ESMTPA id 6037A233EF;
	Mon,  8 Sep 2025 21:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1757359278;
	bh=vNiJoZ4QWly/KKvQRA2zpDh1zo/FXO7FdLLjYNaY9w0=; h=From:To:Subject;
	b=AEva1hBP1OMIUEQmEmbb/BEeW/1N3lzEYFQ/yHSmH1NCRGcDJ61jbFBXYb9p8Qe8P
	 pcGpKwQB7OIC5vh5Wh2NdODeFMQUjo9y8HvNQ6XqTvnO3kDinHoD25KEwtpctoviHC
	 oO/5AgJC5Kx91lZ9EohwAOdl1OdAlgUuDOgeKUTOMMZkQvzQSTedfu0AODGaAiGBX5
	 k6H/SPoZFyFVPnpT23pA2dXYf8vIv+B3M7CqDUf0M6QVAFCu0RB8VI/cAuw7Roq4SX
	 JGFawAW+pTiQdOqII2v9cOFqMzwdnF1EgDe5YVq/zFurwvq1897567PewOk3CbmlZH
	 03xTFxkjNLyaw==
Date: Mon, 8 Sep 2025 21:21:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com,
	u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com, d-gole@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v4 16/34] arm64: dts: ti: k3-am62-verdin: Add missing cfg
 for TI IPC Firmware
Message-ID: <20250908192116.GB4217@francesco-nb>
References: <20250908142826.1828676-1-b-padhi@ti.com>
 <20250908142826.1828676-17-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908142826.1828676-17-b-padhi@ti.com>

On Mon, Sep 08, 2025 at 07:58:08PM +0530, Beleswar Padhi wrote:
> The wkup_r5fss0_core0_memory_region is used to store the text/data
> sections of the Device Manager (DM) firmware itself and is necessary for
> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
> for allocating the Virtio buffers needed for IPC with the DM core which
> could be optional. The labels were incorrectly used in the
> k3-am62-verdin.dtsi file. Correct the firmware memory region label.
> 
> Currently, only mailbox node is enabled with FIFO assignment for a
> single M4F remote core. However, there are no users of the enabled
> mailboxes. Add the missing carveouts for WKUP R5F and MCU M4F remote
> processors, and enable those by associating to the above carveout and
> mailboxes. This config aligns with other AM62 boards and can be
> refactored out later.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Verdin AM62

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>


