Return-Path: <linux-kernel+bounces-896580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5EC50B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16C4C34BF12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C232DF149;
	Wed, 12 Nov 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRSsne6X"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75972202F9C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929053; cv=none; b=Lsf586nnoYOgcjGmwAwIFcnu/7TOJ3uMXmjJcYpUzUDZrYI0TF/gEQ/+rL5V3C0e6nYKlLM/MinUCvR7eYs5iyl1gXgAfRcYSNqRJdZVkOVo4XvY5YtstcDoWc3dxN3rxH2hzahwP5dwvZrrTH/ZczC1h+nyYbzl14q3/SiuGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929053; c=relaxed/simple;
	bh=vkvNjPVybqGFg3v5E14aYKJtRBrpQakMnNvHoaFRIzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJPyB23/1ciOCuEm9B3G/m6dQvDJQ42Dh5JA4UTPbYbXW5OpWHOgeN5MdGOgtLA9/GLN17AisANdwVx/YqoiQYSQiQFDFUHWZdsfrYxM7TGaIXcAx1nVrfEwNRyAaTuubqqXR+aaXX508d/X9l0rWKylC2QaNr/PCpTvC6nSQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRSsne6X; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda6a8cc12so5946301cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762929050; x=1763533850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUVNERqw16/pQTgRG4/ce0IUftN0SrBAkIDEVmIs5X4=;
        b=dRSsne6XByopETAyeiMqjAwRhDhm/Kb8dAV19GC0c3UEAGvHcU5EPKpOJdG4qS+gE1
         e6CfQDi+whp5mPVxbmjtBQu1IqaObQsHgI0jNI3utL4m6LlPuMzMXpCSdDD+t3KLMbsb
         xKPQtfswczDpadLlDdvzpEvRgesKo5jIZeCU8WfuTYhCeCrL8BZxZYfUUWR7kqbqEQDO
         9ExFe+z72zsBREAjjz4rF+sxGx1MnkhOyDsysmkPicFXCyfv7gzpibwJ00uEcJ9aPHqR
         ibh3ExDsFiTzUqjDE8lx8NyfW+mDp6ULEUwwbF1V2ItiUi1+CyQWgo8z+d2l1H4In4cm
         +Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762929050; x=1763533850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUVNERqw16/pQTgRG4/ce0IUftN0SrBAkIDEVmIs5X4=;
        b=RrT4aZ1Apw6De6bOIedtAv+FlBexVmgaYk/ikeYvs2Z5jYSZp5Y8qkc2sliZIhQC/1
         sgIwBniUC1sAgyVSF/CRoN1FXcaIg7neSbH5eHPsHO/qQdgkM1CkEgdHq10BSpo17jOl
         ELrvCF0NAa16f+gd0vubvYrD3uHXx7Sb8nK7rj07LarElLhBx5A8kUw/nwNPOLEK4+fC
         XnzZdp1b+Fw2FMrXJwinIFkFDpBWCIy1sa94Vk097GSNsLnoHRuUOFt2uQtvRrFiDEwK
         lylnvxurhQYNwPB837uafcaSx2rgzNlS0m6bdW723Cnw48nqmj81AegURdJ8Fa1w3I8y
         Do9Q==
X-Gm-Message-State: AOJu0YwM4HX8sl+Den+a7U+QXamh8hGof4YxodFun0/Otzw8UBAEHrgt
	TD+qbaO+P4vEHXK/geVcvmSb8ux8kPN1weEBbf4WLSmrbNgD0KzHiMKDFTxc1g==
X-Gm-Gg: ASbGnctdNiNBLWjpZJaDtxKq3wGakvoatPNs3IOaoPql79cCJJ3rweogDbetaHagVpu
	rxanuOXo83sBKE8wWmRzgU+hMrKrK2VSWGGRcG72uQqyEQOZv6NX9Lgr74kju3lwzFA/7uB770x
	F88tXOiQAgS3I7K3WyWn277BGL/JyZlkRKlObKaXWbwGDy41DMsLisNCmnQWCUtYbT9PU+VOauF
	d3Hgyy1XfKF/abEzw5bmIqSKu1n4//jrXH+7QSXwf9riD6lflQYfrxtMqVZyuYpDuXNAXxHapGS
	NRkp73lvYWzSXf6erFvzlthU7k3onJ00F6VfvaHnHLxpTE/Idstej0n5ym29Dxj9KWdWfk6ltyS
	F7Ark0MKPLnBh+SHFHLjH9kcWTCLJwaO1Msdn2rpIISQyaTs=
