Return-Path: <linux-kernel+bounces-772925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07812B29968
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7291017BAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9841D271479;
	Mon, 18 Aug 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IJqKaRc"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA027145B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497284; cv=none; b=Gq6wpUhm8N3fgHgEMR2P7OyCVYpjkLk32UGXkMn7I3P425dAa2hplxW3n/p6V2AOwypfrFf/hPXJbSPVLF187OVY5jdcgQyopfg5OQJ0tWjiZe894Z4ZAg1UdSRYOeBxCf5T7zzvFmbIuB+lppDpXHpxw2oNLD2AwUsOmEzh8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497284; c=relaxed/simple;
	bh=TrmMaGXfFM9Dy7FU7g83nMPOzp2/f9kGtkE2n5K/8eo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PaQjasgjuvfP1ruXVWF2Pqo+WM3bIYXiYlw/2uHEV2v5GSZKhHo/OfEeczF6XdVGl2iHg2++KXOvJht1IS+AdF/2NBPXy63mirdXVX0/kwIOBv5/fFP58orAWwS//MC/9o9unIQhebymMrqvBAMTrLDYWLVdJrCz7fBDlPWprhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IJqKaRc; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-333f92d133bso18098531fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755497280; x=1756102080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MrMTy9fob00ctraswujNwZhhAnI/gHEtPWec2OL8mk=;
        b=1IJqKaRctiDcV5eWwwZFm2A79S6TPsriLGIy6M5Ru7fkjga2ZToh8apiAfmYGndnDn
         VR3gzYN3wWSgbqnzX/72+LcKxbqQUqpwygnG4MSclvUvu4hoxMTSX2ueVaMpviCOG4QR
         GRZk/JkZeGbV5pQPhdrYFsrlqsfDnTtsNpNtB7Wf5MrIgTNpGFdkuxbJv4BK7oDEIVap
         PKVD8TLjwdlGSveEvMcMsM3BpielRTDaGYMfODwQbc9KBop/Pe7qJZgp3dY4hRvPdfak
         yDoO+GgB+p+jriX5hZIm4C/uRldeIT4fl1zlBxFF2gR8DkcPkyeuO13zyqj0Zxqzj0PH
         85tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755497280; x=1756102080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MrMTy9fob00ctraswujNwZhhAnI/gHEtPWec2OL8mk=;
        b=WTtyG5KGa4C3Ms/e+aUbFUZpMi3DhgGF2hF0A5CXYwoSzJndO+mXQ3ZuawVbWwhTbA
         kw2d5m0XjUB9NTqXcAtfhj3kmS2sYwJ5a9LU6RGk0u5zOXD7RNRsGOklwh8qgliQnJhQ
         hiETvzJumDZlF0a2t+3FKpL5AhAEKr3fm7mLIoBHu0o6OUaW6dkyZVIWM+77NximZVhI
         xkwZTnfkWGrUm1cyVKgEL0Q+lZkZxZPu47FI3sFcdo/NrkDqLIz/dCFnrm5M0pVrcG14
         JdONcJoRBfrO1+02fD9UVZQ3Bz2gVqx7QwSAYDGf7FO9MVK5CNSfs9iO1YxmiedAuwfZ
         RNsA==
X-Forwarded-Encrypted: i=1; AJvYcCUa6fWXl9jDAtLbAvI3wyNppwXzKrSD4l/drW1hNvGK4YQ+nxoIv5GA7OYhOKnAN3osb3xJ6OR0eMrziEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjp/eSxZeWwJpw/aaAyIiRb3rV4/1H85kCTDkKQmaHhIBbHZXI
	b/MVKhgZemAqX4gTTKGK+F9NjGJSyFWew3heynbHFCM0Fj05oHSN2QR53kijbIOHgRocqf6yC89
	zDVWRgA==
X-Google-Smtp-Source: AGHT+IF4gJdgX2pLk1YRQu2B0FhAWRI52zKLOPKoWiCGPyd/eQ6IHsLbcAS3xRXg7QkEYVC9ctqqj7VP1jk=
X-Received: from ljbl6.prod.google.com ([2002:a2e:ae06:0:b0:333:f189:5431])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:a98f:0:b0:335:2563:c0ec
 with SMTP id 38308e7fff4ca-3352563c479mr1899201fa.33.1755497280423; Sun, 17
 Aug 2025 23:08:00 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:07:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250818060757.2519126-1-khtsai@google.com>
Subject: [PATCH 1/2] usb: dwc3: Add trace event for dwc3_set_prtcap
From: Kuen-Han Tsai <khtsai@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="UTF-8"

Changes to the port capability can be indirectly observed by tracing
register writes to DWC3_GCTL. However, this requires interpreting the
raw value, which is neither intuitive nor precise for debugging.
Monitoring these mode changes is essential for resolving issues related
to USB role switching and enumeration.

Introduce a dedicated trace event to provide a human-readable log when
the port capability is configured.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/dwc3/core.c  |  1 +
 drivers/usb/dwc3/debug.h | 18 ++++++++++++++++++
 drivers/usb/dwc3/trace.h | 17 +++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..370fc524a468 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -156,6 +156,7 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
 	dwc->current_dr_role = mode;
+	trace_dwc3_set_prtcap(mode);
 }
 
 static void __dwc3_set_mode(struct work_struct *work)
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 09d703852a92..70d90790f872 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -13,6 +13,24 @@
 
 #include "core.h"
 
+/**
+ * dwc3_mode_string - returns mode name
+ * @mode: mode code
+ */
+static inline const char *dwc3_mode_string(u32 mode)
+{
+	switch (mode) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		return "host";
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		return "device";
+	case DWC3_GCTL_PRTCAP_OTG:
+		return "otg";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 /**
  * dwc3_gadget_ep_cmd_string - returns endpoint command string
  * @cmd: command code
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index bdeb1aaf65d8..b6ba984bafcd 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -19,6 +19,23 @@
 #include "core.h"
 #include "debug.h"
 
+DECLARE_EVENT_CLASS(dwc3_log_set_prtcap,
+	TP_PROTO(u32 mode),
+	TP_ARGS(mode),
+	TP_STRUCT__entry(
+		__field(u32, mode)
+	),
+	TP_fast_assign(
+		__entry->mode = mode;
+	),
+	TP_printk("mode %s", dwc3_mode_string(__entry->mode))
+);
+
+DEFINE_EVENT(dwc3_log_set_prtcap, dwc3_set_prtcap,
+	TP_PROTO(u32 mode),
+	TP_ARGS(mode)
+);
+
 DECLARE_EVENT_CLASS(dwc3_log_io,
 	TP_PROTO(void *base, u32 offset, u32 value),
 	TP_ARGS(base, offset, value),
-- 
2.51.0.rc1.163.g2494970778-goog


