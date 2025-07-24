Return-Path: <linux-kernel+bounces-744402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177AB10C66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D013D582D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FA2D8760;
	Thu, 24 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEOHDd7Q"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425702E425F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365395; cv=none; b=ccy6zXw6covwm9uBh9POwH8Z+cTNp6VoswutHm3juQ/subQBS6G5JZzOcVzgT5nZkHZ7dqulYDoIYV10fnDVfpsk6VXMxcRlZnirJ44z9EGE9lcJ859m5M5qu2O/YIr3yWzUQC3EgTELhRo2gDE8F7BYWi9885o+YFtjU5agNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365395; c=relaxed/simple;
	bh=ghY+GwpjKzXQo2zgURX2uB3oB2874ijEbWShVaN08k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdcH/o0yjCVk74vo8ZFhoO5juFjhwbPc+MN7YHCJdg0qNHvuam3AbNeVp40q5oOVdyD6TferWJcHFg6rHoXnvqh1M9w2Tia5WvC8pyqmQ1EVbJ5IClGGup/gwLgLg+9XP8S0oA2vG/HNiIttQPUSaRFN+nwj36z/nMnHWzRsXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEOHDd7Q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso722751f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365390; x=1753970190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SReSPaHbR3saXb697Yp9wPF5rwCm4qBMUK6NGh7oWew=;
        b=rEOHDd7Q8N2mYG5T6Unnixnoe176QqAN/bsTATidQzaTXYl8x6Fl7kfvxRo+ZWK4pc
         qMPiNcCtEXI/oOonec1lsGzrOXHoDqJ3VDuKDkuiRI9iifVqADHi3VMHybE8rEeRnfT2
         craY5TpZD6e5/X0OKbBzvy6zU6R5MiPYMHWfNs9a8ertibJByaQ1NYIaJ6koM5ZnZ0Sn
         7NpwjIqHtMAAtK6Y5G8b20QQ9wWOoneaAVnyoKgbSWe+n7xqx4hzWKiNTIIeQU3fJn6l
         eshPWsHMwEdHl5/6TtzTyIIVGndSQqVeaTyF7w88+qvU/tpL7QZ0qI2fL+YnilChs3qE
         Y+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365390; x=1753970190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SReSPaHbR3saXb697Yp9wPF5rwCm4qBMUK6NGh7oWew=;
        b=PQ5WiPsdK2DFxfHTPYiouJsL+za4+sW7q66VBylV4yyuyUKmNiDHzZT0+2fb0YMuEI
         SPm7R+ZQxyGDxn4+F4RhqL0AXZt1neIx8dOK7UtVvng1MXGdWggH5aCw+0yMkVq/FudZ
         SZeBZ0repHYNis/VCd6E2tJ93DbET2pQAELZtMqHpJ+4ERp7sNCTq1sOMYGTF8gofhy3
         8yVP6d7q2yA1vGF4170ABsCu7wDQh9LWBzM/e27B2NlFR0NGv7rDEgCpRR/OkppBhWYS
         OWe8Ti2z+FPYL5cZV/ZvjTwoxAef/bRRDkq4ZMm9iWk0crBsNG39AS9SEAMKmNKa1u3r
         /R5g==
X-Gm-Message-State: AOJu0YzEQh4G4RtEYWbxMiKcZ/HGIFF7zI81HR7+PqPDx0G0Zz49AZTM
	FRDv5n29eTTyKhA3oth+//bhVIdh+vqXy3EyiMwk7hbTQVz1ShS//srMQ2RM1/ThYFFzatAAvTs
	MhQEuBR0=
X-Gm-Gg: ASbGncsZ+exwnCfhkDWMVwP4MpKWLMsH8Kqnu9mFHuyc5DeO2l6infxQurA5LbCSeF9
	ERXKAEv+LRy1KTs94g0pRBzsPVrpd1r3jnvuDXeVx1uXVDsx2ZuoqwsEJsDa/sxCMDAI08PDtxZ
	u4qn1MEl7Tq9dXw59NW/3uTahigE/+ZYTlbaQhVHyP/NIwYSphlOjm06iVXT0rN7M3pbvfKAt3O
	PRHMFFq9sH6wfapr1GKBTozLKF/rDW6+xaS/ojFw5BLQIpEHEfWe5ZDwAof40GSUDQpA3Zx21kq
	pB+qw2N1mZkql0k6g/CebnQx0LGe4ySbCsSrMtFjvrWxqdGSKkANSw20oKit28D3BTWyhkP+XN7
	3iDXXyisWYN8mCp9nBgeov7s76dX+Cym+S5FMU4T9pVBOdQFn79LDN1XxRWNsS1V9h/a2KvBbAO
	/A3F48pokbzDBG
X-Google-Smtp-Source: AGHT+IE5OpzTZyLft1dF8PAF1zWD0A9y1GJkIKlmiY5JcqmC3+aHq3C9hKZiU8MWr3uj6ilv3EjyHA==
X-Received: by 2002:a05:6000:2c0c:b0:3b6:333:256f with SMTP id ffacd0b85a97d-3b768f27e15mr5395112f8f.58.1753365390310;
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 09/29] genirq/irqdesc: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:52 +0300
Message-ID: <20250724135512.518487-10-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - nr_irqs

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/irq/irqdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b64c57b44c20..6d11b85be2b3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/kmemdump.h>
 #include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
@@ -140,6 +141,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 }
 
 static unsigned int nr_irqs = NR_IRQS;
+KMEMDUMP_VAR_CORE(nr_irqs, sizeof(nr_irqs));
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.
-- 
2.43.0


