Return-Path: <linux-kernel+bounces-723598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA58AFE8F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D481C46B84
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6221FF46;
	Wed,  9 Jul 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NupUPD60"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39591A944
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064284; cv=none; b=VRf7ayYAiAhC0fmRihYVjr+A8tv1xI7BNQ1ygDa5wf8zRuxgZpwkUMLKw4jeg6rjsVmvjFPE2yNIIYWJVq87EN8UG0EivHnciRP3tEeGA5BBa+iooT4cHBqbKDIywloMWULfmpUHVgv9lBKTByprkEX8pod4LRd0Y+H9mb/y+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064284; c=relaxed/simple;
	bh=Ed4Twb2CQqgQw/j9EYSd4UBoWLDImfPhC3bCjXHZGDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bTiy6JOQsTDaoOP4TDK/NSqBlQy9cYMKGORG3g7ndrs9yw5JaL/qtxC2QONa0gTvwZyPpXNyWHJRPJAb8eOwt39xVmPI1HIHTkuHg+nMpvo6h626BI3ks93fVzVMYIQfF/mJe2D+Jt5xK8Uk/8yHYhs11e1F03ZkXiXZUBHLcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NupUPD60; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so8589225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752064280; x=1752669080; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxL9ut2GQHQVUIwYpiqJ1CEIQmWXGnBhZS0iGBFnzFw=;
        b=NupUPD60hKQflrmS/NCM+34QfpsoKJ/JkFsJOcvC+mKWOD/1cwYgNpYLspuQaiNKAD
         9ihwacqGTXZFypfuojiiENoB4vMC2syZlTOC9dVlMSiZPhtDHSC6tWe0tm3YdvNyzzkx
         DpkV2QKHhKVYQaLXMRh3ehPyiEUhEvWmt/bOa1FD5exlXBl6KV56Syb1e6k5uHfcpbrD
         MkE4nOlD8ji/k2YHxWoQhSatv5XOiBy3e5VtrFqGBaYa+lzkTG3EJXDAcRFxaWh4bMrg
         k6pefp8mT/319EC/3OudhLf/zTzxGFC4xew8pqW9MoovwNS7FR1SfuJu7PsExbUeY8Ma
         zaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064280; x=1752669080;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxL9ut2GQHQVUIwYpiqJ1CEIQmWXGnBhZS0iGBFnzFw=;
        b=ZlyrC6ustFHqKU8/4Ew3KqsTs6w70qe7G6Y74W2QMHOYTTKiUkamwA0bRA12JF3GNS
         0afUP9+UneM6ltcY3U1oTHyDQcAt72R6GhqFShuvcqHFW785hPcMp7HPMTG0s0rapVzY
         q9YNF4DOEawyNZcn6IJbwt0dgM8PXow68ALf9Dro4zwzmzkGaeHw/YHfFBbBom3QKq9E
         F0eePN4BpRA0Up1dbEpIxjdAPytYMeMjb1CQBig3tYWhN+dI26tXjOJtvor8EwtrLBSC
         hSbn6I331SvX+8G8UdMLtrb3tCa6rr3Oo3ZguihJ0To2s76TKJFlbVEH7rK4OE/yyKtc
         S0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Dzq0izaRrTXb98qNxQCFWIc8IpnOGTArVDefVDTKE8+6pDKsrNHFyDFDGGPZK4HdxgszyiWpeItA/Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLi5Qs2tlxsbnHE7d7K6ZoKhzmscNDz3qY9NIUkC7llwQrsJ+
	Hwtsn2xvG7Kjp07677KJGiQb4dnJm1OXR2N4GQdf2K8UBS0LVh//7aceJWWE7cm8tXU=
X-Gm-Gg: ASbGncv2OHB1Vxe7Jq+Xid9sz8ScXlxk0IKYe7L6dQo5h+aZRoMR0JbDyyGPooY3jPi
	BWvqZE086lvIv+ej1c2e+LQA88LtiHXJIt3K59BpQxJKw4IbdEAoihP1DqRO8nCvjw/qsSs1rjL
	YnZULilsRTqp1lxAn6pqwmEOu+i9gpB0gM7tiaQ7qc8HP9O5A2jAGTY5eJIQxeakusnf9L6zrWY
	Y7ypGPsWE0BhzlslGQZ/YYjs88c464XKoqDsUwSVByqEv86gRUV80cSWE3kt/ByMar+Z869b1js
	bZamas56SSCpjNZj1bdcJtpei58UbciF6Cts67F90A5owc4YySXwFftmcCz4K6LSqeLLfCGR2Sl
	R0z8r7F6aiXLeMdhvLb4vpaKSCuoKg88g2vegd+Vv3g==
