Return-Path: <linux-kernel+bounces-843963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 884CABC0AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D49634D06E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD752D7D2E;
	Tue,  7 Oct 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvtEzi7L"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358972D4B68
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826031; cv=none; b=bNZ4LyhR2AXD3YxWfp153yoOlzvLoeth0Rq4bTQEons0qus/lmI1NAuALbO3JOgq6Ayy9QmnHG5kRCBKtwIq4lTqKXHh9BLJsdW9r+0TTlTeg5LcoII5i9X5J0spqDbKk3mPSxqpBSiyWX4P8dKvrPfSaS5vlNYohWkZxppJX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826031; c=relaxed/simple;
	bh=1iY8dgK/r7VYOZvJEas2P75fHwdABfTnDJv6B71gZwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5ywlCcLKy5gfjdoF9Ei2Vw56cC3kaku91byGIIrYX5oDpkAehf1CL91p8QPjvG0t+MLin2lSGxVhxSGxknHAcgD61ZHjzd6YEJl7v9Ly2o05G3cXDO6o24VJVnvfpwQtXjVREdelPNSiazhQHQkBTROX3Y4LRDgEFdxbA3cAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvtEzi7L; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36a6a397477so59379771fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826027; x=1760430827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56U4cHXm/XO+yZsN8UYLacC0NRz5ruIRpTT3AQstYVU=;
        b=GvtEzi7LO++FCpXY5Pwj6ebSKH/tNsC43rHTbEjrKqP9pbyRAfftAvC/UXWEtYd2br
         tnTvfmfAhtXi6sbjedf+dxL3BW3VDl29qv1VzlLq59hYB6TtF+QD6ovw/exd621bMXir
         EZ3rJwkIMKpK0cbzuZv9VAlxXybRJ6iGTSs3qj5GofZ7aAqEsAAl0twjRFz8Z6hvHpoI
         ElJuWOHKQ6wgPA76saqaP066ZYmuFx5JOVN7xn1zahPLdvBhuKiKacQz64LF4d/UQYqf
         e2V3rJo3Z5jHjwLaYEUMOUfhGcqboT1Outv1Pl1NDP+bp/IsD6kNOZcTnjPZWXGjoLfz
         Xwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826027; x=1760430827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56U4cHXm/XO+yZsN8UYLacC0NRz5ruIRpTT3AQstYVU=;
        b=eX2cbe10qKrW19znyUQPwLBDM1sRxZrTONtgMdJyWuFEHgw8lgI/36Dv62xKbTFGWW
         fceuc4Et1YbBtzPzRraQWbT1V/J9XElgt9PfLNeentc5wrCJsHEgEQPUPIMiU6VEO3Cf
         TXgPGQX6rh6EWAqDKh8nj68qbxRWsVCDsZuFbftKnf/nwjWTAmnzsqiVSZjD/Qes6JPv
         buS9hbP1yP90vCb9gPjoMT7aA16RmZUDDLEL5EYbn7/QSwglcJq3nsICzwml1+cpa06a
         02BE8Fkz4YuZDiK4ogdXMuVEtbl20eqwhY2OOqvyBn+yuFtvEMoWu2HV9nKQaT+C+f8P
         +pcg==
X-Forwarded-Encrypted: i=1; AJvYcCVFE4yNxU6ABbJwDsPJxy3VgdDXAeYl+n++oGDmIHeB1lnyeV1L6CYPEqSkPmmpKChEGwvVIMmREpino58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCbHtbp0jVhj2EsRuEjlXpXSjKGdS23ZcgvGD33j1t5AHL4Wf
	45yVVJA69ml+TComE4s+TVBhnK3fpT1d+DIMzsNxeGJBBLp3/fa5e26N
