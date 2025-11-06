Return-Path: <linux-kernel+bounces-888500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B881C3B050
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D8188B312
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103E333343E;
	Thu,  6 Nov 2025 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8BE+70C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638CF32D0DE;
	Thu,  6 Nov 2025 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433442; cv=none; b=k4rjmhWJjf9/O1H8uvVwwYrFVliNt97qE19c+tp0BZ5oXiZal3g5VaH6mKp/P01qDDkHAhDo0xZvdUrh7veySfpdL5ukybkasKNBGYLUMHco0znBPEg2StA0WEq8RVUJkFU567e4hQo35VYOaTUNyJCTPq1dRwKulRn0P6isuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433442; c=relaxed/simple;
	bh=ZJITJKyGzvg/Bl/cEsY/MW5qg/xMM97d7Kko/dTB22g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lydtf/BchyyBHB7iuk/Ab9XPUxhkQ0hLhj24wH+SonUAE6hy4un5Z+zVi1DUchhr8+Ci1Jc9w3mbk14g63ZjeaEiQ06aOASSgPYhIYWocK3vz/UTXlXPoGbrHeppqiDc6H+0rVkn90ey3khdMf9fxdyoRZUrZkMtTMvjvuIaF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8BE+70C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330E2C116D0;
	Thu,  6 Nov 2025 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762433442;
	bh=ZJITJKyGzvg/Bl/cEsY/MW5qg/xMM97d7Kko/dTB22g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r8BE+70CChFWGFGO+2+PvYTsUjK0yMtsaOC2FI2llufqmm11Y08eV0PHlebGVlniW
	 QZiX+hPnHRHrT8MyNfp8IR87fPFIW9qqo+U7VFjDdIz0WfWcYnxV2h25Cs2jDBQrCZ
	 ROH8djJ1XvFyurLjFEYzjrSG3MUGjCP+CSzRLKT4DvhVczzPWd7bfpLZMQXugbCHCa
	 nQWRA6/4InXbqXKU/1bB4xFfdi2hWR+GJrqyZD3epNpzAjq/+OnHspDcGNkeMCKW7Z
	 pUmF7HsQXIL0ji8THdKvYSpOhLl1/dbygmzk6pXRmccC/L9hZU3lIWfHcJNKV37zY3
	 S0Djwyrj+3RGQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: praneeth@ti.com, m-leonard@ti.com, rklein@nvidia.com, jm@ti.com, 
 khilman@baylibre.com, kory.maincent@bootlin.com, 
 thomas.petazzoni@bootlin.com
In-Reply-To: <20251021182716.292652-1-s-ramamoorthy@ti.com>
References: <20251021182716.292652-1-s-ramamoorthy@ti.com>
Subject: Re: (subset) [PATCH v1] dt-bindings: mfd: tps65910: make interrupt
 properties optional
Message-Id: <176243343893.1817816.13036179647177001559.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 12:50:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Tue, 21 Oct 2025 13:27:16 -0500, Shree Ramamoorthy wrote:
> Mark 'interrupts', 'interrupt-controller', and 'interrupt-cells' as
> optional in the binding schema.
> 
> The 'interrupts' property should not be required for the TPS65910 PMIC.
> On the AM335x-ICEV2 SoC, there is no hardware connection from the PMIC_INT
> pin to the SoC. Without the 'interrupts' property defined, the PMIC cannot
> forward interrupts.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: tps65910: make interrupt properties optional
      commit: bf55337a6c1b29722b12d126c1b1b64f9c762d00

--
Lee Jones [李琼斯]


