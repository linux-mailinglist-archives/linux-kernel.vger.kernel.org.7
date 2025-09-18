Return-Path: <linux-kernel+bounces-791628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D9B3B973
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFB0684326
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0635314B6A;
	Fri, 29 Aug 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YeOPd/bn"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E423112A9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464880; cv=none; b=qabLQ4SaDd3KKpvFeM5c87p0/q3iT9e7Cxg28Jf+0Zldk+DpSpVK7Gu5rmZ0sYxn4hAXoM/7ghEzE94KiHQ9nMOJj6Gdp2WOgKzpsd9weS3Qi91iFDcsDrdmeLNIipSxl69dCB59MNjdu5dc4nQTpz1Bs5TmqQp8+cdSXUnV0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464880; c=relaxed/simple;
	bh=imJbMT1QRWT0N70p1sPsm04UPKbsXzV1SUOttMAC/bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EDtFPUTzeeNk4vqPctBhTIoyJidB6ZDVaLjuBJBP2wkWpJ9IBdh2/7et2agTVE378XC7Wv8ORgFurlIU4ZkqGCuUTNFpYsjzapZe0QG3y3y6j2arGCO1S4dB265QYnSQ/31AjF2rG6p4TGONqsCkQV3d5xmveP9as8Ju4LPfMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YeOPd/bn; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3cef6debe96so587198f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464876; x=1757069676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRmzACq1z8KPxODlF7nAhbs9Rjd/H78CaV52MZqNfYI=;
        b=YeOPd/bnNG3aYhywq63bredqrXVjP+5A/WcoxKBikFfc8Ac/efHccCGdRPueDSpW4Z
         i/TWNhOeX0BKD/7X11X/IE1UZgQTSEH0/i75vRL2/m2NIKNFeWEoj3KHa/okPjxqkekU
         UKTIkIlN3WUZigGrhzu5byrMC3hqsDoUHahb+Gbo/WiitzNWqYFMG+XLqZ0eJhImro0u
         kc+iAovY+A/gE6sZROJ9gGnV71pC7Ek8W8l3ELYGUdztByeziJtkfBQhHzkjQmifShnT
         DUC2ulBHxd58TGHpDi6f/AXwG152tNnlTOfhSQ1+Ii8LwKXHoqqxrAUQx3X9pKpzLCU3
         CGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464876; x=1757069676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRmzACq1z8KPxODlF7nAhbs9Rjd/H78CaV52MZqNfYI=;
        b=eZGTIY3+m8pgZH9P+pFkfkJRBvrugUPkGpT5qgc/JuOsDiXmkt+V5RlaY3y+mBVORD
         LVGW0JWuwd/vl3c5Y/cMUeDuwztKrN1WyGYVjgDEQksexwrz/DheNnY19CEkTYtT/xok
         KTdgwGlqDb91UP8VVr7Yh6Io3+yxzHyS0UukwvfTVd/taxIADH6qyKx2m8jz/3JR6Y6C
         mn86MpKBVh9ajBVQfUKtEPYpcbs8qjMXYFdYumIkmI3A/+8Xpyas359VBsrGTWOCCgNP
         4PXwHed+5DSo0mx8N6GG6RvMJK+vFQbf0WHbjJbVdFDClH61WHmTvf8K3Pz8oYCmnwFw
         nWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/+PS/K4nc6BkRT9LdVrLSyrE3vHeJKp7LPm3sJkyGQ4P6XMhg2j1FctQ6ggHqGOKnEg7oBadFqfACMSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTC3DHnPl4CTg0cfjm1T6J8FNIhNO/StsdWNhUsUJiAJ3Goc8
	YmZBJuQPcKNCCxQ03nrH/M+S5xD5jBsnlZTlGNQiKTyd+/juwQTaJzlfL8FxibrEKDC8S9VbLsv
	qoqlwGF9M4StcKNsf4w==
X-Google-Smtp-Source: AGHT+IE/FPwm3swQP/F9rqEn9qUM4c1z0MoJ8Gfln+SOie1DHcd6K8k4m5uj+Rt2dtpNsRpFAo5lHoh24WYIjy4=
X-Received: from wrbfu1.prod.google.com ([2002:a05:6000:25e1:b0:3ce:f7b7:be8d])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2087:b0:3c7:84b4:e76 with SMTP id ffacd0b85a97d-3c784b41ab7mr17512777f8f.25.1756464876207;
 Fri, 29 Aug 2025 03:54:36 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:15 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-8-sidnayyar@google.com>
Subject: [PATCH 07/10] linker: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

These sections are not used anymore and can be removed from vmlinux and
modules.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/asm-generic/vmlinux.lds.h | 18 ++----------------
 scripts/module.lds.S              |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 310e2de56211..6490b93d23b1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -490,34 +490,20 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 									\
 	PRINTK_INDEX							\
 									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol table */					\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
 		__stop___ksymtab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
-		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		__stop___ksymtab_gpl = .;				\
-	}								\
-									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol CRC table */					\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
 		__stop___kcrctab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
-		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		__stop___kcrctab_gpl = .;				\
-	}								\
-									\
 	/* Kernel symbol flags table */					\
 	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
 		__start___kflagstab = .;				\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 9a8a3b6d1569..1841a43d8771 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -20,9 +20,7 @@ SECTIONS {
 	}
 
 	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
-- 
2.51.0.338.gd7d06c2dae-goog


