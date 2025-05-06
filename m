Return-Path: <linux-kernel+bounces-635848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011FAAC2C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 13:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AE27B9763
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D2227B511;
	Tue,  6 May 2025 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btJjgamw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809C27AC52
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531119; cv=none; b=vCtGkrLaKgAdItJLVolU1hat4Od/3Hg8C06Si9pUZsPs29W3sMxRDOBtsGLdMbHnRsR9kROKfAuOwSVa+HWI/fo1yLR5yBYYMFz89gCgW795vIcu9EHkKLZvVseJ60skPm0JKbMDIeQBPLvjNpF4pIx2diiN4c0B+PYLV0BTus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531119; c=relaxed/simple;
	bh=dZOxThEKY/19fDb1atsCAd4vX2SSIiVfbJuNFdfhc6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k3M3StzKz1PrFOKWCfymLz/Stz2qqZXa1lCw0OS0VkRkJz+Is7yRVilds6O+dUjgFrI0dRtdTbPbhLKf1j2/Tg7sr6zjoPfrCbF65LEDVGUjm1MhMX+bL4zRqdqomwtw9fYFns/ArOzCYiR0ry9up2YxBChXz+yVBWnXKSrktDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btJjgamw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so36498225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531115; x=1747135915; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVYMaT82isRrkpK15HHVNBbc3e0novaLvbWmbpyFIOE=;
        b=btJjgamwaPMIkqoGeqCUwJxMbsrXe+ax6aHgMu1gvdxjoxNrTHRXu1FnVN+FJi9ey5
         E8Z2aufoTkRU4xRYBPSuOKve/r+gimZ23CbWOANicn6eSfFSw4xzNxTlDvtil0bVSwIM
         tkhwVOnry/pEjBbZQkfRoNosxJVcIy6tClo9OnVm9rWWOKDOT/zDe2psEs0TRc8N5zFJ
         wUKU/lJ+owD72z/r0DDhK3rTtn7iIQwA9zKrdRcqtQ1EINLJjqYyPSUqnW3fzUwULrsk
         z0s+UsqDSkOojUN2bZvvuV7eVWAIigIiKmodnSmpiXuFCCPNZLENAacoEsI5THfcPytZ
         PZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531115; x=1747135915;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVYMaT82isRrkpK15HHVNBbc3e0novaLvbWmbpyFIOE=;
        b=Y9FhZwrywu0QqDTT3o06urfELmfB/dkuUh+EL+J5uJ05WQ6ALwYIOUxpjFsQ9uuIGX
         eRwX4CNjpUCERi5eh6KYsK0z5tmFBa9cb+GDW2Ex/+vXILTz0TpwggG75EA0rWVGqCTd
         Yh7bKC+ZRvrMGmdYp0Ou5j85964EeD6BHVcQAQFVOj5EKIIHh0im9c0knffMdIdv+QBf
         Luqu/s1C7ilAKq+hOvH4COr/VhnbhN+woJf11yHCegiAg3JyF0AsLcfnF2aETXqGPqDa
         7AqFVQFJU5AiPkq4sUK1esN+AgpYsVmTiMlvGrIa9O0z3IXvyVWyv9uSRFxhqDyFFlPk
         oYrw==
X-Forwarded-Encrypted: i=1; AJvYcCUY1Hvv/BbRCX/soBp8AdKUKfB3TWoqknMS8sJUMCFrKi1031QSknNdgEk4wZEXvGAmLQO9UlUczi0s0r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4RE3KRSYTkqAB5pPTDGDUEs4LvfBxIz2VB7JbRDnPtoo3Pxc
	LDkl6FmRsRwOF/HZjLs9G9c4izpFym6Gjf8k/tYLOxkqXbI0Xy0vcAj56uZmNQnkBsrr9YlJVy5
	pWQtb6g==
X-Gm-Gg: ASbGncsmR56kOmJDPTglTHCxGQgKPjbaSNWAD3M5Fk2ObTH8+5pZiEFvo/fdXA9/le8
	bKnfckrCLoNyaOxAjLgXyRX1vw8JWAe6DsDGfoKRk2qr4nfCoeVZzvKEXEdYaMkUgn6+vN/M8Ei
	cSnE2NeFffznk2eiUNCYadGxhdox8lD4rfop4yUTdYnB1gf1K4ZwH6AKutcafgWVyNDDUWWzTIa
	UOHb60EV1n6uicUcbahZEsYbqvoZqt67PXGDiiBmiyEZYsb6JxzylXZrLqbjwXUgNGj5v+bmxZ9
	q5ZChHbTEJu93SgUMVZFF64k/Lf5rG/qTw2zoj2uV0nZjn228GeJKN2q56g1vqbfxAfxDwtVnr8
	r/3RwOw9yh/sBOpW9EoSE
