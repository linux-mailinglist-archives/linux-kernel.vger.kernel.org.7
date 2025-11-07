Return-Path: <linux-kernel+bounces-891145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F404C41F32
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9A189567C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764E313E27;
	Fri,  7 Nov 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGapfCye"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC730DED7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558088; cv=none; b=fxc2bW1J7tMBf+AJfJgowhn5kXHbHTIyVdWVfL8svxHV+Bg5YGo+1b5OFt+ZKzs26lEzAEKkOEJtUNTw5kIWoOT6oXhTPBoExwYVSVdTXGQLbZOjnvvbNcdauqR1UsqmRB54nxHEicXGXa2+oarXv3y3HPGd/4vIhaNrMB8LDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558088; c=relaxed/simple;
	bh=+/fFPp+rQE0Kv4hAWny8nwSCwR4OhKVRzT5fLbOpHa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYa2SD5klDHwSvlKg0WlLK2Jbcu3hRt+S3JHSbGtPwq9RL4eZGSCnzhjCSb0qplgMMg8O8eqhS9NNYkSzH2btj2MklzQRp2D/3aRz+jTj9/fHThvRIH5dyLeE1WYG252x/dz6uynCQIqClqrkcrBTWHkOSP9DC15BeqXeJyAVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGapfCye; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso1095537a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762558086; x=1763162886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FRIkjyQLpnKSuNdHtvanSQnNNTZlAIBvW93bELD2Kc=;
        b=EGapfCyeIhBL8Yr7SgHoNHSqPpXt/YroOD4EOwyodvIe5hpLH84XTbBt9GwwRFzenc
         g/Kxh84G/a/RGdtuaxMEf4SkEbBaB5r5Xt9lpQyNYeMZPbOio/uUXZLCuLqajUFSn5iH
         xn8uwPTwvnEMzel97dVbIMbxukFMmkM5o1S9YnBSDpDeZtEH3KrXV1P92v+C48T4H+/E
         GWDveuuENdgcZZFA6Zgq6N3LOvZNL0LBnr5TrzTibDXMF3CQxfHAe2Ah7+fl8MClTHbI
         tOpSPL0ZrdrIbw9HBRq+fqofMREV3MSB9qkK0es79vOftJpULebSn9EL7fyi7vUx2ROs
         qmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762558086; x=1763162886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FRIkjyQLpnKSuNdHtvanSQnNNTZlAIBvW93bELD2Kc=;
        b=oiHLvWssatjpf/GFDTLoNam3yis+C5cEzzJ7n7PuSQDUU4k1PLk4HA+b95sOTUK1Lq
         KvBz5peOjr5kzktCc725X/tES1j9DC4lwdAToiaYt5AUYpelKRjeTpHHVE8d3eN1ZU7E
         HOPPCjWfzggqaEnyKXBzWpgxmXLh79gHo6Cu8SExOw9L2uf816YkPWRdOtCw+3hFlPrK
         sMbPKQ9Mm4d8X6o5CEGiv1CIyt8IDkYI8o6+aYkVprtOKvVJ/uWSHPkhFUZm81O94a9q
         TwOXtj7vU8uGpEUu1R5NaREiBUlruXDz2LZyBlO3MwE7nFnGDW464AkCLP1WobvQoiFI
         kkPA==
X-Forwarded-Encrypted: i=1; AJvYcCUXg+Ly49UcPi24kkj/T9TmAfH4/XoMd8Q2UeT0rJQgFfLr/LAgNWN7Gm6m0jBE9Tw8iMaeo7EOEcwsQws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGG17A9F7/kYk+6w373WYtsYDA2DMboN3Zfhd0N5dpetCZ7Cu
	ylPxfNakFpDECSk/6pEjfo1DJZTHSlYAjZPAkQHCUJlPtTVqsmAhRe+H
X-Gm-Gg: ASbGncuCP5JCD8dG0TEFeTydvSpjbY9E1QMO+HgzFXnLpui4njcssipCFo48xf4xaDo
	K4ZP/w+gGKIsy+Fwybnkg4EYx8kN46g8N2FBnmfucMx3q+n/8kFAuZWZg82cujUYF5e2xmwNK8t
	FA5K29aQ261A5QRGs3lxelysR5FAmGzOLU+kDKu3qHwv34GRvds/Kgb9mvEPHHnsd7cYUDi9Dnv
	OvMbbLBDkLO3JaZM9rIO/digsSVkELMoyyZWD8Sm0RYmd3N4yk9gG8FOgo0RTPXugI8sui5+8N7
	5xknImbpZBKU32iyjn7qNnQ19rwaO1qkeIHSTWKaLrzGz4GQhLeja6W2BDV3Je9g7yDI/eGH6Mw
	tYer6htHhaC6M28qei1Gy+YQ6wwnRkmkh0OJ6bt6gmoQeFwLXfjNb/bhep8Ycox2Nfulg1hQG59
	/wsG9EvqEhJIyeoi9YFA3cqb9cyWhte00vGMoW82fy3KY=
X-Google-Smtp-Source: AGHT+IEnfB6XHf0tun8R6O8Jd/whhZxRIBexp6VVi1lZY68s7/51Itvmvrdz7VaaTUr138BNkkf6Iw==
X-Received: by 2002:a17:90b:3885:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-3436cb7ddacmr770381a91.8.1762558085998;
        Fri, 07 Nov 2025 15:28:05 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ba90138f614sm6166240a12.27.2025.11.07.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 15:28:05 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH] mips: Remove __GFP_HIGHMEM masking
Date: Fri,  7 Nov 2025 15:27:58 -0800
Message-ID: <20251107232758.105850-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary __GFP_HIGHMEM masking, which was introduced with
commit 3e14fb19ad7c ("mips: convert various functions to use ptdescs").
GFP_KERNEL doesn't contain __GFP_HIGHMEM.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/mips/include/asm/pgalloc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 942af87f1cdd..7a04381efa0b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -81,8 +81,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM,
-			PUD_TABLE_ORDER);
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, PUD_TABLE_ORDER);
 
 	if (!ptdesc)
 		return NULL;
-- 
2.51.1


