Return-Path: <linux-kernel+bounces-869657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C79AC0871C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2EDD4FE2B7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFE91E51EC;
	Sat, 25 Oct 2025 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4nrRPYA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4661C7012
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351965; cv=none; b=hDsZPqwnEXBoaKxAQBt1SvhLZyHu4NpdQUCmVvC5NZ3Gabl1LlL+JIDrOEnALhU4Hke0SCj4y9MKK2VqpJDXLsvcoZNog7WSyt3TZnx3Kakf7S84La3mdZ+6CQni8yP2nh4hhvsitslcNpl3yoMcqBBVIZ/f9CoAiWviB70bn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351965; c=relaxed/simple;
	bh=9CvGSj3k52YgdYK4J0MHeIq2HkIZQxGeUJahNJ19td0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OnzVE54FGaW4dYANi3dEz/zEloB70hXGBdEzkR5rLLVF7A820I8wnIOR2wOUQ49M7gKXBPJMybL3ADY4OL0N2dZM303spgr4CoGlLiHLS9kKIXjj4Xmfa6AWpJVyB/qH8fAl7pRJoNajAu9YizCJ6ZtVFYIv/DFhgYClMV/JPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4nrRPYA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698d47e776so21891905ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761351963; x=1761956763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CiHvIx4iCcyVz9XM+n+OAI2ebsG3UALzSjgEuG0sIw=;
        b=m4nrRPYAqpvCSL3yZqRfzxNRxGeBAaJ2TXYKZDbuT43XN5SXQI/ymCC9VrLWsE9nDH
         MsiBtK+gZrxEDoXb1NTsXjdoqa1b0mQvN5kF1oCn5pdlJJIO7zxG/JAZdz2bd55le83R
         5Xc8ESFPlC7704BHUb0JgT8nnZACn3r5ElSTk0cCATWSK6sjDTYbw61tUNxqAznyzVWJ
         eJuB+uTmLwwMh7nQGpPbxDgd9aWtAPGiz6d6tetmS/Y0NFXqNElfro9V+L/xnl83FAwv
         4rhx2ipnVzXGxl+Slmk3vPa4n/jFUwMK2uTxYFNZu4CbaZ5cloh3SBR99Rh+jkv99Tav
         2wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761351963; x=1761956763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CiHvIx4iCcyVz9XM+n+OAI2ebsG3UALzSjgEuG0sIw=;
        b=W0eMjTqQmNRg4FripN3e3gGd8pD+7l1Ge6Xj5NiJSS4g6Fka6hgREHqMf/vQDzNmgU
         Tm7JoS4GSGjVTMlyJfMUT2AnekiaFhbGZwKTr8MmE/h47E74YNCoc5lIS4R6FlddAzVT
         k3QSWQDiwZPXyE0Nc8OtLnbVvkn2F6CqNybD4hsyVhlbgsfbVyFZ9Vu+rCaPmVLEy+sp
         mTNvwXfd9qvKnbJ1wDPfvw3Q27m9mcei0l67tdS/y9yKxOEZ6k9wX72IVKdS3C+QDFF9
         MIpCyvpBJIk82YBnOv6C6FFkyWX6h0Rup1aCMIESTZa7EwJxPwI9YyCP/OD+Wkey3FLf
         nZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVFQbS9/+lFfJL+RpCvd9Nls3qoIHA08tmsDXdjC4+KcAuRFx92qWFTzN5AC6qkJ8+gCnuppdhpyK/8Xeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQU03aG8IiMwFgMpuRICCMVzm6yVOzQ8t6L4kYHGQo4bHyHMh
	SaSYtBgFfL44CYJCQT8zMy4GRsiytAvYvhExrNkX3Rg/HppPuDAO74xA
X-Gm-Gg: ASbGncurHlYRRfESzj+qhlUUEzZdyp3NcxsbZdzf7Yp09IKogCF/bN8TYf1rDGJpYNn
	UfDMm2Lt/pZlANlucnozRpBMP/xwqhkzhIZ8sA0geOeinvyxuNAq1LCKIZgdv6IWepmiyda1ZA6
	cZdNZa5+fmW7WrHm9PDvrJdE2Xo8/Mk4PsXxMe6Ylwq2CezSYwXJTdAQY3KuEXgm7IibvbOrTJm
	mUmb94tE19BU93aQ50gKbAwDySeZvkdlVC5tNPYnckWjzBMPQxkKE0OY3UJYeI6tua3Mj5JGuQ3
	rBJ5+XIJ9lPl4dnHBhZ5x6qD7AwPeWUiBVXm78J2be4WBlT3bXWiStuJg38Dhp+YRlcHkLjRlbE
	+NcOi7e47/3uo2xG3MA1NahUMHMl7B5Axej/ulCRROdu6MEFjbWVk1L17uMmeCf4zbyaWRRPtUk
	AxuwmzFDq0LyAeo0E1Ixo4FE1eMxz4h+KMlCzAnTaiuanUtbrB5ZN4aWmo9F5od3uA8LlRUHH88
	174sJwjSbVun/VSpNILYnswwFyl6Um1PWJTL4W/u4o+1J2/PsQ4yg==
X-Google-Smtp-Source: AGHT+IHSa7MdO+RyudQ13l7ZBDW5YjuDQoXfBKNGzygwW/8ijBbpH54bUrATc3DfIp5eGwuXkgv2HQ==
X-Received: by 2002:a17:902:fc44:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-290c9c89697mr387774495ad.12.1761351962920;
        Fri, 24 Oct 2025 17:26:02 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3f4asm4728885ad.11.2025.10.24.17.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:26:02 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 25 Oct 2025 10:24:40 +1000
Subject: [PATCH v4 09/11] mfd: macsmc: Wire up Apple SMC input subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-macsmc-subdevs-v4-9-374d5c9eba0e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=9CvGSj3k52YgdYK4J0MHeIq2HkIZQxGeUJahNJ19td0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDBl/JM4d3hJqcNPewfPwlleiK7fkXZLhtVltl2i2UGbKY
 wMxq6iQjoksDGJcDJZiiiwbmoQ8Zhux3ewXqdwLM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GuoY6xgxcHEKwFQ32DP8D1tQvEl5SoUQr3Tpeel9LQEufdveGjjeWpK55erOQgadQ4wMBy1+6wZ
 LhiSptYttjWV5voFZ8fr10xZCNt+PsEww+B/ACgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Add the new SMC input function to the mfd device

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 51dd667d3b5f..3b69eb6d032a 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -45,6 +45,7 @@
 #define SMC_TIMEOUT_MS		500
 
 static const struct mfd_cell apple_smc_devs[] = {
+	MFD_CELL_NAME("macsmc-input"),
 	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
 	MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
 	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),

-- 
2.51.0


