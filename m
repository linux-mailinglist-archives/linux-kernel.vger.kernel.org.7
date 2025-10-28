Return-Path: <linux-kernel+bounces-873206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7DC135BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA1054F9114
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B6253F3A;
	Tue, 28 Oct 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhJLZVI6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB32246327
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637450; cv=none; b=XyKicjokDOqSg457eGvwbAfzThqJFdijIzwo05rAczta/qiakkODcwsNx1tvlvdA2qvyt3WrqJ/bXnwJeY0/HZoG3mtGhxNZon8rsNbfu2w0YZdC1nFyWLqanuJHUSQ2LO7pDUmN9eO0OTg1jKHCSpV9/CQoh1NDVPuplH88f8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637450; c=relaxed/simple;
	bh=ctDSOGvnfluwdqQK0vmzGTA0kYQ9kp9TzypNLkG+wK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+sgSn0GMWHX+hYHlSbzeR0fauh1GFh88AMbwrgW2djqDKghgKeHXltTiiJt7h3r8dvZbJIjGoe23WyQb3352SqKEsmZ/Dq97dgpLl6BeBj2uN55woZ3l/Wsxyvf9xUSlhu4qWahTKH/kcr+87zpx6Vm7xl0QVcBwVDcP0qJ1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhJLZVI6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698d47e776so45039965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761637448; x=1762242248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHiLo4dGvJFI5QS5K6V3lit/WAW4UGG0dYLvttBDB7A=;
        b=RhJLZVI67B11b5HC5NHCGHs7Ual8Yvjjon6av1rc+EMVKJpJ05hlPBfz/OHLiWXhyi
         Noao0MLoIX4tt3eRlItvdxeU4e3gLHFst5NWcQ+iYu1jrAZoIvhyHPwpXz6fSB1g8Bal
         6Gj7CwP8uowrZHN2SAHuGrjb/x72iJD/DjlqZXIaygwAbIN1UniJYG91xsFw0AK/3VAt
         y4wZp/gYEXDpeJPHkVvmY6YZlEy4dOT79dz9g1B1sgIigXpNZXmmx1A+LN9F00x0JvpX
         ptm/+PlaT4MrupH7i1EDecGJ5dooEFl6ZhHLE8uPATNehDuQvNZtnZtkKIupESDNu+VH
         M6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761637448; x=1762242248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHiLo4dGvJFI5QS5K6V3lit/WAW4UGG0dYLvttBDB7A=;
        b=pWYfOZgO809OEkYaWTiiQAYiCmyLOr+Ck4EwDEpZK51LYXAh5JmiZMotih1hMPtC6e
         KW6z5vGR6Un1uEAq6vsVTVkct4OW0eAvRKChe008kfZLHiGYhjjQUWFkfhudjPGaGUs0
         ZTGeTnAXzp9GMx1cAofKEy7jxmrR4SR2UTvzXmKRo7610S/YzUnoNuYGwXh+wc7Kk3B6
         IbPH3h+o463184cL/5ACbBA5GBQ3EvGM6IYqzzldlfK/PTX6fvi+rtm1iZiwIPGbHCrw
         133ZrOuVXxaXqvV70Q/QmzhNqq7keJgVCigfbLhQENjf7xi5lRjlVAp3l3e/SUg5ZOQB
         9BDQ==
X-Gm-Message-State: AOJu0YzII5GoCW0rMysIdiKJ2JBrqUUMWuWy3m/b2hlmb5NaQuRyv2Cq
	3jzUyJMLlTRAa4PFsxjaSQfRmRPLe3TqHIrXkCGm95bG49F8WMr/R6IX
X-Gm-Gg: ASbGncsnJA1uslaHb5Uy5xQ7W7HY8N14U9dmqqZxclrp6GeOLUj906wAplLUbCwgA1F
	o9TjsIDUOXocPdyuYqjS0LwZSlsWd2ioK7v9xJJYuyenFaq4uik78mnEt9skZCWVBn7lNDAkR4E
	/jbuTaNh5SnUg8R4122+k6vb9dkHCXF3sgAfGJc/VPo5rF1tM1h/fn0rvn+Afs2SMkmxUpitSf7
	EZurAL23ILS46wE2VQC0QzWsv+iwMb43Bp1ECTTKi0bP2P80bFxFyvlS0Bex6w2cKBockjHGEqy
	LXyTsn91CMT3vUVONkrn13DWNYjOLHcukjV02BI/bVHYSXM1SUb8mBRpOBTHlbvmOgcSv2qRpK+
	UYk8cvrqvDbOoZeTcAjM1CD1wshsaJ1cdAuagPMTQrij5nLHgo5hPHqFU5i2IrS5+n4HsjXOn0+
	Vplo4vcPK1CTAiJw2yJuXQ5idlZ0I=
X-Google-Smtp-Source: AGHT+IGsIkYrkc45uqWpm91ynhY0uGPwce26KQbyUA4igcUWQSZwaA9AtEwgUtgubUdiZipkf/tsKg==
X-Received: by 2002:a17:902:d2ce:b0:25c:392c:33be with SMTP id d9443c01a7336-294cb52636fmr44444815ad.59.1761637448312;
        Tue, 28 Oct 2025 00:44:08 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm105702125ad.107.2025.10.28.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 00:44:07 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] irqdomain: fix kernel-doc warning for struct irq_fwspec_info
Date: Tue, 28 Oct 2025 07:43:36 +0000
Message-Id: <20251028074336.929816-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following kernel-doc warning reported by `scripts/kernel-doc`:

  WARNING: ./include/linux/irqdomain.h:59 struct member 'affinity' not described in 'irq_fwspec_info'

The field name in the comment block was documented as '@cpumask',
but the actual member is named 'affinity'. Update the kernel-doc
comment to match the structure definition.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5907baf6099d..952d3c8dd6b7 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -48,7 +48,7 @@ struct irq_fwspec {
  * struct irq_fwspec_info - firmware provided IRQ information structure
  *
  * @flags:		Information validity flags
- * @cpumask:		Affinity mask for this interrupt
+ * @affinity:		Affinity mask for this interrupt
  *
  * This structure reports firmware-specific information about an
  * interrupt. The only significant information is the affinity of a
-- 
2.34.1


