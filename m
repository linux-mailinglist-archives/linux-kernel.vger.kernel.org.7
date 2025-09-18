Return-Path: <linux-kernel+bounces-789733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8377B399BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613351C808B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0430FC22;
	Thu, 28 Aug 2025 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJSKZmKt"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571AB30F7EF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376579; cv=none; b=EsTsGMvIwB7nKcydqrsHGe716Iv+H94R34vGf8HRm00auGP0o/7mgXFDqRtB+zM2gRgT1uFhJv7XG1V1oHV7ds6Wlj/u0qubfb17k6cPL6JZPJ1bbjcFnt7RrePaX5gFMhSv3z20LGZx8xK4v0z5/fukBu+R9qg3ZOr57NsCi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376579; c=relaxed/simple;
	bh=17gKwiiEc6Iayh7vvEXW3j/5n7q3RqqnU5JePw6QKxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zmy5jbaKOSq9hklQAR/iismPjqwi/xNW/fENDo8fLe2tN6fG1ajrXF+mfWPfMGQRKDSIOVImYiQtttoLogPU3LUMgPfkq4DfjLEwe+RW47m04mtx8Smt/uYFPz1Ek/ASO+qE9BIyQ3eAGpACOcXvTHMfD/yJZLuE/5gu794GVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJSKZmKt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b72ef3455so3103795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376575; x=1756981375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3K9E6P95OBoIrAaeSXhIcr+KmE7exqnfhWdjrNUo1aA=;
        b=bJSKZmKtKk+3AUn/DX3Fw4CASNCGeJ/OFOo4DZ+nq/b1VOLmWOqYObQBGuB7E/3Eqs
         hA7f5TBP1MicvXKk8m2L/KF0MshP27Jd3OboHCBtY79PR9GENSGLKsv5kWNOfd2FlBeV
         MqNJ/3LC3HM8J2o9E+Lk1/kiw0LQ7/v3XkW6BcgHA3IsHjr7WA/fk5ld2xzd+TgmHh38
         tMsQOFp1ERNqxHLBMOLK2iK0cRWEqJNt9XGz489jR+ikAH5+S+/Xa+KLP2Cd3GAKuYz0
         NNOWiCOM+HFEdF6eHCww003WUvGmMgiS+L/rBSRyunjLMDelVwqUwMAry4ryKTai2ECb
         js1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376575; x=1756981375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K9E6P95OBoIrAaeSXhIcr+KmE7exqnfhWdjrNUo1aA=;
        b=ZnAsTcunq7Y7iSj0Cz9p0a2kNYpGJjvd3Jmajn0bKwOGLWhKukUguEbyYPG/Ok3rmT
         gBHW6TWq0cmLQ7CUWNSSKn781eXvsZ5vZsZd9aced3Ko6RZuL8C00EWO1cNdSdMLXEdf
         DfPnd68rAsPfwemgSt6TptTrkpnBYv1B3RH3KNDLRndEqKjfU99VEmHGdn91EboWP/I4
         GE5oV5DNEaOxyHjf3RRCfiVNClRt/d//VzKXnIcPVDsEJWhRn4yUjaRRY3ksFwetrits
         vt4n1IXn7OMLh7WcIQS9J2x22CWgSSnCljZzQvg1iqgWJ4T+F9wn6akWULwpAqr45Bul
         VUSw==
X-Gm-Message-State: AOJu0YzHwc0ngf/XtFKllkEjl4UGrD55T4pstjc6+fZpNnNKdwdwNAXF
	FUE11p7dHlQ4FNDj3MjZLNPqDcqAf5JIZFW+YcyS0LOp9ZLZ2zb6r8z75WiGoFElQYjAQr4urLo
	vNhK5qEzJzVuEPPXE/i5ofOJ6+O155Xa5XxrWoJq//5UaMACO3pahwmjy5/afxqXsgpPr7qxEe5
	gBGxK8tZuAcuNaFrkn4+5F89iuacaHVBhrwQ==
X-Google-Smtp-Source: AGHT+IFpT5QW7/KxeBIMyZI1WbFqw0GzGtPZng4SsxGxqK2bSNryCdcYj5gMK+LpiN1tj05OTabMiIET
X-Received: from wmbhh6.prod.google.com ([2002:a05:600c:5306:b0:45b:737c:35bf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c87:b0:45b:7b54:881
 with SMTP id 5b1f17b1804b1-45b7b540a62mr11109375e9.1.1756376575652; Thu, 28
 Aug 2025 03:22:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:21 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=ardb@kernel.org;
 h=from:subject; bh=i15d+lYw6W0I2d8523MgJUq1xQDSurxPBDjB0fb3voQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7oMvjx4c+LT60NyaR/N26rua9Rmu7rT/O/VlQlfTh
 2CJJn3PjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARxQ6Gn4yzdnL/Sp1ivnDy
 jXkMwklHe27yOJi83n71HnNK2JnuWTqMDL3nhI9atZY2BDz6YFUVESQ4ZY53hk6ky8z93yVOyN8 qYAMA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-42-ardb+git@google.com>
Subject: [PATCH v7 18/22] x86/kbuild: Incorporate boot/startup/ via Kbuild makefile
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Using core-y is not the correct way to get kbuild to descend into
arch/x86/boot/startup. For instance, building an individual object does
not work as expected when the pattern rule is local to the Makefile

  $ make arch/x86/boot/startup/map_kernel.pi.o
    GEN     Makefile
    CALL    /home/ardb/linux/scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
  make[3]: *** No rule to make target 'arch/x86/boot/startup/map_kernel.pi.o'.  Stop.
  make[2]: *** [/home/ardb/linux/scripts/Makefile.build:461: arch/x86] Error 2
  make[1]: *** [/home/ardb/linux/Makefile:2011: .] Error 2
  make: *** [/home/ardb/linux/Makefile:248: __sub-make] Error 2

So use obj-y from arch.x86/Kbuild instead, which makes things work as
expected.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kbuild   | 2 ++
 arch/x86/Makefile | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d88c57b..36b985d0e7bf 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -3,6 +3,8 @@
 # Branch profiling isn't noinstr-safe.  Disable it for arch/x86/*
 subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
 
+obj-y += boot/startup/
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
 
 obj-y += entry/
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4b4e2a3ac6df..4db7e4bf69f5 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -275,7 +275,6 @@ archprepare: $(cpufeaturemasks.hdr)
 ###
 # Kernel objects
 
-core-y  += arch/x86/boot/startup/
 libs-y  += arch/x86/lib/
 
 # drivers-y are linked after core-y
-- 
2.51.0.268.g9569e192d0-goog


