Return-Path: <linux-kernel+bounces-863930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00606BF98A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEB0482C52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F61EA7DD;
	Wed, 22 Oct 2025 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BGq/vUUi"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF031A317D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094645; cv=none; b=SFzj65Ym2nr5HC5YGzsoB9iIh+Ex6NhgTsD3bDuFWO57b8rSMXnF6oL7E2+KknNxWBoBoKfRe4iNWHfTDf9VobNdvgHVXPeUuUxal2YTtcOTS2Cjal7gP90FyJz29pe24fvpgr0JDSQClDs76c3FHmaBA+e9uIgqVpASsltuO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094645; c=relaxed/simple;
	bh=ROlC0Rmq6oglp3SIiwWhTf6bfbx9oH9CcVgMhO5a408=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQBOxkbIGR4/XSfseaCUa8x1Iv0YZ9A/l5t4Bhc+QT2axW87f4NkMgGwwykYGsN+hxgYMu7oDp3maACBhtGggrmHCdwBSRwhZyia0PD3Lpx7D2zuPYZOdotp73yFQKFuTRAjnWjuCzPEsGlRwT76z5NCIBRW34ZqquDi75nxnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BGq/vUUi; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-892d1443e48so809214885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094642; x=1761699442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nnhz8RmEJ4aJVyp94lmGqv0dP2Oq39IOopI61ahIsMs=;
        b=BGq/vUUitFqzI+BhMSncBwqtq/Gmj0/LhheeZxjZn8YWHQa258Xgss6Bw7kEckYBu6
         N/RkEzSG74aKSoQRXMkr5HOJxwR0+VIpsfN8QfL0jtKwYCUzeWcB3DuzfCJO5kCQbxp7
         V125Wrqgfkv9At2zlBe3Wil3gKInkTN6djnvGLfc07CB81fP4w5icAmIVbvGfgUsiTIV
         VrJFe3MDQvReW0fdzPDML++md8hlnc8gChVhu7PE3CK9/tp2ctSFlLy68DUByqCOz0NB
         FeV68+JfnRJhiT6orZfC5Bfm6kQ9Tng58gItRQmfuJ7g35jjNkCO0c7JuYUbAzwsFFjf
         Jkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094642; x=1761699442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nnhz8RmEJ4aJVyp94lmGqv0dP2Oq39IOopI61ahIsMs=;
        b=FLIyVIgwgUPyEe2K9jpZ9Wzm98bmfPiPl1q5sVEA07s7h5qx8Rin8pWdHdopv9cQuG
         GZVu8TdGQaXzi5gVRCZJOAsg/yNbtt5G6WIwHkWbKICjpeaHqlnxpque1IoXze8go6Zv
         cUKplJ0nbvonLJsPuzgEWrV985HSeRZR3UiAgL39qQ1cgDSjEbzz4T5yr2t7FvNwRoXm
         ZxSaVbP6nY1l26gG06ukdNYtiH8yTQeGr30r3M9KRm62zG6OvZgoFDVE0jwYLmeHE+b2
         +gwaqOEvGrvvLz+Q7ZkuxmUVMzFp27O1BzfA5gneYIZ4pI5WunjocKoZhGfrTzS4J4l3
         Cj8w==
X-Forwarded-Encrypted: i=1; AJvYcCWjNr0SWITaSINPrl7f8lyojHa99Ze9xAm62l/G7qAmpQlGS9A9pF+Gm95F83smWNo+NKjEYJGeV5E8cPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+kVgQ6oh0W2CTpsEKocb/ZSzYMJUifBT+XWenR1nJTc1DgDq
	XPUnVsu/OsHgTXw/n56f67D/GBNUwEieLKiJcccIa9hUq9/iY8GmGC+m1/aBNeoFid0=
