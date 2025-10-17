Return-Path: <linux-kernel+bounces-858689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF354BEB6F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983DC622E12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333BB33F8C9;
	Fri, 17 Oct 2025 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="uaaILemH"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8614F125
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731325; cv=none; b=RBw3shwYQ8e6QpXReaRreAMqeC35AtoUB7MBLaGx8J7J70f577dUyzohzLa7sKNbfbbYhcuEUrcOg9OrRsVsU4CKfm2ZvEIXI3t6QYRQq3uDouoCeHjA7FcrMSym2bmg29wbUsryvOGH84j6JRgI1bcPCgywwkCb5Dw3LIY7TjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731325; c=relaxed/simple;
	bh=uyhTf/Yn6End13EicY7fTGC1iItnSMpS8TMBNDZvOT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSoNRi/h0H25tVQIZWAeSxuKhz7JGXWfBlrIsg6/eJe9s857W3mVzojLYl59wnU9ufbCLk/55UfVkr3uo5HQq8/e986zoyFnQFVGE4vX5BYs4hpcDJAjLaxoOCZrRQZIM3UHGL1CekJP6cv2I+YfEPZf1Vs4iZGqPPt+1xiMrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=uaaILemH; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-931028aeaf9so1295702241.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1760731322; x=1761336122; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uyhTf/Yn6End13EicY7fTGC1iItnSMpS8TMBNDZvOT8=;
        b=uaaILemHO0QiQamnUkVY6Q3aYm58PzvJ0NTP++KsA2Shen/K9kkeo/5qm4t+71afSj
         D0fjdbdPN7vxrvK7Ucet0nAMfoiJ58qOMFqp8icKGbmjnDt+T5R8CrXi8U1jDBPMXqoV
         AgpG748P8MEbVd1AzPSG51ijJQn9SG/y/6m3Mws2nGA6L7VPVU2k6FbPAC33XmFnjTVU
         IRwKY4FF9YrEIT8XsYox5c/JZcxeTEISnQf/Z2M1sA0HWyuF+JyTdgsQYJgRHX1lK64d
         lAP90dhULEdB8NM2fEVx7lsGDo8iVD1JdpMTs03MfviEZInjQUKS3Y7arsS9j2DX15Qt
         XUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731322; x=1761336122;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyhTf/Yn6End13EicY7fTGC1iItnSMpS8TMBNDZvOT8=;
        b=s35LfMXZgr+AAT6Hrdg0EwcZyJujnQCqJIq2J4+M3k3P57xBoyYmaJOA06ObJOluEW
         1JGY1N833GKC62fTycJjOltINYBYKk2/KuI8SGuZ6QiFJhO7hYwZ26mHRyET6TCZRmzZ
         trSU6XJ5ks+lnskjG42apFJqgNhO0G4kspKg8RwOGJF+KgyJVT3tpMKTxsiu31cqeunP
         ENEWK57wr6TfOL/+fmxvdneqlej2T++10tQK8F3gK8J9JgsJ8ndR2J95UsicHGL8n2ZO
         qpnuavHETl7lWzuNuEkKKaanMhG5X6C+VAlPjBRpYCgDl6AmAuDmY+PGDAe6HxLih0LM
         FsOw==
X-Forwarded-Encrypted: i=1; AJvYcCUqBX9zTjQUkQjDFYeTH8Hy+PA5x3vaMxALpiM9iLo+eP4eLETeZYY3xrxsz4//3wggOPS0wrXwtOEiUFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy413RnnAVynzUUASfdK19V7pOJTfpF965hQePKym2m/ZvIXIGS
	mut0YGla2jS2/lBcrqcKaINXkp/g/bAtIL8VrEcg1D0fO/ojgK08uqy0yJ7lptodzdA=
X-Gm-Gg: ASbGncuO8myEQHNFUjS2HqYF2yUE4Wxp/uJ7bw0dzygMp/s9f1rLktRDAwZksPjN7dG
	qpDYouq1JFnqMoatttHd5x2LVzBPtkcIFGGMUrwh05F61x5tNpvheDa3HAnaIHDCNscEUJmv1RK
	n4PxMDDedPN7LoyzR8sMYbAaNhR6WpOaJPiXzxwlYVTMueIfF99hC+rzrzjw5lm3d71TzWFQRp0
	mAL+B0fiLTq3ciqtum/JiY4VC/jZKHQJZVQTHjIeCYHvLUB0ZvYLlqcHsTpRIttIThYMHLJycZs
	QXFv7vwrnw8hiGn4sfZ1ZbiIpjtbz/7tBoVlQuF3Xein3+4M3xDPI0hGyeDRKYfog9iO1XGqhTO
	xJxV3vLfvBclRnDeFkPKf61ZP5uapRrLQZKtgPQfMhUv6cIYCSgXZpkj2Bwbmul6zHC3dZMEMfE
	z+mqXwBlfj7USb4HXF
