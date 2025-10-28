Return-Path: <linux-kernel+bounces-873428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB0C13EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE8A4FE82D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A4628467C;
	Tue, 28 Oct 2025 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="SxpPySr/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263C26B0AE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644859; cv=none; b=mcMbNj8txpjf7e5/KmIdw3CH5DMVh5biQo+9gUUbxFLhGQ0x4/dfCEARXkYbvhAT8ukKabe563CfHrgJBT8Enbs0Uj15CpOd0hce9mqr9WbYFqUxbR3UtFaMzb8kGml1zDcnGP826cucGFeRuT5b1OqDsYrB7ztLG4TBjdjhcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644859; c=relaxed/simple;
	bh=fGcN/mnc+npBuOP7cFZCpYdNMDGQEaN2qai4gWsr0CI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JAd4h0DqfXnBaW5DEGKFaC4EDoW9IF4N4D4bDCLaZ/l+UC67QHhI+mEtV02b0z+/McLT6FxCjmauUbVkYlr3Dp56Qn4DifsGGpc79uaRr4gSzIGaRoVY/enksiXwb2yHJ+KihasYPwUzTUJpzrv6u0HXqjZbfot61hkEJK/543U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=SxpPySr/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471b80b994bso79658045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1761644855; x=1762249655; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=768yZp3cA3mcqTuMW9me8j/QG9lDuH2jp1SmYQqm0eQ=;
        b=SxpPySr/zFrB7ady2cnI+rHVCk019fL+7VzAKVAzRl56oHRKQXfWns0+hgu+ZxMfZE
         FWkpsHReI5nZv354E54WkgtM3xahm7gOFHzSoHbrCzz5uQpCIGIqvsIn6OP+HQc4+bKF
         Daf6KG6uP/ENTmUqij9kUDJQZj5AAxrBwuU0DO39GzM3aE8XC7+96B5mtvugzO8eeBIP
         6OLdco3wb9WCrcXyJiGrSRzA3bYeeiLrImCVcZhFabJq3y0tQl9RHf5W+7aIl38TpnBR
         YRdS+SJePdkQ3sZ8LhBqfsM4mX3IXTYFG70YHJsQ130w8JItiSK9UQ4qXubhTYNGM31a
         xSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644855; x=1762249655;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=768yZp3cA3mcqTuMW9me8j/QG9lDuH2jp1SmYQqm0eQ=;
        b=FF/UifY3Qu//qld4y07OIlk5VSN5+VEDPZFppHgRg4gULhmSNEm5eqmCFef9oo7Ezk
         gg8DnqiOjSx+r0NGchUedOMQL7L9Sfa+SvYzsOazwhACKobUFL6fnZu6CA88L4ID3b6H
         5CfLqJJrvWPkh6+R5BCkw2uu2+JQhmThJsKRyltnREiwglQJNjU1a4GfbetCzkWh2by8
         ZmzsTvQCS3wX+gJtkKtS6/7a9uXrjjOb9eSWLwGSGI310ArEDgqBgdfldnsOshhXt5I1
         9DQNHXvlTd5TesCNkJJeO5F4xXdUqGXuEtUUBfR4rPavCDydUNgcX+peWIj3jqfzQT2h
         N0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn8c3wfPLLqjTJXa17inzk3N8ShgHHBZhbRYpVgPWvCKA0Vg4r2NLyh+R+qGsnz/jhFUm5ATZCXytRnHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/WeH3SWYUtky2wjesP9gGn3ZakcliY8K5+pBe8Qo9PlYTWD0
	HFnXqMVLwiv6ZJu+seLli9HXuOHOeIUUd/ne+tKR0UASD3R+oA4dCl4vnmWfqi4Tj8E=
