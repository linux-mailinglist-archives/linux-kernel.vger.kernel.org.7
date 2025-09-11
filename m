Return-Path: <linux-kernel+bounces-811488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26134B529D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A51C25E35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CAF26CE39;
	Thu, 11 Sep 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga4iNlc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E026A0B3;
	Thu, 11 Sep 2025 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575572; cv=none; b=COW+nOom/BAMROx+R+i2iGUJ7WErlVV8v/b+7nLcDxgRe+p9AAgRhitjoibKPMLbJMjRwZZD7u0ZCKjNxKpOxXT8WhcT+M341JlOobaW7xSA6cOVkfooOMpt1EAYKGZmrg6Y2VZ+fXqWJa/rSX63H3XGD41UMGvkMgTbLwD+Jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575572; c=relaxed/simple;
	bh=CmezHyB1HkJJeJ1CoSh2IlnsvQ1nyPiZtOoD1baW30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv54mR6246NTp0hkd5APr34b/IsGbe+12F27B0yFF98pRmukvgSxvkvrD6kHLMPUcveRNoWH1VCoc06JX9YwoEjG+8nj69oiQWYgcBDQRLOJjBoimbAUoXV6jbG7TqbwAgQRuVFdRGVZ/CGhHE/M2g2zJJKWuffw7wrmGMNHZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga4iNlc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA56C4CEF1;
	Thu, 11 Sep 2025 07:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757575572;
	bh=CmezHyB1HkJJeJ1CoSh2IlnsvQ1nyPiZtOoD1baW30A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ga4iNlc3m/a0A/uuqP82l5CqNf3d1laV3smTHtuMkZq+qHJA0/Mbnjr3EfNLZS2Uc
	 9RAyaaXO6SJXyM5ai+DFUFNKcTJbUTEzXo0jHun5vnr5C21B7giTi5o/kr0FMG9qIu
	 hh9Rp9YVkksg+RW+Khk1IirfwdYi/CY8jhFLexNamb2qwuxwDj7oaTDXTq2q9i/kYA
	 s7teDS2/NIdkIciIcbmyWuO2P+M1D/ZNA41lbt/vDZpUPum1KXfiocTGL3OjyKjfRN
	 R8nxrEGRoR8UrER5JIZcHuhj89z90x4DZ9UCpby3HmFFjrcSIR3J2+8vyyLsFByXuG
	 KPMhJmpD7rxVQ==
Date: Thu, 11 Sep 2025 09:26:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
Message-ID: <20250911-thundering-wildebeest-of-awe-eddf22@kuoka>
References: <20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com>
 <20250911-k1-i2s-v3-1-57f173732f9c@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911-k1-i2s-v3-1-57f173732f9c@linux.spacemit.com>

On Thu, Sep 11, 2025 at 01:47:10PM +0800, Troy Mitchell wrote:
> Add dt-binding for the i2s driver of SpacemiT's K1 SoC.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


