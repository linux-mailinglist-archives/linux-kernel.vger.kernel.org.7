Return-Path: <linux-kernel+bounces-882898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A7AC2BD3C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A5E4EE1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983030CD98;
	Mon,  3 Nov 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WdHMaNdA"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720D221264
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173766; cv=none; b=eB8dNc57fycce3WJDKENL1qhY75a2/XuLJIW2rfd7XNeascIHPqc9YyAOxZesmoW+pePzW9HWGOV73FHLORwuzpdHTDgh1rNlCu3nTWAeroAyCaiL1nHH1Boq8x/StRVQ1EeRn0jLb4cZLCV0l0XHY5dREH6LyKMjRrMWO/YlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173766; c=relaxed/simple;
	bh=05bvAMFQtigRL9AkIb9HLNaYbuwhPBcTJBkQFv446gU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bYvlpOFEEEsZ39ig7XjNLw251R5wK8+I+oTNBn4KD3yoBHqCTg7Iza+OCwvmRoQq2wMLlWoP1M0Y5PQQSdzN9LxNX1nokQA1sW9vzpvXDmvtqnbanwVV30HGOpxyA7pNhHzy35As5tyhZVSIizpvSb0e+QEaOzKG5mIx+t0YZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WdHMaNdA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so2258113a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173763; x=1762778563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fFCdIMIJ8Uo09Pxm7hTDDj9X6OUIsKRKshcXYCzYPI=;
        b=WdHMaNdAzTg+Dvwh45Xy6GVseFqWBuHOk1oom7fYSjeiC9sVqPp9WAX0ZtaV54edto
         ns3X1B98dSQQSm2zc9OH0aubBBZ7vzDKQQLOlURyI+gp3tsUu53SoCV/BX5tdrFu+AMs
         EBgEpl+TmMfkCtqJFHSoGPNCB7Ryad9TQ1+Q7OEXeFtdkWPsuN8Whi3RdhYkrqsYFV9z
         W32A4IS2qHqbUaN+AH+oXKohEXM+ej/5KPv0o8XFC8Yh5JW6MKjWvmp3OHkZI6AiQnS3
         5UUbN3dul1a6b5zou+Ycts+h8nxXJgljMlMauglAXY056VgYP+WS5if3AGJqMu/w5NFa
         PzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173763; x=1762778563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fFCdIMIJ8Uo09Pxm7hTDDj9X6OUIsKRKshcXYCzYPI=;
        b=caCKAGXQCwOeGdH4N9mmXEY5dA85zOlxtM7xx65tfORqsFvvkTFkwNUY3G5Lt2+a1S
         5Xze/0HaLbEgtowVIHS8cmkATmecHVUh7PEDIqaBwWXQdYz0He/925jZSv8ktnwm6hFG
         NtSVHYxvBENMzCtc7i9rH8BZCA/9rfJP7eSTBRS2ZJUfJyymBGlrQDo+yUDkPDtZiAGj
         9+aLKE3wGUQqC17pNOyTTPWK08plLxoBVXlHJPGHJ+Cu2ogiFjMPMDzAF8pq1Fn0+pRL
         Lt1SgVCejhbkOQRueAxoJD4zkatl+7nUItczxYoQVJ228yMYSZtcknaVrGrkKol80wua
         IdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB0oMxzjN47qwIpn4U0HKmO4TaiYHSacCZUHo2ujKXuStvQ71jDUVGsAHfLU091SWRa6tL0augDR93q7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMd8AcF5prBuR5B/NhdX2jJ2jwCXqVJOdz3KS0/R0vHeyJGxD
	GWwQbs0x8xZxyWE91c+y5ejv577W8WW7FqrnASs3CbpCh+maoXJJGWlKdnKinRXXLSI=
X-Gm-Gg: ASbGnctvjDnJwB491kFzFg7w92N9EtEd3jRQp2VEhX+jTFAqTcQKuAw4DKc1Di0lLOV
	5QUAuDk3p8v5o0gjcLX+Di0/fMs32K+4nk9qAGT1w6DKVr/2m01f2uCE6CK+qW9m7Kv2AIrPBfF
	QwjfECcdY7aPtESox/TqeUwIkRMg0G2wO1U+muuW4JNmkMtHuK8fewYnEJ4eHoD3xG805DDfmU6
	8YMrvm3T0CeMq9Px047hhNn6FtXaUbH6ORSim1+Eenf0F2HvlTYX8MaEw50TEjrk32JQ+E2trXC
	WEfy63jhvmKcAnSLlqGTZ4l5cRgFw9Jn57+dZ9xntFK7ssM5WNnZevtNxAYs620Q9cVD+pIy+nE
	UDRMMY8DG9SIK2SC1YVnki8Vhi3mSggzmpoaEZdVnXJbaWIGtJWlybqnBqeuepi9kK59jcimWuF
	uAo9eLvA==
X-Google-Smtp-Source: AGHT+IGLOlATomjwi7fjoVoQAOmBe8LfZrNU0JTjWyfW5nhEuGL7RfvkIMlNkbvH5sxfdhy0mbYqtw==
X-Received: by 2002:a05:6402:440d:b0:640:6512:b9f with SMTP id 4fb4d7f45d1cf-640770209afmr12414380a12.28.1762173763080;
        Mon, 03 Nov 2025 04:42:43 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-640aa4067f6sm5556380a12.34.2025.11.03.04.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:42:42 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:42:19 +0100
Subject: [PATCH v10 1/3] firmware: ti_sci: Support transfers without
 response
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-partialio-v6-12-b4-v10-1-0557e858d747@baylibre.com>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=msp@baylibre.com;
 h=from:subject:message-id; bh=05bvAMFQtigRL9AkIb9HLNaYbuwhPBcTJBkQFv446gU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyOxYYuAaVLVRiPt3JoMtrKTTqVPGHBt8C59bPfH/Pm0
 eFI17vQUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPp2sfwP1Io8u3ah0+7Qsy1
 7vg8+H6J6QTbOom63ra1x1YGSx/NYmX4p9tmlb56XfzltTOZRAuFHj1WW1h5dnNb5KXdUtU/Y7r
 fsgEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Check the header flags if an response is expected or not. If it is not
expected skip the receive part of ti_sci_do_xfer(). This prepares the
driver for one-way messages as prepare_sleep for Partial-IO.

Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 49fd2ae01055d0f425062147422471f0fd49e4bd..2585cb82d1ad8e3d79bca458a2b86cc81a3e627b 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -398,6 +398,9 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
 static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 				 struct ti_sci_xfer *xfer)
 {
+	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
+	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
+						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
 	int ret;
 	int timeout;
 	struct device *dev = info->dev;
@@ -409,12 +412,12 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (system_state <= SYSTEM_RUNNING) {
+	if (response_expected && system_state <= SYSTEM_RUNNING) {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout))
 			ret = -ETIMEDOUT;
-	} else {
+	} else if (response_expected) {
 		/*
 		 * If we are !running, we cannot use wait_for_completion_timeout
 		 * during noirq phase, so we must manually poll the completion.

-- 
2.51.0


