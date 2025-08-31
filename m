Return-Path: <linux-kernel+bounces-793468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8115B3D3EA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE60B1894604
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4B425A34D;
	Sun, 31 Aug 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK9/rn8B"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2091DF24F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756651222; cv=none; b=Jwe8mXKZN1BJRtMG0SyBmaV5UEpU6XkV83yxFQiL2GPCLIKSrf8sNdMV4sdsZz1iNWmhD82k0uocA1mJv9leH0cS1TQoJE9loTHrImW/YscRK66E+39d8Z3Wz42b7DMPPHNGzdnILbPE3CBAxTHZD1oRi3uc5Jrs51kapaI7J3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756651222; c=relaxed/simple;
	bh=pfHcXOH+y7SGRY/Xmb+/0M15B8kDFZdMO5ta4CT2Mf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XhanEWh3iB6XSKD+Pn6YVLu2tnGE0zf/i0bJWy3mMdVxpFKFIu761vBgk62gRx79VHaynUw0e2IPn7oNrBuFsblp1tAdM0TeCw8qJbeFvBRZ3OlKPREmNF8dle7/okjBUoHVNy0G+YzeM2Ue57y1PqAFRIo1Bjc7YcWOyICAx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK9/rn8B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b84367affso12527935e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756651219; x=1757256019; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8uK+63tF9hV8oMnf210yJC1/tTQmsNNUHWIDHsThjdw=;
        b=kK9/rn8BR3OJ59Kr7stSIM7Asb3f02l6VV+vmkdjwow4gm/x4/me1KJ9fcalzHZIYt
         UvKP1TaWNJ3eu62GduFPgQIqJDlgi0BSv1hF1P0mxWr5QzO+71tTUiG68oRG5V0anURj
         uJqC/bo/Ld/gVnehAt0NAwoAGcbtJoAaoXkafNMim4SruzWJaYMj88v71V7VcEYISvzL
         BamqnhHcPkBjEw6fO8yc5xtHChQ04Ylt9g0LkydmhO6LNdDO0ytEyFNXAbzf9ybO/JPF
         so/486IKF+i9fHQgYLTZjI8Im35sJkGuOQdzCZMGwfG+7PApnCwJjYjxClcUa2MgZHMN
         K6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756651219; x=1757256019;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uK+63tF9hV8oMnf210yJC1/tTQmsNNUHWIDHsThjdw=;
        b=JRrT4vzRitNlq/iOrB4/5ikrydOFWVvSuFGgkn7UwLOstrsGyY91UPCtHTiU7tsdK9
         DogM0qLJvvdKgfFk8fziPWYnWeLaoSQMmsI7FhV1H8EIOL5aa7RFkeGtp9k+ullITdH4
         9iKz3g9P3ASnPT63QSqOmN2PLzxGgyQBOLUl+oS7cZEOgDCriRlvOh1Kqn591w7DOcDW
         KLlS5RkeO7KaNMcxxO5wy6lWnmzen5tKJpMo1fSCZ62tG1WRuzE0lzvhozFjy6peNiLZ
         JCc4Z/woMq4Z3gZtrFSVkTmuMUupkALDiy0I+GXbf1yf0gjKWGgduRc2sp83Kh9xClLX
         hzoA==
X-Forwarded-Encrypted: i=1; AJvYcCVghgXYlDSlpVI1xWS3v5Ia9TbwfFmJcs/ZBy/2AsKtlWQFC785/aK7bfNMsPiCQf9qSTWXGU9ZvpD+U+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3yG75MNMb4F+6Xvbm3VNMatgrrZfgID4Fug7DbXuORCSLTTQ
	HdyYOz5RBhTj/abUvbDI13MryavhXSbavg6d6MFihmcgf39PxtSN3bO8
X-Gm-Gg: ASbGncur52UtgwvOIzG2ooY7VR+B2CLcs8OmIlBZBcUZjg1XWDTQn9Dr9mrnPDCmJLp
	OT+lXGdc+JsI6BkpXWZGezBNcahHmVCgxasTMsaKzJmi9lRpo8xU+6mSe0NpV5+nXNgbEmy2Rff
	yRoc+zR0eTMvBiXHnqeTK0rI6ujqOzgrtN2mGX+DQpilTq3tO0YqLz1beIOr/MjHNj5WdASan9b
	V2Iug5t097oWZSwJFz5FaQRQ7PRwGrfTd0+o+upQsQk6F769oKuq1U537RxRSSJsSDc/I2aEWoG
	+NnS6H9F6OpO+H4RZd58b6HRHE5MHqdECEdjL1pnaMahWC8kYMj9YLNl2Rrt/WkHsODXhsxEmtl
	m+Kqhy7q7seu3k5LW/0urgWfS27h4Jta+OpvI6ShciGz0zTKHKrg=
