Return-Path: <linux-kernel+bounces-804203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E61B46CC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382861896C60
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A7288CBF;
	Sat,  6 Sep 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uAs8j8qB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC491C8630;
	Sat,  6 Sep 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161305; cv=none; b=BfnqdzAF7PdRc7X90zVwDTS1p+BmkKbYCDpIlLr3rUT/hROL8h+vbaB4ViUPlQKif97SECcToMnUpjIRJS+vPsu2ZEmdlpUU6WPwTBXbZktOZT3o3NOmSHPTq7++iV68H1kl/OIBYt9p6fDDV6K8rXoGYm94HWA2Y/NTbs+UppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161305; c=relaxed/simple;
	bh=Du2EiDVhjks2InfB/ibkVU9ES6HD4SRzAVCwbyrBSmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlnSHR3UHyyO4WbjDDS59H6n+yIJISAVM08lDK70WSgwrznoZZTiwjudqJ0aFeobX95Nk4PGndHk6eSQCvIUi3KTHWVa4Z12q9rT/jkdqyXlabmvrXZnhqsIYlqrwUIwV4SZ1rYjt5t3e+s5HuFt88A9f+zUWaDZZ/abBvUlyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uAs8j8qB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=jJISYZ9NEMqNgtPEeFx7VvEBRUrxQUx5HJSJjwIbpD8=; b=uAs8j8qBmeMmHKpU2fur/lfZTw
	5dLMqNxoV0/nLhdEyknYecWk6JBTU11HWm2PDAG22lfqo1jd6m7/frS5cK1tGutag+KLre0/8LsQL
	k91poOxdUHuXKKTH7DyMe/nh13MAv7fcq+g5FYg0z3Mn5vbRu+wJM3nqyNEQz7aezJJ3R09Q6cYem
	4a3Yu1v7gWGSnEgp1Y+SDnJZ5EVlwq9BHon7frWW46mnuZTwO5GWtEyq1TbXRzFVi1qJffdNNACx7
	CcWCnuy+OezLU4jzfIKUAst+x9eL19STiuIdY+QETs6AqtumRTgquV/exgUIY+9LKBoANidK67Px9
	rZINaC6w==;
Received: from i53875a53.versanet.de ([83.135.90.83] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uurv1-0005FU-Ag; Sat, 06 Sep 2025 14:21:23 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>,
 Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Make RK3588 GPU OPP table naming uniform
Date: Sat, 06 Sep 2025 14:21:21 +0200
Message-ID: <3169011.CbtlEUcBR6@diego>
In-Reply-To: <47cf50f2f497108a923815c12b1f8c9b@manjaro.org>
References:
 <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
 <DCLOTR9Y380M.22GZYL11XXZM2@cknow.org>
 <47cf50f2f497108a923815c12b1f8c9b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 6. September 2025, 14:10:22 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Dragan Simic:
> Hello Diederik,
>=20
> On 2025-09-06 13:40, Diederik de Haas wrote:
> > On Sat Sep 6, 2025 at 12:01 PM CEST, Dragan Simic wrote:
> >> Unify the naming of the existing GPU OPP table nodes found in the=20
> >> RK3588
> >> and RK3588J SoC dtsi files with the other SoC's GPU OPP nodes,=20
> >> following
> >> the more "modern" node naming scheme.
> >=20
> > Like we discussed in private (without an agreement), I think it would=20
> > be
> > beneficial if the (gpu) opp naming would be made consistent across SoC
> > series as right now there are several different naming schemes applied.
> > They're all valid, but inconsistent. And if consistency is improved,
> > which I like, then let's go 'all the way'?
>=20
> As we discussed it already in private, I fully agree about performing
> the "opp-table-X =3D> opp-table-{clusterX,gpu}" naming cleanup=20
> consistently
> for all Rockchip SoCs, but I'm afraid it would be seen as an unnecessary
> "code churn" at this point, especially because my upcoming Rockchip SoC
> binning patch series is a good candidate for such a cleanup.
>=20
> On top of that, I'd be a bit weary about performing at least some of the
> testing associated with such a platform-wide cleanup, despite actually
> performing no functional changes and being a safe change.  On the other
> hand, "bundling" such a cleanup with the Rockchip SoC binning patches
> would get us detailed testing for free, so to speak.
>=20
> Of course, if the maintainers see this as a good opportunity to perform
> a platform-wide cleanup at this point, instead of seeing it as a "code
> churn", I'll still be happy to extend this small patch into a platform-
> wide naming cleanup of the "opp-table-X" nodes.  On the other hand, if
> this patch remains as-is, it may hit a good balance between resolving
> the currently present naming ambiguity and the amount of introduced
> changes.

Personally I'm always for the "we strive to get there eventually" thing.
If there is an established goal to reach, steps can be incremental :-) .

And also short and scope-limited patches are easier to review anyway.

Heiko




