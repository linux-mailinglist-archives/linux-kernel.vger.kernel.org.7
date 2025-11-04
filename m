Return-Path: <linux-kernel+bounces-885237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9BC3258C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6118C821F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D5338910;
	Tue,  4 Nov 2025 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyN4zn6O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598F3314B8;
	Tue,  4 Nov 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277123; cv=none; b=twSXCqpTgLHvQ3k86oLtBdmed1K3u1S8zuWbC853xutIb25KbcGMovtTNLeH004zLno6Yvjom/rJAlLbAbrRJ6KvKtYltkhJ63q63VkjkpmSXvz7s/qyCQB0sWLo5aCth14Vv5+tETF1TJD075vpulgWo8RMTHwcLRyF6L5Pbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277123; c=relaxed/simple;
	bh=7aYmwGwBDUYQ7VqbcwEdBsnlFLdnNbLvQp2h4mZD/aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5R9STgig/+R1cf0902zFJhefdXaVLM3Kjt9jwiQqL1vAveNlQtmpRHS8eEW3g6QpfHrSh7dVI4M64QGJiicL8brv1h7/YbL1wlMXvAGKpSL+ucf5UV2CeVjtDiKqa79WNXaOsL+yzbw5FdJVwk4Jujfp42qcWyjxzU4+igEkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyN4zn6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3F7C4CEF8;
	Tue,  4 Nov 2025 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277122;
	bh=7aYmwGwBDUYQ7VqbcwEdBsnlFLdnNbLvQp2h4mZD/aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyN4zn6Oxil+gSh9XzVLNVS0iBN2c6eW5echRWW64joxBsDwbB/7MqVQq4RbAKzbv
	 cax5Xfn0745ta9Ysb4JhfbvqZN/do26aorgSP5rd8RYyzF/s+0x8KAO7vn0OV/2/ZY
	 XRz6jJa7nY+toZh4NjW7AM7S4RAv336NWkkaKeROwDNlEAysrHqLQgctDRaPt7dDrx
	 gGvaM2Oq428uCIFD0UPwwEUs+ZW9Nwt/7DsbasYljox5YtkCv8A3XKdIewCL3L/R0Z
	 7j4k4/0t7HMhhUcIfIJLhjBbFgCGgPFlXHTNwQQ3dju3nisceqj+qZZYptdPfQB9ad
	 6l8ofBQOl7MUw==
Date: Tue, 4 Nov 2025 17:25:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: Re: [PATCH 1/3] dt-bindings: clock: rk3568: Add SCMI clock ids
Message-ID: <20251104-royal-stir-ee4df643e3ff@spud>
References: <20251103234926.416137-1-heiko@sntech.de>
 <20251103234926.416137-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cRAjLMPfblXcgdZS"
Content-Disposition: inline
In-Reply-To: <20251103234926.416137-2-heiko@sntech.de>


--cRAjLMPfblXcgdZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--cRAjLMPfblXcgdZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo2/gAKCRB4tDGHoIJi
0hsdAP9ntPaYIuuUM8fCimgWccu0AE1sB4lF0aTfYVW5HORKCwEA/hh8sno8jBWE
x5UzPmkmc96+i5yN6Z1Q/6Jn4oTmCwg=
=oiSb
-----END PGP SIGNATURE-----

--cRAjLMPfblXcgdZS--

