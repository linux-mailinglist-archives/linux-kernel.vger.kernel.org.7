Return-Path: <linux-kernel+bounces-843862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D2BC0710
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A3BF4F5C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB08260580;
	Tue,  7 Oct 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqCUjLDl"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA72288EE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820049; cv=none; b=lRPaPIN0seeHPkevq4sr6xEhGvoKFQsimgnfKURYvlqBq3qZdhWCKYrTMlX+oy2Rd4nYL/n8ca5DT9AzPxG8RdpqGhAFrGwHfOdepO9wiMHqG/hXZlmV7nJa0u5H9T4PEh8y+BEXbDqFboDhqXJSrGb04Yi8LntuviZU1NV0ZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820049; c=relaxed/simple;
	bh=TTG+AhssdA42D9C9zLf9qT/1ySGtIas7NJQm9lzkZ40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iV2tE9XhM6VduZ1nZLv5mJkrU484k320PRZKcOQPDqAL+LUBb73vYVjMZ2oqMcajvzIOPX1TktJG+CoBSvgi40qHqYq/wL342WUI5DzS6OZE8xV2XXGNQeiSV5GlW0CojtapxQ1eRFecAWreidn5ZCKKbJCFqbYWMRZ1KH7gvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqCUjLDl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so2075548a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759820047; x=1760424847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mswOKIOKbhdl+VgGK7vEvPqN70bAqxJl6ivwxQMTkZ8=;
        b=NqCUjLDllV5XRJE+MjO8bvZK9sNtfVTfLAQ5xZDQ9Kvao4oAV70x9S6ZDTVWftZnLu
         5a7+GEDMK74bs72int1LBpySpsXJklJd8HOewOD5lUh5y1oyEAuxSHhYa3oNLfd+tyaL
         iH2PfRe1PEJ5gk5Mm5wpWeNBPIE4PNO4RfR4J7KJvr7ZC+zHaRtsfL/0P9T7hpEcEh+Z
         rjW8jqYtQRvc4nozAlk6hAkV+P8rO51tNBNHQ613cgVP+INA94tMYJ+ynLa0pJf9HrEM
         MtX/Dpqgq/BzVMtImqEts+feo3+CZ202JzN7ZbQQwS9iUIt/5wilG/+5BuK8t3sKvs+i
         fhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759820047; x=1760424847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mswOKIOKbhdl+VgGK7vEvPqN70bAqxJl6ivwxQMTkZ8=;
        b=hafRWiZBat7Gfh3oB0dwj5+2tThgiOE9LUSQgK0+AGgjw4vQVtv+UW5CNLLKbHo1Nk
         EQ0AgpCwwEh9uaOiko3bcRESnqdI4k0Ty0FBNeSL1leZhvXiTTT70kzTL5h0mXCbkVkk
         QeL78Sx6IWYAfWK62CCFDkTjI/iVkZ/kPw/zPZRuEePNii+ZMcsu6iXdhTUxF4zLpbRl
         mBzaQ8a4k3abIdqoWSQkMONTc+cK3vWGFH7QOCbgiCRQz914B95aYzHs2KgADI5sk7xo
         Qh9QrqrUY0R1YDwbDSrI7EOd9E+cC0k/ssGiwha0Bm6yC18SgwXpNF8mWh4KP0rejdZx
         QPxg==
X-Forwarded-Encrypted: i=1; AJvYcCUuXtiNPKcP650FC8mfWbHuzK4+FoAd/NoXdpi1YK02Z5ga7o+qJAzx98yUjbzX02sDcyxCoNFfuCfoX+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkmU4lgWo3JMOZNL+2AMFWuxPUPpe/rMmTyg+MQRG5EIEVNIu
	rfexTj9CPtRLVZO9+dNVXTl85qprBvDK2Xx/VdP1QJT41H2Ww9TFtFfa
X-Gm-Gg: ASbGncu6cz0Jf4lYBMGRKZZwFKLUw03EFW/qDbxJyrHDzWu3jTfpeyLOx4DcEwiPy1y
	dpz/iU/cImROEhz3mXUy9DFLY3vgWa9KI0Q7cCVYb7bJ+HZ6uOclzd9Dyblv4YdizRGezFzkb9Z
	Nv0icTt6B7rJ71eYf6RGLU16q8tYWyU3Joj9tylG4nJiEjko86yt+1bviug65FsDY1fgXCCONiU
	Ak7Ei2RdISubtcDN7izlKQRWxzjbhzskPO15cbmEqkksx6OsGlvlAFNyGEni39o5y9KXFTt7h0l
	NYExW8I6kahJrpVj9XaE9+hdE1O1yVvJKx8IiWCpDLNgOR2RBRReewAC6BIAC+3Hbr0bNYCPaDk
	KpjNmrTUQ5iSKtFS8FVe1c+2hC7KZZgd3MKWod21R1aM15TYSpDiWd0H6msqyBZbBM1KuKnk=
X-Google-Smtp-Source: AGHT+IFOWxg9dlREBFVestaXMYXB//r1bQveRFkHWcW/v8RP8fcHviNaQLC2YO5f6bIdAK7/nqQmyw==
X-Received: by 2002:a17:90b:4d0b:b0:32e:43ae:e7e9 with SMTP id 98e67ed59e1d1-339c27a50ffmr20351680a91.17.1759820046589;
        Mon, 06 Oct 2025 23:54:06 -0700 (PDT)
Received: from ti-am64x-sdk.. ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee05db08sm824666a91.2.2025.10.06.23.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 23:54:06 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Don Brace <don.brace@microchip.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com,
	cassel@kernel.org
Subject: [PATCH v2] scsi: Prefer kmalloc_array over kmalloc involving dynamic size calculations
Date: Tue,  7 Oct 2025 12:23:45 +0530
Message-Id: <20251007065345.8853-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a best practice use kmalloc_array to safely calculate dynamic object
sizes without overflow.

Acked-by: Don Brace <don.brace@microchip.com>
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: The patch is tested for compilation.
 Change log:
 v1->v2:
  Updated commit message to refelect correct intention of the patch to 
  address James Bottomley review in v1.
  v1 Link : https://lore.kernel.org/all/20251001113935.52596-1-bhanuseshukumar@gmail.com/
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 03c97e60d36f..19b0075eb256 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -8936,7 +8936,7 @@ static int pqi_host_alloc_mem(struct pqi_ctrl_info *ctrl_info,
 	if (sg_count == 0 || sg_count > PQI_HOST_MAX_SG_DESCRIPTORS)
 		goto out;
 
-	host_memory_descriptor->host_chunk_virt_address = kmalloc(sg_count * sizeof(void *), GFP_KERNEL);
+	host_memory_descriptor->host_chunk_virt_address = kmalloc_array(sg_count, sizeof(void *), GFP_KERNEL);
 	if (!host_memory_descriptor->host_chunk_virt_address)
 		goto out;
 
-- 
2.34.1


