Return-Path: <linux-kernel+bounces-851187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BA8BD5B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DB944F1265
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221A2D6E75;
	Mon, 13 Oct 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqn9Ilqg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31F2D6E44
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380222; cv=none; b=OBbLL5MFgTTEcBWdV6iygY2ed2POICcX2weAWwCdXi2ayRwtM0FnTwYvAizyRowxG2ePTbkt7eDb0z+caMLo8oWAJwB3qSKUi7RVT/5zmk6P1WenRda8+ShlgD3d9R2wzu36wSuYeIQCp0U5rWlTNKjhF+Bg1r3ZpipqONn0wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380222; c=relaxed/simple;
	bh=DQQ6OBr2524+qZB672GSzrUccJmaXhbWsh5xplRUxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHxHtpr6wQoFgh9Pg3zH8kkYuxcSoxWg7gnZ9GBjZ/54X3MHmKXKJYxgoE3IzZIBshyVIW9qeyjYnj9R9k4ip+i7hIcQFccoCvBOl7jdi/xRs82ctjlpJusEYwlmItWFeivz5hecE32VAQ+3ZTdNKxrrroESR27KgOdiCNmyIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqn9Ilqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86168C4CEE7;
	Mon, 13 Oct 2025 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380221;
	bh=DQQ6OBr2524+qZB672GSzrUccJmaXhbWsh5xplRUxZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rqn9IlqgfeldlIBto2PijJ0hKPkB5Tz/7lpv+p+BEac8+AkDi6Xq7ORyv67/TGA3K
	 d9Pu9seNioMricGO54V5H7i773NG1SfdgctmHcNuoOIx2pRQNSz6fscnrsPTBH5u6B
	 ZmzTuP2KHJ4J+irZBd/UfOesMGjOLEozy03uQ2JhvQ8Rne2eEvaMZTI8s6yqpwsXlh
	 plgxUb5Xy8/pmejhxQQ+1jbyB88INzOsP6mdtz3z4m89zEmUS1kyPD1LE0AZ/6tmSv
	 3IAoBg+YaA27SH8y/sYJNBIV7dJ2acBaK+lkeggxxK76uCUNyl43Xv1d9q0Ps+mwV5
	 COJTaTrsndliQ==
Date: Mon, 13 Oct 2025 19:30:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-kernel@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>, linux-riscv@lists.infradead.org,
	Zhang Xincheng <zhangxincheng@ultrarisc.com>
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
Message-ID: <20251013-trimness-stainless-48343053f204@spud>
References: <20251013111539.2206477-1-lzampier@redhat.com>
 <20251013111539.2206477-4-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fCaikIoT7Zs8h/ij"
Content-Disposition: inline
In-Reply-To: <20251013111539.2206477-4-lzampier@redhat.com>


--fCaikIoT7Zs8h/ij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:15:38PM +0100, Lucas Zampieri wrote:
> From: Charles Mirabile <cmirabil@redhat.com>
>=20
> Add a new compatible for the plic found in UltraRISC DP1000 with a quirk =
to
> work around a known hardware bug with IRQ claiming.
>=20
> When claiming an interrupt on the DP1000 PLIC all other interrupts must be
> disabled before the claim register is accessed to prevent incorrect
> handling of the interrupt.
>=20
> When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
> the enable state of all interrupts is saved and then all interrupts
> except for the first pending one are disabled before reading the claim
> register. The interrupts are then restored before further processing of
> the claimed interrupt continues.
>=20
> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> SoCs using UR-CP100 cores, regardless of the specific SoC implementation.

Why is that? I expect that you're doing that intentionally given the
ultrarisc employee listed as a co-developer, but with only one SoC using
this IP core it seems possible that this bug in the hardware could be
fixed for other SoCs that are built using this IP core.
Is there a plan to, for example, change the core version to UR-CP101
when the bug is fixed?

Thanks,
Conor.

