Return-Path: <linux-kernel+bounces-810705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8379FB51E27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9265E2F01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0527B4F7;
	Wed, 10 Sep 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVnlEL1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0027602F;
	Wed, 10 Sep 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522846; cv=none; b=g6MgQAxMK0wxA6DoxVk5JDEoV2/sj6Cbdv+V/GBJR5AXXEn3N7uYo68sfaKw5rGGHO4gNG0BqyGhWkZkP+9VpjpBdeCNUFyqvKmkUQrdbVKhDyNwV/5FlVEE6GcTcnRCzDwrbMO2oDZfkg1UlWS5Nc0rQRkUWIHTk5bdpB2bJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522846; c=relaxed/simple;
	bh=62Kld7JTWpGcejeXzL2pSMaMWwHGWlpqGWR2nvOnp4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rFPpcf+RWzdv/MHj+TXZH9749RmwTgZUGn6VAY3EQBYqWV0Kfcq2iU3fiM0m31AhUt+4TWxl0X+XtNytmwGg+L+pOmrB5rmp/AvBsmL3BVvPbbSI2mSDjIaEBjwBtAtMqGe82ofKmKuD+hvDQNm6AWiZ47Em/0HAWyFBb83Tdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVnlEL1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD1C4CEEB;
	Wed, 10 Sep 2025 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522845;
	bh=62Kld7JTWpGcejeXzL2pSMaMWwHGWlpqGWR2nvOnp4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FVnlEL1lDTV1YR+A8J7uibu4yWINGyomz3bF6CJfqS/UN6fvYIN6wqbHiIbf0/box
	 3FAJG98TDCgaw7pzqq0BgmcM/FoWbrLw+G5U+VLpz/mr+Rr4jnzg7sdvgb2FBT7+Wl
	 30Nf8QazzuJsL/Di9fq/ulNdZdZVvMLzdW2ChFJxZbmXrsuqfuePJ+KexOXmWXZSGQ
	 BbXR7CxeJ+RNUDLHeSjnon1bu43HtBqIKX/9qeRiW0ET+RVUoykGvR5Uz9IXTZmm1M
	 4/iFXIeDfd3wUmzFwNnZtNnBb+tJYHWrB4UjCIieOnj6zM1Q4CywaxKejr/vqOFWTu
	 a7WHOQ/GLn2WQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Inochi Amaoto <inochiama@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
 Longbin Li <looong.bin@gmail.com>
In-Reply-To: <20250708063038.497473-1-inochiama@gmail.com>
References: <20250708063038.497473-1-inochiama@gmail.com>
Subject: Re: [PATCH v5 0/2] riscv: sophgo: add USB phy support for CV18XX
 series
Message-Id: <175752284008.484319.10400801407053619384.b4-ty@kernel.org>
Date: Wed, 10 Sep 2025 22:17:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 08 Jul 2025 14:30:35 +0800, Inochi Amaoto wrote:
> Add USB PHY support for CV18XX/SG200X series
> 
> Changed from v4:
> - https://lore.kernel.org/all/20250611081804.1196397-1-inochiama@gmail.com
> 1. patch 1: apply Conor's tag
> 2. patch 2: remove dr_mode debugfs entry.
> 3. patch 2: simplify the cv1800_usb_phy_set_clock function
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
      commit: cdb2511bf3925ce095c31e1647c12086d34f9cc2
[2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
      commit: f0c6d776f74d1d8bda94f6f042b2919bcd615280

Best regards,
-- 
~Vinod