X-Google-Smtp-Source: AGHT+IFB+/2+pwJwZIBD0b2yLu++CXDbSzQgzqM1gVS70tv5Bksn6acNtQIMSaKWzYmIjz1xXAmFYA==
X-Received: by 2002:a05:600c:8012:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-441c48b05cdmr93122945e9.7.1746531115575;
        Tue, 06 May 2025 04:31:55 -0700 (PDT)
Received: from ta2.c.googlers.com (92.221.190.35.bc.googleusercontent.com. [35.190.221.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecedcsm213723495e9.15.2025.05.06.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:31:54 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 06 May 2025 11:31:50 +0000
Subject: [PATCH] dm: fix copying after src array boundaries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-dm-past-array-boundaries-v1-1-b5b1bb8b2b34@linaro.org>
X-B4-Tracking: v=1; b=H4sIACXzGWgC/x3MMQ6DMAxA0asgz7XkpAoDV0Ed3MYBDwTkFARC3
 L0p4xv+P6GIqRTomhNMNi065wr3aOAzch4ENVaDJx8oUItxwoXLF9mMD3zPa478P6BL4lNgR09
 KUPPFJOl+r/vXdf0A3b3cymoAAAA=
X-Change-ID: 20250506-dm-past-array-boundaries-1fe2f5a1030f
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746531114; l=2250;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=dZOxThEKY/19fDb1atsCAd4vX2SSIiVfbJuNFdfhc6g=;
 b=zmVLAtKGrgYT4MKv8fchYAAkjBVI+UyBexEDHXyQc+1hENewYZaxjQ/O7Yyxoc9/n9JVBYPEH
 CQGMUpu2v34AhJlKIfbHG/UUXKSDuWiMsqKYs7NhYIRppYDE2xyBeFm
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The blammed commit copied to argv the size of the reallocated argv,
instead of the size of the old_argv, thus reading and copying from
past the old_argv allocated memory.

Following BUG_ON was hit:
[    3.038929][    T1] kernel BUG at lib/string_helpers.c:1040!
[    3.039147][    T1] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
...
[    3.056489][    T1] Call trace:
[    3.056591][    T1]  __fortify_panic+0x10/0x18 (P)
[    3.056773][    T1]  dm_split_args+0x20c/0x210
[    3.056942][    T1]  dm_table_add_target+0x13c/0x360
[    3.057132][    T1]  table_load+0x110/0x3ac
[    3.057292][    T1]  dm_ctl_ioctl+0x424/0x56c
[    3.057457][    T1]  __arm64_sys_ioctl+0xa8/0xec
[    3.057634][    T1]  invoke_syscall+0x58/0x10c
[    3.057804][    T1]  el0_svc_common+0xa8/0xdc
[    3.057970][    T1]  do_el0_svc+0x1c/0x28
[    3.058123][    T1]  el0_svc+0x50/0xac
[    3.058266][    T1]  el0t_64_sync_handler+0x60/0xc4
[    3.058452][    T1]  el0t_64_sync+0x1b0/0x1b4
[    3.058620][    T1] Code: f800865e a9bf7bfd 910003fd 941f48aa (d4210000)
[    3.058897][    T1] ---[ end trace 0000000000000000 ]---
[    3.059083][    T1] Kernel panic - not syncing: Oops - BUG: Fatal exception

Fix it by copying the size of src, and not the size of dst, as it was.

Fixes: 5a2a6c428190 ("dm: always update the array size in realloc_argv on success")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 9e175c5e0634b49b990436898f63c2b1e696febb..6dae73ee49dbb36d89341ff09556876d0973c4ff 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -524,9 +524,9 @@ static char **realloc_argv(unsigned int *size, char **old_argv)
 	}
 	argv = kmalloc_array(new_size, sizeof(*argv), gfp);
 	if (argv) {
-		*size = new_size;
 		if (old_argv)
 			memcpy(argv, old_argv, *size * sizeof(*argv));
+		*size = new_size;
 	}
 
 	kfree(old_argv);

---
base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
change-id: 20250506-dm-past-array-boundaries-1fe2f5a1030f

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


