Return-Path: <linux-kernel+bounces-738085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D30B0B41C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349C43C1120
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 07:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F21CF7AF;
	Sun, 20 Jul 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzl2//Xd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0A18FC91
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752996795; cv=none; b=W7bFzFuaUlla4mJrc4UJCaVTCg3pxvNI81Sp989zqvct56mZkMLqA3cJfkj06UiF8+8q8WSNJ7XX2hrJCLVIgCVwDCqGlIwlkcdmvTgdOHRZSQlVLq9+F6V00OsKqrqqf3lIXIceFmzvufRLi+xvSZ8+mOfmbYpz4M3/02a2jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752996795; c=relaxed/simple;
	bh=UCPebKLxqBspyFjBExWlopI92nmsltDWUfczks4LkOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9t5uCaUb8r2v0VcHkDRcWvJWnX2l/ooIfAJ1cBgrTHJbiabxH7xCYiV7fVdCZXfma1RF0vMS/otvJbfVMuS/h1lRPjLvArkm2vM9Qp7R0UnpnHABuc/WpHBZOtSNLvjKJgoekiQ0Q4BlnWEFhrJvzyvOUan2DX3iVxkiUg20Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzl2//Xd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167afeso32733525ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752996793; x=1753601593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zM+q+F/3AakFjugN8+T3F0cDtlqAbO5mNb+XTOdV2cE=;
        b=dzl2//XdpsG1RJvVgLqKh8WKCNVk8hu3ZXMu6FaMyuxXvbwG13AOW+MZ0vJ8WJmOib
         iDHLESPwfC3kdcQX7vL6L5VmdWQIVvFboJwUnhnn+2WSJHKvrPy7POKTQ5yQmoKavRiH
         HVvsL7IS3R72Y+6Hkx5YtnEo/9O7uw0S3y04IPXAthsSgnyMgvR6uDrsroBTyZKcTOQE
         i4tIrEETo/gq6fSEv+ggTXm7e1ZtwXYhFGw5YOjobn54ghJOw6QbPhJJwp5cymSvtmhd
         dVY7Zeo0sw6Nx20MxcYg1d6AAoQ5qCRwi5uGt82tODb9FMk/fwoNhThH8tDD2Bmxbp7p
         6OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752996793; x=1753601593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zM+q+F/3AakFjugN8+T3F0cDtlqAbO5mNb+XTOdV2cE=;
        b=aqlBFTNC6Nc7B5t+qUkWD6xg9h7yNac1b3qUL/eeeUiCuhfDEcP7TtCpUOADff1kL7
         WIonrWQw1rAQakX9+ZjMLIUC5ymfcd5FAg4N3sl7n5kW3OvGaiggRk7T33dVEEH0IIlV
         Ph/IAM0bZ/P5WN8Y+iS7I9NhLVK9lG5clCCglf2TOPZMoYlPKQVIosmUdgkD9EBhImfl
         +qpWd/q49tfgp8CYjajveMnM3xMipv7Oc+PIeAAY6gk4xVdtOi3QKtKmz4bYviFqHXTv
         o887wblrRelLuUY9BYB+lqjebSWtPXa9jf560GOuT1Vf1Zdqcc3fYBsja9SFKtUVrBB+
         Kdog==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+p6Mexk+RChMcwKn8p4Mtbh5iyDjX/bNFFvRxsbHA/1+YnVqB6eO8xEDxhtIRQx48oGXgejC7GIQUFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2j/dwGtOYGro/5s4MfofZJuFErEiUEGjMSp362NFH7uO1Tt8
	h5pzfIDZGclGhYgljeIDC1hPdvVYs8sxOu9BLvDU7tY2kS6+HoyBPlFg
X-Gm-Gg: ASbGnctO2sht75SkJlIsZvaYGrWqnjmxWTzW/FQ+70UPFp9FPaPR2ugND11cD6YYEkR
	0UJYb9V0JzBEzkwq0wam8fI679gGy2iwnRWPL6hdpGU1TkHCD7UIg4ISksxjWFuwv9jx+0QITCE
	Z8UeYqPQ9nEg8dAI2CXovLGtUBlAKcivuHoA0KpkScynpNjFYAA+GUqIKR/LaUX+4zyvFmUv9MS
	YLcW4GV3ODe3dyOOlaPa9bcAWQl0Qp1TJC59RRuy/b1Y8gPHz5JJTHrIb9R2CT4H3aGh0Qu7QkD
	GpSvzwRDIflUNTFqcgurlU/o0VS6IE/8lEU8qyLxMZEddwqT68/dY/Q+wyoEAVz6cgddKEtcUx2
	YOHTBea/jnd7N8wA/qgvpQNkaEEy7gYklErNkeQmIdSMt0w5YVS/20pcyXqoDGjXbGKxtHqnkww
	==
X-Google-Smtp-Source: AGHT+IE35sqZs22C2EiV2vT2ULDaWoB6RgEVfwqSmY4mmjUe+SwJdh5GwTnP61aOm3yMhFDf381o3A==
X-Received: by 2002:a17:903:1aee:b0:234:a139:1215 with SMTP id d9443c01a7336-23e2573f322mr258918805ad.35.1752996793228;
        Sun, 20 Jul 2025 00:33:13 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6cfa0esm37938125ad.145.2025.07.20.00.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 00:33:12 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Super User <root@localhost.localdomain>,
	syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com,
	Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH] [PATCH] comedi: check for NULL get_valid_routes function pointer
Date: Sun, 20 Jul 2025 02:33:50 -0500
Message-ID: <20250720073350.22251-1-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Super User <root@localhost.localdomain>

The function get_valid_routes() calls the low-level driver's
dev->get_valid_routes() callback directly without checking if it is
set. If this function pointer is NULL, the kernel crashes with a
NULL instruction pointer dereference.

This patch adds a check to ensure the callback is present before
calling it, and returns -EINVAL if it is missing.

This prevents a kernel crash when user space invokes an ioctl that
results in get_valid_routes() being called on drivers that do not
implement the callback.

Reported-by: syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com
Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/comedi/comedi_fops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 3383a7ce27ff..2b8cb280287b 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1302,6 +1302,11 @@ static int check_insn_device_config_length(struct comedi_insn *insn,
 static int get_valid_routes(struct comedi_device *dev, unsigned int *data)
 {
 	lockdep_assert_held(&dev->mutex);
+	if (!dev->get_valid_routes) {
+		dev_warn(dev->class_dev ?: dev->hw_dev,
+				"get_valid_routes() not implemented\n");
+		return -EINVAL;
+	}
 	data[1] = dev->get_valid_routes(dev, data[1], data + 2);
 	return 0;
 }
-- 
2.50.1


