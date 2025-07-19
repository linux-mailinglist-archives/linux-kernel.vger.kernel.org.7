Return-Path: <linux-kernel+bounces-737920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE93B0B1EE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94913BB379
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0921C165;
	Sat, 19 Jul 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEqWV0jf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F36148838
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752959907; cv=none; b=BgOafzSZh3ivfp9yR2XldXYrsz/zG7nBvxOGS/bOkqP2vTemzMtn1wkLzYWxpUgGd/EL2ALyFrkEh5kVP5KfOmz7FfAFcCLgAHrFxkzyuwYgbT8Ku1AcB370NSF/Cmg5weShBgWTPXuuq7YffKKLMwHYMS58e2HEdaORiCa+HpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752959907; c=relaxed/simple;
	bh=EGM79XhFtZD3s61maFzC9P79N3gs+C/j+HFCPSgYnJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzu4BbIPoW8yfXqj6y/QsDKL9a4HcKBBxkuzFqSqLyfrVorThqEqCmOiNzzSt0aG+0usB4DABjOv0e7+JiCzr7Xry/SY2I9ZX5kqh455MeMsjEJxu625cnYfZ3cL9resoa4cGGg5SvkiC4B3gpf4HVWZfxirowxsN3mF96aaeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEqWV0jf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235f9ea8d08so26054285ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752959905; x=1753564705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTq6760lwia4e8YQuBVWdPS9I1iCcagKkakwsj9jDHs=;
        b=ZEqWV0jf4NYz6419jU5ihepdyKFQMeRa8QIZNLN0CNfJYNqG1mrgkDzki1VyyVCsC6
         E9qYMXy2IeTOsv1NRnq8QWPtSlvmNC+Py7hwcXJJCbLvX/q7e5x4QiEzd2YJTXrADQ88
         LJoEYJUgfXRCF3xbIWqHTXFnXyiUvETyu+aFZCRV01raQj9WWhJrNbGQEjn9w5ezzLBe
         4lPX8LQ4en27H5kZ4fAt5qaxz+4BslE/q/FW9/XN6kovZCT0rfbz9s4XivRCEBDQkY81
         lFRQmN8MqI9HiuTOtUyARYzWiDOKcrsVr80ly/8kdYHBDcXJtyLjnx+/I99Z1/PgDyIh
         cdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752959905; x=1753564705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTq6760lwia4e8YQuBVWdPS9I1iCcagKkakwsj9jDHs=;
        b=JARxt3Ls7Qixwwe+ZgroDmuB2IGU16/05gFdWyIz1rDn6LPJ4+ic4gY89OJABsu2j/
         1m4X+QpF2Mws3kzbXDQYPoelFxFtVBhOCXYJUfWklORBd8ACeDhQ3sK9w7dgpEF89W6k
         knwV2+aMUqqbqZRHEet8LMw/mm9IGVfDY7bxMiqCQSAxG5EpPNeGIzCm2Mu4oJGg3DCn
         OdPkQaHufYFHu6Fl/ny+zhiLAnalN+hiUnNqT+H6ealCs5N69s4TTF67UShoHIUsBk80
         hAq61RfxJfS7nWrs6BZwbcXB1SLPNzHMMWX+q9SacEyMKcvi4TlukbuTh83BoV7DiVK6
         qYhg==
X-Forwarded-Encrypted: i=1; AJvYcCUXIgDe3sh3hIpuyR4qkK5mCttEKhhBmY52WkQchLtN/VbR2T6j5U7Q8hX+vZajmlbs82/vZe7Wmza/Fo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUhnbkDru/hve63k7pzTW+DSrYjamN4dyantNT9ov8CofsmFy
	G4xfqeOEjJXBf0DXFt0M5u45hjRnWkMgMPkfxKU24zW5yl5ZL769yApI
X-Gm-Gg: ASbGncsz9UbpCIEsCPvOaLeZJQnDTHFkR5Yk7zmPEf9UsX2DtX0w1UpPCveV2Bk2EwD
	gH0gxwku7iQlDK1nLUac8GcYxncGAWpN90t2lRNQjSDhE/Zv73ViehIaNc/6YBDNADMvjZl03/J
	lR+Au/PodcFv96NgZD5ZfPDCiqnpQzuXFYWc51w42eekfBjjr0rirGChT/y6yo2LVJcfgmRQ2RU
	84a3M+U4+2EoG40UmgRL7snSIB6T3kxo30Z5MVXJuyxQtOThusrw082joTIb5JAaMadseoIcHy8
	fdIqVrDlYy4Yv+kUeMOEKY+xZgGoGkLJzUBVlsTVmMbsW1G9LI76hZw+7Zy374HeVsjTt7l7okL
	AX70c8ZLo8bcJS9fa5qkbMg==
X-Google-Smtp-Source: AGHT+IHAIkKZtqnoz/2pk7WJGBHqjCEITlmFopFvF8I7utW6HlbMKCxKMP+RSzVFsCWdPkO0e+Eqdg==
X-Received: by 2002:a17:902:d50e:b0:234:d7c5:a0ea with SMTP id d9443c01a7336-23e24f4aec0mr268589825ad.24.1752959905019;
        Sat, 19 Jul 2025 14:18:25 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b611ff5sm33210955ad.75.2025.07.19.14.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 14:18:24 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] irq: simplify irq_im_handle_irq()
Date: Sat, 19 Jul 2025 17:18:17 -0400
Message-ID: <20250719211818.402115-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Hi Thomas,

The function calls bitmap_empty() for potentially every bit in
work_ctx->pending, which makes a simple bitmap traverse O(N^2).
Fix it by switching to the dedicated for_each_set_bit().

While there, fix using atomic clear_bit() in a context where atomicity
cannot be guaranteed.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/irq/irq_sim.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index ae4c9cbd1b4b..e05904da7e3d 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -128,15 +128,13 @@ static struct irq_chip irq_sim_irqchip = {
 static void irq_sim_handle_irq(struct irq_work *work)
 {
 	struct irq_sim_work_ctx *work_ctx;
-	unsigned int offset = 0;
+	unsigned int offset;
 	int irqnum;
 
 	work_ctx = container_of(work, struct irq_sim_work_ctx, work);
 
-	while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
-		offset = find_next_bit(work_ctx->pending,
-				       work_ctx->irq_count, offset);
-		clear_bit(offset, work_ctx->pending);
+	for_each_set_bit(offset, work_ctx->pending, work_ctx->irq_count) {
+		__clear_bit(offset, work_ctx->pending);
 		irqnum = irq_find_mapping(work_ctx->domain, offset);
 		handle_simple_irq(irq_to_desc(irqnum));
 	}
-- 
2.43.0


