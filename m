Return-Path: <linux-kernel+bounces-847798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E09BCBC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFB314E2502
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F343223F26A;
	Fri, 10 Oct 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMdf/wLq"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC81DF26E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760076744; cv=none; b=QxJRRD8e+Ldqe3UGOEL9ANcMlhI5WajNnuke1zadHIjp/qwNOBYxBrTSM4u8f3hMWoN8NjfEFiHw5F2F6u7K24RUHY5ZGkbR/i31QzRT4EUBoPVkk7e9M/JemiSgOgYkqrj0uYWg96ajA3gV8ZHo0d9lKtHbovKp9GvRdbAX02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760076744; c=relaxed/simple;
	bh=Ox5HfcBIa0Pd9ImGqX26Z7WFjqhZmoCpc19fwDDvGvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nZhafx1MmfLol2uoJOYKZTBc4EYYl2OfNnHOd2uXQUNP+E4PVRQelWFnotLzpSr4wI8fIcD9OTPAxzzSfJMLPoU63oQYXMztpSqyihDkE+sgwoO45ytOQWghuywmHQfH3AFGBw7cfcnEEy0mGJlhJm/yhj/1aWIEnn8c9BOkcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMdf/wLq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1246543a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760076742; x=1760681542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAUs4mxyOS0iY2X7XLxfa0TcqLPgyAiOiZoIgTVsHYk=;
        b=FMdf/wLqcLPS2zE04mMptPwnCx1xTmRUSart/DGd/954Md5mZDtGodYVq8lg7J09L4
         FzpMBB5vBp9W7RGTkrKAsvSLD9tkZqDRjJGYj0DEC8GrKhjm7n282Gj09B94Y31UQJn9
         EwoHDae/RaL5qpFi4ZxsZKQH+jU8ICt21GzwtNSp0L2Hx0dL1k6U4ZsasOYWDImhnAsJ
         XnEPKIflxmgkR2VyCej1b3a8VdNAVIhuY9CWYj2Qtv325sQ9bMVr9p/jHBiLH8rEByDd
         U4T0gn5CgxZd+PULdW5VM3e3hdd6B6qPF0QTlA5LOux5l3d1/MhbVXp0FfaYj+vwNreB
         qf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760076742; x=1760681542;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAUs4mxyOS0iY2X7XLxfa0TcqLPgyAiOiZoIgTVsHYk=;
        b=JTPDWZ2uLND2QBcWSNnWqtS40PE75dZRp3z4igjaPDt+XMCDPsZ+qPDDydMEPwvMIl
         5ffcS3hhe3+PS1RrqNRHXZOpblkqWtNzq6ZgJ/cZUBTZ/W8kRcD7zVo0YUs8xMFn8uyf
         hROzjzbpmS3RewOFZX7R4Sh+MZdaJ4kxAWBZnDBNEcwtbbkMyM4WFNfr9BM648kncTJF
         dsw5ZUUzip9+5abrp58apxl5bob1wH9KZ6/vMBPiKs4/qSus5kETzdUpR0b0FCabbJpw
         MK4nGBQJeJRT/rfBFvxtAg2VBPkSHfrcVy7dBZVZvpi94VzBC/DbNgCT+RTxNdRvs5JC
         8AUA==
X-Forwarded-Encrypted: i=1; AJvYcCWjAXmHh4FrgWQyZ6TgYJmT4xr6CJ9x44HqBt0DWjaIgHzrETm9/xCxYy1vXJ10q5o2V+ZtYw+0ale2L+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyJ/KeuwJka9KyrYr6iH5zfa3/m6Dy2n8+us9N8yYEpOdRBqF
	wfaH0Am0yvmdy9O0hLUO0ABE3Y5rjuWgD0CLAOyPChsN2rJD+Rx7i4oe9v7TEA==
X-Gm-Gg: ASbGncteHuRQknXxjyCnI8H2XPvMnDCtaKb6RIdwUE8XanIRraNYiJt0hPj3alR4ufD
	SYOFMrPCSPtTfSrCGNWKv+wO7XLMFSwd9EiWeFFsm+Ul0g0bNDGfQp5vwbd7wYwGaiZoob3g3dC
	pPbXlEjcDYACc3dSrvik2Mqc+3I3pGI+bYHqVSIqkJIq8DNVWuQdA3zDeam6H3SMe0KCyPAStfL
	4Visly0GdVwbQDe2gIiZKlG3oBSUYCvjo77KBZ5uq65miLTmM02Yp6LTwNtDReWsqJdikP8qsO4
	HBtsIWMxqTtXBcGnqlundjAdnZiuQUlfaNxGNtlD0JNA3Ay0sbUuMEzV87xi1zKUz+bKn9wQ1g9
	Ak3AUD0TCtre1jBNSWAahx8CGJlI1UiTzt98bEAaSrtTS8Py2FmPhUoyJ7aSxrFL6CnQTWSN/gh
	UH0LlaKou6rowNWsM=
X-Google-Smtp-Source: AGHT+IHibCd1Wm0g2BhXInFGKhNjAxMweDeOENyDko3pQXv/8IbBDLJrvtBuzPxZdKeg8K1kCgaeBQ==
X-Received: by 2002:a17:903:17cf:b0:24c:b39f:baaa with SMTP id d9443c01a7336-290272e1fe5mr143061995ad.49.1760076742145;
        Thu, 09 Oct 2025 23:12:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c593:2dc:16de:acd1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b71sm46446495ad.114.2025.10.09.23.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 23:12:21 -0700 (PDT)
Date: Thu, 9 Oct 2025 23:12:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?B?5Y2i5Zu95a6P?= <luguohong@xiaomi.com>, kenalba@google.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-input: only ignore 0 battery events for digitizers
Message-ID: <of5qjeij72wduee3zyf26drfcwhpsl4sjs3v6tfjv3tgl3xsol@sss7zcyawwaz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Commit 581c4484769e ("HID: input: map digitizer battery usage") added
handling of battery events for digitizers (typically for batteries
presented in styli). Digitizers typically report correct battery levels
only when stylus is actively touching the surface, and in other cases
they may report battery level of 0. To avoid confusing consumers of the
battery information the code was added to filer out reports with 0
battery levels.

However there exist other kinds of devices that may legitimately report
0 battery levels. Fix this by filtering out 0-level reports only for
digitizer usages, and continue reporting them for other kinds of devices
(Smart Batteries, etc).

Reported-by: 卢国宏 <luguohong@xiaomi.com>
Tested-by: 卢国宏 <luguohong@xiaomi.com>
Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ff1784b5c2a4..ba3f6655af9e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -595,14 +595,18 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 	dev->battery = NULL;
 }
 
-static void hidinput_update_battery(struct hid_device *dev, int value)
+static void hidinput_update_battery(struct hid_device *dev,
+				    unsigned int usage, int value)
 {
 	int capacity;
 
 	if (!dev->battery)
 		return;
 
-	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
+	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
+		return;
+
+	if (value < dev->battery_min || value > dev->battery_max)
 		return;
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
@@ -1518,7 +1522,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		bool handled = hidinput_set_battery_charge_status(hid, usage->hid, value);
 
 		if (!handled)
-			hidinput_update_battery(hid, value);
+			hidinput_update_battery(hid, usage->hid, value);
 
 		return;
 	}
-- 
2.51.0.740.g6adb054d12-goog


-- 
Dmitry

