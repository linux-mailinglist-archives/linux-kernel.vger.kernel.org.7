Return-Path: <linux-kernel+bounces-764425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89236B222DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD1A2A3B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6962E974A;
	Tue, 12 Aug 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="AOHW2uep"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3D2E8DFA;
	Tue, 12 Aug 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990295; cv=pass; b=m2ooUEaUBebLvOgAFlXvOntv8C/nWb5sLzogz9ON+bDV4AUDCGh60saUS7t1u1T5psSwARvEZLlpe53iDN9hItYE166hsXaxyJuVUROwtf0QYKoUQm7R+FYI19OKC3kvxRDOfMYNqS2vCD5IlQAgvut+CHLZlCKo6roNwtRij20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990295; c=relaxed/simple;
	bh=1+hInyaCbxnzsVD/At0u5EtgvJbYvgUqxLbC8ItIg3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWG66FAWxZPxUgv8knZ91bJJoafCpfHP8tcBkC0WmgxjgRpuIyYD9+Ks6+SUyRaKs+lXdTcIv/n3W9K8N9bQwcyEdqQH/lzrZXp9A4fnPu9GebV3mI3lieLTRvmpS7HCRloN/cfA+LFk8Hd/0EHvh8gijELTJ0aHfPp4X6+9reU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=AOHW2uep; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1754990274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VGoHwuknbXdy2ikBZ1vGU0AWjSXzzg0mbeI+XAGjv3lI6bjWhYJe+W6PZpzvf8HkjK3FEkG0hbzKbj9V3ywie1c1s9+mF/rWWDDltZbfjZJIUwCWE+bS8HX80iAfnyPcTBj6Xx104uWUbmV+Oa3ioxqF0K7pS3vibr9TIfMQdq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754990274; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1+hInyaCbxnzsVD/At0u5EtgvJbYvgUqxLbC8ItIg3Y=; 
	b=iROwg3CKcXXrofcmrd3Pz9aX8GMpSIOt+9JzonuH/ivzcEkUiZeTrHVWLhHOhh6ptgtWQc9DD+5D6dnEQCIKh32AZIYC4RI/zLvfmvFRFXEBgR1Pkd2lpOcBsGt1pX+Vn/TsJAiPd8JgpTzVH2WUmMAAo/FR/21H+8uYHOofBkI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754990274;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=1+hInyaCbxnzsVD/At0u5EtgvJbYvgUqxLbC8ItIg3Y=;
	b=AOHW2uepCwbOHaGmfXrIOS7xN5xZ7vXbAwjyRc/gFEbvSb0cBIkHga3zU+BlcgKz
	3BvH+dgbFSBKdx7pivNHiOOdj2vL57zp2EjeRssbmNuOWeT14zFq6PzBkLGjmT27dsH
	N2vailR+WOvTebM2bc0/ovf0YYJF4pKgh5PKfr2aVhP9/p31pZhjtpJw7utukub7JaO
	owUadTOQY0NQwwKH/F8eQM3sujQxBj1euXhd7A+7RkKjYuPbx0xiYfunfRa9qkkf3Ap
	xMKkSAgQ6bbvHvxwCrIK5dMfxFeP7rFq8PZYmXiIPDEx6mtPV5UWSr90dbaV97z+rZK
	e1i/ZXUZ9A==
Received: by mx.zohomail.com with SMTPS id 1754990271194111.10728242341895;
	Tue, 12 Aug 2025 02:17:51 -0700 (PDT)
Message-ID: <6d21521067409c483a8d7af39e43a6d579c98dc4.camel@icenowy.me>
Subject: Re: [PATCH 4/4 FIXED] clk: thead: th1520-ap: fix parent of padctrl0
 clock
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 12 Aug 2025 17:17:45 +0800
In-Reply-To: <20250812060433.1979587-1-uwu@icenowy.me>
References: <20250812054258.1968351-5-uwu@icenowy.me>
	 <20250812060433.1979587-1-uwu@icenowy.me>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-08-12=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 14:04 +0800=EF=BC=
=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> The padctrl0 clock seems to be a child of the perisys_apb4_hclk
> clock,
> gating the later makes padctrl0 registers stuck.
>=20
> Fix this relationship.
>=20
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> This is the consequence of fixing 3/4, because these two patches are
> at
> nearly the same position, and unfortunately get dependent by the
> algorithm of diff.
>=20
> Ignore the original 4/4 and look at this too.
>=20
> =C2=A0drivers/clk/thead/clk-th1520-ap.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/thead/clk-th1520-ap.c
> b/drivers/clk/thead/clk-th1520-ap.c
> index 75ea1705cc08f..0ecedac50d6cb 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -917,13 +917,18 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK,
> perisys_apb3_hclk, "perisys-apb3-hclk", p
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00x150, BIT(11), CLK_IS_CRITICAL);
> =C2=A0static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-
> apb4-hclk", perisys_ahb_hclk_pd,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00x150, BIT(12), 0);
> +
> +static const struct clk_parent_data perisys_apb4_hclk_pd[] =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .hw =3D &perisys_apb4_hclk.c=
ommon.hw },
> +};
> +
> =C2=A0static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd,
> 0x1c8, BIT(5), CLK_IS_CRITICAL);
> =C2=A0static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd,
> 0x1e0, BIT(13), CLK_IS_CRITICAL);
> =C2=A0static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio",
> emmc_sdio_ref_clk_pd, 0x204, BIT(30), 0);
> =C2=A0static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd,
> 0x204, BIT(26), 0);
> =C2=A0static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1",
> perisys_apb_pclk_pd, 0x204, BIT(24), 0);
> =C2=A0static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart",
> perisys_apb_pclk_pd, 0x204, BIT(23), 0);
> -static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0",
> perisys_apb_pclk_pd, 0x204, BIT(22), 0);
> +static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0",
> perisys_apb4_hclk_pd, 0x204, BIT(22), 0);

Oops looks like this does not work and orphans the clock...

> =C2=A0static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi",
> axi4_cpusys2_aclk_pd, 0x204, BIT(21), 0);
> =C2=A0static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk",
> peri2sys_apb_pclk_pd, 0x204, BIT(20), 0);
> =C2=A0static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd,
> 0x204, BIT(19), 0);


