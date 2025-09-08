Return-Path: <linux-kernel+bounces-806558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE65B49877
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C114A203538
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA6E31B81F;
	Mon,  8 Sep 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqi2SowV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CC238C03;
	Mon,  8 Sep 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356771; cv=none; b=Reicoe3+c2Ayo+P9GE5Zj4YIqU0uO+yTooWabG/OhGDoJYrHWYN1HU1hftc0UDV7ZN3kVgrSvdeJtfOKvyFTCEBwoThDHeGHxn/dreqkfS6hFRwDYwIjvAZmgipioGJfog1UdeVdTC0pcU9u4zGrjsjW4v35V/i6kaMLksBfjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356771; c=relaxed/simple;
	bh=hQRVCMxFIlMjgfrjQrjZjKXH5Qw6jPXzLcXthqrIXeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9FqPiGplCAATQXIa3YR1C5fmIR3cDSWenw0KM5Ban/tDaDRQ6milGpXV3CyHlEY4x09GuMe1MRFJ4wiWycwkEZh3SJ47KSaxDMEP+n+Tzyx9OoBZc08Ht+52apcp9VQxoKjQrX+YsHNxF0L8XL+8tWoZcHc8IcgBVfYs0lAztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqi2SowV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B59C4CEF1;
	Mon,  8 Sep 2025 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757356771;
	bh=hQRVCMxFIlMjgfrjQrjZjKXH5Qw6jPXzLcXthqrIXeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xqi2SowVYENOd6lGzG66LHoPHU9vjioz8qj1zAyw3rNwNmDryenubp0UMdBt/N+eI
	 ZDKrhkqwQhCy/4WMXrAUy69IkI11j/UopIbgm9sLEFs7S407glXYbuzB0ohYuzJtQH
	 isk2nSxVFLObSCKKFWiwnduu+xb2JYS/rlzI1KYXo6WxBmkUNSPqNjZPoDJPtVmnuZ
	 w27WIQv6hxPlun0gZ0l3Ru4RGKVBSZVz2ODs2tiGtSdqhCXPmmG5vaXjquS5p/B+Bb
	 J4jzZ66+uoXUJb3o8s5R+XXtmJF0Ia9vt2Y6Mhe14mYaWlDzFCEmzCcV6PGLNlt1KC
	 sctJUH4ClXaYw==
Date: Mon, 8 Sep 2025 19:39:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250908-turbulent-unhappy-378144402000@spud>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
 <20250905-pamperer-segment-ab89f0e9cdf8@spud>
 <20250908093709.owcha6ypm5lqqdwz@skbuf>
 <2b1f112e-d533-46ae-a9a0-e5874c35c1fc@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l1qAzSyQB+CvJSLr"
Content-Disposition: inline
In-Reply-To: <2b1f112e-d533-46ae-a9a0-e5874c35c1fc@solid-run.com>


--l1qAzSyQB+CvJSLr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 02:02:35PM +0000, Josua Mayer wrote:
>=20
> Am 08.09.25 um 11:37 schrieb Vladimir Oltean:
> > On Fri, Sep 05, 2025 at 08:02:59PM +0100, Conor Dooley wrote:
> >> On Fri, Sep 05, 2025 at 06:41:50PM +0300, Vladimir Oltean wrote:
> >>> On Fri, Sep 05, 2025 at 10:29:33AM +0200, Krzysztof Kozlowski wrote:
> >>>>>  properties:
> >>>>>    compatible:
> >>>>> -    enum:
> >>>>> -      - fsl,lynx-28g
> >>>>> +    oneOf:
> >>>>> +      - items:
> >>>>> +          - const: fsl,lynx-28g
> >>>> Don't change that part. Previous enum was correct. You want oneOf and
> >>>> enum.
> >>> Combining the feedback from Conor and Josua, I should only be permitt=
ing
> >>> the use of "fsl,lynx-28g" as a fallback to "fsl,lx216{0,2}a-serdes{1,=
2}",
> >>> or standalone. The description below achieves just that. Does it look=
 ok
> >>> to you?
> >>>
> >>> properties:
> >>>   compatible:
> >>>     oneOf:
> >>>       - enum:
> >>>           - fsl,lx2160a-serdes1
> >>>           - fsl,lx2160a-serdes2
> >>>           - fsl,lx2160a-serdes3
> >>>           - fsl,lx2162a-serdes1
> >>>           - fsl,lx2162a-serdes2
> >>>       - const: fsl,lynx-28g
> >>>         deprecated: true
> >>>       - items:
> >>>           - const: fsl,lx2160a-serdes1
> >>>           - const: fsl,lynx-28g
> >>>         deprecated: true
> >>>       - items:
> >>>           - const: fsl,lx2160a-serdes2
> >>>           - const: fsl,lynx-28g
> >>>         deprecated: true
> >>>       - items:
> >>>           - const: fsl,lx2162a-serdes1
> >>>           - const: fsl,lynx-28g
> >>>         deprecated: true
> >>>       - items:
> >>>           - const: fsl,lx2162a-serdes2
> >>>           - const: fsl,lynx-28g
> >>>         deprecated: true
> >> This doesn't really make sense, none of these are currently in use
> >> right? Everything is just using fsl,lynx-28g right?
> >> Adding new stuff and immediately marking it deprecated is a
> >> contradiction, just don't add it at all if you don't want people using
> >> it. Any users of it would be something you're going to retrofit in now,
> >> so you may as well just retrofit to use what you want people to use
> >> going forward, which has no fallbacks.
> > You're right that it doesn't make sense to deprecate a newly introduced
> > compatible string pair - my mistake for misunderstanding "deprecated".
> >
> >> I didn't read the back and forth with Josua (sorry!) but is the fallba=
ck
> >> even valid? Do those devices have a common minimum set of features that
> >> they share?
> > I'll try to make an argument based on the facts presented below.
> >
> > The current Linux driver, which recognizes only "fsl,lynx-28g", supports
> > only 1GbE and 10GbE. There are other SerDes protocols supported by the
> > SerDes, but they are irrelevant for the purpose of discussing
> > compatibility. Also, LX2160A SerDes #3 is also irrelevant, because it is
> > not currently described in the device tree.
> >
> > 1GbE compatibility table
> >
> > SerDes              Lane 0  Lane 1  Lane 2  Lane 3  Lane 4  Lane 5  Lan=
e 6  Lane 7   Comments
> > LX2160A SerDes #1   y       y       y       y       y       y       y  =
     y
