Return-Path: <linux-kernel+bounces-843611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4700BBFD26
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74F54F3290
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D13822AE7F;
	Tue,  7 Oct 2025 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q03rbH0Z"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C832192FA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795232; cv=none; b=W7DzxsMnYUAV+/AvwB9fbPMER6ZckVl1Wx6CDEkz55kUNRF1ARxcsUU2wD1e6VP6ei9lS0gmXdkovDBt43krgG9HOK22bKruu0nIu9Ymwap/E/CY/lHXpnydGpGmKM+C9ROeQLBUOdxikD0nu3i7ir0Ygwwq3lwLgnXKdlJy5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795232; c=relaxed/simple;
	bh=D+MRKxpRY+FzYsdPeIj4rxTE/97xCVi92Ne0tdfRG9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=amc73b8EiAO7zv0J59/7TsZ05FwNFQONmZZFFaBaSfODiSY5ZZANzyQXiqlCqsp4PZJm8HihGxPEmEiy7bypKr/lbyeGXRLUCgkIR2abocaexGDgIq0PIai/c58Zy3WD04+4DDdDRZMqM3VmiALHhHJkdCZJplzWhMOBdrbGlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q03rbH0Z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befb83so5853995a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795230; x=1760400030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBzYAbkVeiCWYgmKOO6DMAiS3ySiT/Utkjit0D80cV8=;
        b=Q03rbH0ZOciiKXEGIka8M5SIgkmvzw6ZHsDsOkSYyUmLRCd8v3zg1PCTWsjgf205cE
         fju8msKsEasSW/0kkBl6H10HqfnMZm4EgbfVOvofsXBgSWUacfO4/3ZUHCeyqPwoLs3o
         nIsHdRVAqLeBDmEyt3nHaAAjywJdKopVZ3J4A/nYfXQPISH5PH7d1/oOWzBJ592wkSgH
         m1SAQEkRXRW0CSkcAD2PNVa6uOgy0xfcj1sV/HquWem0LmSUERRwbzcY3Wlmp+bBTDtL
         BMk32ivDpxNgdFKmcAAIG+Jw47DFOQCdpSYvns7wogtXrvL2kE6hgLgyfiY5lga0U23m
         Pn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795230; x=1760400030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBzYAbkVeiCWYgmKOO6DMAiS3ySiT/Utkjit0D80cV8=;
        b=Lz99n72r23PDd+xadlroq8hfN1ZJpPNx9bRlgHABfWYaZLB5Tc0XBVpSEFr1Wb23lj
         9xSio9S/T+XXeQNWXmVlKoEglz/pGOr8t9mnskzl9ValmggM4le6ukSc1KWraIs9BSU4
         ZHc+OlHDYs88XFM8Rpb3wGMNNO8q7dDa7LKPvyxPqQmhZEp0v/5logPQbQsU6NonVl+c
         JNVT1cOBk9437ASvMd4mQbIxOmIPSvUQvlDhwjdobGKXBwWJHDI94QIFeytUp/X+XbnH
         2iGUM7IoTe7BOGEOkmRvbC/nFWTcaVe7izS60O578VBr5fBkagdzydvX/YpZk3JiVe4Z
         yQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCUHD/ekczHx8pVui4JNdT5jEG4Z14AuqtjBF5sUtBL2yUQXloI+/npmc0zDAxvZ7GFsLzEQQkfEdGmGvz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPq1bT5A+TonjuNS2WrTTZxOTSX2QTaCzg7rFrs/rcb2kdadAZ
	Y2P213Q6/kTGTNnWYFVdAj7JW+30hLi+dkDDGMj2avTfM2aqh+zJwMzZLKURJI70IyHhFTab0IW
	UunLPnA==
X-Google-Smtp-Source: AGHT+IFxQ/0APQQH/w8k8aOg6BAF8kp00klr4bjh7buOd+uTq0PuqSjd8xU2TYekqWlGFdbE0f7oM3ZZQgc=
X-Received: from plek20.prod.google.com ([2002:a17:903:4514:b0:274:e523:6f5a])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f04:b0:269:8d85:2249
 with SMTP id d9443c01a7336-28e9a5689f6mr144152565ad.22.1759795230224; Mon, 06
 Oct 2025 17:00:30 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:00:05 +0000
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007000007.3724229-5-jthies@google.com>
Subject: [PATCH 4/6] usb: typec: ucsi: Report power supply change on sink path change
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jthies@google.com, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update the UCSI interface driver to report a power supply change when
the PPM sets the Sink Path Change bit.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 +-
 drivers/usb/typec/ucsi/ucsi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7b718049d0d1..1a7d850b11ea 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1293,7 +1293,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
 
-	if (change & UCSI_CONSTAT_BC_CHANGE)
+	if (change & UCSI_CONSTAT_BC_CHANGE || change & UCSI_CONSTAT_SINK_PATH_CHANGE)
 		ucsi_port_psy_changed(con);
 
 	if (con->ucsi->version >= UCSI_VERSION_2_1 &&
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index cce93af7461b..35993bc34d4d 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -382,6 +382,7 @@ struct ucsi_cable_property {
 #define UCSI_CONSTAT_BC_CHANGE			BIT(9)
 #define UCSI_CONSTAT_PARTNER_CHANGE		BIT(11)
 #define UCSI_CONSTAT_POWER_DIR_CHANGE		BIT(12)
+#define UCSI_CONSTAT_SINK_PATH_CHANGE		BIT(13)
 #define UCSI_CONSTAT_CONNECT_CHANGE		BIT(14)
 #define UCSI_CONSTAT_ERROR			BIT(15)
 
-- 
2.51.0.618.g983fd99d29-goog


