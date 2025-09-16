Return-Path: <linux-kernel+bounces-818901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBA2B597CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B913B3426
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7D30F801;
	Tue, 16 Sep 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjisEOPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A743147;
	Tue, 16 Sep 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029842; cv=none; b=OP0zaya/AmhsjXtP5qLKAVN/LI3RQZW6lHxFUNWazWWgq/SKK3DrjpN1SSwoWa4YDataLTy6Y+kyrGaSjXByFiOxAriVmct7bib4h0eVepx3WCyLVxwLmKo+V6Ni42Ci/HodhDk5Gp0pQMzO4TIBag05qB0gq9WK8BJTKJd0A/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029842; c=relaxed/simple;
	bh=YEW3a09Zeo99Z0N5BK6GqtsYttsWt77Qxdg0YjLXzmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRZFwtwRYVLO19tAXbjK6Znw5rkZ85r2ftwKk5qZLBhjGGDZ6ypml7sLagKpXRNyDNKzQnba6EyjNWfD5F6xC/BR+L15Q+rOCJRi641wrtiR0YzeOX+n7i+qGUDmVe8EnSG+gXfZ8OYcHIk3FWOAukn9lh+SFwDFOMIOF/99XXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjisEOPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62430C4CEEB;
	Tue, 16 Sep 2025 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758029841;
	bh=YEW3a09Zeo99Z0N5BK6GqtsYttsWt77Qxdg0YjLXzmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjisEOPF6AFv8vzhh/+nSyHm2BXKBl1eVs+ZiBzbUv98tukbER3ltymiT/yHUG+Rk
	 HYIS3ZO7sX/Vxa75tff3Jwy3URniNAvzY6uTNmd2brkyCEDgkykNCbLBly0RRQZ5SG
	 yoy1V1c0wg6C5B6xq3SKaytBQHWrxXhOKPvZdK1Rt5aQU4zorAN0OjCplY0iyKX6Ua
	 aR/ShmjtscE9rpD79VXihm53c+x7Mjq4CVvp9iQEIJrXK8nAH4lEJWH21CTCjZOUho
	 MgBrcdDvpUrkDPdSGiAHU6uc0Q2RiUaNVhSzz036g0eX6yaNNphnwOseFsJiQib5ug
	 HsFSrJItUkG7w==
Date: Tue, 16 Sep 2025 08:37:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
	Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Joel Stanley <jms@tenstorrent.com>, Andy Gross <agross@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/7] dt-bindings: riscv: cpus: Add SiFive X280 compatible
Message-ID: <175802983980.3653941.6041553285815630800.robh@kernel.org>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-3-ddb0d6860fe5@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-tt-bh-dts-v1-3-ddb0d6860fe5@tenstorrent.com>


On Sat, 13 Sep 2025 14:31:02 -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@tenstorrent.com>
> 
> Document compatible for the SiFive X280 RISC-V core.
> 
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


