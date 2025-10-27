Return-Path: <linux-kernel+bounces-872314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D8C0FE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59ADD34E601
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BE02D839A;
	Mon, 27 Oct 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hqARmNiw"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588332D7806;
	Mon, 27 Oct 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589188; cv=none; b=IKLhPaduEOtaFl+4E4wztN8AdSI/WZ/zWMrPWcvcX8YLfQ6tVUJ9Qrt+m8n9hVY51dSxxlJyAH+N6US1+HV3vsNcOlogyUW4lOoOZNhGyOhDJZrQGpgDvXdqyR92WVBTTUcPuhkYN5hubbWDxo6TTkW9xmZgBD0YbqIKK9/TEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589188; c=relaxed/simple;
	bh=11CBatggCCItYnQkkvuhnAvNnafMsLqpFZJIH0JJMsY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=RRB3pg14Z+KJDyQvcrXpPTpFVsz4Ot9C1teB6lj0sOvBPb+Zi+Nv+FG8zvDsoFIOtq+EXmjWMm5/Q9mKhfEMDxud29iTHRwxKxeurkLU26CLZHplMEDCiVq0ZUr4HgAySZ++v/Nqakw4REhlH8cPiC3hzghnxx7W4BYBpwuZnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hqARmNiw; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 9416840D1B;
	Mon, 27 Oct 2025 19:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761589178; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=36Cbfb/vjeQ/MuEIGnK6bEu0FQjCPhD4xvsTx+U2YiI=;
	b=hqARmNiwPpusSwZKYVqiX/9ApyoiqEQ34kuYnR5OGtVLZuJCUemXxsuyCtUKGlv3pq5bo0
	VVnO2r9zlxTW1PAB6V1GeVc62DBZvqYa9UnFy0MwiAcHnEXFnHM05jUkspAdBO7fWYaP+y
	urmSrkx/NUvm5Z6HBpzFwW2itsn+taP8SA28E8tHErXq4vUisZrUWn+M/umpX6vzHe408F
	W3eqbHZWCfFvHz6QDWNTNIvaRvs5EeFKviSmsv0bPFZFLnZpdGgEwTYPRatYYhMsubajif
	YjeqZ7OWCAGIRsKDHG4McORglLhhQK3i5cdkFLGwJyEe6Z0TnQup9qGF9TW7Jw==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <60a1046c-437e-400a-8e2c-391cd471c358@kwiboo.se>
Content-Type: text/plain; charset="utf-8"
References: <20251027154517.136976-1-diederik@cknow-tech.com> <60a1046c-437e-400a-8e2c-391cd471c358@kwiboo.se>
Date: Mon, 27 Oct 2025 19:19:36 +0100
Cc: "Diederik de Haas" <diederik@cknow-tech.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Johan Jonker" <jbx6244@gmail.com>
To: "Jonas Karlman" <jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7dc31259-c172-de0e-554c-2563014b9c2c@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= Harmonize regulator formatting for Pine64 rk3566 
 devices
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Jonas and Heiko,

On Monday, October 27, 2025 19:06 CET, Jonas Karlman <jonas@kwiboo.se> =
wrote:
> On 10/27/2025 4:39 PM, Diederik de Haas wrote:
> > The regulator node properties in Pine64 rk3566 devices were formatt=
ed
> > rather inconsistently. To name a few:
> > - 'name' was sometimes put at the top of the list, while at other t=
imes
> >   it was (mostly) sorted in alphabetical order
>=20
> Personally I prefer to list the regulator-name as the first property,=
 I
> think it makes it visually easier/quicker to identify a regulator wit=
h
> the name prop at top.
>=20
> I typically try to use the following prop ordering for regulators on
> board DTs I submit (and review):
>=20
> - regulator-name as the first prop (to quickly identify the regulator=
)
> - regulator-min-* before regulator-max-* (natural order)
> - regulator-* in alphabetical/natural order
>=20
> Maybe this preference just comes from a long history of always puttin=
g
> id/primary key/unique identifiers at top or beginning of data tables,
> classes, structs etc ;-)

Oh, I actually agree with your and Heiko's preferences when
it comes to the ordering, regardless of that being personal
preference, tribal knowledge or just common sense. :)

However, that's quite conflicting with the current official
rules for writing DT files, which don't recognize such exceptions
at all.  Perhaps we should attempt to incorporate such preferences
into the official rules, because such non-standard ordering does
make DTs more readable?  Following the rules is good, unless it
makes the end results worse, IMHO.


