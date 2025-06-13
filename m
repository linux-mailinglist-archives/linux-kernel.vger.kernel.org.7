Return-Path: <linux-kernel+bounces-685584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70892AD8BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106E318931D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F22D5C87;
	Fri, 13 Jun 2025 12:08:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8022616C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816496; cv=none; b=n+o/FHc59By4BxohjFIxGSbTnNUXxQuqwUvz4mSbDG7Jp2ZNhlSelx64p6N0wbkjV9yYtXkAxLdOuIPli+ojmSaNnOP+kxSxip6ABfaAM2f2wvf91xZGvJUO0FRQaGzdOCPVaFfhzhJLnKFoUGvm9TJKi2l7GctdQ3x3o4legYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816496; c=relaxed/simple;
	bh=FTI1Dd4UXGGGgfpkTT8/Tb4MSRkcYnKLspq94ruFVQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw8bWbIOovUr6hOOEK0ZCU1MKeOdbV56Jw+v//yFeSqQ0cipOXzarRf2nW3kxxm5NGAZcf1THWhvmx+S3aBGlr4D1NWgHnM9dri/LH+woaND9X4QmrEk8fpO+eqF9uHNAkxYx3PhVL1Cfy6Qm9RgbX9zFzlQqV9/b5pI9g4arxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uQ3CP-0000Au-9S; Fri, 13 Jun 2025 14:07:57 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uQ3CM-003Htt-34;
	Fri, 13 Jun 2025 14:07:54 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uQ3CM-00BA3y-2Q;
	Fri, 13 Jun 2025 14:07:54 +0200
Date: Fri, 13 Jun 2025 14:07:54 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robert Marko <robert.marko@sartura.hr>
Cc: catalin.marinas@arm.com, will@kernel.org, olivia@selenic.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	andi.shyti@kernel.org, broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
	kernel@pengutronix.de, luka.perkov@sartura.hr, arnd@arndb.de,
	daniel.machon@microchip.com
Subject: Re: [PATCH v7 5/6] char: hw_random: atmel: make it selectable for
 ARCH_LAN969X
Message-ID: <aEwUmh9HOwrG4kPK@pengutronix.de>
References: <20250613114148.1943267-1-robert.marko@sartura.hr>
 <20250613114148.1943267-6-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250613114148.1943267-6-robert.marko@sartura.hr>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2025 at 01:39:40PM +0200, Robert Marko wrote:
> LAN969x uses Atmel HWRNG driver, so make it selectable for ARCH_LAN969X.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/char/hw_random/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index c85827843447..8e1b4c515956 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -77,7 +77,7 @@ config HW_RANDOM_AIROHA
>  
>  config HW_RANDOM_ATMEL
>  	tristate "Atmel Random Number Generator support"
> -	depends on (ARCH_AT91 || COMPILE_TEST)
> +	depends on (ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST)
------------------------- here is missing space ^

Otherwise:
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

