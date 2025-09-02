Return-Path: <linux-kernel+bounces-797128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB67B40C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8477A57D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3693234572B;
	Tue,  2 Sep 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="bxWN29hW"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC92F6586
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834618; cv=none; b=BzA/PYZF63FouNGE65iKlXcNM3Uq1ksUIUGRd2RIG2kVTKUYrpZ+SVgza2v1/7BTuI+Y/vOzkCVIQt+Z/CJkgocz8Nlb3ojO+GGwEE297xz84Cwza+Kdlj3ePi2wjZHT52pL5amX9Xwa67bVlLrtnB+g/bcDc7wy8j6BF5BxD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834618; c=relaxed/simple;
	bh=8kh0KNqFZVht1WCkkGTN7yfMohVJEuP5J75rfdIo3xU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iENY3VaXhsn3iB4dibSmaHBjHrFXTn6XCoRxtxneY5px6zUeUnFKxXwkBF34myrTWMsO30bMMVYlVX5jlbFW+hh3TDYDfQa9EiEQl3aa37PALSTB6g+CQZH7ZloI30XpuzZZdx25YkCDnJUVnbErxV2yI/fCWcqxBG7tq9tD2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=bxWN29hW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b3384f552dso22170731cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1756834615; x=1757439415; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YUveWLfJxG1xB/SfZGtWgCATWX/xICcJ1voX4XvPV7c=;
        b=bxWN29hW1hIg5Yv77482HztNz+ZdmAaScIkC9+sugyKOaPQ1Ld3a31/j8v1wRUYx+9
         R+/KTbG5TyjMRzpk3ksRIfYyRGvVwTPJUvPgC4zXEzcuAyhqJ0QY96rt56X0Rn3oeAtL
         EYH4Mv96KugpGb1Fgd3ILM86lgws55m6lus1w8mox/Da4YdO4LP/Ic3gAWOJpVd2Hmx9
         bScknCYtEbNNTH2CcmYce2ntU7MTiEG6l6l3U99pykP36NE+uae42/W1q+GsrOdYP7qD
         SbRF8zGJiFLFTtZNpbXpqjpnrCy0jSrN5oJVG5UITNvYHfXChBlw2J22TTQj6zPuMzHa
         mXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834615; x=1757439415;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUveWLfJxG1xB/SfZGtWgCATWX/xICcJ1voX4XvPV7c=;
        b=oHbO+8hAblvpFLGpkD4j6Lv+YVx+tOGzfngQf/j/JHQRncKHoq3AkKt/OV67mVp6it
         0UWENBkwdidfX/BuejORWwtFgUwnbQBqM0bf1l+hLOopd3NN/n1Wq/IKD6vvDw2chxi5
         Pc1eOqh3Z+uQZN2VcqotmL2tNy16/RfvWIroabmLdBI70dcxSQUwpRqkiV21eEz95mOi
         SdYaz7ykC5Z0T6AzbscetXRM/VTFDxiMomhrRlfNOb5c90oLy5p3xPc6SoDQYcQW/DpX
         Hc6R3E5CBMyK7DiKulV1t1g82DvJGfz1Q9FSgsHhCYiVgH8cFTVZKBw6yQMDQjJz0YB8
         J25Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7nt9t0yJnDEgH3NXH9OOIymjDhanlPu5sQbkVd4MzripmLCFphgcfoUUlGjXTdhQN9Cog19NuTEMS6ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPl3eSfQzZ8pA3KLipTSwbpqIGXm2pbBEdGU4YMFfWhnGmJJnh
	8V/ppx6SWXhOhc+Y/dMS9nCxNCCilWXBaOMmCW6jAGqwOxwLPaf+bQ6C1A86Vp073Oc=
X-Gm-Gg: ASbGncuCvwtHsfKMuz0u1tTNrIfcf9Fw+fuHyQJULKWW+ODdUpWo1aHh5ql9Ukq1Tak
	oAIh3ewluo3KeBNGJLauc5qOwKigv5ETyTmJDCOLaOLsjUvRAzAUGKJ9ne6+mwlXl/GpOy58SiQ
	+LyiBaWYpPUoTTkFWDI+Y1kCj/1h73axIRXPYLJVC1KL6P/Y6fiRyQxXbDffavxANUluUS952Tr
	K9Jtoo8pSuF3OE5sLwfzjJ5GfwLbMG/cCE1hKP3mgEUCH9kKbPhu47H4/kAnKXjXCULKY8uGL8j
	brmGmUdWHUlscCAIknYsss/LySKz1nzaFdP5qweTxPgYJ9IXQrS7tujdfCnEgB7hgEkUw1bK0Nu
	joCIHWdGQewxe10Hc+eVgC6PdAPw=
