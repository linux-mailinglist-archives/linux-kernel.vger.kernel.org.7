Return-Path: <linux-kernel+bounces-836316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DFBA94AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0192A1920E19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4C306D2A;
	Mon, 29 Sep 2025 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCA6j1jJ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947D306B18
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151669; cv=none; b=j9g/10OHUgazi+uSFGSvMpWuMGLHD34tnTpZ1z9i0u919BFGTYu7FH2cFZU9nSQ/nxAjeTb0NPg6qBo+OJBWD0yV+/KV1Dzs6Em8oL6H8zYhh5pMQOw2NR41h+kUJ+HohnVmGCPsz3JwgPcvWoszWY/l8KTIME0I6rroocsE8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151669; c=relaxed/simple;
	bh=Mv/b8aVCVxNhM1F+1VoETRpSIMA8dMlQJBW4BOZFGXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4ARpSn9zUOAxQ0EJV8PqfPfhmEF/eA+kSki8rmK6FmOf+4hCaPzrEkBtPUQiHfXpIYqsApakRFf/4UsU7FA6c7oJxFBLX7vtmJWCh3fQX1GjxAnqldC6Ban8wxpxAhWXGttMjg3bFlpUhovXuTTqJTm6vPPxIinAdy/PkwMiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCA6j1jJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-579d7104c37so6470801e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759151666; x=1759756466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1TScXo9HlddRXxyVV537w+xJu4r/bR5+Sl4AGG4P1c=;
        b=ZCA6j1jJEElIyVAbgMXM3uSQnJIreXe1usmhSPoGi7D8yRJgbFLE/Yt+/6YgjuDi07
         dvMDC/V12e+aawDPrRngopE5+w5HcuCvbz+/NZ6f3vdlz6B4v8iESF9AIBtah/tNBOdx
         oIBAiVCgeKEf2IvrQ9zQwuW57A3231KnonJE1FSF57BL7usnZMJ6Jo32yN1xkbRzZxtb
         fYmi8frJsnyb5LfX5TmNXXhg5N6GCEm4cKwe65G4peQCCNcEf7KRegAhWazrDcKyk0z5
         0UX+62TjRLR6hau2ZyBqaUgtOsQNzWpLJelw5axw8yApRAWikxoD4Ns5ou/YFaUG/wL/
         +4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759151666; x=1759756466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1TScXo9HlddRXxyVV537w+xJu4r/bR5+Sl4AGG4P1c=;
        b=fwsfjt2FA9EtX8ajicml8iEZV/m+tRr1BRK4LxUm7FFl9/NAWF4PE1b9WKdRMvRG6P
         FKpLRj3lnNCVr3CHd9icc5xPlTtAMu9RSot3KG3tGbO/OZapcW+6usAwj07bUMSOQ+tA
         7a2g9LxH2t45cKxC7XgUbW0BVXeRGBBqd3YS923Vo7yX3t7rGegwNiTaJz299VinlT2j
         Mjn4Z9/I888zunO/taleN2nDQ9ZHhDJNJnBbNXnqulokpP6RzKRyELXDEPQ6gG94uifA
         Qa6z0eGGR3bp2w4S2rEa75G2mZ34nffOtuOtqix62i5BS0YbvTw6kPjG2c0VI7HiI2st
         e+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU9Mua7CVaL1QPjJZVhiVDiulTsEhoseaRuHUlef6viS1UJ71y8CxF+AjqK+sBV66DsJWJd01vJnxsxYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNv+eSu3hn20C4KtKXj6DUYWLM3gwailUlKFb6UQ14BNQAskwJ
	nO6t9qF6y2dbEyqsPX/+pxq0JkNyNwtBuEnZVb7iEnJahoq56OxFueEt
