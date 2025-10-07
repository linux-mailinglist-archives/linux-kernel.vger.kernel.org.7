Return-Path: <linux-kernel+bounces-844685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6DBC27F8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A500D19A2A60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA10233134;
	Tue,  7 Oct 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeY0t+XP"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFD20E31C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865036; cv=none; b=HVobFvRHo5mSV5QeRKzLILRsxig2LCvmGhp9xDVTMJfVMterJMqAf6v74pJ1mKw9K1lmXFYvQgDa0LvjJPvpsIjS6AiQ+0/1YH3eYzZqh22F3F9mQ89xD53PNs1n1iTHdZ66AAobXqgKThzBAZb0ab/5jfKVMCRALw4Hd+8//ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865036; c=relaxed/simple;
	bh=Xw87XgCbg1sAtPDYd2NoXiEutjwEoopTGJYzoXJp+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0abS++Cc+e2PBk8OD7d1acaCx/MVSAam+pujvIGRBAnqj0uQBjNMwUGHyJs7slqCAQSJJZ4IhcEHbB3qz5Wv9wH4FF9oqZDfKoGeslvpVtYqEMUJgI7CzvMi4Tn0kV/kDxg9l9to7BFJF+5lYDo8E4LNj59JmG7hbu/DnAbWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BeY0t+XP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7930132f59aso1225071b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759865034; x=1760469834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eT1nwRDKVbKeF8BXec5ppEFdy9ETGubsSZiyxLMw9JI=;
        b=BeY0t+XPIL49xGOpuFawoFJcyKkJT42Sx+SmegzwSVIr0zRs/+N3UQ2vb6Nw0S8Th6
         P6R8jdaXsc9UCy+8ByKBz65bzckfmDBv/qrTT8PxAWJWhS0HokRZcCtkgu3EBf4DFk8R
         F8Az6eu4+yFOWCOMHoXxJZ0XDgel6Csu+9/s7huIuiK3V2l+9gmOUofebtpA7OpQY9Sm
         O4/qzioO4qk431yZUiyJsfCuNUdg5ge5S9eEztjfqP4HZkHyC+TlBlFHs67J2VcjR5sy
         0ra+sU4if5dvHqoFhzw26vD31vwLfaNxRK9Avkx9/jcujFk2UHw/1llUOv52QkhM0xVs
         HcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865034; x=1760469834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT1nwRDKVbKeF8BXec5ppEFdy9ETGubsSZiyxLMw9JI=;
        b=izXxve5KcgCQ+/knI9GJHmz2M6ARUT9ZdZHWzvMJEdcpMfByp3A6EUyNIK5BgAOXvC
         XCh6RUKngPqRWC4gujUZKx3zD0mGvCW5Y+EEhvD1BFxpNZQmq68vetkbSyHfGx8/I9KB
         qgx+oYHYyQvLCs30c0Ruq5++lxguKFGvpYvj3N/5b2B6p4OZMBIYe7iK/0Vbzcypr8wS
         t4f0xDTP+6DG12bKOj5HoDnESb073shd1m3hMAqf0cZS3B+UHEhZ60scgSZZNY9h62BY
         bG59PVl5QbwDJjMyzg5ebWxlOPYRAhDOoLTc8LcX7VkjwUZFbJvEyt4koXAmng2HmkWR
         hCDA==
X-Forwarded-Encrypted: i=1; AJvYcCXfJ+B5omiUfs7rPboCBgZ/xbjF2R8taKRlN8mlRLlaIeWkDrW65KOq2BBhMb+dIPjGWOzpND5H6JKVSTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GqueBmX0Wom5enSZOjZSo0lK2G8I8xVkK/sa3aaWCyCDX1JG
	DWf/ueVAZ2Lhqt8OusmLuHnZM9vlQFyywevd/xGTVqE6OVx7TXQqvOCowLNW1J09lw==
X-Gm-Gg: ASbGncuIm4hoO/o+Ug9Z+Pgj+ZL1bUGVTHnuzzo2+A/FuGrCor5rzMA9NkK4o9SVSHD
	Fj79Z32WfiznVYxa3D0JsP5IfGSzc0nQbOI11xumgOl8EYeCsYzYPrQRQnnzo3y/ZTrzoUZAKsv
	MNE6vx0v1lGZlWdgHoNtqW6FfMKL8laVRFlRwtf4sqtmZZGRreReMUHwSPWBl3dLOhu9vqTVPG+
	bopLjFrS+bAAeiVvUjmSANzZ2h1QhscGPWhQc0tV/CZAE1+Y0esm+v5kM9PSNP3IlvNuQFnn4bc
	23IGOrEZgexbXfoVcIEX769gvPcHLwKJIhjwhR2mJvbEGMkL4ocXSDpVVCslPMxSESwrx7R6DcP
	QDqEkkeBa4EPVwgHgz1lkjRzPNwiKamkqjk/ZIv/PIs/12DB1qMnhNTK6VQv48MZ8GXd8TX/lpM
	7uQ9DMA+u2xK9dgfPs/et8Egbb1xLKfl4=
