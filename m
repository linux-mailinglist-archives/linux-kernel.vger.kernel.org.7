Return-Path: <linux-kernel+bounces-878376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8357CC20715
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1558188B9D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7AF242D78;
	Thu, 30 Oct 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CL20xqFb"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB1257825
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832633; cv=none; b=UbnWWrnJFyHF7GDchOnv/QWeRjjZsYC4m6FVtqWJN3nBCkZd0exHEg+dNcd40PVbKBr5vUFOA6d7nLsnkk5jnM7atxYdgYZtprFGR9SVuxVDh4n5yQVECcJapjD7gu7MLirI+ZSfJJlJY+feult3UNxHeGKss7GET3GtdVCDInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832633; c=relaxed/simple;
	bh=sklcjzEcUTVDi/Q5wjy6gWoZ9JYYCnW2Ie2EGD2t+f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWL/ZG8jvMSKERI/9EIcj2Bvq4E9EpWfGgq6XfUjl1i5mYQIloblzLiA4d9P4Iaox+pJtT1o1EghVb42OdHgqoGTR7s7M/SikcpDqAW/3p21u5fMEnYpCzXi1sGbhkoaK7grv8EPnGWzVXbfKoNOc/NHxbMe2/zoR2/UjaXyo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CL20xqFb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so1099941b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761832631; x=1762437431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idtv0RG1n1Xu/2siY10CA00hyxq2ZPaiF1nMz1aq8l0=;
        b=CL20xqFbkYfYrwMgWT//8vyg6J71GVkJqhtlN9e44hQSeuPNH2Ag8EnFi5nGHow1yR
         omDqYyZBvh4/FB4rsUDfobip57jupY/Q9mOvGGzzYmXhxA3N5rnKIjpkL1Y+hq+N96gY
         3gGpLoJUxYtnGnispysx2CrPsCspPLLe5HW9fy+Rf+8UqmY3rlY1jSsdt/EO5ulNoHvN
         d2SflKSb56b/FKRxGwCk/3zT1I7MvwBey1gfYx7gmFsusWyX5TN1u3GVZYj5Elh/f1oc
         RSZiXyM4jj/XFN66yTWrTtv0IpLKxZKTs+fCyQGV2qi4ATGzxVfce5D7QY0fSsa0oK2F
         CJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832631; x=1762437431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idtv0RG1n1Xu/2siY10CA00hyxq2ZPaiF1nMz1aq8l0=;
        b=LiKEmPLaNKUT3Sbe8rD1Nhc+cdgTec9fgaJsoZ1Rx0WWRQQoDBBEmwyI2XoQlrhCWO
         o+6qP84dYfWjLEVjdRXOHCYhB/HfWQL/DbW4PumcCjI099s+MtMMNkHGwvTQpZVul5eW
         UCvhyTlkjp0EO5dM/aHA1axJUxrRBCYooc/Vf82bnJbh7FTr0bB5cAicjPgNaBPdbPa/
         LIxaniVBYQp44qWu5XV3x1nbfxh9pfbPx8G3l/RxwRwg45L5sDQT7G768h+wK0bZcIvY
         IZL+t9CqFZXDBPeHnemeVjEHC24BHByPS6e8KGLHRByJqxZsrL9dvzlorR1fN1DkWtCS
         6FgA==
X-Forwarded-Encrypted: i=1; AJvYcCVju+FeHjoE72jjWPjSEJhNZHppQilmctg+DymIC8DJabM9X6bKg+zJrRjRkcoXfaax7/YOjKcZxrA7He4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8L+XMlm+M1vALj+nmrBkH4Mz7Ye5CYqZFkTk25ky/BQ/n3bI
	dcV3Jz9e0bqX8ct4cFEXP1WJ1MleuF7I6GmDMIylrgOtS6fPF88ncIFj4oHpbTGHqw4=
X-Gm-Gg: ASbGncsIbQ5by46XqL22KklIjoCHLODu6sAqAOMSKExkXU6RApmtPbKCOVKxkbDJq0z
	oB+6QPAHP7EsjO5HexD0eX9DMAo2bl0CLmFDqVRAc7PLUFw8yW9Nt5fDQ0dTa3gJ8OASRlCs5NC
	pr8pzCzGZR/koiQd2rF4RivDy6Ch7kjm33vAmwApfYVljMQWInQFw3kSaQmTPmMda3AYPHXGwx1
	0DXTolByWEpFZiH/zVVb3/KDIumeoIrQah/b4e0YPyF9p1imNVQrrU/uuD8tkLvHrh0hX+OLToN
	6Juui+BfxbckPtfJuU92gWve+sSmKoY4uGeq08qBj1TjQhYyH6JLiNagQts/KYZo8MHkN9NzGws
	IsxtO78Qn+qomR4I3MQfMicV2oFlu5lW3SrpKmc5kz3K/yxaRa7AhGk/S3h60elCW39BigpHkxf
	lbon5MIXAPAsNb8JbWi6byJKchtVQFazRQrFVOkIxcADvVo744A0c//n/rctwCza0=
X-Google-Smtp-Source: AGHT+IGbOUAtM2+Lu3qbpwcnntpyy8m+vA1T9owmvZzuSyODN0ovPcBr/za3iDV2dG9ZYLAg2yY1uw==
X-Received: by 2002:a17:902:f682:b0:294:ec58:1d25 with SMTP id d9443c01a7336-294ee0a0fb8mr33408495ad.50.1761832631190;
        Thu, 30 Oct 2025 06:57:11 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e495e8sm187071905ad.110.2025.10.30.06.57.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 06:57:10 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v1 2/4] riscv: mm: Introduce percpu tlb flush queue
Date: Thu, 30 Oct 2025 21:56:50 +0800
Message-ID: <20251030135652.63837-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251030135652.63837-1-luxu.kernel@bytedance.com>
References: <20251030135652.63837-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The percpu tlb flush queue is used to buffer the tlb flush tasks that
each cpu needs to process.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/mm/tlbflush.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8404530ec00f9..aa8f1304ae5c4 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -103,6 +103,18 @@ struct flush_tlb_range_data {
 	unsigned long stride;
 };
 
+#define TLB_FLUSH_QUEUE_SIZE					16
+struct tlb_flush_queue {
+	struct flush_tlb_range_data tasks[TLB_FLUSH_QUEUE_SIZE];
+	raw_spinlock_t lock;
+	unsigned int len;
+};
+
+DEFINE_PER_CPU(struct tlb_flush_queue, tlb_flush_queue) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(tlb_flush_queue.lock),
+	.len = 0,
+};
+
 static void __ipi_flush_tlb_range_asid(void *info)
 {
 	struct flush_tlb_range_data *d = info;
-- 
2.20.1


