Return-Path: <linux-kernel+bounces-734329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C585B08013
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646607A8F86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021112EE27B;
	Wed, 16 Jul 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xrauqQ7R"
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFF2EE261
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703150; cv=none; b=PDFGkzaBlOGyvKJGSN7JytUzrsySdw3xEaVUe/TCpOeSVNevZnaaWFdYATvWRT7J0lvuAaGwU6RV6KhnrjvmkRj8sUqQ1nUTrhZe5bkoqzIGt4jAXGv40FK+UMkwj0wCWREYFUsI0eFL4AVn/NfTBHOas3ok62CuObAFsMjVvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703150; c=relaxed/simple;
	bh=Hl07FxAtdNbkRG17OKg4eb9lsA+Zl2El7hudon5km68=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQUaicqTOX/X70i0ilpZ87CZLKtQL8zA227pjgRFNdVylB2+MV3Hh+yD8BbecGs1GG4YbQcYwfFZT6upczBIbtfiCmIV+4TlV3rBgO9dX+eLs4/U7HYnIaRnY7Sl1Ev09EPSyzXhZvGojsn0Jfy0rLZLNsMblbkYGXuYuk+XamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xrauqQ7R; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1752703139; x=1752962339;
	bh=Hl07FxAtdNbkRG17OKg4eb9lsA+Zl2El7hudon5km68=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xrauqQ7RaxnmWmfIcMnpxplVdZsi4RDhTQKE43DF6cA5IX1FJaHuOpdzITH71vHUo
	 dBfPgoYv2JsDR8ossLSmKCqohxeCOxmD9HB/TL0Zi7gondo9cDUvJSyS6Y/86tBYI/
	 KPIy6vikv4PL2QQ8DMc7KRY4TaQdaUyOt9FmSXSViexgyT2jZJfIqeE/n9VivGH5hn
	 qfpt4oKyO7OB4hDm30wsyZUAmGd35PxFC7i1JxDzCmD5pV+2nD1bkNv0YQBf2uJ1mu
	 srf89hZ9mpvckETIDYYYQ5RVmiZq5LEkk66rVJZhqpqdHIA+Yst3V7Wuj0sKJMs/YM
	 +XdXtH4Q0wmDQ==
Date: Wed, 16 Jul 2025 21:58:51 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add initial device tree for Billion Capture+
Message-ID: <clyMtNobNGJ9iLau0esd8U36HYaH3YDSGV3omgjp4uN5OPQ9n5BXWCOcgzuKhAc6_HYyPhrwqEK2M_HDfFTZlTNzvU1Erz9DItHox4IpDV8=@protonmail.com>
In-Reply-To: <cb863e23-79c9-444d-8511-033dd75c02e6@oss.qualcomm.com>
References: <20250629-rimob-initial-devicetree-v4-0-7cf84fa142af@protonmail.com> <cb863e23-79c9-444d-8511-033dd75c02e6@oss.qualcomm.com>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: 8e16e3cf7cd9949ede4bd0190b760dedb97ab5a2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, June 30th, 2025 at 12:37, Konrad Dybcio <konrad.dybcio@oss.qualc=
omm.com> wrote:

>=20
> On 29-Jun-25 08:44, Cristian Cozzolino via B4 Relay wrote:
>=20
> > Billion Capture+ is a handset using the MSM8953 SoC released in 2017
> > and sold by Flipkart.
> >=20
> > Add a device tree with initial support for:
> >=20
> > - GPIO keys
> > - SDHCI (internal and external storage)
> > - USB Device Mode
> > - Regulators
> > - Simple framebuffer
> >=20
> > Signed-off-by: Cristian Cozzolino cristian_ci@protonmail.com
> > ---
> > Changes in v4:
> > - pick up tags (Rob);
> > - Link to v3: https://lore.kernel.org/r/20250626-rimob-initial-devicetr=
ee-v3-0-4017ac9fd93d@protonmail.com
> >=20
> > Changes in v3:
> > - (patch 3/3): pick up tag (Konrad);
> > - Link to v2: https://lore.kernel.org/r/20250624-rimob-initial-devicetr=
ee-v2-0-34f6045ebc30@protonmail.com
>=20
>=20
> Resending just to pick up tags is not necessary, maintainer scripts
> take care of grabbing them
>=20
> Konrad

BTW, I'm not sure about that.

