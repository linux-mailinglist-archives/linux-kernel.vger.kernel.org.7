Return-Path: <linux-kernel+bounces-872168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBDC0F6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D501893ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD63148DB;
	Mon, 27 Oct 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KPaZUyTD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9322127E;
	Mon, 27 Oct 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583640; cv=none; b=OJwCCHfPJkCMmnqMkXqQPauQbeGRndCOsMt3uyMXa3BruaEw9GwzXN94wjJY39BZB1/IeK58cuWogFYjZx1aia8aCyO9kOt6KQtWYeqziEtulwYhx46ejDp25oUy/oQRxiqOod46a/3vBj0RBgy/0oBfi6X+qM+wYp5aango8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583640; c=relaxed/simple;
	bh=R3pIMv7zj1Pt25i2sTrqKqbY8ZWXr5LXp9U2DuuDncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlP+WOqt2Hvm62fKrRqb+GOeIV60JNp+p7tEUUpZQvqGJEbNy05QSKu0O+WSgEtKqJCCxs+95csATufmgEGcTLBx20S80u1657zBVG5UUr25UQQZQQtAD3gPOw62QGldXk7juApl88gxKrPXcCNeMRIG0eq/q7v2fv07ruisagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KPaZUyTD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=6VropRRCJmyIDE6mt2lFPIyoGvs5jUPiwexBau4cLyg=; b=KPaZUyTDWThc0N7lTe/ONzVw0U
	ESn0Fa6QH5v87GZZ6plLOs7iA7tv/CUYy9djvkl2fnDloFoe5XRpSU0oqtSxWZBW3XR+URwVte/2W
	R+4WTo3iZ5QT7ZsKeBkIdwb5ie0EX5kP4jhA/BenkUcwqSW4ck1YTKiP84kcIOraRifLEta7N3662
	QuNhAZVmwpnU9K1Fx7IP0pQ2d+3QPicBeyuOxKh8yAH/UzJhaFKJxtIr4TafFrRR5ZklGk/kmC7N6
	O7kf9O2sGUHubyFX814JIxD4jFmdOjQPXJoIzAOZHSO2Gzri8pUkiRzSKE0i08NtNlxmPEAIZ2IHS
	BMfhM9tA==;
Received: from i53875be3.versanet.de ([83.135.91.227] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vDQMx-0002Ep-6h; Mon, 27 Oct 2025 17:46:55 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <diederik@cknow-tech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Diederik de Haas <diederik@cknow-tech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Harmonize regulator formatting for Pine64
 rk3566 devices
Date: Mon, 27 Oct 2025 17:46:54 +0100
Message-ID: <5054965.31r3eYUQgx@phil>
In-Reply-To: <DDSFVM1TXN8C.3JNX2M8XX04IF@cknow-tech.com>
References:
 <20251026153805.107774-1-diederik@cknow-tech.com>
 <DDSFVM1TXN8C.3JNX2M8XX04IF@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 26. Oktober 2025, 18:44:42 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Diederik de Haas:
> On Sun Oct 26, 2025 at 4:37 PM CET, Diederik de Haas wrote:
> > The regulator node properties in Pine64 rk3566 devices were formatted
> > rather inconsistently. To name a few:
> > - 'name' was sometimes put at the top of the list, while at other times
> >   it was (mostly) sorted in alphabetical order
> > - 'always-on' and 'boot-on' were sometimes at the top of the list,
> >   sometimes not
> > - 'state-mem' nodes sometimes had a preceding blank line, as they
> >   should, but sometimes not
> > - other properties seem to have been added to the end of the list, not
> >   in their alphabetical/natural order
> >
> > So harmonize the formatting by making all properties sorted
> > alphabetically/naturally. And harmonize the formatting of the
> > 'state-mem' nodes so they all have a preceding blank line. While at it,
> > also fix 2 incorrectly indented nodes.
> >
> > No functional changes.
>=20
> I just found some additional ones.
> If these changes are considered OK (in principle), then I'll send a v2
> at some point.

Originally, I always liked regulator-name to be on top, identifying
the regulator, similar to how compatible works.

But I do have to concede that this is just another "special-case" of
style-preference, that makes it harder to explain things to people
and in the end we should just follow the documented sorting, without
tribal knowledge :-) .


The other issue with moving stuff around is, that it makes it harder
to follow git history, because git blame then reports the sort-commit.


I guess it is ok for individual files, someone does take care of,
like Diederik for the Pinetab, but please don't start resorting all the
existing devicetrees :-) .


Heiko



