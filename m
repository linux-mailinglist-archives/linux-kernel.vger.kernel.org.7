Return-Path: <linux-kernel+bounces-744162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2FCB108D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F3FAC1E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34726CE38;
	Thu, 24 Jul 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEhtvHwX"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424B269823;
	Thu, 24 Jul 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355735; cv=none; b=bgY7o+x3EklVD4j09JtDbjBUubvDjyVmGbAw6esClp0PIG6xTv1vWyaXxOHRzqxkF85uGDMSr4N2JI4oO0NyoiW99ki2UH2nMUasrQ8WDhy4bid0RwzoEyp2YNv6nvEIe7F+XptdmNVD5e5N/+TODBkMJ4mYcIFVCLx89mf/vLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355735; c=relaxed/simple;
	bh=zI6wznTCKI6qdSFZjO0Obfrjv1HDVl4f5YRC0ifu8j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u0TPXFhZwPgJFmNCSeFLMtC7+o00e475lR3gYXNBf2F7LEAWzf4nQ6QwzTJFVaHi1GBGLg5XBRT+J8ZDm9v8PAQr4f+7F1jfBnxtWoosBkiNuau0fVqoy27H0txeib0WWehEmF7M5GtYNtyPt4MKpA6DC11YmPvjWZmkIX1fh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEhtvHwX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so599036f8f.0;
        Thu, 24 Jul 2025 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753355732; x=1753960532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akK877jV8P/jl94k5i6QYpdpJ+XCJw+iZLGZenw8WpQ=;
        b=TEhtvHwXBWc5Rt30lwL/4sWZuzyBRnperE/Mxd0hrafV+CxhTcEtdDsB3zEmnGoHT4
         go5DvV8L8NKGKRo+Qs1F9cAxXvEd4txCdyb8e/61XRNzr4OxcXF5mZ53wQvDTxq/b/p3
         68FOHgvHVB9GFudEwxt2DUxD9JG+pj/c4YnwbeokqEZPCLWV4cZCN8sSMZG5ahwa6XYV
         xJ26rZPUtC2JkhG617hUeT9zNOqMNR4SjFbz5C/bR775iRif/qcaKuo+mIr1NXr6Awbm
         pWU6dOZSTKCcc/1WDY2gvxqAiSp1Xce+NgiA7An5JN8lL3wVa5ryJgWYJZifaMIcj4iy
         B1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355732; x=1753960532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akK877jV8P/jl94k5i6QYpdpJ+XCJw+iZLGZenw8WpQ=;
        b=RVkByX6bv3wP3eTsguhYZV4MqHfO24LpCTagMZCjigGTz5PU2lm/MSi/y128LrobVn
         jJTv0Z4HWiMkYCnkie6F27UJ4yCDgzpipHkKEIEn4tNoAI0vEV4bU95wk1CH/i/TY3wn
         lKTLDsfJNAJIXAisJhIRQjn6ifLjN/QahynTqi4UldkbbuJyQH/LqwvWn8DR4sB6Yx15
         1qnrLxxQQM25m8BpN1iBD/JhkOu0YUsQtXc1awHpjVPMNdgfLP61W3Fgq+Oofjj8A0x6
         gHe58izcnkXnoI9scHX4bfxvdvKtZzcP5dGQGESXd0GkuaAlNHC73Efvur8JjC4aDxkc
         cZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQUXjPAl9aWMPomN93NQ8t/K9VTPVuqVS7uTVcEJl67NpbYIiWhVD2kskgrQthowTcdxTpxyY8NeyKdfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNt/cKjCMOUuQ6hwYJMw9oENPcVbFFq3e+GP99Zsi60Fc4L6xU
	+FPMPe5H2+vHLpi2eFyx5HwNwFfWjvUKOj7dSXmMU77WErqynCSveZyr
X-Gm-Gg: ASbGncsgux7m+0vU6Ae+v8oDCO1Mpj0bnIN5bnqlNh6RrGWIpwZA64xUZKNp3OUQbaM
	+cZpkFm5B+KfDP7m8dJGsSCkUoeNFkC/2M18sZcgfX/fxOYF1s5ji1pEk0GTBlti9gGyGeiC6Hu
	7qaEZ9yjdNdmqGG+okpy80PquOBDpmD4yfNPQ0Yz+Fh/ELHmA19UgbrYb7lPIEIRKR/N/5NlF+l
	javQUFxH+kdUqCWvxRHMKYHacnez2rL0NSINAh4ok7/x4+xofjeaTNAUKbUZ3KlFujxZmW7TyMP
	wG8MeTG/bkicehvED3vQx9flwuZvAvIl4KwEcSOZ5+SljZcgZ811VA2sNwXed/G8h+nlBQK4BVx
	6pvhG/vxpdYXV3KN5nyOl
X-Google-Smtp-Source: AGHT+IEQGNJvOEga9hz2pxNuvy/L70+Mo/J2VQnHERBtvV4F+J1eR/g0m7CC1aE7WWyByY79S+K08g==
X-Received: by 2002:a05:6000:26c6:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b77137c0f0mr1391798f8f.27.1753355731944;
        Thu, 24 Jul 2025 04:15:31 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705c4f40sm16199745e9.27.2025.07.24.04.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:15:31 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mfd: Kconfig: Fix spelling mistake "infontainment" -> "infotainment"
Date: Thu, 24 Jul 2025 12:14:59 +0100
Message-ID: <20250724111459.141633-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the MFD_TIMBERDALE description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0ea3a97bb93d..4fbf14d94385 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1921,7 +1921,7 @@ config MFD_TIMBERDALE
 	multifunction device which exposes numerous platform devices.
 
 	The timberdale FPGA can be found on the Intel Atom development board
-	for in-vehicle infontainment, called Russellville.
+	for in-vehicle infotainment, called Russellville.
 
 config MFD_TC3589X
 	bool "Toshiba TC35892 and variants"
-- 
2.50.0


