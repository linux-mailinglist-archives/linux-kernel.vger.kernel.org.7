Return-Path: <linux-kernel+bounces-744962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E48B11300
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6D17BE3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DE2EE5EA;
	Thu, 24 Jul 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDAP1sUn"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033E2EBDF5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392110; cv=none; b=nFaobKiKP/7dX+AKrfoyAux4pvWKARr1AWFNbK0L4GnwDq4a5HAqg0n3kLjJkNXnQYBFBmNXdGvRpM93qGKNLXjejBrUfrcltvzSJZh/iMuUtbRqTrlARxz/Poq1W6rqQdvlAUqJBlABvd2/uUcU4KObyiyFilGeEEfV4LrskPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392110; c=relaxed/simple;
	bh=y1SIf7gY43SwKa7IR0gF6UJkqjIsuRGzDo7QEIv7M80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qebKgV4kZTm/OMcZb7jKya6HY82IIBdZzhFh6qdJK+KBC3ms4OzZEpbYV4NSPyaCHKKoQLxvR+wVN9Lw0MuhkbclO11MpSiKCeJ/Rq7i5HH5iASYXTNzPdmHC6FvUqij1Fw6OwBjbfdI1O5p9Qeeg6XHAbBQpeVhfYYoc92Exus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDAP1sUn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748d96b974cso1291527b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753392109; x=1753996909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/z17J3MJSAj5T5y3QojA2SOzybnkEbHLfb3RK0Rs3s=;
        b=KDAP1sUnx5g6oQjaMm1W7ZI5yqss0ELQiP2kqQ59rAuqoWDBUMR/1xMYkpP6j83eqf
         IQsTukJEcWnxN31NTcLh/wCjCjzEL5RxTEYS33Ya7Hw4VXlgZBNER8cZxJoo/36VgL2u
         ZC1pafPPAhlGRtK8yw6tWaJHiRVbQzv8xC0az+SZh6PZk8Ej9oUtsX47WCnh8QyEYn5j
         cxYI7mmhgASTAJECrI8Yhf/8fF6pWmRO/iwKXRnwdbOCOknsXHHN8sjetYA9GwMcK0c1
         l9iOqec4CimewV2a1gHihFLGLtn9uqhRDjupRrhHaOHPzu/NcEJF3wXI3aVbipEYJiG3
         H1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753392109; x=1753996909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/z17J3MJSAj5T5y3QojA2SOzybnkEbHLfb3RK0Rs3s=;
        b=G/JYXQF3Qmi24nqP1qlGn1MqCwF2grdMVj2Ja22wVMK4Jf/eXKYwvhlq9sexp2Jq60
         n9hVIZQSq/ePzMh7taWT93Sg44EJ3rgTlXDe8YJVVPrKFzTZJ9zKXGxzDuXBQBC9Cgft
         msAjNnNM+KeIbHfzL3061Lh6nxKj2LDAwWHUJusXSZzBCYES2Ivdx2NChhgsDVO4Fgs0
         lrmwXxl72YEuRTAoN+dkukOpEGnfeqtXqxHvXSa74ZXJ72irsMsqd5pw3+W2je16CQ8u
         jMJldU6SAATwNaJ6H7pyk5R4fX3NmNPy3tnsr4x8ydlDwTFyc8ieWAgjlAMecMddsAjp
         XR5w==
X-Forwarded-Encrypted: i=1; AJvYcCX3fEZBN2Po7SKWTxf+/1RezElel52eOT38uH0Yf/EhJA3kB6BPKF2EEqf9pR2mOy7+cWIpX31grElljdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXdg7eRnbxFuF6A61QGHQkrbOmQWAyfjOOTabNnEPAvmRFKM4
	L451sLwp2BQqOs2G4Fgpg/XnGuXd5ympKqF0XhvFHFUFtbPBfatVJ3gX/gspqEtLaeW799mEHz4
	yjDTMtijSlYwXGK7R713vlmnXXQ==
X-Google-Smtp-Source: AGHT+IEJ9XYOWVgjjXZ78n5qyUTxKXo4rnIJzirVFj5roXLp7h/SZ8Os1OF5p+0AkWDbfIK/trpg4rsoj9Lv2j7KrQ==
X-Received: from pfbmy24-n2.prod.google.com ([2002:a05:6a00:6d58:20b0:748:df52:fdc5])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:14ce:b0:73d:fefb:325 with SMTP id d2e1a72fcca58-76034c002ffmr12500904b3a.5.1753392108676;
 Thu, 24 Jul 2025 14:21:48 -0700 (PDT)
Date: Thu, 24 Jul 2025 21:21:37 +0000
In-Reply-To: <CAPE3x153br+UdtWYnxdtAX7hz2OwKYovQeWdeOCWvicTxDayeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPE3x153br+UdtWYnxdtAX7hz2OwKYovQeWdeOCWvicTxDayeQ@mail.gmail.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724212137.105270-1-salomondush@google.com>
Subject: [PATCH v2] scsi: sd: fix sd shutdown to issue START STOP UNIT command appropriately
From: Salomon Dushimirimana <salomondush@google.com>
To: salomondush@google.com
Cc: James.Bottomley@hansenpartnership.com, bvanassche@acm.org, 
	ipylypiv@google.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com, vishakhavc@google.com, dlemoal@kernel.org
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
Change-Id: I820269189d1a2ee03795b8c0db41aa50c0cb484d
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


