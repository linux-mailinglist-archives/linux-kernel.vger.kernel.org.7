Return-Path: <linux-kernel+bounces-762620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A34B2090A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E613A43BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9242D3A83;
	Mon, 11 Aug 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="gX/CWJyQ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABD145A05;
	Mon, 11 Aug 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916085; cv=pass; b=PH053EpkTrMW7Fvicmp9rd8Q6oHs0KKLOsA9+7cCVrfTyTkjKePPWG2zfoOSwAw/Et+uf8zKvCxiNueHgxjUpOxLk6Upm/qn17Kn5lhMuvYxcJe5YWVPhCVqDisxbYRVbJYfa0+XaytIns7plVjtOnqppJ6yIgDdC6IEptARki4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916085; c=relaxed/simple;
	bh=U2yhdYGqAT6KsjoRuTApTSiNZyds64i5ntP2Ld/cNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuXOBzER9YfI//BZ1wOEsRGeG25NTPoJhlWHi4DEwiD66IwiMGZ1FY6G6QxuiGOQHPiqCHGQ4+SEyYiiw3ajOU4TqlnyGbiNBjeUAmfmExXKWgzuiUEvQ70i62jNU40g8mIeiC1CXqSfCXJCjF6USRCKY46j5l5u9YbwXFM6n74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=gX/CWJyQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754916021; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hteRfCRvkd67/Dx+dfT1KUe3zys+bioiMiINKAoqpiTvtPDlOOPKcNB/4tVKwVwFvHMX+zLzcvvN8ipbV5MQRiobOr64LC+LtReoaHmoo8FIaaicTy36wtcJ3j88Dxzd3G+4Uy6pQ12JiteUW9OgU0u5XMKeMWuH/5ZDs4BwGTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754916021; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4iGM2ITegptFt/GB57XpVHMLcIR82cp74UJOaNlV0sw=; 
	b=VcAWintDg6coTqlLrgPMr08CdjQAmkSsel+lKpq6Kh8IF21WYFLkuRKepDSDUD0T9aN9C5rVcu7rKoVqRt7JdTvX3VNtS1etNT5Df0aW3kz0XwsIDOJmw9+H77SZwdWzUjr3CdXD0lmxRPnbCLMGS7dgvUUk4n2dGelta4xYlWU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754916021;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=4iGM2ITegptFt/GB57XpVHMLcIR82cp74UJOaNlV0sw=;
	b=gX/CWJyQm5KR7h1N2KyiPRq8MQNw2pzdjNaWcZe8wF+RXthtgRjx22s8MqNdJdiz
	bJJPv4dtcLip+KRMuOEv1uYh6uOFoWtkGR9PW9gofTrl+kAMhB4SA0YLWH2lO20DIsW
	qMX4h73cw6RxpBErFYkaYYQ4PmiEOWRenASXbqns=
Received: by mx.zohomail.com with SMTPS id 1754916019156141.85896495716338;
	Mon, 11 Aug 2025 05:40:19 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Niklas Cassel <cassel@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
 Alexey Charkov <alchark@gmail.com>, Patrick Wildt <patrick@blueri.se>,
 Chukun Pan <amadeus@jmu.edu.cn>, Diederik de Haas <didi.debian@cknow.org>,
 Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
Subject:
 Re: [PATCH v2 1/2] arm64: dts: rockchip: Add the vdpu381 Video Decoders on
 RK3588
Date: Mon, 11 Aug 2025 08:40:16 -0400
Message-ID: <2793168.mvXUDI8C0e@trenzalore>
In-Reply-To: <aJjxjgG1gEaKBVwE@desktop>
References:
 <20250808193602.142527-1-detlev.casanova@collabora.com>
 <20250808193602.142527-2-detlev.casanova@collabora.com>
 <aJjxjgG1gEaKBVwE@desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi,

On Sunday, 10 August 2025 15:22:54 EDT Link Mauve wrote:
> Hi,
> 
> On Fri, Aug 08, 2025 at 03:36:01PM -0400, Detlev Casanova wrote:
> > Add the vdpu381 Video Decoders to the rk3588-base devicetree.
> > 
> > The RK3588 based SoCs all embed 2 vdpu381 decoders.
> > This also adds the dedicated IOMMU controllers.
> 
> Back in the VEPU121 enablement series[1] it had been decided to not
> expose multiple identical cores yet, because there is no infrastructure
> yet in the kernel to schedule multiple userland processes on multiple
> cores, or (more relevant for your usecase) to even combine two cores to
> reach 8K support.

That's right, but the device tree still defines the hardware as it is. The 
driver, however, will  make sure that each instance after the first one is 
ignored (at least for now).

> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> 
> [snip]
> 
> Thanks,
> 
> [1]
> https://lore.kernel.org/all/20240618183816.77597-1-sebastian.reichel@collab
> ora.com/

Detlev.




