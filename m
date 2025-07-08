Return-Path: <linux-kernel+bounces-722019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F999AFD1D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395F5481A19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9A2E54DC;
	Tue,  8 Jul 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgL1aIwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9372E4985;
	Tue,  8 Jul 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992648; cv=none; b=pcK0TiUcfsBrDLAqrEHsawsEcPRhwThaqWJJEp2UTSacNCr9qpbL/lp28T+Xd3KvaaPqfWb8fqhiN6v+XXq/3laKlSblnb4PjzGymn2RJYHQ15s0bPfcHSFt3dLk8loU1yGTcHlgfYv4djAyAqc2CHxOkSpESL+Mq2UiVmufwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992648; c=relaxed/simple;
	bh=E2MH6Era3uaTUyq6UQkdrQU623x75zpfdpctt6OS6N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6fyATLyqz7pOUfJPlwkVirpmtK7tk6xgbWds9mGNrVIrqNtlZqYGNAXNOkWxE3irt6lunDGborS2UuD3uuCj0jms+he3PNSWKXN9MdcsdCpichQadeUCXeizCb/lqXt2WLO649bp1Z3X3LVJBaH5IRUq3eSK3eXwj421VmmxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgL1aIwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCF8C4CEF8;
	Tue,  8 Jul 2025 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992647;
	bh=E2MH6Era3uaTUyq6UQkdrQU623x75zpfdpctt6OS6N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgL1aIwpNDOsBhu1lHtzt/gdL7gFViln6CKGKjxHod0zyR2fLCbowFPIjsmwrutLC
	 gHob9L7dauu0Y/QYDTiGGJI9hkGHHC6LacoeIUX3k3WEkFU8qQJeUs4C/ljg4IM81I
	 n7JF9pyG5djAD/QPmt9ZtI9jW+irROhMMzukGAgbAj343qjRffn3mkLOyzwhT3vpin
	 2Dg9e0e6fprGw8p9Ro0/426mcziDZDyHst+e4yANb4MisqoibpC1aZ9d5hFJ5MpGTk
	 R4ZFmdjIuUD2Jn/G/K0N870yt+zdH0MfEARHWiTriEYlNKlMqsisRY6Y74E+cvDPUf
	 7AS8TpPrL3jhg==
Date: Tue, 8 Jul 2025 11:37:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: conor+dt@kernel.org, Cyan Yang <cyan.yang@sifive.com>,
	krzk+dt@kernel.org, Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: power: Add SiFive Domain Management
 controllers
Message-ID: <175199264440.598704.6992619905695386304.robh@kernel.org>
References: <20250702091236.5281-1-nick.hu@sifive.com>
 <20250702091236.5281-2-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702091236.5281-2-nick.hu@sifive.com>


On Wed, 02 Jul 2025 17:12:34 +0800, Nick Hu wrote:
> SiFive Domain Management controller includes the following components
> - SiFive Tile Management Controller
> - SiFive Cluster Management Controller
> - SiFive Core Complex Management Controller
> 
> These controllers control the clock and power domain of the
> corresponding domain.
> 
> Add `- {}` for the first entry [1][2]. Once the SoCs are ready, we will
> add the SoC compatible string at that time.
> 
> Links:
> - [1] https://lore.kernel.org/lkml/20250311195953.GA14239-robh@kernel.org/
> - [2] https://lore.kernel.org/lkml/CAKddAkAzDGL-7MbroRqQnZzPXOquUMKNuGGppqB-d_XZXbcvBA@mail.gmail.com/T/#t
> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>  .../devicetree/bindings/power/sifive,tmc.yaml | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/sifive,tmc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


