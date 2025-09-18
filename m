Return-Path: <linux-kernel+bounces-823568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC037B86DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0854625457
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE15D31C56E;
	Thu, 18 Sep 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq9oZLJY"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339C31CA62
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226326; cv=none; b=uOmTTm2f4BCGZ75H12D1degMbcc3xB0jf6MkUAy9r1Gl9mv/Uj+f2Z17dVQePogJibG4aqqTzBKdIsZIxZm4yPjtAyLrK6BY+prj/K73AowDxKNbVmI1cm2YXpPn1CUWOXIA6tG8/B9x2aib0Gnzh7S0hT0c0ZoHAWDOJt5uEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226326; c=relaxed/simple;
	bh=PvPtlt1c4VJyn8dLTiCc0gxKvb+VLZbvk3Y+VTRwjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKZcofevM7Lf7d/PPNxZIpH9OWHyhmMqB8kIxBlRq64QTsQtjdj8dxPde9iVhfLgfaCiXIVfgIblFafM2yr6KU8NNlvhbeoEfWPJ6ifbOzVHfJ7lxPxl9eKBR7PraYi3i/YyBQBlhtWXmWhEiISt4WIpf64E9NwNJHSW7/rYmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq9oZLJY; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-811ab6189cfso139340885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226323; x=1758831123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP02yHuvyiZWCyd9gSrmQ/IvvtpIZejTIOWn2O6TonY=;
        b=Oq9oZLJYyNyStlrlLeRCxVQ1FZyaM0MADesNu91TMEzQ3UKsC8hPVl0eEH/v6GTn7w
         gaLm3GrsJLHnYKnON7W1R18cqsMyYYFLa24vOMnXI972208ZNQWG6cu07GDs8Aln51V1
         QSi+MkP0r7Yv8+yY6qbx2xD9pDp8gTtp8lpGBMTG2g519BqCtO2pzxMEXzc7/qYifSlc
         hWVGmmZVFPmFiekxZ6fRzfVOnvgkS8jah15O9nJulhZy8hDzGUeP9zzDFOiLmly0ifMI
         BpTOXmLo7tSuC2jNoRgksHPvbQ3QEWPjw8whyxDxlDSGJ5XBHkl97GhgbEwl1krKKHzi
         8MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226323; x=1758831123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP02yHuvyiZWCyd9gSrmQ/IvvtpIZejTIOWn2O6TonY=;
        b=r/wszN1C90S6OHr1xYFBCC9kabsDyH+seMy7YSbSxo6yOhwVQJLHpwb0tN8u+cclmL
         e4M2SnvW3bs5o9OjrUPf8AJbJipum12J+vkWd2rDDbSmojqoNLcESKILyItuwiAU5OaA
         YFg+LRcTbjxG+JH0izZ9fpBIgfR/x/lJXqN4V5uE1JNXWhpt1+/Fo8ccrCvFNwTlRDlP
         AHgSJsfZdHVccbv8CUEL6F7h6cY3XLZBbs6nY6WFoYbwYIx9YG4ZnIHtIVuNGlm6k8yv
         XAnLJSA5j+riWJfSFdu3aGT3QORyXraexcYWu/1U63v7UNPx9//fEMFYUOxmzDkzkdD5
         jumA==
X-Forwarded-Encrypted: i=1; AJvYcCVKG5rZvpay5ho8g0PMqgtOmMdyk5x0hNa9jfnDHe/lCeVu861/aa2tnwUsRfwk9nswQ5BKW9C+U+G1JO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCM9pWiby2FhdesF1HVC0XDG4C8OaQSpugVClF4Bp2WVAuVOCP
	Z4PkmICKKu4UtyYdPzQiZLYxeA/Q2MNcoqdkBSyhO0sBiSI+He1mgnvU
