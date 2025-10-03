Return-Path: <linux-kernel+bounces-841602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE3BB7CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF04EE67A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6955A2C3276;
	Fri,  3 Oct 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="pKbC+TZR"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0E3594F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513676; cv=none; b=u7VClMvgIbvli57gBzkIRrIsmp+LazxlPkxF8zRjNerEyTfFAFQWTInu/Vm7qq53i4acLt6T+9Pt5XnENYGxATBqFrktad0lVWEvqPkWWnEZ8z1HVwVL1DzTqx06K9jmBw/LJLw4OgHCCtwz63l8U7fclmoWl/uK40O/wVkoFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513676; c=relaxed/simple;
	bh=7cFf07vJ1ZOqj5vQcNrlXFY4kxuMmo4vQffhv/UYB/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dgh+D5Pe1tF20OstMm7PDyu64IeQUUcD4NzAMdZmwAoaCMiAq2HIVRj12n3jmgn5OvmpfPPLt8J0m7RcDb2/6p3C8XbP/IqndwJuuXm9pxhKDHjYTCFCCv1nxYP1A/bUP9/yNdpa3nuLNu4b0Xat358jnjjT5N2SbpVFrRDI4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=pKbC+TZR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78eba712e89so22013026d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759513674; x=1760118474; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7cFf07vJ1ZOqj5vQcNrlXFY4kxuMmo4vQffhv/UYB/8=;
        b=pKbC+TZRYV3ueuOEkLd5qaPOKDKkXxg65og1WClfBJX75eCtbvsGxka8pMaJXwnG1f
         6V3Ma3CyR03/w1FHdCPeoLXbBM+nTtiMAVSmOV4kqs6p5myQIzI4Q5ABIVTWeQ6NLmzU
         ICdlJeJ8XMQktzM0gb3Qz++5WX5Y5y7BeyKjzpHydbmqzWKFem9oqfXffESweSOY/VLh
         pqCxeXV5TnnrwntjQHSqdYhsSuCfZF0LvnJk3DHPoVfCbNWFe1hcjZQMrVUMQv2MewIL
         /BdLpJL/Ilg/tJ00fuZjRdYZKtho/ZJpFeiFooucdhTSkhtWZ4Qnhr/0UUZ26De4h+Vv
         2/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513674; x=1760118474;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cFf07vJ1ZOqj5vQcNrlXFY4kxuMmo4vQffhv/UYB/8=;
        b=iZMlo1rcI2p+j2aQLOTIaqe+3GmxWBiLkT2wHJnvtbwIJdDOr54BYt+qL2kL+dJ5b3
         mmkSVdjo9unI7QOTl8kgPAPPOzINk4bC42zwjcLMnEdsjKA8kqK4CSiFgRwayIsfL2Br
         WNUSaEBPkjuCIr2bTALddx9WM59bvMFy7diUy/GKhTv0sAORmjyJKQlx1UIG8yf6I058
         70zdvtC0Fvv01yn4s3i1ZW7uFVhghpwIl5+kHVvDVmlyJklXgAjRTcqL/udd2CZlon5J
         F8+Hz/+LkEbLz1LP6PvqL7YIZRqZHEg2cHry+nPicQ+nhAetbd/0Om8J/tCJVoVBv+3E
         WgGw==
X-Forwarded-Encrypted: i=1; AJvYcCUIGpOvtF8paUorSKHHQ4GoQ/XlCwDtZTdL4MpuPs99PlGw8AIL+4MXlDeyQQzDHsoL0qyJTw8vZfqsfIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOY5bfrb3p7BjoLhQ4hpyfZ4/I8R7nCuDbdU0jKhyDt3wLWhuJ
	oV4SGJAmWSWcdKxDnLtwrBSnz8rLBXzR29ktWuk51p9thYO7CHJRQeZsaP5N6rbd7uc=
X-Gm-Gg: ASbGncs1DBYF0ISBnQ34IxDuK6PoAUi1fcuuYVTK+ysQKDDsgxUEgC8hCTDLIthrlG+
	yb+P6+mQprYKQV4IElCSuaA7S1/lIySCd6Om/J65sv9CZ7su1a53wbXYpTqTP8mJ0zBxCokL+du
	QPx8o4c1DEHmYiQDLF+2aF0z9UwZKNyEXpzjwPIQZLNDU5LWvFDHf58pwnbsJFAlnxjpMc7IvUu
	2Q4F/Qp29RqYal702ewa1B2Z4xXu/nCFDEchpNkNBicF/tokzzvVXB4o2wl2HihgfTNT+8GAMyL
	GjQiblANwEDzJ7O+octkj4V+qvISL+NEQdZFcbzFv57tX0wPwlSO2bI7QRe3LSA0dA4z7boK9Ha
	WbDgiZ4NpKeHLxJESZlLOZzlSgIoi1PWrA6Y/p5ScT4I4fsY7EYVFoMVfBTlVIz/5XGQ=
X-Google-Smtp-Source: AGHT+IGfK2A6d1ozVmZSTT9hVr6KDhJblEwd+eZzjf0av9TH9BojLf29+Qfku/s/1SVJeyJgOncyoQ==
X-Received: by 2002:a05:6214:5188:b0:793:dce5:4540 with SMTP id 6a1803df08f44-879dc77a6d2mr50596496d6.2.1759513673750;
        Fri, 03 Oct 2025 10:47:53 -0700 (PDT)
Received: from [192.168.42.140] (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60df0sm44377316d6.3.2025.10.03.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:47:52 -0700 (PDT)
Message-ID: <d505550ed828d7f7e7202780bb14e53f68194323.camel@ndufresne.ca>
Subject: Re: [PATCH 0/3] media: allegro: fixes and improvements
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Matthias Fend <matthias.fend@emfend.at>, Michael Tretter	
 <m.tretter@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Mauro Carvalho Chehab	 <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 Oct 2025 13:47:51 -0400
In-Reply-To: <20250901-allegro-dvt-fixes-v1-0-4e4d493836ef@emfend.at>
References: <20250901-allegro-dvt-fixes-v1-0-4e4d493836ef@emfend.at>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mYE1c3375T4iIhW/yV7c"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-mYE1c3375T4iIhW/yV7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

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


For the series:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> =C2=A0drivers/media/platform/allegro-dvt/allegro-core.c | 114 +++++++++++=
++++++----
> -
> =C2=A01 file changed, 91 insertions(+), 23 deletions(-)
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250901-allegro-dvt-fixes-932f2c97063e
>=20
> Best regards,

--=-mYE1c3375T4iIhW/yV7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaOAMRwAKCRDZQZRRKWBy
9P7LAQC5y40ZttoAmKexN7ZrquivosLvab5jXw0HU11z5DeI3AD/XWIzzYQ6lWG0
lpS0Ynf05sSuZY2UREqCQxT4sZKZbgQ=
=cCCp
-----END PGP SIGNATURE-----

--=-mYE1c3375T4iIhW/yV7c--

