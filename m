Return-Path: <linux-kernel+bounces-853199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0410BDAE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADCC405946
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06330BF7F;
	Tue, 14 Oct 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HG6OWkST"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52A30B51C;
	Tue, 14 Oct 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465220; cv=none; b=WjCcnSo45JQ2mHTjRBN2v62rNpYVAa8BbgI5DdZs+bow6VVaASqe5XOYi9qSLuI10lO/WqA3jNxRIC9X3qBKNoD8vKGwYObXxmJihdiZvCaBbqP1lYoBXK8DFk+3KX9vwa2ZvTt/mABHvVdoePQjU82g9QR/jsSevSnUiqSX+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465220; c=relaxed/simple;
	bh=mQF+9ud5enuo0GYpbVv/BONkEntXUcr+qFfy2VVX9UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrEpF6h36t72kNZIW6Lk7Jg2Nl8/8txt/vawbU+tJTths649oyXyCX6MMkGMY8IfnuXZPMMM+wOLXPvMdH+f7ivv0uHCRStIQOmsjTV7M/iZggwZsJjP6UMnq5Bp+VRAE2m+rzvIpV/SXV/Fey1+M0Q2s9oGUwBr/hAXpdrSgck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HG6OWkST; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=VKxAQI/icwrsALd3yt9ZYYrax5U+WNqBH1n83Wd3UMA=; b=HG6OWkST/IexkAxDFqbAPDCqBA
	vjIkyhoHebXbSiI+rqLwCIlMLt2SoF/Q+cKr2s5zNU3490kQB0BiwLPZPkrI9FllyKmJxO+JCt8bx
	Tsvmn1VbTch4GIjjCafL1PK4NDAnBFYWCaIusVzssG6dCKKo+IYwp8i8bXNydV8BHvAdfGx7w533Q
	xHcgroIL5A0HON64oxXNhMIyR2xerN5VmIEO/zeFpRXn48nunWgAz9MuJRLO0fF4FHPEb+SMBU69w
	uBI8UtEiLYar8OQE8hJ3AGtvbTTxtQuXMzw1M4iyGoPiIC+DaTDuWQHBR3rwKuOCUtFI7cdjxJdhB
	rfRQje4A==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQB-0001Gj-6X; Tue, 14 Oct 2025 20:06:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Jonker <jbx6244@gmail.com>,
	Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Drop 'rockchip,grf' prop from tsadc on rk3328
Date: Tue, 14 Oct 2025 20:06:35 +0200
Message-ID: <176046473175.1662867.15777985050220275071.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251008082143.242270-1-didi.debian@cknow.org>
References: <20251008082143.242270-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 08 Oct 2025 10:21:22 +0200, Diederik de Haas wrote:
> The 'rockchip,grf' property for tsadc in rk3328 wasn't actually used in
> the driver and is no longer allowed in the DT since commit
> e881662aa06a ("dt-bindings: thermal: rockchip: Tighten grf requirements")
> 
> So remove that property which fixes the following DT validation issue
> 
>   tsadc@ff250000 (rockchip,rk3328-tsadc): rockchip,grf: False schema does not allow [[58]]
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Drop 'rockchip,grf' prop from tsadc on rk3328
      commit: afb5f84b216d14a71e2962ed569edcea30cf9763

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

