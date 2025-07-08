Return-Path: <linux-kernel+bounces-721769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60689AFCDA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A8216A2E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3392E03F4;
	Tue,  8 Jul 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvLnkvfG"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FB1E22FC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984922; cv=none; b=U+WhXvdQhyPAIlWwIAWtwux3I/uAiE41xSJ2ogeYibuvDYduKU2fi9xi3ryol00ctjdHsr24BWQrK+D+/uXguOIYZE/PNktSzWE4C8oSQzcYlLkSShp+eSTTE+8/6+2Ukfq+1ghoQ14V2UQ7Laa1nSuKQeer+c9zn7K5iYoxi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984922; c=relaxed/simple;
	bh=jWrF/dpjWXBvpXy6EsBSTMmZytF1FtpgbDD05a1Vidg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GfRwlmbof0LvndQwkuziySOks3CGUvzzOhUf5yayJJhABz40JnOQdM7qXvhDm4uTv0BXZyXXsYIG12ALrP2MaeFLVDwpZK04ESgkcRMbQsyqZ/y9hTZpizzWH4JBj1safFMRX0cMN2FhX0A9ObZYk/CoxIijSCwbGYdJ1zF+hOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvLnkvfG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a575a988f9so2828592f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751984919; x=1752589719; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1u0ZnpKBMPq+ESjeFyy2iZIrYKgj2r6h5XgXP2nS68=;
        b=lvLnkvfGU6EcDzZAQkuAv3FNXGz/6NbOGaFnU7bg+OTfkka61x6ShSQ5PiapE8acCp
         414S5KggiPQ36rrhbLvLRVaZwkljUaYFp1W2OQSRupPTWuLixPAubEhGZbgYgVpyyMga
         qAExDhcLyjdUFfWeN8kj6h4je01ycDPwspq9J7l4Yf0gA8a1YmrIeCtbr9cxxd8TEOI8
         L7GiloLjr0g6d2WZTpmPO4DySrNpcZf0kby5KS4IJwPDTjwkYaZHsa+2rB8qR8d7O1mc
         sjVewX9U94XJoYEQ5k5kN+LC8z06QBAPADpNPzLwmrMzbYByp0A6MEmIVrymE5j9KFYE
         WHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984919; x=1752589719;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1u0ZnpKBMPq+ESjeFyy2iZIrYKgj2r6h5XgXP2nS68=;
        b=nKqcPit9riLgKwBZgAN3hZyTN0jxcoIhFbzBRgLps02BfknxBICH0u8MmAyLoxEGg0
         YsevIo2nfIo5g6XMfBpeIAeu/pjbRoEX/5EQ3YSabKqMt1v2q5vJfcVTseCC2SWqTJLJ
         k8A6oW/9RkudIXLCyQNJ0QmiXLszjnGIWp4Nl3WZfh1qzSsV6IfjDDP/R9zblt21dIYk
         S00wbvCSo+yE3T4N7Jw7+9ZwMqXpoZf5gXav96MpGSmzEtgokUf3UNkPpNfKKdr+ueIo
         SoFXXvLsofdPeWGw+nSE0jfT+rayv8OnRNGQWzF7ZrYL2jqTstQ4us79VUlUC3b8ie15
         uzYA==
X-Forwarded-Encrypted: i=1; AJvYcCWs/IYPCC7y0DRN9EJyacs5mFqu6RpYOJxgs7HemH+92kPwalX4roHPOGNAmdCb3M00ztx00Lgu4LID/Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfONbrlQwwOvNgW6x1CF87kITcwd0PkPMiw2uMgs4G/D6bxLB
	QFqc9QLKQGGdgMsLA6zYn4mC2cBOV/eHGyRm2Ihf5vGpMytHcdtXV3FL8qXYSOhlCyk=
X-Gm-Gg: ASbGncuM3cwUzj+9gcw5FwiHucrjpaI3ngk/L91EbXsspq70loAn7babDAs8hVFYLnf
	ZxMurTMJeHPi3fK3A4o+wAyB6skHVV7ZKjgajPymi9XspCsRiC3xAqSbOs95VkUN/sF5B0YqdI5
	/6KXFvrp029VnStpDsNMbxCOliu7IErd22qvOJv9G3fFJtWML1+BRZWw7gXwbgzd72nmWcCZiPn
	0OZUmgAu8mBjNM6Y2q++4TdQU8rgL6Ty9WsIxWhC8kMABO5DiV4xOL8cj3mdkUswr1PitR/aGyA
	XNcyiMvjqAM6pAlMh11PkIoHHrUnQiT4daTb+HrSv0s9BgVB6jg+05OxOWMytj5t4mR00UwE547
	gxOMi6obPrclJtBaDq/WYO7It8NVRoAQxUBXudPLtAg==
X-Google-Smtp-Source: AGHT+IGHYlyW/KuMeQ38ZTMg8cjufpV+V4CRuoUvRrQjYHvmdYHiGY/2hZbUDnpbC+myZxX6Hsqw1w==
X-Received: by 2002:a05:6000:290d:b0:3a4:dc32:6cbc with SMTP id ffacd0b85a97d-3b5dde8bb2fmr3026994f8f.20.1751984918672;
        Tue, 08 Jul 2025 07:28:38 -0700 (PDT)
Received: from ta2.c.googlers.com (24.125.187.35.bc.googleusercontent.com. [35.187.125.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d099esm12963602f8f.21.2025.07.08.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:28:38 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 08 Jul 2025 14:28:35 +0000
Subject: [PATCH] PM: add kernel parameter to disable asynchronous
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org>
X-B4-Tracking: v=1; b=H4sIABIrbWgC/x3MMQqAMAxA0atIZgM1IhWvIg61JprBKi2IUry7x
 fEN/2dIHJUTDFWGyJcmPUJBU1fgNxdWRl2KgQx1xpoezx1deoLHQwRnIdcyObIsUJIzsuj978b
 pfT/H+3OQXgAAAA==
X-Change-ID: 20250708-pm-async-off-bf2a3e2a27ef
To: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751984918; l=3222;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=jWrF/dpjWXBvpXy6EsBSTMmZytF1FtpgbDD05a1Vidg=;
 b=ZNYMiW1EANTACN67LgcSUzSu4Nbqflr85S7w13JDo9s/T284rPyYfYKZDkPV/U5QUb7yiydKA
 UjSZAMdLQWKCo9ztdFEtbW8KCtERSMMB8BsrRaJLnONnjWGGmBZBXuR
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

On some platforms, device dependencies are not properly represented by
device links, which can cause issues when asynchronous power management
is enabled. While it is possible to disable this via sysfs, doing so
at runtime can race with the first system suspend event.

This patch introduces a kernel command-line parameter, "pm_async", which
can be set to "off" to globally disable asynchronous suspend and resume
operations from early boot. This provides a robust way to fall back to
synchronous (sequential) operation, which can stabilize platforms with
problematic dependencies and also serve as a useful debugging tool.

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
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
 kernel/power/main.c                             | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..55ba3e747d86c09a0696e105a1d9cd99218f0c07 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5000,6 +5000,15 @@
 			that number, otherwise (e.g., 'pmu_override=on'), MMCR1
 			remains 0.
 
+	pm_async	[PM]
+			If set to "off", disables asynchronous suspend and
+			resume of devices during system-wide power transitions.
+			This can be useful on platforms where device
+			dependencies are not well-defined, or for debugging
+			power management issues. Defaults to "on" (asynchronous
+			operations enabled).
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


