Return-Path: <linux-kernel+bounces-834518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA7BA4D85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D45F3B02C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55930F928;
	Fri, 26 Sep 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dy2WENu3"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B12FFDD3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910128; cv=none; b=ffpE8ncpYsPvEvTvUMeSzyTPeoGTZ3n7rwMtIU/dM4dkWUdDI+RBqYrffLeYB/MaTxB4xh1/lJ2mk9UZlhnWCg95hP86rlZCfhqde+HdlYb3MZ2IN6oWEPrK9TEIUw094Rb26guiXh3oOZC3gP6lqvoSfUCofOsUqDe3peFogoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910128; c=relaxed/simple;
	bh=bNery69c0iKX/wsItQ9Jw9E2x5N8wDAy1y6rrlTnxAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWjhxkbJ4U7K4xT+iJIVhSxgilqT7BxuL36XRiMsWRd4Z4WwiRm8/AWMB2tvJ23LndsiE4kqgwHSU7usel16atc601X9hfahZyd9Y04Zdqz8iY8gkNFh5Z6zmF0jeKiW/AJK1ng2K9cksv+qj5Cw+QkFDw5Qsg84bUoyjvZNz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dy2WENu3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-634beb1a884so156365a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758910125; x=1759514925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8ZUoVYGkxtsuJxVT/vNYCs4iW+iTZPQ/ORTQlDYkQ4=;
        b=dy2WENu3xR3y9szfMnkEBr3ylc7zvqYYookj/8SiCD+KFIxW8dfK4Oh+b7VB3z5aud
         9JEQR2VdiSGNHLIKfJdZlevYyiReEkUNmE5pPkKQp9VdtUJb74pnG40i+iEZIfhDPTCf
         ttkzOyFCsxiPMPB2mv4fG+YkIpK5f2l6MoKNETRUVH/iOgmMjdeCPWhAqoPgmfmRiKDz
         739MPdGf2dzN7Q7O5KLP/9nxPd592n5iouEdMIAx3J9XNEa3M83AdcHAIznytlEGB9Wo
         bSV/M07XUrVi7DqE3S9L3MglgBfk0jz1SBxhkmdwprc9/ayokb2YLxdjV+WivYb4XcUE
         7lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758910125; x=1759514925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8ZUoVYGkxtsuJxVT/vNYCs4iW+iTZPQ/ORTQlDYkQ4=;
        b=gA6aRd5gYvEZ7RXmzBxYk5281eWMxTRAnd5KUGBlfX+e14ekcwtVlisajR865NQASa
         x9fY+PeEMxswXbV0PJhHVPpJRS/zhvX8rknUGC3o/JWzLJ/Ve3cKW92BaEG2uUHomed8
         hucE/B5PozM0n2vxgZyg7sURbtlluKtHgawS8gu1JqkCtPVzqXy8r0KA5ftpTDJScNH3
         ETl86QaT7bUlV4SwhWT3rMROXIcCOjyI1BVodsSE6JFcjZ3k4oU54sBr5tVzNDwCBTWe
         zbyvxonQQQ6cwAhRsLzgOMQLgDIA/X/n+69YusTxBAmgpY6NBMjIkTOkvrSL24vI/rqm
         JKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYe25WSd03sT+1a16uuOizRd7Ll3tdmVe2eSayuJqjHAQCKV3N2/kvsRMJAqWWfFkaK9DT6wvQnIK0acs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0pfdlr3qwPIiz+NNY+FrSVxtpXQmo+YFp44I0hxHqMdlDRS0
	obqZqQ8qRtuJmnrQ6hiU+XBEfBulMJ+f/KZeStAw3qakmRqBmp4C+3EfQ31XlLCd8SE=
X-Gm-Gg: ASbGncsguCVAGlPfyyMDgAtGHSMpjPrBIAHofu1kbhQwR0I6hdmeZwKp0JEHV8ixLC1
	NsVbEkkcP7JmNkdHvV/xqJLK+Py2YtG9plIpIPEvsvM6d1s6TZToP3kkd4eP8o8P962wAFF7okg
	THfTg9wDNZC9UECm36sQX1zen18gKNs4eOraegF8pTrCd+mQVD5BpdzWBr6fJfgjbB6SweE7dBD
	4slN4bIxGJZ0mg1ufVSeMrmip9mrrwO6LS3iM9F52xz511F3rkvHxp0nuhVVW+iSpgJFzZoqm5o
	631bBPcG71sk0Mpov+r0hkSaf5LT5tX9ZlZJrswDsNcjRQLWSuiKYfNberJY/0GL5Vm6EeGEDhC
	eL7duirJdVwa6u2ZJ5b6aMMPpLvp3H4mJ9tWL8MfCzfeoU5jfnkdidBj5i3iHqzGHGhLGimeJeO
	5sRlyvUFKHIY8HgA==
