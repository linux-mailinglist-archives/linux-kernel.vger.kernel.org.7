Return-Path: <linux-kernel+bounces-631247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7CAA85A2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F6E189863D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFC01AA79C;
	Sun,  4 May 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdY5hqOw"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567A81A8F60
	for <linux-kernel@vger.kernel.org>; Sun,  4 May 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352396; cv=none; b=E8+UyecPEAc0R5nr/IEhZpHGOtMOP6fpkz35EPRZf7V1I6e7axfbDXxsVvt9BWZh6N2zyzhnTwxcBFibx3DZq569Ysh+IE9JNuf35M7pPqmqFAut5ef+MPL+qIaAZGpuJo2pMDwILc0gs+0FFZHbkoEGKFqF7OYrRjtp49Vg8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352396; c=relaxed/simple;
	bh=wAopLMca1UYjHu6q///t2MON0majb2OOzEkKv0U9LCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AtnQ/wli7ot/74R7QcFt5bExrc35fY1bLsgRGRUJlvMzSqUl77Lo5FCaZsJb9x2XcddgkWID8JYmdPADqQVPwsmw9J6Nkp+Tn9XQBkRPabv9cFRzEXMZs5f4XJcgeuCnuP9lm3WFKDwnZT5ENWQT0KhQSfBeTmqWKT3hdBWbBXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdY5hqOw; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39d917b105bso1654645f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 May 2025 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352392; x=1746957192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAweXUFMoRYKercdO+M+dsvHLlCp3KZIzpWmAZjUMHA=;
        b=EdY5hqOwYHDN+3NplhxQeKnQjKAZYgYHdJ5NLaAOC0saxUedOg21YCfBoEq20wRAZ1
         WkmK6EwaRN4yBwag4lcsB8UNfTXMlBEQFmA/nD6k2Txrid6WF+npGmqoLnlh8XXyUVw2
         XkXaLiI7V0lMbRQXDp28flRIu4+uYiX+BG4MLT22rafCNOzIcNMgOVurpIL7/Bu1gKxA
         upuHigeJCuPXAjvBDoI/hlPueHrLXnBgqC35sZzxIVNrO5ACXeV+JellfceiZeXfDg0I
         hM2GjqmmXjPWn7FF6OmMoLcOclLYb0uueUL1JFVU9+XfuSegaEzawJfHtg9xRoiF9FET
         vhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352392; x=1746957192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAweXUFMoRYKercdO+M+dsvHLlCp3KZIzpWmAZjUMHA=;
        b=cvI+cCOiXgAfDRr2MtWD87clPbMRQdsw0qWlTh0UzC0g+rGfQbp/Ymb7b2w9SxCNVx
         m2XlyXKO2jmlv1SKf8NB8OjYtsffCT3gzj5KiBZ2AvFKhN5/yail76qNkGMKgw5+hd7B
         +NftyqntkicOqSREUIXacNO9AqhzmabGCTWCzqrBT1MW0SS6rWgdwGZ1yOEX2UQxKcKf
         LlOuOaBrRb96yNQ4CY3zg7rhtxWp0iVKgmmHCRVuAg6rYzEHEDjwkLqWtZcPDFExiQlp
         F9ysDmtKS+Hz/J+/kG0bqRfamDjc1lfbMQdZFjWt55Al5wtXxg58XwmKYVrwvEcD/l23
         JPaw==
X-Gm-Message-State: AOJu0YwV4Rn1p4+SXHfXLe0Ofz8meQXFjz1qi+NKyb+JA2P+EYh7v5ho
	Yhok3eYV/aRpAIOkltxUgWGqp1lccm7t0gQ/rXuq7NtOIC+H/hgKjhbmhiY6WtQ2akFVqYdGHu+
	cCbIXsWuSLksyHFy1sHw3wZG6fCN2lq6Kz+QRF7DnN9lDPpano62+36+WgnBkgYXS0esDQJnj59
	q60WePxKaxd8fA7CdYVbDlNPVdEWbbUQ==
X-Google-Smtp-Source: AGHT+IFM8cy2OT3ETxysigkIKqj/0ZIhQF3bs+uCxzkZ6dCqhcT/sDAKlDn0k6MRjCEA2TTZpReBQrga
X-Received: from wro15.prod.google.com ([2002:a05:6000:41cf:b0:39e:c3a8:56e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5f4a:0:b0:39e:e259:91dd
 with SMTP id ffacd0b85a97d-3a09fd767fdmr2356447f8f.17.1746352392609; Sun, 04
 May 2025 02:53:12 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:34 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=ardb@kernel.org;
 h=from:subject; bh=JGgi/PR6B/UfDqiCR294jKpXFY27Hox0oJTQ0bF4MW4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4oma+ffGA1wJetcP5/u63mjazBjxYtYal82dN0syz
 d8unOHRUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyX4Thf+FdTjPxxQJZxgev
 WMq2T7bfuftDUOq6a2WO//Ysu7l1HT8jwyzdvPX68Zt8Jj538g5ofPDeWmfO2/jMXf4RWTfYVs5 S5wQA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-29-ardb+git@google.com>
Subject: [RFT PATCH v2 04/23] x86/sev: Make sev_snp_enabled() a static function
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

sev_snp_enabled() is no longer used outside of the source file that
defines it, so make it static and drop the extern declarations.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c | 2 +-
 arch/x86/boot/compressed/sev.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 478c65149cf0..bc52c0aa96d4 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -164,7 +164,7 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 	return ret;
 }
 
-bool sev_snp_enabled(void)
+static bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index 4e463f33186d..9d21af3a220d 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -10,13 +10,11 @@
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
-bool sev_snp_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 sev_get_status(void);
 
 #else
 
-static inline bool sev_snp_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 sev_get_status(void) { return 0; }
 
-- 
2.49.0.906.g1f30a19c02-goog


