Return-Path: <linux-kernel+bounces-674694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138FACF34D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0BB176BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1427587F;
	Thu,  5 Jun 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPXukdl6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E57275878
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137928; cv=none; b=K3kIXECMgeNIFntfgAaWp+GGH8f4GO1UliwNQGjUQNp6TqKUKXzA1w2oYjH3KQxJY4u3GdoBSB1lDlwvLLXhnJ7P3+qrJWJFh7bA6Bqjxx/7QfPPAgAVmLNgiEeSasnvQpe/HrtA6beL8+kka7GoxtkyW0NhaH5NJG47rS4170o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137928; c=relaxed/simple;
	bh=qNAmmRKC2jTglldpcDlO2KCXuzEUgGG1x8yJRBImMT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rddV0jq/zHBp/8x7i5SdcgA2Evxf6XCTXYpvp5ObkTV5BFaI/VUg+JprdQipCd6hcND5xIIYHhUhDkVIfI+X2wDulGVRtqq+dESFJP6V30hE6ANcCM6wg/9BG71m2/JG/cZtzLtNn/YF0YiCxcBxSppGOmfQXaNCtZO1/8VLxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wPXukdl6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso7643735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749137924; x=1749742724; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=69scRkVxEedfu2A05mr2qUJ6E6ZjjFxsp+26832+0SY=;
        b=wPXukdl6sdR/2gWrk16Rg0+0rOALlrEYG7h5Nf7K08aVSWeIsYcCIHD9Q7u4rTe+37
         G6KdBzB29OP7Y90dijiOG5eAfmHl6UPmDkIV3VPmt75dUdkY596MB6A/gjFFEARnVJvr
         CXlSCMFj+CqL4LA2z8ksbJhthFhIJmeD43LLzpfU6G++L0N/Y5shh2aMz0LdzHQHpBEe
         nDgozEiNDUiwEwCqMJNdLUDnVX85hbceYj9bCCAlyYtkvjAdA+b+Tm7RY/p/VqHiSdTs
         WqpDTql/RbfyksL+yKSxtPNjp5LCjL+LRiB3/laMMrnXmOuca5XbZNIv+H6h05K0xDRs
         wEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137924; x=1749742724;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69scRkVxEedfu2A05mr2qUJ6E6ZjjFxsp+26832+0SY=;
        b=cuhDOEpXmJagRvqd7YsbLgJ7kL2rx78DHAPnGWcA7FNFuF6rC/naQyjhHQP79c9NOE
         LF5flksuDpRvx0ff7DHh3thtDc2bTXusYeAy39OTQTj6/+R8y9tQyc7UDr5DuMFdpLzD
         1Fq0Y/Cc85wQhI1lX+1mqlPnOAjuZm5EByQby+Mlwo3BpwT5GnJm/ftwkc5lEB+KHAWf
         GVz5z4FSUDmxHyKopYl7Q+MwZgiwaqEhrihqZwOFxN1seda96HCc7NbZpucFFeBLdkTf
         viUl2M9Fe45+n9p5EHnHjXkicGNJ34jwzn4R0ggBdNayX5LNeLgNPYp3S4s9cAtwsRYy
         fmqA==
X-Forwarded-Encrypted: i=1; AJvYcCUun3Tl4/54Da9/FJ82FVg+g9oUZtWI8svNIcxEJYhBcmKPhYZLgSQANgdTH5PAFjk5CW0n0ZlU41eiDXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDtm7iGUYaLbg+3wPj/tYu8wjvEsBOnxPpv0L5hocgOXTYXal
	nRQr4tsxpbYjjQ/Vc9GFdkwVgEZhQ3N46w/oMxoJ6x8gA8I5c1w015sMvyXf23JLxWmCzxZ4Z6C
	klcam
X-Gm-Gg: ASbGncvE+Pby0NYgcfUUejLLtuGXXw/qZmzsdrwzwqDCefRHFF5CWBLmobTItW+Rskv
	2/CLKOzwiSxczT6TO7ZCF6qlb8yac1Jj8DyZVxs13Sb8qebfhTtHdPzc6Yb3y6xJFdjEjcTKjpr
	clD5BEIqsB7hx1L0TnXXCrIRVdjTtg85x5yvqowIoMMA3398TzY6Ce+raaXgiRUHny3Z+UJKGBB
	jVSIPoVcquC5tGGtPBDg3/4b/pauBkBFwiAehwd2HHAriCwQa+YSQlAwinmCifxtehrgEyDwP5P
	Bo4CyUle8pLf/l900PP/EduCr35xoReOX3b8a4tN1impjiNu7JN97WYrLxuX3sA9MBsjdKuOChq
	d7MAG2+ZO3ICkgKR8enyf6ftwhh1IstMcLK99/bkA5Q==
X-Google-Smtp-Source: AGHT+IEasUAnsCjjEU7kkZN4XsU9GWJ8G3GIagukhq7hmK1v/JFF3UnIXc8rWmqtDB232dzP+SQlog==
X-Received: by 2002:a05:600c:8b03:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-451f0fade9fmr66739725e9.32.1749137923998;
        Thu, 05 Jun 2025 08:38:43 -0700 (PDT)
