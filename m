Return-Path: <linux-kernel+bounces-861436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88895BF2BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A9C74F7FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7673321A1;
	Mon, 20 Oct 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6YX0EwU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4017A2F0;
	Mon, 20 Oct 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981823; cv=none; b=vDvtUbN/tYW+2+CivXkAVImz2udTIcDn+Z6uhdi3a/yenUJk3hqBIQsx1olLfxMPwJkWWSynHGrRqOpZUTC8TwQKrLqOmMQXoC505g94mxN51b+u50KtTbdPp10+Ak0iASSEOAinhJz4N4VT6Ezlej9MKaSoQqGkZM7vAHOVHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981823; c=relaxed/simple;
	bh=K9wyPo0cQ9GL77ffKurdZDil7DRu7VmOSh2SzUXV9Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIoOwJDvHxv2+s48Dquu3XdWoXbo5mYvPcp0z0sDtwzPZ3ywUoUZujU01qB3JPGWtHI5Z+tI9fDydbyZYRUt6eD2tWwQtnyq69t2Bgf6aUsYkVAh3ia//jogHZUOEewf7GT5dzL6IPaLAGAMuLlRDU3puFX+ZU8fCIEGZQKsAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6YX0EwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B0BC4CEF9;
	Mon, 20 Oct 2025 17:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981822;
	bh=K9wyPo0cQ9GL77ffKurdZDil7DRu7VmOSh2SzUXV9Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6YX0EwUNddz7jSUTd+A9NGqHxywGBuhRnEQJRd9ZBRuRov6j9u1snN9kAN62S8Da
	 +KDXwR32plJI3GpPETtNIb6zvlf/AUzcVm6qiBBx44aIEMaokVecBjuBAFjNIBMB8k
	 Zxwyvt0im46G101RmnLOD+wLAsVZFXFmpN+ssQTOMt8zTr+pGyGMs52XZYMo0+M/KY
	 SUoxfUPuwzxy7+MxM/Lp9acyZZObl3otC1eByaA0Sk/6y2FGCE5KZJLo/J+1I726n4
	 lGnljDqCmswM1aboQ0jY9+xl295zuKveVSzoanSVMYFCKdC+G1bUBSDhpt+T40msR1
	 DYWVHa7mRkYhw==
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	E Shattow <e@freeshell.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dts: starfive: jh7110-common: split out mmc0 reset pins from common into boards
Date: Mon, 20 Oct 2025 18:36:53 +0100
Message-ID: <20251020-eel-skipper-c71e1f8fb679@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251005174450.1949110-1-e@freeshell.de>
References: <20251005174450.1949110-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=412; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=XWKHqVXwJok2pbqQ588FkM+xUoRw0fT4JIvExX2Fkz8=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBnfis2+dnJ8FN+Xvk7QbCbLm81Rt0Rarz77ouezSbv/Y 1mTlMKDjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEUo6RYU/tSW8TRnXLpXEO 36Zp7d0r/n6LW9PclzMVJwlN275w1xOGf1qfNgu0LXBYJv9CR/Tj74/dSoZyfLJTTSoUVGrmlqb OZQYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Sun, 05 Oct 2025 10:44:28 -0700, E Shattow wrote:
> Prepare for Orange Pi RV using jh7110-common.dtsi having GPIO62 assignment
> different than mmc0 reset by splitting this out into each board dts.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] dts: starfive: jh7110-common: split out mmc0 reset pins from common into boards
      https://git.kernel.org/conor/c/fa939a287224

Thanks,
Conor.

