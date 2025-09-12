Return-Path: <linux-kernel+bounces-814356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315BB552D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE55AC511A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878E314A65;
	Fri, 12 Sep 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAOMROtg"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B40321435
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689840; cv=none; b=E+8s6QLiZHzb3eMUnvjiW+WqwqfJBHPFEJiIxdWyORf8CBURHKS7eJCtY+HnAX3QSTvZeLXkP3hbVzqXDYdYxr5uwhm6YgL1tMFsnz86m2is/wdzu9Qj7zEBOlRvVWI14fPu+I8YJShod1lygA4LgY44FgbO9Acy/J19t16/9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689840; c=relaxed/simple;
	bh=lBamo/mRxiUtCBdbmIZyVniV6pvujs45sCbA4KFEQzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEHfKxCvYRnSEDbRETjtmqp776r3vcYQgT6fQ1NMAKpcsdD/hHG4qCxtzhoPeuVOFrMoPVLgjl36bjz9qZx8FwgYR7uW1LK4TyzBXIDifN7fsw87Fdgw3iRkhApCMmZnicLazQcgfQKtAZdkkg+1cB/8kn9aiFvCPM/MXi6oG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fAOMROtg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60504bf8so19144487b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689836; x=1758294636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ds8gslyRhEA90VqYYB6jUYRwIuKnqG3r9jdtCHu7D4=;
        b=fAOMROtg/82tIva9GG3Qq7B1/Xo0+WLG/MAQv4jrJm8l+dpu/m7w88+hJOQUjbEBCE
         Q/c6F7hcNX4R6eSvQuECiTJ/TwZ5ordlY296OA611EL10F6Q1XB+2shpcmNX1wJysvwv
         NOh0HeeJrlREnwXJPTUTPDanh1+wbk5RqHQ26uU6u2xA9a2cR+CzZhb7PNYnsb0MizPk
         vfA0nSyqNet2mhTreKSt6W/pq1aHgIboBGbT4SMlpCiDS1qWyPIW2mSg10P7JSnWUfnN
         dgEWo/RJpZfZ7WXd2RPHPcUbUJGClDGaXmF6kF1cvaXdV1OhTMqaB58W9YZMg4944Pzp
         7LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689836; x=1758294636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ds8gslyRhEA90VqYYB6jUYRwIuKnqG3r9jdtCHu7D4=;
        b=nZHDzWS7n/qZSaW2jJ8WkogMkbdbmMIjrtx1/RDr+bhFt8hPLVVTASVYFrR8CXhF1R
         N05GpI2Ybz86foIdZgY+qM2Xq/GDQRzw80+O/1iNdkPo85QoHyjJbEhRaAo6wbCOFWYw
         +hpI7IoiS2APBZRVaVRb5avTehBTW4RrBHptG+a6+1XNUCStiRWCRIltgAoYtYUP8zWQ
         kLPt5erYcvvQKe1l3+zUOqzyO2z2400bKzo9zTK1zEoKb888VkJCVsc5ONHPgMveWtz+
         b9hV7uP2QTMAuwXefYZEqCSY1Xr2B/kX1R5dm+uFgIVGaq5LVLgVw1mFW6+t4PRkCRvG
         U64g==
X-Forwarded-Encrypted: i=1; AJvYcCXBC0RktN6a/GmB1qajZInB9uuXE5E98ydtz6Ru/qoeWYzhJwxSQWXXIk1wKk9bA4xpeQ5pSzLPQA5fsh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSmEg/1joqCb7KtNbyKYpOf7bl+q3GP1ZwA2pgPj+TLbZ2Lfu
	CP5h2MYMB31JH0gQrRNvvEbX5CHOJRyDXS0h9Mvr1Kd5+yt+emCokQc11aeYOp9UEaI=
X-Gm-Gg: ASbGncvlwAkogz9jIRB6UuS4YzZt6yWAPPxhJKNkxCU5s/3nzSTjZOdjadd6Oc8EpV/
	vyJ6jnfZGmMEgNPrHmLJ2Y2nkastt5+YJcP7zcJn4uQAKiiu3JVWBvrTzJWQXGO4eQT4DCc/AmU
	aM6w11rERM70x2ZntzSoU7ADgh35zZ7srYgsrTNg5wc/L2jjEGyn9gXft/re8ruCPdNywJUXcTL
	DCm89UN7h817gz5qyY6/JGRRUk05rT++PFQ0JlVDo5y5eAjHyoNq8xuZ2GqD9uRrqGdOt0HHdxG
	2It9RczHXgSH/9/bPlzbT9pYj4QUl+1lz6IS+5h8+K5dBju1sJ6xRDoQyHZYxlXm+yode/tSDY5
	/C83KtfnFLHdKqHCmIQ8YhCjOn5TDBTJCqg==
X-Google-Smtp-Source: AGHT+IGUk5zUSgxh+r2dAU6fmhsNlb1RTWa2J7nuwDb4l4jA+t4jqiomYFBGdZGHaaNJrIZspvEapA==
X-Received: by 2002:a05:690c:7286:b0:725:dc12:3004 with SMTP id 00721157ae682-73063d589abmr33964367b3.22.1757689836260;
        Fri, 12 Sep 2025 08:10:36 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:36 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 09/16] genirq/irqdesc: Have nr_irqs as non-static
Date: Fri, 12 Sep 2025 18:08:48 +0300
Message-ID: <20250912150855.2901211-10-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_irqs is required for debugging the kernel, and needs to be
accessible for kmemdump into vmcoreinfo.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5..6c3c8c4687fd 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -139,7 +139,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc_smp_init(desc, node, affinity);
 }
 
-static unsigned int nr_irqs = NR_IRQS;
+unsigned int nr_irqs = NR_IRQS;
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.
-- 
2.43.0


