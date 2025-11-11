Return-Path: <linux-kernel+bounces-894883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B814BC4C53C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 618A334F910
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B0E32F740;
	Tue, 11 Nov 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcqzUVIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A02DC35C;
	Tue, 11 Nov 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848898; cv=none; b=DBBctw+51X1NuUFXj0j8EyK9Q56bEgHrZJJTrAEGncin1ddMNTfiqEb7jQ1FAv500iFSWjUu9kyTf1cmVsonjmraJRPq0S9OqoHLFcS6SZdQJzY9ZPufp3H88krn1kuFV8UxtyQ0yEO0Botqb6QYKC06ZL9MslzQ+CNf0RdqMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848898; c=relaxed/simple;
	bh=h307kAcGDdlAPMSOA8BXjiOpTLM82CH1YDe7PLP/zqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn3/8o9uNKLEukJpl20smFHZ/6wdSd+D8l9EN4lJ4ZSSzQ8wAyRR6HJ3T0f33DXyx2jWftJxYqysSZ+yUsWsYVOx0FsSXCRYdU+FZTyu7GqDD0xN2Ln4MgZJFkp63tKgxI6MtEhBSwici0oko+Dbs4hP4hLpRxWyfsDYis+1/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcqzUVIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ADAC4CEF7;
	Tue, 11 Nov 2025 08:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762848898;
	bh=h307kAcGDdlAPMSOA8BXjiOpTLM82CH1YDe7PLP/zqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcqzUVIgaCxIK5ctebECQFqIhdURORxhsCGy+GrHzZsRCJrtbOsufz3ZbiGCaMwLG
	 CseLgtNwvDethRiiSKNVWlR/BI5jUUQpWvMqbTlZ9WmR5W/BeBQqS637QI/3cLsClT
	 AgafciqiSZgLD93V1R75YdqCjTuvPFE50EMnYjKk1lIB4Qgz2qUUK8K4FaFSYuCEtw
	 2Zr4p5IQZquGZIXoZo6mTIWVPhtYuclEVOow0km9iyVN9lPyVrO1FMDDPGs7uKDltz
	 NQoaM+U+dBqqFVrMiu7Htg3HkNqLfXcm+lOLzwRNDuykoTy6o4sLnW41lHLpVuXVWZ
	 agS5bPNSU9ZMg==
Date: Tue, 11 Nov 2025 09:14:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: adrianhoyin.ng@altera.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dinguyen@kernel.org, Thinh.Nguyen@synopsys.com, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: dwc3: add support for configurable DMA
 addressable bits
Message-ID: <20251111-aardwolf-of-unmatched-potency-7a2eff@kuoka>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
 <c69076470c19fc03d92fc04cdb10960873bc2bc0.1762839776.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c69076470c19fc03d92fc04cdb10960873bc2bc0.1762839776.git.adrianhoyin.ng@altera.com>

On Tue, Nov 11, 2025 at 02:18:48PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>=20
> Add support for configuring the DMA addressable bit width in the
> Synopsys DesignWare USB3 (DWC3) core driver.
>=20
> Altera Agilex5 supports only 40-bit DMA addressing. Setting an incorrect
> DMA mask (such as the default 64-bit) can lead to address truncation or
> translation faults when the SMMU is enabled.
>=20
> This commit introduces a new field, dma_addressable_bits, in the dwc3
> structure to track the platform=E2=80=99s supported DMA width. The defaul=
t value
> is set to 64 bits, but for Agilex5 platforms (altr,agilex5-dwc3), the
> value is overridden to 40 bits. This field is then used when setting the
> DMA mask to ensure compatibility with the system=E2=80=99s actual address=
 bus
> capabilities.
>=20
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  drivers/usb/dwc3/core.c | 9 ++++++++-
>  drivers/usb/dwc3/core.h | 3 +++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index ae140c356295..20e655364135 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2179,6 +2179,9 @@ int dwc3_core_probe(const struct dwc3_probe_data *d=
ata)
>  	dwc->xhci_resources[0].flags =3D res->flags;
>  	dwc->xhci_resources[0].name =3D res->name;
> =20
> +	/* Initialize dma addressable bit to 64 bits as default */
> +	dwc->dma_addressable_bits =3D 64;
> +
>  	/*
>  	 * Request memory region but exclude xHCI regs,
>  	 * since it will be requested by the xhci-plat driver.
> @@ -2194,6 +2197,9 @@ int dwc3_core_probe(const struct dwc3_probe_data *d=
ata)
>  			dwc_res.start +=3D DWC3_RTK_RTD_GLOBALS_REGS_START;
>  		}
> =20
> +		if (of_device_is_compatible(parent, "altr,agilex5-dwc3"))

No, this does not scale. Don't sprinkle compatible all over driver code.
You have driver match data for that.

Best regards,
Krzysztof


