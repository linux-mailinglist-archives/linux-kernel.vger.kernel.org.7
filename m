Return-Path: <linux-kernel+bounces-841647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D3BB7E79
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02BE54EE9C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212192DE715;
	Fri,  3 Oct 2025 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="A0yJ/qWN"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B62DAFB4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517035; cv=none; b=KVFYQyYqHU9IWEfUH/TziOQyLcsjzvAcZjTBfdDviF0B9r7h04BEKULZnDPIxnlpAIqBaYdoZdXCTNEFE0UA/xAwwDdCBgW58OvQI+OR3rUCoNIrpfDp1YE/eq964sVu0w/aOtUjyFVcQf88wSPkyONUr2LQ5gsw5PL4Ou1xNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517035; c=relaxed/simple;
	bh=KuJJ7wPVxagNcyryDtFWOnS+fG9VHmibRREcQW+NV/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQxBkX9ITsGT6A4esRWZJ997/oghzA38vrZWTrQeq0c7OY+Upxzo+lWgWcu8COad30uqLAgDqEfbxnQt/nX6X4lg6uwV/VqKkJE3WLfBtI2b53EASb3E1fYkLw3etgZ1VhaPrNwsXFDyRolwgmmJWah0T8p3Ld6BXGabZEqxoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=A0yJ/qWN; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e4a24228c4so20333041cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759517032; x=1760121832; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJJ7wPVxagNcyryDtFWOnS+fG9VHmibRREcQW+NV/U=;
        b=A0yJ/qWNbcr7ubEqchnEVLY21gcL9dd7x36XzsQQiWSgFSKBwlflB+mCISesMDLDtI
         ZmB83kmsd3gnF2fOIoABa90Uaa2ysGqlG1xlsF0VWFidow9F2dJwg3RXRmAfQlcLs5pC
         GLUPp400xjkD13uyfPJ3SieF7pFiVXvU9EIUiFhSvZ3RCcOkP5m6a9E5UuCbE9hbOYQ0
         5dvohojuBJQSIMox5cgC7t7PhBoASgS8k29RJFUee6NeT2/Ik49/J68QSwkmvKAKvtR+
         iDgz4iJ36BXUrSqxBMBKxHX2c6nTMYOW+TeXc8TN5nbGSN3Aqgc2sf4PDcV75Vjxu530
         JW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517032; x=1760121832;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuJJ7wPVxagNcyryDtFWOnS+fG9VHmibRREcQW+NV/U=;
        b=J5RBAC8ugdttZyqDeMtlaA6TSEhkWgX4oLf2U77fGLovmqkYFb+TFXQHnR5wrKiX6R
         sovjn0FX0sGs6vCf0NRvtRpby3qS+MoJNIb97GlXlu2+d+DQDMmfaHGb1l8vi1THRSCl
         hDw3A8zt17JbLiLsS4e0EytHHxdFW6ji8EysdMS8unXRX0GXUB2gfcR/P9jU18qTLvwK
         w28KNweJ1NRojzAL52OgDuAjszTA3eVpd5N8uu0iIPOEUSfW9JToLeZRHJOkL+YHFHGv
         nOm3x7v/SHrHVpOcDC4+BBbS5hGtF1a8OVIzxw6MljY2CMxmcakDx5Ukg8N69SpplWDq
         ExXw==
X-Forwarded-Encrypted: i=1; AJvYcCXbs0Syp98OdV8VFqmfp/hwkuuKp2YgoAUOo+PijZK6XanBjP525cnkJleixETWn/3TeoDTJMxceyQ3lXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfA9pyBhpNCUs160arvhLBWRJi5SZE3eDnqnQwaT3s+0fJYYN
	zpmQwVe2S9VX4j3W+bMJuk+wzF8EWZoCHq3wS+PzQEj+NOupKmYEJkeH1vJWNE1CjdUBtQhsDZG
	tEyY0
