Return-Path: <linux-kernel+bounces-823879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230DB87A25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9C9466795
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6E238159;
	Fri, 19 Sep 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqj9/Lnn"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96C7E0E8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246434; cv=none; b=q31TJLxMljgs2yg/v54RHaOpT+aidKkloHutCatXYLTFCpZyzeAIGvSpVkfb6kIzl3AEyqr4JflC1kzFHdasWDJhxkvcfvvtpr6jSR5ZB8doEJkWUy9azNEAO61AdalOzauxW6HQiqnHoUFG7WTq/aSyX6cefyBiUlIE4C40CGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246434; c=relaxed/simple;
	bh=tK7qZxWKS2HuhX167r9HRB0W9FfaI2Q3iMdOyh7NKV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8mQYjost9HVDLv3XhPv5c6KXF5MGEQk7CZH4sPIFGWLy3IKc7+wPKZaT9F5TXgKXM0DdrFplGqlSO7oiqM+RD7QodScEnCcB6lnElgxMQgEliutrFxXHes1GmMPHqKG8nyO15W4DSUP2BKaq9dckPQcQrLXNd71o7UR3rGdSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqj9/Lnn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7728815e639so1132257b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758246432; x=1758851232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctSrW8wbv38Mk10S7M7Ab4SdtyDnVEwCrq9dHNHgWY4=;
        b=Iqj9/Lnn+cCuAoT62r7WxCdNy9rFH2mEpCDNXJVkw0Ll9bnkgVSwmLLaqAXBf7VPec
         OUSx64e5B4UM8QJ2vfKo7HS0bHaRr+sneEY7y/aH1QMxQ7QOjvZxH1gedKx4ifn2KiTA
         PU4FycfiXe10DKzDmcOzE5kjkC1byn2MdpuYKFMzbYVbQjG3aVkZ0iEJxmWgvIoDMBXg
         lSVAAVvbkClKx80hb1Hry67IhVCMTEa9YFmk1f4zmLjvNivb/PEyAjjBOJo1iXhuI/yB
         dOCl5k7UqUsGlzRVeJ59Cq/G7onh5yph86q/EnHobJMsdc0cGnOZ6b/A/odPPWNQxpm0
         m0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758246432; x=1758851232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctSrW8wbv38Mk10S7M7Ab4SdtyDnVEwCrq9dHNHgWY4=;
        b=Mjh5fXquOCbFAZm9KtSmcG4anQ3EDQcH3JGw7gaBhc1DipGjU5ME90V7xbChJabhfn
         OvS4QcCduSipJ3Cyhporw0GQVQ2gNe2tpfUUbW66mDF2Tr/2ig02Pd0o+dGud0XWvani
         +iBcK7ofL/q3wOro+y6IaQpjNCbJT1ZH9BXL+NajH2v4PpvdpPkqx0z/Op+SWI6JS5pK
         f+S4qxaMb+TnTiaqaBHRrRCewyYlgZUQK6CL57rM4mldfNBFukHTry0VyoPZ18edkxSq
         euuheWMb23lfy4NiW10j1HiQpK7cfe/lXIjowpBz4IvHs8QjBfdAVp+v6hHbckvdR5/S
         VRMg==
X-Forwarded-Encrypted: i=1; AJvYcCXmZ43X80qQmA50glN4dk6JH4bSpJwIlK72sr48nyWEuu7GzrZE9FivUqXv8lWZCeyQoifAykxC5zXq47E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZam7ZUnfpPLXQLozPidCQWMdOxOynuOKVZYXyFtEUDbm5BMP
	06PEHG4aQMG7uHplcleln2rWEpfyD86g11WVcfLGvvGKTt1CUfNckRlc
X-Gm-Gg: ASbGncvJp2rpomx4qM4PnRL/te4j0kneRh6NUPgy14H9duUUh5oCcIPBdkie+UaiRMj
	Roc6g1nh+g3wC9nlg028NB+q6bZDKKiKZrWbWz0zS/4KEdmEfiJ4WamjPckQsA592k14N4x6gTA
	JO+6uW2Ew3bd1q/2OYtOJmrIjZYWo37anOfPYBLazPh8xAIiTvOgnakBm5lfbyghu9vgam0+ENU
	uJ0U9Y15OWDHS15C78fqOw3WlQGSAUk2wkUwtzDOkp6tgxBF69wzVCNXJBlSBdQr2aW9P2bmmdF
	i0t8OinFIuXe5d5Kp5Re1P1PcscnYSvSuJyhjGZCq/51QsMNiduIhQYszzBvxP/eFN5YidubcAT
	jmHiqt8XgzVaCJ3RRxWu/c+fQ2jud7b3dfV3qY3B8rusBOxqNPbTKqvQOnLNAMoLMCCW5jyEUAY
	hy9Q==
X-Google-Smtp-Source: AGHT+IHgzeQnEqpmnUs1J+YXPdqkcX/Yip9M+tbbNnqxQ78PLh+Qjx/qxIoFuDJdnI81p0BRulHRLA==
X-Received: by 2002:a05:6a00:178d:b0:776:20f9:71f7 with SMTP id d2e1a72fcca58-77e4d708a65mr1943903b3a.8.1758246432434;
        Thu, 18 Sep 2025 18:47:12 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c2esm3618114b3a.2.2025.09.18.18.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 18:47:11 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: w@1wt.eu,
	linux@weissschuh.net,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH v2] tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers
Date: Fri, 19 Sep 2025 01:46:43 +0000
Message-Id: <20250919014643.2776037-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d5094bcb5bfd ("tools/nolibc: define time_t in terms of
__kernel_old_time_t") made nolibc use the kernel's time type so that
`time_t` matches `timespec::tv_sec` on all ABIs (notably x32).

But since __kernel_old_time_t
is fairly new, notably from 2020 in commit 94c467ddb273 ("y2038: add
__kernel_old_timespec and __kernel_old_time_t"), nolibc builds that
rely on host headers may fail.

Switch to __kernel_time_t, which is the same as
__kernel_old_time_t and has existed for longer.    

Tested in PPC VM of Open Source Lab of Oregon State University
(./tools/testing/selftests/rcutorture/bin/mkinitrd.sh)

Fixes: d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>                     
---
 tools/include/nolibc/std.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index ba950f0e7338..3940778822f4 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -29,6 +29,6 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef __kernel_old_time_t  time_t;
+typedef __kernel_time_t  time_t;
 
 #endif /* _NOLIBC_STD_H */
-- 
2.25.1


