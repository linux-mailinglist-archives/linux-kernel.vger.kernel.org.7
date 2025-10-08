Return-Path: <linux-kernel+bounces-845685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F704BC5DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9088E4FBE72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174952F83DB;
	Wed,  8 Oct 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0LOzILw3"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F62EBB87
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938412; cv=none; b=Mca+NS4UvJ+pK+lNey7uwIepX1tRQlvy8k2wyADSN2PYy/k7ggyVRj53hzjpWQ4b3cLA7qIqALnzNkRg9da3nT6S7bxzCZHR4a1DAZhXhBjO1O+zLs+N1sEHfv4vfzTO4KpH7vgMPrJNsQ/zJnb9+GfBXBE3gj6hvrqQ2w6WC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938412; c=relaxed/simple;
	bh=9FmzEtdFM20sJTDcHY2CkIswmX83GWfybFiLYLap2Ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=udXkAm9HTQd1YuZY4aGDg03AMfZGylqpW0OcDMvic45vZuNbqiLIztcY0g02aLB0CZc7uolr+wU0pj2pHgSjDOfbwBd2bMU4H0PXP4Cuk5Rv1JDama0kzlDYA/2ep/fZQ/p2+mAGw9GgOXy65FzdSsRVcuLe8uliUPXWNlZizjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0LOzILw3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e3ed6540fso516345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938409; x=1760543209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXOxGZ/YNATafGtRkFO3eyEiqFtBfSwf8M5twzbqcUE=;
        b=0LOzILw34Y572FNhSbCe+tM2odhcs1iVGydR7iB7f5mZMnNxvejBUY6aHeDCGIQWlE
         wH0wLh41+EtEZKzEu4yjfK6Daa7hlIK2c9jJlQT6JbxQ/YtOgbdEPkiMzy1ivl+jF1jL
         g1DtZ1634rO2NtAIXYNt3AEWlWjT9hNoI8or9T4n+nTe7kX2BJNlWn2gjDQOrlUxfeYp
         x9mRHqLW/fDTK3sAyJMtnTdX61O/9xkDzTWFLCbV7MijhC3Q7VPVVXJrZdknQP1KMRbX
         FvhoTbFv2BMQ2g6PXD10QeINDxJRx+uyKzl8XShVvyLWBjG8fJkYuIx20vxcwVD3twQ5
         8qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938409; x=1760543209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXOxGZ/YNATafGtRkFO3eyEiqFtBfSwf8M5twzbqcUE=;
        b=NFiyb2cl1GNkoDlaNecxbCrmX2yngINhPtMv7NdE9Z2xu/WNWov0O7XGCX210M1rOe
         oxs7AIxKTT/kg4CEiJ2KUYdJkzEHZwf6i/x+AUanfnMb9WcdpDfwusxFeBU7ESYcVvxD
         YWPu4+hK6BxY64sPuXqNzaLw9BuWAcpZp1Dr6PK0OoL+m468DCY0QbDoBu5Qb4F3MU78
         sN0fh5QLpSdB+iu9oJudCdErMbVvFwHGpJLXITcB/yXwTiwApDZSlM5AXO52a0Av/w8e
         8N48K12x0CiYxHjbB6pHElItGYPvyVELEU/lYP350QvY+lnh3WsnsDqnS5UjfKwZQIMU
         1Wrw==
X-Gm-Message-State: AOJu0YwS/Gb9bFmL5/iput8tYW9ZwGwspgMdX6EpxSCCz0psotpgKriM
	iXQivH+f5R2G6C6RXJcZoVRUHf449BW6bw4BDYbEqDy3LKM2u4L/YPl6MV/ltVwfBW6FNuk+RA=
	=
X-Google-Smtp-Source: AGHT+IHrU6L0LG/tG+7wPrq4CdnXtlNwP7FFFswqEly2EF3y8DHI9O5XvzzoSmEJYWWHooMBlG9Iu1ob
X-Received: from wmwn26.prod.google.com ([2002:a05:600d:435a:b0:46d:ab31:6ece])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a202:b0:46f:a995:55f8
 with SMTP id 5b1f17b1804b1-46fa995565bmr20733855e9.13.1759938409082; Wed, 08
 Oct 2025 08:46:49 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:38 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=ardb@kernel.org;
 h=from:subject; bh=sjBBfqHYpRbSdr0WNjBeTQONw5wjcd3c1yQxz5xj5oM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeNZu5ZqzFvNj+9Xti34033rQmJlb9VLuTw5mZLqRXlT7
 +4+4nGgo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykeDbD/9TlQevcHdwrDbTZ
 1a4VZTKeqptx4ERN2/FmMyZ/vv8bOxkZLt2MCSvUsjctElfyuRjF8PHzGpndpaF6f7z4ys6eWPC bEwA=
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-27-ardb+git@google.com>
Subject: [PATCH v3 04/21] arm64/simd: Add scoped guard API for kernel mode SIMD
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Encapsulate kernel_neon_begin() and kernel_neon_end() using a 'ksimd'
cleanup guard. This hides the prototype of those functions, allowing
them to be changed for arm64 but not ARM, without breaking code that is
shared between those architectures (RAID6, AEGIS-128)

It probably makes sense to expose this API more widely across
architectures, as it affords more flexibility to the arch code to
plumb it in, while imposing more rigid rules regarding the start/end
bookends appearing in matched pairs.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/simd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 8e86c9e70e48..d9f83c478736 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -6,12 +6,15 @@
 #ifndef __ASM_SIMD_H
 #define __ASM_SIMD_H
 
+#include <linux/cleanup.h>
 #include <linux/compiler.h>
 #include <linux/irqflags.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#include <asm/neon.h>
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 /*
@@ -40,4 +43,8 @@ static __must_check inline bool may_use_simd(void) {
 
 #endif /* ! CONFIG_KERNEL_MODE_NEON */
 
+DEFINE_LOCK_GUARD_0(ksimd, kernel_neon_begin(), kernel_neon_end())
+
+#define scoped_ksimd()	scoped_guard(ksimd)
+
 #endif
-- 
2.51.0.710.ga91ca5db03-goog


