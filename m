Return-Path: <linux-kernel+bounces-710725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC0AEF038
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B7B7A9BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C3B25EFBB;
	Tue,  1 Jul 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEg/HyLm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E81E51F6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356520; cv=none; b=NUDzNWI4jI9vC9Nhk4Er2bNi7br9HPTnLLZQb6KZA7XmWfDMGnFVdaQo/u0EMUnCeYnPpp/5tNXvij0XZH0BUTskO0hlTFzByWoVjyoxCRdXwwNrsLnAYVvK/zS0Ig1Tu35lRJmm4uW+dbyfsz6AD683Y3kyxBrRnPjZ1s2T3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356520; c=relaxed/simple;
	bh=jFA2Vl0jPD75ev7E43ytDZByT+SH8CFGnuV65782Ojw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8a1cq2ODdoUfIoEAamIkolxdAoakMkQtVFzQgIHhy4OxcrOVi4lpjQ9M3HSHhAhIFAP2ektZ0H2ttLn3OB9ohyYJp39pO6JYk/Bli0WT4UDDoyBzsgnenVhX+IYDlOEMrqcyWe47Q6nCM2kslWTfP6O37NHSmpxseFLIhdJOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEg/HyLm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHdMzgFfQJGJTVG/4M9MM8/CUYx5m9feJxrpAo8o1hk=;
	b=SEg/HyLmhyDWz0uurN5AcnMWaJzPboxaS/Tv+MG2SaFUgGyZ0JoCH2ik2sMX3T+nbTqM7t
	Ms/XqFtWTkIJfvv17zxmSbvTt4nU5N08BbqIL9xfDohyNcFuJKSFdGPiGEalpslaPa/p2X
	FG25LBsgBAj418o/KTDjTvcf1SiCuGQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-GQq7f134Nc2EzMnOjrPIQw-1; Tue, 01 Jul 2025 03:55:08 -0400
X-MC-Unique: GQq7f134Nc2EzMnOjrPIQw-1
X-Mimecast-MFC-AGG-ID: GQq7f134Nc2EzMnOjrPIQw_1751356507
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748cf01de06so7093962b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 00:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356506; x=1751961306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHdMzgFfQJGJTVG/4M9MM8/CUYx5m9feJxrpAo8o1hk=;
        b=un/wOtvtUYZeV2qRjR+wmj3WIhgsjwG+X+7+c2ah6frM3/2HKzIPSHsgVFQRFiQN84
         DnpzHJ2eaj4Sz5IazjOqmKlLThP5DzqA9YSfEp5nz+zs4XSF31L5SbZFsWrDNVHI7OEm
         +ekWyHJYRq2WQRi3B6yjhzgbIv3/OLm/RX6ZRjQSqbgAj9QQqlY7Hlug40sc6hIwR49J
         TLx/u8jpyS20MPQDnMHIbJEL2Iw6uLOZac4zXbU/wZAEjyBCvAWgi4o61VZcZ+Wb9aRD
         nf+OqlYNkExU+qcaF8cyztaawVTE+HoXQffRWfCwrVLQYJnVR9vJ5//r67gAtVibG8XM
         Ug/g==
X-Forwarded-Encrypted: i=1; AJvYcCUFRu9hGCFIodrXi+E/cWB2Ivv4ymy1XwTDZz+u5Dyvxexlne/vNTNetL5JTwKtUkNOAfmPrxQQV2O8eRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvsztO9PGUhvU6WQ0SV5/x0/duTTE/RImnB1V04av118yk2rX
	f3Lm7lhxr3tBoJTltD7etE8/1fYWSB+NC76XDChw/9+Yr2iFyBdKaRlXxDy5AILZXOo+JONGMRv
	JzZURsJPkgWYoezJL3hBieOPrAotLH7jw1ZMiKUrMUY7m6A6dKCeSO4WoUFgfAcz9YQ==
