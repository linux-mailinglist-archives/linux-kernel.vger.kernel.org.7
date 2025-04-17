Return-Path: <linux-kernel+bounces-608657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD9A9165D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 10:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC32D4454B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0E22D7BB;
	Thu, 17 Apr 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b="kktkyN+y"
Received: from whm50.louhi.net (whm50.louhi.net [77.240.19.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9082165ED
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.240.19.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878209; cv=none; b=aRfq0jJBBKYiLxeCWMjMLfbEdfhIA9LIj448zz9tuuLOZJxIOAw1SlvDXbfKjeSPw3LAETofEWdOIOb6gu0OuUktZjdVQvq0zR/waROfI16V0pfaDEGV0qXoWWRa75bTFGA4zjr9/zrAXfvXqLcTXG7LKcpbQ5mnX9TChOHF0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878209; c=relaxed/simple;
	bh=2Iugk9JkTKzroTBLyegXt9g+/AgkNv6SkaNSuJUVEP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMJdOMpzaGwCMk2iCjb7ZK6nP3aMgpqqGeFcU6qrgxsjSDw/AVyvROuhUVfmURK7CqTzGy+Yn07J7BKZE1UwPoR/hNxevFQF6uhTU38iVszH+JKc9Q5DKIYSzUMUTFhZ3puV4Fc5pv+ayuKkOtJhPAhyjjjAUhjFpRC7k+qhJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi; spf=pass smtp.mailfrom=haloniitty.fi; dkim=pass (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b=kktkyN+y; arc=none smtp.client-ip=77.240.19.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haloniitty.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=haloniitty.fi; s=default; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y/NfW24ZU1/22v8pv8IL6oyeqZpSqYrFN91QC0KdvDw=; b=kktkyN+ywv85ObhtRY1LOixakP
	SQUBLexIe25yOaArDoOgrQqoNBYZq7SE2ssEChfcxtM8hezq1RDhDvhSPJTFMu8Z11r5naFImeeR7
	ZAaJmmOxJ2NICgcUUNyJ3YzllZh474kKu3c3Z0415YBsbeBZ4j7YRZ6kUbI7qhq75wCYkUcRn+I5o
	biJQ2fqfh/XU5XdPILTv3ykx8HQQDm55P+40jCNt3rl70Eo44qbuqA9oXf1/VjM8k986cSMstBsRV
	2ThbdVbp6NlwmMLvY/z55n4QRMHuWURJZqQUv19M8rLZEqy+vv4dgZjru86PzvHa/7C6joZlA3NHY
	zEYCsNmw==;
Received: from [194.136.85.206] (port=46774 helo=eldfell)
	by whm50.louhi.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <pekka.paalanen@haloniitty.fi>)
	id 1u5KN3-000000003hT-41C7;
	Thu, 17 Apr 2025 11:13:17 +0300
Date: Thu, 17 Apr 2025 11:13:15 +0300
From: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Vishal Sagar
 <vishal.sagar@amd.com>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Michal Simek
 <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry
 Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 03/11] drm/fourcc: Add DRM_FORMAT_Y8
Message-ID: <20250417111315.62a749e5@eldfell>
In-Reply-To: <73bd6628-374d-417f-a30f-88a4b1d157bb@ideasonboard.com>
References: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
	<20250326-xilinx-formats-v4-3-322a300c6d72@ideasonboard.com>
	<CAMuHMdXM1B1c=62EpcuUdpdpaBRZSJLXb1GBB0egzp7Fyeo5-w@mail.gmail.com>
	<b195971c-52e6-463e-a440-83dde4346e65@ideasonboard.com>
	<20250327112009.6b4dc430@eldfell>
	<b5cf15a4-7c65-4718-9c39-a4c86179ba4c@ideasonboard.com>
	<20250327175842.130c0386@eldfell>
	<CAMuHMdVEpTVWmwrYt+G-QSWucT91goUcFor9qbo5rZ+X2jnRog@mail.gmail.com>
	<20250331105446.098f0fbe@eldfell>
	<20250331082135.GB13690@pendragon.ideasonboard.com>
	<20250331135337.61934003@eldfell>
	<20250401162732.731ef774@eldfell>
	<73bd6628-374d-417f-a30f-88a4b1d157bb@ideasonboard.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_w01jp+4xY4YrTdLuzFgaip";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whm50.louhi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - haloniitty.fi
X-Get-Message-Sender-Via: whm50.louhi.net: authenticated_id: pekka.paalanen@haloniitty.fi
X-Authenticated-Sender: whm50.louhi.net: pekka.paalanen@haloniitty.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

--Sig_/_w01jp+4xY4YrTdLuzFgaip
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 11:59:43 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Hi,
>=20
> On 01/04/2025 16:27, Pekka Paalanen wrote:
> > On Mon, 31 Mar 2025 13:53:37 +0300
> > Pekka Paalanen <pekka.paalanen@haloniitty.fi> wrote:
> >  =20
> >> On Mon, 31 Mar 2025 11:21:35 +0300
> >> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> >> =20
> >>> On Mon, Mar 31, 2025 at 10:54:46AM +0300, Pekka Paalanen wrote: =20
> >>>> On Thu, 27 Mar 2025 17:35:39 +0100
> >>>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>>>       =20
> >>>>> Hi Pekka,
> >>>>>
> >>>>> On Thu, 27 Mar 2025 at 16:59, Pekka Paalanen
> >>>>> <pekka.paalanen@haloniitty.fi> wrote: =20
> >>>>>> On Thu, 27 Mar 2025 16:21:16 +0200
> >>>>>> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote: =20
> >>>>>>> On 27/03/2025 11:20, Pekka Paalanen wrote: =20
> >>>>>>>> On Wed, 26 Mar 2025 15:55:18 +0200
> >>>>>>>> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote: =20
> >>>>>>>>> On 26/03/2025 15:52, Geert Uytterhoeven wrote: =20
> >>>>>>>>>> On Wed, 26 Mar 2025 at 14:23, Tomi Valkeinen
> >>>>>>>>>> <tomi.valkeinen@ideasonboard.com> wrote: =20
> >>>>>>>>>>> Add greyscale Y8 format.
> >>>>>>>>>>>
> >>>>>>>>>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>>>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.co=
m> =20
> >>>>>>>>>>
> >>>>>>>>>> Thanks for your patch!
> >>>>>>>>>>        =20
> >>>>>>>>>>> --- a/include/uapi/drm/drm_fourcc.h
> >>>>>>>>>>> +++ b/include/uapi/drm/drm_fourcc.h
> >>>>>>>>>>> @@ -405,6 +405,9 @@ extern "C" {
> >>>>>>>>>>>     #define DRM_FORMAT_YUV444      fourcc_code('Y', 'U', '2',=
 '4') /* non-subsampled Cb (1) and Cr (2) planes */
> >>>>>>>>>>>     #define DRM_FORMAT_YVU444      fourcc_code('Y', 'V', '2',=
 '4') /* non-subsampled Cr (1) and Cb (2) planes */
