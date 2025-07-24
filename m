Return-Path: <linux-kernel+bounces-744081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DCB107CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702AB3AF1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5626563F;
	Thu, 24 Jul 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFGqNdSq"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43372238140
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353038; cv=none; b=JoZLt/PvNe9xRKpRvH9gdPykF6+NsyYWOpyuZe82pAwJYEUL1707BPrpwNZml3eEZqgVJGbbrWICvjQEufzItEFM/sx1A+bMzZkYcco0eukhqsDrIrGHfIMytkpDTS+mOiLXb4IrgpkZWOA3Ak9JVMmJOI9T3RiqGOD24bm7dD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353038; c=relaxed/simple;
	bh=vozlwhWTTZeaBLTOrUwLbKibMiWfdaAf3uRpxQQtEhc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FFMimglYoCDAsIfu3wT99PmOA9bs2uVMVdnPoUYBMSqkO7HkyqJwou5eHTllTCbCu00ECYspBLkOczMNuKXDO72zHPFWihg0FFaPFW4IfSB7S2NT6j3yHSY5Aeg3dGGQyqUrdPth4DDV9a4mhO48jvgU9VLJbOboZMYJ9UvSljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFGqNdSq; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jprusakowski.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-607434dbc78so1018736a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753353035; x=1753957835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oP7cxGwm/mObhghxpyauLVJ+5M/Q63eusIkmXcjkDec=;
        b=kFGqNdSqxZ0PMEnHkzyd3Z+XpiCz9r6ip8/ptcFhLP5l50gDhuJo8pu2ZTsn8Rav5x
         /Y82/5G5b0MIQYeTew2JuoovtMJeap0962CYR0UNS1qRNcJK1XZ9pA6IBVhLngaach/H
         YIwE2WpcDpX9Wjdwmj4dcT+u1LCFJm16zYv6YFtU/5mma7FhVu3mBkitPt+MFx0RhajX
         3FN+9HjKaNpNYm+NsG7pj7T/Fduy5zqTmOXENnyB0JXAZCMt4fJlhLD9btFcR7pwnzZG
         pKt+pLAgcN2NGurtI/TOWwd/NqMgnDgffmA+XhZYsUjYHPhQYDSITY8hKHc9PRXmRbBd
         sorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753353035; x=1753957835;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oP7cxGwm/mObhghxpyauLVJ+5M/Q63eusIkmXcjkDec=;
        b=Dsuoh/gwOeaZvTuTlBieSvDyE85FbXG8TNHjeiHNebYFlDSqjE527xxvizQKrFBVo3
         iXPkVpPyrySFdkvcMVfP1wYLU+U7/QcFNfthtUb5IZK3a0jnM3euHuXCvkmbd465+MrK
         GL/hY3iK29hjauultBgDB+X0Gi9YaS0a2GlJ7NAV8GY0lYVJnP5ObgKF9YtGpvUUMtM8
         0OLvBU4Pt3ZmL1c02McaCQUNukVSFxQNORaPYbcSREP5lpIQKqxu1t17Vcu19x1uA1l6
         LV241+LM41QmO6Nd9qFzDUzoB/vTcCVWx0oGcFwx7BlegbyRxBNxMs9lG2HsZPAyjCre
         5+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6uxdVuB6923vsGgQGKv7kBngjFX93y7TKxJZW6717zUFkPnFJPJhtk0UG4/xJSRuMhoEl9Kd61tSlfgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtsVFW06v4bCcmlLoUYD7RLtUtY21IFTF7/D1G+YqxRqTpWjO
	a0RwdfJAzN57uYTI4Jxff079hxvYHt8UscqCzyMSOQ07RFxnZE/tOGlNWJDyOppi/dUDtFxteEQ
	A69vVKTG/YSsYjkeoSxFvl7/T7iZGgQ==
X-Google-Smtp-Source: AGHT+IEW+Ka9VvSms6hDdZ18FHwhQB5dVK6OecnLWTKMyUjuUm/tV39mW4FcyUnZaaFb0VWGkqSjAPHaBgv3/9+78w4=
X-Received: from edr13.prod.google.com ([2002:a05:6402:44cd:b0:614:d2e4:82d0])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2743:b0:609:7ed1:c791 with SMTP id 4fb4d7f45d1cf-6149b5a6cb9mr5507870a12.32.1753353035529;
 Thu, 24 Jul 2025 03:30:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250724103016.5164-1-jprusakowski@google.com>
Subject: [PATCH] f2fs: vm_unmap_ram() may be called from an invalid context
From: Jan Prusakowski <jprusakowski@google.com>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Jan Prusakowski <jprusakowski@google.com>
Content-Type: text/plain; charset="UTF-8"

When testing F2FS with xfstests using UFS backed virtual disks the
kernel complains sometimes that f2fs_release_decomp_mem() calls
vm_unmap_ram() from an invalid context.

This patch modifies in_task() check inside f2fs_read_end_io() to also
check if interrupts are disabled. This ensures that pages are unmapped
asynchronously in an interrupt handler.

Fixes: bff139b (f2fs: handle decompress only post processing in softirq)

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d1a2616d41be..0acc25f996b3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -280,7 +280,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task();
+	bool intask = in_task() && !irqs_disabled();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.50.0.727.gbf7dc18ff4-goog


