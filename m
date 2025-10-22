Return-Path: <linux-kernel+bounces-864718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E074ABFB66D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 032B2505DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90957322523;
	Wed, 22 Oct 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BYUbqMPz"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710C302758
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128785; cv=none; b=pivhch50tM7+Kac7belDI+TNiXQWLhvHdUfrax9Zut3KT3p5MUE8ug/m+VMGN4/ds3Vl14jYaj7wUv4XxUuQ+5CAqBcOjJ9G/s/N6DV9PBzpx0sCnEr16Vzm2tWFC/Gc29xjSi4UDv+xc0y7h79thHQked5AIDHa/ZAKwhdIrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128785; c=relaxed/simple;
	bh=LJKvQlO1JKRgqIri3HXOPvxnjeCAUBpyx+exelD25/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIoiCzVM2fSGJVe/Vt0IyXoZRi+/DSoYfpdjcEvg7sQO33jwzE8Z5X0Qa4y44VQxsEEZAKBXP+9qoL1H4Oa/tTXZAKmsUi3n76NJirPHtk8N2i57yCZwHh9/AkQS5AIwrZW8W2u1quh8WpQCD5LeQ7nvtm+6jUOxVfoECTSFdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BYUbqMPz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-427054641f0so1014313f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761128781; x=1761733581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0+NFyO70aW3IyTtS3oW3FWhS3qqp4kM2Z7rpvvD9UQ=;
        b=BYUbqMPzY7LjSmXgz0Esg9rSzhN3Y8IgivF3seV3LlDIb+/hNVe7a1LjH3RYF7ZZkr
         Ws7JQkUYTkuswzN6aaQdhVtiksinFeY60gUcmzs3wd9dknk+JpaBZxOFofO9x0pi7Gc7
         OMu6iEMe8ohUpHfBDJefB/vDFKEAFPfQeWBOwk18G4Z0WRA9gGpxhLGJFfCA1BcSy0m3
         3b0ZvGSHUqo3s2hPzJFomcrjZgtXM+wsKyIDZhMU/8q4/3LvDlOJC8VnBbfLGeSXsMu0
         Jl7xOnMICzuQVlWl43QX4ZR/daO5cRuuJhY17iJS96hD5yAOJymD/jpz0rb/sHm2RZ9M
         R9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128781; x=1761733581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0+NFyO70aW3IyTtS3oW3FWhS3qqp4kM2Z7rpvvD9UQ=;
        b=ZvPv4l1Q/CbSFMWjwnSsQUsP7xyHtCbObsR0+Hiv+oiVRSwaqXnzo6fYTK0gZtvepk
         GpEw4bEi0WaoJ7oyzfy7EBcPXyp1O/bfiStkKVuad1JTQw/CvYGx0PNO5pbRZSPMcSx3
         Cs7ltETP8RWZhW+xXqfc+mKt54/McuNtjuADRnww7F/V/fI5IntmRQaUviDQJQroYdHM
         jAjoTdUwqT/WoUpC0bZ2WQh5+ZoInOFAXG0Zve8mzxjQuwoOqag+cIJ93JaN2i7rs1a2
         RSxTvDn3b/FRvw7hXcU8zCky8fnFctfzVQXfyzUm/IsfRKEEEAaK1uvN58hTopd+8H4v
         JU5w==
X-Forwarded-Encrypted: i=1; AJvYcCWxAkGYUHkjOREv+e17mggKsOs+Ht5dfARkeiJev7Giuv8EAMpPyuCffrQOu9BLyNcjY8Uc/+H0i8mXjQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNa4I0OSHGa22VmBP6cRwQcbwFgeVA7bstQ2OwNjZkydDOdS/
	qW2rPjGbcre8Iz5rjDRfYgudS5PaghPTzU4nu6gdfrtm9Who666dp8gzrN3gWX+oBEo=
