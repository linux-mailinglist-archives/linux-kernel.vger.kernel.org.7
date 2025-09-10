Return-Path: <linux-kernel+bounces-811043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78210B52352
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD13B1BC3CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9573093B6;
	Wed, 10 Sep 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izpi9zon"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731530BBBF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538542; cv=none; b=VudkonxDDUc50SDciMLBuxUipFG7gprKR6ltcVwgNkHNoUTrwt83772qbL9rwHly+bnX0ht3QhfdOpFXqUV6ZYZzfTL9VCIOGAtf3L0HAenmQocL9dE9ZApJHAVqM355wDouwrSnDg7a0rB74tXP0fG48GXIeHEXd0cZowTlGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538542; c=relaxed/simple;
	bh=E4LMBizJq8FhIAQMWvFaOWeaoF14wsAKhRkAJ9//q24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8oPM8tyMOVwjuqd4TX9/9WZ/647i45oMhFlD3gbfuNMl5HAPXzs3GwoCt/iqWTZ7cWetGQgN+zZKuyVwaBaRxNwRFUbRwjCREKLL09meW4uw765ukFfDaZ0t5GnOpi4XQ3lqsHNPEdM5s8gKO2ABNMKtXqxo1yE6Hn9EmVE0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izpi9zon; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so6455213a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757538541; x=1758143341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMds8Lyj+NmJhDMyiSFguN+8XzypB7UGcIebx/PYKFo=;
        b=izpi9zonDbRyahKa2KD85Yvhkruv9jYwli078D0+FtftnN30oj6j3ZbMaHxxT2N1Iy
         iX5sdF6/UN4zBo36kR8cYBwLLqHOjH3X+4N1ADvmBUc+slQ3SFdNGUvlERagzyRtTAIS
         pLVuKZEIkJ7exN+jhznN53m40bXIpMq5kt5wFR9qANF8bJJt2SSnsYgYJn327oiaX2nM
         nC+A3iX4A9s0iC5nKxTxGTctDs49QTzd4Z8EFah6SFfJWr0QR3hZ8oYTuMSHZwrVOauv
         D3z2W0zVMpZPtoG3ifXJqztXmFA63EjcjDG3x6m2fQcoTtEAdxsaRv9VtYhGFbJce1lW
         vO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757538541; x=1758143341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMds8Lyj+NmJhDMyiSFguN+8XzypB7UGcIebx/PYKFo=;
        b=ACR10YZsUhAU8gnCwXj+ky3orbLPo6oWjiJTsBwLwn5iU5rZA32FU7Ecb3RN3iEzDL
         s4viRU+EH/a43rxz6lt1d+6owEf58lvWnhD9S5+5WEBCUEFlNHEoQy2IyLmJjCyXR/R5
         g7SpvdHQBSmQRli3z9rFFOuZ0QcZ6Us2WydLikAYRg1FalxXbF45PYoLAtcggy0Kjc2e
         7/klsFBqLh0EU5mBAfQxGh2ziI3w5RLOllHdaCubo7FQp22E8lf06JKKoIPgj2+W78mg
         //F0g4g2EIT3E+AheC7mvqyl+/WoubS2w0+Yv1l/UgDaoPrHQD8HQNuzmA7iobtJGm7z
         tgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDHtl8/oP6BM3ZUciNK3q5+l6NEcT/D9Y2HnlEwNZ/vGpxRIu009BA22zWqAPtkXKUxCqAXrh+CRCoLdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWjM9pG1tIcHMXJ0VjrWb2L9QT+9/7pLI7bNijahoRGhToTl+
	EWXBvCPao2GeZBBvaq5Enl16GN7EPPV9uOsglM4Q3CpF2XIR1/BucnNF
X-Gm-Gg: ASbGncv7ebQYuTID8UzSVdhDYntLEMCe6Wrae5SBf4MuhkaFgeC+MDKLcftCxAPMDwe
	Eqllye6us6BjXvPX7wTArPV6QuQBp6sYFVB4rdGCdnlFUqss5LEC2wiGG8WTLcqkmwPTUpuzJtr
	ynFRGn9nXl60eK+QSQ+w4GSvJcvBnV9ckWgAQo7RQ7gaj1MyCKJ72GSEstUadnSw98xJ7h6G1Iq
	SOkP57kcRnPYj9RGBmtI6UWdZ9+lKB3M3Ln/7FRYVxqnXd2Bv/g5JHD+d29+IZJCn3X68E1N7PE
	Iawz/+QNYr8ApG7CT0/FSzE20kmj0TfB91Yu+h05VZqWDcaYhrYz1KsSPioN8EH90xCvsCWW+Nm
	faRvJH6RzQv1iP/PUU+Bbu7e9iov7x/x/
X-Google-Smtp-Source: AGHT+IGyhaAOhrpZnN4vNuCzeqBEUu4Ip8RaAt6iGW2V3EeACqCJlLanMzMCJlXUNjGF285Tma0wnQ==
X-Received: by 2002:a17:90b:5105:b0:32b:8582:34be with SMTP id 98e67ed59e1d1-32d43f2f47dmr19091536a91.13.1757538540744;
        Wed, 10 Sep 2025 14:09:00 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd63272d4sm29271a91.4.2025.09.10.14.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:09:00 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] group_cpus: optimize grp_spread_init_one()
Date: Wed, 10 Sep 2025 17:08:48 -0400
Message-ID: <20250910210850.404834-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210850.404834-1-yury.norov@gmail.com>
References: <20250910210850.404834-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

Optimizations for grp_spread_init_one():

1. Drop most of housekeeping code in grp_spread_init_one() by using
   for_each_cpu_and_andnot_from().

2. Fix Shlemiel the Painter's algorithm by adding 'sibl = cpu' line. This
   improves the outer loop complexity from quadratic to linear.

3. Don't clear the nmsk because it's ignored in the caller code anyways,
   and switch to non-atomic set_cpu() for irqmsk as the mask is local and
   implies no concurrency.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 lib/group_cpus.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 6aae1560b796..35aba99d8cd0 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -17,27 +17,14 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
 
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
-
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >= nr_cpu_ids)
-			return;
-
-		cpumask_clear_cpu(cpu, nmsk);
-		cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_grp--;
-
+	for_each_cpu(cpu, nmsk) {
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
-				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
-			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_grp--;
+		sibl = cpu;
+		for_each_cpu_and_andnot_from(sibl, nmsk, siblmsk, irqmsk) {
+			__cpumask_set_cpu(sibl, irqmsk);
+			if (--cpus_per_grp)
+				return;
 		}
 	}
 }
-- 
2.43.0


