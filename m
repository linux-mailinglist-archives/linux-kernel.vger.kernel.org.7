Return-Path: <linux-kernel+bounces-872471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC9C11499
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F164FE2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1AB2DCF46;
	Mon, 27 Oct 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="C0xNo0EF"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095904A00;
	Mon, 27 Oct 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594868; cv=none; b=Ph4U0ghei7TUK9K76ey/qrMKpjIhFY+XJP6zK4dIc+3+rP50tz8mhrq1epTI439iI3gYNBZlIBpb6XD+glLYpUm55YvZO1O8l6PRe1IEejwWghPSqsq1rLDXQ+Al+XAWyOFbAOKjYY6WprUKIHMSsZTwsDqE2eC09f2Br/04YuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594868; c=relaxed/simple;
	bh=aANp8IgX/V1m/qB1pC709/vz2urAZp9zw10ocMsy0/I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VMnpxtiH+bohkb0+YWtIfIWCOE8jSEq7q/SRBgaMI3eqc5MQb3k2cHbbpcjfGJ0Kev4itIx3Nlh3E0CKheadbd4PwcAfh7unEbXeDQtzjeYgGzsmooRkJwwd2Z/+2D6uqZnBJZ8FB34hXP6/HY7Q9JUmhII11cdt6HhPfAxMyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=C0xNo0EF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1761594862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJGBCui9T7s9JULkvZa2s1Wi4QfFt1yczMpraKYJAME=;
	b=C0xNo0EFD6UEQdlWe0ijdWjenik7ULzrIRTSe20MEiLs+pXDBzYjh2kgjj67gd8uIBZUXj
	Z0bFrzY7O7rChk/7aI2P3bdi1GmBIVG+36rn78DBrnu3Wp5R0NAJWGLoVEQuJDlUHhAK0k
	3FJu7W02FH2rDhWcwdKYAaSo+PQSW/7kJGYySM3mDexxDPxKhDWfVHXjHYy5zy5xHVlFN0
	EulFcXVM23+s800M7vtbRCg/y6WZMaoVXYJE4JNO/F3/95QrcPLT2BbBmvL8YF+3YOo7fM
	CjxYhkgu7N7BoxtEk7JN+QUpBw2ei2u1FUp1Ncx3Ijprz/3Kjo9xh3DyuhR6WQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 20:54:17 +0100
Message-Id: <DDTD9DGY2LEK.1XF49J28I22SZ@cknow-tech.com>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Dragan Simic" <dsimic@manjaro.org>, "Johan Jonker" <jbx6244@gmail.com>,
 "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH] arm64: dts: rockchip: Harmonize regulator formatting
 for Pine64 rk3566 devices
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Heiko Stuebner" <heiko@sntech.de>, "Diederik de Haas"
 <diederik@cknow-tech.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
References: <20251026153805.107774-1-diederik@cknow-tech.com>
 <DDSFVM1TXN8C.3JNX2M8XX04IF@cknow-tech.com> <5054965.31r3eYUQgx@phil>
In-Reply-To: <5054965.31r3eYUQgx@phil>
X-Migadu-Flow: FLOW_OUT

Hi Heiko (and Dragan and Jonas),

On Mon Oct 27, 2025 at 5:46 PM CET, Heiko Stuebner wrote:
> Am Sonntag, 26. Oktober 2025, 18:44:42 Mitteleurop=C3=A4ische Normalzeit =
schrieb Diederik de Haas:
>> On Sun Oct 26, 2025 at 4:37 PM CET, Diederik de Haas wrote:
>> > The regulator node properties in Pine64 rk3566 devices were formatted
>> > rather inconsistently. To name a few:
>> >
>> > So harmonize the formatting by making all properties sorted
>> > alphabetically/naturally. And harmonize the formatting of the
>> > 'state-mem' nodes so they all have a preceding blank line. While at it=
,
>> > also fix 2 incorrectly indented nodes.
>
> Originally, I always liked regulator-name to be on top, identifying
> the regulator, similar to how compatible works.

That makes a lot of sense to me and I had actually thought about doing
that. But I didn't have a justification for it, while referring to the
DTS style guide is a justification. My annoyance was with the
inconsistency, so consistently putting 'name' on top would be fine too.

> The other issue with moving stuff around is, that it makes it harder
> to follow git history, because git blame then reports the sort-commit.

Then it's not worth it ...

> I guess it is ok for individual files, someone does take care of,
> like Diederik for the Pinetab, but please don't start resorting all the
> existing devicetrees :-) .

... and I'll file it under PEBKAC.

Cheers,
  Diederik

