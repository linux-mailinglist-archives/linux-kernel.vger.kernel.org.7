Return-Path: <linux-kernel+bounces-744916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE69AB11272
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8784E3313
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43EF2E612A;
	Thu, 24 Jul 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="so30EaTm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E22737EF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389495; cv=none; b=Fs5diUFY3jTI+yt8T0qn9d9lrwwGhR10mMg/s41fkZst4qtIGuSWDb482u4OFcILApcOpgfHpRy8FXBjEeT/fClkFYjSBJAk5tw0tA3Q39TOjG2AMzCcBm21RLdc2tlBV2DEBHA1aj64Go3EZpT73xf+BCk85T1QBJTyme9Wz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389495; c=relaxed/simple;
	bh=rnwg0fyNj14IsyUcW7zraNjJJfsVMuV1IWAbK23IUC8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e8NWkQHZ+xizMhVRU4Z6JtcdYQeS7Jo9ptEbqoSFz6eQak8kzS1N6nMluBuSZEe0kFgSywY01CEpKZ9Jm6Z/u1euP3tDMzBZilpBBmbGxYM/uL48W2xTWuozS0ibYswWfIQbxmGORGf4ZPYt1HklubejG3HDR7oyOt9gQeEkq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=so30EaTm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311d670ad35so1255772a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753389493; x=1753994293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vij2BC2mcGcQQ0GQvWklo4RarfwpuOFR+GxpFmV3AyM=;
        b=so30EaTm3xoUToR8cSThvQ3cH4kBbtPnOvt/RVZikbEyBSWXBrkx0uk/9qR43++hy5
         gUZDEV0qSEv9v52bVsbJ3nBPNHh6ZYMDXhYiFT7+EHwIi0chjBbcEemZ/AJUx73S2yZ5
         QswzOHZtJGjvtVgF0A0dQNPFwGcMBv2kEEfT7704ak58n7FgR6g2cwDNnNfnhngxVgPW
         HdQOa5cstAYPD1A4Uzn7uvuCsvS/NHpqAj5QGqQfUiZhVDAwLvnyPH1W/7sxKCyjN8fH
         BQXE8cmxKHGcXI6FOC1aoBSbtksN6QIGvkKnLrb+lYDl7Ts545OL4AfcYDZoomdFkj5x
         D+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753389493; x=1753994293;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vij2BC2mcGcQQ0GQvWklo4RarfwpuOFR+GxpFmV3AyM=;
        b=RV053TIessnpAF+82Bzlq1TyEqchEBIYZC0E9VggJnkEqKAjp/Iz//V4ZwEctEfavt
         1rDZulJSvvwHC/7f6LO2pp11WTaIq3fbmE75GIqdmgBqQJhNFuPG6gD4y2C3YJsxX1+O
         ZYPkLnbwlcpc9tvAS8GCg8G8MUaKqOeb8lSho+RDtqzdpAgCIwNPPsbzJrdHyN/xW6kc
         EWbEVK2Qf+stAMPFfJV2cQcelSedZiVeAhrWRseVxffmwHnnaKRAee0EoUqLQVcHQQCB
         mqLPtsXh7/wPOjrlgj2RacoJy98Hbngiw/J436LbY8pIcykM39QceCZMUXxkYy9Jxi5Q
         292Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzL9ph8YkPGRCxCP/rYe4eOmZm+bjrawTjr7RSSXmrfb2orF/b7r+BzX4Ao3p+Smev3u1Ls3pyGX50gcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbV10QQjMvGZi0IpCps+0Vp1sMO7O8MsfDclLDMOPvDjeyPLOX
	SoByYwp1kYoTqWZDkS3Yl8w6nNnX9i8Za7GrpqaSkjzeQP2rqqrEsPKJ3PP7chjJUrzuYNTqO6r
	hMRLJxWoVtwd6TbcrLE26P1Mobw==
X-Google-Smtp-Source: AGHT+IFB9+7JDM5Z5/ZK869HjDWji/NS/K/eY8iUWB56KqX6g7hLiJyqwGX05uW8REXXxaWLboBjI200l+v1f+2Ucg==
X-Received: from pjqq7.prod.google.com ([2002:a17:90b:5847:b0:31c:38fb:2958])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:518e:b0:31c:913e:b121 with SMTP id 98e67ed59e1d1-31e50818ab6mr11706020a91.19.1753389493124;
 Thu, 24 Jul 2025 13:38:13 -0700 (PDT)
Date: Thu, 24 Jul 2025 20:38:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724203805.93944-1-salomondush@google.com>
Subject: [PATCH] scsi: sd: fix sd shutdown to issue START STOP UNIT command appropriately
From: Salomon Dushimirimana <salomondush@google.com>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishakha Channapattan <vishakhavc@google.com>, Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
manage_system_start_stop") enabled libata EH to manage device power mode
trasitions for system suspend/resume and removed the flag from
ata_scsi_dev_config. However, since the sd_shutdown() function still
relies on the manage_system_start_stop flag, a spin-down command is not
issued to the disk with command "echo 1 > /sys/block/sdb/device/delete"

sd_shutdown() can be called for both system/runtime start stop
operations, so utilize the manage_run_time_start_stop flag set in the
ata_scsi_dev_config and issue a spin-down command during disk removal
when the system is running. This is in addition to when the system is
powering off and manage_shutdown flag is set. The
manage_system_start_stop flag will still be used for drivers that still
set the flag.

Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
---
 drivers/scsi/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index eeaa6af294b81..282000c761f8e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4173,7 +4173,9 @@ static void sd_shutdown(struct device *dev)
 	if ((system_state != SYSTEM_RESTART &&
 	     sdkp->device->manage_system_start_stop) ||
 	    (system_state == SYSTEM_POWER_OFF &&
-	     sdkp->device->manage_shutdown)) {
+	     sdkp->device->manage_shutdown) ||
+	    (system_state == SYSTEM_RUNNING &&
+	     sdkp->device->manage_runtime_start_stop)) {
 		sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
 		sd_start_stop_device(sdkp, 0);
 	}
-- 
2.50.1.470.g6ba607880d-goog


