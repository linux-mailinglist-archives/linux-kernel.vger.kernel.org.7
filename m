Return-Path: <linux-kernel+bounces-826299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30342B8E227
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2284E189C766
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF879254846;
	Sun, 21 Sep 2025 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/aryhQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D335947;
	Sun, 21 Sep 2025 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476018; cv=none; b=jBiakTQhRpugnnbFrQdcVirhtCbYCy2/CknrmlveB5xaiQHUpcb/RvzZbSBrbwkPAPas0f55DaHmDUpO3+kFPMnOv2jD2rv/bRyKY1bIGVwE6EY9HWcDEe1OprVGLSLxlONdWYsPPG6vXD5d3UJ0huuRKmxw+M7ZBJLItuhEAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476018; c=relaxed/simple;
	bh=7YfsV2G99r80KQssVgIJbmMWK30nEvZ43WlPBGSS9xY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=T2Di/8cHhsNayEZs8AJXsdvGWf5ajYeXwydH95AyXZgh5OxVRu4ChO/h+avlisEKFa/gWWAYB9OF95hrmP7J8YC6jIJ1Ms2z2V7asQsJ8Pt6jntDgJ+42upwPj324knv3icm4ptmlEwfJl5cJzD2Mb8F3+sAkbSmEiaNKgTbWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/aryhQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE141C4CEE7;
	Sun, 21 Sep 2025 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758476018;
	bh=7YfsV2G99r80KQssVgIJbmMWK30nEvZ43WlPBGSS9xY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Y/aryhQCnJCNYHglVF1skKXdPHR3ip82tNfG7amdGWDwc5a0EVPCtukBDVm9qCIPk
	 77ozaj6h5O46It0OOoeoiUTDJCea3+f9qEYA0R9gxNsydHdOe0i54uJIwq+IxgXqNc
	 tTAXY32sZKrQQC1juDFSZw7JWcOIDhiIuFGuuoqzMMZzfNbhm/Ad/A5Hriv3n1zX24
	 XS8x/Radi9W09C3ksC8zLD0r/Z1fZp1Gi3CAIu53sr9N6CkKa5WF3WS8XZyOPiIyx6
	 BZYIEyH3UDyKKZaBbHQl9rsieo2UMmF5/VzrjHdPVCcmpBBenaikmhNLR5n/30f3jg
	 1/RlDtyqdwa0A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250625-upstream_rcc_mp21-v4-3-9368a86c8515@foss.st.com>
References: <20250625-upstream_rcc_mp21-v4-0-9368a86c8515@foss.st.com> <20250625-upstream_rcc_mp21-v4-3-9368a86c8515@foss.st.com>
Subject: Re: [PATCH RESEND v4 3/3] dt-bindings: stm32: cosmetic fixes for STM32MP25 clock and reset bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>
Date: Sun, 21 Sep 2025 10:33:36 -0700
Message-ID: <175847601668.4354.1665490967315325613@lazor>
User-Agent: alot/0.11

Quoting Gabriel Fernandez (2025-06-25 02:07:26)
> - drop minItems from access-controllers
> - remove rcc label from example
> - fixes typos
> - remove double '::' from 'See also::'
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

