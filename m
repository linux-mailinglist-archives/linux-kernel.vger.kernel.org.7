Return-Path: <linux-kernel+bounces-779135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C32B2EF92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DDC7202DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7B22E8DF6;
	Thu, 21 Aug 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="cAnZIVwX"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392915853B;
	Thu, 21 Aug 2025 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761286; cv=none; b=aGW/EMPI+fmoeKCF5neZPg2cFjfSUaJAuLGzZRSwF6btcERQ78Qd25Resvo8oPyFXsKZv+jhdGfnfvp6JXfvujPIkkSFRCapPDEAZT9biWQq5nO84Hi6wc83DbnKp5ozu4d5LC4B0fWcsxU0hF6G1EVxvTixgHXNqNJBgdpq7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761286; c=relaxed/simple;
	bh=svqcbi3OmPTDfakiBEfBMCs3Ex89tSVr80w/U+8RMkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMd8QAYhC9RoFziWRbOpsxkKn8wcXs6wOOsepL9T7/LZN9iigvhlxooI4E1GuWBFuykiVtCCPAlsq+1H4bzoL92jiC/0epxs9txlA10evXdT9GoMiPKnnMRvGqy76BQo6hL1cZLM+2sgdq2JStHOOo28rKx88Ew7tjevBc/mRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=cAnZIVwX; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=vSKYxpG2l1hLbvhop/k88VTpfR3m9wwP+xtV0BRw8B8=;
	b=cAnZIVwXcfoCbePnaF9lR41aRUKHK61RpFnwD8UwDIeLYSLWPFvT6OhrmTX6dK
	QZdvcJp6PhMfEe5NDEI8NjyqU5JQ+jF/peP0O/xTFKWsTtPmTccTMpH4vEOY4rfp
	25DPz1Qs59k+A8kWUrP3ftU3bARpRy829m15pXT02xmNU=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnnyhGyqZoY5IZAw--.37745S3;
	Thu, 21 Aug 2025 15:27:04 +0800 (CST)
Date: Thu, 21 Aug 2025 15:27:02 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Wolfgang Birkner <wolfgang.birkner@bshg.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: imx6ulz-bsh-smm-m2: fix resume via console
Message-ID: <aKbKRmzJ75uoVTxB@dragon>
References: <20250715141322.1305512-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715141322.1305512-1-dario.binacchi@amarulasolutions.com>
X-CM-TRANSID:Ms8vCgDnnyhGyqZoY5IZAw--.37745S3
X-Coremail-Antispam: 1Uf129KBjvdXoW5Kw4ruFWrur47Jr45WryDKFg_yoWxGFX_ur
	18Grn7X3Wjy3WxA3WIyr4UZryjgw47GrZxW3yFkw1fJFy8urZ7Ga97tr13ArW7Wr4rK347
	W3WYvan0yw47JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb7PEDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNQiI7WimykhiKAAA3e

On Tue, Jul 15, 2025 at 04:13:10PM +0200, Dario Binacchi wrote:
> From: Wolfgang Birkner <wolfgang.birkner@bshg.com>
> 
> Despite the current configuration being compliant with the technical
> reference manual (TRM), testing on the system showed that resuming from
> suspend via UART4 (used as the console) fails unless any other UART
> is also enabled.
> 
> In our use case, UART2 is enabled to ensure reliable resume when UART4
> is used as the console.
> 
> Signed-off-by: Wolfgang Birkner <wolfgang.birkner@bshg.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Weird, but applied.


