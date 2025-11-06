Return-Path: <linux-kernel+bounces-889403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D2C3D790
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5C5F4E02BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C989305E05;
	Thu,  6 Nov 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4hd8ZyC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908A1F03C9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464086; cv=none; b=jh1/kubS4KJxgyrEvXd+kkwo7uCyYvF2HcHMMt4c80bvL0ftNse8BeVD+qPspt3HT2BJ5wjL46CBplEEzUbe94YqPgCmpfH+mZI6/joQEKPabvmZD7S50g7jvUciiZ8UiKUyKSgLKkWgIoVwbcnd1aT8n1acFTIpYs44gry8FYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464086; c=relaxed/simple;
	bh=jSzKWqr0vfaMJTVkCWGxYqps9AjxQj1t7eU9pBBZbAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqYgFBfdEAMm788xJfCmhrPszX85KXO7bBg4vMc6SNeSTLBtt1INz1uV1pDue2fljsml3lRoZWtSe0UfxRpROAsWqX9dLMj3IuLwGjIXWNBVrku1SunMDGAvcyK0JNwnvW0WJExx8Ux+MpoogcjqGZ/GmeTpgYWmgGVXx2bfO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4hd8ZyC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so111557b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762464085; x=1763068885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5F887MQIF+aT57M0ZWlF9T7zoNXNuCnKmSum8jew75k=;
        b=O4hd8ZyCBpv86GEBKRQF3buQzp6KgAzCSdb8G0lkN2d5LN5/AqWtTLlGyNzihs/gYL
         fLtMwjfI2+KoYhtP2EuqGCl1hbIWB0kYy4wh60slKN4D5OJpEWUQazGfyHsAu4sNG2h7
         ndBee39oXwY7bdCr/mzNx3oSsVSOHRYyK9svdancJgbxm7ivnfnjMYz6XDKRh1i4HO9J
         627pQf1RjO8gU85k+OuF2n3hbXPfArJL9v2QEPhj1xR65iAHNthsCylmX9rz9JSy72ch
         W92GZmDZn/hUJZ5NS0keYwGpQPqXyQms2oy40VJF8eArfbgv3ZApmBc/ghY6FWd756Yb
         XVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464085; x=1763068885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F887MQIF+aT57M0ZWlF9T7zoNXNuCnKmSum8jew75k=;
        b=UXksvEdlhhD72UHLrWoGNq7gy3R5/iGZsXqtsE85Zfq2y5TskiovnLjn4b9TE7aEB1
         X6NFWcuULvehPAUShZvK/fpRmG0qO466U7eX8LJMUYVQSQOppeo+unoLRd4ctehYE8Io
         qa5Z5qHKnSGYcquhGVKFBt907c7/ehP0cgfDISXKSXb2PNq1634Je9tcN/NettCZpSPy
         QtTovu/+TnNkfd60vwO3Vl8R1l0oUIyeggkvDqJrmKih2S+RI0Y7j0a04PRvkFJ7YELq
         xJ37KF43dImV/xtPmzi7xtHuKZCW4DjvzmkCQ7yOGBZmuaYqX6IDDSbZUnjLXQo/7CwU
         Oa+A==
X-Forwarded-Encrypted: i=1; AJvYcCX1MndZhJpdmlXbHJeLAf+qALmr8YmhxmUFG49AAm+qi+3h2RfXe+OvUkjXU6qP3RmGNL5z9MjrlOn5QW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4Trnk/uAmoeJsF/khvGotYHm9O1db8a0AHi+R0vuGtwncxyu
	q56J4jmzctQ3Ol7w1wYTqVHF9Vb2YCYA/mqaquKZLysqz8cE+FGaigL/
X-Gm-Gg: ASbGncsbwqhibMn1F6kB/JYSabbjNtx9YajHIz5nLwD2FsMAwwx5Z2JAIMyoDycoRAN
	AI+AynGZTG9nVRRS1YcnpGuV6aZa4Cvr1q03MEd/Uh61kgBuyPCxJmQncjhtzhFYa+kBjFkaMkt
	OmuE1nSTiB2JrW3vzm5ROvf+qwEIwrx+CinmFzlJ9KcdXxIXfUoW5NqNlT5M9CwwReSVxrseNDV
	WLdDGGM0Qvi1xtgTE0y4puuefvE253ZUK30x47m0znNVvVHTCcpHded5JjxWFXFiRsKJRcA/8j7
	YZobTDHGMTZmHXuhfIUw4rYmAcytJZhiBwikPJkUTDPCqbrFLH//uKHJnw+yxd44AXC8nNMXwOE
	XpHdNMQFcOoCP2IJp113nqDrAOWZUYYAA07VyNxeYhrMC0DZ0n/fdwSE7jhTjTRLKLURRbYsCkf
	L2B/MNS+KzkGWWeyDmZhgXXyTAdf0TjAPrRdC6QKEuNRl374F6oXzg+ykQkwtSytEMsRg=
X-Google-Smtp-Source: AGHT+IGb5UU5LqOK9HNMDNWz+iA8UN/wT17BrzGBhaqUQJYwDSTtl1qRtQDwyVjhhL17NR6GPPqc/g==
X-Received: by 2002:aa7:88d0:0:b0:7aa:9e4d:b693 with SMTP id d2e1a72fcca58-7b0bd1bbf07mr1358378b3a.17.1762464084662;
        Thu, 06 Nov 2025 13:21:24 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm521360b3a.12.2025.11.06.13.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:21:24 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/3] Add extreme platform profile
Date: Thu,  6 Nov 2025 13:21:18 -0800
Message-ID: <20251106212121.447030-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "extreme" platform profile mode and uses it for
the lenovo-wmi-gamezone driver. It also adds the Lenovo Legion Go 2
to the extreme mode quirks table.

On some Lenovo Legion devices there is a thermal mode called extreme
that corresponds to setting ppt/spl vlaues to the maximum achievable by
the cooling solution. This correlates strongly with an overall power draw
that exceeds the DC power draw capability of the internal battery. This
mode being mapped to performance when extreme mode is detected as
supported, with the actual performance mode being set to
balanced-performance, has led to some misinformation being promulgated
that performance is always a bad setting in Linux for these devices.
There is also some confusion that the mode labeled performance in
userspace, which corresponds to a red LED in Windows, shows as purple
when set using the hardware extreme mode.

I'll also note that as the hard TDP limits are refreshed when on AC or DC
by the ACPI notifier of lenovo-wmi-other method driver, no special handling
of the battery is needed for safety limiting extreme mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

---
v2:
 - Drop patch 3/3, keep extreme mode quirks table
 - Add Legion Go 2 to quirks table
 - Fix nits from Mario
v1:
https://lore.kernel.org/platform-driver-x86/20251026081240.997038-1-derekjohn.clark@gmail.com/

Derek J. Clark (3):
  acpi: platform_profile - Add Extreme profile option
  platform/x86: lenovo-wmi-gamezone Use Extreme vice
    balanced-performance
  platform/x86: wmi-gamezone: Add Legion Go 2 Quirks

 .../ABI/testing/sysfs-class-platform-profile  |  2 ++
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 29 +++++++--------
 drivers/acpi/platform_profile.c               |  1 +
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 35 +++++++++++--------
 include/linux/platform_profile.h              |  1 +
 5 files changed, 38 insertions(+), 30 deletions(-)

-- 
2.51.1


