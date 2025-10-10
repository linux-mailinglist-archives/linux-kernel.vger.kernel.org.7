Return-Path: <linux-kernel+bounces-847939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05506BCC1AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7687340089E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4F025A355;
	Fri, 10 Oct 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT83sC7q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604381991D2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084512; cv=none; b=m4qUpdslW5JJ8q+5sIwGHraU7YdRyXEF7XQFjDRUtUkBSlDT0v+cYyi0lq0hibeiRLI430Uw4Z9kNnb+VTIjZiTrCFXQg5+rKP5AWKk+zrSmvJSy5+a408xDqe+lld4dDrJEpchNy54A+6y8BzPoX2jWhzP1DgZNgivvULVMM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084512; c=relaxed/simple;
	bh=7n9x7QTrcndxlg+tUsPE5c3XWRfvOWdk/79MKsk4w/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8KpmAoW+grMnEBXyY7/aAthNhqX8X7/FT88TujNJmC/62I/Ae1rUWrj/p34bQRDOQmJQltfWFV9Y/Yl8QZdgst6zw828ymwOZ52HJxla6E3JK+Ym9D1xJciVOJsLsFtsiHQ0Gsg2/H3432BixR+tK1Xljps2xstFOvY5ZiUHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fT83sC7q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760084510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NbJMedQSgMeF1x17YjO/qLNJsjbtU/nMqdfEt6aFy9Y=;
	b=fT83sC7qfprHfSWfOXOq6+OFL6RHzMj3zaci1BilPkgdNn8TuTibsiAzdxwbjU+OcoTchS
	S+moi0TGcILIgbOeH3WiMSKiLJgjmQmRJb6QJWaSts9iQamxF7fbGkLpTNfZTN50HcglfY
	F+xS7a8rbHWTVieD6lFbtTUNUnwunDE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-rX06GibNMPuzkavQyAoL_Q-1; Fri, 10 Oct 2025 04:21:44 -0400
X-MC-Unique: rX06GibNMPuzkavQyAoL_Q-1
X-Mimecast-MFC-AGG-ID: rX06GibNMPuzkavQyAoL_Q_1760084503
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f93db57449so1115411f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760084503; x=1760689303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbJMedQSgMeF1x17YjO/qLNJsjbtU/nMqdfEt6aFy9Y=;
        b=a6DU6WWubCJg/8LWo0utpTdmonMWPW2zgrfjGtt+fvDzdxeAQxRlvp+3J6PEdRV2Mf
         XQxOGtOpbRipWfReVa3MSnldzauOPh8OshrWMQmS71EsAdy+WApatFEvZv7/tj05rRPt
         r+V+dNfW612Tu+OVzerdkCsl3V5nNyrahqdIEoJ/CG6L1pWMujKIZBGfD8xMIuVD92X6
         zw7y7ayrJ2WxMku7kjCffc6x0ErpzqvtuzEp7m2vdfqu1IESYcvcFa2W4hAaaF2P1l+p
         IUtpuQex0SWUs+UtNRXaf+ZuqdM4aSUj8SuFLL+azD6SSMRgmRa46NWv0uTKjldRKN5s
         C2eA==
X-Forwarded-Encrypted: i=1; AJvYcCWLiQhtMLqY30A/2SN2Mf1e2Fz4ZVjUG+UZVop4tl+ttTYQyE8SvbLE0l0FHcLcR2unRim8OJX6KxJSCx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOVbcwGUNwns9ztCYfSFWibPytVWnXzdyv4ZxYmKW2R9J70DN
	M9RJKEI1IZDQYLGLWgMtGS5uvbKV0xJ3qyKuVhcNWfGamoZE7zgmqW3dKx1gcoO4Uq8z364HUiY
	YxR5PXCfBkCWwF4mpmoYGQ9n/Q9QFgiq31sG1sNul+EwPcOy9xA7tefLp431HF4QDMQ==
X-Gm-Gg: ASbGncvjc/tYPcQ+WGjFemono6V8cQRLZqWKv3bDLmb9fstMdzThWzT0NTBC5acrr1j
	bIuln1EkHuBz20HsRRP/3lZ0XOZ2btbQe/5YNemjs4Gx/dm9c8ECwKTTZ7EtSyLpgqfkZoNb7VV
	VGjUPla6rFH3rJQ2iEG0BREbXtsLk7EN6JGxPpmDvSICVrwMm6v0lzMw8Lc4yalTqz1QErsjzfK
	T06GOXIP1GA+fLkFm4BB/gb2hyrZ5D9oieQbOTQdCMGTING/KpI/Lr3bE39nycy9Z2VENwMVxGS
	sM+N2LLDsalrpMj6J5RynQGIULkOgsBxPNVozFMA1NPbNAC6gAAsH4icKnctQ7FTfQdCFxoVXX7
	8yce0Bhw0S4d9BA==
