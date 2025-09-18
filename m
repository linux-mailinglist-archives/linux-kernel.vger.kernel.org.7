Return-Path: <linux-kernel+bounces-822073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7848B82F92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BAF1C24385
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E65298CB7;
	Thu, 18 Sep 2025 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj9lHcgU"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386D296BA2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172599; cv=none; b=YkNvEDQlDCLZNp+akHxVVLFkWdft2hQP9LzYIxmqhKWrUkpYOh/DEk/cYZ9+whFcxoOl9+PXVErSBY0aF7Tt4e6UApshMWvSYtNT06sE4nyCmQHwC8+uVxpfCyqk7ruHEVyrAdAcer94nVxIWGubfDdR8yFXy5FNe4hP05+6DEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172599; c=relaxed/simple;
	bh=Spi61onNNaOtQ/uC59E8UPShdVaOx9lbkbExtWbBzy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwZodmQcXYP1Kohs+zFheuQ9we3r4YXNCflYADzB4W2TdBrdUoUvdSR3yU2z1QUwEc65i+H7B4WREn1NoWGgq7nHXhfjsA+MHBt7R+XWKydpupfvjrCpVk9mJoi3NnF3+brZoZbrFTP8a95KYjZAWlTdZvvi3NvUuv+29oBhykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj9lHcgU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso347061a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172597; x=1758777397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKlVdGR3DDGWOcc4/nfzMKG19h1bO7GYSLtWMup+EQg=;
        b=Gj9lHcgUVcoreXR+B6jm0TviPWsDO+Nxh7Q0FRbUBTqtA3d6Wslj7nE5Cl+j9AigJZ
         GmzJwoNmxVTatnToSBLYp0TwqqtUPp2yL1RDbJlpEVj2s8XlgDgCAzajmXLGahWUoGV1
         J+inQHXHA2eSV5NL7IVBpdo7YnE3sufotBY140e/X/MsK+/JessEk5uUjMGLB9wZtNyx
         rzfWFnKeXUmjzut3A7f51VWcHOjxF90P3bbhZzB/PHOuBXqLPD6VxWIj2e/ytsD93KF1
         tRfs38AeyxL3OW41sJjjc+139HM9GIupdH2+eA7E55IZ5WUyAdOBPSsK8yxst5/smC9c
         TvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172597; x=1758777397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKlVdGR3DDGWOcc4/nfzMKG19h1bO7GYSLtWMup+EQg=;
        b=KhMpgayjsd7NSS7KSw7dtZQeA3cZN3UPvIrPQhFX6rnC42bEAM3TMwhfpEWg0wrCGs
         6cohEm7TMx2dFAK8b1RNKKCtulGrqWHVFJDLwjFYuwd82qJi/lFqOLUKb0/ifa/Mzmop
         dpRKrBt/Xp2x2Kh5Z17SYDaLeHngnPCH6vC9tB8b6gbkZXa8Frz8yTVH2v7a90RO54gU
         taClv0NUk3TceKXk1x5gr6VlwX3xYl6II1B2Z+Ow68F56Aek7xW0rOKpJoYMKUf6zAWA
         m9OSEfnXx7bDQqiGqp4VTXiCOMZAcG+5fpKTvqHhjSw+yFqL6Y+FmHUFHGT2m36EsiP6
         DdqA==
X-Forwarded-Encrypted: i=1; AJvYcCW+S8rB2G7RhCOT+DfyorQX0BU8/0zulDa8gtgfBFcSadPezToT9dP5AES4ESAQCBJcvNgsiPIUdtw8Xbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPERuPB0RQTH0jlPsSxF6SL2yWSA4mPqSqspBygE+GC9tI2Twf
	7r49aRwHN1t8Sd32sypj4g8kJokU67AMaBouZeDTi0k+DhefqUqWsVLE2KS8PQ==
X-Gm-Gg: ASbGncvT8TpLcOnSRW8LkJv5fz2zZe2sZANa5oKMn3VggfDnNwkBKrxgvtEDmlAxa3e
	maZzokEAR+biBRbg3pewp/s11lWOfei08U/Yv8VjTA1UGLy6b59wc9Hrh5ODpfT7LqiWmiqzuLk
	Yac3O7rRJVBlAj40jI8iqE2q1C0Myb/xFfu1P6vlWfCy/weQlBiml8Qk01dcI4Md3rJH1P2lGhr
	jPhSG9WL/YZv6jsWX3+86fzWYyEle+6kFAtZv+J2pqbCMWtThCX6yDAh0/2KYWnI4uxumG3abMt
	J2BJ7mBCsNmusOrvkyS9gM9rH4yagiky1mQfzkAIiZ0M6aMRjfHO6eyFXzczczEgM2avd0ug4/X
	l1l9U16HFHs8w4rMyxMAb+atZkNQPEbd1SXBG7dJXNzY2KufPTtciHSk44/tU6zcdmNsCPxgJ9d
	bHh6P7FY9UIUM=
X-Google-Smtp-Source: AGHT+IGCbT607NrmgHz5Q3KgCNRtitF2Ip3ekkLRwWL5RuIU+yeUgrW6R7+caKPoVbPB2OrdzbDjGQ==
X-Received: by 2002:a17:902:d2c5:b0:269:9a71:dc71 with SMTP id d9443c01a7336-2699a71ded8mr3010715ad.16.1758172597074;
        Wed, 17 Sep 2025 22:16:37 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016d9d5sm12830035ad.53.2025.09.17.22.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:36 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 734B71061EEC; Thu, 18 Sep 2025 14:16:34 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 06/14] fixup seccomp
Date: Thu, 18 Sep 2025 14:15:59 +0900
Message-ID: <6adb6305c2c84d715d37642ee9cd4f5a28719979.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 arch/um/nommu/os-Linux/Makefile        | 2 +-
 arch/um/{ => nommu}/os-Linux/seccomp.c | 0
 arch/um/os-Linux/Makefile              | 5 -----
 3 files changed, 1 insertion(+), 6 deletions(-)
 rename arch/um/{ => nommu}/os-Linux/seccomp.c (100%)

diff --git a/arch/um/nommu/os-Linux/Makefile b/arch/um/nommu/os-Linux/Makefile
index 68833c576437..805e26ccf63b 100644
--- a/arch/um/nommu/os-Linux/Makefile
+++ b/arch/um/nommu/os-Linux/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := signal.o
+obj-y := seccomp.o signal.o
 USER_OBJS := $(obj-y)
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/seccomp.c b/arch/um/nommu/os-Linux/seccomp.c
similarity index 100%
rename from arch/um/os-Linux/seccomp.c
rename to arch/um/nommu/os-Linux/seccomp.c
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 432476a4239a..c048fc838068 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -21,9 +21,4 @@ USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o umid.o util.o
 
-ifneq ($(CONFIG_MMU),y)
-obj-y += seccomp.o
-USER_OBJS += seccomp.o
-endif
-
 include $(srctree)/arch/um/scripts/Makefile.rules
-- 
2.43.0


