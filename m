Return-Path: <linux-kernel+bounces-845646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4204BC5BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC03E3A33EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5E2FC864;
	Wed,  8 Oct 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfdm2Fz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11329D27E;
	Wed,  8 Oct 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937521; cv=none; b=iNpOp2n+M0ZfKpGwiyZdHkle/BXMRpo87h7uvl6aEik/kNz6hRU5ea8uurcFQuVKmbEjE6RIODhP9UbEHviPNU2KI35WzwMbUsGTwe27gs5IZP68UDE8m8radtip4+CrGN1BbodVR0wHHspBgdXRitdEpTtz7asGEEW6M4+qh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937521; c=relaxed/simple;
	bh=6ZyX1kLcLJNXldMegM6HSEKEB5NDJXFXoY077up5ToU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gOJVT2EgjwmBHbALVcLaX72ee7ew21Pq+zlsghIT5fIaTUe/7zKU1xwISilHZzft/Gxz9jSGRMAKlFGbSYCeiyDc5pBgUyOUVkdn+q5KRTnJG3ZUHvKr5vKUdwSs+WPmYExuTPmfLXEjENz6qxH03QQmv9V1twP/zZ5yL+X/X6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfdm2Fz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A74C4CEF9;
	Wed,  8 Oct 2025 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937521;
	bh=6ZyX1kLcLJNXldMegM6HSEKEB5NDJXFXoY077up5ToU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qfdm2Fz11ubxe09xhRTIaDLWoAQKB9VrPp2Bxsevay/2A4m0pDZnQKY85qtpERBKu
	 tVZQyyz5x+w7m7zXQWs+LdbnWOddczRfDpOVmYnZQaagC4y4o+sgX3JpY6zG2AQSap
	 12Y1nw6H8DjC55thOWJISuevZNjugtvXGiWDxtaCoZCUx4xBQY9f9Gd/bQxIDNhkla
	 nRCYsN/MoQxBKzaLdyy2PRl9qKIkOUlRMTNI7wSQ5G0pKwLI8n8863KqCLqnUZ56tH
	 txTcqIHZgPSuF+6fDyDcETHx/CiErx//pMUSyrsJmA5nZemOUFBZflqjgt7eoOOo5O
	 GZ1024/WzyYjQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>, 
 Andreas Kemnade <akemnade@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250917-sy7636-rsrc-v3-1-331237d507a2@kernel.org>
References: <20250917-sy7636-rsrc-v3-1-331237d507a2@kernel.org>
Subject: Re: (subset) [PATCH v3 1/3] dt-bindings: mfd: sy7636a: Add missing
 gpio pins and supply
Message-Id: <175993751776.2584245.7441294249150226238.b4-ty@kernel.org>
Date: Wed, 08 Oct 2025 16:31:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-b87af

On Wed, 17 Sep 2025 09:14:29 +0200, Andreas Kemnade wrote:
> To be able to fully describe how the SY7636A is connected to the system,
> add properties for the EN and VCOM_EN pins. To squeeze out every bit
> of unused current, in many devices it is possible to power off the
> complete chip. Add an input regulator to allow that.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins and supply
      commit: 7d983e997cb53d4c48b61b105163c31c92a35823

--
Lee Jones [李琼斯]


