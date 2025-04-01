Return-Path: <linux-kernel+bounces-582968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EAAA774B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 08:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9233A9AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984C1E520B;
	Tue,  1 Apr 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b="B8SeGybR"
Received: from whm50.louhi.net (whm50.louhi.net [77.240.19.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014042052
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.240.19.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490185; cv=none; b=HpqmcV5SYGROswdM385vr7RjmBA4IuG/5tOT14OPIY19JbXV2d9Rmm5S/q+2pRDCA1Y26b8MGu+4HdIBTH6bjnIDrg4Q2thlZrLBKxLXG+IOPely1UcmlRUeBUukWeJHzyfnODuEfIDPuuaQqQ36ANd6WdrOJJ2xwjbMny3pexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490185; c=relaxed/simple;
	bh=tMXw1ux8AsM1wf3H9iMypvlvdHuCdcpErDsH4HJ5wHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvlsNkU8+5S7fDeLngbmx2ueViZO9qNwcEhs0+kbqjdy1jKFBVS9MUih+8lt2QhQtujrzUTJWdxQSjlnXqI2P9X3K6xhzz5vUFvXJNgftVDgcOns0TMWaJiicjFKHvl0Cvxf+SYehubz5mYmVSTL2H/cWCKkJSjH5my+/DhYt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi; spf=pass smtp.mailfrom=haloniitty.fi; dkim=pass (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b=B8SeGybR; arc=none smtp.client-ip=77.240.19.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haloniitty.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=haloniitty.fi; s=default; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z1s8rRdat+mEB54KawjBqYrX1tYiFDZhR1uStm9zESI=; b=B8SeGybRxlMRZqhBYZ7rjkHR5U
	EotnzFcCHkXJsZmCJ6ALrU2deKMh71mqwXUsYJihNBoL3Bpczb6W5l8AANNd/NJ1W7Av/KWH3gpQM
	haYdLJH75IIDPMd8wKpPTImleO7S3Za76P32u7bcUhlIvTTNb/W1ZAwh2QMUpLyUO45J7Sp6P/Zql
	Yl2vNH2UxuIm48S7pipQwINWCZviIQnkOsclNnpBjh5423yPKYBeM5YZqlNV1Z7lpL05Yj9btnHuI
	plLw69rwbm8CBKCoUo0Dl9RXjydLS+nVNvKFdbTtA+U6nmXn3WOghOQlJVDAR+p/a1nQ3kPSta0JP
	uMGYeDvQ==;
Received: from [194.136.85.206] (port=37780 helo=eldfell)
	by whm50.louhi.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <pekka.paalanen@haloniitty.fi>)
	id 1tzVRK-000000007Ms-10cD;
	Tue, 01 Apr 2025 09:49:38 +0300
Date: Tue, 1 Apr 2025 09:49:27 +0300
From: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Michal Simek <michal.simek@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 03/11] drm/fourcc: Add DRM_FORMAT_Y8
Message-ID: <20250401094927.4f7e6c7e@eldfell>
In-Reply-To: <20250331145456.GB27882@pendragon.ideasonboard.com>
References: <20250326-xilinx-formats-v4-3-322a300c6d72@ideasonboard.com>
	<CAMuHMdXM1B1c=62EpcuUdpdpaBRZSJLXb1GBB0egzp7Fyeo5-w@mail.gmail.com>
	<b195971c-52e6-463e-a440-83dde4346e65@ideasonboard.com>
	<20250327112009.6b4dc430@eldfell>
	<b5cf15a4-7c65-4718-9c39-a4c86179ba4c@ideasonboard.com>
	<20250327175842.130c0386@eldfell>
	<CAMuHMdVEpTVWmwrYt+G-QSWucT91goUcFor9qbo5rZ+X2jnRog@mail.gmail.com>
	<20250331105446.098f0fbe@eldfell>
	<20250331082135.GB13690@pendragon.ideasonboard.com>
	<20250331135337.61934003@eldfell>
	<20250331145456.GB27882@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=V49c94qfyH5Nz7z+qVjXec";
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

--Sig_/=V49c94qfyH5Nz7z+qVjXec
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Mar 2025 17:54:56 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Mon, Mar 31, 2025 at 01:53:37PM +0300, Pekka Paalanen wrote:
> > On Mon, 31 Mar 2025 11:21:35 +0300 Laurent Pinchart wrote: =20
> > > On Mon, Mar 31, 2025 at 10:54:46AM +0300, Pekka Paalanen wrote: =20
> > > > On Thu, 27 Mar 2025 17:35:39 +0100 Geert Uytterhoeven wrote: =20
> > > > > On Thu, 27 Mar 2025 at 16:59, Pekka Paalanen wrote: =20
> > > > > > On Thu, 27 Mar 2025 16:21:16 +0200 Tomi Valkeinen wrote: =20
> > > > > > > On 27/03/2025 11:20, Pekka Paalanen wrote:     =20
> > > > > > > > On Wed, 26 Mar 2025 15:55:18 +0200 Tomi Valkeinen wrote: =20
> > > > > > > >> On 26/03/2025 15:52, Geert Uytterhoeven wrote: =20
> > > > > > > >>> On Wed, 26 Mar 2025 at 14:23, Tomi Valkeinen wrote: =20
> > > > > > > >>>> Add greyscale Y8 format.
> > > > > > > >>>>
> > > > > > > >>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > >>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboa=
rd.com>     =20
> > > > > > > >>>
> > > > > > > >>> Thanks for your patch!
> > > > > > > >>>     =20
> > > > > > > >>>> --- a/include/uapi/drm/drm_fourcc.h
> > > > > > > >>>> +++ b/include/uapi/drm/drm_fourcc.h
> > > > > > > >>>> @@ -405,6 +405,9 @@ extern "C" {
> > > > > > > >>>>    #define DRM_FORMAT_YUV444      fourcc_code('Y', 'U', =
'2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
> > > > > > > >>>>    #define DRM_FORMAT_YVU444      fourcc_code('Y', 'V', =
'2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
> > > > > > > >>>>
> > > > > > > >>>> +/* Greyscale formats */
> > > > > > > >>>> +
> > > > > > > >>>> +#define DRM_FORMAT_Y8          fourcc_code('G', 'R', 'E=
', 'Y')  /* 8-bit Y-only */     =20
> > > > > > > >>>
> > > > > > > >>> This format differs from e.g. DRM_FORMAT_R8, which encodes
> > > > > > > >>> the number of bits in the FOURCC format. What do you envi=
sion
> > > > > > > >>> for e.g. DRM_FORMAT_Y16? fourcc_code('G', 'R', '1', '6')?=
     =20
> > > > > > > >>
> > > > > > > >> I wanted to use the same fourcc as on V4L2 side. Strictly =
speaking it's
> > > > > > > >> not required, but different fourccs for the same formats d=
o confuse.
> > > > > > > >>
> > > > > > > >> So, generally speaking, I'd pick an existing fourcc from v=
4l2 side if
> > > > > > > >> possible, and if not, invent a new one.     =20
> > > > > > > >
> > > > > > > > what's the actual difference between DRM_FORMAT_R8 and DRM_=
FORMAT_Y8?
> > > > > > > >
> > > > > > > > Is the difference that when R8 gets expanded to RGB, it bec=
omes (R, 0,
> > > > > > > > 0), but Y8 gets expanded to (c1 * Y, c2 * Y, c3 * Y) where =
c1..c3 are
> > > > > > > > defined by MatrixCoefficients (H.273 terminology)?
> > > > > > > >
> > > > > > > > That would be my intuitive assumption following how YCbCr i=
s handled.
> > > > > > > > Is it obvious enough, or should there be a comment to that =
effect?     =20
> > > > > > >
> > > > > > > You raise an interesting point. Is it defined how a display d=
river, that
> > > > > > > supports R8 as a format, shows R8 on screen? I came into this=
 in the
> > > > > > > context of grayscale formats, so I thought R8 would be handle=
d as (R, R,
> > > > > > > R) in RGB. But you say (R, 0, 0), which... also makes sense. =
    =20
> > > > > >
> > > > > > That is a good question too. I based my assumption on OpenGL be=
havior
> > > > > > of R8.
> > > > > >
> > > > > > Single channel displays do exist I believe, but being single-ch=
annel,
> > > > > > expansion on the other channels is likely meaningless. Hm, but =
for the
> > > > > > KMS color pipeline, it would be meaningful, like with a CTM.
> > > > > > Interesting.
> > > > > >
> > > > > > I don't know. Maybe Geert does?     =20
> > > > >=20
> > > > > I did some digging, and was a bit surprised that it was you who t=
old
> > > > > me to use R8 instead of Y8?
> > > > > https://lore.kernel.org/all/20220202111954.6ee9a10c@eldfell   =20
> > > >=20
> > > > Hi Geert,
> > > >=20
> > > > indeed I did. I never thought of the question of expansion to R,G,B
> > > > before. Maybe that expansion is what spells R8 and Y8 apart?
> > > >=20
> > > > I do think that expansion needs to be specified, so that the KMS co=
lor
> > > > pipeline computations are defined. There is a big difference between
> > > > multiplying these with an arbitrary 3x3 matrix (e.g. CTM):
> > > >=20
> > > > - (R, 0, 0)
> > > > - (R, R, R)
> > > > - (c1 * Y, c2 * Y, c3 * Y)   =20
> > >=20
> > > I'd be very surprised by an YUV to RGB conversion matrix where the fi=
rst
> > > column would contain different values. What we need to take into acco=
unt
> > > though is quantization (full vs. limited range). =20
> >=20
> > A good point, are the Y coefficients always 1.0 after quantization
> > range has been accounted for? =20
>=20
> As far as I understand, they should be. RGB is full range, so the Y
> range should map to [0.0, 1.0] in RGB space. I'm also not aware of any
> colorspace where a grey colour would have different R, G and B values.
>=20
> There's a related but separate question: if Y is a luma (in Y'CbCr
> terms), it will not be linear, compared to the Y luminance (YCbCr). We

I did not think anyone would use optical YCbCr, since that tends to
not occur in color transformation chains. Hence, to me Y in YCbCr is
Y', the electrical quantity, luma, unless otherwise explicitly stated.
Likewise, sounds like you take Y'CbCr to mean Y'C'bC'r.

(I like to use the term optical instead of linear, because of "linear
with respect to what?".)

> have a DEGAMMA_LUT to linearize data, but that's in the CRTC output
> path, not in the plane path, and I don't see any API element to specify
> the transfer function of data input to a CRTC.

That's what
https://lore.kernel.org/dri-devel/20241220043410.416867-5-alex.hung@amd.com/
addresses.


Thanks,
pq

> > That makes Y8 produce (Y, Y, Y), and we have our answer: R8 should be
> > (R, 0, 0), so we have both variants. Or do we need Y-formats at all?
> >=20
> > Can we specify Y, R, G and B be nominal values in the range 0.0 - 1.0
> > in the KMS color processing?
> >  =20
> > > > I forgot to consider that in the discussion of single-channel displ=
ays,
> > > > because the displays obviously do not consider any other channel th=
an
> > > > the one.
> > > >=20
> > > > Using DRM_FORMAT_Y8 FB with a single-channel display might even be
> > > > surprising, because the proposed Y8 definition would result in c1 *=
 Y,
> > > > and not Y. The default c1 comes from the BT.601 matrix IIRC?
> > > >=20
> > > > Therefore I think the difference between R8 and Y8 has been found. =
Now
> > > > we just need to determine whether R8 means (R, 0, 0) or (R, R, R) to
> > > > nail down the color operations as well. There are questions like wh=
at
> > > > is the outcome at the video signal level when we have one KMS plane
> > > > with an R8 FB and another KMS plane with an RGBA8888 FB on the same
> > > > CRTC? What about Y8 or NV12 in the mix? What if the video signal is
> > > > single-channel, RGB, or YCbCr?   =20
>=20


--Sig_/=V49c94qfyH5Nz7z+qVjXec
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmfrjHcACgkQI1/ltBGq
qqcFKg/+LafNzSX6NrRPk0Xc1NZ5h+Jn86tbROGDDbyQcEg8MoKtgDOZkFvaH8PF
KVQ/IVFbTr6q1kAT9LT7p4PGnAn4ZtFbnrU5oJRKDmWdyJq7rphlCgUalAtNxF2p
QQSPqCnsAhVK8OZ8jQVccwY73/IkzkCmt3OOexepjMoC04VigTiEtGKHFAvbomgV
WmJXW0vGwXKSQu59L9c/7cuNyksUBAtByvYO0APF5KnIvUyj9hHUoRL4IaFf2JeB
SaQ93NCkmP/Dqr4TCEfh5xf/VFuiudlH1KSSD8PzXbOcYDgMkhZPzCP+MyrrzoTK
s8Htzvoa76V+nqLa8cmtz0mRzxHtyKko39Gnfvk43sFZHmEvd1MCSRWqcmRA00d4
uCimtn0mX88g0VCYKtXo6vcDLqPEwsZBpNnWaZkWxCJeqsnvMHMKw+LqgCYGcDnf
0A6wcGtDeGEif66mvxP4H/pc8mWVauqt27itN/Nw0iwFQkZUVftMkPJ8qg4WFsN9
c3v6aJObwd8qiv3nLZX1Lahn0IUhk1TkOzhtJN6Pc0uVohraVVbo09ss2rSCZHZ3
hrlQnO/VWv0cGhwYH9xCP4uutuXHuup2U8SknjC7OT50w2wWQrnjoz+Gf6oOIJA9
sBvEi/Yn3YBh+4q35po9weUFrbj4/Qytms7jkFeg3tI2VIVxBcc=
=gtXo
-----END PGP SIGNATURE-----

--Sig_/=V49c94qfyH5Nz7z+qVjXec--

