Return-Path: <linux-kernel+bounces-727991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD74B02231
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780D45A4E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0072EF64A;
	Fri, 11 Jul 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8RWVzC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2F2AE66;
	Fri, 11 Jul 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252757; cv=none; b=j6YNMEJOiBi759QgEK7S3O2KFQ9/61xOpHMRKuO4jnvSknaPIeVJO3W0bwaOcdKpPMpvmdHtQa01wJftoYwQIud/Binlyma8BMMFkX58AZNRLdV6SaByNamc4gEtIomIpf9nq+NancrHlj7JnP2dIzZM5Ta4+/zcK5T6cH2vhBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252757; c=relaxed/simple;
	bh=37aDaZMIwQe0MnbI8n+TOJ4i1Co5chVtDfQazgIHjJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZZE5ki1Q93IIQEsmwX7tzWn0Xn39g1NTvWT+0x//+eyfltCFdRgm8392W9SDGYvtgjg+5GQ9R40me+rWNrfYVL0jE+8rkniw8WaManfzmT6EEbJkb0NQaAS5hq2XpSGCnsTpHSIutOET37Atkklngqb3jBqpdlHESbY5bB5605A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8RWVzC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2CCC4CEED;
	Fri, 11 Jul 2025 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752252757;
	bh=37aDaZMIwQe0MnbI8n+TOJ4i1Co5chVtDfQazgIHjJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y8RWVzC5aaFoplaLrZVGviuxjnrXgUTTc1YujyZ+kDYetAOaaaXiiTuU08K2rNKiI
	 vFemxUCHfjaNFj35eIPBFU+kGlAV6RvkUg/+g5eKfHKDpJiTXiKzN6OKMHLEIKKYSd
	 GaLLOXYgiQROidWlt0zzqIHf54gWwK4EGvsTQqQefhpzIhwnTDE6mn0j2uKel/X9iN
	 +ssvqr7F+PQmVvMcy27+nnqLrOuHtu29/L5ovZ1gt6su7fBxmk6mBux6dUR8JZCw0B
	 Do7pUNcAAOOuB8VCN3EAMMsM/5snWNK1CgjsqtFyVzQogAajV7/7WsevrwDiqJjYnE
	 h2VOZngIXfDfQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Lala Lin <lala.lin@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250610063431.2955757-1-wenst@chromium.org>
References: <20250610063431.2955757-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH v2 0/2] arm64: mediatek: Enable efuse GPU
 speed bin post-processing
Message-Id: <175225275439.24435.9556126932579316402.b4-ty@kernel.org>
Date: Fri, 11 Jul 2025 17:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 10 Jun 2025 14:34:28 +0800, Chen-Yu Tsai wrote:
> This is v2 of the MT8188 efuse GPU speed bin post-processing enablement
> patches. In v1 [1] the change was made to the driver. Angelo, the platform
> maintainer believes the change should be made to the DT binding instead
> [2]. v2 adopts Angelo's argument.
> 
> Patch 1 updates the efuse DT binding so that MT8186 is a base compatible
> with no fallback, and MT8188 falls back to MT8186.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: nvmem: mediatek: efuse: split MT8186/MT8188 from base version
      commit: ce32f3cdfbc31dab626e20122e577f75ea46b940

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


