Return-Path: <linux-kernel+bounces-871462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15766C0D5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA6F4F3A99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C9E2FF17D;
	Mon, 27 Oct 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTR3uudJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364B19ADBA;
	Mon, 27 Oct 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566186; cv=none; b=q6vXGvKLNd3WxmHSpuGwvhzrKamU+Uk8eb93yNMC619kWM6MeESenREX9rPa2oE6HdvaPAX0h/r5m7oip7X9Nlh0HSqdpCyoVqDanxi6Kw2FceHHCWXCPYEXvyjWWwpCWv48ouzcDIjPZ7DTVvSloacIonkqYE/z5R0/Fe4veK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566186; c=relaxed/simple;
	bh=sS1lIlP0t/Ne7eJT0CnV8aE5TtS6WT4gJ2MXWuhWQWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKLfFouWDZkS6xItxxNPD92fwdNiq7Z0EJnGD2hhJMx6skKjWcv6V5HkPlMyL/rF0don7s1448kEjxgvqK4gXx9C+Tp9eSlvrQTRt2Q2ESs+2MN/XuDhBUiEu3O8f7KvW6DzZzl+FOZiC9u1ELWIWWrkZYVtC0xI609c3Jon3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTR3uudJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82500C4CEF1;
	Mon, 27 Oct 2025 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761566186;
	bh=sS1lIlP0t/Ne7eJT0CnV8aE5TtS6WT4gJ2MXWuhWQWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTR3uudJBfLWhNLSRn3Wtwg9aDPkR2gB+WJWl/df0PCoUi43ruJfSAycB5vsYR7oe
	 iFdgNJXzkGPo0OFXaO1ymYdeWEdtnnSh95Snn+VgYz6H3FQ29DwMPqri+/Ojab656y
	 jqdIBih0bGnmez5tdtCKFGX5KM1s+hJl1F1h0FRgh1iLkf6WnuTOueA4UULvE9BWNF
	 PBT8BPRfSMtZKX1KKdAfgBzCpwWCSyWtZ/J5DpVeSHFJ2tuOVYRXLl4GU8fAzA6ZT7
	 Sez7ZjoezZbp+mXHWVlIebRKZt5pbt1o29YiqDIO16ET7Fz3WJjaYNn3Ly4KtbCF6k
	 bfZjv0VW3TCIw==
Date: Mon, 27 Oct 2025 11:56:15 +0000
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH v3 5/5] riscv: dts: thead: Add reset controllers of more
 subsystems for TH1520
Message-ID: <aP9d3-deezGtCbHr@gen8>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-6-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014131032.49616-6-ziyao@disroot.org>

On Tue, Oct 14, 2025 at 01:10:32PM +0000, Yao Zi wrote:
> Describe reset controllers for VI, MISC, AP, DSP and AO subsystems. The
> one for AO subsystem is marked as reserved, since it may be used by AON
> firmware.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index e680d1a7c821..15d64eaea89f 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -277,6 +277,12 @@ clint: timer@ffdc000000 {
>  					      <&cpu3_intc 3>, <&cpu3_intc 7>;
>  		};
>  
> +		rst_vi: reset-controller@ffe4040100 {
> +			compatible = "thead,th1520-reset-vi";
> +			reg = <0xff 0xe4040100 0x0 0x8>;

Is this intentional so that the first VI_SUBSYS register, VISYS_SW_RST
at offset 0x100, will have an offset of 0 from the thead,th1520-reset-vi
reg in the driver?

[snip]
> +		rst_dsp: reset-controller@ffef040028 {
> +			compatible = "thead,th1520-reset-dsp";
> +			reg = <0xff 0xef040028 0x0 0x4>;

Similar to rst_vi, is this intentional so that the first register,
DSPSYS_SW_RST at offset 0x28, will have an offset of 0 in the driver?

Thanks,
Drew

