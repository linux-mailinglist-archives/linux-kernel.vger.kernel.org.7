Return-Path: <linux-kernel+bounces-818895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F182EB597BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76CD16A851
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF3309DB0;
	Tue, 16 Sep 2025 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPi5McCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877491D7E41;
	Tue, 16 Sep 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029659; cv=none; b=pAigBB5I9sz/x8s4sg7VdIVVrTu2BRzTD/2Wn5EBNuZb4QHS7pm5OqQ0i2Dj+I5TkSFMfQ5wMzq9AT8A48HGWQZsttqPcStP7+4g+7cbdbolD/q2mUNm5l3ObDN9gCSx+8cspbJaAZ4VflNr3Gf+LgaNWZjiazyBop8iF5udiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029659; c=relaxed/simple;
	bh=iIqAO6WgRjC+zh76V3WMiojvREdZ40UZ4E3S/teNB/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSpDYzkKuaEGgh9gxT+OVq6z6bljLkwShBmOvfTSIqJtsFUgaeR5qnw7DL/y2MpJfa9Ev9+eGPODxtgsZSA7FlxckFQL7hXFkpILoVSmVz2lLdCeHCSkOYVhuOYjsLFf24QiqqfmB1Od9AqRzEruOSsAvLFRMjNLHc8fEBgP4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPi5McCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376EC4CEEB;
	Tue, 16 Sep 2025 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758029659;
	bh=iIqAO6WgRjC+zh76V3WMiojvREdZ40UZ4E3S/teNB/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPi5McCRA7fPfhCA/bg7s2uhMT0Eapl0OFyhii8xgYH2qsWZW9epG0OgYUWHnrzv+
	 4fVCRSUkeFNz4sfozuwPzd/oGToZl2ZiTy7w4vIzmEF1NOyEMWkmwci+CTvvQJ7Dir
	 7kat2Ojjy5GB/UOZ28lr7jxBjmos+qNZmOThuKFNkpVbVGvdp8EFb/peo6DdmDO9Oc
	 8c7JK7D/sGsuGLB6bBrmocICesgzPpGoykKff0Pw2BrcxpXFJXrcza82WK3CaEJNsC
	 MTsR7MIRfsvWLroBrA0pLv80f+S87rrWBHdncP/bpgv7GmwJa9crgb1dn01Eg337xG
	 CnASMvShQ4g4g==
Date: Tue, 16 Sep 2025 08:34:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	Michael Ellerman <mpe@kernel.org>,
	Michael Neuling <mikey@neuling.org>, Andy Gross <agross@kernel.org>,
	Joel Stanley <jms@tenstorrent.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>, Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 2/7] dt-bindings: riscv: Add Tenstorrent Blackhole
 compatible
Message-ID: <175802965741.3650693.16028674427033969349.robh@kernel.org>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-2-ddb0d6860fe5@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-tt-bh-dts-v1-2-ddb0d6860fe5@tenstorrent.com>


On Sat, 13 Sep 2025 14:31:01 -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@tenstorrent.com>
> 
> Add compatibles for the Tenstorrent Blackhole A0 SoC PCIe card.
> 
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  .../devicetree/bindings/riscv/tenstorrent.yaml     | 28 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++++++
>  2 files changed, 36 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


