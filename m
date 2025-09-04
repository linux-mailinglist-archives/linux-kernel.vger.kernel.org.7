Return-Path: <linux-kernel+bounces-800847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B99B43CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB244E58F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61502FE05F;
	Thu,  4 Sep 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hmo9ugWE"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDA2D5412
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992034; cv=none; b=hslRmfIcNlf8FGM2r+v+6gVfgN92+6rX89S0pWFXJs+FsrokaOVv6JPif4BmzVzPIObISEIj/yWGarDmYkxFjll0Bj9vnkhDaRtbMr6+/A4ePntksVRf0PX3++W5jnPGOIhIGUSU4Rkq0BvNX3hqlPX+skEkOhJI0RQXOL3xR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992034; c=relaxed/simple;
	bh=JtGzgsy6oukY89TC4x3BdzUwm4U+fpsrzqRZtTbttc0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlIzspxv5+PZxi/n/Nzrvekh0gUfd58z5Lyw5R4AW5qMwydTIPJElR7L6epLLXScHQpu/5M9vGIQy7gt5Hh9Y6m0LB4Vu2hGUPcxXwrGsth6azDQk9rnOmcePVytvaQTyHPpYNLSFQWlSZoc306UxUcUgnehHhmEpDPVPt2ULys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hmo9ugWE; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584DKCa53018785;
	Thu, 4 Sep 2025 08:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756992012;
	bh=45eHtpDotlSZ4Qptz8MiFsbC7Nu4LNeucm3H4hVzoTs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hmo9ugWERdXPhwiCwkO4H1Epjj0dgKcrXJpDB/QT4tI7/lOoCeDbQnq9wI0/Y38Gf
	 JswfjgmNEEeELwpJrOHMxpvFnbKFye2C+5R/Bn0WBMTUSVKerjCELffDfx0zd9bY0d
	 Ve2PU/xeQxRTZtDOXiIQhMBBQIUSNNO0VFbwcRZs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584DKCIK195307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:20:12 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:20:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:20:12 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584DKA5s3021833;
	Thu, 4 Sep 2025 08:20:11 -0500
Date: Thu, 4 Sep 2025 18:50:10 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Guillaume La Roque <glaroque@baylibre.com>,
	<""@lcpd911.smtp.subspace.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, <vigneshr@ti.com>,
        Nishanth Menon
	<nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND v2 2/2] soc: ti: ti_sci_inta_msi: Enable module
 compilation support
Message-ID: <20250904132010.veq2vimhhaj7l7wl@lcpd911>
References: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
 <20250902-timsi-v2-2-a5bf0f32905b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902-timsi-v2-2-a5bf0f32905b@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 02, 2025 at 16:43:50 +0200, Guillaume La Roque wrote:
> Add module support to the TI SCI INTA MSI driver:
> - Change Kconfig from bool to tristate to allow module compilation
> - Add linux/module.h include for module functionality
> - Add MODULE_LICENSE, MODULE_DESCRIPTION, and MODULE_AUTHOR macros
> 
> This allows the driver to be compiled as a loadable kernel module
> named ti_sci_inta_msi.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/soc/ti/Kconfig           | 5 ++++-
>  drivers/soc/ti/ti_sci_inta_msi.c | 5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

