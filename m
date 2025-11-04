Return-Path: <linux-kernel+bounces-885098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F40AC31FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986033B3B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6C329E63;
	Tue,  4 Nov 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="BeAqfUtd"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237131B132
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272786; cv=none; b=FqiVBHnoDk1wFgVQCm2NAmDIihE0baUB+R6JC/fo5SnXYNOCvKdNfslrqiehMSoxo8ANEj4Xi/zniANeibzy77ZtL9woUAu5RXUV84hH1pQFD/z2Ra2MZ69xLBLGr6BvTgKWXcCLkAPUZdaJ4FDAHKtbicsUBOkRZFWVWB5XiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272786; c=relaxed/simple;
	bh=EhPNKWXcOC4wz99nX7zOq9HMTheZCFEjaub0QmjufR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZAYHaeh9JtpEWP76wbT1nlq9MyJjaV5E6c8lalu+uU07n+w3H0ndESY9eTPXfFQ8coGsdZcC8Xxvlu2gCXx/Qz3wZ8ovCkW36u+nXhzcsdh/7fB6X5+6Owdaim80yBG8gzDYI4epGJCuFeHlqzYYYB602BhrL4VenOEfFsAgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=BeAqfUtd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a074e50b41so748212985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762272783; x=1762877583; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EhPNKWXcOC4wz99nX7zOq9HMTheZCFEjaub0QmjufR4=;
        b=BeAqfUtdB1UulzkJ+Y1YQzsc3D0PmjgBNpuEk49hvPM7yYWrM0orjBN70f/as5eqaC
         Ao0NdOy5mYyYHg3vzY/QXXSoiSha7Fn8w6YQIZRQ2dXEoLNpod0CJv9/X0a2pgbX32WY
         /7CW1AakNTM5hNa4BehpGmsaTJW4R+nZBx2tyvV+I/QXt8DMJcdpiwmWDCLemacnO9Md
         F0j+0KPjqXCEbPA5F5CyoQaWzQHUozcaNXXj/LP0v8NlUPMedPtgNbJ5fS6biwQziO+7
         zlulWyy2/Qg9B2L7IfGUee0LjfDVRlGgxRgae/TloJUTa1AlFU6lAkoqhJ2TLtTfgEAX
         cWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272783; x=1762877583;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhPNKWXcOC4wz99nX7zOq9HMTheZCFEjaub0QmjufR4=;
        b=wn0XQ6TJkv+hx4n7gYLWAxsQzdMeUa5eL7oWLUk1uNuq7ypdi04sD7fXsuCRhDeIqM
         MzpEyuOd8IsmhF8Aot4DIgegTUa39gWFt5BYBsaRuWjT5wO4MoQNh3IsmI8ray67NG1D
         m0gLqKvv6xjeSZMHLrS7iXB5YfHjD+xQaj/+NEqUcukIfxfauM5LyyTeTrWQGpjnU9pj
         91F25sCS2MsJM6HBjZFcG1AMa2ldVAyQ0BslWjvyuxJX+oeIsW/HsDTxibQaan2AzsIw
         PytumQ5FNKZOr1Qy+JPaWSct5gypQS+0KY3mHhF+YFtmBsVRPqPPLYI2OCXBdkCUA2Cn
         EciA==
X-Forwarded-Encrypted: i=1; AJvYcCURX5G0CquoZW2HN3dDHNVd6kLFCreg8dL4Bd8C/dp9bgOyheq6RCBJ0fozIdACREeFQGQAnuqUWRZCoEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6op5/iWiFcn4VPz9v6EQGhbImdjOnd39s00CHu7C+PtUnxDl
	aZX1TyhoyVdh+kigE2uGqtlH8A4f8q6z2hbPOqlJs9mlvJvEgqq+aejNVkHFaZJmK1s=
X-Gm-Gg: ASbGncuHtg2mHFPmIoQLGiWTz6PGUIyOW91r9+4fgx5y8APw2YHrJhGgzmjVYPUSDQC
	TG97wMqIuv5znrKcAzZIVM9qaLU+zo9M9inA3ixzmC/Xf/cMNdRPgKSSzUlpXyxpsgO9skdOLdB
	zTatJ6v1ZA0DxAMHT02xcxhqzKflPqwuJB3m1OpHKCRlh9X1IlnuCO41zyLHGvLvybaI9fA3yHO
	QyR1FNXTS+E5jHksrzxVoepQafMt+ddtM6KoScY5h99ODr9cIXTmN1Qmx2Xpvei5C50DjVWCBlX
	xSKTmasZ7fusuqGEu97UDXVOJwlvY70WQgZs5sB7ZUwnWoCVHE/LBgM05PoCe9rWl/EOWH2BS/V
	B5Rq/xbyy2NE2qDxPW5yo6lrfdIf9a3bBhrmtdPldCp8RM6JGQ4CSqjEIhAzD5TN+4V09OJ9eYC
	URHTo8St2afYHW6ILx
X-Google-Smtp-Source: AGHT+IHJNxRdepwmA70rIxH7CleHW+ih2OcQNUmhfvzupPYK5yYekte9k/E/acCX6TG/uH9ZccgQuw==
X-Received: by 2002:a05:620a:d8b:b0:8a1:eac9:a84d with SMTP id af79cd13be357-8b220b7f57dmr20914885a.44.1762272782998;
        Tue, 04 Nov 2025 08:13:02 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:ebd3::5ac? ([2606:6d00:17:ebd3::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f51ecd3fsm216022085a.11.2025.11.04.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:13:02 -0800 (PST)
Message-ID: <b6e6881197dc4c83e43ef5eb1f20c2bf1887d395.camel@ndufresne.ca>
Subject: Re: [PATCH 0/3] Add Amlogic stateless H.264 video decoder for S4
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Zhentao Guo <zhentao.guo@amlogic.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley	 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet	 <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Date: Tue, 04 Nov 2025 11:13:01 -0500
In-Reply-To: <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
	 <b976b442-7d07-4fef-b851-ccd14661a233@linaro.org>
	 <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-kJqvtTvIehm+17QzwcKF"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-kJqvtTvIehm+17QzwcKF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 28 octobre 2025 =C3=A0 19:47 +0800, Zhentao Guo a =C3=A9crit=C2=A0=
:
> Ran 54/135 tests successfully
>=20
> - 52 test vectors failed due to interlaced or mbaff clips: The Amlogic=
=20
> stateless
> =C2=A0=C2=A0 decoder driver only support bitstreams with frame_mbs_only_f=
lags =3D=3D 1.
> =C2=A0=C2=A0 Test Vectors:

Is there plan to support it ? Most of the legacy content, and why users wan=
ts
H.264 around is to handle interlaced content. Its also not really optional =
in
the ITU conformance spec.

regards,
Nicolas

--=-kJqvtTvIehm+17QzwcKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQomDQAKCRDZQZRRKWBy
9G86AP9s4PfT2ZOEc7H8CSULI0fPz0RdFYmemyQn3wCh76IcygD6A5aq+z1GM0Eb
LOyvHiMpTuu/yzDSHPEMnVL2wN653Qc=
=yfQW
-----END PGP SIGNATURE-----

--=-kJqvtTvIehm+17QzwcKF--