X-Google-Smtp-Source: AGHT+IGmcdG+dLWZ9QjPqKn5vbvyPULmAxubJ7JMNbm5wJ9rjtxXh60lzpQUudunNXWZznUcpLdv0A==
X-Received: by 2002:a05:6102:a4c:b0:5d5:d1e1:73e8 with SMTP id ada2fe7eead31-5d7dd555679mr2238466137.13.1760731321548;
        Fri, 17 Oct 2025 13:02:01 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51ff3c9sm4701776d6.8.2025.10.17.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:02:00 -0700 (PDT)
Message-ID: <c2acbc028d014ca9eccefc070e50e40a1022f90c.camel@ndufresne.ca>
Subject: Re: [PATCH v2 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Vikash Garodia
 <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal	
 <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,  Bryan O'Donoghue	 <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Fri, 17 Oct 2025 16:01:59 -0400
In-Reply-To: <20251017-av1_irisdecoder-v2-1-964a5478139e@oss.qualcomm.com>
References: <20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com>
	 <20251017-av1_irisdecoder-v2-1-964a5478139e@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="=-Bg5QwTftatcyAjl3ssim"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Bg5QwTftatcyAjl3ssim
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 17 octobre 2025 =C3=A0 11:35 -0700, Deepa Guthyappa Madivalara =
a =C3=A9crit=C2=A0:
> Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
> Video4Linux2(V4L2) API. This format is intended for AV1
> bitstreams in stateful decoding/encoding workflows.
> The fourcc code 'AV10' is used to distinguish
> this format from the existing V4L2_PIX_FMT_AV1_FRAME,
> which is used for stateless AV1 decoder implementation.
>=20
> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.=
com>
> ---
> =C2=A0Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 +++=
+++++
> =C2=A0include/uapi/linux/videodev2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A02 files changed, 9 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> index 806ed73ac474ce0e6df00f902850db9fd0db240e..d82557a6ac30851b4fd432a5c=
eab969abaed2e25 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> @@ -274,6 +274,14 @@ Compressed Formats
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of macroblocks to decode=
 a full corresponding frame to the matching
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capture buffer.
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 * .. _V4L2-PIX-FMT-AV1:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ``V4L2_PIX_FMT_AV1``
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 'AV10'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - AV1 compressed video frame. This format=
 is adapted for implementing AV1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipeline. The decoder impleme=
nts stateful video decoder and expects one
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Temporal Unit per buffer from=
 OBU-stream or AnnexB.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The encoder generates one Tem=
poral Unit per buffer.
> =C2=A0.. raw:: latex
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 \normalsize
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..e03cfe0a5ae830595f0bf69b9=
51ca16beaedab72 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
> =C2=A0#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* =
H264 parsed slices */
> =C2=A0#define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* =
HEVC parsed slices */
> =C2=A0#define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* A=
V1 parsed frame */
> +#define V4L2_PIX_FMT_AV1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_fourcc('A', =
'V', '1', '0') /* AV1 */

An alternative fourcc could be to match the one used in the ISO specificati=
on,
which is also what browsers and Android uses. It would be "av01", link to t=
he
spec:

http://downloads.aomedia.org/assets/pdf/AV1-ISO-Base-Media-File-Format-Bind=
ing-Specification.pdf

Though, we never had any requirement in this direction, its just an idea. W=
ith
or without, I'm happy with the definition.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

cheers,
Nicolas

> =C2=A0#define V4L2_PIX_FMT_SPK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_fourcc(=
'S', 'P', 'K', '0') /* Sorenson Spark */
> =C2=A0#define V4L2_PIX_FMT_RV30=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_fourcc('R', =
'V', '3', '0') /* RealVideo 8 */
> =C2=A0#define V4L2_PIX_FMT_RV40=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_fourcc('R', =
'V', '4', '0') /* RealVideo 9 & 10 */

--=-Bg5QwTftatcyAjl3ssim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaPKgtwAKCRDZQZRRKWBy
9G1mAQDGt5JQOm/w9g5nqKhv2gVj6S9I2LtZXQK7kIzpHep3EgD/UvNxHjG+9EpN
WkjKrbrxs1vYrwA/CnwzIQlfpQbKVgo=
=RfIA
-----END PGP SIGNATURE-----

--=-Bg5QwTftatcyAjl3ssim--