X-Gm-Gg: ASbGnct1ywX/uZ1Z1y3WKYFw94gXh212PjeozFLO0czxn8A8fH7mQ13LnAF4z3EyYne
	ICO52a6i6ULujBdn0FLEV4bk97gE/u0s2DDasPKznZfeG1buMwim2OPCe7nyvDsEzpSPqtHTMZb
	CvdlLKiBq5RHxzzyemd6PIJsmB4HIvtEXxuQpaWN2OhMoSfRW0OkCMk4pcEsgvT3EleTVZNGUEJ
	zfrG49ZP3QDSx/Id0zbUeoKrPT7oYiratl6sHRBFl5ZkzlFa2FvUO8+UQsQzrugwH7gdTP8uHQF
	As7a/GLO9lnQ8+5ia4l/z63s+MMAHXs9C7BVwb588/odURvOGeOBzAfji5Qz5Jq1bUUgdjtlgr0
	XFh1gkKFi3IPYLrGuCJTdVPc+pKBC8snS21RkY+tciVCIubNQ+o29URfrQzyiaZZaYDjy+GDZfu
	WyBILoJuGVdH04Hcdr3GQmglCDL0F3x0Ll231kXCri7P+KF2x0ylmA/vwUeVXQgBnKxrjooYm6R
	PqOKA==
X-Google-Smtp-Source: AGHT+IHs2EnQix9FDBg6T0LZQ5dytX6mZucqCm8N+9Iw8qechqpBxU9FVxrNOtxIxkuX+LHiwrOnQg==
X-Received: by 2002:a05:600c:4ec6:b0:471:c72:c805 with SMTP id 5b1f17b1804b1-474942ee517mr26066165e9.4.1761128780625;
        Wed, 22 Oct 2025 03:26:20 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47496d23237sm33646605e9.10.2025.10.22.03.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:26:20 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v3 2/2] x86/tsx: Get the tsx= command line parameter with early_param()
Date: Wed, 22 Oct 2025 12:26:13 +0200
Message-ID: <befa0b859777267a11c90aebde6a3bedce276b90.1761127696.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761127696.git.ptesarik@suse.com>
References: <cover.1761127696.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use early_param() to get the value of the tsx= command line parameter. It
is an early parameter, because it must be parsed before tsx_init(), which
is called long before kernel_init(), where normal parameters are parsed.

Although cmdline_find_option() from tsx_init() works fine, the option is
later reported as unknown and passed to user space. The latter is not a
real issue, but the former is confusing and makes people wonder if the tsx=
parameter had any effect and double-check for typos unnecessarily.

The behavior changes slightly if "tsx" is given without any argument (which
is invalid syntax). Prior to this patch, the kernel logged an error message
and disabled TSX. With this patch, the kernel still issues a warning
(Malformed early option 'tsx'), but TSX state is unchanged. The new
behavior is consistent with other parameters, e.g. "tsx_async_abort".

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/x86/kernel/cpu/tsx.c | 52 ++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 8be08ece2214..74ba4abac7e9 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -20,13 +20,17 @@
 #define pr_fmt(fmt) "tsx: " fmt
 
 enum tsx_ctrl_states {
+	TSX_CTRL_AUTO,
 	TSX_CTRL_ENABLE,
 	TSX_CTRL_DISABLE,
 	TSX_CTRL_RTM_ALWAYS_ABORT,
 	TSX_CTRL_NOT_SUPPORTED,
 };
 
-static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
+static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
+	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO :
+	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF) ? TSX_CTRL_DISABLE :
+	TSX_CTRL_ENABLE;
 
 static void tsx_disable(void)
 {
@@ -163,11 +167,28 @@ static void tsx_dev_mode_disable(void)
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
+		tsx_ctrl_state = TSX_CTRL_AUTO;
+	} else {
+		tsx_ctrl_state = TSX_CTRL_DISABLE;
+		pr_err("invalid option, defaulting to off\n");
+	}
+
+	return 0;
+}
+early_param("tsx", tsx_parse_cmdline);
 
+void __init tsx_init(void)
+{
 	tsx_dev_mode_disable();
 
 	/*
@@ -201,27 +222,8 @@ void __init tsx_init(void)
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
-		/* tsx= not provided */
-		if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO))
-			tsx_ctrl_state = x86_get_tsx_auto_mode();
-		else if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF))
-			tsx_ctrl_state = TSX_CTRL_DISABLE;
-		else
-			tsx_ctrl_state = TSX_CTRL_ENABLE;
-	}
+	if (tsx_ctrl_state == TSX_CTRL_AUTO)
+		tsx_ctrl_state = x86_get_tsx_auto_mode();
 
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE) {
 		tsx_disable();
-- 
2.51.0


