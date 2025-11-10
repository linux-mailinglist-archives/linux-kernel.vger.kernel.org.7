Return-Path: <linux-kernel+bounces-892532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C53ECC454B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D12BE4E880E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981622F6931;
	Mon, 10 Nov 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE+5lcay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70622F691B;
	Mon, 10 Nov 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761818; cv=none; b=mmevLwrTntkuJdy210uROhNbpztyuu5E66L/oJ2udctOlT5mM1dg5ArkDETFIv8spktuxw+jQHTVZmr7uNkg6sFm37z7MsGufD8a6VuN3l1c1QbTEAFE7ElB/tJR+fdcc1e4idyc1uoHOwWVc6L/8iAZkeY363/9ak5qV/eknU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761818; c=relaxed/simple;
	bh=8E7+MmUZ3rjUJG1CQj7HaQRHXl/nFB6eUlYK+d/MAFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyXR+Xly2Ec0KqHHyGp2vIhRuBJ96b8EyT4inh6jZK0PtMbLdo+nr0UeZ8BP2dsjd1nTVvcR1j7aM9/7dbnreAWHM2AuUspYXs/3PUwDBvBOUwwzRLHMIfuO6BI6DjlunWBnnx+uYmLBA15B1ajxhHAd4utmgCQSwCiWT2ZPX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE+5lcay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC01FC4CEF5;
	Mon, 10 Nov 2025 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762761817;
	bh=8E7+MmUZ3rjUJG1CQj7HaQRHXl/nFB6eUlYK+d/MAFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LE+5lcayBYJbuSD1KYAjanQzgSNYWNobSSl9rDu0F9MVuKuIqwdUjgr1bIeEbYsap
	 DSinbjhKnXI8K9SsXpPBvlXfCFhc/91qS/o3aL7Skn4XPfFjcspNp5Yox6DsN8g8Ze
	 EuQeZwCqsJFpJ+DMBDBGqO3RaFuvLsOX8kvtatEj1r9pl39Z73yu97xdjFu+GRtJYR
	 Cufi7/Xpu7GYQLTRkGA889IQoiOZPmE/CDPET5Z5+c+lGNZV1GaK261/aN7unNTGhM
	 3trY8M2l32iFN4RLAVQoaYlldzuDgUsx5+UDgctTuqfZzBjLXLovn3IhkYm6DStpnK
	 5cDWZW1pcKawg==
Date: Mon, 10 Nov 2025 09:03:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] riscv: dts: spacemit: add eMMC to OrangePi R2S
Message-ID: <20251110-gay-rat-from-hyperborea-45d3cf@kuoka>
References: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
 <20251109222858.3085488-5-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109222858.3085488-5-michael.opdenacker@rootcommit.com>

On Sun, Nov 09, 2025 at 10:30:12PM +0000, michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> The OrangePi R2S board includes a 8 GB eMMC chip for storage.
> 
> It works fine with the same description as on the BananaPi F3 board DTS.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Squash the patch. You just added this board. Adding board is one commit.

Best regards,
Krzysztof


