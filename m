Return-Path: <linux-kernel+bounces-724821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8DAFF746
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50587481B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5028150A;
	Thu, 10 Jul 2025 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAMM2yVo"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AB28136B;
	Thu, 10 Jul 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116627; cv=none; b=H8eOtH8kfqBdftFfqv9Oo96LVQhCmPA+rS36GOHv6nh462XAfRoQWNwwolRyganDutHHVAJumGebYjFwYuGyCXC1xAugV7dhUTabML/MmgpSe+EnaK/XRYI+gLEe4WUCaCz+48FN0gKasYVhwUPpdHfZnSISkaflbmZ5f8jD0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116627; c=relaxed/simple;
	bh=ky5/iLMIz44SuQ98wPexb2rrGVu1VL5cyqj6SKuU82A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlgIu8ZrJC4PAXOfJQMythF7Vj1vE09797oZAa9nPMhZiNJFp8gJulbpSaNUB4l+s7CC1NlAxbJ+KCdOqWNRMXFjnAMi1ey7dzJTuQinPA4GUg3eFFd5CmB+NUdCtaDHaXk9XUQ9cRBHnAt01JaGNcmWd2cMUq9atPsFG+mKPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAMM2yVo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2350fc2591dso6214995ad.1;
        Wed, 09 Jul 2025 20:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116625; x=1752721425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGodoOG+bYW+2GIlo1wVzxCJFs0nwimu7A6Wb3+W2mM=;
        b=EAMM2yVoripxU3SwORJBQrxG6XGcwJGu2pQV0NrYnECk6R5/4I2SCfHb8JUMP6u7Zc
         UQglbXYFZuZwNkbhHPhQovKqaDUXzIeeBFaYJ3VDw3Fb83ZxAtEFWyCZhYAICdjROCd8
         QntnjgWX/q2WpOG3mp3NGkfvpo/QqMiTuEsaMU7lShrYHFwvZAcRAsGsGAaav6doVeDi
         5q8Tq+VCI624MhwcWUtWgm7EyA3NbQpStncEQJm6r1wEH/nThE6vfEBrqwQVwJNfy0Iz
         YdCLgagCQPzytoRSBriMPzNW6UdbVHlKhMwdT4ALOJ94RynIH0tNZ4LIIo7mAM6c6xfW
         YQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116625; x=1752721425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGodoOG+bYW+2GIlo1wVzxCJFs0nwimu7A6Wb3+W2mM=;
        b=VJNpoA1876RNQ5kGhQcnVtaDwpxChKoOcpiCBGDpgmhQ80OiGLq/N693WTye0rjqcG
         TmFRqWgQn4pcaKbGRHnEaRXDyySCrDcSUpGU8evY8BiKYYBXdlLBEsU20tl0wpUkKjMR
         qvOLOen3mEbZXTPRj8Fn+ozxfxxDjtN9BeTnDEzgZHbX+F8XKkCv9jJELIi1Sqiyisw7
         O1+lpl28y24FFdiUCAcdJZ14mogj0YNWFtSqNVTbLs584LQ0cfbJdqUfLrUJrEGPs95l
         0VM3yRnbVS3Dg7X+nzII+YWs9PwaNU9lifv8qahxnouBhoNC60bNIiUvfgB4fKr9PJai
         6nfg==
X-Forwarded-Encrypted: i=1; AJvYcCXSHKMJlPNhWWt9cf/h6tsc3TkKwIeX6FLE6g+WUOStBWFJsMaIcoDAeq6dCMEUSCFnzvnJhm6DOj35nuk=@vger.kernel.org, AJvYcCXqVRp6rU3jImbcZGd6H8sFew7tW5QqPUdqMXzT7yovUZnIxU3/7pJ/btVYQVR1K3LOdOiL31XDryllnOinm1Z2E2ZeTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDWVRHbFsun2SRWoiqD6vv+gtR46plR+K+j1kbCJ0Rm8miM03
	bhBqCWUVoClrWwmw55f/WQZFkXs9VQxTmW5nYnCfp3Gi2qTOZhkyHe6t2mV2nACG
X-Gm-Gg: ASbGnct329Rgeqtig7JOOqLsYdSfHdxQDVBpGHI03oV1IJ/WDjUdr3rYQkDJ5pIeITg
	1CL1xCjxkEYZeZQjNnvFhOX41tO1D/qnjwr38Xbw7sh0x2vrvDAFf83xZvWO7vkWsuOi/bFb13/
	HmdZ+D95xdg1dIRZwRM7Ve5DH6D1tDKSZJnDqQPVWe1URGPjBL9YkcDsPplHEY5q0IeEeLTQYaB
	ALfbBo8XDaYWSApWNa71RDoon129JLwvc65hNRI5YAdpE2FvWgtxw/G61WNClo3WA6q/FAfKNIm
	GPvJU81U3TTM168hladHnZkyWt7I6dd7DKfH34M6qSYGcwnM7899RoH1XbSBnA==