> > LX2160A SerDes #2   y       y       y       y       y       y       y  =
     y
> > LX2162A SerDes #1   n/a     n/a     n/a     n/a     y       y       y  =
     y        LX2162A currently uses lx2160a.dtsi
> > LX2162A SerDes #2   y       y       y       y       y       y       y  =
     y        LX2162A currently uses lx2160a.dtsi
> >
> > 10GbE compatibility table
> >
> > SerDes              Lane 0  Lane 1  Lane 2  Lane 3  Lane 4  Lane 5  Lan=
e 6  Lane 7   Comments
> > LX2160A SerDes #1   y       y       y       y       y       y       y  =
     y
> > LX2160A SerDes #2   n       n       n       n       n       n       y  =
     y
> > LX2162A SerDes #1   n/a     n/a     n/a     n/a     y       y       y  =
     y        LX2162A currently uses lx2160a.dtsi
> > LX2162A SerDes #2   n       n       n       n       n       n       y  =
     y        LX2162A currently uses lx2160a.dtsi
> >
> > As LX2160A SerDes #2 is treated like #1, the device tree is telling the
> > driver that all lanes support 10GbE (which is false for lanes 0-5).
> >
> > If one of the SerDes PLLs happens to be provisioned for the 10GbE clock
> > net frequency, as for example with the RCW[SRDS_PRTCL_S2]=3D6 setting,
> > this will make the driver think that it can reconfigure lanes 0-5 as
> > 10GbE.
> >
> > This will directly affect upper layers (phylink), which will advertise
> > 10GbE modes to its link partner on ports which support only 1GbE, and
> > the non-functional link mode might be resolved through negotiation, when
> > a lower speed but functional link could have been established.
> >
> > You mention a common minimum feature set. That would be supporting 10GbE
> > only on lanes 6-7, which would be disadvantageous to existing uses of
> > 10GbE on lanes 0-5 of SerDes #1. In some cases, the change might also be
> > breaking - there might be a PHY attached to these lanes whose firmware
> > is hardcoded to expect 10GbE, so there won't be a graceful degradation
> > to 1GbE in all cases.
> >
> > With Josua's permission, I would consider commit 2f2900176b44 ("arm64:
> > dts: lx2160a: describe the SerDes block #2") as broken, for being an
> > incorrect description of hardware - it is presented as identical to
> > another device, which has a different supported feature set. I will not
> > try to keep SerDes #2 compatible with "fsl,lynx-28g". This will remain
> > synonymous only with SerDes #1. The users of the fsl-lx2162a-clearfog.d=
ts
> > will need updating if the "undetected lack of support for 10GbE" becomes
> > an issue.
> >
> > My updated plan is to describe the schema rules for the compatible as
> > follows. Is that ok with everyone?
> >
> > properties:
> >   compatible:
> >     oneOf:
> >       - const: fsl,lynx-28g
> >         deprecated: true
> >       - items:
> >           - const: fsl,lx2160a-serdes1
> >           - const: fsl,lynx-28g
> >       - enum:
> >           - fsl,lx2160a-serdes2
> >           - fsl,lx2160a-serdes3
> >           - fsl,lx2162a-serdes1
> >           - fsl,lx2162a-serdes2
> Weak objection, I think this is more complex than it should be.
> Perhaps it was discussed before to keep two compatible strings ...:
>=20
> properties:
> =A0 compatible:
> =A0 =A0 items:
> =A0 =A0 =A0 - enum:
> =A0 =A0 =A0 =A0 =A0 - fsl,lx2160a-serdes2
> =A0 =A0 =A0 =A0 =A0 - fsl,lx2160a-serdes3
> =A0 =A0 =A0 =A0 =A0 - fsl,lx2162a-serdes1
> =A0 =A0 =A0 =A0 =A0 - fsl,lx2162a-serdes2
> =A0 =A0 =A0 - const: fsl,lynx-28g
>=20
> This will cause the dtbs_check to complain about anyone in the future
> using it wrong.
>=20
> The driver can still probe on fsl,lynx-28g alone for backwards compatibil=
ity,
> and you can limit the feature-set as you see fit in such case.
>=20
> Main argument for always specifying lynx-28g is that the serdes blocks
> do share a common programming model and register definitions.


FWIW, I'd accept both of what's been proposed here with the
justifications being provided. Up to you guys that understand the
hardware to decide what's more suitable.

--l1qAzSyQB+CvJSLr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaL8i3gAKCRB4tDGHoIJi
0vhvAQDZEyf8x51YmLVbLOm2csNWa1TBsE5ET2r/9ORCvGz8QAD9HTuODOrXK55X
L1xXNkzQrGqOZt8X9Md/Ih/UdXYNIAQ=
=nVrk
-----END PGP SIGNATURE-----

--l1qAzSyQB+CvJSLr--