X-Gm-Gg: ASbGncu5PZEFdhDe8N7MAhAwmoLLs+tiwT7aU/yNOKq1mW7QjjHDu/IpI/RToTaMmoU
	SP31WKTW/UUhV+s4ye4pwOOE1G4b43DRcWwBzVyY8NRsaOPRe6Bw5mXGuAW/fzXWgmoj5kTtqI8
	Es/V2UoP/xJFqgWe7iqAQ/z4rLdB9lVgQHMAIo/B1ftK60gT915Y4t39zIvrmescCfyDAfOVZ5I
	IGrXxUpZqBt6vQhdgW/jxH33MPsGKongcLSrHFGTMc/BDoV/3mTF8Kq6GEdA5hjhS9OWpcrrJlp
	mEYPJcu5vOFHpCRfD8Q2ejYufP5e8gOuH9hQfzJgxebM7fh2VEyp6IlithhQcrdZ32F0zl2XAYU
	rLbDgPJymY7oLvb8C+GEAaq2mhrdxZ2YuJMgjBP1qoLz2OiaNk3fEzBXPmsL1eShN7wVGQJGGX6
	lY95xJj1cl1XZyehWzBn2Oh5dHkSePhvQX98AGn+EOziWPy+pEqXhnDVcLGPIKicdPFlped1omP
	gPIwjniwTn7pXBAytlAXhdPTWM/CuL1
X-Google-Smtp-Source: AGHT+IEaIzHHvFJMRfSnJtfU36gVB4GsmRc7NSrbXKPCCo1QHLpqLpx5MupgzuVuHjY2hx1vePG7Pw==
X-Received: by 2002:a05:620a:3186:b0:877:bc0f:985b with SMTP id af79cd13be357-8906fd1837fmr2516115385a.49.1761094641789;
        Tue, 21 Oct 2025 17:57:21 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:21 -0700 (PDT)
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
Subject: [PATCHv7 1/7] kho: allow to drive kho from within kernel
Date: Tue, 21 Oct 2025 20:57:13 -0400
Message-ID: <20251022005719.3670224-2-pasha.tatashin@soleen.com>
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

Allow kernel to drive finalize and abort without requiring triggers
from the userspace.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/kexec_handover.h | 15 +++++++
 kernel/kexec_handover.c        | 75 +++++++++++++++++++++-------------
 2 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 25042c1d8d54..04d0108db98e 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -67,6 +67,10 @@ void kho_memory_init(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
+
+int kho_finalize(void);
+int kho_abort(void);
+
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -139,6 +143,17 @@ static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
 }
+
+static inline int kho_finalize(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kho_abort(void)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index de4466b47455..6458f369a346 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1087,7 +1087,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -1120,7 +1120,27 @@ static int kho_abort(void)
 	return err;
 }
 
-static int kho_finalize(void)
+int kho_abort(void)
+{
+	int ret = 0;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&kho_out.lock);
+	if (!kho_out.finalized)
+		return -ENOENT;
+
+	ret = __kho_abort();
+	if (ret)
+		return ret;
+
+	kho_out.finalized = false;
+
+	return kho_out_update_debugfs_fdt();
+}
+
+static int __kho_finalize(void)
 {
 	int err = 0;
 	u64 *preserved_mem_map;
@@ -1163,12 +1183,32 @@ static int kho_finalize(void)
 abort:
 	if (err) {
 		pr_err("Failed to convert KHO state tree: %d\n", err);
-		kho_abort();
+		__kho_abort();
 	}
 
 	return err;
 }
 
+int kho_finalize(void)
+{
+	int ret;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&kho_out.lock);
+	if (kho_out.finalized)
+		return -EEXIST;
+
+	ret = __kho_finalize();
+	if (ret)
+		return ret;
+
+	kho_out.finalized = true;
+
+	return kho_out_update_debugfs_fdt();
+}
+
 static int kho_out_finalize_get(void *data, u64 *val)
 {
 	mutex_lock(&kho_out.lock);
@@ -1178,35 +1218,12 @@ static int kho_out_finalize_get(void *data, u64 *val)
 	return 0;
 }
 
-static int kho_out_finalize_set(void *data, u64 _val)
+static int kho_out_finalize_set(void *data, u64 val)
 {
-	int ret = 0;
-	bool val = !!_val;
-
-	mutex_lock(&kho_out.lock);
-
-	if (val == kho_out.finalized) {
-		if (kho_out.finalized)
-			ret = -EEXIST;
-		else
-			ret = -ENOENT;
-		goto unlock;
-	}
-
 	if (val)
-		ret = kho_finalize();
+		return kho_finalize();
 	else
-		ret = kho_abort();
-
-	if (ret)
-		goto unlock;
-
-	kho_out.finalized = val;
-	ret = kho_out_update_debugfs_fdt();
-
-unlock:
-	mutex_unlock(&kho_out.lock);
-	return ret;
+		return kho_abort();
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
-- 
2.51.0.915.g61a8936c21-goog