X-Gm-Gg: ASbGncuG8XdWz4Jzje1w+yEuwegQjr3X9E1nPrWIezZtU2BJDwFW50YgnwYUMN+Gr14
	lbdRVuOwiii6dl/MZWec7qeBFQig2Ft7ecqDmvLCC2UdhMfCAA/qR3ld6y9xuRPKug6bfadoWur
	XHEVzSvaJC41stX8dyDi0N7FOD5dNBW5mY93B5mQzYJJr9GYjCxMDq5tfzucAZMl3MnVfuarHc/
	WeJ5eQORMgw6rz4JT/aeUdzuLILsX+vggVKcUkJarezb2hhEUssDlDDoCANLrU2HnpEqAiBif51
	56vUQGsZ8FTuFlQ5rreyZM+yxMQec2tOB2MpAf4LTHFNqgiJEnNZEJeltbLLutfFYjrCUmA7Ny+
	AeGpfLhLnPvb0FZ6Pr+SX9rFMoJoBBcCpKThSfMpu+Xsgv7dingIKDBJ9cfzmnbz8kCT+sjYUiK
	715Q==
X-Google-Smtp-Source: AGHT+IEDlpFweYYZYgSWaGoyFOuU/0LvqNP2116tlq90/2vF46MndprjZ3cScKJFz7EmEJI0QMDqjA==
X-Received: by 2002:a05:622a:5144:b0:4ce:f3ce:e9da with SMTP id d75a77b69052e-4e576a29decmr64079041cf.16.1759517032239;
        Fri, 03 Oct 2025 11:43:52 -0700 (PDT)
Received: from [192.168.42.140] (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e79ffsm50039171cf.29.2025.10.03.11.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:43:51 -0700 (PDT)
Message-ID: <cfaa1ceabae30fa18b5b4136e1eb58aec4fcf045.camel@ndufresne.ca>
Subject: Re: [PATCH 0/3] media: allegro: fixes and improvements
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Matthias Fend <matthias.fend@emfend.at>, Michael Tretter	
 <m.tretter@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Mauro Carvalho Chehab	 <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 Oct 2025 14:43:49 -0400
In-Reply-To: <20250901-allegro-dvt-fixes-v1-0-4e4d493836ef@emfend.at>
References: <20250901-allegro-dvt-fixes-v1-0-4e4d493836ef@emfend.at>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7CZOag6us981g1lPWt9e"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-7CZOag6us981g1lPWt9e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathias,

Le lundi 01 septembre 2025 =C3=A0 17:13 +0200, Matthias Fend a =C3=A9crit=
=C2=A0:
> Several fixes and improvements for the Allegro DVT video IP encoder.
> These relate to race conditions that occur when multiple streams are used
> simultaneously.
> The problems could be reproduced on a ZCU-104 eval board with VCU firmwar=
e
> version 2019.2 on various kernel versions (6.4, 6.12 and 6.16).
> It is highly likely that these problems can also occur with other firmwar=
e
> versions.
>=20
> Signed-off-by: Matthias Fend <matthias.fend@emfend.at>
> ---
> Matthias Fend (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: allegro: print warning if channel c=
reation timeout occurs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: allegro: process all pending status=
 mbox messages
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: allegro: fix race conditions in cha=
nnel handling
>=20
> =C2=A0drivers/media/platform/allegro-dvt/allegro-core.c | 114 +++++++++++=
++++++----
> -
> =C2=A01 file changed, 91 insertions(+), 23 deletions(-)
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0

For future submission, base your code on current media-commiters/next not o=
n
current Linus RC (this one is rc-4 I believe).

regards,
Nicolas

> change-id: 20250901-allegro-dvt-fixes-932f2c97063e
>=20
> Best regards,

--=-7CZOag6us981g1lPWt9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaOAZZQAKCRDZQZRRKWBy
9EacAQCm0ei0RG1X/oXU/A+sx+JDaat1yQ0RhRBh5z5a5nJUDgEA37Yvc+InVtUH
UdhAsnH2C0eb9azkaZvFGRMlW/+o/ws=
=cFmb
-----END PGP SIGNATURE-----

--=-7CZOag6us981g1lPWt9e--

