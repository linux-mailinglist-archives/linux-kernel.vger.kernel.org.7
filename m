Return-Path: <linux-kernel+bounces-841641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC857BB7E16
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D128F4EE9BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609822DC771;
	Fri,  3 Oct 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ohtHXZcr"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2E2D0619
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515886; cv=none; b=g9eOpma0Dl+x5kWOEOM0QqqYLFcs9cysQgIh5CMmW4/GCYyE2Ie6VWVVpYZeZYbROpau+C0oTegEIxMqc6kjcT5dISDrdvwjihELv1IhajjDLHNy4ECX9VVMN7AkvSOH5xiCw5yu6xARwnC+lHOwO4hPpDfEwarAXhlSssM2qbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515886; c=relaxed/simple;
	bh=HX+kpTW6oJpPu802Qe3o1aTuPUw5cnNk0EyKVYCAoO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jwq45oITSCnMya4JAZymAzA2SsncsA6OhguMb6vRThcG75YvPT+TYQlXgHbdzm8MEuTt3og9wBnmmDoXdG4ZYOviU7AERwKzBWVeLO7mQXQOcHUgXok/GNjNmzYuJXgHLcyvkvIuv6CiZdJXNpPMMhbNJ9PuDR8RE09PP+Jwe28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ohtHXZcr; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1759515872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pZwuT/JLNXJewD2NH2HpDVLKQgrPsuLUQV2Ho86TzI=;
	b=ohtHXZcrdHCQRHZiN02OlCl0z3COcDpmx2RJFlgqqfGnMnnTAkQhBddhayj9xpSE/NUgDf
	ewxf87lAqgOPpJYLxMBTg+pjpvOs0qdpnsoW3LHa1OfUS5zTyvhW6c+CABkWzuEF9teVW6
	3Qo+QcWKihEQrFEyPjWQ+1hEazUl875JRSBgG4QRABl2TxZsn47zqrQQtlAFWpKQlx/YNt
	dL+vEZxLF/ZRL8d70ZXnzMkm0RDpt+DOHafIFIZ0hQXGOt+x2nd34wzYF3oP2Fq48OX+mf
	5qxnWUG2+ba36i5woRHH7yfEsQGEBPLCm4Au43JMIs1SnRIPA5lnkKnyEMC3bg==
Content-Type: multipart/signed;
 boundary=350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 03 Oct 2025 20:24:22 +0200
Message-Id: <DD8WBG9LXET7.189BAJGVYEOIR@cknow.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Heiko Stuebner" <heiko@sntech.de>,
 "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Jon Hunter" <jonathanh@nvidia.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in
 fw_devlink_dev_sync_state()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Diederik de Haas" <didi.debian@cknow.org>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Saravana Kannan" <saravanak@google.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-pm@vger.kernel.org>
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
 <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
In-Reply-To: <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
X-Migadu-Flow: FLOW_OUT

--350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Sep 25, 2025 at 3:59 PM CEST, Diederik de Haas wrote:
> On Fri Sep 12, 2025 at 8:32 PM CEST, Saravana Kannan wrote:
>> Please don't just disable fw_devlink using fw_devlink=3Doff. We want to
>> fix any issues you are hitting with it. I might even delete this "off"
>> option sometime. It was meant as an early debug option.
>
> I want to test all my (Rockchip) devices to see if they 'need'
> that parameter to 'silence' the warning. I have a (vague) recollection
> that some don't need it (for that).

Not trying to revisit the discussion, only to report that data.
All tests were done with the 6.17 kernel and no 'fw_devlink=3Doff'.

Device				sync_state warning
Rock64 (rk3328)			yes
RockPro64 (rk3399)		no
Quartz64 Model A (rk3566)	no
Quartz64 Model B (rk3566)	yes
PineTab2 (rk3566)		yes
NanoPi R5S (rk3568)		yes
Rock 5B (rk3588)		yes

Cheers,
  Diederik

--350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaOAU2QAKCRDXblvOeH7b
bi+jAQClFJxngtaff7fByP/1aLRZByopcFs8SEZdCfX0NZgpzwEAjcnsnhLYGu4J
P6cjkclQbHy9mZ8x+FljMgEw+7fw2A4=
=1PVj
-----END PGP SIGNATURE-----

--350687d2fbade414a961dffd460dfe7fc1681636fdd689bcf31c7eb97d01--

