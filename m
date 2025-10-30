Return-Path: <linux-kernel+bounces-878377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78721C206F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9000F4EC605
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FA25A35F;
	Thu, 30 Oct 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="igSpNwBS"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20524337B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832638; cv=none; b=ECMAVrb41e7oWYjRPMUoBdfSx1UmFvy+AG1lT+xhV55T2wh9hvD5/ZUNFz6G5m9+lCPfE96yg63shGz+lyVLcAX+OIAf+73etgptF+XYGa0snxjseLVbtzlolMhy4yow2sX56njmE2xrGPQsPNY0km8eFMtxsdgKEnGZ9lXZZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832638; c=relaxed/simple;
	bh=GZ13kGXVZV3MWjVjkglZlasmL+TOxO9NJy2cnrIsr0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0eMzuLmlYQdNmnivKXTIu8qASzSuUefsuhN5vYosnc5alnNjHUOYA8NTsy91LmklkdNDf/gY1juixYB7h2qKWj/0AeDw6FQi/TAE3J9/RHQOyZO2bK6XylNbJaLQLhdmquj8nAN5duabQrKi2/y63B45OpjDoPy2/2lq58pKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=igSpNwBS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so707787a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761832636; x=1762437436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JicIE58FwjHecYxgU5U3fS7oy4Wdsaoyxg9pwk2jRzo=;
        b=igSpNwBSUXipUq2scagJG7G94aFT5zQ6DedpRagacRC0PjCy9Ax+IKZUq+FCOrHD7i
         NV8iY2iGSDp9wecDQoQNLNXKRzADlFN3/rsi+LWZ6xkNdgiC06p7Y4529myY8Vkg3DGo
         P8MdTZzGk7HIFMPBTQ61kIJS8a6M3C2wvpYCY0yMAzB9csh3DJTFbYKdYGS8vXgnJqJr
         o45tb4l6v7AUFbcM+Jh8Ee9JDcVwlTOCX+S9H3lRZQCzky1jb8ZbBXiPMzvGwGJWoXq1
         txecwcaK56V7VoRRFxmRmXKI1e0XKZLFVd2WEwGjcsNIhWjE511wDSoCCsSUh7jCiyB7
         mEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832636; x=1762437436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JicIE58FwjHecYxgU5U3fS7oy4Wdsaoyxg9pwk2jRzo=;
        b=nCxme8gtAwhsrljT83G9C7TXFmbh7bnbnSE9/DtSez9S375Rk8NQVgdufYhn1npGlp
         mPEgYynLMp1UteVhLDHfOoGInm9xihWDrcMHx8DUNx9ZfFun1OrtVkJN7QFbUZzMsmWL
         Zvjy+PX+PGWPn8h8Y/OI8vxCbWg0+J/h7FFSlz+UxPk+zKTBeq48yS/K143Fb5c0nG4t
         E4uQ+BYm2ynBd4WcDUI+/Xou5Y1LpmqO8GCCaERw2umqQyBddCTk4DZrJHfZ1w0cJe3D
         05XQx7b2MHbwVGqvadu5p5Dd/+mhA35NOQrAkPqtqDlxnZTYOOgvRKOq2tQ8oL+U1iNH
         306A==
X-Forwarded-Encrypted: i=1; AJvYcCXy9rWlTDflUmStqVtGxsdxOisQKsyi4u2aO6pWKg27VOl1jwFtudBSj3o8oSgCm2yrb+JZWuP/ZMFn79E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxttenLXxmj2LVdzMM4uomq3bi2POEpbkF7swRd7LPoTTOuzCuo
	0aoIGUm0VtsSQ1qAw/gtERcfXTDWXjoSdtzPgsoCZD5y55mWskU6k2OFK4D7ZLMoA7M=
