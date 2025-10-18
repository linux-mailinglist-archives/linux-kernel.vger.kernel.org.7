Return-Path: <linux-kernel+bounces-859315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8908EBED490
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 341024EA8A4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4024886E;
	Sat, 18 Oct 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="A6QbQnPN"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3B243956
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807881; cv=none; b=Ww4f2A2r90JtxDpzo5ZmOvdTGzEd/hxI2a/ug+4sYx1GFNFd33L3Nf4bdfv/+8B2vy4nRe5xkmCdBoqwAUmEiRu9hVYX+BB1foOdOBENXcLGjsN59g6y32S8FhDA8ZjOJZPjs1syUTQ2ggbsIZS/9Pqisc0QjfVkPkAnCkFKRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807881; c=relaxed/simple;
	bh=CkP35o2g0f6Yvsli2hyfkcKcXjwIxr/BXO6CQisp2ZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzKv2PWpmLdUhEW0ED1PFA855tsBOHQWBRz4mZwMxtxMX9mrf01yzUSu8Z93ggYxE2SQvQsLSShKO+viK9g4uGs8BKZmA1eY9AZDGN9g3TXK5hs/Ks8DoBGe/0zuo+XdY6cbQdATlS7iv4gw0q6Sj8uoHVgzKKQlgxNeCpQwIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=A6QbQnPN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c1a760df5so58504996d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807879; x=1761412679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G29XfdiPrhmaQm8Tird4J1gH3HStwZIQQCKqgD0mb8M=;
        b=A6QbQnPNcYAfbQZLvYTfd+ku2OYEMr1Gyty4wSOevhT2ZgmmQuIjNfrIayvKDbThtC
         JgH4JA16jBMJf0EgB7juCviHjy+NveUDe8KLe74HUeyH6dEd2Re1hyX0zR7fLNAydspz
         sIBzeZSmH3BrsdEImyviG/0xvcmOtKA1YGHIu9ElVmOSS6+R/adssyiclS/mm4lxwZZM
         9+M94ajaLqwbkkWW/SogK+IZ7Wg9Zy8wrwiFyI698jAim9BCPXq8MtI1X5GX7yJi99DW
         u5Yyzqv53aVrwht3scSS2ElRNcizuaGLktyPBzugq9YyGCtRbR+/QXuoJX4abuy1lTRi
         e0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807879; x=1761412679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G29XfdiPrhmaQm8Tird4J1gH3HStwZIQQCKqgD0mb8M=;
        b=QG11Qj2LhWWD7auC6Fia4kAs8XNx47rtkq3W1jKoaLdRBmauEi9F8EOd23b+RGf3sB
         HuHpGxnr+kvBraBpQOSUPCbuVGTuipRmUEkChgFPKs5kk6oYHT5+Em9lPwbUgtuDLYM3
         +yLwpY/2OWHpPebZPq7rPB5Lr8vJDmSS2XYqQ7rZKPzpc8KikCnpD/ZqUmKhuOfqrpTJ
         J7FH2NMxrWMpqoYYyPnngt6r01N66aLnwy0ztDBXg6Qmvj0rAuxMO7wgySX0AQ3yob3h
         wUVnvmwhgqO3iwxEId3hcPjpTczhH9BkPzLpTxPpYVf2ZHxMHoGqfpm6ifp8tkWBDz0b
         FtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWMctkzqLDnM4vAZT1wXYWclkL+8GOMGDqLIjqn092eE2I2Qwvmcy9BWrI7+Kz+7ENxcu7orZ7NJrdJ6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Z8pHn+uUzNBiwfZ9o6YOcEgwVRoGyjVNuN0HHUyoZiL18Rvw
	1Rw8e0yK76HICjR+zw8fie+d/NAkkp2y7kztJ4EBag/bLD9Nj+DJ8aJYr5In+d+WyIo=
X-Gm-Gg: ASbGncvrSjbQMh29szpaOmM/LaQh+9mwsATSbtT0zhYYL3+S2L9d7375ZZur66dmHlN
	P/NTSN4vM3+LLbaASvgZ+8fRbswEKhSOZKNG6z1X9t4Q4ID9tmR1CHllE2zAbm1V+RLogL7Hl2a
	wvoqWbI3rrKkec94cBGgYXUHBcqXxPtA4SJ9ArWm+dqPYFB4JCjOt3fH6lA9Temo2SLclzA/Xiw
	hr7nAHgPYFxan++rT139wQhAdO9abaz31K8qE+n0J7y7RVU4k6CjvNq2e53JD2KVJOE/SIYXhIE
	vKrvCsL2mF6lQ6RCvyxWgsltFwXKN5OaqqTY7tMhzKSg8iADUmtzSLpTe3GdKyenmq5BhHfNhNn
	7nMwMSjZYG4XJOgFFk9ZGGJoo9sJoJHzcpwn5lggZfktjeKa6IVN0yJDHaAFr8h+5LciPEPBbIZ
	7UbjNQrD5SKzoR5g8lorgwMWknQfGppQ6e1FSxYlfipiayQHC/iNIKCWzAIRCBICYTYWLEkYxLM
	sERYyWW8D649nz6EToGdw==
X-Google-Smtp-Source: AGHT+IFUrn/ODTICOJeqybc9wpoG1rwCuTkHZDhaNQG6q4OMb39krbHuQ7xa84xnE8FoRgnLNMU84g==
X-Received: by 2002:a05:6214:248a:b0:7a3:b6ab:6f2 with SMTP id 6a1803df08f44-87c206612e1mr126599836d6.63.1760807878808;
        Sat, 18 Oct 2025 10:17:58 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:17:58 -0700 (PDT)
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
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v6 01/10] kho: allow to drive kho from within kernel
Date: Sat, 18 Oct 2025 13:17:47 -0400
Message-ID: <20251018171756.1724191-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to do finalize and abort from kernel modules, so LUO could
drive the KHO sequence via its own state machine.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/linux/kexec_handover.h | 15 +++++++
 kernel/kexec_handover.c        | 74 ++++++++++++++++++++--------------
 2 files changed, 59 insertions(+), 30 deletions(-)

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
index 76f0940fb485..76c34ea923f0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1067,7 +1067,7 @@ static int kho_out_update_debugfs_fdt(void)
 	return err;
 }
 
-static int kho_abort(void)
+static int __kho_abort(void)
 {
 	int err;
 	unsigned long order;
@@ -1100,7 +1100,27 @@ static int kho_abort(void)
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
@@ -1143,12 +1163,32 @@ static int kho_finalize(void)
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
@@ -1160,33 +1200,7 @@ static int kho_out_finalize_get(void *data, u64 *val)
 
 static int kho_out_finalize_set(void *data, u64 _val)
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
-	if (val)
-		ret = kho_finalize();
-	else
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
+	return (!!_val) ? kho_finalize() : kho_abort();
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
-- 
2.51.0.915.g61a8936c21-goog