X-Google-Smtp-Source: AGHT+IHuBcT0Gnfe/LXMeNdi6vm8Rp/f4BshHGaipdYX4SKVqcCTkcUAYpTfeQGD7AbysiYB72RvdA==
X-Received: by 2002:a17:902:db0a:b0:234:11e2:f41 with SMTP id d9443c01a7336-23de2f45e12mr27161335ad.6.1752116625438;
        Wed, 09 Jul 2025 20:03:45 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm6210445ad.224.2025.07.09.20.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:03:45 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 10 Jul 2025 00:03:18 -0300
Subject: [PATCH v6 3/6] platform/x86: firmware_attributes_class: Move
 header to include directory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-fw-attrs-api-v6-3-9959ef759771@gmail.com>
References: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
In-Reply-To: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3771; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ky5/iLMIz44SuQ98wPexb2rrGVu1VL5cyqj6SKuU82A=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn5uo0Tcq/K3UyWfc9qleonEFHa/vzqtH9GgVFpv/oXb
 fdy0jjYUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABMxeM7wT69T9tf0De7eSapG
 PFMufzG/VJBr+mqvcx9nRvKDQtnTNxn+2f7WYlO0CH+2RPTr6t/+VcvYe7IfX+CbL7Jq42G3GZa
 ZfAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Move firmware_attributes_class.h to include/linux/ to avoid hardcoding
paths inside drivers/platform/x86/.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c                  | 2 +-
 drivers/platform/x86/firmware_attributes_class.c                    | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                        | 2 +-
 drivers/platform/x86/lenovo/think-lmi.c                             | 2 +-
 drivers/platform/x86/samsung-galaxybook.c                           | 2 +-
 {drivers/platform/x86 => include/linux}/firmware_attributes_class.h | 0
 6 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index f5402b714657297e0ab4bb52a988fcc4c787a5fb..a93189f48dbb79aff39b4b1c254c637dc8e8ef35 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -12,8 +12,8 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/wmi.h>
+#include <linux/firmware_attributes_class.h>
 #include "dell-wmi-sysman.h"
-#include "../../firmware_attributes_class.h"
 
 #define MAX_TYPES  4
 #include <linux/nls.h>
diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/platform/x86/firmware_attributes_class.c
index 40469586cbb4f011e3f03f6ccb8dea643f319ab3..4652637de9bc279ef2030503efb18223fe64a657 100644
--- a/drivers/platform/x86/firmware_attributes_class.c
+++ b/drivers/platform/x86/firmware_attributes_class.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/string_choices.h>
-#include "firmware_attributes_class.h"
+#include <linux/firmware_attributes_class.h>
 
 #define to_fwat_bool_data(_c) \
 	container_of_const(_c, struct fwat_bool_data, group)
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 5bfa7159f5bcd57385a20fe9ac646597b320a378..c002f72b6ac083db8106e9bd044e8a8fc1d3f310 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/wmi.h>
 #include "bioscfg.h"
-#include "../../firmware_attributes_class.h"
+#include <linux/firmware_attributes_class.h>
 #include <linux/nls.h>
 #include <linux/errno.h>
 
diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 0992b41b6221da77db2186f0ec8cda6c10a4f689..ecda54c26a6f01b77e061346ff8d99ba657e4b56 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -20,7 +20,7 @@
 #include <linux/types.h>
 #include <linux/dmi.h>
 #include <linux/wmi.h>
-#include "../firmware_attributes_class.h"
+#include <linux/firmware_attributes_class.h>
 #include "think-lmi.h"
 
 static bool debug_support;
diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
index 3c13e13d488584300c9765132861be5c2aeca269..28046bb941c4b4947e10931690a290d80e909922 100644
--- a/drivers/platform/x86/samsung-galaxybook.c
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -28,7 +28,7 @@
 #include <linux/uuid.h>
 #include <linux/workqueue.h>
 #include <acpi/battery.h>
-#include "firmware_attributes_class.h"
+#include <linux/firmware_attributes_class.h>
 
 #define DRIVER_NAME "samsung-galaxybook"
 
diff --git a/drivers/platform/x86/firmware_attributes_class.h b/include/linux/firmware_attributes_class.h
similarity index 100%
rename from drivers/platform/x86/firmware_attributes_class.h
rename to include/linux/firmware_attributes_class.h

-- 
2.50.0


