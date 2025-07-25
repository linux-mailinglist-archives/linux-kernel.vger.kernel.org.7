Return-Path: <linux-kernel+bounces-746472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74AB12714
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020DF1CC0401
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A330125A63D;
	Fri, 25 Jul 2025 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djIISh6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B222F767;
	Fri, 25 Jul 2025 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484774; cv=none; b=fh0P5HsN8TTWsEoCe6xcosk86lVBIgN1HB6f+FoYLdYZ3MkNNRPjvWn3KhZa9N9R+LNiV/nMjmPnLEsHk8ku5lOEaqzEW7NYZRkPXFcOlhBptr+iTvUxuN7sQUuCWVNKRrzXPUZIvCT29P0HPr9wJfgyafup9WdCBloYo6dEDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484774; c=relaxed/simple;
	bh=8vnCCU3LPQGo53C05dFuO3MKjV+pOSMNfVK636KtS6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOTA6jJuVL0yJ1sKOzWvUQRadAAiThVyW4qGxCAgdI3DQ2oauKzQaplOq17Hujc3nYa6DQ1w2A0S1+/rAby3dEmuYykAn3tRHWDR6gnjjlM/kx+/Ope7gdZuS0dU0QGyeY4tShv5zPYWc3NRDpNhcakOkpWvve00lL+H0T44moQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djIISh6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6392AC4CEE7;
	Fri, 25 Jul 2025 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753484773;
	bh=8vnCCU3LPQGo53C05dFuO3MKjV+pOSMNfVK636KtS6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djIISh6YSRnwbypyxmMrAcPIUUF5v68Wdiwz93/UgTP6WNGlSue6F0OcCzQrZG/Zu
	 sxV/iPajbiXLYwfkki0R/DK9I/KVRQXo0WqgVHJjKoLhQxf3hQZxLs715FLHVQBuPm
	 crPoWpACcui6Im2dZ5mc+qrKo1XDtXvUhg9ExD8DgK+RVldhB2w6d4xkZlr3GTEvPz
	 zmeE5b71gF1tNqmZWVZY9GykFDPmPtcjhvZFveml/6vCq7nGZE7EYsShbqNBoEULL4
	 LzAZkEB6gHsWfNWNJRBItw2Oj7UXsWz/+xvKkNl0N387AaMtBHlfN/qcz1nncI8DnS
	 yKgoA+adJ0F+g==
Date: Fri, 25 Jul 2025 18:06:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: linux-usb@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>,
	Yao Zi <ziyao@disroot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 06/11] dt-bindings: usb: dwc3: Add compatible for RK3528
Message-ID: <175348477194.2001313.779930445119740224.robh@kernel.org>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
 <20250723122323.2344916-7-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723122323.2344916-7-jonas@kwiboo.se>


On Wed, 23 Jul 2025 12:23:04 +0000, Jonas Karlman wrote:
> The USB dwc3 core on Rockchip RK3528 is the same as the one already
> described by the generic snps,dwc3 schema.
> 
> Add the compatible for the Rockchip RK3528 variant.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


