Return-Path: <linux-kernel+bounces-848157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F4BCCC25
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77F7A4FD41D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A52EFD80;
	Fri, 10 Oct 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ptSE5Hjz"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13842EF676
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095438; cv=none; b=qu3uIMOPuc+IqLrpiTQok3cfbgvz1XEbAlBNXX1fZXQh1gtlyDVl0H8Q0iGjAxrl5IjXX9TtniIBTAHafU6JPzsj18XtsOcPV10CC6Isdka3GaEWoKxuwXASAAeAFmTN8NoBvD3b4LhPHCNU1zubQXc0j4ZTmyA2yOFVdAjkFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095438; c=relaxed/simple;
	bh=aq/4LlBtdDV9fwTGsuaPOpu5GJBcvTjlliJW466UN/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pn7tpZrnbIeBxj6v6P1XSZMJfW6i6TOy8Nd+bdw3GXdDsUtqPNYxI1SdbJyidr3U9o127r1s1oePD2aeKYQH/GO5DXIuBNccizHs+5qtYTzIzWYLhrpuiPGhrDXy/8xHjGoXPBT+YHZJ1QyrxRWZ5BfBAbBONyUyR8zpJEP1oc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ptSE5Hjz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deaef9so352684666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095434; x=1760700234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbHU47lVJvPoAqNYQLf5z1X0/coxYDZLmDD+Zs19Aq0=;
        b=ptSE5Hjzhl7uTbavQpg6W3FOgMvpAYNLiJOawlMh51IedLTJ2OAYYf6N4oWs6DPoTi
         lsJa5N94AhYwvvu/JqjENZ4Vu5os6cqtcHuH+pqNos9GrNXkriYpK8+m+4ZVHxSBLwiM
         9LI3l8X08GfNwSQbd1MRPnS0heorG1q9wK45OxzahggJMig7etSJA2iAOuVjTSOyyK9g
         AyLBYZZKYo9FdesyyLeskUR0v2060gXg0meG2adAJNZ39i8ghI2Cdzbq/p3gtnjJ2nNJ
         wbqaGyM98qlLbtv6xvnGjSp7mzP2ExrG7wTfLzlCxL2hKtcTwkd8rtHb2q6WVeRhQZE3
         Af4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095434; x=1760700234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbHU47lVJvPoAqNYQLf5z1X0/coxYDZLmDD+Zs19Aq0=;
        b=FztrR2nqYL0w++1FT3cQZMDvD7xTS1X3RV0xG71eDYGYpxL2cQf9k7hFdALhPhGeKm
         8YpWKGaTQm4WzBY3pIS+CHc3up1g4vCrpA95jr1lw1sHf2DjFx9zFwUv7NYFjx31hxRN
         1ORx+qKKRpmp2uE4d2UjhP5H3t/oOojdVs397hbrArANFhBX9NXtrmcaXYp5F67sp42h
         Zm6CGZS2tQY9EYyPleHOJH8rkfLFIimYLqleqa/itRuXj1qAYVNniMa/1F4YG+guR+ZX
         K9ZkuielXVrdMU8CWxRZb/68CmP5tlmzX62DRyti7aybQPZhs97fVc6Yr3GJYxYNh/zX
         9Qyg==
X-Forwarded-Encrypted: i=1; AJvYcCVSsr0XRZwjylrVxoarLxL5LA56LGxmVkUxEFCfctnwBi4/n6LdMWIs2XcRi6egw6fkyJzXmEgr3Gg8pDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4IzuT9B1YH6EpzhHIxMDzNvMX6iYTEabNq0jWrBxmVNjaW8s
	QO3tHZdEl0RUNNtAtEAw9b8tZza+pckFiYPyc2bI9vEOtVPt5KQOJdRFyCUD9YVpOpI=
X-Gm-Gg: ASbGncs9wPDXatWbMHcfTjihXW/zGNmmvW55Vuvo+rPiHvxyxXp4GFn5bDUQVznvfpf
	f/w9K5b29SEX5PwvMrYuBOz9vxl+Vi8pPUaI0e66gIWNL9XbD0NykIQ9XlNFyR455iBqHhfvD39
	yUU4hzj6b0JHag0QFUR4/dBdeGBd+nyBhC2xC55VtzGejUwvTwnQmnb1n2G3cxPtT5YEU1nK0qp
	3YqJMlbdBCvghW1e7Arv0T+V8XWKUoXiquySue+hJd31zGWAo+RBzW7Tj2Z1cYh2qpkdQTcWELh
	lsF2//QaEJ47r3kWtMPgIyNUp+nBGUnGfdpxL6l4dcIDi9cu9YpGQI23YbJaKZ28WgVLIoKwpMW
	RKH0GaPvdqi5Ii7ZNJtU4e2OuObCoiAwdbcjxRVSQxakQIAX6U3JujZivReufW0OE2OailDypm0
	2cu2WjB3nF+BjwHdaHKBY=
X-Google-Smtp-Source: AGHT+IEGGOcXMfbfok1PgzreNouwnXwnOxKHke/yHbjyLVTMxF0ZeD3AzIE5Lo/WXZ+3jpLEgrXUlQ==
X-Received: by 2002:a17:907:7f0e:b0:b48:44bc:44f2 with SMTP id a640c23a62f3a-b50ac8e52b0mr1079525366b.43.1760095433928;
        Fri, 10 Oct 2025 04:23:53 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:53 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Oct 2025 13:22:02 +0200
Subject: [PATCH RFC 4/6] thermal/drivers/generic-adc: Allow probe without
 TZ registration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-bat-temp-adc-v1-4-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=1291;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aq/4LlBtdDV9fwTGsuaPOpu5GJBcvTjlliJW466UN/o=;
 b=g8H90MmiVQbUf34k7FO9FschEuUpZ8+riafTdgCUcqiIfMwO8Gl+ddsWuyUlJKZ5GMtv0OT0Y
 CC07fjXLbWRAMXyYnitoWqrLXpblN5+yM5fIh5ZBkqstAtSmldwJ1G7
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

If the devicetree node is not referenced in a zone under /thermal-zones,
devm_thermal_of_zone_register will fail with -ENODEV.

Since the driver is now also registering as an IIO device, allow the
probe to continue without the thermal zone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 14aef682e0fb..d31533927be6 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -183,14 +183,14 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
-		return ret;
-	}
+		if (ret == -EPROBE_DEFER)
+			return ret;
 
-	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+		dev_info(dev, "Thermal zone sensor register failed: %d\n",
+			 ret);
+	} else {
+		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+	}
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)

-- 
2.51.0


