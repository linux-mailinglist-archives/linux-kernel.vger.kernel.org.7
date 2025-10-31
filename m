Return-Path: <linux-kernel+bounces-880019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4891C24AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 789F14F2F45
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215D34403B;
	Fri, 31 Oct 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yurGqlK2"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD9334C29
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908478; cv=none; b=h9NWHcDM6nMJLxIjqxu2DbBfvEvP6XQrhixGJBdH/5k0DAl9vGEhcU9SvL7vO22cNuXO1NieHG3O5uRTc8LKMXb9IKGh05sZPZlM5BTqYzvW6nSpjPwMkIYph/FCVFopcK08MkBt/aOa1VuQaosKK25r4JBpaESxo43Z6u+42rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908478; c=relaxed/simple;
	bh=vo0fv5TAORpmA4ondFTRITepDO0rRPiPHhnW/tjjfag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhtSl0t0So9GAH/odeMGk20YoVK1/q98j2/LZcorbrmMhTHHRYG023YJRrEprmX0KZE+jFq2S2nMvXaruaVy3t+sy3LUHZL9z1pvJehg9CKGJKvrN04v8dHV/oGIbK1F7qwm0eHY692p+WPPLsVqgYhYj0bWVbwEJA/8d7LR7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yurGqlK2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592f600acb3so2969272e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761908475; x=1762513275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGqVXPX174dI1TmkMpyvoDpe58SAFIHrUIhMpLUiKvg=;
        b=yurGqlK2vO1HSb3RSvLfeNOgoR6zzC6m0eCZMCFIQaGAdtL91hCrCSbD9ve8kXSe8P
         B/9+3CriDcNV93++G44u2/RF1ewS0xmIW2tp8e0A/UA1jfkPQTVMkklzdaGsjhWRmmKo
         JHtx4c4+frmOXBYAc7Y3PLtbiFpB0p74+GACNE1VElFmyuS417apDLrbhvLo76CRYBF/
         /2BmowZvCCivq+HeZRFt7zn3KT1rKdokIs8MCogdA1W/3HsxbZb0wh6d6lKMmsq2roXj
         mlox+UWZ8ui6B7/Dv1c5d/xSuoX9071lifuABfdBtmHUeuVolXeL98xcAAP5ZVy/Pt5+
         /RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908475; x=1762513275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGqVXPX174dI1TmkMpyvoDpe58SAFIHrUIhMpLUiKvg=;
        b=fbNLLVeWm38FJhd1JjthzucOffGt7ml1aRfS17LCPBKXbi51vKsv1E1AEigHk75zDv
         B/rcF/w8NM9rS8P8obPcmSJEQVE84QyJpL+2D7SrXl/kKzqe4W+Kk9NrshpKbGP/fe1D
         2LNw5YCUHAyuuNgB0FwAIZihlRlTLajxEi8KacxU8bzmyanTOKwm5B4UoSRP9Hd1DboW
         yJnZjnxvbWxJyc59sRXxtV0fjla6wJ4GuyX1stNZijTzGaFKiMBrrB5rXXq5LpQk89bp
         0QQ3r6Y8gZVcyrxSDWHboJzDSVjZl/ZZb81oEmaDkI7k2soPvvIITdewYJ68Y3BfTMIA
         S1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX5Wa0eFnOgYW1Tq5ur4TF9mVEpx5+8YUp1bqO1tQZ+6Db3AvThNyyObrOP+6P+p5v425klbrPVr9FbZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZQBK/MkR36rVACbNIqi+VWz8JMePZG+H622abgPqvrkBpWVJ
	8OedQ4ihIDEID+KH1P3gn+TkXpZQTdvXeaUiBegk/gihdXWdwIJNQFmFng0wxX9MqFQ=
X-Gm-Gg: ASbGncuagZA8zSutHA3WYAVGla/3dyKnhZYiFWaFpXEhlgoTn5iCqFQ0yGd4vCpuu9C
	hK8ednl33a+sczHU1yG/Hc78wtRjzs+EYyjbl4Tj6IkGR9TGNfzwL1HICPpwPHPM8OMUbJYbDsC
	CQnlOH3W4CaWTjZE4VSsz9tW9vRnpc6ndpl7iDKRI/ks4hwlUn2d5+jFibkiPiLcu8HTEiCWmzO
	rSznQlpn4dGza8MXDAMhRlS/7VIY25b+r30N9+n9upTqAP2RfYK0D1uE8bpyiyET3XOoY4QUOca
	+1xXzyJbZ9UFuhOcpSOxOTNwNHCCtd+bgVdTd7XAXUKmYhjIgQcvBCGxgzZQacX9xcoAYDmDHC7
	9W2eNd0q/z0E3GdUUvqjh8VL9+ZOI9XkV3itweSLZ+SOlhF6KOeZmb9R09F3qJEiri/eTqjYb6E
	vcWFgLj4Bn+srpmCqhAGNMIDAusn6x4hxwDnPcEkfV0A1Q/jBj29sPo7I9/4BB
X-Google-Smtp-Source: AGHT+IEJlHlKeVgDybBDloCVX/b/55G16rZzd9wktKjKbh8UnSTpKxD5S3XdnZkoiLNP4Lmabyt7SQ==
X-Received: by 2002:a05:6512:3c92:b0:590:6e62:10ca with SMTP id 2adb3069b0e04-5941d57f50fmr1302080e87.57.1761908474417;
        Fri, 31 Oct 2025 04:01:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bbaa9sm432721e87.77.2025.10.31.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:01:13 -0700 (PDT)
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
Subject: [PATCH v3 1/2] smp: Introduce a helper function to check for pending IPIs
Date: Fri, 31 Oct 2025 12:00:57 +0100
Message-ID: <20251031110106.62394-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031110106.62394-1-ulf.hansson@linaro.org>
References: <20251031110106.62394-1-ulf.hansson@linaro.org>
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
 kernel/smp.c        | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

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
index 02f52291fae4..4533e666152c 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1087,6 +1087,30 @@ void wake_up_all_idle_cpus(void)
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
+/**
+ * cpus_peek_for_pending_ipi - Check for pending IPI for CPUs
+ * @mask: The CPU mask for the CPUs to check.
+ *
+ * This function walks through the @mask to check if there are any pending IPIs
+ * scheduled, for any of the CPUs in the @mask.
+ *
+ * It's important for the caller to know that this function does not guarantee
+ * correctness. It provides a snapshot, while being as lightweight as possible.
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
+        return false;
+}
+
 /**
  * struct smp_call_on_cpu_struct - Call a function on a specific CPU
  * @work: &work_struct
-- 
2.43.0


