Return-Path: <linux-kernel+bounces-744188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E7B1093F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0377C3AC580
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D7127F4CA;
	Thu, 24 Jul 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To54RVNY"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098C1362;
	Thu, 24 Jul 2025 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356709; cv=none; b=r5Toww+IaN06kSZHCwvalz/1lKZ7UNpOXs3RbVKIhq3Hb3MQlKI/likLPG/yw0afIGVfOz8yLBSnG7/iuMnzUYq2+Pyjf6VBGa4ysL57FhF5pv79W/oNMI1wqDC0uCAI49mQFGRANofV2IeLjCacEWft2DHiLk2j6eTPofznJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356709; c=relaxed/simple;
	bh=9zNDH31/bze0DhjG7LwSPl5vL0W17YYDZmxysyNyh3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5oSinozRGFXhbtmLX9hI9yTUSacHBIkPikr7L3p9dP6jJXeOS59sjB7KAYMx66LwIgC5F4uu9FaSs5nRelHNU3JU2t4mpiYTycaemfISdUmGg0EKVpRqXVw8lPiAiOGmKw5rWBDGEBYpVH577jPxgw0Y0tRGoC6Stgh+D3mnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To54RVNY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d6ade159so5475235e9.1;
        Thu, 24 Jul 2025 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753356706; x=1753961506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqhSi6p+B6hhA50AQAC7X4rvYGoarJKa15RY5seG5ZQ=;
        b=To54RVNYTH8CGlAmjyx0y6dMfHj0GgfYucBGLvetpip1IgSPnuVXRqm6d3V95jpkEj
         lw8MYNi1t1Ihut88HjIGzjjrkWztLWV9u7RI0XUnxGV5uUgghcsBu1w0/noZzo2j6cp7
         f4eCt6pMlZfie4irSHs55Rhwys05DpY6IWc+86JuOYsiGFf4mt84AQj8CFVtu1G0Qi6Q
         sfire19wxco1VAh36lY3i/n5xqRaJgBclVYkMrgUX9wzUbNB7LdgsxKnftbzKjptA/GH
         f7JM0FndMbf2mq8TyVRxqbKhuuWdyxLCnTpDSiOV77XfuDYGJXvuzoAI2XNEeCuOetz1
         tkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753356706; x=1753961506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqhSi6p+B6hhA50AQAC7X4rvYGoarJKa15RY5seG5ZQ=;
        b=KfWyQDgDxcQKuqZeUVcw3GD1hFqWRT11EISjhuym5H9f6N82JIo1dw6JRfhMAp+w9J
         P32nTmhjW/2S8lb/hCFlvRSX3shjrkXoGJ0ibviVXEBv3GlztomxLWfntyOqbD31rAKM
         jqm44TstK4G1pxzpkLQ6znuRrY6iZy0PIvl6YsG2zAntBU69TofWmFOEmY8nSaPyGiVP
         UrxC3x1M0IPrmPXmnwZs/PTnxK+7a9MmPSWE/+EjQMf35hCgRsR1oqwIJMd8Ch2Pr2Tz
         8of2njAEqnZc4R6VOr+uqW8D21u6a+VSPgFQf8fHf3ytkLPBW3wzqEev/jFeVJIww7VD
         wPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7MFQqq0L4AB/PmAuLX6LSwRXKqEaBxsPyk7Uo6PtMad99zCDGqfFcX32LKZDlmnCk2gjpMFijyeb4Q/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkCud6XbK2KH2VPIh6aFdpKMRmx+269mWgs4XDnfC4RpoF52T
	nqV38YDutwKJr7wmCY0qXawXOp/cmE5ngS8Nt+LbdcyRrPF0sR6/QPR0Se4eo65cHNI=
X-Gm-Gg: ASbGncvepLTLxa9gtOxBsE8Q3VENHi0NlpriQ90ddU+/K/qaUu31gQGYSP+rRWMe5Ow
	ixFnSVvobv9d6Go7WBEK4Rs1vz0c8GrbUKfmt0SlnYOF4ETph7G3AtNYKh69QDY20qgpRXZ2qrP
	/dIrug1wZWNb03w+VqYkMVS227gudQWTIuXOcoTVdgAy4a6vOR04cCS+Nxp6nO6qkCBhnuW9uij
	Q08wzIQsT/sEOoqiEHTLJprwuutAc+edHbJfzrrhA1dMQOYFRMivO21OwP+8X0YU6oSfpPThqnZ
	xKZ9RoamrOYiBgSr3ALRhPSjAVr/TEfJkdz6vi323Po4nHIJJRPtVQcAHXVN64IftDe+sHAkmjA
	fZtOrrphz4M1yxdZ6wT5N
X-Google-Smtp-Source: AGHT+IFS2wZKBflH4pjS9NpUpMQtqoI3U2xH4LyVsQb3hGkdpScFv/AWIHq9fwbqj/DZ6MVGvkkNwQ==
X-Received: by 2002:a05:600c:1c25:b0:456:1e5a:885e with SMTP id 5b1f17b1804b1-45868c79025mr65313705e9.3.1753356705715;
        Thu, 24 Jul 2025 04:31:45 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fcc3429sm1858421f8f.75.2025.07.24.04.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:31:44 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: Kconfig: Fix spelling mistake "regualtor" -> "regulator"
Date: Thu, 24 Jul 2025 12:31:12 +0100
Message-ID: <20250724113113.143009-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the REGULATOR_RT4803 config. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 7423954153b0..eaa6df1c9f80 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1203,7 +1203,7 @@ config REGULATOR_RT4801
 	  The device supports two regulators (DSVP/DSVN).
 
 config REGULATOR_RT4803
-	tristate "Richtek RT4803 boost regualtor"
+	tristate "Richtek RT4803 boost regulator"
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.50.0


