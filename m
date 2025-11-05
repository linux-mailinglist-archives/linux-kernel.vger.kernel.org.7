Return-Path: <linux-kernel+bounces-886203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE64C34FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0A466AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A72E973A;
	Wed,  5 Nov 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMi0lUAX"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF452E092B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336463; cv=none; b=eLWkj538FTVXrM9gMLtcgRWSrRYLuu4k6YA/lRmr07SLtIqvtQAa/vSs8pXDPemNyPgdC4vohJJNAAYujFYNKR2/1aCsqC4RF2ozm42BaqkE01W2+GhcCvaCPbbjBmSl/IiRhjxLEkRzK0mUKjkc81ZLAnGF/1GNBuObm+lA3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336463; c=relaxed/simple;
	bh=oEmRtHP8TWT45R41hhvYUvaDXkHwDzzB3aWJq/6X1os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjthGGa7cUG945wvbitKz9lUpdKuH+0NrLipBq4kb1vwNUJuYHsugjLSoQExligmiJGreQseeP+aKyPTe7C73UGp8qeug9c1EU+bXbF4O5zIT/7dgTiIJZ+UKRT7HPaTM0am6/EK4Ip6DIrlkizbkQ2eBeYE5MBmIwIsvwSTi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMi0lUAX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3c2db014easo1293512266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762336459; x=1762941259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbP6YVAV0u9Pb+chJqYZ5D7bpfxtenGbfwjte3E4IZk=;
        b=JMi0lUAX4ZYKLVsui1KG9IHI3xhAaEqWguP7UJaOkTDVbTVDLSNiBe8McorxIsYMcE
         Rb0Q4KSBIpFk+j3n4Ij699jhkoKRr9wVnJTlYygWWCoIhHc5nipLw+XewJt9tqJJotJJ
         7K834wB8g8n3cTdQUr+PGQM8U63cfR3t63HenZh0UFEcWbYp1KdHO/Pd6I2Ow8knICvw
         nHYkBp7FClZhu+1HQbFeeQjXi7t1dQ4yrSbFhW4mjrjQjLW9V+orL/ipxquZKOJZDwP8
         qqJ4fQONneNyvh9CkCbQmJXhHMxprqNW9huHxGV2v97D6FBognri+DJ+tKzxL0iC+svn
         9alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336459; x=1762941259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbP6YVAV0u9Pb+chJqYZ5D7bpfxtenGbfwjte3E4IZk=;
        b=HOHJefwZVCbMyBLFG7rbMHCXJax6p63ebNhURjJyEETySoBU9eEeJSbzu9F91RCjqo
         DTA/hBmn2DJOksWebUA083FciAKDI6/fjfOdFaqV3vbQ1LQPoZOt896GsTNzzcLechm4
         SQiycwAj1NAe6DJYUIwC8BnL4wTfv1cHNj1Ia2uO6Bp+H9NE73nQaQwCPhiQSpSDnQv7
         cYiiK8i1gmsuVcYqaIhE8aUQtkx1X8PUr8brPVG43JXwg+rviuC1EdDUcljyKsrWrofF
         yZq1mAAPYfDIFtAq6uUs1aCFzEDkTAA8evjPC8lq/g4bYHo5iyxCy39bTq+UkRXLMuF/
         FU6w==
X-Forwarded-Encrypted: i=1; AJvYcCV354DYykrhxQFhwbqIEkq9K6WZpE2dws9roPDWovDBWIEigJMQatfWUvZIXGVvCCk81YdwQBoEDivaqWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnzTeGWXDk40UOJ68EMex3U5/QgH2t4bpHVqL0CzE8MqHJYyT
	+UHSuIJ3QNNfB8wqnThSG2JFMqsL+xr2Qu8erXn4YzjagplQ7PSi1QCMmCqvzYAJ90c=
