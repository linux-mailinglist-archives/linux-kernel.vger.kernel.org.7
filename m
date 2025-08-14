Return-Path: <linux-kernel+bounces-767818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE7B2597D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA547B6582
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC22580F1;
	Thu, 14 Aug 2025 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/4NvSFP"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F34257AEE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138182; cv=none; b=FmkzaIF1ypkS7zqfC2enj/JfPI5PpQgyEK0Kqrh1UE1l6NYHfaVAoYmnWgpkXnYIKJgBA/CvtKrQqF6QCYEWlVs6YPGEczrPRO/f8+2AU3E6BEmrvO4eUW5kpu4lQICKNzoTzu15GWNF08/LhtKXqZGxMhfEs9NKAOmmvkNnIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138182; c=relaxed/simple;
	bh=dcV4l8LTv/afYKK860pyynAL/DBUCVE2Icn5FEwI7UU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EqRjvvmKnyDKYGp+C6i11qL/0Y/0V6yLIed/4eaStunjB4GKd3jLKzfED3DTnOGq7U1Iun2EURkRUgxp37UBmbxCwmuVDEsPvBp1gQoaC3oqORtC+HXzAbfSwbJGD4DsyKgYlyDfIMkkyvek2wePzB35bvKHjq5zUKlHHW+kJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/4NvSFP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e591846so441031b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755138180; x=1755742980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1PfTMiUYykgWzjiwUXi6YEGJDzxeQvVGZ/bXYgr1boE=;
        b=i/4NvSFPmEe2U+l/86r28Rlj/RUMThGDOO9mUDwvFfcfhuOdlwbfLjNzd8E1rN/FNH
         FK/3tmPW4uBX/2Vxj9FwSjLW4BZpE2B+44Y9TsysirZO89r9/ZIg4y5qoyTnbmQvvLaN
         mxpEhwlnHQQZQ8nNhtO9rgKj8FSbOXNziIccf38Q7qk9aQbRNf0DnatxNT2J2uC0xpt5
         em3ZP9c0kj4TZNxVywYISF4oSaAg6404XLXV4wU+LQSxvnWsYhSMkUSKke+gAsQ065f8
         cHIFNJ1eaxrFrcwsBR9xc1lqarPyVnjWHg5RYx7pK8N8o9tmMaWjbg+Wwanb0Js1/AXZ
         43Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755138180; x=1755742980;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PfTMiUYykgWzjiwUXi6YEGJDzxeQvVGZ/bXYgr1boE=;
        b=Xfn7jDI3ZbqIGar0GboFKaDKENDkzYADeB7IwklYJpldABtEPaAehUdBwWSkHe3LD6
         BGanGDe8tRFdHOMSzXtURM7XqBykguPK2b8nbLAlFBJznbbzFpujCQ6f611R45D3cEhc
         Jq3Z22Ckqjz4EXeY3PzUNYTtetJ4ZrwDxMY+OzimIx9N1ICYnJLkZLSOq/Nb6ntHPPBm
         8MKpzc/j7lgi/kQe6jZilSlGY9CC7M0yKH67s/aSYqPOeiFUvwpXfEEmDg7JqPm4Ea4m
         ywflNRoegmPUfYmDvewVo/+auUhvyY4zBdnnFzjhq3w38DdjjGKMLYoBx28/hGM++Mn0
         gseA==
X-Forwarded-Encrypted: i=1; AJvYcCW/iCzZQvaDffghrsQyjPjv8RcH7pR9fBv25ypsgTQ01uvWHZqJBoIwm94QjxUczgupRRIQ1k4Qu/F/qSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziMcu9g511t8Ywnt+OZImj2P4YFs+HQyNoua1UKfQL+OKNX5Yy
	p6YVRe7OZHuB19PYmm2jBuU6I9W5Nq0ytZ/BJbaoXCEsvdtpy+agtbPpZBkg7s3VfvbIM8MytJK
	FCz97WYBJMAkpTA==
X-Google-Smtp-Source: AGHT+IEwBHdOWTTeg4bGpQ5x3tG8ffn/xQTeFDwj3JxJG3tBW2UsjzNN11QT8n4e83V5gJEJAwY+jo2jIEEajg==
X-Received: from pfbhq26.prod.google.com ([2002:a05:6a00:681a:b0:76b:ce38:175])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d4d:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-76e3293aebbmr1333444b3a.11.1755138180427;
 Wed, 13 Aug 2025 19:23:00 -0700 (PDT)
Date: Wed, 13 Aug 2025 19:22:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Message-ID: <20250814022256.1663314-1-ipylypiv@google.com>
Subject: [PATCH v2] ata: libata-scsi: Fix CDL control
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete extra checks for the ATA_DFLAG_CDL_ENABLED flag that prevent
SET FEATURES command from being issued to a drive when NCQ commands
are active.

ata_mselect_control_ata_feature() sets / clears the ATA_DFLAG_CDL_ENABLED
flag during the translation of MODE SELECT to SET FEATURES. If SET FEATURES
gets deferred due to outstanding NCQ commands, the original MODE SELECT
command will be re-queued. When the re-queued MODE SELECT goes through
the ata_mselect_control_ata_feature() translation again, SET FEATURES
will not be issued because ATA_DFLAG_CDL_ENABLED has been already set or
cleared by the initial translation of MODE SELECT.

The ATA_DFLAG_CDL_ENABLED checks in ata_mselect_control_ata_feature()
are safe to remove because scsi_cdl_enable() implements a similar logic
that avoids enabling CDL if it has been enabled already.

Fixes: 17e897a45675 ("ata: libata-scsi: Improve CDL control")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

Changes from v1:
- Changed the patch from revert to fixup.
- Restored debug logs and the comment about mutual exclusivity with
  NCQ priority.
- Dropped cc to stable and added fixes tag instead.

 drivers/ata/libata-scsi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 57f674f51b0c..2ded5e476d6e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3904,21 +3904,16 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 	/* Check cdl_ctrl */
 	switch (buf[0] & 0x03) {
 	case 0:
-		/* Disable CDL if it is enabled */
-		if (!(dev->flags & ATA_DFLAG_CDL_ENABLED))
-			return 0;
+		/* Disable CDL */
 		ata_dev_dbg(dev, "Disabling CDL\n");
 		cdl_action = 0;
 		dev->flags &= ~ATA_DFLAG_CDL_ENABLED;
 		break;
 	case 0x02:
 		/*
-		 * Enable CDL if not already enabled. Since this is mutually
-		 * exclusive with NCQ priority, allow this only if NCQ priority
-		 * is disabled.
+		 * Enable CDL. Since CDL is mutually exclusive with NCQ
+		 * priority, allow this only if NCQ priority is disabled.
 		 */
-		if (dev->flags & ATA_DFLAG_CDL_ENABLED)
-			return 0;
 		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
 			ata_dev_err(dev,
 				"NCQ priority must be disabled to enable CDL\n");
-- 
2.51.0.rc0.215.g125493bb4a-goog


