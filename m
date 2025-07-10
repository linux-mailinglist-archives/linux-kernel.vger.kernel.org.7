Return-Path: <linux-kernel+bounces-725329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F050AFFDA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EAA7BFAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875B220698;
	Thu, 10 Jul 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="xbG6Ulch"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A691C861B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138629; cv=none; b=iAWKBNftWH+xVQpLAXdvxy7P6sJFxMa0vWCOMXojQLQXRHTvNJ4zUWJw4qzdmpoAYmV57eMfg0f5V7eJuB+W4lqjgckCdfbgzKasl0AQ8CSNqTlbNkOFSmYD0+Ay9634qGnLNCElN5o7yt3WRJMFjzl5bhjigqjTlkF1myjB6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138629; c=relaxed/simple;
	bh=0ejMRvdzRdfr1ozaxpnb0EjZgAiaQeIeNCMr4CRiIfw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QhH+bfFsmtp7b3HUJPQ71raEE1qKQy0nLzw+J8G7q+gSaXIujt94bpzPgkiz35GivmVquMOkhy7Z9NcB2357n76u4WqwqNd9l4RUu+fTiM06Rr0sMKIR0XoJvny5odzdnrk/u2a6iZPtUK8XnWtnfTc4yAM5hi4mb6jCF2ronyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=xbG6Ulch; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752138623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGaNMk1Nb5uDkougr0JHI6djA5s2FrcturNzxHjLd2w=;
	b=xbG6UlchkL4vuwnA6X5fvzcs/+BGWE9E2QDy9ueXRRbvDTV32lB8bhIao/UlPUDFjti9hh
	77VkbFM4ahaWF57B4aD06nfBnwtDcZCO387O6HloDr4JjwuYagTKzyKerNPqKJcxJKdK6r
	86IZmdS6TTrwA+3TUHGMx+gq+wQVVnGhnjTAtvp2mw00DfePiJ8tdd46f83cMGi2sTFOK6
	sWZaOw0vRVch8vn9SHHNZ8YEE9uG0UtMc4UwFWbqBJso9hJoHrGXy0aaM1MlsMLzfTwctF
	ZJO2qu7FB+jTAPpQ3i6dsXl2E2I6+bVmgyHVsOSFwMqSeMyFivDqKlP14VqSBg==
Content-Type: multipart/signed;
 boundary=5487c075f993717a80e96c46976a9b05c2e5ee5ea6d3bac3fbff171d5762;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 10 Jul 2025 11:10:14 +0200
Message-Id: <DB89AVFYVBG3.11WV856SX4PDP@cknow.org>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add reset button to NanoPi R5S
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
References: <20250709105715.119771-1-didi.debian@cknow.org>
 <ea6f2815-5882-4fab-8372-1c252a87e09a@kernel.org>
 <DB7OENOUTHGM.2JPD73SZQ9P0P@cknow.org> <11937120.2WqB4rESCP@diego>
In-Reply-To: <11937120.2WqB4rESCP@diego>
X-Migadu-Flow: FLOW_OUT

--5487c075f993717a80e96c46976a9b05c2e5ee5ea6d3bac3fbff171d5762
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jul 9, 2025 at 9:49 PM CEST, Heiko St=C3=BCbner wrote:
> Am Mittwoch, 9. Juli 2025, 18:47:47 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Diederik de Haas:
>> On Wed Jul 9, 2025 at 4:18 PM CEST, Krzysztof Kozlowski wrote:
>> > On 09/07/2025 13:17, Diederik de Haas wrote:
>> >>>>  		compatible =3D "gpio-leds";
>> >>>>  		pinctrl-names =3D "default";
>> >>>> @@ -127,6 +140,12 @@ eth_phy0_reset_pin: eth-phy0-reset-pin {
>> >>>>  		};
>> >>>>  	};
>> >>>> =20
>> >>>> +	gpio-keys {
>> >>>> +		gpio4_a0_k1: gpio4-a0-k1 {
>> >>>
>> >>> Are you sure that this passes checks?
>> >>=20
>> >> If it's about the 'weird' name/label, it is what is used in the
>> >> schematic document I have and I asked Heiko (on IRC) if using
>> >> ``reset_button_pin: gpio4-a0-k1`` would not be better. That would mak=
e
>> >> it more descriptive while also having the schematic traceability in i=
t.
>> >> The answer was no, use the form I used in this patch.
>> >>=20
>> >> Am I missing checks I should've done as well?
>> > I meant that usually nodes, including pin controller mux/config nodes,
>> > have specific prefixes or suffixes. Other cases have here as well. You=
r
>> > does not.
>>=20
>> I agree I've done it inconsistent with how I did the other pinctrl
>> nodes, so I should've added the '-pin' suffix. For consistency.
>
> Also fine by me :-) .
>
>
>> I've been wondering whether there are rules for naming [1], both for the
>> grouping and the node names. Some DTS files use a '-pin' suffix, others
>> don't. And it's not uncommon to see both variants in the same dts file.
>>=20
>> One of the examples I looked at was ``rk3568-qnap-ts433.dts``. While it
>> uses 'keys' as grouping node, I went with 'gpio-keys' as that was used
>> more often (in other files). While the gmac0/keys/leds subnodes under
>> ``&pinctrl`` use the '-pin' suffix, the pmic/usb subnodes do not.
>> (and I just noticed 'hdd4_led-pin' should be 'hdd4-led-pin')
>
> The TS433 suffers from that "no schematics" thing I mentioned in the
> other mail, so the device-specific pins are named after their functon.
> As I was assuming the TS433 will follow the reference design, those
> pins are named after how other boards do it

That sounds (very) sensible for the 'base' name.
What I'm trying to figure out is whether there are some rules which
determine whether the should be a '-pin' suffix or not.
Because some have and some don't.

>> I'd love to know/learn if there are actual rules for these things, but
>> I don't know them.
>
> From looking at pinctrl bindings, it seems patterns are set per controlle=
r
> with no global rules. Which makes sense in a way, because they do
> represent pin(-groups) differently each.

I think I don't understand this.
I know there are pattternProperties which describe the format for
several node names, but I haven't found a rule for '-pin' suffix.
The "rockchip,pins" property is defined in pinctrl/rockchip,pinctrl.yaml
and I don't see it there. And in the example in that binding file, there
is one node with a "rockchip,pins" property ... and it does not have a
'-pin' suffix.

I'll sent a v2 with the '-pin' suffix even though I still don't know
why. It looks more consistent though.

Cheers,
  Diederik

--5487c075f993717a80e96c46976a9b05c2e5ee5ea6d3bac3fbff171d5762
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaG+DeAAKCRDXblvOeH7b
bm8wAQDC/7RwQKw8W5acfgmJOlF9Yd/jpPxII9M5WLLzV2zSEQEA+ZyoUW3i+QT0
XYt5dtbVv6ODUpEp8G03nlsPitbW+QA=
=ryk6
-----END PGP SIGNATURE-----

--5487c075f993717a80e96c46976a9b05c2e5ee5ea6d3bac3fbff171d5762--

