Return-Path: <linux-kernel+bounces-847451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB289BCADD8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CE51354E17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A062749C5;
	Thu,  9 Oct 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIveV+BN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC732277C94;
	Thu,  9 Oct 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043433; cv=none; b=DktfvEUJv5H+dZ1fgFmNFrs84vkIqrtQBnDuQ5i1MZP6sHuCFPAzRpM2GljqDv36bj54Zx70R5OrU6BqoNR3qE7O/KYQXhv6idRaM358y4j7WPFp3FwSU1DkEFcqqg7adQLxTLwiJ9qDmtt6HPdldcBz5/yBcQ0DSXUxLrik+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043433; c=relaxed/simple;
	bh=lBI1eCHf+aO2ITFQm4OLOPGZVt4N95diGCPMOVo2W/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3E8O+CY28g0PLbMy59JcIKI8l63ccBGG/vPeEn1J5q2fZnwJJz7zgYqtX9SHc7FSWAa/z6mvL3mM9dc9AeC1Jm8KcNlyLXmhOv+lft1rQtddqtDI7HnNIlX2TbkMVbDUgGsXtneXthflt+FaAAGolKuNILNjAagOzc+sTC3T8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIveV+BN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ED3C4CEFE;
	Thu,  9 Oct 2025 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760043433;
	bh=lBI1eCHf+aO2ITFQm4OLOPGZVt4N95diGCPMOVo2W/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIveV+BNg17Ru92Km71oihk9DiiSLbwqT02UzgdvMxjmgHzaDS5b59dqnEQNdfLyU
	 qSZWAHieuUqI6mJacQ3E5y0Rna5r678zB2CYAzh+pkDHugqwJt8Ebu+kS/GB1URCve
	 cLwLftPz1LHHGgwq4S0oaoP/0uKZEUWbvIDh2MhHpkB5EQiVDpGXjofX0fRrBtlBeq
	 oro20Dyn8JLwie1GXZRAf0Yl7kqTWW2Uoje4KaYxUXBuKlTHhlCWuW11+ZwbUA0G/4
	 PZSkAaYOVl03rOE/abY3jwHSnFPxhcAOZDNVO4SQoke69CyCSFIpbyNhpAX6iWf48F
	 oVTmPgfhc0hEg==
Date: Thu, 9 Oct 2025 15:57:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Neuling <mikey@neuling.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
	devicetree@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Anirudh Srinivasan <asrinivasan@tenstorrent.com>,
	Drew Fustini <dfustini@oss.tenstorrent.com>,
	Joel Stanley <joel@jms.id.au>, Andy Gross <agross@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@kernel.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: interrupt-controller: Add
 Tenstorrent Blackhole compatible
Message-ID: <176004343108.3328456.14834767754119467373.robh@kernel.org>
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
 <20251006-tt-bh-dts-v2-5-ed90dc4b3e22@oss.tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-tt-bh-dts-v2-5-ed90dc4b3e22@oss.tenstorrent.com>


On Mon, 06 Oct 2025 14:21:45 -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@oss.tenstorrent.com>
> 
> Document compatible for the PLIC in the Tenstorrent Blackhole SoC.
> 
> Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
> ---
>  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


