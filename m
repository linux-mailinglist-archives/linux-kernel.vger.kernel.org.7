Return-Path: <linux-kernel+bounces-635388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF6AABC7C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 10:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46B55071AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11672630;
	Tue,  6 May 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2GSaWky1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0D42A97
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518644; cv=none; b=Z5CrYq6o9G80Iibw3lMYR2epOZG5OfAfZ8mQwC8ef/lIz+2JACt8Nj361DaCEEyzWL1v9I8kkA3iSus430cviz/x7cwhYcsmAR9fO+OF02OGl6UEV0+MayWsKuCuERj5v3Nc017nrF1b2TrrQYZ4OwrXHqmn4LGiLJtjVy43j+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518644; c=relaxed/simple;
	bh=GDgq1k6gecP9HkpLEFdZKzUDM3uYsMCps4pFXq/sQdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RWvHoZvfvHHxryQGc76idY68zs1RlFxfnVzrxQK7su1+spYuzN3U/+r7R85Uqm/cXAzlumdHxBZzM3njdpmVHa5Kft9+6WxbafjgszjQVviuuUhGIYeo0ZrCwSUA8QwOAisnc6Y9p2JjvU6sGvAymhb96IWWx/achJq1aQ29bLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2GSaWky1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acec5b99052so1047254966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746518640; x=1747123440; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3hvy8MwKFG7pRMa9YWodnPvvUtw/Ntbixkh/hbz8wy4=;
        b=2GSaWky1IeDCxWThMFXDIDxWe+6neHmedrlhBsO7W2NiDshYbC8Yg74RwXaeh0IWo7
         R/G9q5B7DyYeHYNGHnGYKwaGW/8mj9Oi8+KgtZYegfvkZ/ljHUqQ9AbztUvBcLFCTQmG
         bbn6vhhlwqmPQr+2FQgXILpEd09h6rVKkTx8m+VEnPh3Vorvo5u0LeKt9VIexf+NA4UI
         lAYVhIeF8vxBZtX+StJjoon+dGS9mtRmRhmUwYnGNKxH9+Tv0JlnUOd8UHELRvGlLfPK
         3SUVcBgAjmoBKk2bn1WaDviwBQjSMcydO3ppsnRJIpH0X+DTW1KSmnKQwYj0obxUB7eb
         MLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746518640; x=1747123440;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hvy8MwKFG7pRMa9YWodnPvvUtw/Ntbixkh/hbz8wy4=;
        b=bftiKh7fm0ftfRbSvTU6Zmyr67a0IND58fHQ+Jp8KGJ8+gEpvx2aeu4ky8oD6ln0P6
         WEzod6lnxbSwde0iEu1bFbiiHHKwAgGsX8LpZyJDVfzCNXe0T5+KjxM5ulxIf4zs5sVA
         uh690cgV/o5qFBRNlVSK1xOpELRPkFeeUgvA+9gsODkp/aDWadr0evoQ0quprDy0X61W
         s4bKO/mlx3HLnxmRrhp/Numg3rHfh3oM6X8+MBnKBhHUEDh+Q+BKUw8jlzKoMX9nXoyB
         f3KybSi6g+YnzYsviiqOu+jFCJCZMElFrw7GE5NKAm3yeq32gpBVQv7sJfyXfBzu4et8
         btwA==
X-Forwarded-Encrypted: i=1; AJvYcCXxM6B+36qMgPISWBWXeQ696quhy9E39WAZlYXgD2M94FrCaVjD+x+PY8XddLltejza6fSNNaQf93PUfro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQh46Ctw00tWCRLPupMh0iKnBUzvBS5j0gbvagfbEX275V/9ua
	9IjS909DuuvVGgpgN+v9IFXbiBNHJLl/Sm9+FVTFZhkz/CH6G/yIZ8qkvak1RWs=
X-Gm-Gg: ASbGncs9/JRMGbrAWQAKV7RC7+MLIYKEwA3yqYvGcvVdxY+93mJtDI2fk0LLxKNIxWK
	yqjp9NNB2YW4e1etx6pOQKa26e/vuw+fXXeyN6TE1RCqN5myyGlx9lAbCE7Ysdzx59b12rtirs+
	mrDQr182WRky4m3QsLQe3yeeyaNeWGCY/N8MIhZnDvXmfN2UT4o9w7S6Lv6YxqFOoErWvAy7uQy
	HXwv527fIi8XROO43H+oqm9xd4yK126xdEn72qvf1lAi5OTwf3Kwt7jZ9odCDyKg2WHTs+g5oJ3
	F/IQoGFBTiYXtEiW8kSr3KB7NXK09q6+cwI=
X-Google-Smtp-Source: AGHT+IG3XXm9ccIB+CUT1vcml+DotrJ5Y4qNjCNhUj/Y6+0BAiNhM6g1peAmLYMmcf6ccbAvm/mcSA==
X-Received: by 2002:a17:907:9406:b0:ac6:f6e2:7703 with SMTP id a640c23a62f3a-ad1a48bc5d9mr824167166b.8.1746518640041;
        Tue, 06 May 2025 01:04:00 -0700 (PDT)
Received: from localhost ([2001:4090:a244:802a:8179:d45a:7862:147])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5fa77b8fbadsm7209300a12.50.2025.05.06.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 01:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=aa6293dec9e61380259b30e974f91a7a73a728eef4006bbfe88058cc3ae5;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 06 May 2025 10:03:50 +0200
Message-Id: <D9OX6MLK06I5.178PSUN91MJQX@baylibre.com>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Vincent MAILHOL" <mailhol.vincent@wanadoo.fr>,
 <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/4] can: m_can: Add am62 wakeup support
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com> <20250503-petite-echidna-from-hyperborea-cfd7fc-mkl@pengutronix.de> <fc3aee25-2d0f-4825-abbf-6631dbc64996@kernel.org>
In-Reply-To: <fc3aee25-2d0f-4825-abbf-6631dbc64996@kernel.org>

--aa6293dec9e61380259b30e974f91a7a73a728eef4006bbfe88058cc3ae5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sun May 4, 2025 at 7:01 PM CEST, Krzysztof Kozlowski wrote:
> On 03/05/2025 16:03, Marc Kleine-Budde wrote:
>> On 21.04.2025 10:10:36, Markus Schneider-Pargmann wrote:
>>=20
>> [...]
>>=20
>>> Devicetree Bindings
>>> -------------------
>>> The wakeup-source property is used with references to
>>> system-idle-states. This depends on the dt-schema pull request that add=
s
>>> bindings for system-idle-states and updates the binding for wakeup-sour=
ce:
>>>   https://github.com/devicetree-org/dt-schema/pull/150
>>=20
>> How can we get an Ack for patch 1 by the DT people?
>
> No ack, because it waits on dtschema changes. I commented there some
> time ago but there was no response from the author.

I wasn't available last week, but there is a response now. Basically I
don't know if you would like to have a different name for
idle-state-name or a different description. Rest is solved.

Best
Markus

--aa6293dec9e61380259b30e974f91a7a73a728eef4006bbfe88058cc3ae5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaBnCZxEcbXNwQGJheWxp
YnJlLmNvbQAKCRCFwVZpkBVKUxAqAP9D+cIQvVuOFWd2CRsjE+SfzFPGwRZqZgSq
Yg3qb3RJtAD9EBL3kKkQh3G1ojXxBapT1h0bEkW2Y6GgW5EFMczBews=
=bETQ
-----END PGP SIGNATURE-----

--aa6293dec9e61380259b30e974f91a7a73a728eef4006bbfe88058cc3ae5--

