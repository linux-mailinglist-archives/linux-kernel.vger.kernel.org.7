Return-Path: <linux-kernel+bounces-744983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AABB11341
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108724E2035
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCA23815B;
	Thu, 24 Jul 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8arfhh0"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90A1FCFFC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393530; cv=none; b=PuicSl55Du0bAgTrS43zSbnlNvKCy7tUFfJT8Rzb1KlCDJWmVB0cY8ebEQd62Y6SfF6eNGBsdAnsJpmdgqbEmPmoDFSEQ43uXjmHtxovQOhGxBA6lrbYri/BR90mEq++DZMJU18lf36wIXNwLl82ePsoNwdtXaotNh3k0WuzjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393530; c=relaxed/simple;
	bh=meBHuQUy0HZDNI1b1+5+zFkNhHAWXgm156Of7G6LTO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gfaLQUu1CbscpIj6itWAgmq8wZLzX8IJlTeA8ldYdQcellGQWFVLqhWoEb9yzBjWbYuGOsjwcGm5XuAp/ni+HehJaZ2xL4zBx6ZuPbNBFypTne54XYtecU7gL8ADaBjN16+MMgBs43Tm4DrV621wjQv70WBzC7NE4eBH7MHsqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8arfhh0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31f112c90aso1232154a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753393528; x=1753998328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTVJQj47abNavjkOFGpoexpL1J4hRU6fXNZH9TMhCm8=;
        b=s8arfhh0Q5dOwrk2GpwMcRpVnw/XGLuw2G/x6YLFJh4EwgL/YeKQm8uAOFlGySNHWd
         ZKxCxTNphKV+649Fm/qfAZPxnZitlNuKckihu1bL0bJ4zN+DgFLVzub9Z2M/pXHNaQnO
         0LNorgXwMNK9AKWdaKPWqDn8BumXqefmfvoUonBSRGm80S76DGSFbKZkisugZwLyxdbl
         r5arNCvXn3iYw3rxyNOqIwGQVpYNl8wv0hsSE42Rp2qBGURP//SSboTtml6+iKg8wMh9
         x1RYWLKCZHxjVy/+W7fM9zW9+TwKIUjkiKGCzfVtR7rlr1Cqde2ZQ14FhL+OTGgQV4ro
         1iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753393528; x=1753998328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTVJQj47abNavjkOFGpoexpL1J4hRU6fXNZH9TMhCm8=;
        b=NsQDU0p1F6+Q17ohxscyGRqML1+eXAYLJg3W76Vrmj5O76KSkRYaUKGDzUUAPcCrj0
         jre4I5k2blp67BOqzQJ/uo95gFbKFuo/fmh+vqzlzbUuEADVfS5/H/tJceS8s7jc8cp+
         Bxe7ZAVWN6E5y5adcdW+Gwu00bdVX6B17wPYVOjAigU1lxK3a9gj4VePxpxflkNi5Y07
         C4yiaMX+A6ZR1DK434UxzzR1fBtJmC50iYpcVUBM9iQwJY6fo+Ic1iNzKO3Ecl9b5945
         cPmEV939impwAWln6tmWRWpetVhiIqK0pB/9HDhodOk8xO9IuZrBIIEzCmIlvtGS8sNs
         axUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxtTjJzEq3fqEv8YHbRlrWVEuIWpFDWpZp1koEMoqqnKa5soghLTfuntfmvE4bXczPycQIV73RwGqCEG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJNNHzj/sY14KrdAo1Nn+T40IQMVEkOhmVkjPbyMhFp1+RT+d
	e5iExao334bxBLDdydDii0wA0PpZN+YNxQi+1hNE8VpgMEFRuSEd7mpyFx4erTJGrAGZ38iJktc
	NqI2Ehpx3YEJ4ty0Q5LP8Lgo0GQ==
X-Google-Smtp-Source: AGHT+IH6JLvFmKC7DFvAj93VBvWQVZwn3ZOcH/hQrcqQ0Yn7V54/1jAq8qNRCr75UOA17JEmucOBKaxqNF1ush2+7g==
X-Received: from plge18.prod.google.com ([2002:a17:902:cf52:b0:23d:dd69:dd0f])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:248:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23fa5d24b07mr62971725ad.12.1753393527930;
 Thu, 24 Jul 2025 14:45:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 21:45:20 +0000
In-Reply-To: <20250724212137.105270-1-salomondush@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724212137.105270-1-salomondush@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724214520.112927-1-salomondush@google.com>
Subject: [PATCH v3] scsi: sd: fix sd shutdown to issue START STOP UNIT command appropriately
From: Salomon Dushimirimana <salomondush@google.com>
To: salomondush@google.com
Cc: James.Bottomley@hansenpartnership.com, bvanassche@acm.org, 
	dlemoal@kernel.org, ipylypiv@google.com, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, martin.petersen@oracle.com, vishakhavc@google.com
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

Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
---
Changes in v3:
- Removed unnecessary tag

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


