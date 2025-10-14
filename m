Return-Path: <linux-kernel+bounces-851723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65574BD723D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 137FC34CAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62470307499;
	Tue, 14 Oct 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SUYFx8ZZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62AD2BE649
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411309; cv=none; b=cTpYyjLQ0WKVxiqbwul8Jq8wszHGgVwqUhECrFS0isX84TcmgJ9jDUbVE/i1tLP24XLt84ksyFvDGcwpqWX9evVvrcSOXTrq9lBMTQMokeRyGr4JjsoDpZUBmxoCtKZzQngD6hTFNqLu+j5ZRTxwPVJtUeWPBQ7RQQH/c/b2k1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411309; c=relaxed/simple;
	bh=NEii3pLG/QNEJ1Go1mWJANkOZtwtz53NflbAJTNnww0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0fSUfYUNvWgFP4QGfR7wgIBELTszp8cPh6u6mezrgV4kOP74rIgOEj5K239lKREvT4z+2TZ14omaZWjJI6H3uDKhBEEuu54G5cges48Br/VnN3x72wHHnQSgbWn+Wi4QfnwjYMAQQmspZHcCarT/uIEAcC/vQ0PZzcV7UtrlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SUYFx8ZZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=PpSrfZMrt5UobfaNj8z8vLQDmht2luCqBW5eGAcnvbM=; b=SUYFx8ZZLWE7utDxnKjgxHzE8N
	X5XAZqUvLjd3SW4yy7paNVVxDPMxbBKnHq1gGV6D5LPdfuXfb/gto6iHWxgR7UQhK3lge8l3q9gj0
	tG+YYopgZN29cPyLTCVSaoOZb32jurauizkvV8vl2P8vpWul2uxqHjA2LfTFB2nEhWJ7KuSw9ag8G
	TeOftf8kaqbHPBrGfy+H4C6cG5KhwhzwhSPXQ8Ihs2DtEnrYBpO2p3H4jh5mYankypotHUQdnCoBe
	cCm9/2Mv2S1WGdE/i5H4qZ/PM1+y0eNUc6QHRq1O5Q1hYKZo+cVi6fYsfuZOvqbKCDY6JHLtLMlAn
	1OOYSlWg==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8VOT-00000004sPX-3wpF;
	Tue, 14 Oct 2025 03:08:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Joerg Roedel <jroedel@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/idtentry: add missing '*' to kernel-doc lines
Date: Mon, 13 Oct 2025 20:08:05 -0700
Message-ID: <20251014030805.761181-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings by adding the missing '*' to each line.

Warning: include/asm/idtentry.h:395 bad line:    when raised from kernel mode
Warning: include/asm/idtentry.h:405 bad line:    when raised from user mode

Since this is in a kernel-doc block, these lines need a leading
" *" on each line to prevent the warnings.

Fixes: a13644f3a53d ("x86/entry/64: Add entry code for #VC handler")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/idtentry.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20251013.orig/arch/x86/include/asm/idtentry.h
+++ linux-next-20251013/arch/x86/include/asm/idtentry.h
@@ -393,7 +393,7 @@ static __always_inline void __##func(str
 
 /**
  * DEFINE_IDTENTRY_VC_KERNEL - Emit code for VMM communication handler
-			       when raised from kernel mode
+ *			       when raised from kernel mode
  * @func:	Function name of the entry point
  *
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
@@ -403,7 +403,7 @@ static __always_inline void __##func(str
 
 /**
  * DEFINE_IDTENTRY_VC_USER - Emit code for VMM communication handler
-			     when raised from user mode
+ *			     when raised from user mode
  * @func:	Function name of the entry point
  *
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE

