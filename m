Return-Path: <linux-kernel+bounces-797445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F05B4108F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31A470342F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA87D2727F0;
	Tue,  2 Sep 2025 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FeYo8wo5"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54301267B7F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854084; cv=none; b=GDAyENw0xPHWhKLNiFxjo4Kwd1u1ec/0bQMkI9oA8YTXYTfOxGHIWEzUmfptNcfdwJTPpdSqjWkG69ooxS9eWDKKjNgSDYnEqp553smmXIderBaLwE8AT9dWCleVgGc/S/dCFvuZ9nLEx9fe36YHL3/gzL2i5I0fFmtZygDmmhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854084; c=relaxed/simple;
	bh=O3BccIW6IvQ9Y1C+YJMCvgo9lqV//2qfccZt9x/NQ6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MipI/BcE6/MxojK5Wo3fEC6znhtFeG3ws9EcMYjFTUb9/xmZAOlVIXPCJ9CSWiwfKlAsfmT9XjlwjufNMl+XvDgC+wyuOidXwgMFINOon8SMtSxbaU/l1TElJeWTY5sovPnBMxXc2gDO9300f+kQnAj0mDDxxZGFo792GXM1c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=FeYo8wo5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5059124f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1756854080; x=1757458880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4s9mRdWDRID+vJHPDz85q8/e16al1ZYMRKnUSs+YtQ=;
        b=FeYo8wo57SQGAJ9o/snzaI0MwObOcQFR0LwQWVVzCxju6tHhdr/EoWCa8g2e4CXCFZ
         7ov/NdDfVV0/6t5oEcXknRwOiD5LdMkQxtqmUVD4FrmMc0A36+QR1um7ImIROV6yQxOh
         hrCp/QnIMjVVoZoI2nn3dKptKBvbtHAvaJAQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854080; x=1757458880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4s9mRdWDRID+vJHPDz85q8/e16al1ZYMRKnUSs+YtQ=;
        b=pwGeHa73VMF/z9B1Kidg+Z46D0pDj+41rZo2PTMEfGR6IJ+7zrpPDxcf2RIsr2HghD
         JyWKc5iYs24PFlkTtO8oIjdnM3X2jsmj7vyIcnzDgRGrNDxCH4z0seN+Gzp4jnvnYilu
         atkh14E4REHCBgHfHB8yhQGvP9+qP/qBAe7x3maJJwUXOBz5jrX59Ez74y6XPFZpYv8j
         soFWVEs/Ei/tLZt0VT/L5p2U5uhWjdYvTYTMtj7Ae9vzsztTofFn+6ZAX40ynpBIjywD
         EaqaUqDdK4WicAP1z9W43F6WPs3u6P2jzeej0TjFymKy7+sWexvmPCWSbHZYpN+VzWjk
         fmlQ==
X-Gm-Message-State: AOJu0YxXjhFdPYsnzGCJmSUj89SwXz5mz6ZEUFX7zDS2gpf+4Q4jvJcW
	T/lHyztD8yMD565P0oVrDtj304lM8te/8JXO+utYsqO+3Kufo2V4TNz9jXvxqDgpGEMTMg0j0FQ
	OYhz+
X-Gm-Gg: ASbGncvSQ+K5n8DqIx3wUXiNluu9McFuAn5WfgdJqsenBhdjdGMjX985DOHii3zGBdx
	LDRRPSFCQ9/9O1TovgE6CLPzQojJ2/IYspoJFxmGIs3OZYI5BUc/4H5bGHTXGNQRLmvVVl/x6wY
	B5LPbmW4gYO8Gb/EdPlfW6JvWxev9vbXxE5/2ACiFLUZ+/Wx+fVpzOpcHvq+QfaNa0Pkd2uG7ci
	IIcAuz/sEuMe9f1v9RoyN9TwRtL8V1glwwSLXMYJcUSvQL/4e5g+Qu9XCOPbUYu7vp5G9LXiUar
	rbQFhc5qm0kymQSmfm1xPi8sVrtUIkHp3GMdZ0izg3gJYyIaGEIv83lao8DZTq0FlO8KsiIxn6C
	4Cbvs+PguIUYHT5sQEpEgS7DYrHbOsf9pYgl8QJJG5suFW6yUwUfaUQwl1H8ou1BDnSjXE6RYqp
	4S
