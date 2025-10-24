Return-Path: <linux-kernel+bounces-868903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF70C06733
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF77735C5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A3F31B839;
	Fri, 24 Oct 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qusdd43/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24707302143;
	Fri, 24 Oct 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311970; cv=none; b=LMwyXfUhu0JW2knOn5a3pQ2BeC1u4PCBk8kdIxcG5Vkapw+HUESQOzb6KCfjFm/B7rh+tpF9+WCKejSsRK51baEC1j8Z0ZwG1Sd7m3EEXODmusRfcze69nbuPLv4BqDQGMJJYSYpOxnxxfcht9ZcyRNjeoql2+0uI5XIRvw4058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311970; c=relaxed/simple;
	bh=ijZ3YQb5RbTEBsfiDsONjnER3UzdyAjEgd6V2FItANM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+LWJvVcZ3dZa5lriuk235eEh5++73KdXRL17auKGlK/h2xhD8vVp3Jnogm1hdUhcfUyIznkCfONIBfBvEuKp5Ucucc0T6GBpYp2UoC4NoH3hARm5qrmuVxLGQ/T3+ZaayxpLwjkNy6OVYK38tLpFvnvWc5XZ68FlgMzfkzTHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qusdd43/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9A2C4CEF1;
	Fri, 24 Oct 2025 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761311969;
	bh=ijZ3YQb5RbTEBsfiDsONjnER3UzdyAjEgd6V2FItANM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qusdd43/3UXupZ8JoenMD3Y1vDsqvzZj7jop6k1B+5vnlLWWrFRdWv/LKvbPuFtip
	 O6ZJSooyPHQR41CNK+/5FJoObIm4sLs/q0vNbFuXGAVJ4GbEuIfYhNxzzvmd4t+p/2
	 O2yBN6asLYaBQXzNAtzldKcH0O/44vhsmxkJ22KuNSP+eKFssVaJtygINT+XTzX9pb
	 Sm9y7gUl8bBeWf+6O4FwLYN+N1yBmmydtbuOH11YPWxujUTrtJrWcu6kFXvmhTtFxu
	 KDdJ0bsfPpdyoMcBwYWGny5CGUEMX6pk9v4VCfnx7guL/3UlwYQr+U9PolNKKNhNFx
	 4cQgHu7Cjxonw==
Date: Fri, 24 Oct 2025 08:19:27 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: Convert brcm,ocotp to DT schema
Message-ID: <20251024131927.GA1567824-robh@kernel.org>
References: <20251014152957.3782962-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014152957.3782962-1-robh@kernel.org>

On Tue, Oct 14, 2025 at 10:29:56AM -0500, Rob Herring (Arm) wrote:
> Convert the brcm,ocotp binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/nvmem/brcm,ocotp.txt  | 17 --------
>  .../devicetree/bindings/nvmem/brcm,ocotp.yaml | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml

Applied.

