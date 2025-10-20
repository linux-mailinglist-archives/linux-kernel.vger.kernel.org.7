Return-Path: <linux-kernel+bounces-861100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B492BBF1CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F784F602A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CAD324B0A;
	Mon, 20 Oct 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYkgzrz+"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1A320CDF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969856; cv=none; b=PWxKMQmZiy5UmnKV/h5cPnPVy3GryS0NxpF0IjnQfdEMuh07qDhn8CCNm+d3Pfm0YEEx9fZt+2YH9foV2Wiwp0Fmu0FAWZJD/HqnfQV8rIAcgWUvofWry8zDPPq9hF7QDL6hyOjkTHwmRfTFYzPh83vDAv2sHursbcR1H0Y7N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969856; c=relaxed/simple;
	bh=eCdD6Rchcv/zsQaGx/OdGmxf9oXHMxScoB0zys5/ino=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPeoRcVtJheA7/Y5jpe4ZgfF8QkpAHuC0ZId01yU6+VR45FNun8CXmMPEx/2wQHBM02TFcVvaHaLG9hsntF0VWxPO+zCUuBFDiw3ICW2hAw5oZEYWmMfk6nnTRxZrEhY8kSesNQgouk1boOYwVymd9ejBSJWI33n6H0yBUC7tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fYkgzrz+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591c74fd958so5561548e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760969853; x=1761574653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dIjv4MSR8RQ0lSEv7ckZWWm3B4P0BM3xvQjsLdtr2E=;
        b=fYkgzrz+DE4Rr8AQlZr5pw+0F61dyLcX8QvxjQ/cPsVuK6mwTM9w6teN8jjORE+DZ+
         uLxTP0/z34waFD10GyU5iv581wbw9alCCuns0Zwbf2H74a10bqWi/VWw8dIvRz6x/ogB
         dwG6tVMTH34iYwEy7vYlc8/ocofePB+M9Lmm/BBpf8gg8OWH7eTXak0hNUX+/VUyq5Vw
         BkAWk/r2Y5ozo7uyuiLuiO8HHCIWwB8fLCa6pqRUpPBxrWf3Sl90FSMAQCirihO1JcF7
         5cF4/Y71XWjXx2xHJqE3G9FCEAoIvIPXsIXu7+Mx+DS+gUuOOItlzY5iiTeBw0nsAMg/
         F0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969853; x=1761574653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dIjv4MSR8RQ0lSEv7ckZWWm3B4P0BM3xvQjsLdtr2E=;
        b=jRPHSCO6NnaIJwTzsWkKF26Cuyn19VhkLLjt+X/tlVQVV/KelYl/ubNMzBT50zBViO
         8VuAN4EYJcvRBB/ikFg0XJmdHkJxAKhV8VXDjGpfAq5fleREyKeFu5YBBeNl5CXQcZ2W
         /fWVWz5kxIIfSEK6nscXWKXNP/33leSII0F+bcr+WpfqwZaFIy4SGJ+R6cSmKBbehwo7
         6FvexrnOaJ2l5iR2mPsKmwzf4u26G/IDVuLkwxbpmHQJbdbPeQJUgyY9EWVLSl9QP1V4
         pVz6hKsxJ3BTW2lvlPiLlTu2z3fuiTW0PlxBg7cATueDiKeA+4d1kduFFABWyf+rBagX
         K7ew==
X-Forwarded-Encrypted: i=1; AJvYcCXZPSSQ2z3kMu2QYpmsM2tZwITfkZoYJqedMqz6XQfcD//tG17vCfJk/b5xVj7Cgs4qz0t6LYP/kRTbNuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvuyxLsYgdUWDD5JtNlRehQi30TaS+U7pddbELADe1yUzIBT0g
	yTwhZLzVXwpUgrrKDipjAk2ttA8IjohHsGNxaZQkkRZV4wtJS/iunqVP4oWzlAVCOzs=
X-Gm-Gg: ASbGncsvkOaV+pZEzrfITEh+impJkMwWMkik62BnWVr6fpaBiiRwHZGdOL/OT3sP9NF
	Zs2hVHqSEbQyiVyOIsAqR2XsKczbf8g8czewt1D34JwMWP94KRfRPD22v4WIlFNpOoO/qheYzFZ
	W4fSZgc8WB5YkprcDi/vwog91LDU2EXDHun0y2LHG8nhRuf4A90ogIKwMQmu4HsklsT9y/s0E6y
	KMMza5YLVTFdypjQCxGFURtFI7P8FqHy/c9pQ1Lcrld5bhiJXwvJlfStBNiHby+m+5TqKmJbx7+
	GgGDT+uGwFS6M4thcYS+aYH59Zssejq+RBUTe0Jj+NWpgoyNVbQzcegxqK+WwbtlDU4sHUnXGFU
	/86b9D0n4ikGX+R1agQG2txpbnu+3GnfhH49DEPiYIKUi/AzT6if3nHINsA1hSrpjfx0gJ8fXcp
	hqs5Co3iTgRqBaRzdGgu1sJct566yQS/hiSVx1kYOb+XEjpF/GnQ==
X-Google-Smtp-Source: AGHT+IFC52orDQWOlIL6EQhuSMEzlEpPeXgxvFXygwzJXEOK1ypBXTxDyX/2RUJkJkcU3BSkgxWjfw==
X-Received: by 2002:a05:651c:892:b0:36b:b0eb:9d65 with SMTP id 38308e7fff4ca-37797815ebfmr36900691fa.10.1760969852425;
        Mon, 20 Oct 2025 07:17:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950a284sm20797191fa.36.2025.10.20.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:17:31 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/2] smp: Introduce a helper function to check for pending IPIs
Date: Mon, 20 Oct 2025 16:17:11 +0200
Message-ID: <20251020141718.150919-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020141718.150919-1-ulf.hansson@linaro.org>
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When governors used during cpuidle, tries to find the most optimal
idlestate for a CPU or a group of CPUs, they are known to quite often fail.
One reason for this, is that we are not taking into account whether there
has been an IPI scheduled for any of the CPUs that are affected by the
selected idlestate.

To enable pending IPIs to be taken into account for cpuidle decisions,
let's introduce a new helper function, cpus_may_have_pending_ipi().

Note that, the implementation is intentionally as lightweight as possible,
in favor of always providing the correct information. For cpuidle decisions
this is good enough.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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
index 18e9c918325e..093e5458493e 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -168,6 +168,7 @@ int smp_call_function_any(const struct cpumask *mask,
 
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
+bool cpus_may_have_pending_ipi(const struct cpumask *mask);
 
 /*
  * Generic and arch helpers
@@ -216,6 +217,10 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
+static inline bool cpus_may_have_pending_ipi(const struct cpumask *mask)
+{
+	return false;
+}
 
 #define setup_max_cpus 0
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 02f52291fae4..775f90790935 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1087,6 +1087,30 @@ void wake_up_all_idle_cpus(void)
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
+/**
+ * cpus_may_have_pending_ipi - Check for pending IPIs for CPUs
+ * @mask: The CPU mask for the CPUs to check.
+ *
+ * This function walks through the @mask to check if there are any pending IPIs
+ * scheduled, for any of the CPUs in the @mask.
+ *
+ * It's important for the caller to know that this function does not guarantee
+ * correctness, as the intent is to be as lightweight as possible.
+ *
+ * Returns true if there is a pending IPI scheduled and false otherwise.
+ */
+bool cpus_may_have_pending_ipi(const struct cpumask *mask)
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