> This has no impact on other platforms.
>=20
> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 83 ++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 9c4af7d58846..a7b51a925e96 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -49,6 +49,8 @@
>  #define CONTEXT_ENABLE_BASE		0x2000
>  #define     CONTEXT_ENABLE_SIZE		0x80
>=20
> +#define PENDING_BASE                    0x1000
> +
>  /*
>   * Each hart context has a set of control registers associated with it. =
 Right
>   * now there's only two: a source priority threshold over which the hart=
 will
> @@ -63,6 +65,7 @@
>  #define	PLIC_ENABLE_THRESHOLD		0
>=20
>  #define PLIC_QUIRK_EDGE_INTERRUPT	0
> +#define PLIC_QUIRK_CLAIM_REGISTER	1
>=20
>  struct plic_priv {
>  	struct fwnode_handle *fwnode;
> @@ -367,6 +370,82 @@ static const struct irq_domain_ops plic_irqdomain_op=
s =3D {
>  	.free		=3D irq_domain_free_irqs_top,
>  };
>=20
> +static bool dp1000_isolate_pending_irq(int nr_irq_groups, u32 ie[],
> +				       void __iomem *pending,
> +				       void __iomem *enable)
> +{
> +	u32 pending_irqs =3D 0;
> +	int i, j;
> +
> +	/* Look for first pending interrupt */
> +	for (i =3D 0; i < nr_irq_groups; i++) {
> +		pending_irqs =3D ie[i] & readl(pending + i * sizeof(u32));
> +		if (pending_irqs)
> +			break;
> +	}
> +
> +	if (!pending_irqs)
> +		return false;
> +
> +	/* Disable all interrupts but the first pending one */
> +	for (j =3D 0; j < nr_irq_groups; j++) {
> +		u32 new_mask =3D 0;
> +
> +		if (j =3D=3D i)
> +			/* Extract mask with lowest set bit */
> +			new_mask =3D (pending_irqs & -pending_irqs);
> +
> +		writel(new_mask, enable + j * sizeof(u32));
> +	}
> +
> +	return true;
> +}
> +
> +static irq_hw_number_t dp1000_get_hwirq(struct plic_handler *handler,
> +					void __iomem *claim)
> +{
> +	void __iomem *enable =3D handler->enable_base;
> +	void __iomem *pending =3D handler->priv->regs + PENDING_BASE;
> +	int nr_irqs =3D handler->priv->nr_irqs;
> +	int nr_irq_groups =3D DIV_ROUND_UP(nr_irqs, 32);
> +	int i;
> +	u32 ie[32] =3D { 0 };
> +	irq_hw_number_t hwirq =3D 0;
> +
> +	raw_spin_lock(&handler->enable_lock);
> +
> +	/* Save current interrupt enable state */
> +	for (i =3D 0; i < nr_irq_groups; i++)
> +		ie[i] =3D readl(enable + i * sizeof(u32));
> +
> +	if (!dp1000_isolate_pending_irq(nr_irq_groups, ie, pending, enable))
> +		goto out;
> +
> +	hwirq =3D readl(claim);
> +
> +	/* Restore previous state */
> +	for (i =3D 0; i < nr_irq_groups; i++)
> +		writel(ie[i], enable + i * sizeof(u32));
> +out:
> +	raw_spin_unlock(&handler->enable_lock);
> +	return hwirq;
> +}
> +
> +static irq_hw_number_t plic_get_hwirq(struct plic_handler *handler,
> +				      void __iomem *claim)
> +{
> +	/*
> +	 * Due to a hardware bug in the implementation of the claim register
> +	 * in the UltraRISC DP1000 platform, other interrupts must be disabled
> +	 * before reading the claim register and restored afterwards.
> +	 */
> +
> +	if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
> +		return dp1000_get_hwirq(handler, claim);
> +
> +	return readl(claim);
> +}
> +
>  /*
>   * Handling an interrupt is a two-step process: first you claim the inte=
rrupt
>   * by reading the claim register, then you complete the interrupt by wri=
ting
> @@ -384,7 +463,7 @@ static void plic_handle_irq(struct irq_desc *desc)
>=20
>  	chained_irq_enter(chip, desc);
>=20
> -	while ((hwirq =3D readl(claim))) {
> +	while ((hwirq =3D plic_get_hwirq(handler, claim))) {
>  		int err =3D generic_handle_domain_irq(handler->priv->irqdomain,
>  						    hwirq);
>  		if (unlikely(err)) {
> @@ -432,6 +511,8 @@ static const struct of_device_id plic_match[] =3D {
>  	  .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>  	{ .compatible =3D "thead,c900-plic",
>  	  .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +	{ .compatible =3D "ultrarisc,cp100-plic",
> +	  .data =3D (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
>  	{}
>  };
>=20
> --
> 2.51.0
>=20

--fCaikIoT7Zs8h/ij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO1FOQAKCRB4tDGHoIJi
0ivUAQD/Pb15fC2TzJvig9NwYEzMS6COdO2rFEosfel5YRSh/wEAjfmALZ82Zu5t
ZRfxApD3LqaW+Tx/zWBhztMPJKaxtwI=
=4Tzv
-----END PGP SIGNATURE-----

--fCaikIoT7Zs8h/ij--

