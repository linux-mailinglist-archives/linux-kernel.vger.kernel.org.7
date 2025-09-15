Return-Path: <linux-kernel+bounces-817840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A2B58751
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E77AF557
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A852C0F7F;
	Mon, 15 Sep 2025 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaMBmQyy"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2929D260
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974621; cv=none; b=eP6HcGqto98JcQgBC0m6f5I8NVN8dOqalCl6vtWIn7XxM6A/8VoMWLnmvyLPhUn9GpsGu3L/QOKs2HJZxczGko0QqD3heTDG7jpjd0OsRJgTSqOKrVItlaYYWi0bhri2hMF7LUPWv6i/HE8RaOJVlEqjuR0CuM0AvfKZVgs42dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974621; c=relaxed/simple;
	bh=aEm/Hz7dGLKXm+uX1tg9XZs7MReffamnZd9d19QAqvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbWZSL1LI7yGPc4WwCR94nkjLzhN0kNqsRefGhqvcuWq12bXpBDIWsawwyBq62k2clMcEPoO2CVHncEHxBEe6JaIml8IAqxOOWZcukayColh5gu0aw8KnHmbRRMW2GLlifhW2rQnZkErbO73M97AQyfMkc/yrMd9/LH7MkT23Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaMBmQyy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so3068236a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757974619; x=1758579419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0EZSn+IjTlYfsb20ePSkLkAC/0KOeBJ5P5//u/FW/c=;
        b=XaMBmQyyjHDUUjtwm0Un5xtDkRV0QbwGlWYMMMUtIpz7vCaPCRigPiGUYtO2f9QNNr
         HxBml4nxgMVAjl/PbZuvoUlUxqxgS3QhRZX4B9gdIRAF8PfQo3tdCx5ygyKvF2OavWmj
         CSnba8rEbPB37ImHbDEPM2DZmW0KCzXq5phWM9f9wrG2bvbSjE7DlNcyCB6dsTBDDceE
         cq1c/URqqjUuQhvCbyPQcm4Xx9fSoo2HLmwU5wE3/m2Oid5qkmfsjVpV8VNcvIIogzRm
         gxBac6dY/XBYGoHYQTjpe6p0B9FNeim4Iw8LkpfNGIWeXIwWXteXadx+dxBt8l2aXYBd
         4K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974619; x=1758579419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0EZSn+IjTlYfsb20ePSkLkAC/0KOeBJ5P5//u/FW/c=;
        b=nxXEpi9wak5H2JwMOinH0G7RdGfQ1vsvpgz7h4xRIntCEkTGt0rkXNg4E0koOTR/Es
         Z7bxU4oxYNCstT06vnxbafusuhu3hWK88UBeavJAEKaeTsxKEnB8fWWdqua6SdbKOlWx
         N39ryFXjjnnWR0Q1qmYQo14yjJtcpCPHtjZmWTus+lII5XOVYWCTf90a3Ur9M//I4t9/
         z7NJx3Joo5Obk3bX72EDozEC6uwWHwPqyhjw5uurMYoZcQNEob3XhU9JV96MOODzG/gu
         DCwkzNxyXVtUj3fyAjcwdkgvu67kQFyX+vEf7CAst10iWtssQJsnQ9lTId8/Sr9re1JW
         xFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkTcQ0H4tLu4koLrPL3lc9kzDlIJujT/ZCmXw9DfxbhEEYpB2wRZ9tLczl7syf2dhR8sgzfrNfmiJjKG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+wl9uowNlcwsuqem8gERMdwjyUafViZnA+7xEUPsp/pPhQ+N
	HSv8r8AGedp/wQcKUjMw8NevMYP1d10CKBoiGDCKPH2FcingjML15pzY
X-Gm-Gg: ASbGncsRExPV/B9sygvBBxpNYs7R99P5qJhG7Fm7ZG1IzbvClt8OmsRRYWOjBP6AfkU
	8yJ2zY1r0ouPJfhvmF4ABksonGgcZEpgl/zhsWPAryjdDK83pXMMcphZgBriiigXANUhoraTP1T
	zC1z03wVWzdlmVOc0naHSdpYtsGUy3AYLY/5LEHROYlNRuuk/s7PF304QMSJSZM9dl8ABrS9FlG
	KJ3hUlk+zXNwKHWz6B3MfpaC3OHfheqtaSCGjO7TeEBYNJLU8zJwcvUU2d06rhLSIRIGMziE6oF
	uZrMz+NzKchYeEMNeSL6MNrM/97TUentXORWB17sOldXBUBjiJ0MSVg7+V+ayaiOSsMeQ+oUPoF
	CUclVfSHIm7zaE65bX8YPOA5XdAOr98K3yNJaNqL1BM6mEA==
X-Google-Smtp-Source: AGHT+IED7gyrnto+fW51wF3a9rAub6MC34GOv17/JZeQR5eEHSxj8vA0sE8eVX1bxsMfOXdefGr+JA==
X-Received: by 2002:a17:902:d488:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-261e1c01f2emr107392155ad.40.1757974619205;
        Mon, 15 Sep 2025 15:16:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:d43e:6485:d878:c0c4:abbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26711e5d42csm35215385ad.78.2025.09.15.15.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:16:58 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v11 3/3] iio: ABI: Add voltage mean raw attribute
Date: Mon, 15 Sep 2025 19:16:49 -0300
Message-Id: <a346e8b2f406eb14fcc9e1f3c4999de74413d650.1757971454.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757971454.git.marilene.agarcia@gmail.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing in_voltageY_mean_raw attribute for the average of voltage
measurements.

Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
---

When I use _mean_raw (IIO_CHAN_INFO_AVERAGE_RAW), I get a file called 
in_voltageY_mean_raw, so I added it to the documentation. 
Thanks.

 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 89b4740dcfa1..6dd67bd4e73d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -422,6 +422,7 @@ Description:
 		Scaled humidity measurement in milli percent.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_Y_mean_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_mean_raw
 KernelVersion:	3.5
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.34.1


