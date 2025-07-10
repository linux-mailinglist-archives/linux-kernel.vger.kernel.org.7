Return-Path: <linux-kernel+bounces-726577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C344B00EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916A03A1B53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180302D29A9;
	Thu, 10 Jul 2025 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jxS1aYsp"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F492C15BF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187244; cv=none; b=Idw4yoeYMjLgP5Kny6uwjEosods+4kiZJehPfqJK78MBsTpbxUUy/XLuBzKg/2Ss93vOoHsJJtmN5vg17iOfT7UDFYJFaQ3tLIGfcKNXHZmYXgcehZFgBCDPTXRmUKnQ9yuqgtPBwYoUKz8KKWGgO7k3ep4gHtGODY4gpGy72vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187244; c=relaxed/simple;
	bh=CCj9iOwvg6zzBiEjcAxAf7V65hcOnGTyWH1FdMb4jHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aa/8o3gS+QdXzLUfwv3st07HVoFq7yuOI1TniOzPKVj+FL4bkCtJ34lbMnnq4ddcefoW1rVSP0I88i0tAuLTgtxtcK8Y5y9spknHFHWXnI9uYNIa+R0DTBzyajZXSt3ZphTJEBiCWFnlaUELJnsUrA084cbvfpVF2Tf06Sfntsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jxS1aYsp; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60f0a92391bso799715eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187242; x=1752792042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2xSpg91xD37d6BWc4wU5FsBfQPR8cbxm4QoC+z5aRA=;
        b=jxS1aYsptr+OUi+Opa749Fn2g+cJ5CEbG8j4YbHQd9z2oNOmhlTF9VffOEkP6h9Hf/
         jIbmbgYCRgYySQjIlM7WWc2P0r/wMCZDBNALvvXbNiYxUD3W4EnqbSmik6EWwlUFgD5M
         RMTSRBG+nSAClLHm1MzTqgIqOsnpgLAzKTbDwtbtVkyhYiRwtqz7Viel/ImVKmpVz1Qe
         GDI8klexStBawVBlCo142uSqpxOcHJN9XttNOKtzCsqRdMve+kIpfnH301+0Lh5rLOSL
         zewaEb7nB1YcV4JBlKPY8ZVi/LbcxZ/8mmYZJygJS0lHX2y62JFsFFWz2Xe5d+FFHoJX
         5FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187242; x=1752792042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2xSpg91xD37d6BWc4wU5FsBfQPR8cbxm4QoC+z5aRA=;
        b=qDuTWq6KJG14gGs55vHOurk5sZF1yOpwWJ89JhFWFLl4dAMw3QqKsXIowNo+h4HqtH
         EiLahii0IxTha9lJEl98MbTgGS9AIgw5ka1kcmkxC5v54lyrKz2ZFMWWJJhEOMyGF6xA
         ZMw9WjjzHvhK/P0Rxot68Npis7IhOOT6/nhqKNhKKcNreE4Iew7zPkvysoaQDCs2TxMt
         AVdX4b8a64BsXFDvAm0WTHatZE+civyoHGJiVKzfL0abLEsYw58o2iD+C3UgIiPvemB7
         z2ZngEv5pwM1ZdBfVkTjLFyPWH2k36ElaHRAoe33HSRGLs8ke7YZQCTBtoqx2suEQqay
         ycVw==
X-Forwarded-Encrypted: i=1; AJvYcCWlFwLi8WvXNtSrIB0nBMCgbLFV0iAUv0UzjDk30RsHdKIBKrapDMBbKNhTMciY3guVLLygoaXuUVwUYXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bOdt6u9rGzgbc3ZG3RrPgajNjNND6pA6/zknIwNDWFuujuEh
	8sLVz5qxiGcFsRbnbMzyxgIF6lTk4Oz4VoBh1ZmiUTaOoX84quDtGXfQEKr4qQ65TpQ=
X-Gm-Gg: ASbGncszSVmYUX40z8U2ITmCNKtNlK0Y0ZCzlKrqeZwCdrD5q/Qxqd0sLNU1D5WKZwt
	vCCxkRRIy8nQwU7wby4+G4NfbF8R44ZaEzUpglE+l+lyuNKQIh1QfgIepbKRwp6tIsJhyfuuM1t
	Whg9/8coUvPDgCnz4iMF2OGR3EqhBNPUmV92+BX3F+WSgBkjAmX+T6P9GJ8EStHyLJ6FJuo1PRS
	tT5M7fLo9iGOxN6R/QdHbxeOMtjVQduw7JYThNwRFS4fS8ubCa5uXwAqsazMVpbSyg9ZXgz0wmY
	2shQdJ2n6gWOpAYysCuSoV4VbWiga2wGcB3Ryl9ldzy9ZFqlppTK9IqI88Vi5iSGTNtNDYMFXpv
	NGdkDJcgz1lWOGljdm+ZK6N/hTg==
X-Google-Smtp-Source: AGHT+IHJDQiMpjjkeqNdEuJu5mN4++lh2a4XmuyNidTzS9J7M+fjY820BsBEPCbiv8ZDDnnAsrB+NQ==
X-Received: by 2002:a05:6820:984:b0:611:a799:cb65 with SMTP id 006d021491bc7-613e5eee3e5mr686252eaf.2.1752187241855;
        Thu, 10 Jul 2025 15:40:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:39:54 -0500
Subject: [PATCH 5/5] iio: ABI: add filter types for ad7173
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-5-acffe401c4d2@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CCj9iOwvg6zzBiEjcAxAf7V65hcOnGTyWH1FdMb4jHw=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGhwQVmi7U4x7Z81Pd604/fp6tXpK5nHzaYBkLN7GNL2D8fA2
 okBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJocEFZAAoJEMLMIAH/AY/AoHEIAJz/
 ZbeF6gEdPUjASRNpVs40nlVt2BK9rtMsxEuaZz/sHASFwBGhP5kFmWGHmCu1kEvWinSHlnJ4sY4
 SSJqglMdg/zM7Vx5HAIO4VoJKFcIMlewpIlWNs3R3CPQu6ZuvEZXdM/DL9GK6sgZnPpTA5sPVtb
 KS6TSsQMSI28YbG5cWIQU6/fzi0kUt2vP8B0ZUD42V/PBLxM/glpM/LzqWj+aqISl4jKMoxkDXf
 TZvAM0ed8kTb4eA/DJEiZkwE/EmTRB4bxVM/xUT7xvGd+EhogjBdPfpwDmLeTawT95nene2QaNu
 czzRRg+j+4O2I9rHycRqyiIs0QkgMEQkYQIwrqo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new filter types used in the ad7173 driver to the IIO ABI
documentation. These chips have a few filter types that haven't been
seen before in other drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3a13596b6eb081483a1f45fb0c446d2ab3b4c708..05ecf0b551698d3c7bf2d225507a1e0ecc253c86 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2322,6 +2322,11 @@ Description:
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


