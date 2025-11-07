Return-Path: <linux-kernel+bounces-890360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706EAC3FE6E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F063BCEC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD724293C;
	Fri,  7 Nov 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XleZ2MVw"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD41CAA4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518813; cv=none; b=o0ou6l/LNF/TP+Q0laI7lR79w758gd9BCQXR92BNKprqbxPp7mq1T7Y9KjHC8pm5oYQ+Jh6gzpS1b7mVIfyClXQFDInGyjAa0wZgrFF2sRPQJiPY4PRN/nRS1+QDnRHPhTE1Y9HoMxwyWTToGPc6QluGA3DRWhKtlJzJy77GWMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518813; c=relaxed/simple;
	bh=5lcnyf06aV0IL6EQb9F8CzVHgFLLL8ViHujqnpHB5v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVS73t97BNNTq62LQkXdAFKu0kjyJSbIvaPSfl39CQ/P5ROZudkuA/wkiKhWPe9rWgRfkRggo1AscW2J3J8XdfHHkgZ++xKSGXgZEVSl/zWyiwnfnI437gLBm1u3g0NAelSSyxX1rTA7BPUCjxzN5OEfcblsM0m1H6CUUYS8Ico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XleZ2MVw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so588321a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762518811; x=1763123611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wFg4sEi9OuCa1c0qwdmYGRON1nIlfIlliXKoJp2VYg=;
        b=XleZ2MVwOJTKC6W/6mfrsL0h4LHHxq7EMz1xZPJCRrKlj5ohCvU6n39MSWybzmvR94
         /C4LCtGf4+MYPLiPHC2G039tk3mRa0A/qPiv6qgCNRfaOn5HzXOOSiiujeTBiHF84Iq7
         7uW2xu9EScGNHImdG419IGhCGYgCF+AJ4DRPb1CRGo7SA5UsgZAbJFZKFdsNjqcWKOEo
         WzygMvzpE863js+3GcvPAJ9bhukv2jJ26siQQYD0TdnG//Np8H4SnX8DNfv+O1NeyW5G
         ll5Tr0j+4oEtUNtiKkbl/u1YB77N92WUIpqVw3JQeOuQq5YcYHb7Y4cEGn5PR8wlrXL8
         NxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762518811; x=1763123611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wFg4sEi9OuCa1c0qwdmYGRON1nIlfIlliXKoJp2VYg=;
        b=tApSYxbKtQbhgR34O9iLZmQ6ZDfwn5l9eLTWKaErTycOZlQXQrDFNMIE/ikud6vHsg
         xrihIahC6NkPigYRMt/F3Fjja/pPhXNjhfHJGI8D0C2N9YXsuVQEJ8md8rnvQTKT2YAE
         TaTUcphryNufSojR1KK0/hPBcTc8JLjNOYX7iQP8OA8rpk4UZEeTJKesv9wchnpRxXX+
         1Hh4XZX88idKBDlyswq5vpf+7HV+Hw4DCRTYvfDdvZuKhBMcHo/pdvPoiMMj10S6sDza
         QpmMSFhzJhJ7V2C9liKfQai1FqGjy72PBTdSGmeEJqOFb26pKYt5xo5lT3XuHvNcRM9d
         3ZfA==
X-Forwarded-Encrypted: i=1; AJvYcCUqU1CjH1tFkkG6hfNwJos4eOFhg4xqrScqJyemCdfqdAeQ6kJrgJ6is9lZ8ZeYDnLq37v5/WN08LVhWaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6svVPUl8Wj7Qlrg7G+OZlCygsQ+Wm/WaaxeBDhRyc74OiumE
	xVvgNVePSbxLNPZZNuuHuggyUyPF9mqgVAE3eNctYztc7ORDmd61y7uk
X-Gm-Gg: ASbGncvM1no9EDVwUmLjXpbRVMLKHuYHw+42D3uRMVLXsIJsv8grd9/Z1//ETw7svgQ
	b3rHKLILsUQSn8Ei0PsdFW5cWRNEgdKmt79psJtB9QeudfgOlOSFUEPF/p3588hmQNXhTruKgIX
	RyDjTwABAGyHVS7+X6zYUI44g2wV8IFoMEJr4EJelEEHQnW4mKh+kmABTCz0v8Xry+ZTN1AWEEH
	gFZ/14lC5QRA+a1vpv3s5lzE5z5EU2jGz4D1n9MG/rtC5vMyDH+WUJsYpTYV0ChV2GnQJkv2FJZ
	8QHRwx+XAcwmfipV2xlFcHriaVIQelwgPChWCO0sgkeduwe7DwKuGhzBR67Xl1MrliPBiztZN3r
	XrxSlEuIxOgevQR485+CMh7GXJ4Fg7sUIXg/2SD6BmWw2J3eN1dnEVKF4lDeBHe4jOSQLdmVIrw
	z/8RmZuc4zpMEQd4UttK7aAf0YT2MPNK2uz/3P+s1LVsbvEwc2M4fidOcQrpOAzRc=
X-Google-Smtp-Source: AGHT+IE7z6KNZTDs+X3lQn5orUAZb91cr+qoIc5amPGDhp4Mbj7m/pXX02bL6DNNvigWgocoVupEPw==
X-Received: by 2002:a17:902:ea11:b0:288:e46d:b32b with SMTP id d9443c01a7336-297c03ad66fmr43022505ad.17.1762518811194;
        Fri, 07 Nov 2025 04:33:31 -0800 (PST)
Received: from SIQOL-WIN-0002-DARSHAN.localdomain ([27.57.191.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968269sm58959735ad.17.2025.11.07.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:33:30 -0800 (PST)
From: Darshan Rathod <darshanrathod475@gmail.com>
To: linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] scsi/arm: Clean up coding style violations
Date: Fri,  7 Nov 2025 12:34:34 +0000
Message-ID: <20251107123435.1434-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Addressed checkpatch warnings by separating assignment from a conditional
statement and documenting the empty for loop. These updates improve code
clarity and maintain style consistency.

No functional change intended.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/scsi/arm/msgqueue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/arm/msgqueue.c b/drivers/scsi/arm/msgqueue.c
index 58115831362f..7e09624e5505 100644
--- a/drivers/scsi/arm/msgqueue.c
+++ b/drivers/scsi/arm/msgqueue.c
@@ -23,7 +23,8 @@ static struct msgqueue_entry *mqe_alloc(MsgQueue_t *msgq)
 {
 	struct msgqueue_entry *mq;
 
-	if ((mq = msgq->free) != NULL)
+	mq = msgq->free;
+	if (mq)
 		msgq->free = mq->next;
 
 	return mq;
@@ -99,7 +100,8 @@ struct message *msgqueue_getmsg(MsgQueue_t *msgq, int msgno)
 {
 	struct msgqueue_entry *mq;
 
-	for (mq = msgq->qe; mq && msgno; mq = mq->next, msgno--);
+	for (mq = msgq->qe; mq && msgno; mq = mq->next, msgno--)
+		; /* intentional: iterate to the msgno-th entry */
 
 	return mq ? &mq->msg : NULL;
 }
-- 
2.43.0


