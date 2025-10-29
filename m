Return-Path: <linux-kernel+bounces-876484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF2C1BD75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7658C5E49A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6F248F75;
	Wed, 29 Oct 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUOQtAwD"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6C2E1C7B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750589; cv=none; b=secHVfAL6fYfsH4OJ2P72LNxWkFYUfUksAPapY2kUuz4F9atKvZefQtnYiceZiYpmQsGht6AKQlezIJp6l/Q0KwDYjD2xD0bT8KNQGUU87YGC6aLpR2Th+LqVomviPI+PbpIF3RcG5Ta40tVUsBwt2iq9W23zKZasu+E6LFdex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750589; c=relaxed/simple;
	bh=aqz7y/tsWIrJSmzrEk+2wuypMBkDy5rN697cMKCzGbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dip1+E8HIGBzTb4VBPZtxJcHsy1Z8uxffUzw81uMGqmha6SDlL3r2DYNSZn0B9+QESdO3lzTlByquZhy/3spUjXgVKjIR1PIOQgVgq/O6bykBIlPYQD7Zqrq6p6kZp50yQRAxBTq6jtBiE12bkpqsq1mwn+a/N1bwl33uPRxCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUOQtAwD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso378697166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750586; x=1762355386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcXGox7y0cwRE4CfkiPlGOADuJhkEFKXu0gn9JmTNNs=;
        b=ZUOQtAwDLO5JVqDveLJtvF9KLfn/IgDTEy7cwk7pvBhjlhq9gZDdiL7ldtAoMZUsgG
         WnicohU/gpKrJAuSHqeSdNQ8x5e7Nl8zQNgH5GEI6AUerSCz3Ie6JOyO4o1m5cSjc44A
         QED73GG8IIodBAtUJQFi1ohDnNWTRKkQVW/X7wNNbwthKzwi63T14w7FWmLHh8old7Gt
         vU++T9LjS13qGArirFhROQQ0/ibiAcslwNoLxcWjamz1SAtp7H2MBN12BITiip/ldjfd
         R7FfZd0pj7Zcgo+q2G02c5AmqEm9tlfYJbfwPSYiAbCXk0HmQ1UztIV0xQggh3WWsXXZ
         6xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750586; x=1762355386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcXGox7y0cwRE4CfkiPlGOADuJhkEFKXu0gn9JmTNNs=;
        b=CZn9fLlr0FVZmBymBmJXWSi0guNHAYTQxjj+phjQR5BqUuE6zlUGxtZ9snbgS3b5Cp
         zuOLf8h1YpDFCy6nVtvUy/4uPgEA37F6K+WizReQDdgUsmX/PohZQn8SEP/BkdTRDfy2
         cPghSBu/NQ3BczzqGjiei6y/YTeXxzHB1AGSyI636GoMSHWCpQMbMOMq5gcxpUeHPPph
         99NZd3m39/vRDBmgqlZYcJlJOhuE3+I/gq68/3ERVaqfWNe3Acrb0epLFRwjtxIVIYmK
         3bhbFGdc+x7LHwn8MlacCJb8NV22eOnTXyrIuOnab+6+TvNaXhDmGkU9iKXS6JcSJmCy
         edAw==
X-Forwarded-Encrypted: i=1; AJvYcCWPO2pS3jVZgnQXYM6CcwwEU9PmLdtcyaoG3t/F5JBmoaEqKX/3Xd9zHw22pieWbGjh4j46Se9gRo2/uMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxTWflWf4VNb2d9PBgdUvi92taL+HfomXG3rjCcxmFS6jLlDr
	qd8TwyqtzA3cGn7xHXCvdEWNaafkGQ3F79IgqmYVIUj6pKCfpuifFgcD
X-Gm-Gg: ASbGnct/lOomNv9Y2dqtCl9LkDM9tDjyYK7mZBfIpOhFMSD8/EQz+1mlpzd92iVH+ZA
	YQBpHqOgxLBDKyvMCREH1ApSyRPBypRzFA3cWXmrv8qXoBdUlgi5pjIXls2MsiQdc1h0MFAbYOo
	RGhPqG2HP6ps5UIENPM2S/OF4//DU+HdGrdA1W9BG81PB3zVklVUjea9MDmP7hrUGCog1Lc9SrB
	bkEXOs9JY17k0aRS5x1P0m9zQYU7J2+qx44G141Nl10VO3RHJC2y1iD4LT1uyohcvRVxLOcVoOZ
	im6uuFDqwsyBahnAL7Azzqqgy/G2RxCCd3QLutCsMsMxqqxYX1+wzCgZPr4yPf2os4YNTJxGHRg
	VbXzRvnR7SncR/xjUeusWIT3RmjcwupReEhJzPfk3ZHymm3t2IUzAiye+o5uZuEHe777ci3NySu
	d/b9ckznkSMnVL+GT+IL9Ou+ag7dERJOCaMn2wLopBXlpQtzEpLhp9ZM8DJn/XxPYanRE4
X-Google-Smtp-Source: AGHT+IGeN80yBTVwepT0UtoR4GDMugcmaClP0NFTb2hJM8RsJgkOD/qnRyovr1c6oRvOZ1VOicsCSw==
X-Received: by 2002:a17:906:6a15:b0:b41:873d:e220 with SMTP id a640c23a62f3a-b703d5577f8mr331767566b.50.1761750585572;
        Wed, 29 Oct 2025 08:09:45 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d8548ed8fsm1467639466b.73.2025.10.29.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:09:43 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arch/powerpc: Add missing linux/of.h include
Date: Wed, 29 Oct 2025 16:09:39 +0100
Message-ID: <20251029150940.2523328-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029150940.2523328-1-thierry.reding@gmail.com>
References: <20251029150940.2523328-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Add the linux/of.h include to make available the standard device tree
functions used by this file.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/powerpc/platforms/powermac/backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
index 79741370c40c..9afb64723649 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -14,6 +14,7 @@
 #include <linux/pmu.h>
 #include <linux/atomic.h>
 #include <linux/export.h>
+#include <linux/of.h>
 #include <asm/backlight.h>
 
 #define OLD_BACKLIGHT_MAX 15
-- 
2.51.0


