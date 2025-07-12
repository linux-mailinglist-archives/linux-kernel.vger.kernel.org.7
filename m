Return-Path: <linux-kernel+bounces-728623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F37B02AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D83B4A2282
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B927602D;
	Sat, 12 Jul 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfwBEMkR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC4273D7B;
	Sat, 12 Jul 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752326095; cv=none; b=jCDxAm7pwNFHZEVbW86eQ4OGu6QkD0kbr67lO1q6CTCy3YM7HuFobQtoA1CuNbgssHiiyQ0Winy+Gz8HpebNtoHx4Oj0A0B+zbPfyVKaAGgpf2aWScYvzV8RQbVdUs9pIZ7DNAjPQmVw69dk4JQFYj28zs5tzaXXLu5k/NFNfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752326095; c=relaxed/simple;
	bh=5dN2ZHRvnjmzaC8O0OTUDOBXpyAGk7HmJNNUYPuo3ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buhpZCf1mKW1J6QY5eGRDpqvoagdYVpzM0RBx+cguLVfEplsxqsp/sfAxI1dvK1B3sqrCiE9AZX9GRGDrquIq2Vq5jywgn8avRse7hRbQcxmwV8UC/hDjHf5QTn4rsTGj2a0Nh/pjhE1MKf4sUO9sNT8PxgDY3VV1kgAz6dVZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfwBEMkR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a528243636so1653089f8f.3;
        Sat, 12 Jul 2025 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752326092; x=1752930892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGUt1yxOvswvTrka10m3yGzs1DAJHeoa3k02CExK/Ss=;
        b=NfwBEMkRx/cI6i8Kr6qH26KiQ0WfeHAbFmZOakyYN2JwGP6rRTaOCgFNvjyTs3Bu/a
         MkzowJVa2STreoJ6TMc6K4xLlxaAUMhEeXswZhSLQAIvuVlTwjTfY1ajCi54J/eKuiOT
         n0Cd0/iMTk92HfcOaP+KcSyc0P+u1yvqKaQGQY9widSp4qiv4p0qZ1hONPltxRDdR486
         LTcvLokz/yPAc9Edsp+RrUWcTKMdBWoKiWYtPxB9DkgA8jZLu0r3VAD62lwtzPhxWmlH
         i1L8jsSjtl1QVVAkHzEECf1VJ7+32tgaBj1K2BYiVOgZzMTu8hr5S1Yd0K06QcBNDMnJ
         7Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752326092; x=1752930892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGUt1yxOvswvTrka10m3yGzs1DAJHeoa3k02CExK/Ss=;
        b=BpRnrSPRZJ2dpTVfEYRz54it1kKcgOFO0Z8FvCy06Htj/ICSnaY/5P0lDznQKFVA/6
         4bofDW9LQCHID4FumkmUCGxsnc8ib92OT4tZtJqBB3np4ZcUz8bTJ1nxX3xSAmuKeJ9P
         pvQIp7jVIZv7awm5r7n3PNrb0FYtwuG35RBhXCjmtBp4pFDw9gGZWNqyNE4cvbAStpMu
         1ZcOyUeWainHp9jaIm/2dNDWGA7LTktd9JZdNXJwzLsm5B+kv1RmYquDhjS8W8ai/pPn
         SbS+f99q9v0wA9WKk59LvkTH7Yo0lqRRG/m0TxiAbbiCQGNgFdnlNVAEDdqhJDjBNgxP
         5ASQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFryRyJSlHUMEhjZhuxL6uC7rOfB21SEBgOF+5le7OSqNtzfgcO5Z2uSG95QKhpkfPfENmFSg55uY3flVR@vger.kernel.org, AJvYcCWLhU0rKOts1DRUF77b3+i1TLg6bgJWVXaaR+522TBES2eD50XF5Bb/LMbffNOJPYrjn2zYb1Ls3mlk9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZeCnY8oxfxeJ7eVGEB9xps7V+65aVuQD/SLmJDFadTr4RQXB
	1hdNJ4/bcDog4VxfxI/B2AuAEHiEVXGNPrIVF8A+pFWJ7GMkjWmSsnQj
X-Gm-Gg: ASbGnctI/oqG6U7RhQORB7P5AiopUMHwUWpMYk40KnAK+iGBf/eGlek5cHONILeHPWc
	9ebmAUp6NJysh9z8CsSoFEg7EsUeEECNGz2vQkcD1+wrUgM9DMwILPsFHK2ClRrF8NAdg3f4ykM
	ecc2HIxtlz8qxAzTIzp+p6x0MBiKd3eLC+MIh+18/h+cTleeuGuGw1hKK4ekeG0jKizq+a/rBaP
	CgBmuoVibI72MNecWw5eCF1fpXCiw4pxov9Lf5CuOfqOzY1WquCEBbN3oW6rmxJeXWMAkklJH3h
	7okL2KceVlFaAE09k9AnbZgcBj/q3lSvJVySkai64nV+6eCgCBmOeDnxPVOp7HJBHnUnqloH6yV
	s0/lZ2KODEKi56zPrpsuxyYRpaNemNmM4+GHXp4DSwlvmCNk=
X-Google-Smtp-Source: AGHT+IFbc+H8l0qLJKrpFMeU5tqbo7r11l4LglNvrFKAb/BVWebwk1DuSjbYwLjyHDdpjQgidI2xkg==
X-Received: by 2002:a05:6000:1446:b0:3a5:2465:c0c8 with SMTP id ffacd0b85a97d-3b5f187a4b4mr6435777f8f.7.1752326091897;
        Sat, 12 Jul 2025 06:14:51 -0700 (PDT)
Received: from localhost.localdomain ([154.183.63.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc229asm7304903f8f.35.2025.07.12.06.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:14:51 -0700 (PDT)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: max31827: use sysfs_emit() in temp1_resolution_show()
Date: Sat, 12 Jul 2025 16:14:46 +0300
Message-ID: <20250712131447.326995-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace scnprintf() with sysfs_emit() in temp1_resolution_show(),
as recommended in Documentation/filesystems/sysfs.rst: show() callbacks
should use sysfs_emit() or sysfs_emit_at() to format values returned to
userspace.

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
 drivers/hwmon/max31827.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 48e8f8ba4d05..c423cabcb28b 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -445,7 +445,7 @@ static ssize_t temp1_resolution_show(struct device *dev,

 	val = FIELD_GET(MAX31827_CONFIGURATION_RESOLUTION_MASK, val);

-	return scnprintf(buf, PAGE_SIZE, "%u\n", max31827_resolutions[val]);
+	return sysfs_emit(buf, "%u\n", max31827_resolutions[val]);
 }

 static ssize_t temp1_resolution_store(struct device *dev,
--
2.47.2


