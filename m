Return-Path: <linux-kernel+bounces-844619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FEBC25A6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 214F64F5CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E52206A7;
	Tue,  7 Oct 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZDqi0Wg"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7969216E24
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860842; cv=none; b=mQ07EYdV0k4jO3EtUs+c50Kv4XpDP9bDYTLljRATgGUzgD4xZhgUiOqiT1g6MWCm0//g0eLkdt25eGeReiOWdP4Oe9wZu9ysCmldYVwCXGm0Y0JXE2dIvwBotJSjcdqNt1ALNJYWEaaQe4nCdAAzUzc9fKAqm39CY2eOoFu33fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860842; c=relaxed/simple;
	bh=Q1mlWwYaLkVluPXmDrFeV3qn9UNrPlRNx3tBAwvjXGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVtsYkK2GcFw4tpYAUOYp9kxb7kVNv+5lR0S32HZ20TfN293lX7zOoTKx/5fjXQ4dQLAXtoORn8bdRJmPlXc8iv9Jp46f4hfU3AoGjNoGesTpQXOe0pxDgOBGRw0ucsYZylxDgDQky7GU7Z6Om6yPGuwKkNRTSqP6YMOlr80leY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZDqi0Wg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26a0a694ea8so53116905ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759860840; x=1760465640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNH7CpxZO3HtMj7WjMvzIrMn+R/eBczieyRcit2i4aA=;
        b=PZDqi0Wg96vMPhqQbb+0yiL/twuzY/t9JZecBj8oGdTEWSTmf9n0TO3zdfZOF5gR9W
         8F80uQZJqrMuZFxFA441Tza4PoiwQBg5E0SXqgpI+IM5XDULiNBfIc6a+Kno2uIiWj5Z
         gpNP8aiNuS8zEwzuOAvTqqzrrhGhlFrzebmq9IOwpbwCQxbSOVx01FU3amrdlD5b1DOI
         Kz06EmNt3PqMO+/r4uzmQKe9TPyob7Zi6NNRBSDSVA1hbHgun9d6wehP7DgqqnzXTZwF
         1aVLtJ4fMEIjy56qHfXKwkTOcll161fCRQ4mcRvC7cRDFBLG7BbebJ9vWDD4aadDIGJy
         nmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860840; x=1760465640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNH7CpxZO3HtMj7WjMvzIrMn+R/eBczieyRcit2i4aA=;
        b=IRdozguVjUY6nrSMi7RRJJ3wce4OPRxI5R3jXAbLLk+dBgOSLpIVfZy1gPy2N/hPoL
         Zv/dk0t6GiDobaAyczRnmm//B1+3O+xVToyBKt1nDtrDp4K13yWWICnBHFqN0xFi+c/U
         hfIKV7UcOWHMUpQz5KJBopEIT1NbO6fQ1acakgFswPVVXX7uS/75oEntwtln2cZCw4qx
         niik4dPLYpVilgmNAa5eCcRHyvVESHHq1Xp1KGgsqghIeGB5M4m48CLLZsUBh4A5K33+
         x8oBqcnu5TGzicinWxoo6fsgtnPmnsxiOqr7zYtuBLDsRYVEMi9Px6RLNJ0sClQRUOaD
         +xuw==
X-Forwarded-Encrypted: i=1; AJvYcCVcQfz6HBreN0+VuEuyZeCYbGRbR0wmPKT4q/42m1NjT5DGuRLBWun1Lyfdkog2PGAMSpc6kYjNz3QnHHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZsyWRYQxXIEuiEc3djsVMUHzIu4XPKfqN+2vBxDgXQFnFBIs
	PlmMlItqSkg2oCzS144al12ZNVFVIOx8beRNJyxb1N/eak39ujPCgE11
X-Gm-Gg: ASbGncszDMbmI4iwcWHbHn/NLhzzdYduLrv92q7KvNa5MiAzPcH/69R+2fsLZtV1A0W
	BgXUaQhXuh/MCuHhhEv0Go4UMA5sncenhESuKG/BmNfPH8khvumzTpMeAZ5Cq1pEtQjYYSHRZCF
	6uN9B6pctTRYS5rWyeBok0xcwGlBzbUSqqKOY1YM+mVMxHWyFtlwU2bCZ6jFf81lcuO/6Yi5KjT
	vbq4BmRHfbrsKGaJZiNQ2TGruid3iOiaXeWsdOYKPBDaxPL7EjQkN6BijCvmMxtcR23j5TWMILk
	z4GZ0XAiPQnc8BkgZLlJ+eQmEGC1VV7kpSpF/wFccL1YIhNtTjvReUNUWJHNJUesSS87xF3Dd0S
	uj4dkkBhbx6Nri0qP0aazYwgQkRCHjoHCO1Tgclzfzamj3Topm7eGeUFRAIWhu3muMru3Qb471f
	8=
X-Google-Smtp-Source: AGHT+IGEoaS30JkexbczCkER0b0ny9qzXgkbHht7xAbLrqWH1QGS1GjhAeCdWjt9DWYhbnAnZJI8QA==
X-Received: by 2002:a17:903:3d0e:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-2902734491dmr6799305ad.33.1759860839964;
        Tue, 07 Oct 2025 11:13:59 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:71cf:b339:3993:4f8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b844fsm172349505ad.69.2025.10.07.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:13:59 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] loop: remove redundant __GFP_NOWARN flag
Date: Tue,  7 Oct 2025 15:12:05 -0300
Message-ID: <20251007181205.228473-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the
redundant __GFP_NOWARN.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 94ec7f747f36..13ce229d450c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -824,7 +824,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	if (worker)
 		goto queue_work;
 
-	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
-- 
2.43.0


