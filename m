Return-Path: <linux-kernel+bounces-818913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B670EB59805
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B9461951
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FF315D38;
	Tue, 16 Sep 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljdjCTkG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3A2F7AB1;
	Tue, 16 Sep 2025 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030241; cv=none; b=oscjmMpf63qkcdryalQEyLLSebdu6oJCiE95NbZyGI7R48wCUQfh1jv2EQUXg6lWYTbjpxHDbP52ufu7owdrwqPEEuxr91nyOanyWKShiOGQxBUcodaUoKD/agmQuNgDLcdFT6GMn4ctMLUsrK2Y2R70SKp0oXcrIeRZMLOFmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030241; c=relaxed/simple;
	bh=PaMXEFXqCAuG12KEQ4djKfa6Cip7cabwIbwPaQn8wY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCMQjLG39N0/ef/gExI31W7Zz6MWuCkOI4SvpM4M7y6q/McirfBV+8CTdPsmJtVDjtgfVyKytP+hyjK8t1WNOEsTp+oHB5j7WYs+9rr1zSC75ydP9k9eT+i/KIphkOi8venF928K5YE2fVYPPULt/gdnyS5JQFA7gVZiDltNHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljdjCTkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3966C4CEEB;
	Tue, 16 Sep 2025 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758030241;
	bh=PaMXEFXqCAuG12KEQ4djKfa6Cip7cabwIbwPaQn8wY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljdjCTkGxZRvb0F7FEBCvF8MQvB8OpQlHE+8U5+ljM2dNkPq/jtyw3AYlywCWUB1L
	 GD4yIqOid2EWZ5zKmN/h7A5ulypmjpBgT8ztUSUR0m/bbJal5/a/xuReQRkTYGo3PE
	 IhmdHuKSmAFKstZdjPFBsnbr2E6wqoUgl90AIRy6/CG4dm9+haJYr13LVSD61Snai3
	 TZ0K6/J+qkwq7cY0pYSKZDJKQgn3zX/heNEEXzrFVj7J8mC2t2fRqS2ucj5VUw6cnH
	 QBcWHDkMmHYirrBPbcz7Z9ca4cRZZU25bWgyzUXy9eBu2zc9C1E65PQ62MXxBkBvRU
	 pBxHVu/xdGfzA==
Date: Tue, 16 Sep 2025 08:44:00 -0500
From: Rob Herring <robh@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>,
	Joel Stanley <jms@tenstorrent.com>, Joel Stanley <joel@jms.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH 4/7] dt-bindings: timers: Add Tenstorrent Blackhole
 compatible
Message-ID: <20250916134400.GA3654122-robh@kernel.org>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-4-ddb0d6860fe5@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-tt-bh-dts-v1-4-ddb0d6860fe5@tenstorrent.com>

On Sat, Sep 13, 2025 at 02:31:03PM -0700, Drew Fustini wrote:
> From: Drew Fustini <dfustini@tenstorrent.com>
> 
> Document clint compatible for the Tenstorrent Blackhole A0 SoC.
> 
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index d85a1a088b35dabc0aa202475b926302705c4cf1..198146c59de0c95a2ffa052c8d4d7aa3f91f8e92 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -36,6 +36,7 @@ properties:
>                - starfive,jh7100-clint   # StarFive JH7100
>                - starfive,jh7110-clint   # StarFive JH7110
>                - starfive,jh8100-clint   # StarFive JH8100
> +              - tenstorrent,blackhole-a0-clint # Tenstorrent Blackhole

We usually don't put Si versions (A0) in compatible strings unless later 
versions changed in incompatible ways. Perhaps if you already knew that 
B0 was different, then it would be appropriate. Or am I misunderstanding 
what A0 means?

Rob

