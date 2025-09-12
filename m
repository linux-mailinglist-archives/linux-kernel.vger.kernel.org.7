Return-Path: <linux-kernel+bounces-814639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4C2B556CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387455C1756
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06833EB0D;
	Fri, 12 Sep 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fh9xv9Qh"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B83375AB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704216; cv=none; b=T7u2myKLOxlJO9Z5HWwTpkp7VRuxrehO8j+xvjX/TyERRIY9bnHyzB+QvIXmelQQbUs6wnGJiZPAtifGicfVDaLF1PDBjRVuEjQyyCqsHvPtNrjm89DdThSyCrFB4DqqMlIcBWb+kFqiyf1TBWRUDboBYoglZbF3tcoM/KMs2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704216; c=relaxed/simple;
	bh=22rZRQwccdDXCdWucL0md8nKZ5xUlhtkQsl5aauAsOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABgCsKw98CdXmEEQFL88iyGKbN+/ZNb1OyrxHGzq186HhXY/gs98f5sNHn4HLYcAbcXccDRXQjVl/q/CAF77ri6ZFTluwh2+HJC9VOKndHJn3X6myZA58OtzIORcYhR+OloD87rIw3p4pdft/H89kkHs3rkV2R7l6hZmcpRurB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fh9xv9Qh; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccebab736so1854278fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757704213; x=1758309013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdlmWREl3KGVca0VuH2Pgk1lTP5tsygacI/dk5FYqvU=;
        b=Fh9xv9QhDUtcPb0v2qovXrMRPKHInIIEbWfThs0u6NVMgo//LKC2JM3gYeLq8HUVyD
         roVGjQdN7xx9nQyZD4Dj1ACdrt0HsQ1KqMPSUHtv1wUwlxskrruEg6qBOVXO+5YJQYcU
         LOq4uJfzHdn6DXJD7CSJrakY9G2nDWGRGqCasyXBYn9ez8dbh3gmOJotaGseOAFD9e6N
         TV9aXINt8VOX4hh+R81gyI6UcyxgIFO6h/mX/gNuH9qUDoABRG9FF1fmCMO3bJsicuJV
         RGI+cI6GZn6OF2J2swDUikPjRbYnB6E/vc474M2O8bSBjfjuhX15HvDTgcHIbnaREqWt
         UDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704213; x=1758309013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdlmWREl3KGVca0VuH2Pgk1lTP5tsygacI/dk5FYqvU=;
        b=MPemRehoTHJcZjwtFYgAsev8oJonel/oHVh7Ggh6UgZPfME8i/v+VckV/ajeNgQB3U
         zgKLumTdR1sBwULQcy42OedYE7np+wYMVQY7Abc7tm/d23CFqwTiSRQIqOu48ySsNEp+
         ed8I75qRo+vvStekDMU0MT1a+xACF/J3KdFWCHONCPKrRYCP0CQsexY9QmUtlh8RBoaV
         FF/5d7EvYfhtnHvx+apB04W0ssj6VbISJiXRnXIsLmmVRPON6hxeShyFLVHtoqkN+W1d
         gG51XNupkPFkedsAgv6ndS/s4e6YwId3RyJZ/0Ku5SdYeskIMqHSRkDckp0NDTGVzdAu
         4j7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXclOQaitRZP+EdgKJdJhqVmJyn7UXtVXuShs8PbVJYf05dYfx2T7jLdy8FHpvR4omK3RbBAOWrd17MPVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFunTLlxvJYruLS5kKDtssd6PN5IXKDft0aRX7lbTWR1fY2bQZ
	HunS4/N8TPeeQUig8Mwtl43n5nyhG1SxeQTg0BhJE1wBXXoZwv0rqSvKunOoh1Xjvhk=
X-Gm-Gg: ASbGnctTBAVNaz3MDYd8+fqUsX+So+eCprp6fIdWgHMrcvFTfI6mRKCibSillV9eLRt
	+VeuYxhwTtt+rQz+t9gJN0rffIUKUWxfluc87gpnxqFyXqnrZwZ0v6LPsGEOfb00f7t/jbX0xBr
	eQTnjZP9uS3SH0A8j5nFWjsefWjGTIG4LfaGOHr8Qiu6axfA8xVn/tJ/dBRWWHhw3E3W2zB10CM
	6jawkbSYgbIxqEh70DbeTflIuf4XBWRkqsQ3t2AvSx+WTMrSPKyjD31oYubzhdNtsVVCQVcbADl
	rmQMTHjCMPYweFniNokEoc0P3SoTrDyi44BqhQX0uh/Jb9T3wDKHQyD9VUmSdKrcN2MIDMr/Ktk
	RXNwhwKGs7h/gs0g4XXiwwXlGSLnS
X-Google-Smtp-Source: AGHT+IGfyzjSKeBPxKUtCFxXgNXOtuPFBWMr9b01M1myKuXzLh1KXZkhphCsxl5slJPnH3wGEAUdnA==
X-Received: by 2002:a05:6870:c085:b0:30b:ba5e:3472 with SMTP id 586e51a60fabf-32e552aa8bfmr1913830fac.12.1757704213337;
        Fri, 12 Sep 2025 12:10:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm1172564a34.15.2025.09.12.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:10:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 14:09:33 -0500
Subject: [PATCH v2 4/4] iio: ABI: add filter types for ad7173
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-iio-adc-ad7137-add-filter-support-v2-4-bd32dfa3d761@baylibre.com>
References: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
In-Reply-To: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=22rZRQwccdDXCdWucL0md8nKZ5xUlhtkQsl5aauAsOM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxHAKH1jnud58OUFIrZj3B2cZPTbYotYbHhZ9Y
 SFIDafYS8iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRwCgAKCRDCzCAB/wGP
 wC5BB/0drW3DCMb2URgt3eb7DLU10MmceSqnl1yxf0jQJr9fVffggOZinYw2vuZeSWNSY5jRyHB
 vVq+rWfRDxLt5o952KzlF3V7f022WCVbpGxvm4AW9xBj4QRRJ2JQ1nEuI4TJzUB3r75YVNg9Mi4
 HzB4ac+qViJnsBaoxup+TGO8mKnMUpc8A4YzpYei4kqOsfkP/M7sGSsdj9/reNTfbPoGTF4E/Mr
 byq3aedZducLSI+cw0zb5kwcErC7SjJp+PqxTlVrPgbMoLPQuA1nCBsHYwaqdD6JXY+n0x00EGW
 6YAfXMKt7sgPd4hYhUtQr+ns+cX19HV/4OlDYUA4I4dd2s+w
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new filter types used in the ad7173 driver to the IIO ABI
documentation. These chips have a few filter types that haven't been
seen before in other drivers.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b19249743398b1ff0b538b03ced0340b..845dd20aab78e5c7afbeb26ba04c295a28aaafa2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2296,6 +2296,11 @@ Description:
 		  performance
 		* "sinc5+avg" - Sinc5 + averaging by 4.
 		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
+		* "sinc5+sinc1" - Sinc5 + Sinc1.
+		* "sinc5+sinc1+pf1" - Sinc5 + Sinc1 + device specific Post Filter 1.
+		* "sinc5+sinc1+pf2" - Sinc5 + Sinc1 + device specific Post Filter 2.
+		* "sinc5+sinc1+pf3" - Sinc5 + Sinc1 + device specific Post Filter 3.
+		* "sinc5+sinc1+pf4" - Sinc5 + Sinc1 + device specific Post Filter 4.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
 

-- 
2.43.0


