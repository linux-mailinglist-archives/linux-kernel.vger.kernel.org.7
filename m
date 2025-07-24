Return-Path: <linux-kernel+bounces-744597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D6B10F05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC5C1CC6527
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F222EACEF;
	Thu, 24 Jul 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw8n9iVx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2432EA491;
	Thu, 24 Jul 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371865; cv=none; b=uPzhXIp9kBRIp8X+qhyhHhAUKVOXg9ACGAus9Ry3Od3HfEI9flnmF9sLUovelc5D8jbQn3QS6V6N5ZEcTtComL1z/cB3F7fhjndrb1qpwaAfmgxaQ4Coi1XdDhClMewRqTnTazEQfzjtnpZvhxLQrp3Lzo26ce6TMUHJIrrBE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371865; c=relaxed/simple;
	bh=F7YkTzllhnUVqK6Xycfk5dhqweO9M6cpG87czLeXM9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZbM5MZ9GiFnwO1NtLTKy0k+WSJOfZ2dptQ9X/nRds8BpfavGzcGHNfgpWgoWeO/GHXFgw9+yG7WlroGRD2EdYiS42ug3hd8uX+aYH65EE8vC6n2bP0vZus8+HCRHGK6yM4g/L84yquw2lxVNV8OQwS0+9l3f7P/0sKPY21XTW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw8n9iVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8314C4CEED;
	Thu, 24 Jul 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753371865;
	bh=F7YkTzllhnUVqK6Xycfk5dhqweO9M6cpG87czLeXM9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gw8n9iVxpkhQinCyyGmlmfXM+E19Y4Z7n8/3xcChqvZ4SF3d97m+4l4tg/W1Hlb8V
	 zapGtOHJBj6gMjAnrNXxF9WiAurhFU5aK1S0//Io1bk5/DBpZLBM+8OEQZwd88Ho/k
	 dR1k+TsulEp1NwGpR38XTHZeYm7D7CrGjXdTDMYOBkPQmdZ8LEcBWmtpjRibHMLA78
	 kVoHHYWWZB31soZ8Y8fHiRoS8JI3+/B7SM3ejN0CZkGjDokeSkecPG4CsZC2F6G4Qt
	 xVtqXWBjY/+4VmaBfZhjGwF3DrvMwXTW+Kwqi2neRBSNgc3Nm2I/C+bu6iKSvmDpyV
	 7x0VAE+R0PeEg==
Date: Thu, 24 Jul 2025 10:44:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
	yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp) Add thermal support for AMD Family
 1Ah-based models
Message-ID: <20250724154423.GA2939389@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723202735.76440-1-avadhut.naik@amd.com>

On Wed, Jul 23, 2025 at 08:23:38PM +0000, Avadhut Naik wrote:
> Add thermal info support for newer AMD Family 1Ah-based models.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/hwmon/k10temp.c | 2 ++
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index babf2413d666..7765cd57d746 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -556,7 +556,9 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{}
>  };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e2d71b6fdd84..ae87b6c72981 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -583,8 +583,10 @@
>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
> +#define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3 0x12cb
>  #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
> +#define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3 0x127b

Per the comment at top:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

I would suggest adding these #defines to k10temp.c itself.

>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>  #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
> 
> base-commit: a2609b707b58561b9e52f92f3f571d0510201f2f
> -- 
> 2.43.0
> 