X-Google-Smtp-Source: AGHT+IE4jVGwCYI6ZVnYVxSIptfTujoHFppW4MAqE9DyEWtLc68C61ZW53cQq0aa1WzCP8CmllHxcw==
X-Received: by 2002:a17:907:9719:b0:b04:7d57:d3f4 with SMTP id a640c23a62f3a-b34beab0aecmr421189766b.7.1758910124864;
        Fri, 26 Sep 2025 11:08:44 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3544fcde4asm410415466b.76.2025.09.26.11.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 11:08:44 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter with early_param()
Date: Fri, 26 Sep 2025 20:01:02 +0200
Message-ID: <63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758906115.git.ptesarik@suse.com>
References: <cover.1758906115.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use early_param() to get the value of the tsx= command line parameter.
Although cmdline_find_option() works fine, the option is later reported
as unknown and passed to user space. The latter is not a real issue, but
the former is confusing and makes people wonder if the tsx= parameter had
any effect and double-check for typos unnecessarily.

The behavior changes slightly if "tsx" is given without any argument (which
is invalid syntax). Prior to this patch, the kernel logged an error message
and disabled TSX. With this patch, the parameter is ignored. The new
behavior is consistent with other parameters, e.g. "tsx_async_abort".

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/x86/kernel/cpu/tsx.c | 41 ++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 167dfd38b87a2..bb407331f64b5 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -20,14 +20,14 @@
 #define pr_fmt(fmt) "tsx: " fmt
 
 enum tsx_ctrl_states {
+	TSC_CTRL_UNSPECIFIED,
 	TSX_CTRL_ENABLE,
 	TSX_CTRL_DISABLE,
 	TSX_CTRL_RTM_ALWAYS_ABORT,
 	TSX_CTRL_NOT_SUPPORTED,
 };
 
-static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
-	TSX_CTRL_NOT_SUPPORTED;
+static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init;
 
 static void tsx_disable(void)
 {
@@ -164,11 +164,28 @@ static void tsx_dev_mode_disable(void)
 	}
 }
 
-void __init tsx_init(void)
+static int __init tsx_parse_cmdline(char *str)
 {
-	char arg[5] = {};
-	int ret;
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "on")) {
+		tsx_ctrl_state = TSX_CTRL_ENABLE;
+	} else if (!strcmp(str, "off")) {
+		tsx_ctrl_state = TSX_CTRL_DISABLE;
+	} else if (!strcmp(str, "auto")) {
+		tsx_ctrl_state = x86_get_tsx_auto_mode();
+	} else {
+		tsx_ctrl_state = TSX_CTRL_DISABLE;
+		pr_err("invalid option, defaulting to off\n");
+	}
 
+	return 0;
+}
+early_param("tsx", tsx_parse_cmdline);
+
+void __init tsx_init(void)
+{
 	tsx_dev_mode_disable();
 
 	/*
@@ -202,19 +219,7 @@ void __init tsx_init(void)
 		return;
 	}
 
-	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
-	if (ret >= 0) {
-		if (!strcmp(arg, "on")) {
-			tsx_ctrl_state = TSX_CTRL_ENABLE;
-		} else if (!strcmp(arg, "off")) {
-			tsx_ctrl_state = TSX_CTRL_DISABLE;
-		} else if (!strcmp(arg, "auto")) {
-			tsx_ctrl_state = x86_get_tsx_auto_mode();
-		} else {
-			tsx_ctrl_state = TSX_CTRL_DISABLE;
-			pr_err("invalid option, defaulting to off\n");
-		}
-	} else {
+	if (tsx_ctrl_state == TSC_CTRL_UNSPECIFIED) {
 		/* tsx= not provided */
 		if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO))
 			tsx_ctrl_state = x86_get_tsx_auto_mode();
-- 
2.50.1


