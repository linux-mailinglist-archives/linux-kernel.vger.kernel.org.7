Return-Path: <linux-kernel+bounces-837581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854DBACAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D47A490D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F268261B67;
	Tue, 30 Sep 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="IYU/Oitn"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED7275AF6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231185; cv=none; b=iaGuY1gs8vgzReH++XK1ls1K7NM7OLPhncAtHDa4KoCVLUmbQM78ddYSw1HCrBM+k0iPdkocHGQcK8lzyh1KB/vi54ww9U5N88/wjZqZ7zdt2z4CO7+mVtU7/Jb9r8I0b2D6a5J6yUyj97vCepxmOr3LTpFHUNChc3A1kVCIt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231185; c=relaxed/simple;
	bh=Deg9POlJwf6oI59BV5wqbX72B/W4GCjUn9Lp50TU+Zo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gri5AqQ1QdGmkSpXKgMdLSRG0EYnpo+t9raqJEdQGn0j2A3IucGxTFl342GEJ1hvK9TSF3yUuRlnorFU8uCR3cLnPO4DJAByXHTXYZnQ/H1IybAn8Q3QEZ5zQAEy6kWw+vt5P/EjmMmjWWE1rLIcjTIRzRxNo6UZMLGPZJSQ6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=IYU/Oitn; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1759231171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ej8+t/v5mQyQZp57f2hlXxPelYNwXcOIgQlGLkUSidA=;
	b=IYU/Oitnx44deO3YQ4pvsUrf3cs72AmxSOTbghOPYUWNQlr+n/xP/l2HkqnuOORt6jwhNa
	WlRxsrBk0tsqQxmx6fCdxGGYZSUj1zv4M4auOOALhYVuuCRtxoN5uAi6NROsn1yEhm6j2q
	9iN0MKsaxUcw94CxbGxM+bu2VJKmRBh4X5Wj5pPiS59OWYrLUn8VRpmKxGpsc1hrfH36dO
	Hp0X25gak0x8LCJ2/hlncT/efUkp24464O7mCQHrcubDrwYM2h7DNL5uJXl846y4UAc05S
	+2t36F46/1/pvWfidpXKcYLta/n13xuNVx2wbZGHfswkiMn29vTyZD1ttOHiBA==
Content-Type: multipart/signed;
 boundary=64945f9999df6ed87a915ea31fa1d9d40eebd6aa48ba7de803956238b27e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 30 Sep 2025 13:19:21 +0200
Message-Id: <DD63EEOKPWNV.3IK12D6CFPTQZ@cknow.org>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <heiko@sntech.de>, <quentin.schulz@cherry.de>, <kever.yang@rock-chips.com>,
 <naoki@radxa.com>, <honyuenkwun@gmail.com>, <inindev@gmail.com>,
 <ivan8215145640@gmail.com>, <neil.armstrong@linaro.org>, <mani@kernel.org>,
 <dsimic@manjaro.org>, <pbrobinson@gmail.com>, <alchark@gmail.com>,
 <jbx6244@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: rockchip: introduce LinkEase EasePi
 R1
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "jjm2473" <jjm2473@gmail.com>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <DD57IZJQ4FQM.3T5791FLUQ8KQ@cknow.org>
 <CAP_9mL6+uoeG7LX8YCcUFjoU13De1CdPFqxNNfoJvOdsOrYo5Q@mail.gmail.com>
In-Reply-To: <CAP_9mL6+uoeG7LX8YCcUFjoU13De1CdPFqxNNfoJvOdsOrYo5Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--64945f9999df6ed87a915ea31fa1d9d40eebd6aa48ba7de803956238b27e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Sep 29, 2025 at 8:09 PM CEST, jjm2473 wrote:
> I have another question. If there are reviewers or co-authors later,
> do I need to add it to the commit message and send it again?
> Or should the reviewer or co-author add the message and
> continue to deliver the patch?

When you get a Reviewed-by tag, you should add that tag too to a new
version. But there's no need to send a new version to just add those
tags, the tooling used by maintainers picks those up themselves.

If you 'just' get review comments, then you'd usually just
improve the patch and you could reference it in a changelog item (to
indicate you addressed it, ttboyk).
If you think a reviewer helped you 'significantly', you could choose to
add an Helped-by tag, but whether you think someone deserves some
credits that way, is up to you(r judgement).

(Co-)authors are usually known upon first submission. If you later find
out that that list was incorrect/incomplete, then you would add
Co-developed-by + Signed-off-by tags on a new version.

HTH,
  Diederik

> Diederik de Haas <didi.debian@cknow.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=B8=80 18:20=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Mon Sep 29, 2025 at 8:57 AM CEST, Liangbin Lian wrote:
>> > LinkEase EasePi R1 [1] is a high-performance mini router.
>> > ...
>> > [1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html
>> >
>> > Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
>> > ---
>> >
>> > Changes in v2:
>> > - Change deprecated "rockchip,system-power-controller" to "system-powe=
r-controller"
>> > - Link to v1: https://lore.kernel.org/r/20250925055906.83375-1-jjm2473=
@gmail.com/
>>
>> You received an Acked-by on patch 1 and 2 in v1 of this patch set.
>> You're supposed to add that to the next/new version(s) or explain why
>> you choose not to do that (bc f.e. there was a major change, but that
>> does not seem applicable to those patches).
>>
>> Cheers,
>>   Diederik
>>
>> > Changes in v3:
>> > - Fix typo ('status =3D "disable"' -> 'status =3D "disabled"') found b=
y kernel test robot https://lore.kernel.org/all/202509261328.Grjhp029-lkp@i=
ntel.com/
>> > - Link to v2: https://lore.kernel.org/r/20250925092037.13582-1-jjm2473=
@gmail.com/
>> >
>> > ---
>> >
>> > Liangbin Lian (3):
>> >   dt-bindings: vendor-prefixes: Document LinkEase
>> >   dt-bindings: arm: rockchip: Add LinkEase EasePi R1
>> >   arm64: dts: rockchip: add LinkEase EasePi R1
>> >
>> >  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>> >  .../boot/dts/rockchip/rk3568-easepi-r1.dts    | 692 +++++++++++++++++=
+
>> >  4 files changed, 700 insertions(+)
>> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts
>> >
>> >
>> > base-commit: d0ca0df179c4b21e2a6c4a4fb637aa8fa14575cb
>>


--64945f9999df6ed87a915ea31fa1d9d40eebd6aa48ba7de803956238b27e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaNu8vAAKCRDXblvOeH7b
bopkAP4rp6hLo5Z1qfCotr2jDcY3qNpOaylNLYkGskxNmYniSwEAuy5jnsnlFxQS
vg8YfzULofUE/R68RoD9NpsXx8PQogU=
=QlYj
-----END PGP SIGNATURE-----

--64945f9999df6ed87a915ea31fa1d9d40eebd6aa48ba7de803956238b27e--

