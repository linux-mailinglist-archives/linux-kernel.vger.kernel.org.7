Return-Path: <linux-kernel+bounces-871419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71FDC0D2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B057319A4BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B78D2FB635;
	Mon, 27 Oct 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JZcT7et4"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FF2772D;
	Mon, 27 Oct 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565130; cv=none; b=DfqWTdW85fF/B/5/8/Q+Pc0BNLpYLw5XSS5g/c5BuK4hr1adEyoAJD0wPZaMZEQ7ckAnjZqLkYb47EqnbcKklSjYasMMRJLiS9Ffu6RSk96ssDkC5nN15snRTxKJYUrANYWXFgkg1lnBHwhhzK4nqRe3lJI+qsiYQS5a1s3iIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565130; c=relaxed/simple;
	bh=fg3boSJuaVR/snHafzjml9FZCZHr3BIKh5VS1BQQFA4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Drl0+dfeZFqZgTANAXACUBIrFHpkFpHRPrARYMnfwW0xHhr4kW+2duKfa2hUjpH0PCzIf+MgYPEKqZd8yPg7jcMqpQxQuh648m8CQcdxadDEX85eCaRCIMk9lRpU7LyEG3Cr9auL9MXr/tYEoHZmHwIXAAjvMC8WoqoFDG/Gxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JZcT7et4; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id E89CC40D0D;
	Mon, 27 Oct 2025 12:38:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761565124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pp+cdt5NUUAp/RayY/UAf6z47hnHubbe0RqQqLbK1fg=;
	b=JZcT7et4yPf/J0RdIhCYH2lB1UyH+WU6CUzpWPc6n0kWLt471Tt4zM9yUi1AE5Xi4VKwkC
	HSXLev3iMEqkk/raGfqRL11mYQPEADAfaj3BehnvwKmJ/6Y3Q7ath1yHTX975Gy90Dqp2X
	zTj2GRvGCqV75VyrG7cTJP1bRIFTiTpM5xX7aQlnkrTYOzdFFxzW1HHW8wYSOBtOd6Go7K
	O5meD131epz7A4ykMfSL9Nr6J1jfQCwwVcsUrohDfENyno0uCpiywCh96zDwiu2OXBBgv9
	yC4+gWxqRjuVSti29HyeMsnLb76/nCruVcaLuhxlSA6qC9sRt60N6OxOFQ0suw==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <DDSFVM1TXN8C.3JNX2M8XX04IF@cknow-tech.com>
Content-Type: text/plain; charset="utf-8"
References: <20251026153805.107774-1-diederik@cknow-tech.com> <DDSFVM1TXN8C.3JNX2M8XX04IF@cknow-tech.com>
Date: Mon, 27 Oct 2025 12:38:42 +0100
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Johan Jonker" <jbx6244@gmail.com>
To: "Diederik de Haas" <diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d190d649-acd5-4202-4a7a-94b9ada67b17@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= Harmonize regulator formatting for Pine64 rk3566 
 devices
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Diederik,

On Sunday, October 26, 2025 18:44 CET, "Diederik de Haas" <diederik@ckn=
ow-tech.com> wrote:
> On Sun Oct 26, 2025 at 4:37 PM CET, Diederik de Haas wrote:
> > The regulator node properties in Pine64 rk3566 devices were formatt=
ed
> > rather inconsistently. To name a few:
> > - 'name' was sometimes put at the top of the list, while at other t=
imes
> >   it was (mostly) sorted in alphabetical order
> > - 'always-on' and 'boot-on' were sometimes at the top of the list,
> >   sometimes not
> > - 'state-mem' nodes sometimes had a preceding blank line, as they
> >   should, but sometimes not
> > - other properties seem to have been added to the end of the list, =
not
> >   in their alphabetical/natural order
> >
> > So harmonize the formatting by making all properties sorted
> > alphabetically/naturally. And harmonize the formatting of the
> > 'state-mem' nodes so they all have a preceding blank line. While at=
 it,
> > also fix 2 incorrectly indented nodes.
> >
> > No functional changes.
>=20
> I just found some additional ones.
> If these changes are considered OK (in principle), then I'll send a v=
2
> at some point.

Thanks for this patch!  FWIW, I think that SoC-wide DT cleanups
and unifications such as this are nice and safe to do, so my vote
goes towards the v2. :)

> > Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
> > ---
> >  .../boot/dts/rockchip/rk3566-pinenote.dtsi    | 52 +++++++++------=
----
> >  .../boot/dts/rockchip/rk3566-pinetab2.dtsi    | 29 ++++++++---
> >  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 51 +++++++++++----=
---
> >  .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 52 ++++++++++-----=
----
> >  .../dts/rockchip/rk3566-soquartz-blade.dts    |  6 +--
> >  .../boot/dts/rockchip/rk3566-soquartz-cm4.dts |  6 +--
> >  .../dts/rockchip/rk3566-soquartz-model-a.dts  | 10 ++--
> >  .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 43 ++++++++++-----
> >  8 files changed, 148 insertions(+), 101 deletions(-)


