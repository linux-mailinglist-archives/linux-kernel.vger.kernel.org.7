Return-Path: <linux-kernel+bounces-764887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD2B22861
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2206A3A3B35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF527CCF2;
	Tue, 12 Aug 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5SuM/4f"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1C27FB29;
	Tue, 12 Aug 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004940; cv=none; b=n1YLEWvhvilYCA11yEWhgbX55o6VyXBj3bla+tLoKRF6EyJx56JXFv4F9RNNKGRF2nk2/Zlbv5R1QFdXdNZYMELyy7L+LMW8Fjvgt0SP7dHI2ssJVrYD9VvyufRK5XsLHAT0O3iAF6xtHGZ9ij2z+ByS/sLWYA7TA0Sv+l8xqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004940; c=relaxed/simple;
	bh=zYImU4jxvzbeYDCcwW8grQtTwXDcIZSor5qvW0OKkxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVoFrgs9QKBTxkKAiWsP+A7rrDQEFHtYjYvvVDOH1vYpQVSK5c+p1kOEpLN6Nh6PrJYJWa3LGC0nhBrkWG4n0OCXWZXe189MksVxwDbwh8SOndugDDdypEHncmgXlEHgewe3Kmx+MPPgXHK6T9qpRFl3ZC5vzT3Aqk+de5qFjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5SuM/4f; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6182ea5a6c0so3287182a12.0;
        Tue, 12 Aug 2025 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755004937; x=1755609737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=T5SuM/4fbXS9JOhRQpqD8fyfLpCPe9ypXZ5vXTj9KBPuy3GZuHhpPoRlfa0VmT+nAp
         gSE4Wp7Nu+oIRNPDA42gmU21b3vJSr1acGkJadOGka2TgUN7yZbkAcOXbjmV8UiV0y8k
         mvAzdKxEMLGVr8BYMEy8yBF+NT2zJykKmFoPC0L1E5ciff3vBprYnEs2rwRZxf2VfVUK
         1S/57IlRPZK8KKWeCUeOdCvVxjv+Cx3zPtvzdfab2OIJKctWSrrqq+qVTEGnpEoR6GUR
         YOiiX7jjLYcUebI+3i+aCnftYEvAaFtKTTI9wakPLwwR/fgwRk8lvv3+7jfY3uwHXrMV
         sw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004937; x=1755609737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=SE4EoQ3nUEeCTVddELo5Ov5bpckvAIjWjMrsFPFNRBvYet9OA8LSph6GKeMsJHe+IK
         B1qW+vwfDulu3WYwEwrI7RyuRCEfZlWCVbuixwCCxOrmbjWtSzBQwgRFeMkW+gg7vG0Y
         nYtZosq8zxU3SoWEyPv0i3+6/xDedBTekwCb8Pkp1YGgEbxftFziPE538HbcDISMXvxd
         RuHTGShJMqOHufGO7FN9O4gJpkQgVmY+X/Zs1szKtdSuqHVQLmiu3nB3Ir17RyQILG9t
         WBpWYGN2SGU0ikkWL7jgkorIS6rlncePCPZk4oOMwrYxjIl7zr2VAvVCaSEplJd5jdiN
         Q6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU0ImorkkbWza+UtGMyVzW6YiSxsginTdWCCSqiJiOnL1eiFDjsnzSaeHovqoxfydtnEwSLUewMlh+ZcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnU1Bnn4lBbwpaiPqb4GqHWfwSysmC7wqslPcE2Y3j/Ma6dvqA
	JV/Umkivz5QfPDwDP3kPmx27woWXOZd/y7c2H1HAXR2uJEE9MAtYvfIS
X-Gm-Gg: ASbGncscQ1fAmY+re9oSyCNJVbIXHG8kKfeNtByv429vHUwBZFDpk47nmHplEaxY5xP
	dklA7MNRrpSexGqIQH2pUjcqPdPO0MfqVoIgkI9meNmRCKUbSxBL1H71o9bNUQcjdeJX8IBJSVE
	QbD66ULtyVlZGbpKqppFgyE6sWP0Y67erFpMuToRBdpYJ5z+Q/xbZSlChHxpAghty3EqR5m7GNF
	P6mVpyTJioLn45JZLMGRskNFJ+lww9Ue4n16py+HCNjBv7VG6EccXRXU2QLjSAVi7TjyfaI3FIU
	DDCCZAdmSH50OB7MVoHdFLItkXmoupSC9U4fs90aXgtaGeXzvUzlAERcfHtxBTERrMEuRU5XJBc
	m+Dfk/7m2Q0vuEKGknmV0OEm09lsBlTWZvGbP/wXbvyyhztXNBMgdub/vMRoxOacc/FX/4Qls8U
	uGe1H2lA==
X-Google-Smtp-Source: AGHT+IFNty26m06UDavtP1dvlJBa7n0TurDCC5UKVgAj49PoRHGoHNLqfwUv0s97DtjZ50MAbB7A0Q==
X-Received: by 2002:a05:6402:1e96:b0:618:227d:34c0 with SMTP id 4fb4d7f45d1cf-618227d5788mr9402916a12.30.1755004936768;
        Tue, 12 Aug 2025 06:22:16 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61850794509sm1315511a12.31.2025.08.12.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:22:16 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v3 6/7] ALSA: usb-audio: us144mkii: Add deep sleep command
Date: Tue, 12 Aug 2025 15:22:08 +0200
Message-Id: <20250812132209.83728-7-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812132209.83728-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
 <20250812132209.83728-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a deep sleep vendor command to be sent during suspend, allowing the
device to enter a lower power state.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c | 7 +++++++
 sound/usb/usx2y/us144mkii.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index f7944eb2fb93..e452250fc5b4 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -322,6 +322,13 @@ static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
 	usb_kill_anchored_urbs(&tascam->midi_in_anchor);
 	usb_kill_anchored_urbs(&tascam->midi_out_anchor);
 
+	dev_info(&intf->dev, "sending deep sleep command\n");
+	int err = usb_control_msg(tascam->dev, usb_sndctrlpipe(tascam->dev, 0),
+				  VENDOR_REQ_DEEP_SLEEP, RT_H2D_VENDOR_DEV,
+				  0x0000, 0x0000, NULL, 0, USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		dev_err(&intf->dev, "deep sleep command failed: %d\n", err);
+
 	return 0;
 }
 
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index c740a0b5a0ea..ecc4c2fed9e6 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -46,6 +46,7 @@ enum uac_control_selector {
 
 enum tascam_vendor_request {
 	VENDOR_REQ_REGISTER_WRITE = 0x41,
+	VENDOR_REQ_DEEP_SLEEP = 0x44,
 	VENDOR_REQ_MODE_CONTROL = 0x49,
 };
 
-- 
2.39.5


