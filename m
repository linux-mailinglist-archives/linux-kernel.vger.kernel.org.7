Return-Path: <linux-kernel+bounces-745133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA823B11575
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A306A7B35B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809317A2EB;
	Fri, 25 Jul 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+66ThVd"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50DBA3D;
	Fri, 25 Jul 2025 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404957; cv=none; b=EHbHF8dazwT+wihZo0nhD3d/dCtylBdMFRk5sVY8vtby5+JcJVur9ka7LcyY8ur/Bac3n5ACVZNcUueCS3ahTkvvt6HnZ6VVe5kLXXZtxWFQiWh4OeVFz3Kvhil1TfM/IeLIcCfm6q8Anr48tEn73Zx2VPg1b4QfXoyekbacjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404957; c=relaxed/simple;
	bh=4XKAPmBz5foqruO2Dh8PkM1dkEV+GUMjPtrD/uVwcN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZTtTGhs3Yg9nF0WhXQi9rg20rHOL7jKEmlp/P226AuAR5D1Zny8M0gox9EgicgtMrYCl1W/jSSevYSMuzvKHU+QRaAUgAY6u5JulgN8pAeGPh7lU8oOjj33j0BM5/kD8qfo67lVEpBSTbJ2NmRg+r0KgHoGwGQ8KVYbaqXB2bSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+66ThVd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75ce8f8a3a1so1059797b3a.3;
        Thu, 24 Jul 2025 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753404955; x=1754009755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05L76JUv0m8cSj0GnLUPHaR0uDq+xtojF9hghogAtK8=;
        b=V+66ThVdD3VEBW4lKcSrlvgUSpdNOf2aJSDbhqBCeuagrK8w3P4hlUTOpfm3Pn1x9+
         /dNFJkz4PaQUO8v2I1clJHNQ8ldS779r5zqWovWuruBoYoG75j+8k5BxiMSPIYxBDB3E
         NiLLf55T/CSa1XAOhfpVTovQLEB5e06I3ycQZ0xlYZpP09ImaQYkQ1WJHXFArNfXrVhO
         Xeu/PFo1G/ubCYjrfJ2TzyCTPxekvJve5qEg8ekaN4vFzDrCdEV0Ev2Ouzn1giAzfYAA
         JsDVIfcsfioQM6KEkSVnSrrGnqk6kljZP/jDbJWzeZUXfRKhnkMyH/kyP12zboZih1pz
         wR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753404955; x=1754009755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05L76JUv0m8cSj0GnLUPHaR0uDq+xtojF9hghogAtK8=;
        b=buMAMfUTJ6NHCxqNWGkoPFVT9IygtB0IJbZtNU8ytd0KwbMwiZssJLbc0/ZXiupCvV
         lNOdoNE1kVjenr/QPHUFi7PNC22fYcI+w4cI31gpv/tyKn+lJszfzZOVFqNW+97KNyko
         rzgEGbcPSQ7d1xLCJPrJKaww7pB/sQnzS6GYnJiBMtFbA4KX59D65Bu7c32sVHIL/ukH
         hsBUX4xJhnaRlTmnBt331n7SmPF14LTyJMo0sMO8S+n1uFFOrkJbOgwPIkA3zkXWPH4y
         +Ds/2zBrwySaP42aHgmJSQCDJcirmFoLFV1bgwVYl4FFP7olK9jtas3ROF51q0+Opncz
         M+iw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4vr7a06lzfUmARMudVgu1ZDVmz0mm1vrTxv9c/fmRSkLwtj6tGN6OEOcGK4atcDvsdB9jcOIrL7asvs+@vger.kernel.org, AJvYcCVJPPY3TcdxjSMH4laNbNkjkqMaevoeWvNuv3qSQ/pooLm5faUcdIU4vaGmxhny0+4JMNPpBMJdcQFO6n2vhERktHHJug==@vger.kernel.org, AJvYcCVfaEM0/HaHl/6Am4RZ8YXK0A8j4eBONBiagNJ88B0jh4dtT2TOnV/5Z1eYv6srrGYkhazNp2uHrqfn7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIPWb8OGq1PPVgx+RxDVkqssGLtkrXkuh2H5xcNtfGZESnYf4
	oFCKOdf7gyuh3/CagOgTpJgOSFQYKvwB/zg2NRlr7wLS9s+uW0lL1LbS
X-Gm-Gg: ASbGncsQ2aiZDZ0wq0yPQKVSJ6MsRms5b+qraD6/CCS4NMYdDgtV/eKF7L7vRycpL+L
	EMAnBbStO2f2291AsFUMnk0F7XWtS/H+YXSxETwlo/wOBncradN6WBS0kpoVO4nDZ9Xh5HulSEd
	+2AWmIn3T4rbunZMQihFRDvLFqk7btNMKYzpPu38601J7MX/oOQg9En4SeAgPvhmI4UX4Bmj5zc
	ZhFSHBtBDP8d0B/LG5GjhYMQBN6gLsLPf8ZuVJ9T3GMQIC/u2XpZoOL9R6y7+v+R7SBMbZccwKC
	nCO09kTTte+/QlZ5CUC9T+2qlzRhOvp8Gx+4yHh9uJuciyeVDD/sree1eVSpii+6zZEJZ8Eq2zf
	wf4KmGUqqmc6HVMY3nh8Ck1AZQrG7YHR9D5OiJ5xg2E2yes02Y6wWe4zYUQwwno19f81kEDHrBI
	mQFA==
X-Google-Smtp-Source: AGHT+IHefCJLhghOF3i/bSPjuFKzeNgPYQQcyIIZeKOqjv5d28FkNFbsjHITfXX8bgJ9RD+Fo7gl3w==
X-Received: by 2002:a05:6a00:8c6:b0:75f:b4aa:3774 with SMTP id d2e1a72fcca58-76338f86c2emr136684b3a.21.1753404955279;
        Thu, 24 Jul 2025 17:55:55 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b0626831sm2598423b3a.125.2025.07.24.17.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 17:55:54 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 0/4] Add Ayn EC Platform Driver
Date: Thu, 24 Jul 2025 17:55:50 -0700
Message-ID: <20250725005550.65152-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds platform driver for Ayn Loki and Tactoy Zeenix handheld devices.
Tactoy devices are rebranded Ayn devices with minor modifications to the
DMI. The device EC had multiple features implemented by this driver,
including a PWN fan with manual and EC controlled automatic modes as
well as a user deviced fan curve mode, temperature sensors, and chassis
RGB control.

This driver implements PWN fan and temperature control via a hwmon
interface, and an RGB chassis interface via a multicolor LED class
device. I attempted to break the driver up into four logical patches.
Patch 1 adds PWM fan control via a hwmon interface. Patch 2 expands the
hwmon interface by adding the temperature sensors. Patch 3 adds the
chassis RGB interface through the leds subsystem. Patch for adds ABI
documentation for the sysfs entries that aren't provided by the standard
interfaces, but are needed to fully control the device.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
Derek J. Clark (4):
  platform/x86: (ayn-ec) Add PWM Fan HWMON Interface
  platform/x86: (ayn-ec) Add Temperature Sensors
  platform/x86: (ayn-ec) Add RGB Interface
  platform/x86: (ayn-ec) Add Ayn EC Platform Documentation

 .../ABI/testing/sysfs-platform-ayn-ec         |  59 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  14 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/ayn-ec.c                 | 967 ++++++++++++++++++
 5 files changed, 1050 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayn-ec
 create mode 100644 drivers/platform/x86/ayn-ec.c

-- 
2.50.0


