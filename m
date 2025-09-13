Return-Path: <linux-kernel+bounces-814943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF060B55AB2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8F91C209A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01FE3BBF2;
	Sat, 13 Sep 2025 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj71Owpt"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE331BC58
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723355; cv=none; b=kuGjWkEBYFzNSmtMzvewyUrx+TpCVhuw91x7LjM3S2lQ2Oxt9cMdEH1ufzh93cHYvgZRi6g9y2w/A8AsXSIXLYfJsevnzZ5zaCLUAULbC+mP6bBDK7I7HgPEA4Rl/x8fHsST5k+xo3Uq5Y024FQaM/5a/KRHcNW+HXMcOInxUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723355; c=relaxed/simple;
	bh=o/2/1rLuGad7KFL3fjUL65woyzwOsWRQ8y/k/9zJK20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Fsk12Rzs3/HAr9olH1h+8ZEgxO5RyqkuNa9uXQMtCyXXkXB2sH70CIaY6r8EIUkW/ACGwy1oq3areMnLBgS9ItAm6EaicTczpYTmncWKPy5hhNhKJpHH0hsK8LRJAECAQr2bpEfCmJufSPcU+Daiwk0vkiDEYgFUb+uMUk1DaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj71Owpt; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea3c9376d90so2372569276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757723351; x=1758328151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmOJuo57ImQUiYUwmR7+IFwJm/0Fqs9h33y3GCq+M5c=;
        b=gj71OwptWQG7mCmzxuaA0ydwXBePe5CyIuUOSya9fRDbxI97LESSteSA8/rEWvv+Au
         FX8GmvUg0LxhJo9GzKnZwOcCWDu0sSYVIQU5yBCz763BPP6+T7cGp2F6+7ZWIC+c+QTZ
         kVRQBELaJ9pNyJ35FV+ut/ZNgk1pBVoUcjMUx+JPTClE/PwOquVFKdO/J96Ff1cTIeIy
         oLANtwHDwyVDp2HDQ47a8ipWeTEN++WUjJZr9PMmOuNlPQvRwD4O3UYxHl09PNvx8UBS
         Gqs+RD178sDsq+qdOvmsB7W1ZqOhZJ+X0S5ddU1ex8QMo5y4WB/JeXqwTypT4cAMRU3B
         srbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723351; x=1758328151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmOJuo57ImQUiYUwmR7+IFwJm/0Fqs9h33y3GCq+M5c=;
        b=US7MK4+IVBbgtBbzQGRVc+ihPGjC5JqHCiHG3QT3fX24H9LIIr4c2Trgk/nx2urgJO
         OunJEFkbMGsT10lpO7wsXYvSHlGez/XGc9RZF6PwNSF+0t6kkTiaE0dcPfGX3p8sjHcK
         X4GaEMYyNsq8TweHf3/0ie2HsCk8aKmAmRyCNLjCZfNFY70tIQxIzF+dt8JQLKJcr8qm
         SiRzMN9bfUzJxAsafGBpE2T8tPWe0xzCUb55g26pUMdDb3AayultaU3lBPV2ojjmlVaA
         NZ4F7l+POkkH3qDbKR/lmWa/gyYWhGSeSReCRAst+1b+WDnfrLQsaPeP32kjgqTMiGNi
         3AMA==
X-Forwarded-Encrypted: i=1; AJvYcCWkCSdNM12hp3a/GaPl6S55bF8HmgPmdC5vprVfv6KNtHOFRc/OCLPBiVmYf+Njmm4HiX+BGDn/f0SJ4/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVqK7TVkn2MSxqjxLWf8Ib8tPknAgCc07v7jZLIk8q+KJnlp4
	+UYKUzqMQ11C4rnMP4SIMtI2riFDIemDWD6CRqSun82Qbu/v8ZYl3GDS
X-Gm-Gg: ASbGncsavFaR8U8IXs41BYVbQEqk7KsMW3Q0Bxqe5jFWw2JLuxMt/aiiUpC2+0+jRGg
	fsHZENQjdaV1QsjOqcfhfoCuIdQWg9r0hSLOb+VTALcQq8W90JPgXrQSq6IB+w6x0slybr07KDl
	gqslXXUbO5FZ62CWioNT/SAScTU2tAqLQo0UxNVhMcXP20Jdcwcx9e9Os3G3j6nXJovThkkwcl5
	RceDiHRjzX2OcVrbYYVUwv6b7qcntZmq66DbHimtF4qZ++elaUqMzNsWPzhGZNLWchdxmHLVtJz
	/FHQUvNCUDMSa2Bho+4dRfKKCChZgmGbzjU5N2xYvS+jqTRJ+zMgtmvoMHQnqOy81xHsX8trcOQ
	9wl+vk3F4f24I9T/uRFXtCyOQU0Ce3nMqxqOl67FxKPayS5aZ8WfiyE2UrX5fslFNqv19
X-Google-Smtp-Source: AGHT+IEtdwnNl1zhwm0zJTMTaAzTVGehCEQNymipUs87iXcurGE3yl/I9Hy29mFJtQZMSLEbg45DmA==
X-Received: by 2002:a53:c541:0:b0:622:6078:42bf with SMTP id 956f58d0204a3-623389c38c0mr6011595d50.5.1757723351254;
        Fri, 12 Sep 2025 17:29:11 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3cf211a04sm1793439276.20.2025.09.12.17.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 17:29:09 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Xianglai Li <lixianglai@loongson.cn>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: rework pch_pic_update_batch_irqs()
Date: Fri, 12 Sep 2025 20:29:07 -0400
Message-ID: <20250913002907.69703-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proper bitmap API and drop all the housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/loongarch/kvm/intc/pch_pic.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 119290bcea79..57e13ae51d24 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -35,16 +35,11 @@ static void pch_pic_update_irq(struct loongarch_pch_pic *s, int irq, int level)
 /* update batch irqs, the irq_mask is a bitmap of irqs */
 static void pch_pic_update_batch_irqs(struct loongarch_pch_pic *s, u64 irq_mask, int level)
 {
-	int irq, bits;
+	DECLARE_BITMAP(irqs, 64) = { BITMAP_FROM_U64(irq_mask) };
+	unsigned int irq;
 
-	/* find each irq by irqs bitmap and update each irq */
-	bits = sizeof(irq_mask) * 8;
-	irq = find_first_bit((void *)&irq_mask, bits);
-	while (irq < bits) {
+	for_each_set_bit(irq, irqs, 64)
 		pch_pic_update_irq(s, irq, level);
-		bitmap_clear((void *)&irq_mask, irq, 1);
-		irq = find_first_bit((void *)&irq_mask, bits);
-	}
 }
 
 /* called when a irq is triggered in pch pic */
-- 
2.43.0


