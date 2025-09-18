Return-Path: <linux-kernel+bounces-798655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41434B420C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21D61BC0858
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B821922FB;
	Wed,  3 Sep 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="qwZaEznn"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967471917F4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905480; cv=none; b=OKkLvhpi5HiVGqc26sc4x9+RwzwtPCWmsHGOOnJ6UZdlIr3WUJevgzMYEYJulAl6BeFwJ8tDjQ4blylZ9ihQ4CSlHvL7q/xZgk4odLXDHfAcrx1Zfa9JAbR5GVbZtwbfEa1Wz2k4NpkdHPYAkwQdGnqG7zDX6oe319wR7S1HUjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905480; c=relaxed/simple;
	bh=o2R6EH8vVq8X64twREcl5yX+6UbYAOvw2Vop10923lI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0NdqcMeveFRwinfI7ft6bUaAOix64Zd/3uSwJEZ0a30+i76LiRQeRQp/3ZW/Vr8DmKJrY848yRsxcxw3AEVnv94otI105ks3kTCQyp86stn3ZFhXyeE/emibMYeH5WMFbej3sgdpIGMjKDodc9zhVe+ce20hv/0bIKGoRZcjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=qwZaEznn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b32384e586so30159201cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1756905477; x=1757510277; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VvvntKQFWg167uBf7XgNWPpBloVxjgYOfN9r2LJ5PDA=;
        b=qwZaEznnPmy22VcZrNaQ6y4LCsddK50qDoA23YX9JKNdAQUijrLw+JvpcEng7YXnF2
         NwWoZkcZg7p3+Fg7ISTzyLlYhfdtLpo7+dfhH+uOoUOhjcFJiUc2BRIUfGoLdB87xisu
         vRnapFeFVcCr4P+eYV8gOF8lrME0fvLUTsEI1xo8SRxH7J+wn1VbXcXI2OBNILfbD390
         SCReF+POScrtv5LmUlGylVX5RJCSxhY76EPp+0evwLt6lTK8PxR+cb2GLZqMPJsOYakS
         u6VKYAA/0n7eaZArumviZi7ygIgvNIYqhWEX/7sralHv7x54rlKI6WjfF81jND6sfv2a
         +aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905477; x=1757510277;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvvntKQFWg167uBf7XgNWPpBloVxjgYOfN9r2LJ5PDA=;
        b=wd3KX82ejgjsHTCR6JuVKz4NkBbcHH5IXqXuCTSV9yHQnxFbx6oyLW4VmXd0zE7Oqe
         LU9tNU4gJ3/R9O6vVixMuyo4PCsWcWe6jiI+drdoc0D/aCpTI+U2W+A60CyTxApf1IAT
         hr2MgW+L8PrAkmxhivcBG/LyJ6WaNWv3UUxTNvZf7kJudT98+cQ4tTZpzPpPvz1xfDhy
         rtIlE/2tiYxSSTErelfTVYkeoIu5fn/eFyQEOFSFcYAsnZRvRBCqntQLuxGAUkQxDcQY
         /uBtGdZs/JoKcrpizKkElbtX0XCFlY7J6jqBCmSP7JAaZq0hENiCD1y0soGej6iE9Uov
         5Xgw==
X-Forwarded-Encrypted: i=1; AJvYcCX68YmN6GGbFF54SpioK0XYUXkuaaHFfiLLSDls1je58KhMx56jqay1LZdnZuOELNZ3EShZu26jz0GDyYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeL34BGNsAVbuI5wG+BAwv6CPxNb4hATdUELLh7dsfcCzjZcl
	LzT8A0THargR8Wfp12Oxro+WMAl4yLYhbM31iu6fDiLO3rQzfM2CoLnbbu/qhCSkT+E=
X-Gm-Gg: ASbGncvGoOIzs7yO0lVBaVJSy4k/ETbSfsT3TWv07fsG3UCS2fheb4FNdAt85JCDLMI
	C7+b3ASwhLY/APlaRqZDVZ/GHuUDZgkKXA2aE7/s02uOcfGpv6MmfSPEiso/jmolduTbXE5Sq98
	AvgLNWhNUNYJPa/IHknI5rrM+0H3e1mGgYvNiOBljqHAvePruCtyer/082L7vHAQnVy1SChGn0q
	/3yednm8q794DBQ99WebQaiKviXlu3O7xFmH20VtFwYMAqjS15BVU8/jpkpF9vm5J3gvtrsjfqE
	x2k0dpTBF+K7oSZtkAlzgnrx3fqbtFOhC65Kzl9NugRPrOuD23WLgyovP9D0oUuePQhP7qmNR8f
	XdCoggqqIv7QqikUXCjM0mEEN0H0=
