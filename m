Return-Path: <linux-kernel+bounces-869655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B30C086DA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5E14024E6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B11DB54C;
	Sat, 25 Oct 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr1KreK6"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30C1DB122
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351949; cv=none; b=HVVgW4Ca36joqaDGVOvnlP1E0MoxJxh2hVqXwv2XjVBFHvYw7jEa8s6j9Ia+Chj9o9aOXAJMEOqyf5/d26hOnlCNoWGrkMNpGqdhanotpGhMYO8bx3CnrQQD6CeMrwi+LHIR8MpqELt0jf35Mrl8X37NkCIwgE+DT85VvNum3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351949; c=relaxed/simple;
	bh=EBXsHgi+TPtnux5Mjfvq3s8Tobe6+wN+A1W9K6WofCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LV281+07quwFy8z5/SLmsJsNyj6FVCn8LHxEYeAKbRbZAO12peNHtb+ct0PbjXaeoO15YTjoPyfTdTn/U8C/4nSCDLRz7uYXR2ruvMs1U3nC8diEgb1Lo+80pmTjU2FU4MwjRo1tBQ43+Q7fqxxBennyuX4EYPIVXWDs+2k5WCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr1KreK6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso2434797a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761351947; x=1761956747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfRZW1u7QrD8wKs/E/qokjfPak76+Jqb1NI8oZKYmR8=;
        b=nr1KreK6axEXyVC73WTwFJTGtK33UrYo4xZYW/eqhFqFnUxcVxba/IEtJO+g1pEmIh
         ak3NIV1pVy+Yqz+osd1NxfvDcnqKTb2CFelydd2ET3xabHuRXLbAsNI07EPMt4bfpBkE
         2jkENDtCc7zlF4zMNqokX+l7Rt8UEke433ts1qKPTvYjHqHIC3lilN9WXJXvu1ahhF4s
         ZkN1SYR7BibKOhbK32kYuyuJ7HM7L+T7rrcDfj0FjKGstYwRO00mMYjT+RsWGCdIbTyR
         MUyeT6chfa/9b6AbQu6nyycgB89rCNNfSZ6vPMj31FVr2S4+vdm8hd7MCx3Tuylt9Ysx
         Va9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761351947; x=1761956747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfRZW1u7QrD8wKs/E/qokjfPak76+Jqb1NI8oZKYmR8=;
        b=mLRxhAqipe2lOnxSMUNpGvdR4uOkQKMKX9pAO6FaMZKqmRmzHRzOq1hDER8XgBIhhL
         6TNE5Buse+rwz399VQrfMhm44QVAktI8iFbqywyV1EzxRjcG7TYaZV9i/Zx/34ly2RzR
         NjPfAoiwMzS91EUL/+JxNJnKvi9AmGC9N4e6AlQ9LqAZVnsY0SNXK6NKK/vBkIKcIJcp
         SN/PmaEqrSclBjyDFzYqaK93JhGY7fgHrwdnqRmBuwzeEFv2s1sChQwA8X4qkt+KdXY7
         mmz0bfQbNJbjm6/GerfIarqqVMwl/pbDLlWZb7UR+ZlJsA3Mti8jEXbjckhR++k0ibfR
         jY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXg7FgHXCH6gvyFPYgVTsMwT3PXEJV2YxDl111/PyptibMvH+MzCgkqhj6Wa0LQ2eHDt69bTgibxw4LcrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIz9SF4c1JP+ZkNVo0C/S7NZjr5aZK7Kb2030SPkecfjQRmVaG
	+uNUO34ynJnHiyrN+RJWgIE8KTx6UsX2Bn7g6oz1ZfuVMCbPhHNAqvya
X-Gm-Gg: ASbGncsTAZ6axOqpwQO5rSDuLBKXZ3XBtj/LGIWQfqNB0UmdO0SUzcecLO8XtLZLcFd
	Bvkta+qqV4xTmfNcX1c3tgHvVL/S7E9fmLaoF6qMF1KNiSLOHRUPpI57LCbDSDsq9Jj3KrDk5XA
	+KrHITGrt/tqwLoX3KngtHXtHTPS43ZJFVt8aMXSBKAT2UvTE/+7AzBdd0ad4uIlMEzkOpmRS44
	nfweNRAnzkrJ+sedU1+0cIy+1yfyYWzzlje8ie9yMp7InMzcFD1dUpYRy6OuEVulwOcnb/dbIkD
	/3MyN0DeCICxLNLvSnaNCSGDQyejsbDyNDPxETIpe7r2dWbJE/GRMD7Rh4w7cWuqwVSwD4xCk5P
	bWBeR+8zV73J7Kxk4vlDgxJjlkBekefyfeW9YEHIVo+6hPKgJ2ppb1m3x40aG3T6HFX8g6FoxFj
	tujzmxlEdUnRtIUeK4sk8+mB4IosrhVMwNFdfbhTuPMNwqOjF2AWwJbT2zLkq7J/rKMxFKQ6uJb
	uiUC0bkcfQAXZK6J3wlDvh7D8n/tr/w0wMNkHyBQohQx1gMhBx9d+jCqSkGQr1H
X-Google-Smtp-Source: AGHT+IE7b7WlJg8PMfCez4BRWP01L89M03XHDqmXIAUdqR0o0INVIyz4n2FlGNeMHwcTEVAj8jvj0A==
X-Received: by 2002:a17:902:ce12:b0:267:a55a:8684 with SMTP id d9443c01a7336-290c9c93abbmr330781785ad.2.1761351947512;
        Fri, 24 Oct 2025 17:25:47 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3f4asm4728885ad.11.2025.10.24.17.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:25:47 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 25 Oct 2025 10:24:38 +1000
Subject: [PATCH v4 07/11] mfd: macsmc: Wire up Apple SMC hwmon subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-macsmc-subdevs-v4-7-374d5c9eba0e@gmail.com>
References: <20251025-macsmc-subdevs-v4-0-374d5c9eba0e@gmail.com>
In-Reply-To: <20251025-macsmc-subdevs-v4-0-374d5c9eba0e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=744;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=EBXsHgi+TPtnux5Mjfvq3s8Tobe6+wN+A1W9K6WofCg=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDBl/JM7tvHxyY2mQfvkOj2Ou1b+lL5wt2qeuPnvBRX51B
 rNbl1QLOyayMIhxMViKKbJsaBLymG3EdrNfpHIvzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKhjrGPEwMUpAFNdv5aR4VLggrKHBVUNC5VEVaVC98ZfZxOt6Jh45+IVmwlNsr23dRj+Z+7eV7D
 x+NRGVakE1ehjKc+n716bd2HBjQL/Jt/QqBk9XAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Add the SMC hwmon functionality to the mfd device

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 500395bb48da..51dd667d3b5f 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -46,6 +46,7 @@
 
 static const struct mfd_cell apple_smc_devs[] = {
 	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
+	MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
 	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
 	MFD_CELL_OF("macsmc-rtc", NULL, NULL, 0, 0, "apple,smc-rtc"),
 };

-- 
2.51.0


