Return-Path: <linux-kernel+bounces-823566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F16B86DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298F5564A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6131C596;
	Thu, 18 Sep 2025 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz6ACzkx"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962BC31BC86
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226316; cv=none; b=e5bUtkboV6xmJKB9IrKYk6byxD7B2STuKrvgYC7CR7n2zVrAR7hAAK4Dz28JzkoMJDhi35obb0r2iYJzACcxlMItwbmZrEiISNqObF9glJ9BjLvd/wAEqHjw9dICjIRdvibNRcdNMPkUWnBRHeJWJd0yJp7e+Bg1GE8dccptd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226316; c=relaxed/simple;
	bh=siBuLk9zH13tO8g4aEZ+ghf0JyGMCIvgX+eqmUGKzyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEFVVUIt7b4phme73NnrKX1bEbHH+ZaRu6ouXyUns8PIYfZienSa0V+N1frDSnpqsl5XIyHlkQBrxkMEdyuQFieZQsisVkG+H9uQa06XogLW/ll9v4aI5jkNRO6Ct8CzTzJGIL7Sd3iNSpUODERhU9XD0kPZVGPbJ2ebvaJo65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz6ACzkx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-807e414bf03so169491785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226313; x=1758831113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkokmLK2YiSj3gWXRJKv9HJ55buXfb9b0NJavRjgMIM=;
        b=hz6ACzkx4smi0DRDlJTI7dRtumrJDaeUm7Vbiix4KsvYmQQ8Dw9oLqUS7vg2r8HZhy
         h1AnxnADb9AaM6TYPQUq1WHeqBfpcJtDZiKeTPRif9MTUB92opADdp4g8itlk2g2chgr
         LAvFRT/C7lS0d2uirYtZhj+xDMmMshWcmua9tL6Z2ZpXyY0KA5iwMvajI1jYDxsx/TPm
         53+cJYlXqLE8aSwmDelCWlqdFZecTdWd7oktQBYz28pwKJcHteHcN1/J0INQhMdUXLXV
         zqKjonYUmszPHzz4Yjo9wL9TLdBURTFY+LjTiTzHgj1WZfW4Ga8b3pRLifRBTcm4csQC
         BhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226313; x=1758831113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkokmLK2YiSj3gWXRJKv9HJ55buXfb9b0NJavRjgMIM=;
        b=SBiT5ZcGKXQ8kNnU2RJA2DAcHBFY7/KKWqxXDVYcvTm4KEP/jR9fQRAS3UTnz6BRyG
         GccPT0oeKBsiC2C6JBUv3fKPKHUeSQAxSFEWRio2uy3TFWUcEylsCnS6HvMN9tG+PYUO
         xyt7tG+dC7WMnAKyzpito/xfsw52dzVJG3ab3PVL+C6dU0IGAQrHI3RDxmN2ru+EmvHJ
         5rrPp7L2WFpmz0DsYsA9fhX4sX0IoaFQB3/iuWd83pmTYAFP6tpl2dVFMRZguKmFKJw9
         bQDdj2XZqXEy1/emDDkl4MKPlDcWqVrzKiz/xvbGCTGKqIhwLOJnyXGTf7BAgmw0YKuM
         0pcA==
X-Forwarded-Encrypted: i=1; AJvYcCV8kAV20A7g6USQ2ZmWRMyHhHXzPi1THQXo5Rna9DD3xljgz4q8JwX7M+stzpCAil3ZpjDa4F9953ceoFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmSQhU79kmMCE8lDRD6YPEi/nGN5UPhdz5IyuE/3ko61mWZv2
	ksG7SSmirsMKo/xkwCD+jbvMRnzI57/DK10BjSq27h2t4E4MmCakTqco
X-Gm-Gg: ASbGncubrQaMMIMeZFU+2wbZ+NQtamK8+IBf9jRIYSH2u3LbF18ECfgLHtB382K+Eep
	+Zx7OQzTV04jrNTogsJfuBUOw0MKUns/HBOrxmT9h7ZOfLlnx/paIDsKwuYBEW3oD9uiX+fX9Wh
	zNqsILZUOYswOuuhHFMtWDvMPfErAQmFjTToKt4MK4kajvX+kUKoMN3geOUoWA67jUmLBy+sE89
	w5LEgFuxguHhcnwVsmVEEhF3RR7HSGls8HCHf/UFBr5RkVGAzWy/C2JPTOb5YSbjoiTW5MvIcdS
	9fM6V4qYha2Xp2cgTqi6JAe5T7kAWIASADVa629oHg0kDlqjWWQumTRsre8b5geWkMofHddWif5
	R0A9jXBnYVC45Jldvo/EKrPbhFkL0WpPFjL4ue3hui12P
X-Google-Smtp-Source: AGHT+IFiZ8Cmf7lfrKrgivPhlQMvgZpgNrmFHwpmbuo6oJXmpmGCmmDQeFJT+qUdMU9Hw5uXjfq0ng==
X-Received: by 2002:a05:620a:4d52:b0:801:eb0:c0d9 with SMTP id af79cd13be357-83ba371e8cemr92937585a.32.1758226313542;
        Thu, 18 Sep 2025 13:11:53 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:52 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 3/6] module: move freeinit allocation to avoid memory leak
Date: Thu, 18 Sep 2025 16:11:10 -0400
Message-ID: <20250918201109.24620-8-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move freeinit allocation after do_one_initcall in case do_one_initcall crashes.
Otherwise, freeinit would leak memory after every initalization of a crashed module.
I could not find a reason for why freeinit allocation happened before do_one_initcall.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2277c53aef2e..2825ac177c62 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3021,21 +3021,13 @@ static noinline int do_init_module(struct module *mod)
 	}
 #endif
 
-	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
-	if (!freeinit) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-	freeinit->init_text = mod->mem[MOD_INIT_TEXT].base;
-	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
-	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
 
 	do_mod_ctors(mod);
 	/* Start the module */
 	if (mod->init != NULL)
 		ret = do_one_initcall(mod->init);
 	if (ret < 0) {
-		goto fail_free_freeinit;
+		goto fail;
 	}
 	if (ret > 0) {
 		pr_warn("%s: '%s'->init suspiciously returned %d, it should "
@@ -3045,6 +3037,14 @@ static noinline int do_init_module(struct module *mod)
 		dump_stack();
 	}
 
+	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
+	if (!freeinit) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	freeinit->init_text = mod->mem[MOD_INIT_TEXT].base;
+	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
+	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
 	/* Now it's a first class citizen! */
 	mod->state = MODULE_STATE_LIVE;
 	blocking_notifier_call_chain(&module_notify_list,
@@ -3123,8 +3123,6 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
-fail_free_freeinit:
-	kfree(freeinit);
 fail:
 	/* Try to protect us from buggy refcounters. */
 	mod->state = MODULE_STATE_GOING;
-- 
2.45.2