X-Google-Smtp-Source: AGHT+IGmNiaoVhPlVK76Q0iZFW2fo2EpnrQ5R1q8cpqr1ZXwl1vz3jEJqjp7fRgR1H1I05IorYswug==
X-Received: by 2002:a05:600c:3b84:b0:45b:89ef:65ae with SMTP id 5b1f17b1804b1-45b89ef6623mr24158065e9.16.1756651218368;
        Sun, 31 Aug 2025 07:40:18 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm115956885e9.20.2025.08.31.07.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:40:17 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 31 Aug 2025 16:40:10 +0200
Subject: [PATCH] mtd: core: always verify OOB offset in mtd_check_oob_ops()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-mtd-validate-ooboffs-v1-1-d3fdce7a8698@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMletGgC/x3MTQqAIBBA4avErBvQyv6uEi0sxxqoDI0IwrsnL
 b/Fey8E8kwB+uwFTzcHdkeCzDOYV30shGySoRCFEm0pcb8M3npjoy9C5yZnbUAq1dx0taqEJUj
 p6cny82+HMcYPBDu9T2YAAAA=
X-Change-ID: 20250831-mtd-validate-ooboffs-e35c796540fe
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Using an OOB offset past end of the available OOB data is invalid,
irregardless of whether the 'ooblen' is set in the ops or not. Move
the relevant check out from the if statement to always verify that.

The 'oobtest' module executes four tests to verify how reading/writing
OOB data past end of the devices is handled. It expects errors in case
of these tests, but this expectation fails in the last two tests on
MTD devices, which have no OOB bytes available.

This is indicated in the test output like the following:

    [  212.059416] mtd_oobtest: attempting to write past end of device
    [  212.060379] mtd_oobtest: an error is expected...
    [  212.066353] mtd_oobtest: error: wrote past end of device
    [  212.071142] mtd_oobtest: attempting to read past end of device
    [  212.076507] mtd_oobtest: an error is expected...
    [  212.082080] mtd_oobtest: error: read past end of device
    ...
    [  212.330508] mtd_oobtest: finished with 2 errors

For reference, here is the corresponding code from the oobtest module:

    /* Attempt to write off end of device */
    ops.mode      = MTD_OPS_AUTO_OOB;
    ops.len       = 0;
    ops.retlen    = 0;
    ops.ooblen    = mtd->oobavail;
    ops.oobretlen = 0;
    ops.ooboffs   = 1;
    ops.datbuf    = NULL;
    ops.oobbuf    = writebuf;
    pr_info("attempting to write past end of device\n");
    pr_info("an error is expected...\n");
    err = mtd_write_oob(mtd, mtd->size - mtd->writesize, &ops);
    if (err) {
            pr_info("error occurred as expected\n");
    } else {
            pr_err("error: wrote past end of device\n");
            errcnt += 1;
    }

As it can be seen, the code sets 'ooboffs' to 1, and 'ooblen' to
mtd->oobavail which is zero in our case.

Since the mtd_check_oob_ops() function only verifies 'ooboffs' if 'ooblen'
is not zero, the 'ooboffs' value does not gets validated and the function
returns success whereas it should fail.

After the change, the oobtest module will bail out early with an error if
there are no OOB bytes available on the MDT device under test:

    # cat /sys/class/mtd/mtd0/oobavail
    0
    # insmod mtd_test; insmod mtd_oobtest dev=0
    [  943.606228]
    [  943.606259] =================================================
    [  943.606784] mtd_oobtest: MTD device: 0
    [  943.612660] mtd_oobtest: MTD device size 524288, eraseblock size 131072, page size 2048, count of eraseblocks 4, pages per eraseblock 64, OOB size 128
    [  943.616091] mtd_test: scanning for bad eraseblocks
    [  943.629571] mtd_test: scanned 4 eraseblocks, 0 are bad
    [  943.634313] mtd_oobtest: test 1 of 5
    [  943.653402] mtd_oobtest: writing OOBs of whole device
    [  943.653424] mtd_oobtest: error: writeoob failed at 0x0
    [  943.657419] mtd_oobtest: error: use_len 0, use_offset 0
    [  943.662493] mtd_oobtest: error -22 occurred
    [  943.667574] =================================================

This behaviour is more accurate than the current one where most tests
are indicating successful writing of OOB data even that in fact nothing
gets written into the device, which is quite misleading.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/mtd/mtdcore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac3c297ae21329c2827baf5dc471f0..9a3c9f163219bcb9fde66839f228fd8d38310f2d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1590,12 +1590,12 @@ static int mtd_check_oob_ops(struct mtd_info *mtd, loff_t offs,
 	if (offs < 0 || offs + ops->len > mtd->size)
 		return -EINVAL;
 
+	if (ops->ooboffs >= mtd_oobavail(mtd, ops))
+		return -EINVAL;
+
 	if (ops->ooblen) {
 		size_t maxooblen;
 
-		if (ops->ooboffs >= mtd_oobavail(mtd, ops))
-			return -EINVAL;
-
 		maxooblen = ((size_t)(mtd_div_by_ws(mtd->size, mtd) -
 				      mtd_div_by_ws(offs, mtd)) *
 			     mtd_oobavail(mtd, ops)) - ops->ooboffs;

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250831-mtd-validate-ooboffs-e35c796540fe

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