> >>>>>>>>>>>
> >>>>>>>>>>> +/* Greyscale formats */
> >>>>>>>>>>> +
> >>>>>>>>>>> +#define DRM_FORMAT_Y8          fourcc_code('G', 'R', 'E', 'Y=
')  /* 8-bit Y-only */ =20
> >>>>>>>>>>
> >>>>>>>>>> This format differs from e.g. DRM_FORMAT_R8, which encodes
> >>>>>>>>>> the number of bits in the FOURCC format. What do you envision
> >>>>>>>>>> for e.g. DRM_FORMAT_Y16? fourcc_code('G', 'R', '1', '6')? =20
> >>>>>>>>>
> >>>>>>>>> I wanted to use the same fourcc as on V4L2 side. Strictly speak=
ing it's
> >>>>>>>>> not required, but different fourccs for the same formats do con=
fuse.
> >>>>>>>>>
> >>>>>>>>> So, generally speaking, I'd pick an existing fourcc from v4l2 s=
ide if
> >>>>>>>>> possible, and if not, invent a new one. =20
> >>>>>>>>
> >>>>>>>> what's the actual difference between DRM_FORMAT_R8 and DRM_FORMA=
T_Y8?
> >>>>>>>>
> >>>>>>>> Is the difference that when R8 gets expanded to RGB, it becomes =
(R, 0,
> >>>>>>>> 0), but Y8 gets expanded to (c1 * Y, c2 * Y, c3 * Y) where c1..c=
3 are
> >>>>>>>> defined by MatrixCoefficients (H.273 terminology)?
> >>>>>>>>
> >>>>>>>> That would be my intuitive assumption following how YCbCr is han=
dled.
> >>>>>>>> Is it obvious enough, or should there be a comment to that effec=
t? =20
> >>>>>>>
> >>>>>>> You raise an interesting point. Is it defined how a display drive=
r, that
> >>>>>>> supports R8 as a format, shows R8 on screen? I came into this in =
the
> >>>>>>> context of grayscale formats, so I thought R8 would be handled as=
 (R, R,
> >>>>>>> R) in RGB. But you say (R, 0, 0), which... also makes sense. =20
> >>>>>>
> >>>>>> That is a good question too. I based my assumption on OpenGL behav=
ior
> >>>>>> of R8.
> >>>>>>
> >>>>>> Single channel displays do exist I believe, but being single-chann=
el,
> >>>>>> expansion on the other channels is likely meaningless. Hm, but for=
 the