X-Gm-Gg: ASbGncsCC/4jCWfGC8DyI1EPgmuETN0uJf3sXTEx9+8dQxYTarLLnrdtE//0mlRXd/K
	ccJnWuxuNIFoafmMrllgigZk9rE1IQBj+0JYhNwcHxwXzNzAHoZjwk3s5YsdOtHwJ6kB0Z8Z8yf
	maUb5MoIJGE9jkXO31EzQLkvEv4QI31KdiY9u1KwgtbP0Dp+WaU6fjSxqfpO3/SMZUGlJnqGp2R
	xAWt1SFCC+EVc1RgQT9o2zqXzh47aAg4nGGjDa4VAgN4uQaH70dgvHrGKZXy+NrvSx2RsK4z+gx
	aEzrbkzYljueUy8dRhjq8e6+JDEu2BZ37AudvVFx+UDek9gk7r4NLW+zK0Glkokwjy0d3nbu0Ua
	QiOOtM9NkZGX25++dICLTZxm9AkEgzkUi6uIpyyrCnT4+w4jBqWp5iw==
X-Google-Smtp-Source: AGHT+IFPlR5J0y/lc2XUcE6O1X+JtlZJeu/GYYDJksj4es7AGQByzJg+EaWCHdJkoi6q7phUr464xA==
X-Received: by 2002:a05:6512:39d4:b0:57e:7040:9c77 with SMTP id 2adb3069b0e04-58cbba0232bmr5051448e87.38.1759826027136;
        Tue, 07 Oct 2025 01:33:47 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112480fsm5865665e87.21.2025.10.07.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:33:45 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:33:42 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 05/13] dt-bindings: leds: bd72720: Add BD72720
Message-ID: <52a4df1a12f6b480150187d956d0fcd57fe626d1.1759824376.git.mazziesaccount@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hl5GOwGd5SzFL3hD"
Content-Disposition: inline
In-Reply-To: <cover.1759824376.git.mazziesaccount@gmail.com>


--Hl5GOwGd5SzFL3hD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD72720 documentation to the binding documents.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---

NOTE: The Linux LED driver does currently have: values
bd72720-grnled and bd72720-ambled for the rohm,led-compatible. These are
handled identically to the existing bd71828-grnled and bd71828-ambled
and should be removed from the driver. Thus they are not documented in
the binding document.

Furthermore, the BD72720 Linux driver does not use the compatible property
=66rom the LED node. The Linux driver is load and probed based on the PMIC
compatible in the MFD node. Thus no compatible string for the BD72720
LED node is added.
---
 .../devicetree/bindings/leds/rohm,bd71828-leds.yaml        | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml =
b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
index b7a3ef76cbf4..64cc40523e3d 100644
--- a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
@@ -10,11 +10,12 @@ maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
-  This module is part of the ROHM BD71828 MFD device. For more details
-  see Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml.
+  This module is part of the ROHM BD71828 and BD72720 MFD device. For more
+  details see Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+  and Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
=20
   The LED controller is represented as a sub-node of the PMIC node on the =
device
-  tree.
+  tree. This should be located under "leds" - node in PMIC node.
=20
   The device has two LED outputs referred as GRNLED and AMBLED in data-she=
et.
=20
--=20
2.51.0


--Hl5GOwGd5SzFL3hD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjk0GYACgkQeFA3/03a
ocWo9ggAj4GBq9go42smGGQBwidPKeFC80081lry80AjjqdeBzWn8ydINnkvdFVU
OboKgpob0WwNIuyoripCr55U0emX7Pdg/SN9pMPanh2oWvN1A3dZLfPW07smIpfC
jv0WPOIeBqCOfjNRbriaGHx3mGlfjcYEJrt4TMb8JlHJpvYRMDjNzDoGI3oUGEgR
lqnXCPRgb76A+OT1Gnx9zDwm8p2PpVpOnutdlxQ3JtLKpH2XjKUqQM9RhOqJ7hme
ElMvS16kznuAMzBGKD5ByXcYOlFaQlg2d8IMcnUM7W9PmkVKEzoeqfE4XHZN8ljy
RW+XE1gvB9Lc2j88vgeXM9rMxGO0jw==
=CW2a
-----END PGP SIGNATURE-----

--Hl5GOwGd5SzFL3hD--