X-Gm-Gg: ASbGncu07WF7vzDlq3DKG/Foj4kQdo2IQc5YAPWyDJjQ4QmwN+iciSuOBBoYxhU0JA4
	UcyB4rYLiUCN696CSYBvSoYocSt5+Iub2KDorden+xLM5KelNztvPfbsdJle8oB6SwFU3M95Fif
	wYrwy5pZgFnWiv8OLFuIeT1Od+Nnw5OlIgmDoDFzGhlHI4xCstMKKNIeZR9hqvdGSXIn6SfW50Q
	zZguuOjCG2TDo3S4xKSvGr98hujdD5ZpLkjQXf6wBa6sZc4AXoepK7rWbEQ2WPIMGivHxwXI/7d
	j2iWFXNL1MTJZ/Dj6wpI15Yv4BeOX/+3ZukVC1PlGRZULHM9ksOmH7ZTBPT5w8eyryTK9mep1Q9
	C5zJfAqWsO9IqG/+lxAmJ9bE/b3fKDzb99+aKx8Pb2Y20aENyrVyQGj2n9qen27j20dJFrxNyAN
	MMuiP/xOHj1BnbVfGrBg==
X-Google-Smtp-Source: AGHT+IHZle33T9qlwTRkGN02HpHQkNiMF3U5c+dtAlLNyjo9fOwAHNej00mUS1o+kB31UkvOsNWXkA==
X-Received: by 2002:a17:906:d554:b0:b72:7dbd:3bf with SMTP id a640c23a62f3a-b727dbd0f61mr28623166b.43.1762336459365;
        Wed, 05 Nov 2025 01:54:19 -0800 (PST)
Received: from uffe-tuxpro14.. ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37cb9sm442571066b.61.2025.11.05.01.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:54:18 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 1/2] smp: Introduce a helper function to check for pending IPIs
Date: Wed,  5 Nov 2025 10:54:07 +0100
Message-ID: <20251105095415.17269-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105095415.17269-1-ulf.hansson@linaro.org>
References: <20251105095415.17269-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When governors used during cpuidle try to find the most optimal idle state
for a CPU or a group of CPUs, they are known to quite often fail. One
reason for this is, that they are not taking into account whether there has
been an IPI scheduled for any of the CPUs that are affected by the selected
idle state.

To enable pending IPIs to be taken into account for cpuidle decisions,
introduce a new helper function, cpus_peek_for_pending_ipi().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Updated the description of the helper function.
	- Fixed whitespace.

Changes in v3:
	- Renamed the helper function and updated its description.
	- Updated the commit message.

Changes in v2:
	- Implemented a common function, rather than making it arch-specific. As
	suggested by Thomas and Marc.
	- Renamed the function to indicate that it doesn't provide correctness.
	- Clarified function description and commit message.

---
 include/linux/smp.h |  5 +++++
 kernel/smp.c        | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 18e9c918325e..91d0ecf3b8d3 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -168,6 +168,7 @@ int smp_call_function_any(const struct cpumask *mask,
 
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
+bool cpus_peek_for_pending_ipi(const struct cpumask *mask);
 
 /*
  * Generic and arch helpers
@@ -216,6 +217,10 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
+static inline bool cpus_peek_for_pending_ipi(const struct cpumask *mask)
+{
+	return false;
+}
 
 #define setup_max_cpus 0
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 02f52291fae4..f349960f79ca 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1087,6 +1087,28 @@ void wake_up_all_idle_cpus(void)
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
+/**
+ * cpus_peek_for_pending_ipi - Check for pending IPI for CPUs
+ * @mask: The CPU mask for the CPUs to check.
+ *
+ * This function walks through the @mask to check if there are any pending IPIs
+ * scheduled, for any of the CPUs in the @mask. It does not guarantee
+ * correctness as it only provides a racy snapshot.
+ *
+ * Returns true if there is a pending IPI scheduled and false otherwise.
+ */
+bool cpus_peek_for_pending_ipi(const struct cpumask *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (!llist_empty(per_cpu_ptr(&call_single_queue, cpu)))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * struct smp_call_on_cpu_struct - Call a function on a specific CPU
  * @work: &work_struct
-- 
2.43.0