Received: from ta2.c.googlers.com (213.20.187.35.bc.googleusercontent.com. [35.187.20.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb2088a5sm22158835e9.21.2025.06.05.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:38:43 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 05 Jun 2025 15:38:26 +0000
Subject: [PATCH] firmware: exynos-acpm: fix timeouts on xfers handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250605-acpm-timeout-v1-1-1dbfdbee30da@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPG5QWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNT3cTkglzdkszc1PzSEl0TYxNTcwtTA4NEYxMloJaCotS0zAqwcdG
 xtbUAor0BA14AAAA=
X-Change-ID: 20250605-acpm-timeout-434578500a34
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749137922; l=4289;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=qNAmmRKC2jTglldpcDlO2KCXuzEUgGG1x8yJRBImMT8=;
 b=1Z/GFCXW1+ZqzSheOjbJBBWUWhL1BfaxkJJGRkPiPuLM//cM8JZvKHw0CmMrB7Drg80EUon9w
 qW0ghk9KheqD1dG72mvPSAGxwmTt5zE9tTIXcHWMMHWa49n73BUgWqT
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The mailbox framework has a single inflight request at a time. If
a request is sent while another is still active, it will be queued
to the mailbox core ring buffer.

ACPM protocol did not serialize the calls to the mailbox subsystem so we
could start the timeout ticks in parallel for multiple requests, while
just one was being inflight.

Consider a hypothetical case where the xfer timeout is 100ms and an ACPM
transaction takes 90ms:
      | 0ms: Message #0 is queued in mailbox layer and sent out, then sits
      |      at acpm_dequeue_by_polling() with a timeout of 100ms
      | 1ms: Message #1 is queued in mailbox layer but not sent out yet.
      |      Since send_message() doesn't block, it also sits at
      |      acpm_dequeue_by_polling() with a timeout of 100ms
      |  ...
      | 25ms: Message #0 is completed, txdone is called and message #1 is sent
      | 31ms: Message #1 times out since the count started at 1ms. Even though
      |       it has only been inflight for 11ms.

Fix the problem by moving mbox_send_message() and mbox_client_txdone()
immediately after the message has been written to the TX queue and while
still keeping the ACPM TX queue lock. We thus tie together the TX write
with the doorbell ring and mark the TX as done after the doorbell has
been rung. This guarantees that the doorbell has been rang before
starting the timeout ticks. We should also see some performance
improvement as we no longer wait to receive a response before ringing
the doorbell for the next request, so the ACPM firmware shall be able to
drain faster the TX queue. Another benefit is that requests are no
longer able to ring the doorbell one for the other, so it eases
debugging. Finally, the mailbox software queue will always contain a
single doorbell request due to the serialization done at the ACPM TX
queue level. Protocols like ACPM, that handle their own hardware queues
need a passthrough mailbox API, where they are able to just ring the
doorbell or flip a bit directly into the mailbox controller. The mailbox
software queue mechanism, the locking done into the mailbox core is not
really needed, so hopefully this lays the foundation for a passthrough
mailbox API.

Reported-by: André Draszik <andre.draszik@linaro.org>
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index e02f14f4bd7c96de6ebb50473005de520aba1c4f..56b5cfdc63036b6214e5e8a5d30faabdd63b2dc3 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -430,6 +430,9 @@ int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
 		return -EOPNOTSUPP;
 	}
 
+	msg.chan_id = xfer->acpm_chan_id;
+	msg.chan_type = EXYNOS_MBOX_CHAN_TYPE_DOORBELL;
+
 	scoped_guard(mutex, &achan->tx_lock) {
 		tx_front = readl(achan->tx.front);
 		idx = (tx_front + 1) % achan->qlen;
@@ -446,25 +449,15 @@ int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
 
 		/* Advance TX front. */
 		writel(idx, achan->tx.front);
-	}
 
-	msg.chan_id = xfer->acpm_chan_id;
-	msg.chan_type = EXYNOS_MBOX_CHAN_TYPE_DOORBELL;
-	ret = mbox_send_message(achan->chan, (void *)&msg);
-	if (ret < 0)
-		return ret;
-
-	ret = acpm_wait_for_message_response(achan, xfer);
+		ret = mbox_send_message(achan->chan, (void *)&msg);
+		if (ret < 0)
+			return ret;
 
-	/*
-	 * NOTE: we might prefer not to need the mailbox ticker to manage the
-	 * transfer queueing since the protocol layer queues things by itself.
-	 * Unfortunately, we have to kick the mailbox framework after we have
-	 * received our message.
-	 */
-	mbox_client_txdone(achan->chan, ret);
+		mbox_client_txdone(achan->chan, ret);
+	}
 
-	return ret;
+	return acpm_wait_for_message_response(achan, xfer);
 }
 
 /**

---
base-commit: a0bea9e39035edc56a994630e6048c8a191a99d8
change-id: 20250605-acpm-timeout-434578500a34

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


