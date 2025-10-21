Return-Path: <linux-kernel+bounces-862660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC54BF5DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8195D4E9CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5BC2F2600;
	Tue, 21 Oct 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4SqDOKV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1FAD24;
	Tue, 21 Oct 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043583; cv=none; b=oS+DElkLuq683FgD7ogMdmd+rPTxm+vjF7uH4vS12ZbmRPitMPvrHJHeL86C/l4ceDuUg+zW+lp+B3qLeBcubLIEjqD8d4z/FgxBq6g99eutR4gMBM5iYe6JoN9ePCgGVxOQEgpLQO7tExw5kHhPaPODgLpzoMkIDEWXK5LeUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043583; c=relaxed/simple;
	bh=EL/deV2+NAe7Ey9GQFKqJtn+XrkhgmRGr22p3S0Ukmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjQayGFUu70Rd7nsE4X9YWyq/SClTEopJh335DHZDJnT3GcvN/3KdocdBD+5+e4PEQDJ/uId0cJGOSzCMz4jzObPFhKLNVdhaGmd9fEb92mXJ6Y7UiWVdBCjKDk6HlGT1gabWS9xSiv0NKkvw4JyiMWRsOjDcBlgWx+Dzzv0Wj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4SqDOKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D135AC4CEF1;
	Tue, 21 Oct 2025 10:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761043582;
	bh=EL/deV2+NAe7Ey9GQFKqJtn+XrkhgmRGr22p3S0Ukmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4SqDOKVh+gJNEHY6HdSDpJmWHOIESAZr124vQ1HNd9RrID/5qAeW5AFTR9YzyUZ8
	 6JnV49iP8P0Si37Q26PuJ9CHjoZnSIBfR/Ew4+8FQa2/awpAPlPUaYrwgPSxVMvbnz
	 e9IXfTOLz4mlD+PHdm1ORdulFBGR6yk2B6PwXSktNEQopM2H6/AI2ocSx0EPEp9yD4
	 ycvZoUpgIH+h0hPNue38tY+at0Mc3tI//M+QlKL6aiNUU112LGWYYBdvH3J7KBX0p7
	 liGreE+LhOiiL4lNhfRJWnSBPK9kxFCORd40b+1ZviJnaAJz2211jdLmKN20H4sQWu
	 4vyqrMeqtbdgQ==
Date: Tue, 21 Oct 2025 11:46:15 +0100
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>,
	Andreas Kemnade <akemnade@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 1/3] dt-bindings: mfd: sy7636a: Add missing
 gpio pins and supply
Message-ID: <20251021104615.GC475031@google.com>
References: <20250917-sy7636-rsrc-v3-1-331237d507a2@kernel.org>
 <175993751776.2584245.7441294249150226238.b4-ty@kernel.org>
 <20251020151511.1fd8611b@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020151511.1fd8611b@kemnade.info>

On Mon, 20 Oct 2025, Andreas Kemnade wrote:

> On Wed, 08 Oct 2025 16:31:57 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Wed, 17 Sep 2025 09:14:29 +0200, Andreas Kemnade wrote:
> > > To be able to fully describe how the SY7636A is connected to the system,
> > > add properties for the EN and VCOM_EN pins. To squeeze out every bit
> > > of unused current, in many devices it is possible to power off the
> > > complete chip. Add an input regulator to allow that.
> > > 
> > >   
> > 
> > Applied, thanks!
> > 
> > [1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins and supply
> >       commit: 7d983e997cb53d4c48b61b105163c31c92a35823
> > 
> hmm, what is the fate of this? I remember having seen this in your
> for-mfd-next-next branch. But now I cannot find it neither in
> your mfd-next nor your mfd-next-next nor general linux-next.

It's still applied, only with a different subject line:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=cb62b0ea2c88c8a3d38b7b4991adbc0aacdb1418

-- 
Lee Jones [李琼斯]

