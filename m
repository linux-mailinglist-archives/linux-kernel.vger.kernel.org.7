Return-Path: <linux-kernel+bounces-874002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C2C1549B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C71A4EE8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7806C2E7BAA;
	Tue, 28 Oct 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHXhqDL3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA42571DA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663351; cv=none; b=JyKTIIoqitUvIiINm3vRiUvoAF3sFn6eDtRMwbFWeT+M9nmZM1x6Ml+jX0n5SlTb2hGpnY+AaU+kvBRfuWsPhPh4BXhM8+ED3sO4AyzPSquoIZpgZw4qzO4vbzJQ8o8JVHwatzFeSK9G2BfywQ9QPL2qYogMA54fVCAfitAJgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663351; c=relaxed/simple;
	bh=4DfI7OcUnB+kIuMTQXNdtCg+eWdy+FCdGYX959o/v1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KXwBS1jH/PIRD8Uh3z8MrIvJv1fTnq9lcoJ9A3LZo6u36N/vJurHTrKYFN+cQvYa1AmJ84X/1JQnae8VBxLVkBZuyta8KYJX1tbETZIELI51fGV5nMZKPozQqq5TDCjGDCb0S2GTHIAvDefNbAOQ26H0yRN/dAzOeG8EnaPOOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHXhqDL3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f22b1e49so5555459e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761663348; x=1762268148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxgC3Ar205SePZa68q9SjHUQRYO31L1UuAjDONdLHVE=;
        b=hHXhqDL3w0Vx6kMG51Fjk8jFxIYahWeolRhcGDxl+8U1LvwlXinDUdnMXcSe3tk74v
         lXAVT9iEYfr+8eTv2+h+HL1LzQ5DxMA3NXV7w/cHcbuk4wtwhN5hR6qQAI50cfIce2bO
         1+6VRN7oa4Kw15FR5RBiIxwInxGbbc8uh+Fuu817GPf/neeYeqmQWRwjBLMkf4RacqVF
         QrfCJjpt8/ZMyhV0eZHJ3bY8Icqtqwae79eG53QTXu68q1fomyZLYtTesr9kKvPXiZb8
         5TrfHPh+0J+hUR5T75LseO91sDCWUq46+k5IugS7brnGxKwyaRdlQ5Da/MHKw3SOGCHs
         8BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663348; x=1762268148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxgC3Ar205SePZa68q9SjHUQRYO31L1UuAjDONdLHVE=;
        b=CoJyxlzrNc0xqFf4JMsGRkJhnwfeKBY6jMuz8XdRUkvCHQAuUrGb/zrXhBCH5NBqCO
         l0v7xO85m6HSf4iSeSee33OTFEin/hJCLEkzVid+yCScTVIM0Hrr3y9xEBO7CP12ZGOy
         /tEWyKw5Ab7ZBj5yjt2u1Vbg36w6VwOGUOZkioXdoFRpFJz74tom5dIzbSRYoSmSzgWU
         6rhS8mpw5e3/4VcAuktIrUMFCSJ0XRUtL5A4dFYfV1ehT1QmShsxrc69+g2X0EzMTvua
         U5th2CmJ7erx4Hvb5PO/hi7++xbWTIDPRquyq691645uak3m1By9lDsxg4XiQN/I1pq5
         kegQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuXWiHCSVnugsCM1feeieDwMuCjHqLVsgaBFN+UKC6ipm2z3pbXM7h7csD7/3Vdldc6MCSBZ9ytu23yuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpc3kz5o1Zor3qXpvGNQrE0BjFPg6fMqNEKmySRKcV/LyIG742
	7B5zaE8cJQPGe8847KIi906V+Fq2jW8nRCNdMkhIMvM+iMVVeWf5yJF/haDwuesC
X-Gm-Gg: ASbGncsFWb4N0A8jlp46rWpeHi3u11Iq8g0DGY0ufPtsa2LYVWszeHAVYIrSnpEibvD
	P6YQyeUr5CuQoCaGMB/no2zMcI/h9Wt4YM1P+yTURBd/zNF6BLP2yoXk4MT34kZ0jX+egZyqJdT
	hMu0H2fUKSoFqaETaL1M+P916ImtlJuXxJIeTfZDejznv/6NKeP4XUqKORR0Y2Nwiqigzoz7T+A
	ydm1oh9Gpv8r9XZqPDD0ei4dBQIzHl50gTYHcauJnVAAJl9NlmLrijrnAxTK+Fvuplm/syQua/9
	CZKVHcK9lvvGF9AiR1tSZhX3Xm0t/1G1x2SyYbOyTsB4brBat+VZmcOjcgN1cFTfBILMy9uEXAU
	6yjYXo/qUGm/byr3mWDHlIQfvEQT0G5Zp8qsRX/8RXNM88EneMvFE+NdvDlJ8uK7TFqN5uPLrGn
	dWHhQfbG5ax2lKnff2cIGrt2unVMfstNp61pC4wzcEjMvTBwZJpWM2S84mSDFCss/iBnZjYlxxW
	CwAVmJvbA0CDyzJHmLGfd9R5Yp20Fc=
