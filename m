Return-Path: <linux-kernel+bounces-836313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32377BA9496
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8071D1920B27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A383064B0;
	Mon, 29 Sep 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaryIr9s"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3363064A3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151421; cv=none; b=qb9zXorlsh7d9eu4pV5QnutnETswwLUeWi6n/tre32yWS7YB6pfWkaM6qw+yQAce5+H/tJLJLFsyFtPxfSz60g9/8h6ykVd7YOqYmIALBwcdTKfqsViiuNADTce2chMM1zav+NUN/QqPDDU65nJzw3INxZi60kAeTCyTEe9fpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151421; c=relaxed/simple;
	bh=Mv/b8aVCVxNhM1F+1VoETRpSIMA8dMlQJBW4BOZFGXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYamhAdOSpJbTNm3qhcVzVu3g8tj1S5CZD5Rw3+AaGNabnmJa7j/rxN9ETumwbWOgRgHmJZWdA1lYp7T/ptC6fLMU4i/70Mw8LtIhvNZF1HELBFCMhWSk7cmPHTEc48Vkwv6zA4whZuE/o/lmhbEp02Q/NrjutyAVpNWhq0MqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaryIr9s; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-33ca74c62acso45255641fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759151418; x=1759756218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1TScXo9HlddRXxyVV537w+xJu4r/bR5+Sl4AGG4P1c=;
        b=YaryIr9sjVlUO3ru9JknL+gPST9dx5fZzhNWVNEB7ZZlhr4Z8x3CmvgRHoe8kqNrwB
         lTFlhaDpVk1YWsHYUSgd97LWwWxFaTx+0pLxGjkqClo4nnuAXLziONh2UEaWDMjT9RXF
         62EwjGCSqdyWJDiBk6eHUkKzxXjtpm4InmaEk8+QohEbI87Q7nU4tYOhdMyHgBV2abUG
         OSqo15MibW+W03kFYk7WLk+vjhxJeR23WIEaBsg7CACeIgs8A0U93by39oVapY6GIhAM
         XeZSLQPV1HLR6saY7fkFYxRODpgq71xv3Xhs/vIoSk+as32xmjeQB+jaS7O1Z34Fm/iR
         lgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759151418; x=1759756218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1TScXo9HlddRXxyVV537w+xJu4r/bR5+Sl4AGG4P1c=;
        b=cQk5YK+1E4otqZKKPIK1ciuMEvrzJQORt/M/Xxl5c0gkzq0penVwd9qV7Eg0mhBva8
         LX8p2NiYui41QZiGesdxAbZc92/jqxiVrO6xj2kQiaB8PwPzeXA41ZKIUudmWt7fcc2D
         2ZSbI1krMkxSJJ4f1Onjqr5Bi44mMI+c00ada63yPqCmaB4G975yK/OHBUmHEVQTlf69
         lAK+AdAyed2oKkLwu2AIv6P9OlrCwHklFPndU2ZHafkHnSpSTIX2kl+YqNjnjyhSsjwT
         Ydkegvo5emY+YDJ0QQ2rLXhZBZF76fYQrU33UPo3l/bWyS34OroaFsUaINaiqzd6WQOg
         ugow==
X-Forwarded-Encrypted: i=1; AJvYcCVZGA9MKBcCE4GB2uYTRqwI5N5qz7E9NCBdanvqgnLjhwwCNG5ViMqZ9K/5l5+hS35uE07XPdfv1PHwmxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTO8MsFHYZEjF3fzkEE2VysMfYmGT6Q4bRWUwx8BXMOuQ71vz+
	tXDHSDYn/96+tjAqrR+QCV6YPy9gH7VFwjEWP2U8mpD4bNjM4g6FuZuX
X-Gm-Gg: ASbGncuRPJi8insbflfo6Iqh5kHozFf+kxZdv2lue76F1KJ3Mtn0urmH3WIGDsS7IrK
	rpTlZ859u2oQn4aOHHHVQYFe55QzwOha0xZ3GWZrfjx3qqOQRi8ZEsjE35NTvaYFjhBMF+TfiKs
	rLIHoe7tm6F0JrTTBb7ZQElhluj2ZDMQHMCR91PPUmCSP4qhiPN6yNSFLQV4s4KzCq5RUkAXOXI
	cknsz6d7M4/8A9VNDfnVdOTVOrgvFfvWaKwB8kz5n6kHzq3JWMrTMJmjMy/28XguMssN1UBadXp
	j4Mux4antaTew8rd8HWBqhK1UlH8pE4aA7/+CohygkKfrHKV8O2TFBcpmwEuau9GsQdlXUF1SGR
	600dFZ8piKE8m6KZzqBgseaLxY2lKStzKbB2q4NHC2Cwg+Fc7XFY4oRvQAAnTvg==
X-Google-Smtp-Source: AGHT+IEcUX+DjySA65AZ4EirRuxBQ8lIGoA5qOge8LkJpCU+G4WGmi1HxUDdlfwOC7g7+7QmeV3SjQ==
X-Received: by 2002:a2e:bea0:0:b0:36d:6ae3:8146 with SMTP id 38308e7fff4ca-36f7f247f42mr47225651fa.26.1759151417546;
        Mon, 29 Sep 2025 06:10:17 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7bfb413sm26246441fa.56.2025.09.29.06.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 06:10:17 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
X-Google-Original-From: Artem Shimko <a.shimko.dev@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: a.shimko.dev@gmail.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rivers: scmi: Add completion timeout handling for raw mode transfers
Date: Mon, 29 Sep 2025 16:10:10 +0300
Message-ID: <20250929131011.524842-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929131011.524842-1-a.shimko.dev@gmail.com>
References: <20250929131011.524842-1-a.shimko.dev@gmail.com>
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


