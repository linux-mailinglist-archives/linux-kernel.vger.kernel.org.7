Return-Path: <linux-kernel+bounces-593399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F968A7F8B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A649544151B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34DD264F99;
	Tue,  8 Apr 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYZaigLG"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523C10E5
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102400; cv=none; b=i++oVn8oex/oaiGAuANEFGQoASlXnvnvJl9AHKd2Sw/E6GGQzEaXiu0gcPjfuHx+sTQ2x9w7809Q3thgJdwa1fZMIy82I9vDqrSV+ppapltdFD3HkLqIC9MurtxYwah3OIriIHvSMQd1e/OAX81I5+1RyWvBm/lMB/FIVZz3jrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102400; c=relaxed/simple;
	bh=JlE2OQ2AduMmCHQo5eYCN6KCZRNPYziCXg6rcjgqdHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jTYNeaoUFno1sI09LJeIgpusbVthsjn3HGD7haQRtBhv02e64yfg9BLKanDkWhw0BQBEDYxuuOzTLyAd+QvhtmKXoFB6l0w4q4RgLrAtGF2NgnxyQ7r6CycruvQk26ObmfxNyunU1G+f8K7NVZozDak7OXRpNbr1fqdLMWlbVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYZaigLG; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so34393075e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744102397; x=1744707197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSE3KrXfCF2z467xGjBqx6qUo0ojkLUVWjm2QnsSXBI=;
        b=bYZaigLGqqIPCQXYOO+lXl/mJfuhSyXoK65Ec9H7XuEIpBdCPEvq+KEZNMsX/wT6r7
         r4tkxpFtiekq73yFnrqct8SU/ry6hyc4cHhfEh2tvh+T49T9CVoP69mw3kWZBO01gpmY
         Bgt4rBuFz2Tc/vfgV6fY+923GDj4sa0IKIrwS/BaXUBuWRJ8PRom5j5ook5mLMdLZHPN
         ejUPWQywNSPHDGl4tmP4+TTJGBNIFjpqIFJeOfXq1xcQLcfwkt37l3z62EHuBT5Kd9Rz
         0N+XvDa6tEezExLChW3xlYyx+RDORy6BSHWQ10oVfCjin4rgRgltk2wgEZRssetNQQCh
         bd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102397; x=1744707197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSE3KrXfCF2z467xGjBqx6qUo0ojkLUVWjm2QnsSXBI=;
        b=tPR9zxBuBcin39tVtdG2wUu6a5ECFGDrEx4Mf+AoM/Hvg1aoSwvqYhe6MPcrmltdxE
         UZoTj25VoMMawympZAuftimVQPR+8r1lGQnDrOglP14b8KVnG1+HKGkr/19dtVk5niEU
         Xgcc5I3cb9o0cMcQ6pub76oT75WchLx625rK94HySZWYbxGQpoy5tLr5g2K7B4JFFJ8D
         yc7OBie/WVnpxVC+xxr74tKQC5Zle6idjeGae4YXgHczG79pGR9FSxRGL52KgItKNepL
         0PO96Ef2lJ56Ui4tyFx4x3BrUY8GX7W7vhKDdP/5Mhy/g8uN2bnMoGueENPb8fzfsvr2
         fdlw==
X-Forwarded-Encrypted: i=1; AJvYcCUxKtprfgEMzli4Lk2GPRA9rB9V8CoIocnakVALFYORVrdpx2b6+jYqyU6NoMW6IRUHoRTqBJyF7p9wGb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFM7Odgwjf8bJXfw8GO/SY+cgeCrm4migvoPxyze/D7uHHF3nF
	+o2D9+pvV75+6CIA6GlGD5ZlbqWudM4zZqaq1b5c48rA+y/LCghqd4drHTKoBM/spmSgUw==
X-Google-Smtp-Source: AGHT+IFa0DJqpCQSDbjxFWbigyPtud7VbYW7GW80hRibKF26sQXQzzZjdKrTlP/OKHOu0W764n0BW5kp
X-Received: from wmbay15.prod.google.com ([2002:a05:600c:1e0f:b0:43d:48c5:64a2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e0a:b0:43c:f70a:2af0
 with SMTP id 5b1f17b1804b1-43ed0c50ab7mr163226865e9.16.1744102397047; Tue, 08
 Apr 2025 01:53:17 -0700 (PDT)
Date: Tue,  8 Apr 2025 10:52:56 +0200
In-Reply-To: <20250408085254.836788-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=ardb@kernel.org;
 h=from:subject; bh=+vHTcCsLmbKcBGy048Aa/bn6FL1dz2EfzCduKTSuptU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf3L45dbaltZkrf4KPLdcdq/SXJ//HmtaKOfEWv2terzr
 5L7/s6ro5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk0Y7hf+kfxSrJkJ0/eN4k
 t3gUyzAKr9p95/lphpKzHWd6ZF8udmD477T+kNKa7wIHa6v1hVI7FtZXxokoGc95dPNCdbpE2zM bZgA=
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408085254.836788-10-ardb+git@google.com>
Subject: [PATCH v3 1/7] x86/boot/startup: Disable objtool validation for
 library code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The library code built under arch/x86/boot/startup is not intended to be
linked into vmlinux but only into the decompressor and/or the EFI stub.

This means objtool validation is not needed here, and may result in
false positive errors for things like missing retpolines.

So disable it for all objects added to lib-y

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 73946a3f6b3b..8919a1cbcb5a 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -4,3 +4,9 @@ KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
+
+#
+# Disable objtool validation for all library code, which is intended
+# to be linked into the decompressor or the EFI stub but not vmlinux
+#
+$(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y
-- 
2.49.0.504.g3bcea36a83-goog


