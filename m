Return-Path: <linux-kernel+bounces-876034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11890C1A7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55A274FB47A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E6346E51;
	Wed, 29 Oct 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAoZkdnD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077337A3DD;
	Wed, 29 Oct 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741285; cv=none; b=MS2tjgz/pC2vezDnGF2twTjftO5uxwLnDYVmFGAFJ8rMEMZC138355YNlUIMVYSqIforzwASe+uQkc3UWyef80DbmUvMeNGHXRPpOfqFaqwqPGOl/VH6aVs+/+XS3JoZkCa55ecFXdi0ZDRyVVGERenIborRHAfvMRJB5AZBlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741285; c=relaxed/simple;
	bh=wCMm5SMLDdbe9NGRhjkjnjQ3ipki5USRE6K4jHu3HZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7zIm1VxlgXSWDIzNOVTIveRdoMnXEPlUaBHmvJDSTVeyee30XTc8AFwnf9fs9nXdDs62nJtSVRmDPoUVKYR8Pi2ClBHwDSItBWUsh2C8l/l1DvqAIzF665Up7pjXEMdPBfIBi5Dq/kVxxRcYG/lPiaWCAtlijBrPnHldfCyG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAoZkdnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31C3C4CEF7;
	Wed, 29 Oct 2025 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761741284;
	bh=wCMm5SMLDdbe9NGRhjkjnjQ3ipki5USRE6K4jHu3HZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAoZkdnDmGj3UyvKdz6+m9HHFwbxnJj2IVJ8/pmiqDkA1pdcx7bSjLZsgRSfT+CQG
	 p/dtNIbPQoOukYZ1NwnGe5ble2MK9Q0ggUt25EejCyGs3fhNqM8FOgNGiVEHcSZCUC
	 cQbaNn9y0uI2JjZ+82xdL2LTev2Pi/S+dD8EUCU5HzWzvieHXUb5Sv98vPnifX3CeM
	 2i3DRAtYIRzcv4p5XErrinObDzOE1OfbgAA25sUAq/BxNWnG/Pwo3q0AJtWvByA+08
	 +Ev561SFthENk989DpbA0eMqEHeza3hEvbrMF5lD2lS85dVGbKDgvHtiDNpRsAcRyr
	 wd8aeTiGVloPg==
Date: Wed, 29 Oct 2025 12:34:36 +0000
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
Subject: Re: [PATCH v3 1/5] dt-bindings: reset: thead,th1520-reset: Remove
 non-VO-subsystem resets
Message-ID: <aQIJ3Ei9lziyQc8s@gen8>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014131032.49616-2-ziyao@disroot.org>

On Tue, Oct 14, 2025 at 01:10:28PM +0000, Yao Zi wrote:
> Registers in control of TH1520_RESET_ID_{NPU,WDT0,WDT1} belong to AP
> reset controller, not the VO one which is documented as
> "thead,th1520-reset" and is the only reset controller supported for
> TH1520 for now.
> 
> Let's remove the IDs, leaving them to be implemented by AP-subsystem
> reset controller in the future.
> 
> Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  include/dt-bindings/reset/thead,th1520-reset.h | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Drew Fustini <fustini@kernel.org>

