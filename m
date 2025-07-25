Return-Path: <linux-kernel+bounces-746470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A3B1270E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7436BAC51F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D1259CA1;
	Fri, 25 Jul 2025 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEXjstUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49F1E9B22;
	Fri, 25 Jul 2025 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484637; cv=none; b=GGQA8mahyTOaJuvjULmZa3799SEhX0Gyg84WuJhhBhIHQu3KM54ehdP9W1MUTiifhx7eRNxnPFC279dt3/w0G+JWaT5lJ8bhSxLCCN8zvt4snooS6mU8l9ZHiHX/zer6MizqFsKKk6TqWwFYw7kvP3ek7ju4fqRU6gwf0BGQ9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484637; c=relaxed/simple;
	bh=/ihqXbiLnvze8X7uQMIFreBNaBY/ADD8BZyIiZGUufc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULxIIKoc0ZXFBA9FJwz3zGro48vZATuYeVK/OqjBfeKTi1IVIlr3yqYhvvhicNSbV+6lWuGElW+YjKog0N7WWecWK5ZfhydsV2RTeiJx+KF5kJ/I7PUG2tg341voRVbIh7hmtiWaKqitI7MYCmt4cb1dpQHQMG5Myn9+cB1pasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEXjstUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92499C4CEE7;
	Fri, 25 Jul 2025 23:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753484636;
	bh=/ihqXbiLnvze8X7uQMIFreBNaBY/ADD8BZyIiZGUufc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEXjstUOI0TN9HQBSTBwqbatkXGLTR8j38MRH0gaYGIjujVkhVpmcdbrufiYTszqh
	 ixhIl1p7DSDHg+eXdv19MOviwgiL6yDT3Sdfr9UvFsaDUwIURonuKLJ4buX0FqURKj
	 vJDuCcW94BuqQ2EeIuKROn1vn3TyYKszJkmmbyqApPir9CHfxOO/XqucVDJnSRazip
	 9Nzcwxa+Yf3rEBR3wHIxoOYkXz4bnce80LHQaI7vkxojkbhp7CKUyO+pus/y705TKF
	 uWbYGINWxygVgHZH6wPF4H5nP+zOhZzq5vqqSUqJ/HLOI3kS82hUx6KZ4mpYuuo0zO
	 N/mMYbJxHCwtw==
Date: Fri, 25 Jul 2025 18:03:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Yao Zi <ziyao@disroot.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 01/11] dt-bindings: phy: rockchip,inno-usb2phy: Require
 GRF for RK3568/RV1108
Message-ID: <20250725230355.GB1993803-robh@kernel.org>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
 <20250723122323.2344916-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723122323.2344916-2-jonas@kwiboo.se>


On Wed, 23 Jul 2025 12:22:59 +0000, Jonas Karlman wrote:
> Typically these Rockchip USB2 PHYs are fully contained within a single
> GRF. However, for RK3568 and RV1108 regs to control the USB2 PHY is
> located in a different GRF compared to the base address.
> 
> Update this binding to require rockchip,usbgrf for RK3568 and RV1108 to
> properly reflect that the USB GRF is required to control the USB2 PHYs
> on these variants. Also disable use of rockchip,usbgrf for variants
> where it is not required.
> 
> This should not introduce any breakage as the affected usb2phy nodes for
> RK3568 and RV1108 were added together with a rockchip,usbgrf phandle in
> their initial commit.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  .../bindings/phy/rockchip,inno-usb2phy.yaml        | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


