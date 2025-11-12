Return-Path: <linux-kernel+bounces-897084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0400C5206C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DB3F504098
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353C31195A;
	Wed, 12 Nov 2025 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU6cMCxK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388930C612
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946309; cv=none; b=E9pS0jG5CeAeBDLYHpoN7ZItF9Cq9xjcDUw/DQGT/7bwpWeYNX+wyKp0nmLbpMXsyq2O786wowLlMCvKzujZjDaNxPOKHejFEtDDbL3GNaRyKoXdwiRXSSEYLVS5gETAXkLGHKRpDC3kGTmpx57msC4S3u/5fbDC7QL79vcQ3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946309; c=relaxed/simple;
	bh=KDo5qf6VinF0dcocAqVHp8Ouk8wH3LA0jZpPa6Inudg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGNvZIYdaDXGKlgRyev9KEI2TC3uTyESoLFTpyIcuo/Yy5v1VBqYvwJO+Ham8JnLyfyOCCiD/bxK82KnGKh4pZRvB2B7l2zIssGIIWeCAs96sVQGso9BpgHCmDaL61YwF7VpjQQnzIcmqobuZTM3GVIo7fSxMZHRXmrLjaJcF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU6cMCxK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2956d816c10so7547515ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946307; x=1763551107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lo9J4PpQIlH3VY5/mtPONGxIrnhCSXs3KQrxmVaTEns=;
        b=aU6cMCxKtR+CE944lWsCiO5Dv1DxnTnVmxFZ7J4TcQLZZvjBVkHwz0xcu72s0og5Dg
         xbZgzyyjWlirg3gL3kmcknVELZshT9neYBuko4L6oQo4dRrEf5SJ0+MGCUky2xjlC8QB
         4pIGakWQJqEH7qjPnAeHmXUD6mOtPrvWWvTYpR3YgQjiz9e2THUxS7P3LZ6XVmpklI6Z
         QHHhBAoYDElCWToX5rTSG6ptOAJUBOIvWFe1FDBcw8XLh9HAVqrFCBv5UljjHgASg1iA
         J1i9Zf4J9CDWnmZvjsJVv9jI2kN3mXOC/x1qnNhVSA4MYOOjrVubVdUudeyLSb+HnZjy
         W67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946307; x=1763551107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lo9J4PpQIlH3VY5/mtPONGxIrnhCSXs3KQrxmVaTEns=;
        b=P6kMJ56GnNGcLLMhcwFFjOEH+zqqXeTE+TeewxC8ZL44OkQy2XeKOJVi5blMXU1Ltn
         g1RxLYmMOOCsvWuYKQoGOJhN0l27xmnI5hqulIcZsgO0w9QpT869uN5rcMKKRj2jhCIA
         vAWjcRPsiH56qOTVESucx0cq0EWWXKBbbWcW3zoqgqpO1ZXPixQATyDxeS/Cixg5df2o
         hEs+6/Vab5s08uhmwazuzIdWIRgZMFN0R3Ms52oAWbrYubszAzz0j3WJyzZ+l97Mcn1r
         NzOTk2SLs8yj1P74fHGryGVIhXdTPNkzOApvjR8aRYjpzfM5oHyNfhDJxa5vzYyEh9Wy
         1eTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6qNWvLAv3fFkVS8JequUx7ffQNUTw9xGM5qTpGWbDn4p2EY9ej01NeyU0jlkMTO2JseUbvyf0WNodJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NLB0HuaY/nUFXMCXMsB8ESA8KKcOsI+OLMOf7L9NYpTwirdQ
	6xgC824jMKvzJ0e60I089ygnhuByU252Nznowz0u9RpdKBXzeqkoNTmT
X-Gm-Gg: ASbGnct/es1xQVgsqZLLJfG3hOy4NlDmbQEu/HI2YaLcdJy/FTntAUhdP7x8BKU44mh
	oZZb5MEszwc6ozWfFE5m1bTarFFE+z7MCXQeLqfglaWBmRzlS1WEjk4hPN0oX2j15Ct32S/XBSt
	gfXjZwx2aa0JPPwVcj/ZCp1phPoiUUph0D0dSnK6w3KCrXsGU6CDLDYPSvsOFcYZyboBqpUxMXZ
	UABawbHVQi47WxHpCxK644+ft02nAw/m64LxNaYNH+t3IOa9c6tnBfE9sxtREI32QQK1b9VGgWH
	k+j5qmh62vtU14oVxITvMHHtYLN74LQ+CubTcVqkso4a3vrGeEVjNmDphkSJEKU86OhbPLy14Sq
	v7i4h8Jllj3saqnmK/GTIQ+Z1MwcfpasBtNKzdC7Y1adM1XRVKi0jdrInityJx5UzPLNcHUq414
	LX6ExcR2pMIbEFx8eF99/xKUbj85qcgtt/SBe3IQTuZpJEZKSJP3WBuVhf+ufqm7nIcvFO4scz8
	IxC4FC73LSZFL8vX9mbVtmS+JizJdznRgDoaBLJ5Y9qW7YB2lBPAo9sl+se6nic8A==
X-Google-Smtp-Source: AGHT+IEImt2oq5AVyAyincVqTizrLP2oINP9hgu+RQmDQEbV/h6h5zM29LTMvGX0qa1Tj+zk9/lS9g==
X-Received: by 2002:a17:902:d60b:b0:294:fb21:ae07 with SMTP id d9443c01a7336-2984ed92d45mr33420405ad.21.1762946307045;
        Wed, 12 Nov 2025 03:18:27 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca0f28sm27386695ad.60.2025.11.12.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:18:26 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 12 Nov 2025 21:16:53 +1000
Subject: [PATCH v5 07/11] mfd: macsmc: Wire up Apple SMC hwmon subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-macsmc-subdevs-v5-7-728e4b91fe81@gmail.com>
References: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
In-Reply-To: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
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
 bh=KDo5qf6VinF0dcocAqVHp8Ouk8wH3LA0jZpPa6Inudg=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDJkiOUdZA4+/VDxp9c31mWLPB8Z1xzU9H8o5bWfLi7zwL
 fz9vPJZHRNZGMS4GCzFFFk2NAl5zDZiu9kvUrkXZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNQx1jFi4OIUgKkumMDwv+iDSLuozZuJUz69v8Z79VyVRceJ3QsUthr+n/mbd2rAklWMDLfnfll
 6aovjr827RbynnHifxf4lfqXZyn/z+aa9YGbaXM0MAA==
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
2.51.2