X-Gm-Gg: ASbGncuHwyqByVETiHWecP0z2KCbCGU1qpbmCXAnpvkCuI//IdgxsVWvqxwHbVoF8Tu
	cwkePEsuovc4x6/BkoYzW0FHv7b6zLiBr+dJGfe9xC1rdKofuy7O95bpyXUn+zL2+rPe6NtFOSd
	geU1rP1TyerpXKF1yO/cmrgLRQVACJv996BUSZ9XVNkV3D5yxFFbmt1t7BsQtJW5a58z6pmMiBj
	Zz50G7uRStMFNc9DUO0hJqgnhoWjsPoXkhhL7xbzzVeRPIeTUyhz0eflTAVR8zbMR8vBF1qDYmA
	KMWL+GMVrzB7Btyy7Uy8+WLKWmsRwuRB5uH3cTnIiHLDD8UT9PCa1CXIfoUswuhk7yhRfB0Vie0
	bdzKFqaaLxDcr/uaiH4a5LgJGF19VNuU54+S0hpXWU7un
X-Google-Smtp-Source: AGHT+IHYupFZHDTKkw+QZ4v0Cz2P4eNnX3kBd8iRs0HvVEup+i6PcnJJH0MCFFeUfABRPeGNsKeS5Q==
X-Received: by 2002:a05:620a:1a8c:b0:80d:a8d5:9857 with SMTP id af79cd13be357-83bab74d395mr104333885a.43.1758226322335;
        Thu, 18 Sep 2025 13:12:02 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:12:01 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 5/6] module: store and complete idempotent upon force unloading
Date: Thu, 18 Sep 2025 16:11:14 -0400
Message-ID: <20250918201109.24620-12-julian.lagattuta@gmail.com>
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

Move idempotent definition up and add idempotent_complete declaration.

Add idempotent to struct load_info which gets passed into load_module
and then stored in the struct module.

run idempotent_complete after module is unloaded and give EBUSY
to any process waiting for the module to finish initializing
via finit_module.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/internal.h |  3 +++
 kernel/module/main.c     | 29 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 8d74b0a21c82..43f537475859 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -89,6 +89,9 @@ struct load_info {
 		unsigned int vers_ext_crc;
 		unsigned int vers_ext_name;
 	} index;
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	struct idempotent* idempotent;
+#endif
 };
 
 enum mod_license {
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 217185dbc3c1..256e30259bcf 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -80,6 +80,17 @@ static void do_free_init(struct work_struct *w);
 static DECLARE_WORK(init_free_wq, do_free_init);
 static LLIST_HEAD(init_free_list);
 
+
+struct idempotent {
+	const void *cookie;
+	struct hlist_node entry;
+	struct completion complete;
+	int ret;
+};
+
+static int idempotent_complete(struct idempotent *u, int ret);
+
+
 struct mod_tree_root mod_tree __cacheline_aligned = {
 	.addr_min = -1UL,
 };
@@ -784,7 +795,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 		!IS_ENABLED(CONFIG_MODULE_FORCE_UNLOAD))
 	) {
 		if (mod->state == MODULE_STATE_GOING)
-		pr_debug("%s already dying\n", mod->name);
+			pr_debug("%s already dying\n", mod->name);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -833,6 +844,11 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	strscpy(last_unloaded_module.name, mod->name);
 	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false));
 
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	if (did_init_crash && mod->idempotent)
+		idempotent_complete(mod->idempotent, -EBUSY);
+#endif
+
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
 	wake_up_all(&module_wq);
@@ -3591,12 +3607,6 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	return load_module(&info, uargs, 0);
 }
 
-struct idempotent {
-	const void *cookie;
-	struct hlist_node entry;
-	struct completion complete;
-	int ret;
-};
 
 #define IDEM_HASH_BITS 8
 static struct hlist_head idem_hash[1 << IDEM_HASH_BITS];
@@ -3683,7 +3693,7 @@ static int idempotent_wait_for_completion(struct idempotent *u)
 	return ret;
 }
 
-static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
+static int init_module_from_file(struct file *f, const char __user * uargs, int flags, struct idempotent *idempotent __maybe_unused)
 {
 	struct load_info info = { };
 	void *buf = NULL;
@@ -3707,6 +3717,9 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 		info.hdr = buf;
 		info.len = len;
 	}
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	info.idempotent = idempotent;
+#endif
 
 	return load_module(&info, uargs, flags);
 }
-- 
2.45.2