> >>>>>> KMS color pipeline, it would be meaningful, like with a CTM.
> >>>>>> Interesting.
> >>>>>>
> >>>>>> I don't know. Maybe Geert does? =20
> >>>>>
> >>>>> I did some digging, and was a bit surprised that it was you who told
> >>>>> me to use R8 instead of Y8?
> >>>>> https://lore.kernel.org/all/20220202111954.6ee9a10c@eldfell =20
> >>>>
> >>>> Hi Geert,
> >>>>
> >>>> indeed I did. I never thought of the question of expansion to R,G,B
> >>>> before. Maybe that expansion is what spells R8 and Y8 apart?
> >>>>
> >>>> I do think that expansion needs to be specified, so that the KMS col=
or
> >>>> pipeline computations are defined. There is a big difference between
> >>>> multiplying these with an arbitrary 3x3 matrix (e.g. CTM):
> >>>>
> >>>> - (R, 0, 0)
> >>>> - (R, R, R)
> >>>> - (c1 * Y, c2 * Y, c3 * Y) =20
> >>>
> >>> I'd be very surprised by an YUV to RGB conversion matrix where the fi=
rst
> >>> column would contain different values. What we need to take into acco=
unt
> >>> though is quantization (full vs. limited range). =20
> >=20
> > Quantization range is indeed good to note. R8 would be always full
> > range, but Y8 would follow COLOR_RANGE property.
> >  =20
> >> That makes Y8 produce (Y, Y, Y), and we have our answer: R8 should be
> >> (R, 0, 0), so we have both variants.
> >>
> >> Can we specify Y, R, G and B be nominal values in the range 0.0 - 1.0
> >> in the KMS color processing? =20
> >=20
> > I think this 0.0 - 1.0 nominal range definition for the abstract KMS
> > color processing is necessary.
> >=20
> > It also means that limited range Y8 data, when containing values 0-15
> > or 240-255, would produce negative and greater than 1.0 values,
> > respectively. They might get immediately clamped to 0.0 - 1.0 with the
> > first color operation they face, though, but the concept seems
> > important and carrying over to the new color pipelines UAPI which might
> > choose not to clamp. =20
>=20
> Is the behavior of values outside the limited range something that needs=
=20
> to be defined? We can't know how each piece of HW behaves with=20
> "undefined" input, so should we not just define the behavior as platform=
=20
> specific?

