Return-Path: <linux-kernel+bounces-871431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71236C0D3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8B1D4F7239
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242BA2FD660;
	Mon, 27 Oct 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODS30pIt"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5B22A4CC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565515; cv=none; b=CSiH3BqfRHcAXegiBDVpbRhnTuzOVbbezUEzYIh/7LBhq72VdRHQAJnEJ77cCP5r4jI2cYr4iv5wgbUfXOWBTp+pL0I87WjsXU9nZUCJvH5Sp1DIciSZyLJquVCJwLns3omFwv3kvR9D427Z/kpspaPjtv60QIxK3FDISBrRvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565515; c=relaxed/simple;
	bh=IjpBU42ntX9XaYmyRucOHQzBqWEweHkDi9vYXmN8LMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYi/oMIK9iu3HmvxvPK1soVjgi8eaXvJLGEoYZoqAecry0errlODFEK9/nq8CVEWubyQVFJF7UmRjMaPpmiOk8iLr5y6nwfSYFFHQDadd+E4JZUgqGcKyk8kGnwoLmSUg1Xf5CJiauZ4W+jWco4E/SQ0JAT84C76PR0dXb2kgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODS30pIt; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-378d50e1c77so41149401fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565510; x=1762170310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3bvBuQH05UYV7qQeFG6dlKCPrhvCySjKkIncy7Gx44=;
        b=ODS30pItJia4v+EkFJTKwrB+i3DItT+o2TLpFP3zZnYPf30k+e3X/2CFVI3LZPYyMt
         /A3bOyjc+akTrbysEXVFYcA3GtLMHmOoCJfM/a65nt4ywNaerdGGp7ig883OMS7C+Rhw
         QTODaKXbrQhd9TQAhM/W0e4CJsp9wR2V7eHqemIgavolDfE54e43gllAbJ8UfIeis93x
         sTQGtT3tgwYUXWeYarCaWM6ZpfJ/Mjgv4jDsdDHvcntuB09SG2FdKVhnHVeswuhVyQOq
         SXxsSy5BwY5kw/DX1PNL/b/tJHKFWMYWPgwYMpI//dqEkWZkM3pzEe2QOam+okXFSWnf
         eYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565510; x=1762170310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3bvBuQH05UYV7qQeFG6dlKCPrhvCySjKkIncy7Gx44=;
        b=MQpnP0WlfcwWWw14vwlQqXn/FzhnSTToyftm6O1Igq8kQVriHJkEI9EAwFg23Khb/s
         EOIC52Tr4rHbJAgNs3aBP+2kwXe2qvzUug/8UIIPSVMQWB/5mViJp+mJCdDjgvkItle1
         zgrUq97d7itj/7c9ad0tsgRysyqi553Bpy6hkOydlLfFNJlwNJ4JquBNKQNInfCrN5YM
         mpzdwSeEfNqaNTLdkg4ogldTJjlCC+q6vB6sKvm8U/V04Ggvx6x8JXk1FhgUDF8TAk6C
         ncX/EypSpevlvoVHLfMdKPn8OTQP2nnAlyt8uzN42Mxch/vfiEZUYwLDcOnDxCOFfWxe
         yFPA==
X-Forwarded-Encrypted: i=1; AJvYcCWy76gxOZRjyelSPZdZ5+Dgj4sDX7HLd7UM+XZXseIQseIiaqdMvB6j7sWS5ytnV71O659ES3jC3rk2W4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPfkoIdSZ0rikyKWWJ8fMJ3pbmLj8U2KP5Yus2+80NCi55o8U
	eAMCFbv3yAkIGO0VIWQDmbiQ7w8ozCrN3Qzhkj7kO4/GYSgWt0XnCOtz
X-Gm-Gg: ASbGncspanXC/QF/joha3AQnCBih8tCxPax1TNrjz7qXq9fkz4669/4edMiEiS1eVCU
	5X7k6hiJWDhLapT/Xq/mWH0vbuDeX+Lgf5Yg1gcQSkSoqblW/mWX0X8KFgw2mXl1EQVU4XoDR8L
	gKr5puVL6Z80t+dTon24Gh8QPAxQr5KX+ivECCpHBh3KwDZJlthdLxR6zUWxiCeFQb7/Fo6JbaK
	nFUIwcG71b34h32PbU04H0Ie/T4SQ2cv28jN0/vhDYp8Wam2gLgbv6zz5eF6DyesV892vmUuQUE
	cGMR0lY9tTyu9tMMkRvhmUGMePIL8jCS4rNXkKlqIdoxv7e1GRtZ1EM4f7KuQBi7qM/O1Qni91b
	TQkzmVSuoVrzphN4QrtHS0gOAd+i3M2I9pqkLBcSbQx8iWg9j6KIpKaz1L5zFEkmiM6yMHRg7EY
	YjnBefvrQ=
X-Google-Smtp-Source: AGHT+IG040q7cqWV71VuTHnX5coaOHS5RsTVRj/7BqmGOTBNKnaNhaPjcm0wBLEa4smz5wwn4wiKuQ==
X-Received: by 2002:a05:6512:4022:b0:592:f5a4:ece6 with SMTP id 2adb3069b0e04-592f5a4f458mr5888071e87.14.1761565510170;
        Mon, 27 Oct 2025 04:45:10 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5fc75sm2207808e87.59.2025.10.27.04.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:45:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:45:05 +0200
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 02/15] dt-bindings: Add trickle-charge upper limit
Message-ID: <b13b733e7e0fba05652f49f727412fed9e0ceb02.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0aGnDoHzYmHLbrXY"
Content-Disposition: inline
In-Reply-To: <cover.1761564043.git.mazziesaccount@gmail.com>


--0aGnDoHzYmHLbrXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the chargers for lithium-ion batteries use a trickle-charging as
a first charging phase for very empty batteries, to "wake-up" the battery.
Trickle-charging is a low current, constant current phase. After the
voltage of the very empty battery has reached an upper limit for
trickle charging, the pre-charge phase is started with a higher current.

Allow defining the upper limit for trickle charging voltage, after which
the charging should be changed to the pre-charging.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
Revision history:
 RFCv1 =3D>:
 - No changes
---
 Documentation/devicetree/bindings/power/supply/battery.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index 491488e7b970..66bed24b3dee 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -66,6 +66,9 @@ properties:
   trickle-charge-current-microamp:
     description: current for trickle-charge phase
=20
+  tricklecharge-upper-limit-microvolt:
+    description: limit when to change to precharge from trickle charge
+
   precharge-current-microamp:
     description: current for pre-charge phase
=20
--=20
2.51.0


--0aGnDoHzYmHLbrXY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/W0EACgkQeFA3/03a
ocVHlwf/WmMG+VHvvbW2L2DZtJpJaw0EfC6PYPUNs9yBLXDr+CfL0pRslVccxRKB
Jmbbt/J+CQ5jhDcPysdGvd4gvl2XqZlNW74w9zBpGGeoAXN3RepiLjwPu07tbi3q
KsMyf0UBeVGeZMD89Z0iyf+i9uAPjIbL7jsJ67Im5cg7H5xWctMEjPmQSAYOZI3n
HLbSqG7+HsWQN/9V3fqNVE4g3O7gipBY8F0ZZQzdZcU0EEimtnwhpyUz1VHnQVIQ
R9MRt7+1ynYb/Hr3y/3yUjLfNmwvD5atDA2znKphM6acJ/LgYTJA4sg2Nvco36Xw
A5pNMofVjUgxD7NYCslLgrj9UeRj+Q==
=OPBq
-----END PGP SIGNATURE-----

--0aGnDoHzYmHLbrXY--

