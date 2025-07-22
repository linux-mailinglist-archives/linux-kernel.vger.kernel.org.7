Return-Path: <linux-kernel+bounces-741631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADBB0E6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044A0173A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841E28983F;
	Tue, 22 Jul 2025 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bEtlGeG/"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696328507E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225676; cv=none; b=CaQjFwlcfYAyUFUvofSoHLhcPrxA8mVktXAJNfESpzI03eYZ6FeusM/BssAebhV7nNcx4w++j2VrRj6vnHYtnL/8i1Zje+l7qVUVxwBWnkM2/W/ZAWvAeFNmWqzA+mIIdNl/IXPX2f0BRbADHum7t3znY2rKOO/pTk6XCcnX2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225676; c=relaxed/simple;
	bh=vnQY+YQQPXrlIFRmW4z5+m30scb21pBdAR6BMa6nFmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UZq22ozQV6xAoqNOf9mQ1XlGRhyHSE3HNLExUg/Fg0xY34FkgIydIFGt22nB8VfsVd6fD675V/cHhHU6q/90E0biI04lRNGr1IxClol9VsrqiGxKStay78ORoVzVVw7PlemMinfTkY/HR3WVi3zZzH3xD2+6yXVlSemAxcznSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bEtlGeG/; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-41b8e837427so1698852b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753225672; x=1753830472; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Srk0cxwRCrhhN4WaZxrwTDDepZPN1c8513XKhcFSioA=;
        b=bEtlGeG/L0OnXcuYlXTuLGgvT+ztGXIlLJqI1XBmnoOmS0xnvU7fK2JvV/8KaE62pW
         tIiO5F84D1eTu9kR3TEXggg8vC+gnOA1/ezH+JJVPq9gf3ZqVihl/n/i4vu9W4wNplec
         wI/ATEM27AcPtkw+1kabyvVfsNF4yFEmfc+7hN6tYjmAwaJwLhYpoRUAVINA/TwF1W7c
         HEz6aHllGBStgV76htBGDrPQvw9dV4KqnmGwd00WD7MOm3l/COXX3is3kbk+gtQQB/4l
         5eQLJTy7qEuWxNJCn4fOkckQ5Lw+n+i8VBTt6bc58BvkSdYBQJlTOfZ56rERf6RoV+nI
         uuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753225672; x=1753830472;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Srk0cxwRCrhhN4WaZxrwTDDepZPN1c8513XKhcFSioA=;
        b=itdXge+2/MgKUiFaeWixD92GDrUnD5yzs5opkMgjdd204Hb5NX59N7PczfvEvpr51w
         PJ3Lsba9Y0kpNFgavubVRJqblEo/oQdhSM1JTOM2eSExOS2gdy6/UJlNSdKKjPnW05Yg
         xXczxFz0w9Uf4J7/90mP6qdg5/cPAIwunKEIneBJnij74kx0fbFsboKYiIye9YyOr1Ke
         uQxk2fgYgQFyZm4agcEUw7xDt7Rlh+sMOk+oRvYbfK2mbqOwTwDQtCmKgpOzFO3zH20q
         Afv2McozHyzn4DrF8flMYhB9vXAHKPCyp3JO++X5ROA37x9IT6FbM0hPM+JSTdT6SEg3
         1kQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFEWOE5w8ymnLa2lm3Wad7lCKOfYQL+UPeVdDD5RQ4Yhaxe9HCK7wCr48p6yn9sVE88WDPF9+PiCFTJhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXpmEPQHIpKm8ZsQCUekxHGPOrQ3GNCyxbuVs9647YwQ/Jl6Z
	bF3PbPnwPcqMUcXfG09Gn4kG/Va+sesmFZyYrV90519CkZXd4za6CzQF2Mg+7LohcHE=
