Return-Path: <linux-kernel+bounces-863936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1788BF98C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826135626D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC421B196;
	Wed, 22 Oct 2025 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="F0MoXSj9"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6F1FE47C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094650; cv=none; b=RZCLvvEWS3EsLN50fp2NipQI7IdIJJtmD6Wh4CLzu8k2cfBlqJ1nMTYfBmINQfwdzI3IJbLA6kft5Ko4qPV62DLdC6P7b5M6I+80tzaQTlBoVO4XS3YDRLo2VYnTZGJJ0Rt3VwislnGr26GVnCCZwjTcS3EcM/UNDWRreTHincE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094650; c=relaxed/simple;
	bh=rDk7y3w4IR2m5puAiIrkuPe+hYp57EQM6DHhAf+5F9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw082LX/qJnVJUD2RmRs/OHxoF2FRo74M5luy52R994CHOWIPFbIkuB9lsY+yVjRPCLdfQ/yyuE0zYjKyJ+dbgjdLX2F9Ig/ISxGtfAV1PZasCfsunAx2b43ci6q8g9Xm81Et3Wdd5TpwUfrlmo0C7n2p7Q2KigcuhSJLjwDIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=F0MoXSj9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e89183fe47so5307231cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094648; x=1761699448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pcy9ROlMFFrxYmRYWOB+KoxotgZLEgmv04f04lRuCLg=;
        b=F0MoXSj9PuNjYQPKxdf2O0UytO+qmDlZ5fSk2mOquUKlDDH7Rn4Toc9s4miLMc9cJV
         Uhk9r2z2kB8++EQI+Vr3OgWXWlqd6MxFi7ZstARpy356hQ8EdAaHgTP6/0gokYBcAWXd
         tCNR+0tSk7AdmDZA7ayYzUJUYyCIsPzdxEg0fehN9iydwRMY1o4ut4mqxtA3OBdPL81B
         TWphsMlj/gUpUV4ocath0eNximfZEMGMYdsd5mvlTxXl2OpYhnvMxRaPcM+CAAwAO8L3
         vdHKPT4KFw12pkH4fQlc3pYurEF/s8+OTdpaP4MHC/1WhKxjQ6xc59IG084Q3yUCrqNZ
         SxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094648; x=1761699448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pcy9ROlMFFrxYmRYWOB+KoxotgZLEgmv04f04lRuCLg=;
        b=IJz1xfgfnm8cCiBbk8xyclNYff7TxtFAb07azTcx7p+Bg2yZ7IAon0klEeCyNhkjPC
         zWIqzkWNL7ZbKfquQXeGS6bhFC/89F8WKTyp9aLD83RO01vDMAz+fOkMfepH2laE+S91
         KcSLwS+bI4F2lYduqP+NWtdlzSt16BIct6gn4GEx+0DXXlL/JVq8pQIdVQK3S5g/wSF1
         a+kKEHx5b8W0fz4GGDn1hSks2Ls3PSnKj8VZ9e2OEG833TR+jSXlQkW/PrbB8OTaiXCr
         iAVFmaz0mNP/8nyNk6/kZldvkVclsuRizNnCh6iDjrXiSqDniTiyAuS+tvI9lza0bhis
         42gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2IAL106PojLQR74d0oiOcFf2YVl9G0ER448kOUSyU+5tRQhs/rm82FkiaELsFVOv06NNX8xkDzDPRprw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbfzLbcrqClbXUuzXKYukapBWQwCnOIEmFtgOZMdaGhQWzENp
	wIUghQcMpiu+Ghpzsm6JnLrVgQR6UpXFD127Zpw9dzq7ukKWaIc0XxvO1ynkjArEqpM=
X-Gm-Gg: ASbGncuRiW5USkue37L2HecnLpzKP/lMgQU/2EU4WKTSUAWV9iGN4iC/1SqgzygrxfB
	a5a2xQAbnSwHLvrTFiFxwtTq7gSmN9MuX3ynV6d2oTs5Eeb97alq5Bbgoa+l+8osu80xEvWLnUk
	e22KjxgE27E80T3HUSJoKksVwH0gP+UdaVEWuLpuDZPlb5TKexFX8Tvh7wh4AqhthWlilHrwG3F
	Owx5MT6VJX6u20g2iRtTgxOY5Ai5GDq/EWbEpA/IZd8Gt0AzkVxWrPwWNK7PO/x2yBETJT476jb
	kOdwO93WRTCqO0culfY18L9ONfqqJB5bHwHR9DnVFKOlLW3JkhzhAXNcUsEVPA6+Bnt8EqOwwLv
	iIlcMq+2uT3R7HhXph9VpMvh18IEUaxktAOSePQG5BtWArt3Xqpua5vLxssLoc7HEDXiAqobK6B
	3vednq8giXeUw3HoXPX+X3kUmLtb4zHZjTWcM+aG/G0QnrFtMlQpXRq3KZ+kNGY5GYYFEhVQvyE
	r3Pi124Du4H6ICIr+rpnw==
X-Google-Smtp-Source: AGHT+IE6c9SGq1VaL57v0krF0Yo2JROYiPXfKdfjnZS+o2r+gBektScJV8dUmdmPm+e/5KTw56WryA==
X-Received: by 2002:ac8:7c54:0:b0:4e8:b3cf:b9fa with SMTP id d75a77b69052e-4e8b3cfbabdmr154195831cf.29.1761094647906;
        Tue, 21 Oct 2025 17:57:27 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:27 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCHv7 7/7] liveupdate: kho: move kho debugfs directory to liveupdate
Date: Tue, 21 Oct 2025 20:57:19 -0400
Message-ID: <20251022005719.3670224-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO and KHO both live under kernel/liveupdate, it makes
sense to also move the kho debugfs files to liveupdate/

The old names:
/sys/kernel/debug/kho/out/
/sys/kernel/debug/kho/in/

The new names:
/sys/kernel/debug/liveupdate/kho_out/
/sys/kernel/debug/liveupdate/kho_in/

Also, export the liveupdate_debufs_root, so future LUO selftests could
use it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debugfs.c  | 10 +++++-----
 kernel/liveupdate/kexec_handover_internal.h |  2 ++
 tools/testing/selftests/kho/init.c          |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 46e9e6c0791f..454b7d34ddc3 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -15,7 +15,7 @@
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -118,7 +118,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("kho_in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -178,7 +178,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("kho_out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -212,8 +212,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 __init int kho_debugfs_init(void)
 {
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root))
+	liveupdate_debugfs_root = debugfs_create_dir("liveupdate", NULL);
+	if (IS_ERR(liveupdate_debugfs_root))
 		return -ENOENT;
 	return 0;
 }
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 17ae101dc6ae..92798346fa5a 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -15,6 +15,8 @@ struct kho_debugfs {
 	struct list_head fdt_list;
 };
 
+extern struct dentry *liveupdate_debugfs_root;
+
 #else
 struct kho_debugfs {};
 #endif
diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 6d9e91d55d68..f0136a30ce8b 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -11,7 +11,7 @@
 /* from arch/x86/include/asm/setup.h */
 #define COMMAND_LINE_SIZE	2048
 
-#define KHO_FINALIZE "/debugfs/kho/out/finalize"
+#define KHO_FINALIZE "/debugfs/liveupdate/kho_out/finalize"
 #define KERNEL_IMAGE "/kernel"
 
 static int mount_filesystems(void)
-- 
2.51.0.915.g61a8936c21-goog


