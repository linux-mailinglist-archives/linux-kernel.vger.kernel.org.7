Return-Path: <linux-kernel+bounces-767467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAABB254A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1EB1C24C26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627A29BD97;
	Wed, 13 Aug 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UF7LKToI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327B1DE2D7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118014; cv=none; b=Ow+x9c5IpNZYLcIB/Id7I3xbGH2llhic5jnpbjSe6KG4Ei5OcWnRIF8MSkRjuLLuQtXiNXAv+whbtIVzR+k1knKCkNLGztATkOPoZM311531o3AYvbgjCpXpySYE3WXhYZ8jloXCu2WndxNe9gzBnBahoqUmO3NoVV0vJRa1rJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118014; c=relaxed/simple;
	bh=3msZVg0HRJb3iRLBV25DLd2/0IRJKa8M5nKvdTDwsE0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fEYdwm/fq+DuKDnhYpTFi3aiVjCYqkhjb8cdaXjzjVGxGr7x9SnfpLkdkgOXiTisXV28k/YJBkrm5OBiCYNJMegPNGmAb543k47KcV1zZ9UqKZ0MF49pAp5aLCyQi5/c2lfI0jnpcjNfTeeOVoIMJdQ+KzLSUFJmSc6quD4v2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UF7LKToI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445806eab4so1479665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755118012; x=1755722812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BPb4y3nft44GjGTyIn5iIw4m7Onuiy/xdmv1KPATuDs=;
        b=UF7LKToIVZ7xYboQiRYz8R76SyqYGi2/7uiX4XUzFqggwEKoMwS3Aszi2Z1gL/r4cT
         Kb8vxzsP5s99yXkXi/LwhRJlnZCxFIKTlmfzMtZrfCP5iCBLl6Udf+HPseulj7HdA02y
         XM+obMDv6fSP/V/rRykDR1+aLbWmc9Gto/r7gRMW8UrsV36vILX59fIUNzTF0oAHnXq9
         pIHoxIS8EXksHliSoNiiSbAmex0W08e6+/+12yy0394GjmmHo9+iI+11V9NKK5EmV0Mx
         GzO5JIaS1je/M8mLvb2H0ZhsBmbvBI/wEkXRX+bCZePvjIhcy8zzj9pZCnwb1WHQaS+H
         fyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755118012; x=1755722812;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPb4y3nft44GjGTyIn5iIw4m7Onuiy/xdmv1KPATuDs=;
        b=d44+rLDNQxvPjCIFsBdeCOO6F6iqySGUdE5BVH5uz9C/T80c0qoCYhPNDptVs17i3f
         HprKfTBJ9QS8FPIZzVaNxNNUXxs8rqOJqo+UdbbcbMAp3rXrMDr2vm90PpManFbRZrY6
         LD3Dk5A9EHCVpgvkDIL07lbN+aEf/wqYiS+TkQbU7rYWd3ZHBJifvLLkVpuqgOQTdYaF
         RBk7YNMhX/zpNFUMjwWi63SlUgqKoUQGGJJANUwA+BG5wm13Wh9M3Qwi1ugSZXIXiZan
         lVMmPGeQkrxYYK0iJM3smOQX1bC0WVY9SbFy0dC26Vz+0Mq50/Z4V63A8vlACCzCLbVq
         cRGA==
X-Forwarded-Encrypted: i=1; AJvYcCXqlt3X+70OruYUHDkVTy9eTaIlbT4ScwEosgABntV+9Cn3pie89cZrLFMNoWIvcfGOVA2wkd9hGjbvdIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa15aMw2ePg01aa/ZXS7EksR2s1BeFL9MD4gzL78cXH80NmJwa
	U+LpCuoj57sErb6xEFNQWPUZ6f1I7zvGK8by2Aos7MrRFT2AYRNbEQ6DhjkQ5mxjuCwxwpxTiNt
	SwEDWRyYfv4dVUQ==
X-Google-Smtp-Source: AGHT+IFgXz7gVJeHrHVNI0YMYiBrpI1xtsujBpCmTgabA3qV1nDHzl4U4ZVxCdNm8xMf+diL2uY2q6ZIW6eh1g==
X-Received: from plbp6.prod.google.com ([2002:a17:903:1746:b0:23c:7695:dcc5])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db12:b0:240:417d:8115 with SMTP id d9443c01a7336-244584ee7a2mr6975095ad.16.1755118012159;
 Wed, 13 Aug 2025 13:46:52 -0700 (PDT)
Date: Wed, 13 Aug 2025 13:46:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Message-ID: <20250813204648.1285197-1-ipylypiv@google.com>
Subject: [PATCH] Revert "ata: libata-scsi: Improve CDL control"
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 17e897a456752ec9c2d7afb3d9baf268b442451b.

The extra checks for the ATA_DFLAG_CDL_ENABLED flag prevent SET FEATURES
command from being issued to a drive when NCQ commands are active.

ata_mselect_control_ata_feature() sets / clears the ATA_DFLAG_CDL_ENABLED
flag during the translation of MODE SELECT to SET FEATURES. If SET FEATURES
gets deferred due to outstanding NCQ commands, the original MODE SELECT
command will be re-queued. When the re-queued MODE SELECT goes through
the ata_mselect_control_ata_feature() translation again, SET FEATURES
will not be issued because ATA_DFLAG_CDL_ENABLED has been already set or
cleared by the initial translation of MODE SELECT.

The ATA_DFLAG_CDL_ENABLED checks in ata_mselect_control_ata_feature()
are safe to remove because scsi_cdl_enable() implements a similar logic
that avoids enabling CDL if it has been already enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 57f674f51b0c..856eabfd5a17 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3904,27 +3904,17 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 	/* Check cdl_ctrl */
 	switch (buf[0] & 0x03) {
 	case 0:
-		/* Disable CDL if it is enabled */
-		if (!(dev->flags & ATA_DFLAG_CDL_ENABLED))
-			return 0;
-		ata_dev_dbg(dev, "Disabling CDL\n");
+		/* Disable CDL */
 		cdl_action = 0;
 		dev->flags &= ~ATA_DFLAG_CDL_ENABLED;
 		break;
 	case 0x02:
-		/*
-		 * Enable CDL if not already enabled. Since this is mutually
-		 * exclusive with NCQ priority, allow this only if NCQ priority
-		 * is disabled.
-		 */
-		if (dev->flags & ATA_DFLAG_CDL_ENABLED)
-			return 0;
+		/* Enable CDL T2A/T2B: NCQ priority must be disabled */
 		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
 			ata_dev_err(dev,
 				"NCQ priority must be disabled to enable CDL\n");
 			return -EINVAL;
 		}
-		ata_dev_dbg(dev, "Enabling CDL\n");
 		cdl_action = 1;
 		dev->flags |= ATA_DFLAG_CDL_ENABLED;
 		break;
-- 
2.51.0.rc0.215.g125493bb4a-goog


