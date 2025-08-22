Return-Path: <linux-kernel+bounces-781474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024AB312EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8636084D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C02E3AE5;
	Fri, 22 Aug 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpxs5VXL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFE2820A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854657; cv=none; b=pQdFBPQ0M/ATKhzUBrd1T10BxFpr+u3madQWhKNfQhRhtZO2rj0U1s2w+Su5VnJq0xv2PKj/kb6TnQ09YQAxgkHL1bY67Dx5+Kb8JOHGIcMprvSYmGLymkSh/AYGrpEbC6SfdrdE0JGcL6ELbBmWCHEYQCZIP4mixxfYj1IXSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854657; c=relaxed/simple;
	bh=QZ1yMwiRS/edAk9yh784lz6Yhaw2nWEa1VIzlMHI840=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YufmXVRewer2fnlFd6NEqNAUgRbI98TWcAFXnOYWb23gf9RseYDEbYuDMTa69sUrht5PrXXtVwohH8CIlruPmU/1wO8BPJJJ71so5gyrj/QhgHU3WGDU6vCbzfDbjl1o/3NCZSFuJ6dTeQsom1RBMiBAqQeIJwjo9PqqPuutkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpxs5VXL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eac5c63so1875131b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854655; x=1756459455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VyilXqTlTSUumeHDAFKTKU4l+yIbGUl58kzVG3ScM4s=;
        b=xpxs5VXLk1T3mSKw48Z8zPeSmND+wwF/17996a0osPFMT6owKG0ABtqK5qkKxIMdav
         t2ftKDoOdhzqnKWv6SgN+kzpV7Xm9WOV5a1IWWyTN30ZeQHM0jKQJBnlkUMhhJkPAdYo
         YUh+TWBZ/U4vrPKTgTW3QhMa5gGvtbVLsTWa2xMpXvXS4mLMQ7qoS83SwF71viG29GXP
         voJRTjarV3xvRh5c49vwJah8yGTKDfb1dsJHj3VPq7P30eWOBs0XSU7Nh/XCzUusOq3B
         GvEafmZ3o7VKjUZ7vIbXTtaWjeTsJLHjZJl0qiy6hjh2ulb08q0wjYX2Tm6x2EgttloA
         IAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854655; x=1756459455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyilXqTlTSUumeHDAFKTKU4l+yIbGUl58kzVG3ScM4s=;
        b=i2wp1pfU1fv89/3Uq0lsdUPmdWKDf5jTqFVb2BhtbxH70NDEyDP4vkYT9uMpxo7XEy
         C7JVAiawK/oXTP6NFZjGesltRPvhFuLtK2Ddti8+wAn0U5+zLASUVtYl6o+COCForViR
         04TQpOMD7V234xM7nawV92IYpe5F7UvjMclxbk3ye0v0TjN46Ca7bhkA+BznQIcP1v5e
         0+VJffzNiWuXZL84VN3x4oDWQyWVuuOo3FEQ/BE39t0ILZm2EcbhRupcjtuf+gzBAXoD
         jgdgdgaHhoKLhTW8omSSNYMPlqAiDP2qCKEyuoV+xKXZ31+saIhTr+diRpjCmxXOKiLJ
         bs8g==
X-Forwarded-Encrypted: i=1; AJvYcCVvZK1+5nnQq/Y0nwW/a4ou0jXpJyzIWZ71nCLbNwwWSS4sxSJ2AVScReqks545kq5/9NCKhTgVs8U2feM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8g+lCphgdABhpEkUA+hULYFFN/wSp+phlnFfmmx/pV4uLZlGf
	P9aXx3JITsPGWQlD31f9EtMk62ZJkAWu/K2GWg5iFP76aT6mAvLGatX1/XeraT8dGYiSrDG6MBz
	74sCo9A==
X-Google-Smtp-Source: AGHT+IFjuPEKgVHXW9Ji15b2ymMDqqhJVr4Gn2I/XEBmf7Wb1DPa881urd/0sgYFstDva6Z7VUAN8u5wjXc=
X-Received: from pgcv16.prod.google.com ([2002:a05:6a02:5310:b0:b1f:9534:4f55])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8b0f:b0:243:78a:8299
 with SMTP id adf61e73a8af0-24340e068d0mr3373683637.50.1755854654776; Fri, 22
 Aug 2025 02:24:14 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:23:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250822092411.173519-1-khtsai@google.com>
Subject: [PATCH v2 1/2] usb: dwc3: Add trace event for dwc3_set_prtcap
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
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
v1 -> v2: Updated the @mode description and added the Acked-by tag.

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
index 09d703852a92..6e1cdcdce7cc 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -13,6 +13,24 @@

 #include "core.h"

+/**
+ * dwc3_mode_string - returns mode name
+ * @mode: GCTL.PrtCapDir value
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
2.51.0.261.g7ce5a0a67e-goog


