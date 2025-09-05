Return-Path: <linux-kernel+bounces-802144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2877FB44E1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6195A0798
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E952C0272;
	Fri,  5 Sep 2025 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="MTr7dAou"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F582C026F;
	Fri,  5 Sep 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054508; cv=none; b=ftSPHJtLfOVEFauZFZ3EvAEbn6wq7wv5oyZfQdXjwaqG0N/pz+eP9Wgv8WHmfhPGMSIkmsPDqq8DXIZSKFh9J+gkF9PH7sOixQP/DpXVQ/KAkDhtJDPkAkielauLW1yh4VDmP+fkGksooFr4dtkhjXK3H1YuRVRQN8zvYr+ufqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054508; c=relaxed/simple;
	bh=JLJZhNdjc/j8WwvSif7mZ8ejAMEds2XNLHR1rGzf4lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAT8hpcdqjdJBl2cwi8U0uHw7X+mdlEgLfGc3HV7xFFU1CUosHnhJPnK15VE5ZKAPTtX9IHOjk5rrlVkRz1QdAJHScDwYFqVR9m/zBGKb9AK7R05G42q/7/KCUfSNE+W4T37tiXSLL7MpwZRNOUuzKUgHdgQd6sF7cGPtUUaYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=MTr7dAou; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 732A7245EC;
	Fri,  5 Sep 2025 08:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1757054094;
	bh=m7eCumLJRVxXkVrrCzfdq48+hh6xilH+s0pYgrmlgbE=; h=From:To:Subject;
	b=MTr7dAou1BzD/n5kZvgWpUlcsxUSShVIOKD577/anK6dZbyF1uWzkF/XNu7r3lr4C
	 BCNDa7/CudLSQsB06MB72d19JQU7Rh2FFO9ju9yOphO0uKfUIVYnxrZwrHKaVCDs8z
	 G2FgZHlb3f4fCDm4jhYEwblST1EqUkW72OWVvkzZ9RrB5dDJ0qH/lzvOtPDjb/CnRE
	 3B00jxIi2imWCxG9CVCCS/971hgJbbvre+VrLLvZbnuu7v98OdSdmmpMGNPsfWH6pX
	 /enfx1K6l2vtQ7n8CCKthU+xiOUC5N2Mz8UFmDq0Hc1H3FIbG83Nryb0qXZUI5OePn
	 B/4PzjVqfLMbg==
Date: Fri, 5 Sep 2025 08:34:49 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com,
	u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Josua Mayer <josua@solid-run.com>,
	Logan Bristol <logan.bristol@utexas.edu>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v3 17/33] arm64: dts: ti: k3-am642-sr-som: Add missing
 cfg for TI IPC Firmware
Message-ID: <20250905063449.GA6194@francesco-nb>
References: <20250905051846.1189612-1-b-padhi@ti.com>
 <20250905051846.1189612-18-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905051846.1189612-18-b-padhi@ti.com>

On Fri, Sep 05, 2025 at 10:48:30AM +0530, Beleswar Padhi wrote:
> Currently, only R5F remote processors are enabled for k3-am642-sr SoMs,
> whereas the M4F in MCU domain is disabled. Enable the M4F remote
> processor at board level by reserving memory carveouts and assigning
> mailboxes.
> 
> While at it, reserve the MAIN domain timers that are used by R5F remote
> processors for ticks to avoid rproc crashes. This config aligns with
> other AM64 boards and can be refactored out later.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> Cc: Josua Mayer <josua@solid-run.com>
> Cc: Logan Bristol <logan.bristol@utexas.edu>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Requesting for review/test of this patch.
> 
> v3: Changelog:
> 1. None
> 
> Link to v2:
> https://lore.kernel.org/all/20250823160901.2177841-18-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 27/33] to [PATCH v2 17/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-28-b-padhi@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi | 54 +++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> index 81adae0a8e55..8cb61f831734 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> @@ -162,6 +162,24 @@ main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
>  			reg = <0x00 0xa3100000 0x00 0xf00000>;
>  			no-map;
>  		};
> +
> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {

this must be

mcu_m4fss_dma_memory_region: memory@a4000000

the device tree specification requires generic node names, my comment [1]
had nothing specific on verdin am62/am62p.

Francesco

[1] https://lore.kernel.org/all/20250821060629.GB7503@francesco-nb/

