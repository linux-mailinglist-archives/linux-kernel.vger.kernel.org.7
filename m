Return-Path: <linux-kernel+bounces-751894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE7FB16EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FD83A9FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF48290DAC;
	Thu, 31 Jul 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCQq51sO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68CEAF6;
	Thu, 31 Jul 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753955213; cv=none; b=V6qoaBOgGa2BnTVACyIQDBXHkEZLvAr6TgafpJj9VmAy+JYwX778JQWogkzpI4+gHIS+523I61bEcOHGBpa/4TQ/JzCGLKM3wx9EK9NGVakuIPnyZnZRUJQcfq3qnwH1SK2rNhUjaz7SdwbTg1MAO50MbiJT2VxkDPp29xBiHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753955213; c=relaxed/simple;
	bh=xXPpGX7ZBjJ1xdWVAl1wkJNiB3J4P2aSQW5HUTyyQh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=knd8m0+0hLTbNmeOEwG5IsvHDbYGyCw15ZLe2KXoV8e86Y96iHiUXGNO63iZUm4yQmLprmq5LjPjJS8QBSGnE5PI/PoLN9GlOhL+BcAW6ycRIpwabbgDfplky6gyc9hF/+SU7Zdob/1oxPGwJ5T9W+ln4v5CKWJin6PuXXmx9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCQq51sO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so4534015e9.1;
        Thu, 31 Jul 2025 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753955210; x=1754560010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FvYfWmJZ20gWyOT8n3+HXUa94Fj4Gkd8CfUCWJIkuY=;
        b=UCQq51sOvkcNr4EkK+s9G4pGImwv+d7PHjJ4G9tdNt0e1/BM54u1P4wt8ugxqpPHhY
         r78WrvNwiGB74Me911rzMWa+3+kOB5hJmgkViku/Q3Vw67yG4KNRFOo/mVNIoFfoyH82
         p+vERXth4h5wREAUCIt0LJmaPxdCLDURlUw4N4Ny6cNH+eY1G+gWuvmGmrjQ8JHrAR7s
         9YMhaJntZzquhlD21zvxCoT5nbMxt1HnrJziUygkDcEoK3VJLa7lj7gdsimPM8rRnSNw
         6RIFmvVZJnBs8fFV3OMe45B9kkYUzsupjJUjfB1TcmY0T4bnEnNZIU9gecTZbO8F3b2t
         pIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753955210; x=1754560010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FvYfWmJZ20gWyOT8n3+HXUa94Fj4Gkd8CfUCWJIkuY=;
        b=IaWrqWw1GntzIVgNW4BLQpDyGJeoYPNdOmfxC0oGR7iYlwhqLcy8C1ajFmSjabsYkQ
         ryMIpiVVkNgoAXYbUmKdTJ2vmgqnBK6GBMYYUZsuAO3EtWEe14V3u5c+jqy8IZYYo3tM
         0WFDITAOoDVHzSDM2jjLFupBcSBxxTpxBFj0W/BYKa0u9UoO7XLyH3Q4mGiPLccIGljP
         /0yALMqfi2cvXcf/RSidjWcFQLk5R3mN88djxzeDC0j7+5Q6sfNGjAOpj1TkGaet3HYi
         yPVEGYNGVgOmKkMYSoeSYI8O8Lf0gwgTnhI+cx3C1ujwIf28Wygk61OnibAqicUzWD6q
         iDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHI3BQtVS6L9/HHEon6+AHE56SnLqodLiGgHxv0dBms6dLznPa5Sc9UAaxE1v55p00T9cCQw1ddpAkPew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnHV5D6rnQYKB6S1HNEA66m+2BpGdrjnjIxkdUzBRKJ0JHByK
	RxkgqrF088eqZYRmU906N6rxsFUu3ju/7S2yVo/WduUrDELaHDkJu0bB
X-Gm-Gg: ASbGncsi99LWO7VI0K9ZVd21QD7FELvwItRMhUdtcPemKdeiVhEQ/gyIF4RD18S6hPO
	r24E1IbGJEJJeWIUB0yA9Nlgbuh4/0UnbXoijIIx8UH28jOotiHeXOBW1/wf1zz4aSj3OGWwl72
	aSXMIYHPtYhcOMU41RSVud/4R90ChOstND5A1cJCi/y0SoreQqDAli1yxuiez/TX0MqkH+VgLCs
	Me+GnHNQasY9re+caQDxsnwIW2NCGDBBNjEEZPrv1KNFZi6Nu1yzmXIV2Z6BP5LAcRXJeZSa+67
	pdFmIamALPxO4Mg4LYSH7JHJ+djzXKBLXwn4mxE+GOD7+WxeAULHZ97LbzC1AZWoorYVMnGVLTh
	x48QMZ+VhmgZcIctecKSu/4if4jmUAjQ=
X-Google-Smtp-Source: AGHT+IECIlKob6XVGKXqPkIouz4B7PwUNLICavEgKGFiyCNrN7e+75j3b8k5cwiFz9G2EqNmg5hHVw==
X-Received: by 2002:a05:600c:8b81:b0:456:eb9:5236 with SMTP id 5b1f17b1804b1-45892ba3686mr67809105e9.15.1753955210391;
        Thu, 31 Jul 2025 02:46:50 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458981d0b06sm60091895e9.5.2025.07.31.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:46:49 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: jedec_probe: Remove space before newline
Date: Thu, 31 Jul 2025 10:46:13 +0100
Message-ID: <20250731094613.2164604-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space before a newline in a pr_debug message.
Remove the space and remove a space after ( and before literal string
to clean up checkpatch warning.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/chips/jedec_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index 23c32fe584b7..6a583418788d 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1953,7 +1953,7 @@ static void jedec_reset(u32 base, struct map_info *map, struct cfi_private *cfi)
 	 * as they will ignore the writes and don't care what address
 	 * the F0 is written to */
 	if (cfi->addr_unlock1) {
-		pr_debug( "reset unlock called %x %x \n",
+		pr_debug("reset unlock called %x %x\n",
 		       cfi->addr_unlock1,cfi->addr_unlock2);
 		cfi_send_gen_cmd(0xaa, cfi->addr_unlock1, base, map, cfi, cfi->device_type, NULL);
 		cfi_send_gen_cmd(0x55, cfi->addr_unlock2, base, map, cfi, cfi->device_type, NULL);
-- 
2.50.0