X-Received: by 2002:a05:6000:2910:b0:405:3028:1bf2 with SMTP id ffacd0b85a97d-4266e8db2abmr6017879f8f.62.1760084502779;
        Fri, 10 Oct 2025 01:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtaiyaP4ciHOEVEUj0fw2KNuY3ZMQkjybKrv/92syV0a+JBFL/CPIzPSOnaTNXUhiK7HidDA==
X-Received: by 2002:a05:6000:2910:b0:405:3028:1bf2 with SMTP id ffacd0b85a97d-4266e8db2abmr6017864f8f.62.1760084502351;
        Fri, 10 Oct 2025 01:21:42 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583424sm2946970f8f.21.2025.10.10.01.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 01:21:41 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] treewide: drop outdated compiler version remarks in Kconfig help texts
Date: Fri, 10 Oct 2025 10:21:38 +0200
Message-ID: <20251010082138.185752-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

As of writing, Documentation/Changes states the minimal versions of GNU C
being 8.1, Clang being 15.0.0 and binutils being 2.30. A few Kconfig help
texts are pointing out that specific GCC and Clang versions are needed, but
by now, those pointers to versions, such later than 4.0, later than 4.4, or
clang later than 5.0, are obsolete and unlikely to be found by users
configuring their kernel builds anyway.

Drop these outdated remarks in Kconfig help texts referring to older
compiler and binutils versions. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
Andrew, please pick this quick tree-wide help text clean-up patch.
Thanks.

 arch/Kconfig      | 19 ++++++++-----------
 arch/arm/Kconfig  |  2 --
 lib/Kconfig.debug |  3 +--
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 74ff01133532..602ede49daf9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -232,17 +232,14 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 config ARCH_USE_BUILTIN_BSWAP
 	bool
 	help
-	  Modern versions of GCC (since 4.4) have builtin functions
-	  for handling byte-swapping. Using these, instead of the old
-	  inline assembler that the architecture code provides in the
-	  __arch_bswapXX() macros, allows the compiler to see what's
-	  happening and offers more opportunity for optimisation. In
-	  particular, the compiler will be able to combine the byteswap
-	  with a nearby load or store and use load-and-swap or
-	  store-and-swap instructions if the architecture has them. It
-	  should almost *never* result in code which is worse than the
-	  hand-coded assembler in <asm/swab.h>.  But just in case it
-	  does, the use of the builtins is optional.
+	  GCC and Clang have builtin functions for handling byte-swapping.
+	  Using these allows the compiler to see what's happening and
+	  offers more opportunity for optimisation. In particular, the
+	  compiler will be able to combine the byteswap with a nearby load
+	  or store and use load-and-swap or store-and-swap instructions if
+	  the architecture has them. It should almost *never* result in code
+	  which is worse than the hand-coded assembler in <asm/swab.h>.
+	  But just in case it does, the use of the builtins is optional.
 
 	  Any architecture with load-and-swap or store-and-swap
 	  instructions should set this. And it shouldn't hurt to set it
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e3f93b690f4..9b4024b277d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1159,8 +1159,6 @@ config AEABI
 	  disambiguate both ABIs and allow for backward compatibility support
 	  (selected with CONFIG_OABI_COMPAT).
 
-	  To use this you need GCC version 4.0.0 or later.
-
 config OABI_COMPAT
 	bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
 	depends on AEABI && !THUMB2_KERNEL
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8aaaf72ec4f7..29e11893c873 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -342,8 +342,7 @@ config DEBUG_INFO_COMPRESSED_ZLIB
 	depends on $(cc-option,-gz=zlib)
 	depends on $(ld-option,--compress-debug-sections=zlib)
 	help
-	  Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
-	  5.0+, binutils 2.26+, and zlib.
+	  Compress the debug information using zlib.
 
 	  Users of dpkg-deb via debian/rules may find an increase in
 	  size of their debug .deb packages with this config set, due to the
-- 
2.51.0