Hi Tomi,

it's not undefined nor illegal input in general. The so-called
sub-black and super-white ranges exist for a reason, and they are
intended to be used in video processing to avoid clipping in
intermediate processing steps when a filter overshoots a bit. There are
also practices that depend on them, like PLUGE calibration with
traditional signals on a display: https://www.itu.int/rec/R-REC-BT.814

I think it would be really good to have defined behaviour if at all
possible.

> In any case: I can't say I fully understood all the discussions wrt.=20
> color spaces. But my immediate interest is, of course, this series =3D).=
=20
> So is there something that you think should be improved here?

Right, the range discussion is a tangent and applies to all YUV
formats, so it's not a new question.

> My understanding is that the Y-only pixel formats behave in a well=20
> defined way (or, as well defined as the YUV formats), and there's=20
> nothing more to add here. Is that right?

There are two things:

- Y8 follows COLOR_RANGE property, just like all other YUV formats.
- Y8 implies that Cb and Cr are both neutral (0.0 in nominal values).

I'd like these explicitly written down, so that they become obvious to
everyone. I suspect either one might be easy to forget when writing
code and taking shortcuts without thinking.


Laurent,

I did find a case where (Y', neutral, neutral) does *not* seem to expand
to RGB=3D(Y, Y, Y): ICtCp. The conversion from ICtCp to L'M'S' does
produce (Y', Y', Y'), but the LMS-to-RGB matrix scrambles it.

I didn't dig through BT.2020 constant-luminance Y'C'bcC'rc, but I
wouldn't be surprised if it scrambled too.

Of course, both of the above are not just one matrix. They require two
matrices and the transfer characteristic each to compute. KMS color
operations cannot implement those today, but with the colorop pipelines
they will if the hardware does it.

That's why I think it's important to document the assumption of Cb and
Cr when not part of the pixel format, and not write down a specific
expansion to RGB like (Y, Y, Y).


Thanks,
pq

--Sig_/_w01jp+4xY4YrTdLuzFgaip
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmgAuBsACgkQI1/ltBGq
qqc7nRAAmXge9COzSkIFtwVdgB1I3C03S98MlzQzBngg1OeV2HlqEvQxgGog4RS5
H/m+1Uhp/eSwmHd/awb1g/xBRphN8PaWaTAgEqhBvD5wqOU8yA11jXUUEdqay9fT
R/pG07ULjMoDuQQhaXhEKk/Nbb/sLpfLQ5/LX2pnFNcamVon8RtBB1hgtXIuqp+k
219fhUX5R9aaL/miyDUv9qn2PJiTMWEssS3rC/e7t4Iw18Hcvvbc49DEVJZqC/Al
4BU8jsVm8fyCIiv/fCKLg8SmaU6vBJjNo/HTmjE2VE2/0v5qoRrVolBy+CSycpVQ
im/O0YSbgR/M8AbZJgYGa10J1aUq3Gj+R8AdpywS2AvGT3JuA8ngdQ72crGbjcck
978rhpkUTU9wksIsbYvoCldB41AVqYZ5+/YnREDxckY0+OnkrU+rwy9Kg1yXp7qS
UnjWsrBUDmK8wqGR6fFSwKb5NHIY9lc6nc9hd0T9IIOwsgiRSlW/F27i+qctnOKM
1sMfqvRrC0BH4uCmCyoSI8z42IGbhhO1UnJO/m7nciEdOMsc0hI74KbT3H6FSlPV
EoknbNWsduAwAFfpetlJujy6mGPqAlYFoeZn4NNBQ1BZns6MambRrT5kvPYs2TkK
GS+27Zw1M95eextSNVCIWJ+JWF5xq1jlQcWmml2DoeZE6JIGm7g=
=uYMo
-----END PGP SIGNATURE-----

--Sig_/_w01jp+4xY4YrTdLuzFgaip--