X-Google-Smtp-Source: AGHT+IEYtMFNcBTkx5BcQJAnt4IjKAPptrA7hwRAVKe8cUNymnzw27KPZxunv/Xg4w6rE9Z8xlhI2Q==
X-Received: by 2002:a05:6512:b05:b0:592:f9f4:7932 with SMTP id 2adb3069b0e04-5930e9cb1ebmr1304002e87.33.1761663347674;
        Tue, 28 Oct 2025 07:55:47 -0700 (PDT)
Received: from localhost.localdomain (host194.safe-lock.net. [195.20.212.194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59302878849sm3082988e87.80.2025.10.28.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:55:47 -0700 (PDT)
From: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
To: sathya.prakash@broadcom.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	sreekanth.reddy@broadcom.com
Cc: martin.petersen@oracle.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
Subject: [PATCH RFT v2] driver/scsi/mpi3mr: Fix build warning for mpi3mr_start_watchdog
Date: Tue, 28 Oct 2025 15:55:34 +0100
Message-Id: <20251028145534.95457-1-kubik.bartlomiej@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC warning:
drivers/scsi/mpi3mr/mpi3mr_fw.c:2872:60: warning: ‘%s’ directive
output may be truncated writing up to 63 bytes into a region of size
41 [-Wformat-truncation=]

Change MPI3MR_WATCHDOG_NAME_LENGTH define to properly clarify
the required buffer size.

The mrioc->watchdog_work_q_name buffer in
the mpi3mr_start_watchdog() function no longer requires adding mrioc->id,
since mrioc->name already includes it.

mrioc->name is built using:
sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id)

Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
---

I do not have the hardware to full tests it.
Tests only built kernel without warning and run kernel.

Changelog:
Changes since v1:
- Add define MPI3MR_WATCHDOG_NAME_LENGTH (MPI3MR_NAME_LENGTH + 15)
- Change watchdog_work_q_name buffer from size 50 to MPI3MR_WATCHDOG_NAME_LENGTH

Link to v1
https://lore.kernel.org/all/20251002063038.552399-1-kubik.bartlomiej@gmail.com/

 drivers/scsi/mpi3mr/mpi3mr.h    | 3 ++-
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 6742684e2990..be15d5ec8b58 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -66,6 +66,7 @@ extern atomic64_t event_counter;

 #define MPI3MR_NAME_LENGTH	64
 #define IOCNAME			"%s: "
+#define MPI3MR_WATCHDOG_NAME_LENGTH (sizeof("watchdog_") + MPI3MR_NAME_LENGTH + 1)

 #define MPI3MR_DEFAULT_MAX_IO_SIZE	(1 * 1024 * 1024)

@@ -1265,7 +1266,7 @@ struct mpi3mr_ioc {
 	spinlock_t fwevt_lock;
 	struct list_head fwevt_list;

-	char watchdog_work_q_name[50];
+	char watchdog_work_q_name[MPI3MR_WATCHDOG_NAME_LENGTH];
 	struct workqueue_struct *watchdog_work_q;
 	struct delayed_work watchdog_work;
 	spinlock_t watchdog_lock;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 8fe6e0bf342e..18b176e358c5 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -2879,8 +2879,7 @@ void mpi3mr_start_watchdog(struct mpi3mr_ioc *mrioc)

 	INIT_DELAYED_WORK(&mrioc->watchdog_work, mpi3mr_watchdog_work);
 	snprintf(mrioc->watchdog_work_q_name,
-	    sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
-	    mrioc->id);
+	    sizeof(mrioc->watchdog_work_q_name), "watchdog_%s", mrioc->name);
 	mrioc->watchdog_work_q = alloc_ordered_workqueue(
 		"%s", WQ_MEM_RECLAIM, mrioc->watchdog_work_q_name);
 	if (!mrioc->watchdog_work_q) {
--
2.39.5