X-Google-Smtp-Source: AGHT+IETKmiz7vITB+wEL/qJVUdGFwJs0WdOeM5m84xzUG31rg4EEVrbihuQfEUXw5+mzM+hj49V9A==
X-Received: by 2002:ac8:5e0b:0:b0:4b2:fe63:ade4 with SMTP id d75a77b69052e-4b31dcbfc82mr144159171cf.78.1756834615376;
        Tue, 02 Sep 2025 10:36:55 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:5a76::5ac? ([2606:6d00:11:5a76::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3474f2d08sm14082101cf.49.2025.09.02.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:36:54 -0700 (PDT)
Message-ID: <10a2f9865e96655c99ee377d542b5a06bb0146b3.camel@ndufresne.ca>
Subject: Re: [PATCH] media: amphion: Drop the sequence header after seek for
 VC1L
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl
Cc: sebastian.fricke@collabora.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, 	kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, xiahong.bao@nxp.com, 	eagle.zhou@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 02 Sep 2025 13:36:52 -0400
In-Reply-To: <d0102df15412fc827dca3b330b10904f97a1a240.camel@ndufresne.ca>
References: <20250725080712.1705-1-ming.qian@oss.nxp.com>
		 <ede4226a80e27c8b047b0eb25fe8f5ba90214d12.camel@ndufresne.ca>
		 <dbd7ec6c-9837-4bf3-a363-e287d075b677@oss.nxp.com>
	 <d0102df15412fc827dca3b330b10904f97a1a240.camel@ndufresne.ca>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-rCEhWbp6M9Za3ScTvuSE"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-rCEhWbp6M9Za3ScTvuSE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

just adding to my anwer,

Le mardi 02 septembre 2025 =C3=A0 13:01 -0400, Nicolas Dufresne a =C3=A9cri=
t=C2=A0:
> Le lundi 01 septembre 2025 =C3=A0 17:41 +0800, Ming Qian(OSS) a =C3=A9cri=
t=C2=A0:
> >=20
> >=20

[...}

> > >=20
> > > Nicolas
> >=20
> > I tested this with gstreaer, not FFMPEG,
> > And I checked the gstreamer code in our repository, Then I found the
> > following related code:
> >=20
> > =C2=A0=C2=A0 } else if (g_str_equal (mimetype, "video/x-wmv")) {
> > =C2=A0=C2=A0=C2=A0=C2=A0 const gchar *format =3D gst_structure_get_stri=
ng (structure, "format");
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (format) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_ascii_strcasecmp (format, "=
WVC1"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fourcc =3D V4L2_PIX_FM=
T_VC1_ANNEX_G;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (!g_ascii_strcasecmp (form=
at, "WMV3"))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fourcc =3D V4L2_PIX_FM=
T_VC1_ANNEX_L;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > Basically it processes WMV3 into VC1_ANNEX_L, and WVC1 to VC1_ANNEX_G.
> > I didn't found them in the upstream gstreamer repository.
> > Now I'm not sure if it is correct userspace behavior.
>=20
> Its a little concerning, since we are in the largely untested territory.
> Without
> proper documentation and with all the downstream changes done to userspac=
e, we
> can easily endup with NXP considering this is the right mapping and let's=
 say
> Qualcomm or Samsung thinking differently. Since this is for upstream, we =
need
> to
> ensure this is concistant. Have you reached to other driver maintainers
> already
> to discuss and resolve the subject in a way it works for everyone ?

So I checked Samsung implementation and your interpretation seems to be the
same. They MAP VC1_ANNEX_G to VC1 Advanced Profile Decoding in their
driver.=C2=A0Venus drivers does not care and just map both to VC1.

If I quote here Wikipedia's Window Media Video page:
   The Simple and Main profile levels in WMV 9 are compliant with the same
   profile levels in the VC-1 specification.[13] The Advanced Profile in VC=
-1 is
   implemented in a new WMV format called Windows Media Video 9 Advanced
   Profile. It improves compression efficiency for interlaced content and i=
s
   made transport-independent, making it able to be encapsulated in an MPEG
   transport stream or RTP packet format. The format is not compatible with
   previous WMV 9 formats, however.[14]


It matches well with the fact Annex G introduce start codes and inline sequ=
ence
headers, since you absolutely need that to stream over MPEG TS. GStreamer u=
ses
video/x-wmv as a family, and format=3DWVC1 for the advanced profiles, and W=
MV3 for
everything else it supports.

I think you should go ahead and upstream this mapping fix into GStreamer. V=
4L2
documentation should perhaps mention "Advanced Profile" to help devs.

Though, this gives me the impression that codec_data can be inline for ANNE=
X G.

Nicolas

>=20
> >=20
> > And the reason of this issue is the below code in gstreamer, that the
> > v4l2decoder may only send codec data after seek.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 codec_data =3D self->input_state->codec_data;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 /* We are running in byte-stream mode, so we d=
on't know the=20
> > headers, but
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we need to send something, otherwise t=
he decoder will refuse to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * initialize.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (codec_data) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gst_buffer_ref (codec_data);
> > =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codec_data =3D gst_buffer_ref (fra=
me->input_buffer);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 processed =3D TRUE;
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> That is truncating a bit too much of the context. The "processed" boolean=
 is
> set
> when the codec data and frame is combined. In the case the codec data is =
only
> to
> be found in caps, it will queue the codec data and immediately queue the =
frame
> data. This is perfectly valid with the way the stateful decoder specifica=
tion
> is
> written.
>=20
> In practice, GStreamer stateful decoder is multi-threaded, so it will fil=
l the
> OUTPUT queue with following frames too. What you can do to make your driv=
er
> more
> flexible is whenever you didn't find a frame in a buffer, merge this buff=
er
> with
> the next one, and do that until there is no more space in one buffer. Thi=
s way
> you don't copy all the time like ring buffers do, but you can survive abi=
trary
> splits of byte-stream.
>=20
> Nicolas
>=20
> >=20
> > Regards,
> > Ming
> >=20
> >=20
> > >=20
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0	ret =3D vpu_malone_insert_scode_seq(scode,
> > > > MALONE_CODEC_ID_VC1_SIMPLE, sizeof(rcv_seqhdr));
> > > > =C2=A0=C2=A0	if (ret < 0)

--=-rCEhWbp6M9Za3ScTvuSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaLcrNAAKCRDZQZRRKWBy
9G63AQCyMGpnvM2t/iah6p5bRMNoVq3AhBhx82SGjhQ+Gb4EPAEA0NCbo/kMptfm
2D47AslCwI/TCwDxugSj+57rWW71AAk=
=x5cZ
-----END PGP SIGNATURE-----

--=-rCEhWbp6M9Za3ScTvuSE--