X-Google-Smtp-Source: AGHT+IEskytN4hzXK8t/WgLF3N84e9VKxJR1eMNrKG0LRSB0iStZm2wWbZoOK80SbhCj9cPzG+h+GA==
X-Received: by 2002:ac8:5914:0:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4eddbdabaf5mr25483851cf.52.1762929050130;
        Tue, 11 Nov 2025 22:30:50 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882638344cesm24932036d6.42.2025.11.11.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:30:49 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCHv2 1/2] firmware: stratix10-rsu: fix 32-bit compilation
Date: Tue, 11 Nov 2025 22:30:32 -0800
Message-ID: <20251112063033.176276-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251112063033.176276-1-rosenp@gmail.com>
References: <20251112063033.176276-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code uses long which is changes depending on CONFIG settings.
However, these longs should really be 64-bit. Fixes at least the
following errors:

drivers/firmware/stratix10-rsu.c: In function ‘rsu_get_spt_callback’:
drivers/firmware/stratix10-rsu.c:285:28: error: left shift count >=
width of type [-Werror=shift-count-overflow]
  285 |         priv->spt0_address <<= 32;
      |                            ^~~
drivers/firmware/stratix10-rsu.c:289:28: error: left shift count >=
width of type [-Werror=shift-count-overflow]
  289 |         priv->spt1_address <<= 32;
      |                            ^~~
In file included from <command-line>:
drivers/firmware/stratix10-rsu.c: In function ‘rsu_status_callback’:
././include/linux/compiler_types.h:597:45: error: call to
‘__compiletime_assert_377’ declared with attribute error: FIELD_GET:
type of reg too small for mask
  597 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:578:25: note: in definition of
macro ‘__compiletime_assert’
  578 |                         prefix ## suffix();
         \
      |                         ^~~~~~
././include/linux/compiler_types.h:597:9: note: in expansion of macro
‘_compiletime_assert’
  597 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro
‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:72:17: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask,
_mask) >     \
      |                 ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:155:17: note: in expansion of macro
‘__BF_FIELD_CHECK’
  155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET:
");       \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/stratix10-rsu.c:122:40: note: in expansion of macro ‘FIELD_GET’
  122 |                 priv->status.version = FIELD_GET(RSU_VERSION_MASK,
      |                                        ^~~~~~~~~

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/firmware/stratix10-rsu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 1ea39a0a76c7..2b8ad04679f7 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -97,8 +97,8 @@ struct stratix10_rsu_priv {
 	unsigned int retry_counter;
 	unsigned int max_retry;
 
-	unsigned long spt0_address;
-	unsigned long spt1_address;
+	u64	     spt0_address;
+	u64	     spt1_address;
 
 	unsigned int *get_spt_response_buf;
 };
@@ -120,14 +120,14 @@ static void rsu_status_callback(struct stratix10_svc_client *client,
 
 	if (data->status == BIT(SVC_STATUS_OK)) {
 		priv->status.version = FIELD_GET(RSU_VERSION_MASK,
-						 res->a2);
+						 (u64) res->a2);
 		priv->status.state = FIELD_GET(RSU_STATE_MASK, res->a2);
 		priv->status.fail_image = res->a1;
 		priv->status.current_image = res->a0;
 		priv->status.error_location =
 			FIELD_GET(RSU_ERROR_LOCATION_MASK, res->a3);
 		priv->status.error_details =
-			FIELD_GET(RSU_ERROR_DETAIL_MASK, res->a3);
+			FIELD_GET(RSU_ERROR_DETAIL_MASK, (u64) res->a3);
 	} else {
 		dev_err(client->dev, "COMMAND_RSU_STATUS returned 0x%lX\n",
 			res->a0);
@@ -632,7 +632,7 @@ static ssize_t spt0_address_show(struct device *dev,
 	if (priv->spt0_address == INVALID_SPT_ADDRESS)
 		return -EIO;
 
-	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt0_address);
+	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n", priv->spt0_address);
 }
 
 static ssize_t spt1_address_show(struct device *dev,
@@ -646,7 +646,7 @@ static ssize_t spt1_address_show(struct device *dev,
 	if (priv->spt1_address == INVALID_SPT_ADDRESS)
 		return -EIO;
 
-	return scnprintf(buf, PAGE_SIZE, "0x%08lx\n", priv->spt1_address);
+	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n", priv->spt1_address);
 }
 
 static DEVICE_ATTR_RO(current_image);
-- 
2.51.2