X-Gm-Gg: ASbGnctAI8gqykLxKLwjN3hwTgU3RCp0RpcKu1Wq8F+71KO5z+4bmPrIhoA6m1UBMkF
	rzDr/UNMCZq0WcgJ9WuNx9rYosmYN9Mpk+A+etkH8cf/BhqpHGVhV0e1K6JG8/zb1/lCO40D52D
	QCLAfPadKGp3V5suKQ+jD+O6V2xDvlbdS4a8BqY7UyzuHI0oeDsqHmUd2y06ImYsflL9Q20RjOo
	4Doll7BttfOn/O9kohbwe69r5T/fWloADTpw5/JV8oM7rhIu1hDmFBj1PwEsnW+OIRL79M7e73n
	KjppAryRBmt1nPeAd+VoyFZVF+j2OCVChYkikXg+6uIynjrUpL5bOiF3OjNvTqUMwKb8dhsvRgB
	iNgpcMUJ0pHNc61qQ8xwnn1iXSKY=
X-Google-Smtp-Source: AGHT+IHNmGgyMCcq9wlm1R+OxSVpkwsi4kGsTTyqZt/p7EnCu1zfojNaekZE1Q/0shAygO0mmMS/RA==
X-Received: by 2002:a05:6808:398a:b0:40b:3816:6637 with SMTP id 5614622812f47-426c6049210mr914401b6e.24.1753225672438;
        Tue, 22 Jul 2025 16:07:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c22a3sm3079339b6e.8.2025.07.22.16.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 16:07:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 18:07:44 -0500
Subject: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAL8ZgGgC/x2N0QrCMAwAf2Xk2UCN1Km/IiK1S10eTEszpGPs3
 y0+Hhx3GxhXYYPbsEHlr5hk7XA8DBDnoG9GmToDOfJuJEKRjKXmJh9ZVpzb1dEpYpKGFoM+l7U
 wsk4SVNkML+FF55CcT6OHHi2Vu/sf3h/7/gPxcmZWgAAAAA==
X-Change-ID: 20250722-iio-proximity-hx9023c-fix-scan_type-endianness-8ab26af05f75
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Yasin Lee <yasin.lee.x@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=vnQY+YQQPXrlIFRmW4z5+m30scb21pBdAR6BMa6nFmk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogBnBEldK5kMGWTrAU81u03j7aIo9SUftcSOXy
 Aj6VOtYZXuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaIAZwQAKCRDCzCAB/wGP
 wGOJCACfOYG3GYS15KrvaPsdIUsr2e72AVwiKbuHBgnrOVkN5gU0UTwlhxD85OP/iGYLzobi5kw
 VfxfPLw/Syv2vu5GdOIbdFMC8d7KIkQSW6bvlc3nr80fw2HK/Dx+lQEsM6gRy1bS+RSPzFy8D+X
 6AbqewxJ2x48YAr6WGdwLNQAngqJhFbaDdWbNSMQReo3Sju8uuc7oz4lTCTWZjmSCaJt4zRs8KB
 zFJrkWvxpg+8ThXY8pOXOknO2eoU275HB/JgFzCNvIJcgW/QsRVdsTqhCx8B73gilSFcKgfai2P
 xfUPKoZWMNu4IMNmERt6uyz8pLP0Oc2eZPfnGP+zHsCwwnWq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the scan_type endianness from IIO_BE to IIO_LE. This matches
the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
the data before pushing it to the IIO buffer.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/hx9023s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 33781c3147286fb3e2f022201ccf7e908d0b6b12..8e5748a5f37a7b6674acc1604710394326818204 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -251,7 +251,7 @@ static const struct iio_event_spec hx9023s_events[] = {
 		.sign = 's',					\
 		.realbits = 16,					\
 		.storagebits = 16,				\
-		.endianness = IIO_BE,				\
+		.endianness = IIO_LE,				\
 	},							\
 }
 

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250722-iio-proximity-hx9023c-fix-scan_type-endianness-8ab26af05f75

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