X-Google-Smtp-Source: AGHT+IGSwGW88WMOLbHemUBllZFvuVlpdJOj4FF3pHUy4SuNXB8acXcCYQBlHBqvvbgzLZJwVZQjDQ==
X-Received: by 2002:a05:6a21:33a9:b0:2c9:1323:f800 with SMTP id adf61e73a8af0-32da80db36cmr695432637.9.1759865033911;
        Tue, 07 Oct 2025 12:23:53 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205336csm16623586b3a.45.2025.10.07.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:23:52 -0700 (PDT)
Date: Tue, 7 Oct 2025 19:23:49 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org,
	krzk+dt@kernel.org, robh@kernel.org, bleung@chromium.org,
	heikki.krogerus@linux.intel.com, ukaszb@chromium.org,
	tzungbi@kernel.org, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: chrome: Add Cros EC UCSI driver
Message-ID: <aOVoxQY3sLgkzJgD@google.com>
References: <20251001193346.1724998-1-jthies@google.com>
 <20251001193346.1724998-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bael24djLhppaNDA"
Content-Disposition: inline
In-Reply-To: <20251001193346.1724998-2-jthies@google.com>


--Bael24djLhppaNDA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 07:33:41PM +0000, Jameson Thies wrote:
> Chrome OS devices with PDCs allow the host to read port status and
> control port behavior with UCSI commands sent to the embedded controller
> (EC). Add documentation for cros-ec-ucsi node which loads the Chrome OS
> UCSI driver.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  .../bindings/chrome/google,cros-ec-ucsi.yaml  | 71 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  4 +-
>  2 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-=
ec-ucsi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi=
=2Eyaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml
> new file mode 100644
> index 000000000000..2121776e3ff0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,cros-ec-ucsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chrome OS EC(Embedded Controller) UCSI driver.
> +
> +maintainers:
> +  - Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> +  - Andrei Kuchynski <akuchynski@chromium.org>
> +  - Benson Leung <bleung@chromium.org>
> +  - Jameson Thies <jthies@google.com>
> +  - =C5=81ukasz Bartosik <ukaszb@chromium.org>
> +
> +description:
> +  Chrome OS devices with PDC-based USB-C ports expose a UCSI interface
> +  from the Embedded Controller (EC) which allows the host to request
> +  port state and control limited port behavior (DR/PR swap). This node
> +  allows the host UCSI driver to send and receive UCSI commands to a
> +  Chrome OS EC. The node for this device should be under a cros-ec node
> +  like google,cros-ec-spi.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-ucsi
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^connector@[0-9a-f]+$':
> +    $ref: /schemas/connector/usb-connector.yaml#
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      cros_ec: ec@0 {
> +        compatible =3D "google,cros-ec-spi";
> +        reg =3D <0>;
> +        interrupts =3D <35 0>;
> +
> +        typec {
> +          compatible =3D "google,cros-ec-ucsi";
> +
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          connector@0 {
> +            compatible =3D "usb-c-connector";
> +            reg =3D <0>;
> +            power-role =3D "dual";
> +            data-role =3D "dual";
> +            try-power-role =3D "source";
> +          };
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/=
Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 50f457090066..646bc81c526f 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -99,7 +99,9 @@ properties:
>    gpio-controller: true
> =20
>    typec:
> -    $ref: /schemas/chrome/google,cros-ec-typec.yaml#
> +    oneOf:
> +      - $ref: /schemas/chrome/google,cros-ec-typec.yaml#
> +      - $ref: /schemas/chrome/google,cros-ec-ucsi.yaml#
> =20
>    ec-pwm:
>      $ref: /schemas/pwm/google,cros-ec-pwm.yaml#
> --=20
> 2.51.0.618.g983fd99d29-goog
>=20

--Bael24djLhppaNDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOVowgAKCRBzbaomhzOw
wghaAP4ptO8He+nJ7m200fytazpueLrS9kKxn3i2rwNFghRDdgD+K5AL8DYGEsTY
DAUJA4flfi9ks9FmXLEf5hEQyUN98w4=
=nNDB
-----END PGP SIGNATURE-----

--Bael24djLhppaNDA--

