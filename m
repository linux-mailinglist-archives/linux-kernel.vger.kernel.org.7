Return-Path: <linux-kernel+bounces-892531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59BC454B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06CB3B2D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BF2F691B;
	Mon, 10 Nov 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBMrRrlR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2F261573;
	Mon, 10 Nov 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761774; cv=none; b=oOhS32YufXAOHUbJtRPlTLQsCB3bvcrbz1dnS2zNaE5NW+g4BWDRhjUpF1srD50cPzeAZ9Ua0dt/maOjp3JNS4roZa09KPHx+7QZkA1E5PwTykl+aDMYNk01tmHqo/OPumOK9BTARzyczgmHyIxdU22fgW9gtFdvk6KfBrsjcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761774; c=relaxed/simple;
	bh=Mjf/udNQvIHvbjf5mPBHq7ehCEM72149U5Hh1Lrz5ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwoIV2JMVFIJNhU03Bl5klDbuhso0W4PN49jk0ZkbUuqxwFGW4jUKvX4xT+V2mHpedeWLpEvSCqmy6w4AH6Bo1JrELzkJFO9d84tBffI0cmpfu7AAIgLTbXW3DoPk7ZIgjW2XM9G2JCUJGEsRDIUDZHNCG4El8B/Ds8P+ZmozeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBMrRrlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C099C4CEF5;
	Mon, 10 Nov 2025 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762761773;
	bh=Mjf/udNQvIHvbjf5mPBHq7ehCEM72149U5Hh1Lrz5ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBMrRrlRgxK97/xHqRY3xPElLV3ZBVHtIgd85mJgW+cVB7zEhaGbQL4RL+Vr+r9nG
	 epRumM9yhggPC7tzZ8295w2DkXrcAH9Z11iLsiHGqFRdQN6xRTukNlaqD090LFCpvw
	 I8s1vFxvExNnAtg39YD8xz5l8QxDiqILzJXtTGttkY6/aa6ordtM4OF7tsRH597LN/
	 /Pff4IoKUbiVs1FiDnMPko8lpkm9Iqv3u3Fw5eMzgSenXd3aqssqztltbU0dYREbu4
	 pGCm+F48PrLWayTWT6msy0vgZcAmFDiiBmRIcehuFEEIWOhfPAk5BALh5fRsMcHqby
	 /vzLfCrcfQ/ww==
Date: Mon, 10 Nov 2025 09:02:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: riscv: spacemit: Add OrangePi R2S board
Message-ID: <20251110-impressive-dalmatian-of-luck-4d1441@kuoka>
References: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
 <20251109222858.3085488-2-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109222858.3085488-2-michael.opdenacker@rootcommit.com>

On Sun, Nov 09, 2025 at 10:29:57PM +0000, michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Document the compatible string for the OrangePi R2S board [1], which
> is marketed as using the Ky X1 SoC but is in fact identical to
> the SpacemiT K1 SoC [2].
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> index 52fe39296031..1b2f279d31f9 100644
> --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -24,6 +24,7 @@ properties:
>                - milkv,jupiter
>                - spacemit,musepi-pro
>                - xunlong,orangepi-rv2
> +              - xunlong,orangepi-r2s

2 < v.

Best regards,
Krzysztof