X-Google-Smtp-Source: AGHT+IGvqixI2JJ9vMEi9zexOfvg59/aFmfGuKseEK7+mWZiCf6UPKvrAFywYKNIMyyJLkPSZvlDfw==
X-Received: by 2002:ac8:5ac9:0:b0:4b2:fd60:61e7 with SMTP id d75a77b69052e-4b31d875830mr147326121cf.37.1756905477391;
        Wed, 03 Sep 2025 06:17:57 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:5a76::5ac? ([2606:6d00:11:5a76::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aaacfe7e1sm105779585a.44.2025.09.03.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:17:56 -0700 (PDT)
Message-ID: <35ec43df37131904dae9a0c10502348461269af0.camel@ndufresne.ca>
Subject: Re: [PATCH RFC 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: DEEPA GUTHYAPPA MADIVALARA <deepa.madivalara@oss.qualcomm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Vikash Garodia
 <quic_vgarodia@quicinc.com>, Dikshita Agarwal	 <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue
 <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Date: Wed, 03 Sep 2025 09:17:55 -0400
In-Reply-To: <20250902-rfc_split-v1-1-47307a70c061@oss.qualcomm.com>
References: <20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com>
	 <20250902-rfc_split-v1-1-47307a70c061@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="=-yYZtNSI9AXNjeG3trwZC"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-yYZtNSI9AXNjeG3trwZC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 02 septembre 2025 =C3=A0 16:00 -0700, DEEPA GUTHYAPPA MADIVALARA a=
 =C3=A9crit=C2=A0:
> Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
> Video4Linux2(V4L2) API. This format is intended for AV1
> bitstreams in stateful decoding/encoding workflows.
> The fourcc code 'AV10' is used to distinguish
> this format from the existing V4L2_PIX_FMT_AV1_FRAME,
> which is used for stateless AV1 decoder implementation.
>=20
> Signed-off-by: DEEPA GUTHYAPPA MADIVALARA <deepa.madivalara@oss.qualcomm.=
com>
> ---
> =C2=A0include/uapi/linux/videodev2.h | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3dd9fa45dde1066d52a68581625a39e7ec92c9b7..bff42a71c67b3f4b570dd6f3d=
250f1bb482ec8ae 100644
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
'V', '1', '0') /* AV1 (stateful) */

You also need to update Documentation/userspace-api/media/v4l/pixfmt-
compressed.rst. Mistakes were made in the past leading to great confusion, =
AV1
can be wrapped in different forms and with different alignments. Here's few
question that should be answered in the RST documentation:

- Should we pass complete time units to the decoder ?
- If not
   - How is the timestamp going to be interpreted and transferred ?
   - Should userspace pass complete frame (with leading headers) ? or can i=
t=20
     pass OBUs ?
- Is that format meant to be OBU streams or Annex B (not to confused with H=
.264
annex B, it groups the TUs for faster skipping) ? (I bet the first :-D)

cheers,
Nicolas

> =C2=A0#define V4L2_PIX_FMT_SPK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_fourcc(=
'S', 'P', 'K', '0') /* Sorenson Spark */
> =C2=A0#define V4L2_PIX_FMT_RV30=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_fourcc('R', =
'V', '3', '0') /* RealVideo 8 */
> =C2=A0#define V4L2_PIX_FMT_RV40=C2=A0=C2=A0=C2=A0=C2=A0 v4l2_fourcc('R', =
'V', '4', '0') /* RealVideo 9 & 10 */

--=-yYZtNSI9AXNjeG3trwZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaLhAAwAKCRDZQZRRKWBy
9CvuAPsEUt+GPSGe3xTULuQEsO/qPdCGqiqWNEXf61UR09ODYgD+KVKmXTUYkoNO
OJpzALKdYRe5jhV5QzQ44fqbkTjIQw8=
=u4SA
-----END PGP SIGNATURE-----

--=-yYZtNSI9AXNjeG3trwZC--

