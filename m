Return-Path: <linux-kernel+bounces-769554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02844B27045
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4C9685D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E45E26AABE;
	Thu, 14 Aug 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wbis/2q2"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B831986E;
	Thu, 14 Aug 2025 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204042; cv=none; b=YBZi6CxjqNZL8Ei03DFpWH/1TFYJ3LQm/l10KTOQU9L3C/yXDOrj1r0s2WqAScUigGMf3d2Q52XI7T/6N5cVpkXmI+BJTkCavNH7TStURQ652bkCLyEu3AJ1NkAzeGA4ClU0MPgD5jwtyE9sk2OYYegO/9P5It+wVSVj9lswW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204042; c=relaxed/simple;
	bh=Ap+mKN8wlio27p+u9jX1kutG1qQyWMj8naLvTbI66Pc=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:From:To:CC:
	 References:In-Reply-To; b=ZCxdgA2lkQkXknhC1SgKn4NFACrx27mIO61tgnnNlKO8IuYvg4xE773QyfcY4vI2gC0wtjBvlhKkgT3o4Yr1x76cPrPgs7lmGVjkTFXSpN6bJ1/QAZzCMYup5kmHMNfirdKG9qlFsDUzQUlS9JDn7fJ1JWlLpaGFPh0KXWWbNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wbis/2q2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EKeQu62011538;
	Thu, 14 Aug 2025 15:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755204026;
	bh=A5j5Nk1nvJBPLYuxHFSA0kqPXhXQZcTtQKp/iX7Jb1s=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=Wbis/2q2+SDxJ+NvmaShsH3FG869f0FYFjq5GwTovn6wO2qIpXvhrELlePmQG9qIw
	 rJ29O/kfgB6AP1TLgwF4L9rmBJ7LAuQTY/m4aJBXWiYoHAR2iCt8McumVThbPIzp6B
	 FcSv98Y3d0zmBRDEDgZaZPQTtlSxsMVlFy3bP8pQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EKeQRN1400343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 15:40:26 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 15:40:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 15:40:26 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EKeQ064172623;
	Thu, 14 Aug 2025 15:40:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Aug 2025 15:40:26 -0500
Message-ID: <DC2FWE35CXPV.YM6MK820R2PV@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62p-j722s: enable the bxs-4-64
From: Randolph Sapp <rs@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>,
        Michael Walle
	<mwalle@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-2-rs@ti.com>
 <20250813151721.nc5fr3qmro5grlda@steam> <DC1HS8D8KLIF.2MN7D9EXGQQ45@ti.com>
 <20250813184229.dhgpqvi3b6aat46g@managing>
In-Reply-To: <20250813184229.dhgpqvi3b6aat46g@managing>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed Aug 13, 2025 at 1:42 PM CDT, Nishanth Menon wrote:
> On 12:56-20250813, Randolph Sapp wrote:
> [...]
>
>> >> +		reg =3D <0x00 0x0fd80000 0x00 0x80000>;
>> >> +		clocks =3D <&k3_clks 237 1>;
>> >> +		clock-names =3D "core";
>> >> +		assigned-clocks =3D <&k3_clks 237 1>;
>> >> +		assigned-clock-rates =3D <800000000>;
>
> btw, as per https://www.ti.com/lit/ds/symlink/tda4aen-q1.pdf (page 86)
> 720MHz when vdd_core is 0.75v (default)
> and 800MHz when vdd_core is 0.85v
>
> 0.85v is set in the board dts and higher OPPs are enabled depending on
> board capability.
>
> You might want to check the assigned-clock-rates based on data sheet,
> default should'nt need a assigned-clock-rate.

Are you suggesting that we set assigned-clock-rates in the board dts instea=
d, or
do you just want to do away with assigned-clock-rates in general and eat th=
e
perf difference?

