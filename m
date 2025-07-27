Return-Path: <linux-kernel+bounces-746965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3190BB12DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697FB540416
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC4188000;
	Sun, 27 Jul 2025 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0rhGdVy"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20538376F1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583551; cv=none; b=dIAMGBNHsxnsLNKlZM6fPCF6iJBbd1KSiL0fY7+PIgZ4pVYOhTtQVV1RW2aRHMpytPog4KxFpyum8joGjESkpqfpT45nBsEv9rvUqRx7GYZvoL9FjWpqB47gn7ftxod6shCv91pjfgdrt3PPuWk5TaGpE4WcuC2oXDJFywedrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583551; c=relaxed/simple;
	bh=TVlWjrQluuSrhqM3RHjljoVHYHpSNZazgafcl6aP+e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=silDXi1ypQlBOVxDkLSgGXualZ1L7VPZLNjXFma9dzFGs6/FuTuYlvvN7z0mV8C9x68VPPbf1bdg5SX8TTixp5COuVECqu/w24DhJteLXHdNop3ZXWLeWs0fh0Gp88pq+0YzHab/2mXlCplTEZwDK4NnS1HzwOzPqFesZUYe/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0rhGdVy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7490acf57b9so2284647b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583549; x=1754188349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TJDPRPyAICEoFIC5p3TAZLEGyWu+JwEQfaHaO3KYwA=;
        b=T0rhGdVyDqmFCt+t6ji4RHkpfhgoCZnHOIN/hUM+1USadeca5fX7egWlliF3XNpwKA
         UKOv8noDlbCV9Q5U5ZTtTN/PY5/wU+wDePfbAGMPpQQz8Iq+P9iLnwgjZ6Okw1wdyj94
         L8ds25j0hcgnRFR4rjfvum3xjOlN7SUsoqtGZ7bQrBop5Bg8w3yjoRqAk9wwPeyLEs/t
         u6UQFqd/mPCoILDocRxKAYa2DSN687ZdY2nhRMZd7iHeX7UPmyUKirVmVOF4IAHBH10Z
         XOJPzz37buAYM9+wKU+OdgSuE48bP47CTzo2BndYngXM5e24jXHy+dB2AiJKVbTW584P
         v3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583549; x=1754188349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TJDPRPyAICEoFIC5p3TAZLEGyWu+JwEQfaHaO3KYwA=;
        b=mDfbatdN2mjmhM53VVZ3dnYAfbkuNh7vHir56M9yN1SPC+lgTSKdHgpOACS/xxLO8P
         ASt/gNlQ1aOeRAd5mSDhi60us1Jtx61PDQH6NIdOuyJVsOIlNuYivHx5IOQ4OBffxOi+
         Jwft2/h0eiNPkNmr7UaWS+T0JfYeIyJDCGBzt4Hjr9jWOhMGM8eSAqpN5lQ7jwsMPuMv
         nEb9ZICbff1grzRgy2/UUw6qF0SF+aWBUscvsVl0ZVrp3oQzy8lo5XQWKiazmbHqzvM5
         /v35+w8yuVEBDTlEg81RUx2aPtNjdvGXaqewpzBohVepp+sRv8m0SWEPzfFHNXWJUi4k
         R+Ig==
X-Gm-Message-State: AOJu0YzRv6dOCkVVaA3QaLn6FlnnGtC6+KGwZ5aAo7bmQihELJgFwHr6
	FVHGm4AcetBv+5kcZ3zCp7aRpTz81uxoVYudHbyteoxbea7mQFlWUCpB7wSATwX+
X-Gm-Gg: ASbGnctqOC9MNg6Y3TSZy1PVS595+dctOBKixp9MaAfqY4FWQA8O+HJEkEmNFl0fLgU
	rhtn7Kmr7k9fcFTkvP73Sq0XO7kfv+FL5c2qBbYSkTbu6SMNLMt6LC7ErtyaXScdfIOvyuwEItj
	rplOHrVQHV6ZgV4gy93hGe5QMAxQHdFUU75O91xVbkTfcKfCLDPZNzVekfK6xX3CzOvtYMMyRJ/
	9PJO1DOw2Qp7kIQnhw5OC1H7V7DYp/YYq8zruKJhHTgFe1dq7BaRs63Z6U/CrcPNTfGt+YFFcVk
	KsHkBIjJW+L5JpqRFNLSUhDfIHPC0TmPGC3dTbh+A+1594BIjH9NnlYWrfciuxdPK1L0qxdoC+o
	dJ73o7KMAMvszZfPBA/gdmFBvKLiUkj5VpJ+c7IcM1/4ToWNk7NkXCCpa
X-Google-Smtp-Source: AGHT+IH53tbmDggMSkeSoGjanSgrTpXFCk2r9EPaoPXK+Q6257I1qos/qwt3HmPaeGusGZ77f5cSEw==
X-Received: by 2002:a05:6a20:7f8e:b0:21d:a9d:ba3b with SMTP id adf61e73a8af0-23d701cd1d4mr11583569637.39.1753583549204;
        Sat, 26 Jul 2025 19:32:29 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b3d3d3csm2588592b3a.111.2025.07.26.19.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:32:28 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/net/wireless: Fix typo 'thresold' -> 'threshold'
Date: Sat, 26 Jul 2025 22:32:33 -0400
Message-ID: <20250727023233.82780-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h
index 99c6f7eef..2efe7d886 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.h
@@ -195,7 +195,7 @@ struct rt_firmware {
 	u32 fw_emem_len;
 	u8 sz_fw_tmpbuffer[RTL8190_MAX_RAW_FIRMWARE_CODE_SIZE];
 	u32 sz_fw_tmpbufferlen;
-	u16 cmdpacket_fragthresold;
+	u16 cmdpacket_fragthreshold;
 };
 
 struct h2c_set_pwrmode_parm {
-- 
2.50.1


