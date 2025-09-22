Return-Path: <linux-kernel+bounces-826703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E50B8F276
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6643AA79B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA2254AFF;
	Mon, 22 Sep 2025 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Xk5/kVXU"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51F2E401
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522749; cv=none; b=W3UD3c571NZxynSL2P98490FUMzXwlLAL7ySSFJZ2d4G/FVW1BidM3cdNdCHrN9uSjiQ7Ub1aKe3FZvTLfrt1BVi9wyILVSsohzjCKNL45o9QTh7Dpn3AubXupJPBJxwfjnIFImd1QwASZUuTHRWfPsW3S9SKbCs9/YGkgswJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522749; c=relaxed/simple;
	bh=YubifslHICPIZVPwEXD2B/cHyglHEMOWkV3UXsZFgZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AoKYBs0v3Iv1HMjed6s0F0eyVg1qHVbzklYcn1aSrJPCeLJ28LPzbraFJ9VEWmUYHrxppc5+36UpPpi0yoYlokSzVABAbdqXVSkhYh6lq8+K9SOJ43S6WpgxD/GOf44C0LU0Nha4vTHf+gFEoOTGvx+7Tzgp0DMPJFio95aQqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Xk5/kVXU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cCx+9yjjowpPnPkXHgBr6oVC5xhComuV9u3ACqyOGsw=;
	t=1758522747; x=1759732347; b=Xk5/kVXUdgFOD/pXjCz0avjiF4biRH7RBX+6CUZSxMIbQVb
	qlyqTUvGmPwO3QqQ2PfCOBwaRJ/FNAhLXTCwdJX5HPDdU9/9BxnE3rmjGeRbGaXNqG4X6oDRi94I/
	7BlpXi7c+0fHAWPStwY7LMUGCyedQL6xZS4ZMpMFxo/cIWZesLZTJh0Oz/7kcu3m/qo/vQP6RRYne
	/oZ9bEeE/Q5sOULgkXIuvUZJeiSYzWXi0FhHReL0oOLK7YpBdNYU7LBOMpnGi/IpU1zBP34rMtYni
	k6ISobgNhfk7UVSUb0zhh+TWGJspChbxd8eoGUNZZqqs0fxuDuhqIcP/J9QqGp6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0a63-0000000489S-2JdX;
	Mon, 22 Sep 2025 08:32:23 +0200
Message-ID: <39692eca904137ce7d51fccdc948ae0b94b4fe4f.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 08:32:22 +0200
In-Reply-To: <m25xde80qh.wl-thehajime@gmail.com> (sfid-20250920_014621_763283_43F42C24)
References: <cover.1758181109.git.thehajime@gmail.com>
		<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
		<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
		<m28qib8g1r.wl-thehajime@gmail.com>
		<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
		<m27bxu949d.wl-thehajime@gmail.com>
		<da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
	 <m25xde80qh.wl-thehajime@gmail.com> (sfid-20250920_014621_763283_43F42C24)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-09-20 at 08:46 +0900, Hajime Tazaki wrote:
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 6a0354ca032f..04025207a077 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -159,6 +159,7 @@ config UML_RTC
> =20
>  config UML_PCI
>         bool
> +       depends on MMU

That won't do anything since you elsewhere have "select UML_PCI"
independent of MMU.

> @@ -170,6 +171,7 @@ config UML_PCI_OVER_VIRTIO
>         bool "Enable PCI over VIRTIO device simulation"
>         # in theory, just VIRTIO is enough, but that causes recursion
>         depends on VIRTIO_UML
> +       depends on MMU
>         select UML_PCI

Right, but you also need that for UML_PCI_OVER_VFIO.

> and do
>   ./tools/testing/kunit/kunit.py config  --kconfig_add CONFIG_MMU=3Dn
>=20
> the validation currently gives the following error:
>=20
>  ERROR:root:Not all Kconfig options selected in kunitconfig were in the g=
enerated .config.
>  This is probably due to unsatisfied dependencies.
>  Missing: CONFIG_UML_PCI_OVER_VIRTIO=3Dy

Well, OK, but that's fair - you did specifically override MMU=3Dn, and
virtio-over-pci needs it.

> 1) use --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dn when using kunit w/
>   !MMU, and drop this patch from the series (no modification to the tree)
> 2) prepare a different file for !MMU & ARCH=3Dum testing (e.g.,
>   arch_uml_nommu.config), and add an option to kunit.py to switch MMU
>   or !MMU
> 3) implement virtio-pci for !MMU and propose to remove the restriction
>   of CONFIG_PCI depends on CONFIG_MMU.
>=20
> 2) will be removed when 3) is done so, I'm hesitating to propose a
> patch used by whole tree.
>=20
> so, I think 1) is (not the best but) a reasonable solution, with a
> note in nommu-uml specific document (i.e., [PATCH 12/13]).

I don't think (3) makes any sense at all, we should just _never_ do
that. !MMU is really here in UML for testing to support other
architectures that are !MMU, and since by today's definitions no other
architecture can have PCI without MMU, it makes no sense for UML to have
that (and complicate the PCI code unnecessarily, etc.)

I think it's entirely reasonable to have overriding CONFIG_MMU=3Dn to also
necessitate overriding CONFIG_UML_PCI_OVER_VIRTIO, i.e. (1).

As to whether or not to add a specific config file, honestly I don't
really know or even care - you'd have to ask the people who actually
want to test !MMU.

johannes

