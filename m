Return-Path: <linux-kernel+bounces-749139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C8EB14A99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAB71714CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C315287245;
	Tue, 29 Jul 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9/ONf1Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F919D09C;
	Tue, 29 Jul 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779624; cv=none; b=lQGLgH8JajBc+mk6h0DHq92nSStOkVJDhJVx6hC/Wlo9Scl/Y2OiXMRRFlfEzNJa1gyeLmsoyAYvgX4bffi1hOYtg9/Kz8UF4BrmMTpOIr7QqYWa7oN6ctgQ9ohgKzUz9fT79xEUtzEvqQmo/pTp5iDoRtNuLA6pH9nN0oI7/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779624; c=relaxed/simple;
	bh=NqJOUVSnRAuwlsdCgD7CCgnH8jeSEv6tZOvVIi96fe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iinNY42oSVIUwp42jZ0IOrmp9FOGXzx6+oVi06y0vI9f3nwVq8o09GEY7VR6TxdydcFSmbbYv5dhT1zr8teBTtWA4pkHNRUKxx0Eeygtzw13qE6Pw89lO+kXdODdTmQHdcoW1z3UV6CKZiSY9Y6MtNlCXZ65uedNZMNb51Tsk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9/ONf1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B44EC4CEF5;
	Tue, 29 Jul 2025 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753779623;
	bh=NqJOUVSnRAuwlsdCgD7CCgnH8jeSEv6tZOvVIi96fe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9/ONf1Q+KuJNq6cweFcLhJ18FPRsgO8u0mQMekNt0xpmNy793rHy0kQ+DdM5HYC6
	 2UzUNmYpjbNGQgiUrH1v8kBq+w+ymTb4f3ng10d8eO7F+yPPbS1qmfo6FkYRcwGL8u
	 7H0k6BBIsLziLN2niIlGUNTkOOC2tvslr367DVjbiRUGcvQiIABCHOObjB4PpyYpCf
	 yzlLmNk1je9ZKfwLmQtdonw6uEBeX1ngP8M9R8Nuclo3KHyYV9pCsglI02dZPQCq3y
	 iobG/xREiel0brKSIRkZkYqIF5ApsV7K0GhKXkgxuGjo4b2zTEst4UFKSDqLuFr7lZ
	 gcDlvw0zhiDwQ==
Date: Tue, 29 Jul 2025 11:00:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Troy Mitchell <troymitchell988@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, Alex Elder <elder@riscstar.com>, 
	Haylen Chu <heylenay@4d2.org>, Inochi Amaoto <inochiama@outlook.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK
 for SSPA
Message-ID: <20250729-stylish-antique-cassowary-4e3c4c@kuoka>
References: <20250728-k1-clk-i2s-v3-0-5d7579f02227@linux.spacemit.com>
 <20250728-k1-clk-i2s-v3-1-5d7579f02227@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250728-k1-clk-i2s-v3-1-5d7579f02227@linux.spacemit.com>

On Mon, Jul 28, 2025 at 10:20:15PM +0800, Troy Mitchell wrote:
> In order to use the virtual clock SSPAx_I2S_BCLK in the device tree and
> register it in the driver, this patch introduces the macro definition.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Your SoB does not match from.

> ---
>  include/dt-bindings/clock/spacemit,k1-syscon.h | 2 ++
>  1 file changed, 2 insertions(+)

Best regards,
Krzysztof


