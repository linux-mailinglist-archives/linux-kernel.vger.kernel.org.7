Return-Path: <linux-kernel+bounces-767928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D217FB25AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F855806AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E51F5851;
	Thu, 14 Aug 2025 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Bxm3cBre"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E515C158;
	Thu, 14 Aug 2025 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755147816; cv=pass; b=PNI1pvQSyW4t6ssqoUCabdKAGbzIGR5oG3aMULeyeOXas8WOiplt5fKgFdAHaojx33TzkTizcMO6MCXSixlv0QosJyrIIfsHYGP3a3KVV98EYZ+nwgzh6u45wpw2yC78cnD0IdPKNuL6WBnAabHUCGGApOQopGN1GH1kgGHg2W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755147816; c=relaxed/simple;
	bh=gKJM5C644LG9rsg7duMR0KLnbszCz82kft+GL+KGUro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M++v3MypP8u+SCpA9HXSvGo8PG+VFyAO5gHv/fSN+Dg+l6lha3bE7QAYct9GFX1vxtLcKDvH6TnEeavVqENAV2btxW+zdzQwrrtcIvTbo755nTweLiTzaoIiSoM5taaejwI0/IWOzGK7VFKQLLvegRk0jheUZ2ia21KcYmMOgEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=Bxm3cBre; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755147802; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ntImf5J+UOrydq8pxjV1FsxBHnBAANDYN0HvR88uIR+nQ+NV48q0qO7FA1ibA2Exk1QQv5svsKOCvgJZ+xHiIpBLibFYYhY7eVQbGdV2W5lNkcI08uKD6GQ0ozZ8bv5nziJ3xXNrz9hn7NBYDFzr+W88YVtIssAkAeoX9VH9bHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755147802; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gKJM5C644LG9rsg7duMR0KLnbszCz82kft+GL+KGUro=; 
	b=CKqBwa8oKb5MwYr3pxv0/19z5hay4GRIRxssFxxqSUdrsfDiNBXHgpQD0OltSo5/YMyVj6MmZ9rIR6vBGr8wXzbcBVEA1K+DlCxDL64Hiding9SdwxuJ0FZQlr0NCrjbisKbFbPGwtG2WwTLoG6S0+IR4eihRf+TN90n5CFAGGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755147802;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=gKJM5C644LG9rsg7duMR0KLnbszCz82kft+GL+KGUro=;
	b=Bxm3cBrehiUEQB8zy1/W2o1kSecnuH3umONwv8l+gUpbPXZAMxQSn7n7F3aGKIgW
	OOY7+4crTW4nWjrX21o4/8oT7OdXPdX4CMzg7XPrd55FSl7netoQujY4GfKYZzI289N
	W3M6te0HIFJFHeCq6Ppi1IVbBok5h0H0d/5/Z8PvypLYNp/7/jECXWEWASc8qaPtVC2
	mCZKJTQRsnMYAiuBe9hzsarX0Do68I4D0OqVNQ4JLMmYRe24vGjN2Z7Gfs8SsHDmeT9
	gcTFu9Te21WfvD1THKrLtH8UcvJwSu3pSoA+B58pxzuaeSVt4L/0hh2rayT3AEZUC8q
	Zhq+reThHQ==
Received: by mx.zohomail.com with SMTPS id 1755147799613946.1322238706706;
	Wed, 13 Aug 2025 22:03:19 -0700 (PDT)
Message-ID: <fbbd4f01234d63d1a083944a3c90fa554a6ac458.camel@icenowy.me>
Subject: Re: [PATCH 2/2] clk: thead: th1520-ap: fix parent of padctrl0 clock
From: Icenowy Zheng <uwu@icenowy.me>
To: Guo Ren <guoren@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Fu Wei <wefu@redhat.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi <ziyao@disroot.org>,
 Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 13:03:12 +0800
In-Reply-To: <CAJF2gTT-ryXrM87BwvK_wp9F_ZEsqUHKJdkxKbtJmiq_07g2rA@mail.gmail.com>
References: <20250813171136.2213309-1-uwu@icenowy.me>
	 <20250813171136.2213309-3-uwu@icenowy.me>
	 <CAJF2gTT-ryXrM87BwvK_wp9F_ZEsqUHKJdkxKbtJmiq_07g2rA@mail.gmail.com>
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

=E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 11:08 +0800=EF=BC=
=8CGuo Ren=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Aug 14, 2025 at 1:12=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wr=
ote:
> >=20
> > The padctrl0 clock seems to be a child of the perisys_apb4_hclk
> > clock,
> > gating the later makes padctrl0 registers stuck too.
> >=20
> > Fix this relationship.
> Should it add a "Fixes:" tag?

Considering pulling this patch requires pulling PATCH 1/2 too, I doubt
whether this should be tagged a fix and trigger a backport operation.

>=20
> Others, LGTM!
>=20
> Reviewed-by: Guo Ren <guoren@kernel.org>
>=20
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0drivers/clk/thead/clk-th1520-ap.c | 5 ++++-
> > =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/thead/clk-th1520-ap.c
> > b/drivers/clk/thead/clk-th1520-ap.c
> > index d08e7fb387e50..f6f3d63d53353 100644
> > --- a/drivers/clk/thead/clk-th1520-ap.c
> > +++ b/drivers/clk/thead/clk-th1520-ap.c
> > @@ -888,13 +888,16 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK,
> > perisys_apb3_hclk, "perisys-apb3-hclk", p
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x150, 11, CLK_IS_CRITICAL);
> > =C2=A0static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk,
> > "perisys-apb4-hclk", perisys_ahb_hclk_pd,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x150, 12, 0);
> > +static const struct clk_parent_data perisys_apb4_hclk_pd[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .hw =3D &perisys_apb4_hclk.gate=
.hw },
> > +};
> > =C2=A0static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd,
> > 0x1c8, 5, CLK_IS_CRITICAL);
> > =C2=A0static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd,
> > 0x1e0, 13, CLK_IS_CRITICAL);
> > =C2=A0static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio",
> > emmc_sdio_ref_clk_pd, 0x204, 30, 0);
> > =C2=A0static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd,
> > 0x204, 26, 0);
> > =C2=A0static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1",
> > perisys_apb_pclk_pd, 0x204, 24, 0);
> > =C2=A0static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart",
> > perisys_apb_pclk_pd, 0x204, 23, 0);
> > -static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0",
> > perisys_apb_pclk_pd, 0x204, 22, 0);
> > +static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0",
> > perisys_apb4_hclk_pd, 0x204, 22, 0);
> > =C2=A0static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi",
> > axi4_cpusys2_aclk_pd, 0x204, 21, 0);
> > =C2=A0static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk",
> > peri2sys_apb_pclk_pd, 0x204, 20, 0);
> > =C2=A0static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd,
> > 0x204, 19, 0);
> > --
> > 2.50.1
> >=20
>=20
>=20