X-Gm-Gg: ASbGnctSPhS9IRojfxThd/UtbJdPWIt1Xhsp8BF8hFlHEh1Sn+cGQPAS2Ozdmx/vmnn
	ClF0msJQJEsxD2OMypKZ7rUvBTMcCw/3rOZqjVMTXOVKVHg3hqTKUZPdoqapJZ+PuvLjGskIJJU
	7Xo14XV88AStXuESUIb2qhGb1wcKuMMlrjESkoyW5VdzhV5y4LxxoTqRXe7XwI6RJA9u2A4Ymb8
	DmbLdFtJt0fn2GbxROyiJ1GYo4iE2xXw/c/MHwM75ECzYSv76NpQmwJPS2ohzjDxZkarwUrQ20U
	EF5Ixy4M5NoNKu3Q6U1rbYnlr9k+NGF/rOWKYU7Z8LnJtSF7Vmp7ULBdhAVLbztUc3gGAwNtjvN
	LJVVLfwxCuUIOJoeRaZj8MyEVIz3ODuKMkmrEbhew
X-Google-Smtp-Source: AGHT+IFdZvltpHwZV1hUFDUAn+X1LBVfg1iTgq2zM08qx+yjkvQ6KOYUEgmP09Fpq9EwiTOtStUDCw==
X-Received: by 2002:a05:6512:224f:b0:57b:7ca2:f02e with SMTP id 2adb3069b0e04-582d092db20mr5490234e87.12.1759151665722;
        Mon, 29 Sep 2025 06:14:25 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-588767b72e3sm461758e87.41.2025.09.29.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 06:14:25 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
X-Google-Original-From: Artem Shimko <a.shimko.dev@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: a.shimko.dev@gmail.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rivers: scmi: Add completion timeout handling for raw mode transfers
Date: Mon, 29 Sep 2025 16:14:21 +0300
Message-ID: <20250929131422.525315-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929131422.525315-1-a.shimko.dev@gmail.com>
References: <20250929131422.525315-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix race conditions in SCMI raw mode implementation by adding proper
completion timeout handling. Multiple tests in the SCMI test suite
were failing due to early clearing of SCMI_XFER_FLAG_IS_RAW flag in
scmi_xfer_raw_put() function.

The root cause:
Tests were failing on poll() system calls with this condition:
    if (!raw || (idx == SCMI_RAW_REPLY_QUEUE && !SCMI_XFER_IS_RAW(xfer)))
        return;

The SCMI_XFER_FLAG_IS_RAW flag was being cleared prematurely before
the transfer completion was properly acknowledged, causing the poll
to return on timeout and tests to fail.

Сhanges implemented:
1. Add completion wait with timeout in  scmi_xfer_raw_worker()
2. Signal completion in scmi_raw_message_report()

This ensures:
- Proper synchronization between transfer completion and flag clearing
- Prevention of indefinite blocking with timeout safety mechanism
- Stable test execution by maintaining correct flag states

arm scmi tests: https://gitlab.arm.com/tests/scmi-tests/-/releases

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/firmware/arm_scmi/raw_mode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 73db5492ab44..fb83beb42e7b 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -468,6 +468,12 @@ static void scmi_xfer_raw_worker(struct work_struct *work)
 
 		ret = scmi_xfer_raw_wait_for_message_response(cinfo, xfer,
 							      timeout_ms);
+		if (!ret)
+			if (!wait_for_completion_timeout(&xfer->done, timeout_ms))
+				dev_err(dev,
+					"timed out in RAW resp - HDR:%08X\n",
+					pack_scmi_header(&xfer->hdr));
+
 		if (!ret && xfer->hdr.status)
 			ret = scmi_to_linux_errno(xfer->hdr.status);
 
@@ -1381,6 +1387,8 @@ void scmi_raw_message_report(void *r, struct scmi_xfer *xfer,
 	if (!raw || (idx == SCMI_RAW_REPLY_QUEUE && !SCMI_XFER_IS_RAW(xfer)))
 		return;
 
+	complete(&xfer->done);
+
 	dev = raw->handle->dev;
 	q = scmi_raw_queue_select(raw, idx,
 				  SCMI_XFER_IS_CHAN_SET(xfer) ? chan_id : 0);
-- 
2.43.0


