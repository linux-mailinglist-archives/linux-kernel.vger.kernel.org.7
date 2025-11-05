Return-Path: <linux-kernel+bounces-886613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30528C36130
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B991E189FCBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5F323414;
	Wed,  5 Nov 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGOwQrcM"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED42E7F2D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353233; cv=none; b=Bp9rw66V+RsMqB+kvHcNWPPDvGTtqFuOJSIQ6YZGSrUPGOjf8ix7hmbiBjaAOz+fjvNPD7jWLt2GTnyRsA9yuh2/U5KN7QYkCvqj7y9jPUAl9WjDP6zc81H+8yuYQ4r/y+389D/znA6bf/SMQSR5qq70IhOV6Gg6Z+mJ5WFj7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353233; c=relaxed/simple;
	bh=vg/RXprrlsVjtXM2tQTWZW5NZf2Zc1PI2BcwO3b4knc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D3k1jwk+Va5GKQ3ARarBi9VvWJ+HtRtRiVlLQYdCvqTnLQptq1176N7y5HgRWoEnyVczae2dnDosDNfd+f6tWRwbQVwQCbJEJQziblbJenylNt0Qtxg3otEjz1PihAW+Iokpv+x5BY24lhdVA0w9tJq3310pcUWXR48PTxaILOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGOwQrcM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-341b2e98486so622739a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353231; x=1762958031; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpdMK/DRKVWAvOOWNiPRhZVNRMFfL3v2YgNMmVkwG6w=;
        b=gGOwQrcMlodBbKVVOiUBinmksNozEiX0dcbzLhJ6uSG87tTZnIMj4BnmEKMB7UBEdU
         VSTLj/BqJKuK34oeXzfw27+HAjeNlQXcpPxNHzru6AquGh1m+U+WWvtV0AbQhkiEMdZj
         4grP+Z/LdiRwUEESDOyYmmKNHLZMYBr08Zip3Qa0XNyiT7JNXtxJ+33ISpoI2AOiGtNd
         I7VYkj/iichxosgAvkOXMdENvSg3ggSHO9tMcBBoYDr0tLRU1D4OnkT/CpI4MOkzIjOS
         MRv9Rl5ni2iab9xQcAX+Afxs7zuDhCkZ7TO/xPYLLwKjyOsF3ccFysduXX98+YYATUxq
         wExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353231; x=1762958031;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpdMK/DRKVWAvOOWNiPRhZVNRMFfL3v2YgNMmVkwG6w=;
        b=fgfV5onscT+OsfXKNz8gozfev8V4rFVdHua/ByJaPz08lmDuNrItlfWEFdoY6NS5wi
         zU39ZFYUP9IBjk4111u37o2AL67xs2d3JBttdtV+AiBzlUkwUNUeheFTYIGsLP08Gcub
         oDMfr+/sXA3bGpNSgGcRWDdOJN/c2Bpx9GPhW581UCrTu98VTNPdimCn99q8v0dsbvYZ
         a232tI2jsy2RQU8oLTzCv1b/JCZOzyEZvQ14S2VRT9CEyiDDhjxcWhBy9eNiLA8jMJ9J
         Tb5iIr2GQKizBBMrKfrRdMIQABzq1KkflHtsC6l2VHuindvkbXlCF438bsqKjOWrKgWV
         5JCg==
X-Forwarded-Encrypted: i=1; AJvYcCUfNFgFRqoSHswV4KXRIwwRcHR5+OXMayH8hYGFeWPNA+rn0p/yGd7gp5Y2xhGvk9ktdwxfNlq6HcPCL5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ao4CDkXezUnIvBjB7vViMnYeeQF85YNb/Dw+gWXYmScAc6zk
	vvx8Fs679MeFzAJoB8mFEPl72W1t3mov8J0kGdF7AV2IWgtu4jpFjnJX
X-Gm-Gg: ASbGncvFiwozm0skV1Woa9sQjSsPqhyeyxGo+sR9fTxkFi1OZHU/ip6dMYGdecOd/17
	grYbF1mY5m0yk7yZ71ba86EnbG+bHgbSS0hZcpxKBoMx6UQ/4Gf2lGjYEz4TjgPyef6AE4/nLpT
	dDSkxmCQf82ywyUYAukNoZW9PTAtTowFkbLJs/TqHDZ1oO4qGCCkXX9BSmvu9uKOLogHCSi+Nnd
	/DUf3+/zCH4ehmsPacSWGuKofS3tHpE8EB21qDBYwvGFZuonIubY32IEljsm46EFUdL0F6uPd7A
	zwa5269SJ8XmT0Sx0GWyRs9sRNAYGGNlczJ0cl6OQq9CbHnbnNH3wWy8+POK91Yd7r5h91WJ3y/
	5V1HiqNHw+OLeWylMDHhuym8MvSjFdWmtQZulnVF4FpLGEYFaUKgiXjr2QpCihv7J0SMpMG/skw
	Q=
X-Google-Smtp-Source: AGHT+IFhgXKJ4vhkJNxXbe74Kq1mJjWs4yqe0dw+xDqXwgk8gyjw+XNt0LDe6GfLNBlv2sqKPJa/Lg==
X-Received: by 2002:a17:90b:55c3:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-341a6c4d3b5mr4552306a91.11.1762353231054;
        Wed, 05 Nov 2025 06:33:51 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:1d39:8dd:58db:2cee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a696d978sm3132190a91.11.2025.11.05.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:33:50 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 05 Nov 2025 20:03:44 +0530
Subject: [PATCH] overlayfs: fix uninitialized pointers with free attr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-aheev-uninitialized-free-attr-overlayfs-v1-1-6ae4624655db@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEdgC2kC/x3NywrCMBBG4Vcps3YgSS9aX0VcBPvHDpRUJjFYS
 9/d4PLbnLNTggoSXZudFEWSrLHCnhp6zD4+wTJVkzOut9b07Geg8DtKlCx+kS8mDgqwz1l5LdD
 FbyHxcDm349B1boShWnspgnz+p9v9OH4fFA/BeQAAAA==
X-Change-ID: 20251105-aheev-uninitialized-free-attr-overlayfs-6873964429e0
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=vg/RXprrlsVjtXM2tQTWZW5NZf2Zc1PI2BcwO3b4knc=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDK5E7x/mmaYJghHbb161vBg2pXXuVO+iX5v/hVhFlOyi
 W3TjUd3OkpZGMS4GGTFFFkYRaX89DZJTYg7nPQNZg4rE8gQBi5OAZiIHD8jwxMjm3+J234vm5rD
 b3vynJmj9XmVBYeXJwUvc107f/1bjnWMDFPLfO/uupf24b/z0+LKuFsS7af+VDFrV6oxuM7lb5n
 qww0A
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory assigned(randomly) to the pointer is freed
automatically when the pointer goes out of scope

overlayfs doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free` attr
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 fs/overlayfs/params.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 63b7346c5ee1c127a9c33b12c3704aa035ff88cf..56d5906e1e41ae6581911cbd269d0fb085db4516 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -448,10 +448,9 @@ static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
 		err = ovl_do_parse_layer(fc, param->string, &layer_path, layer);
 		break;
 	case fs_value_is_file: {
-		char *buf __free(kfree);
 		char *layer_name;
+		char *buf __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
 
-		buf = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
 		if (!buf)
 			return -ENOMEM;
 

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-overlayfs-6873964429e0

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


