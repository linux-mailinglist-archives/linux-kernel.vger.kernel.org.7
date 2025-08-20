Return-Path: <linux-kernel+bounces-777122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970CBB2D597
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4830A3BC443
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3951F2C08AA;
	Wed, 20 Aug 2025 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxaVP6CX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF91F3BB5;
	Wed, 20 Aug 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677025; cv=none; b=IQ0iEhlYNUFCNaypGaWz2pWMXpE2ikVM/viMXZ2+mNaVuTceyZmYTMiCAfd7jOfvXs5FTEnywW2LgXGqrI+E7tsSdPIYHKxxEP2Cu+8sCSe5xIApf0rAn3tRIA7zq55nRtAPjSGwYVAzle3pQxv46tJAY0Zy9KtqwHhSSPqFvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677025; c=relaxed/simple;
	bh=BISR+gtNp9+FdWJxwDQ/PC3a0OAeumHoulzrrl8qHsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghobTA8YZlENhDcBt1MRIR2U5U4T0OCuDb57QcAU9xOcgCVNqgXJlAfCDT57R3VOJ1HnPx++WInfj6xbGDkQwNCSXEoZ5hM8nJTFJMnZaZpr6ebLm6pTiYAyFfMnLhzL5z2zvbgsaGvToyEY4xn8qp1tWVlWrIUfwCDa66g0DlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxaVP6CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E997C4CEEB;
	Wed, 20 Aug 2025 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677024;
	bh=BISR+gtNp9+FdWJxwDQ/PC3a0OAeumHoulzrrl8qHsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxaVP6CXICRipgpUoN8KbSwb0dfHkpQ8cbufSh7204gD4i3ENOWJXQcaTmScUS7RY
	 SpxxhJvgttV3xsT+BB2/x9hFgk4nUOzZL59k4Uias7uxMRKARhEoXebyzKz3xfa4e5
	 ockFdmutkcecsT52edwqViL7/Ax7X74GbKsvbxHxoHXxHVvlbsu3mGfmbRhV9VlzoL
	 qn3/LCz3E4Izs1s0hhhbvpuxf4BF/CVMSOV0jlYiNYCD9wDV/D5Lx3kkYbCyUU6PRg
	 kNWYsFeZdiLSKeT0tcoJah5uhxuJxrAWIxj/oYAbBkFGv5A2ZjRhc5bDfglXJwf8n8
	 hSxDTqOXFeFuw==
Date: Wed, 20 Aug 2025 10:03:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i2s: spacemit: add support for K1 SoC
Message-ID: <20250820-gecko-of-absolute-will-b06337@kuoka>
References: <20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com>
 <20250814-k1-i2s-v1-1-c31149b29041@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814-k1-i2s-v1-1-c31149b29041@linux.spacemit.com>

On Thu, Aug 14, 2025 at 04:54:19PM +0800, Troy Mitchell wrote:
> Add dt-binding for the i2s driver of SpacemiT's K1 SoC.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


Best regards,
Krzysztof