X-Gm-Gg: ASbGnct4ulmqQhhFIYPXQBtDdOKiZ3CdCe7Hw2JR+Sru4yvi9ueUXYJyBgbs9vZAdad
	MzdumQTXPOeR7IvLWXpi8SbrMU27SusNQOKhezobddadhImeA44phO3n8/jJvMfJfpWIvugd2W+
	kkcNhgYThz0g12Bjxp9qqs7+TgEcigCa1C08B1Is/w0xQby0N7w/xMvPaIWxV10565MXBkhJCpj
	NbTqqkpdODxZWZeQqPk+liWIDSYuZLyyXrsCvMne2/1DQTW6kYB+NCxLUHS7VtuoLYgvIdNbM8Q
	CxUkMw04YwPSG+kxFk6KIiQHxH58tkvsj5fSXOtIfe65Us6495mrul/Cemd881B01jO3N1iRVQl
	X4IGdnatMjNRO+/ojyaT6XEUw2vDc5dxYYtyTkpbSYD/n4/MwwPldlgtTgVdgE8C5n7DnjZmQ3/
	jMRrFzNKFoSLvkUw8W8f0S1EuWhMDyO65W7pHQlf2nRjd0VxQgyULpQ30irLeuidc=
X-Google-Smtp-Source: AGHT+IHEJ20/piBU7YOuFAuDIHAXabWarffYfeSdFbAZ/TJ7BVINPJu9h3FE6SZpYUveWoSWx2Tx3Q==
X-Received: by 2002:a17:902:db11:b0:294:f1fa:9097 with SMTP id d9443c01a7336-294f1fa9228mr37402885ad.34.1761832635722;
        Thu, 30 Oct 2025 06:57:15 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e495e8sm187071905ad.110.2025.10.30.06.57.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 06:57:15 -0700 (PDT)
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
Subject: [RFC PATCH v1 3/4] riscv: mm: Enqueue tlbflush info if task is not running on target cpu
Date: Thu, 30 Oct 2025 21:56:51 +0800
Message-ID: <20251030135652.63837-4-luxu.kernel@bytedance.com>
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

When need to flush tlb of a remote cpu, we only send ipi to the target
cpu if the task is currently running on it. Otherwise, we only enqueue
the tlb flush info in target cpu's tlb flush queue.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/mm/tlbflush.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index aa8f1304ae5c4..f4333c3a6d251 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -115,6 +115,32 @@ DEFINE_PER_CPU(struct tlb_flush_queue, tlb_flush_queue) = {
 	.len = 0,
 };
 
+static bool should_ipi_flush(int cpu, void *info)
+{
+	struct tlb_flush_queue *queue = per_cpu_ptr(&tlb_flush_queue, cpu);
+	struct flush_tlb_range_data *d = info;
+	unsigned long flags;
+
+	if (per_cpu(loaded_asid, cpu) == d->asid)
+		return true;
+
+	raw_spin_lock_irqsave(&queue->lock, flags);
+	if (queue->len < TLB_FLUSH_QUEUE_SIZE) {
+		queue->tasks[queue->len] = *d;
+		queue->len++;
+	} else {
+		raw_spin_unlock_irqrestore(&queue->lock, flags);
+		return true;
+	}
+	raw_spin_unlock_irqrestore(&queue->lock, flags);
+
+	/* Recheck whether loaded_asid changed during enqueueing task */
+	if (per_cpu(loaded_asid, cpu) == d->asid)
+		return true;
+
+	return false;
+}
+
 static void __ipi_flush_tlb_range_asid(void *info)
 {
 	struct flush_tlb_range_data *d = info;
@@ -152,7 +178,9 @@ static void __flush_tlb_range(struct mm_struct *mm,
 		ftd.start = start;
 		ftd.size = size;
 		ftd.stride = stride;
-		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
+		on_each_cpu_cond_mask(should_ipi_flush,
+				      __ipi_flush_tlb_range_asid,
+				      &ftd, 1, cmask);
 	}
 
 	put_cpu();
-- 
2.20.1