X-Google-Smtp-Source: AGHT+IHWj61MUObzg8zjh1Gu+Q3+ULmgD+3Tet7Gf0YlEwHB9HCZZ9zrT7ksgxYACN6D+ljPvcYnRA==
X-Received: by 2002:a05:600c:450f:b0:442:d9fb:d9a5 with SMTP id 5b1f17b1804b1-454d5601c97mr22911685e9.9.1752064280407;
        Wed, 09 Jul 2025 05:31:20 -0700 (PDT)
Received: from ta2.c.googlers.com (24.125.187.35.bc.googleusercontent.com. [35.187.125.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cdb549absm37887155e9.1.2025.07.09.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 05:31:19 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 09 Jul 2025 12:31:16 +0000
Subject: [PATCH v3] PM: add kernel parameter to disable asynchronous
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pm-async-off-v3-1-cb69a6fc8d04@linaro.org>
X-B4-Tracking: v=1; b=H4sIABRhbmgC/32MQQ6CMBBFr0K6tmYYJKgr7mFclDIDk2hLWtNIC
 He3sHOh+av3k/cWFSkIRXUtFhUoSRTvMlSHQtnRuIG09JkVAtbQwFlPT23i7Kz2zLpjNBWhwYZ
 YZWUKxPLec7d75lHiy4d5r6dye3+EUqnzOgSwFqr+YtuHOBP80YdBbaWE/2zMdsOmN/WJobTwZ
 a/r+gEwuYca5wAAAA==
X-Change-ID: 20250708-pm-async-off-bf2a3e2a27ef
To: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 rdunlap@infradead.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752064279; l=4059;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Ed4Twb2CQqgQw/j9EYSd4UBoWLDImfPhC3bCjXHZGDE=;
 b=uuL2Ulb+3/5msMT8ELf6EoI8f2iEqu5Jl2oVMDbZvKJlIX1YmEO0S4Z1QBX0sUTOet1t961Rj
 B1v9AS7MguyC/vXudwLkhLrbrauVbYUDHuQxaeJl6H80Q+tJ3mDaN2x
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

On some platforms, device dependencies are not properly represented by
device links, which can cause issues when asynchronous power management
is enabled. While it is possible to disable this via sysfs, doing so
at runtime can race with the first system suspend event.

This patch introduces a kernel command-line parameter, "pm_async", which
can be set to "off" to globally disable asynchronous suspend and resume
operations from early boot. It effectively provides a way to set the
initial value of the existing pm_async sysfs knob at boot time. This
offers a robust method to fall back to synchronous (sequential) operation,
which can stabilize platforms with problematic dependencies and also
serve as a useful debugging tool.

The default behavior remains unchanged (asynchronous enabled). To disable
it, boot the kernel with the "pm_async=off" parameter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Dealing with the pixel6 downstream drivers to cope with the changes from
https://lore.kernel.org/linux-pm/10629535.nUPlyArG6x@rjwysocki.net/.

Similar to what people already reported it seems pixel6 lacks proper
device links dependencies downstream causing i2c and spi client drivers
to fail to suspend. Add kernel param to disable async suspend/resume.
---
Changes in v3:
- update documentation with "pm_async=" and "Format: off" (Randy)
- reword documentation to make it clear "on" isn't a selectable option
  for pm_async because it's the default behavior.
- Link to v2: https://lore.kernel.org/r/20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org

Changes in v2:
- update the documentation and the commit message to describe that the
  "pm_async" kernel parameter provides a way to change the initial value
  of the existing /sys/power/pm_async sysfs knob.
- Link to v1: https://lore.kernel.org/r/20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 kernel/power/main.c                             |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..06beacf208de3242a3b4bb2413ab6cd3e0083f15 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5000,6 +5000,18 @@
 			that number, otherwise (e.g., 'pmu_override=on'), MMCR1
 			remains 0.
 
+	pm_async=	[PM]
+			Format: off
+			This parameter sets the initial value of the
+			/sys/power/pm_async sysfs knob at boot time.
+			If set to "off", disables asynchronous suspend and
+			resume of devices during system-wide power transitions.
+			This can be useful on platforms where device
+			dependencies are not well-defined, or for debugging
+			power management issues. Asynchronous operations are
+			enabled by default.
+
+
 	pm_debug_messages	[SUSPEND,KNL]
 			Enable suspend/resume debug messages during boot up.
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3d484630505ae91fea29f7f9b3fbcf7e585955d8..3cf2d7e72567ecbea2cd80acd3c7f6da85f5bef4 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/init.h>
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/pm-trace.h>
@@ -112,6 +113,14 @@ int pm_notifier_call_chain(unsigned long val)
 /* If set, devices may be suspended and resumed asynchronously. */
 int pm_async_enabled = 1;
 
+static int __init pm_async_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		pm_async_enabled = 0;
+	return 1;
+}
+__setup("pm_async=", pm_async_setup);
+
 static ssize_t pm_async_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250708-pm-async-off-bf2a3e2a27ef

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