X-Google-Smtp-Source: AGHT+IGizUqm8EYUPaSDWAInqMyV7AspDGh7qJFLYCi0IrnWXu7jvQFMTN4GFcw9Xoks9jq0tvPWWw==
X-Received: by 2002:a05:6000:2089:b0:3c9:79fe:f4f5 with SMTP id ffacd0b85a97d-3d1dc5a233dmr7297760f8f.8.1756854080293;
        Tue, 02 Sep 2025 16:01:20 -0700 (PDT)
Received: from localhost.localdomain (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d643dsm21621475f8f.26.2025.09.02.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:01:19 -0700 (PDT)
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Xin Li <xin@zytor.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Subject: [PATCH v2] x86/fred: Fix 64bit identifier in fred_ss
Date: Wed,  3 Sep 2025 00:01:17 +0100
Message-Id: <20250902230117.1475414-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814190436.2555438-1-andrew.cooper3@citrix.com>
References: <20250814190436.2555438-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FRED can only be enabled in Long Mode.  This is the 64bit mode (as opposed to
compatibility mode) identifier, rather than being something hard-wired at 1.

No functional change.

Reviewed-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Xin Li <xin@zytor.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org

v2:
 * State no functional change.

IIRC, this was wrong in an older version of the FRED spec.  I made the same
mistake in Xen, and I didn't copy Linux's structure.

I don't thinks this warrants backporting, but the fixes tag is:

Fixes: 3c77bf02d0c0 ("x86/ptrace: Add FRED additional information to the pt_regs structure")
---
 arch/x86/entry/entry_fred.c   | 4 ++--
 arch/x86/include/asm/fred.h   | 2 +-
 arch/x86/include/asm/ptrace.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4dc74c2..94e626cc6a07 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -78,13 +78,13 @@ static noinstr void fred_intx(struct pt_regs *regs)
 static __always_inline void fred_other(struct pt_regs *regs)
 {
 	/* The compiler can fold these conditions into a single test */
-	if (likely(regs->fred_ss.vector == FRED_SYSCALL && regs->fred_ss.lm)) {
+	if (likely(regs->fred_ss.vector == FRED_SYSCALL && regs->fred_ss.l)) {
 		regs->orig_ax = regs->ax;
 		regs->ax = -ENOSYS;
 		do_syscall_64(regs, regs->orig_ax);
 		return;
 	} else if (ia32_enabled() &&
-		   likely(regs->fred_ss.vector == FRED_SYSENTER && !regs->fred_ss.lm)) {
+		   likely(regs->fred_ss.vector == FRED_SYSENTER && !regs->fred_ss.l)) {
 		regs->orig_ax = regs->ax;
 		regs->ax = -ENOSYS;
 		do_fast_syscall_32(regs);
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 12b34d5b2953..2bb65677c079 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -79,7 +79,7 @@ static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int
 		.type   = type,
 		.vector = vector,
 		.nmi    = type == EVENT_TYPE_NMI,
-		.lm     = 1,
+		.l      = 1,
 	};
 
 	asm_fred_entry_from_kvm(ss);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..37370c3b1ffd 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -84,8 +84,8 @@ struct fred_ss {
 			:  4,
 		/* Event was incident to enclave execution */
 		enclave	:  1,
-		/* CPU was in long mode */
-		lm	:  1,
+		/* CPU was in 64-bit mode */
+		l	:  1,
 		/*
 		 * Nested exception during FRED delivery, not set
 		 * for #DF.

base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182
-- 
2.39.5


