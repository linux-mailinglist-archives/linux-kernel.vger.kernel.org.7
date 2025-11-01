Return-Path: <linux-kernel+bounces-881444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F7C28381
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0131E3BE12E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CAB279DDB;
	Sat,  1 Nov 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FVUHwmBS"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450141DB34C;
	Sat,  1 Nov 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016358; cv=none; b=aZkTZrEFdGwfkfhdU382tlzf/fPKIf4kpw9IitsUFYSGRDCDlsWF75PYU/o+WrGAFDlSqdRouiEuusRdusoE+DV4xfsQRw+nHG80o1HTIfYonLD5jUHI0EAcLXP+OGw6dXOC6qY4lw3UhES5ewVHfK5g1ZEuUvZCKsUf2FisnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016358; c=relaxed/simple;
	bh=oG6X+pskPG/jMBmD1RZ2DQn2CkantGbNLQEbpKfETBA=;
	h=From:Content-Type:Date:Cc:To:MIME-Version:Message-ID:Subject; b=HjR3uVQIO35XKZVe5dnO6C7xKfMGujzX+7A9Q8SHuaJXWyAwljjcTYjL4cfMZiOeN1i70VOp2MgShc6Cuoh3/6R06DhU4+h04ClWhO2AWNSXA59nMOQ6iaRbC7IAE6TcowBJLokK8R+EW89nNHsWMcWwMimaaKNUVwVvGpJJqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FVUHwmBS; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id CCC2240E64;
	Sat,  1 Nov 2025 17:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1762016353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=sMl6CrU8n9CPvD/7RHfQqN/cNpPavM10Xf1mdRiKWUw=;
	b=FVUHwmBSEL5aIJ1c0fb9aFCKPuK5Q4UuwIsQwmfnSdy+fV2DoLZD3oOJZmi2IPmcIknZbY
	kkUl+o77eAkhizFN4RQYHs6VMvMVLSO1sWarxs3ru82X+lsvrlL0HLGQG14g+MdXZ+2GcE
	ZUq+Bvhq9zD99aTrCpND48sG4M6JuHYYWqainbbKXAlRV7sncpYMv4LwiQFBFvf0CLlv0q
	mr8wDYB6y0NfNxUVpPRCIlxyvZJTwn2anq8yvRGdZ0OpSlLUpObtgok6uYON/Nx4VELUw3
	ynSOhbmPebWOx/fFS/MV88pgMrfEzN68Ym+BWXqkc/TnE7Yk2AeZwmICdOCd3w==
From: "Dragan Simic" <dsimic@manjaro.org>
Content-Type: text/plain; charset="utf-8"
Date: Sat, 01 Nov 2025 17:59:10 +0100
Cc: "Heiko Stuebner" <heiko@sntech.de>, "Alexey Charkov" <alchark@gmail.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, robh@kernel.org
To: "Hugh Cole-Baker" <sigmaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0ac61ea1-9e22-7101-646d-694e350ec1b4@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= pwm-fan overlay for NanoPC-T6
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Hugh,

On Saturday, November 01, 2025 14:14 CET, Hugh Cole-Baker <sigmaris@gma=
il.com> wrote:
> On 01/11/2025 11:44, Heiko Stuebner wrote:
> > Personally, I'm more on the less complication side.
> >=20
> > I.e. if there is an actual fan-connector on the board we should des=
cribe
> > it as such.
> >=20
> > Overlays I see for things where you attach hats to generic pin head=
ers
> > to create specific functionality on top of a generic interface.
> >=20
> > But if the board itself has an actual fan header, it should be desc=
ribed
> > as such. Because that then =5Fis=5F the standard use of that.
>=20
> The board does have a fan connector, just no fan by default. But anyw=
ay,
> since it sounds like the preferred approach I'll send a v2 which puts=
 the
> fan into the base board .dts.
>=20
> Dragan, you mentioned there's no need for more than 2 trip points - i=
f
> I remove the trip points between "SoC is warm, start fan at slow spee=
d"
> and "SoC is v. hot, run fan at full speed" is the OS/kernel expected =
to
> interpolate between those 2 trip points (if you have a link to docs o=
r
> code about this it'd be interesting, I couldn't find anything in the
> dt-bindings)?

True, that isn't described in the bindings, because it basically
doesn't belong there.  Thus, the most specific description of the
associated cooling stuff, as provided by the bindings, is the
following excerpt from Documentation/devicetree/bindings/thermal/
thermal-zones.yaml:

  209 cooling-device:
  210   $ref: /schemas/types.yaml#/definitions/phandle-array
  211   description:
  212     A list of cooling device phandles along with the minimum
  213     and maximum cooling state specifiers for each cooling
  214     device. Using the THERMAL=5FNO=5FLIMIT (-1UL) constant in the
  215     cooling-device phandle limit specifier lets the framework
  216     use the minimum and maximum cooling state for that cooling
  217     device automatically.

That's where the cooling hardware description ends, so that's also
where the associated binding ends.  Everything else belongs to the
thermal governors, because they actually decide on how to best use
the available cooling features.

For example, the chain of events may look like this:

  (1) The rockchip=5Fthermal=5Falarm=5Firq=5Fthread() function, defined=
 in
      drivers/thermal/rockchip=5Fthermal.c, gets triggered by TSADC
      within the parameters of DT-defined "active" trip types

  (2) It calls the thermal=5Fzone=5Fdevice=5Fupdate() function defined
      in drivers/thermal/thermal=5Fcore.c

  (3) This ends up calling the step=5Fwise=5Fmanage() function that's
      defined in drivers/thermal/gov=5Fstep=5Fwise.c, which handles
      the previously triggered "active" trip

  (4) This calls the drivers/thermal/gov=5Fstep=5Fwise.c's locally
      defined thermal=5Fzone=5Ftrip=5Fupdate() and get=5Ftarget=5Fstate=
()
      functions, which end up ramping the fan speed up and down
      as needed, while respecting the upper and lower limits
      defined through the "cooling-device" DT map properties,
      which correspond to the "cooling-levels" defined in the
      DT fan property

Here's also an excerpt from drivers/thermal/gov=5Fstep=5Fwise.c, which
confirms all this and explains it a bit further:

  113  /*
  114   * Throttling Logic: Use the trend of the thermal zone to thrott=
le.
  115   * If the thermal zone is 'heating up', throttle all of the cool=
ing
  116   * devices associated with each trip point by one step. If the z=
one
  117   * is 'cooling down', it brings back the performance of the devi=
ces
  118   * by one step.
  119   */

With all that in mind, the fan will ramp its speed up and down
nicely, according to the current temperature, with no need for
having multiple manually defined steps.

The intended benefit of having the two usual, distinct "active"
thermal trips and cooling maps is to lower the fan-induced noise
a bit while not affecting the cooling much.  This is all visible
in rk3399-rockpro64.dtsi, for example.


