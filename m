Return-Path: <linux-kernel+bounces-760695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81D6B1EEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B4E7202F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C52882B8;
	Fri,  8 Aug 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qv9VyF9q"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8902882A2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682040; cv=none; b=pfo4islzbuBO7Qc37NWEFfHEhsxtrfWN9Ukuqs5v3e8xrs/jqy6e2sj73jfcc7KTltpP+njPQBhAdf46nKbLPpCMZeD8lw7nkbS+n2esFQ1mZW8d+rjOImJ9K0wC0fKx9EzbbkWO5URmwy1NuVAR89UnPvDAzc+yZf4hEFDkK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682040; c=relaxed/simple;
	bh=fbC1sfGTRwM9KVR6ISJbEGyq/BzRDCIS9DtaXdb/r/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJG8sdiiQDljNQERxgyZvAW0HOmCMjhOzloBk05+JoUBO/w4rlBus57/kgtgG4CmzElDzCpyr/9VQ1WsrFii48lHa7Siq7++0zL5cjqKlwQC/Jr0qZxsJtpEZGPzcxXUjB3s9w+JnlwKcxMfx0cTM52tqi9YC0EiymBp7ccZuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qv9VyF9q; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e41b930105so13681275ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754682037; x=1755286837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=Qv9VyF9qPpd8lyhs9+zp8dCC+g1vvP4tCU6o4dVfoZAtOeATK8LMR9DflHuvF0ppym
         tOzdBv+QMyZKuaYEwMpWd+pFyPJgCHNfR/OZo6PGDF1Ut3JEdUdJcf2NuXZzdMsZNJ4J
         Gq9dvL5o/gnjZPmjxt6A7YeP/s3pRk5OQQromBo68D/9a5cpDE9UVtwDlQwKfNFk0L4P
         v5TTCZote1xBOR4TQrlUBnnhBQDXpI/8aJucSUm0hE4XbBBlcPSTp7WXUsWtpqGAvNci
         +dH4TQKo01Tt0vPlJ7ro3nK5mRWJOcE7NNguyl09lT3+7f9QaeT9jx/9SFEb6O60eYxZ
         kn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682037; x=1755286837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=Ici5xZM8Yua8RwPv5sTtZT3FICYWyPdJ+ZR4nkpP90/UY1UXPYEPiMdmzO9g9FcIIX
         ydMIPyuHvE3Vt4JWE9JLEzD9mKFKbZrxW8/hP+NUQwQLWHJFAATPNrTW8IDptjXGoGIg
         +Gh60BBuew0c4G8aztTb2fF68riLgD6KtxuT+Mb+H/ZMvXOY/uIaKO/AWu9tsOR6VLHS
         TjiqN6wHqg/yDdflgOfO94bKVLuC/W8ckS0MGKLwW86FzeRkv+eS/SPVezFo1xG9wvwX
         2X2kbgzu2KXAlIFgqowDOnpeP2EIPdCUG/WtR5rUxmYWBlZ111De2MlXuDkkPGdCDCwT
         iLqg==
X-Forwarded-Encrypted: i=1; AJvYcCXYzFgOFgrWxTYwWyCZOt+g9sBPrviyfQl5EZFXaFxMUjT+u0Pn42JUJF/roiNQV3ryF1Oi19W2L077+2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4lzylQs6vTUF2Xi8HMMyN3O/ChrWtAuh1vUof5xjFmpd1RCP
	YAbxnF0W8AZno26T/8kgkDfExpUhVaDZrTt8wdZgOQvmVAgDiooEG7tV8LxRccgkP+Q=
X-Gm-Gg: ASbGncveiqo452k6Vr1ssLpZ16HrOBvBksePV1Un25X0DVtyJ4UGLduz0snV5uELs7R
	Cdywp7k6SbrMGxJ/Kml5ZiryE+qM2fs1vUxLFB5TNKXcaGj38LD1NSLGs/JL0rndfRhWh2/6djs
	VgGBcZzmfxcXHBAi8q9M970ypBCMmZeBKAKZi8sXWiFa1Szn/laH2SFRjp7ED8qBCSaAg6AMAnZ
	ysl4uPN2xlBLtJZ923nsK3jO/hTRSiqwqACHc83MB0anFuw3N04bDQZTFfN7cweAKOcN1jMthxj
	pEmAqsLamwsFwaJUABIgV4zZq1rzhoECRga7yR/N4i60OhQFEpr/IeVsVRGB/ygTFzaQRM6onLv
	QKYd4
X-Google-Smtp-Source: AGHT+IH2UpzKS18Oe6Yaqd1vLBnaMu6N4Av80bztoHhlVzqOmN+TBK1mKIZRtGXMBrujqw7T5yeUKw==
X-Received: by 2002:a05:6e02:1886:b0:3e2:c5ff:382 with SMTP id e9e14a558f8ab-3e5339fb3e6mr58553175ab.5.1754682037532;
        Fri, 08 Aug 2025 12:40:37 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8255:4e6::7d:6f])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cdd3e6sm10482345ab.55.2025.08.08.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:40:37 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH 1/1] audit: make ADUITSYSCALL optional again
Date: Fri,  8 Aug 2025 14:40:33 -0500
Message-ID: <20250808194034.3559323-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of commit cb74ed278f80 ("audit: always enable
syscall auditing when supported and audit is enabled"), eBPF
technologies are being adopted to track syscalls for auditing purposes.
Those technologies add an additional overhead ontop of AUDITSYSCALL.
Additionally, AUDIT infrastructure has expanded to include INTEGRITY which
offers some advantages over eBPF technologies, such as early-init/boot
integrity logs with. Therefore, make ADUITSYSCALL optional
again, but keep it default y.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 init/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f085455..2552918deb45 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -487,16 +487,21 @@ config AUDIT
 	help
 	  Enable auditing infrastructure that can be used with another
 	  kernel subsystem, such as SELinux (which requires this for
-	  logging of avc messages output).  System call auditing is included
-	  on architectures which support it.
+	  logging of avc messages output). Does not do system-call
+	  auditing without CONFIG_AUDITSYSCALL.
 
 config HAVE_ARCH_AUDITSYSCALL
 	bool
 
 config AUDITSYSCALL
-	def_bool y
+	bool "Enable system-call auditing support"
 	depends on AUDIT && HAVE_ARCH_AUDITSYSCALL
+	default y
 	select FSNOTIFY
+	help
+	  Enable low-overhead system-call auditing infrastructure that
+	  can be used indepdently or with another kernel subsystem,
+	  such as SELiux.
 
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
-- 
2.43.0