X-Gm-Gg: ASbGncsh7rCA9GpD4eC7jgFHFrqw+DPzgIZwBNx+oEFnJCKdRv8rcvHBKcqdxrAZF5H
	9qLSsTjcVgQ2ouYdPJLsGGIsjDr5rnFuaJ2nYaCni2lGbRJ5590CieR2OJJroVieevJoX5lX4uD
	5bqFnX5JGDvXSk994dc1zPQ4WQ0y807uFNxdg8WuU6q5q96cw8IW2rlYqDjLBGVai+H2IlJ3hq5
	bxoec4Wnw2106jocCmSZcLbSaWbZluXvL/1qrJGnl68MbsPNB6qhohEWj1o3c97HVss0hRWoACc
	/WGF1SZ3IeMmJeOic/zPuDOLSpcVW2i+KwrEFLTwxuC9E9UF
X-Received: by 2002:a05:6a00:1495:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-74af6ebdffdmr22051632b3a.2.1751356506618;
        Tue, 01 Jul 2025 00:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLLY/eKZv2t5yuLjLiXwRD/wN1GO4pT44DogAvkkhU/DiOVmH3mQAj6VLHh0UEaPV5yfZWTg==
X-Received: by 2002:a05:6a00:1495:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-74af6ebdffdmr22051587b3a.2.1751356506152;
        Tue, 01 Jul 2025 00:55:06 -0700 (PDT)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557439csm11016401b3a.80.2025.07.01.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:55:05 -0700 (PDT)
Message-ID: <ce0fdbf2753075056c227ce7567a69386a5aa0a3.camel@redhat.com>
Subject: Re: [RESEND PATCH v9 1/4] PCI: rockchip: Use standard PCIe defines
From: Philipp Stanner <pstanner@redhat.com>
To: Geraldo Nascimento <geraldogabriel@gmail.com>, 
	linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,  Manivannan Sadhasivam <mani@kernel.org>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner
 <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rick wertenbroek <rick.wertenbroek@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Valmantas Paliksa
 <walmis@gmail.com>, linux-phy@lists.infradead.org,
 linux-pci@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 01 Jul 2025 09:54:51 +0200
In-Reply-To: <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>
References: <cover.1751322015.git.geraldogabriel@gmail.com>
	 <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-30 at 19:24 -0300, Geraldo Nascimento wrote:
> Current code uses custom-defined register offsets and bitfields for
> standard PCIe registers. Change to using standard PCIe defines. Since
> we are now using standard PCIe defines, drop unused custom-defined
> ones,
> which are now referenced from offset at added Capabilities Register.

This could be phrased a bit more cleanly. At least I don't get exactly
what "from offset" means. You mean you replace the unused custom ones?
But if they're unused, why are they even being replaced?


>=20
> Suggested-By: Bjorn Helgaas <bhelgaas@google.com>

s/By/by


P.

> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
> =C2=A0drivers/pci/controller/pcie-rockchip-ep.c=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0drivers/pci/controller/pcie-rockchip-host.c | 44 ++++++++++--------=
-
> --
> =C2=A0drivers/pci/controller/pcie-rockchip.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 12 +-----
> =C2=A03 files changed, 25 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c
> b/drivers/pci/controller/pcie-rockchip-ep.c
> index 55416b8311dd..300cd85fa035 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -518,9 +518,9 @@ static void rockchip_pcie_ep_retrain_link(struct
> rockchip_pcie *rockchip)
> =C2=A0{
> =C2=A0	u32 status;
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D PCI_EXP_LNKCTL_RL;
> -	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_BASE +
> PCI_EXP_LNKCTL);
> =C2=A0}
> =C2=A0
> =C2=A0static bool rockchip_pcie_ep_link_up(struct rockchip_pcie *rockchip=
)
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
> b/drivers/pci/controller/pcie-rockchip-host.c
> index b9e7a8710cf0..65653218b9ab 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -40,18 +40,18 @@ static void rockchip_pcie_enable_bw_int(struct
> rockchip_pcie *rockchip)
> =C2=A0{
> =C2=A0	u32 status;
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0}
> =C2=A0
> =C2=A0static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip=
)
> =C2=A0{
> =C2=A0	u32 status;
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0}
> =C2=A0
> =C2=A0static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie
> *rockchip)
> @@ -269,7 +269,7 @@ static void rockchip_pcie_set_power_limit(struct
> rockchip_pcie *rockchip)
> =C2=A0	scale =3D 3; /* 0.001x */
> =C2=A0	curr =3D curr / 1000; /* convert to mA */
> =C2=A0	power =3D (curr * 3300) / 1000; /* milliwatt */
> -	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
> +	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
> =C2=A0		if (!scale) {
> =C2=A0			dev_warn(rockchip->dev, "invalid power
> supply\n");
> =C2=A0			return;
> @@ -278,10 +278,10 @@ static void
> rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
> =C2=A0		power =3D power / 10;
> =C2=A0	}
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
> -	status |=3D (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
> -		=C2=A0 (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCAP);
> +	status |=3D FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
> +	status |=3D FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCAP);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -309,14 +309,14 @@ static int rockchip_pcie_host_init_port(struct
> rockchip_pcie *rockchip)
> =C2=A0	rockchip_pcie_set_power_limit(rockchip);
> =C2=A0
> =C2=A0	/* Set RC's clock architecture as common clock */
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D PCI_EXP_LNKSTA_SLC << 16;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0
> =C2=A0	/* Set RC's RCB to 128 */
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D PCI_EXP_LNKCTL_RCB;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0
> =C2=A0	/* Enable Gen1 training */
> =C2=A0	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> @@ -341,9 +341,9 @@ static int rockchip_pcie_host_init_port(struct
> rockchip_pcie *rockchip)
> =C2=A0		 * Enable retrain for gen2. This should be
> configured only after
> =C2=A0		 * gen1 finished.
> =C2=A0		 */
> -		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_LCS);
> +		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
> =C2=A0		status |=3D PCI_EXP_LNKCTL_RL;
> -		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_LCS);
> +		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
> =C2=A0
> =C2=A0		err =3D readl_poll_timeout(rockchip->apb_base +
> PCIE_CORE_CTRL,
> =C2=A0					 status,
> PCIE_LINK_IS_GEN2(status), 20,
> @@ -380,15 +380,15 @@ static int rockchip_pcie_host_init_port(struct
> rockchip_pcie *rockchip)
> =C2=A0
> =C2=A0	/* Clear L0s from RC's link cap */
> =C2=A0	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
> -		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_LINK_CAP);
> -		status &=3D ~PCIE_RC_CONFIG_LINK_CAP_L0S;
> -		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_LINK_CAP);
> +		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
> +		status &=3D ~PCI_EXP_LNKCAP_ASPM_L0S;
> +		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
> =C2=A0	}
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
> -	status &=3D ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
> -	status |=3D PCIE_RC_CONFIG_DCSR_MPS_256;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCTL);
> +	status &=3D ~PCI_EXP_DEVCTL_PAYLOAD;
> +	status |=3D PCI_EXP_DEVCTL_PAYLOAD_256B;
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCTL);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0err_power_off_phy:
> diff --git a/drivers/pci/controller/pcie-rockchip.h
> b/drivers/pci/controller/pcie-rockchip.h
> index 5864a20323f2..f5cbf3c9d2d9 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -155,17 +155,7 @@
> =C2=A0#define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
> =C2=A0#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> =C2=A0#define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
> -#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
> -#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
> -#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE
> + 0xcc)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
> -#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> -#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> +#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
> =C2=A0#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE +
> 0x90c)
> =C2=A0#define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE +
> 0x274)
> =C2=A0#define=C2=A0=C2=A0 PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20=
)


