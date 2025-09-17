Return-Path: <linux-kernel+bounces-821115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CAFB80782
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BC95283BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5232F49FB;
	Wed, 17 Sep 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llj0cr9Q"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386E27FD6E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122254; cv=none; b=b8KsovziCTmomGRWc/TnyR7hBse5RsLywvzNL05Nhe8fbrx2e6Z2EqTkUvljOPp396shiKDJUBauU/YvrMhwhOkUFGXf8r9tGSt4UwkP/ne6D4/i+tQP71pfoXDqhKBASDM0xt7Y+BPONZBlQ3JpB74aZ1uvD5UbW5bsWgNXQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122254; c=relaxed/simple;
	bh=bEyXUHGfChjaKW7D1iCKrZxj0SfOD7seNsJoVOKJnnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2vrA6f78x57K0Ph7BOArqDh2wrbDkPUKMIgx/S13YzlvXS1ZxH5ResSidXiTw5nYjctQtNJhYZob45Hjj947Gp8fvqvGs673eDOVM8Bm92e3KrCO9vo3S+bbWVNDJhgjXxIUuXuxFsoQphwutUpY9OdhP/ab4dEDuiwC0vIBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llj0cr9Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dde353b47so41344505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122251; x=1758727051; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6LiVoSFszZzWGxoTKoX/IVcu7vE/+lNgVzYVOLR2NBE=;
        b=llj0cr9Q36382fnAfhvp2/3WQ5UuhY724h6XWpmq7NvFFsiR8trxH4tUGtThBs5Tyo
         EXO4GgXUIr5qTvtumdLMlXPsTASeKsSBTpKTG25WlWdV5TT30kZvuznW33xjq5IpGLgP
         ZGZFDVW2tE3l6ZYaOV1Kimri3Fcx3KCex78Z/FofDn4nbh+VeDEA5VhUmuxP29XVuDJs
         eEl73+qJYYxazlSRmOcK9ufjOwHf6B778K5tKQatPfALVNm8hzfO9II3UhmQRYUMAnWe
         cb4iPlevupXAhWKKuhAtGj7j+YCTNxlv9ofVIUTBCGDKhzZC0/k4PGFw0p9JGkdvtziV
         owfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122251; x=1758727051;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LiVoSFszZzWGxoTKoX/IVcu7vE/+lNgVzYVOLR2NBE=;
        b=ikY1BahbI4f+k8mpeGwU1txO8h1k9MNB1E0KceGONvpth3Jtksmd/30yXjbnsiaFaE
         MgbYGTexIZjDtLiPy2OLZ0DCM6DnGGBcWjN2voRdmQSQ8m4vg8s6wdsFkj7BWvCvJmvL
         tvxfukWccmZ1r2z+SdPI9k8hdt1IKWH80gprKNi+jHErhHt0vNpd1d5L92aS1EjKp1Wg
         4a07vmhAor8Wgy3B3clWxTghrng4uOErrjgN7Eo27UtSJtvWf1YtMsChBM4hFGMM8Bg3
         lz3/pvu1AfEKr+cm9Er+H9/f0BzI4+tthEPzmtGDEKWtuzB6CkVONmPfa5GlCJatOP3d
         0CTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIrvjc77X36IPqCaVpayMbcEY6Y/9Xd+MDZJFh/WZBJtRhBZsjVT81CiFHUZ8euUBwVKEX6ifXTcn9fxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxfurUrLCFFCtYJlNumnAK+U5rcY6mo6aE0fBqHNTCXFnoW6X4
	YZyr1rPnvpq4WVJIZcxPGGep7L0rXG0hoB3DqgrSZDPDoZBVpldxtwof
X-Gm-Gg: ASbGnctHd/mSqgom9i3MeF2dGYehPAhWQli3wcZPfgCRCXacZ/iJjTwrMTy3f6VHB9e
	4Der3LIqbZPNMHUor5Bkbi7AZgXBraxQRCcYV0udFfQ3V6JJ/1YtI/eV7GJ3SDT6ixuSa5dnCVd
	8+Wfuc9sS3250sRKPqk/2oOPl88wc+v1Wf5Not4EYc1k6xkf+ETkFVFlibE88i+lM999b7k5Ph4
	6YSWkUv61jX03b3quRPb85hS9n5MoYyQwzIiTdPlWKluJTHRl0Idjck7Db46sn8ErG2qVMfBuG3
	8dzcZphe/uHIqBK89UhBXXrRgM0GFc6f/Vw2Z4q3fw0J78n57GOwMZBhf28x9rByhsWJhSGnGGx
	iDv/Hy7zvhtwB3f3ZlwczP4Z+yngspXc=
X-Google-Smtp-Source: AGHT+IGXiQ+wA7dnLWWohC9yMHk1s20he8pMp2LKEHl6ojec0wQ8QcHJtxsvyOT/9Gpxmj2HMV+okw==
X-Received: by 2002:a05:600c:4448:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-4620376f653mr25658245e9.12.1758122250486;
        Wed, 17 Sep 2025 08:17:30 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f339sm58355e9.14.2025.09.17.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:17:30 -0700 (PDT)
Message-ID: <add0b8de5452d9cb293c175c60cbb71b5ccac2d0.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: use AD7124_MAX_CHANNELS
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Sep 2025 16:17:56 +0100
In-Reply-To: <20250917-iio-adc-ad7124-use-ad7124_max_channels-v1-1-70913256a8f8@baylibre.com>
References: 
	<20250917-iio-adc-ad7124-use-ad7124_max_channels-v1-1-70913256a8f8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 09:17 -0500, David Lechner wrote:
> Use AD7124_MAX_CHANNELS macro instead of hardcoding 16 in
> ad7124_disable_all(). We already have the macro, so we should use it.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index
> c24f3d5127cb83eeab0cf37882446fc994173274..9ace3e0914f5acab695c0382df758f5=
6f333
> ae72 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -702,7 +702,7 @@ static int ad7124_disable_all(struct ad_sigma_delta *=
sd)
> =C2=A0	int ret;
> =C2=A0	int i;
> =C2=A0
> -	for (i =3D 0; i < 16; i++) {
> +	for (i =3D 0; i < AD7124_MAX_CHANNELS; i++) {
> =C2=A0		ret =3D ad7124_disable_one(sd, i);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
>=20
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250917-iio-adc-ad7124-use-ad7124_max_channels-37e2537d7446
>=20
> Best regards,