X-Gm-Gg: ASbGncskzPBbTJRW2DALkOxQm8XzzNnrxCRAzm6LEvWJkBVc0D6N2RyQb8AlJmZee+t
	BqK1viCDfJftLU9ttw1Ackk8Y32Jqe1ud7Bieis0EHDDRhsywvZjzfu4cEo46KrL3tXRhAcoMe2
	iUzeju3plaHtmx01uo/dD22AWj40+IwveiLe9AFQIBTZrcJQG5HdUeVk4mS0to5kLCrHyIwAvfU
	nqepUwpoeW3afYKFzgQbvtI+CYVrQz4OyW7uAdCmX6E4b0qpqEpsGvzxIRFvS8zaltS1Budu+QB
	EFohRQlT3DtdD9vC9yuhKHQ0w1C0oiiglsgZNv55dx35Xt9Ia+eIdt/zbe/1I3TXpNmLal0dWGP
	U8wwCp7jHsfgId+MqcoGzXn+hf1Nm8ZRipu1gNW/nRidpoFA6wn7CMNXROcGZstT7Gdtyrq+Oxl
	PyZTQ9
X-Google-Smtp-Source: AGHT+IFWHLGEgecjsi14d17d8QJAN0DfHwsjIZ3qxpUH1YdvcBO32/JOe3vpDKUGwmEPQRfYE+sNaw==
X-Received: by 2002:a05:600c:6290:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47717e6d477mr28815885e9.34.1761644854176;
        Tue, 28 Oct 2025 02:47:34 -0700 (PDT)
Received: from [192.168.4.57] ([79.79.193.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd477c92sm184692565e9.2.2025.10.28.02.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:47:33 -0700 (PDT)
Message-ID: <3a603410869cf876e7693880e0f6ca8ced27be7b.camel@ndufresne.ca>
Subject: Re: [PATCH] media: v4l2-ctrls: set AV1 sequence flags for testing
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Pavan Bobba <opensource206@gmail.com>, mchehab@kernel.org, 
	hverkuil@kernel.org, ribalda@chromium.org,
 laurent.pinchart@ideasonboard.com, 	hansg@kernel.org, yunkec@google.com,
 sakari.ailus@linux.intel.com, 	james.cowgill@blaize.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2025 09:47:32 +0000
In-Reply-To: <20251028062623.12700-1-opensource206@gmail.com>
References: <20251028062623.12700-1-opensource206@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-kxVl3pXhlxWcSMfpspLf"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-kxVl3pXhlxWcSMfpspLf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 28 octobre 2025 =C3=A0 11:56 +0530, Pavan Bobba a =C3=A9crit=C2=A0=
:
> Initialize additional AV1 sequence parameters in std_init_compound()
> to make the default AV1 sequence control compatible with compliance
> and userspace testing tools.
>=20
> Specifically, set:
> =C2=A0- enable both SUBSAMPLING_X and SUBSAMPLING_Y flags
>=20
> These defaults help ensure that V4L2_CID_AV1_SEQUENCE behaves
> consistently during validation and v4l2-compliance tests.
>=20
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
> =C2=A0drivers/media/v4l2-core/v4l2-ctrls-core.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4=
l2-core/v4l2-ctrls-core.c
> index fa03341588e4..8809912797d2 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> @@ -160,7 +160,13 @@ static void std_init_compound(const struct v4l2_ctrl=
 *ctrl, u32 idx,
> =C2=A0		break;
> =C2=A0	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
> =C2=A0		p_av1_sequence =3D p;
> +		/*
> +		 *setting below parameters to make AV1 sequence compatible
> +		 *for the testing
> +		 */
> =C2=A0		p_av1_sequence->bit_depth =3D 8;
> +		p_av1_sequence->flags |=3D V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X |
> +			V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y;

There is a bit of a lack of clarity upon why we do this. I would comment on
that.

/**
 * The initial profile is 0 which only allows YUV 420 subsampled data. Set =
the =C2=A0
 * subsampling flags accordingly.
 */

With the correction:
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

cheers,
Nicolas

> =C2=A0		break;
> =C2=A0	case V4L2_CTRL_TYPE_FWHT_PARAMS:
> =C2=A0		p_fwht_params =3D p;

--=-kxVl3pXhlxWcSMfpspLf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQCRNAAKCRDZQZRRKWBy
9AlJAQD/1RfF7gfX/ljsf3B9plPP0YJ2UE8a+X8pA4lJofOB9AEA7h73+bcEcBvf
1DaAHAJAnIPGp6p8vGgGrEp6sZffvwc=
=zBmI
-----END PGP SIGNATURE-----

--=-kxVl3pXhlxWcSMfpspLf--

