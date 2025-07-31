Return-Path: <linux-kernel+bounces-751800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93111B16DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA123BA8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9F829E11E;
	Thu, 31 Jul 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gyu0ejsD"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73893597E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950899; cv=none; b=kllSOxglFOhytmVE/keB+viWGfbaFqzTCxYJvEXAjWrcE//eE8zT79+OVqJx6nv8jX/mV2OtwjOG80+/ZVUCb3oCl1Lm8QjXRWFMjkeFBeYIOISmMn+YXwA+AFFULLK7H6m0E6P/ayTWWLLh8mm1uvjNQQYpvYvh0teIXnaD1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950899; c=relaxed/simple;
	bh=eyCrxSFIXm6saDbn2aU9bjSZAbRV4PHYbWnaUh8l8tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBOpmhIHzU08wJZuQDxw2SQpV9jRP5snozsAJmeXzfDGIZuKR7DfIqkLPxTQYY+qPu0UAYz5No20F5jvw4X2su8PfWbIXvs3hKK4+t/zsEkzUyH84Dt6Xze3DOUtpJw+UgJUfldYZOT3UasVW7RryBoy1KrmN1V1YKisVbQOLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gyu0ejsD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b784493b7aso9172f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753950895; x=1754555695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbhycUfCO1PwaXZKIGI/Y3HAn2GmNIZ0D09WoBs1Dyg=;
        b=gyu0ejsDBXUdwP7iPNJeaICWh9YrJBYS6ZGhHClJVCVH67/0faSETgKcCDcmEun7xQ
         lf7VUJXNsazOmneH9LPvfi2MCGejbR0m7U6gPFiOzDZdHO6wwb3cXKEglcqOjGkFahh4
         GuqJ7/a90iPFUpAnaWALBkJUPwd5O9SEb9AMJCA2WVN9vW/O9RRqs2dGcJoPNtxLOlnw
         +UOI2TWD7DjR0dRisj2hX7R/4cLm7toyUR1skApJGwKIOqVp7Sot/LNnKxfhaRuBYWmA
         uEx2oQSNcQ6/WbS4nviR5/d0OBghyg8+tWnh23ljH7fOtLDiLTuvX5oMO1cm4e996Vcg
         sJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753950895; x=1754555695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbhycUfCO1PwaXZKIGI/Y3HAn2GmNIZ0D09WoBs1Dyg=;
        b=P4Lta1M+0Eji0K7THDZlEXJXU6ipVwhJO1edRdPaARwogSQLPgg1WXwGT9U49f5MCB
         QSbq9vQHZnlCm/3FkKN/9Lr8NdvEdC9ra7AVmsEwL0koeJv04cMj3h3DAfH6geiVx+3F
         GhTEJUvBL+07SUSiSFxDlJaM9Zbfj18NdDuxr6WF3a64HKKIE76wiTIy4VFZs2JEwlPM
         ae1iOMw0St1gJtWvqdEd/+a6spFnwck94uu6slMEq/XCewFqQ88Vm/26zv6jeD+HkMAg
         2R1Fe5v/RHa+De1MPMhkc3zbw5z2NcFrY9sciaKYvAh7z3SneUK1cYiP2IJMDzLsyBIu
         NKiA==
X-Forwarded-Encrypted: i=1; AJvYcCWCsWs3Om4vyzntJsv+zRM0ziLRPj1okyEMM+p7o3H1m+iftkZ0wY7gsmbWJQSAKbeIMb+v4B8OsIPiqq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiC/zkDYnH8PW+zxDfB/g3ol5dRERdgHV8StgaC7MFeoWr4YFZ
	vQPl4x0af2rRQ5U7CE5TtvPDYa/tK8I24UVOI6/gcPU+POSz36cb78m0EisfDeaZsH8=
X-Gm-Gg: ASbGnctUDcePQv20mr34JLzAXTJUjIq61Gpn3dqgyB+qMYXKWcwkyHrNma1OIfwdSy+
	0GwHwT/Ui4LbV/tD7cqGTREojJd44/xI82MY+y3YM8UPX4Mn+WYiJsowx86PGIKVTPn2+8NyDEB
	Q3eIVXK5LBAQMdhSgBw2rHo76eU/4nTNERzf/Zn8wmamAHqJ2qZzGAKnhVu2COsHob4d0MlPDPZ
	2M2AkLmrV/EsqspMsMZ8pK3ZjN1H7l6lrsfJyh1FI+k+1+poT+n5eWt0Mb0w0aUEX7ELFPZSRlc
	Udi4Ee6yDZnltHsm9BrSky0fe+xycs0h/VfWtQ/Iqxcc50TLeB1/OdiOWuy6nZ+TcRQjK7DfYIc
	PYFpWhvFlE7ugSmlHlqdg43+bzx7HAyBexoQDwoMXRnbF7sry56WIaY7Ano8PDHUoMM9y2FQ3nN
	9lqMdEjwajYiEw
X-Google-Smtp-Source: AGHT+IFczC7y6SDDxpSaD7RKQ62R2/QhGdxb0EhV/NPMGFkZUnCw87JBU02Aawl2Xve7MAHKubXo0Q==
X-Received: by 2002:a05:6000:22c2:b0:3a6:ed68:cef9 with SMTP id ffacd0b85a97d-3b794fb61fbmr1821212f8f.3.1753950894761;
        Thu, 31 Jul 2025 01:34:54 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abebdsm1600046f8f.13.2025.07.31.01.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:34:54 -0700 (PDT)
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
Subject: [PATCH] x86/tsx: Get the tsx= command line parameter with core_param()
Date: Thu, 31 Jul 2025 10:34:33 +0200
Message-ID: <20250731083433.3173437-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use core_param() to get the value of the tsx= command line parameter.
Although cmdline_find_option() works fine, the option is reported as
unknown and passed to user space. The latter is not a real issue, but
the former is confusing and makes people wonder if the tsx= parameter
had any effect and double-check for typos unnecessarily.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/x86/kernel/cpu/tsx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 49782724a943..03e1f28cf9ec 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -156,11 +156,11 @@ static void tsx_dev_mode_disable(void)
 	}
 }
 
+static char *tsx_cmdline_param __initdata;
+core_param(tsx, tsx_cmdline_param, charp, 0);
+
 void __init tsx_init(void)
 {
-	char arg[5] = {};
-	int ret;
-
 	tsx_dev_mode_disable();
 
 	/*
@@ -194,13 +194,12 @@ void __init tsx_init(void)
 		return;
 	}
 
-	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
-	if (ret >= 0) {
-		if (!strcmp(arg, "on")) {
+	if (tsx_cmdline_param) {
+		if (!strcmp(tsx_cmdline_param, "on")) {
 			tsx_ctrl_state = TSX_CTRL_ENABLE;
-		} else if (!strcmp(arg, "off")) {
+		} else if (!strcmp(tsx_cmdline_param, "off")) {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
-		} else if (!strcmp(arg, "auto")) {
+		} else if (!strcmp(tsx_cmdline_param, "auto")) {
 			tsx_ctrl_state = x86_get_tsx_auto_mode();
 		} else {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
-- 
2.49.0


