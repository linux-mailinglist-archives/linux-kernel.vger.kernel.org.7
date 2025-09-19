Return-Path: <linux-kernel+bounces-824224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EAAB886E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F05B56226C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2072ECE95;
	Fri, 19 Sep 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAwQveQ8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71C2D9491
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270749; cv=none; b=a/0fw6rArTRvPRA7qvu754R4aR45AL8KkF4Ujc2GZ5DUUQ+WBqPUjQvO302lIztxeHsq1+wH91Zo+E2fxhOxlRIJksEBh0cqcK0FP5KKlxULOiFPXA0vPOw8paj36GfIQwkSqC3PvbCzWXxGToesUpX8Qec425zPWUhzfbAFWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270749; c=relaxed/simple;
	bh=UWAvoZGlA50FgS0o5z1upfJK5o23+YuDcbIqNegbrgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmFEYOy+/l1+ehmmEiJz1OX+8J3X1idK2HjwUrQOq8ybyItzi8qY0ti8KAHrRvJ2yu7i5bwh8Qi9GnWoBckDxi3Se8Q6yPwKioH/xFwkPUugGK+SJ9wYLjWo0es5+i9rahdpnBxMgYX/+aPaizTdCethtWnsz2mK3cdcEvMVyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAwQveQ8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f0e9bd80fso40275b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270748; x=1758875548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsQBw1Dh8LHuiz7ZJyDcP8aEgIquMXPJj17sT8M1LHA=;
        b=NAwQveQ8XrCJPPaSGFnckHUBM5XucQBwbn1m7I8XQOPDF53ZtPkm1xY9E3A5K4iC87
         4NXLxRjyx+z/HveShM3G0/hrsxugbUBOf0rBPs73If2T9cXFijxzoDmq1D3lCoUn03Tx
         fByVVGT4E+kg7DJ5Z9kCg4o5JOqmh3L4BZZyWqH3z7RHuB5ferMoDXpRnBxw1IOAnUyl
         0nzhCUmgKK6cu9yLAtSvUjqoNI0TxIV7QltD/5AQBEE2xJQ3nr9/4fVSXeN6/wo7Yrp0
         9bO9gbQ+nRqXRjNMYsQmpU0ETC5ltHr8y/exHEy0qYc5aRK/TisTFc4w8r5t3wV+W0CU
         FS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270748; x=1758875548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsQBw1Dh8LHuiz7ZJyDcP8aEgIquMXPJj17sT8M1LHA=;
        b=l2NMOlRfirFcIXoY2ua/ululE1rOg2yzGqujntr+9mgJjRPaw1I2GurocVKqhpjMYc
         kwB7HNvRq21oINr5xF9ndgSApZG4Wol96hlHYJQh8qTuBBCZEBeEFsdK8CjczAkFLH4N
         2uIO9GvFyipi69fUxPwycgq2rmEfxp4ptAL8ai3JnGTMoQb75mcevHX+o24oVLkRDbrr
         xBdaW6k/vic4DkLJsKH7LLbzlkznEAtvoJDU6xHa0jVSsgYnjwhnQWwJ5ukYouFoe26X
         904bzzy05/yspgNXUClWMfji3T0cGKiFbV6ck1mIqhIui+VgZiQYPzbkaJURI6YC0jgO
         KGRw==
X-Forwarded-Encrypted: i=1; AJvYcCV769gIBrMJieBNtJ7PVOqbzCsewkmpeg4oHDzL/7SXBSFybcWT/2aHHue0eaF2W+XUMqj+aCidCzMir+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FAknmvZLcwCvVygDjYML3m3AmWxcJZNN6eGbXlQHPbM10fW8
	kFlW4gsHK3WAxYKI/Md+TTwwk+OrA22TWbyU4RJKmLTbAuYMfPusKafx
X-Gm-Gg: ASbGncs63aUWh8/MTuGeQOkMZgGHJLEn4Eic1gqkHWR9Ks/Lys5d9YZv+FKgVGHBNNW
	HxbksUXPGoppQ0Twom/a/f7kW/P2GgRbQ0NtWa3IYKRS1F2fcxMzKtZX4711MomjQV9J1oehSPN
	D50DzHE2oyuVVByqD38BlGKwEMvsMdVqXjWqackIYQSbZWFEgfyZcfNWNT+kuP+1gDoCNrHg5zL
	5JbIAzkMV2SHrMJ7SOBzoaD8ji0T9Kvwi/fdJCMEqX8f9uBwcbi9ksEBqJSdDTGFkVnRMRiaR3B
	mpgLeODvxNvaeIgoz8RgxCRZqZq0qDUaKWYF6Qc8HmEv7mn0TfTduJLT+nFsBQHx7LwMeG2XgFD
	NI/amLYQIdAU+j7ZJq85nPkiv
X-Google-Smtp-Source: AGHT+IFELQ3f6NPUjdohjrHMcMhPlg1pHDmoCsPi5apVaUNTHNt55Juz3QmARBoFQ1xFCdRTMG4z2w==
X-Received: by 2002:a05:6a20:938c:b0:262:82a6:d93e with SMTP id adf61e73a8af0-2926f4b8ff7mr3896745637.32.1758270747541;
        Fri, 19 Sep 2025 01:32:27 -0700 (PDT)
Received: from archlinux ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3309c81f50bsm1324622a91.23.2025.09.19.01.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:32:27 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: mirq-linux@rere.qmqm.pl
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] misc: cb710: Replace deprecated PCI functions
Date: Fri, 19 Sep 2025 14:02:14 +0530
Message-ID: <20250919083214.1052842-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions() have been deprecated.
Replace them with pcim_iomap_region().

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/misc/cb710/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index 55b7ee0e8f93..033e9e6d37db 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -223,13 +223,12 @@ static int cb710_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions(pdev, 0x0001, KBUILD_MODNAME);
-	if (err)
-		return err;
 
 	spin_lock_init(&chip->irq_lock);
 	chip->pdev = pdev;
-	chip->iobase = pcim_iomap_table(pdev)[0];
+	chip->iobase = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	if(!chip->iobase)
+		return -ENOMEM;
 
 	pci_set_drvdata(pdev, chip);
 
-- 
2.51.0


