Return-Path: <linux-kernel+bounces-841426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548DBB7473
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB471B207BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6F284B2E;
	Fri,  3 Oct 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3x9rx/E"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4D78F4A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503795; cv=none; b=XD3rq1DY+PxtKzF5Az4DmkBs2LFyVNE0T/gsHGFDAviG01fevC+lABNgd653zZp7jZdB7z5JLKCI8i1ihVv1IoyP05RbO3nFO8gyOv3byvTle2Yn4q89klELM+8JaXPVf38By47Bzkr19lUh1mXQI4X0J7uzdQqcS0PYI/Dcb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503795; c=relaxed/simple;
	bh=cwH5NZo2bh906tN8MwSEO4J3T9h8Rf5m3rQBSanhKP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC8ASWtnqkX0ItIGNNM2gj6E1vsaYzwxTMFUDCmUUmMYs0WvlvEfGNDUxJtZvtxFHqOOBRBHBWNx86c/AiOwWF6oGmlKEQCOhRpm08UD4w/Gay7/rNDHtndItOmwgmJ2Vmj9bGb+dw1lXpEYWG5NrkH17Ju1SLQGE0s7svAyIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3x9rx/E; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso3272736e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759503791; x=1760108591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiWd74ZCGfHByAMCCnxU+D58hX3cmoUbDQ+hmZwcLEk=;
        b=C3x9rx/E5KH4CHXMNbzd/GPMRpOS/WeCLtqaiEbbMmhV5cnJI5dOfo0eetk8xdA+dR
         5VWEeL8TA0jhje8hiKSNbtSz94iB5194yAmqARawOlTq73UQwAsYPNS/b7VTWcc0IELj
         8A1/jQ5Sg0saQe5SVAju8scao3sw8Xx1dSpBBs+wLu7vdqHoNKMGLD5CMdGGzKBiZHIs
         qcKDMyySyEnxQm3xHeM1sKpXHHN//NRgWayRguCidkMkRBj7GE0Totj9S77lX/yjQ6tC
         X/DqNOoG5dOlAvejgogmp5VyWvdDu3ANgcLSSMRD/5dcJj8Itui4ZqIP/PJztZRjtoSw
         8dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503791; x=1760108591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiWd74ZCGfHByAMCCnxU+D58hX3cmoUbDQ+hmZwcLEk=;
        b=Makpmy501kcdckzSc8zg+GC7fa3NbI99fXT/6hLwQIplI1jFtJ8SwMuX1eFIlSqrEm
         wNOsaQJUv5XqzQxyDmINUMbkwh6arEHT/fctZvuwSgUeCOXR1PooubseXFenSvvWEQp2
         7vcgmTozYW0P8dVIptsJJeiXJqcviHRtnZVUhxqtCGoT3TuoF5mSKTji5sonGjpYs0/n
         iZmd4mu83Mw/YEDBJtnIvKtAxnZiphO+CfsLKCtvfXl4ZlXCO7fpWqHEah7dHbDdyR40
         6CpGBEy8Fav93P5nSU1WnLsMz4sX6mchgc21zKxLzhbrIaJpxrPAPIEe12aLI0VHK+ZE
         RsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Rka5qmESQvWEYMAvBXTDG269yZCbrVVXT8AfzydTGsf8uzuEXOMQ4uYiG8GnVPB2H7bRWiwbVQRmxr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysqTVpuOm2Sp9jrEq4U9BNqyiuzJ5STq6Q1ky5Bv7npw4f88Xc
	clPpkEYGT5YdLTouzxxI71Pco4akCblPQYbrdbkkI0XWOYjE4kz5jDnzKmYH+B2Kjq8=
X-Gm-Gg: ASbGncvyyBleF1zJXgjma80agW6iAiaqo/p1m6U1nOitZkNS0CQ/0tRvn69wN7akIjD
	OhdZJphYvUdUh7jnStQiDGLM9o6DrGufN5uF6dWwjdvxQ+AzF5ktsvDiTbB2O5yoHWIaJeHuQf8
	MhZAZ8/JoxQBF6elCLFWoRVP+WsEYUBY1m35sh2Hbj0AKyTbT0Io1xCSeDijItCel9e+uRi1mhy
	IpRqlLu20Jt8vLXpk77wSgo7iu+orpa090lzFMnp58NqI9oZzBUQahwyMsEhA8jmsZG6gnPo7V+
	0yRAP1s1bT3Vqqq1rV1j9hP7rmCf4bMykCF54mgeCwnDKVAFGAd/2xljpCmNSztgyL0C5GvuuS7
	KOOCVPQv/Q5pGp/wZXE0YiQgwW163P256YZXecqZtd1bIpIe5hmR0T0fmUaPHBqn0Mtck+jJQ9Q
	8w2zhnGEhO1NV908ZWGm/6SxlV
X-Google-Smtp-Source: AGHT+IGyJEOVsOGaJivQixkkTNrPfM7QlcKiFG+WBD/H9sXsSIxK6ThXRU5bBxi3vw/zF8JXbdqp6Q==
X-Received: by 2002:a05:6512:6193:b0:55f:43ab:b220 with SMTP id 2adb3069b0e04-58cbb4418e8mr977737e87.34.1759503791304;
        Fri, 03 Oct 2025 08:03:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011343b6sm1933369e87.35.2025.10.03.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:03:10 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
Date: Fri,  3 Oct 2025 17:02:44 +0200
Message-ID: <20251003150251.520624-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003150251.520624-1-ulf.hansson@linaro.org>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To add support for keeping track of whether there may be a pending IPI
scheduled for a CPU or a group of CPUs, let's implement
cpus_has_pending_ipi() for arm64.

Note, the implementation is intentionally lightweight and doesn't use any
additional lock. This is good enough for cpuidle based decisions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/kernel/smp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 68cea3a4a35c..dd1acfa91d44 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -55,6 +55,8 @@
 
 #include <trace/events/ipi.h>
 
+static DEFINE_PER_CPU(bool, pending_ipi);
+
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
  * so we need some other way of telling a new secondary core
@@ -1012,6 +1014,8 @@ static void do_handle_IPI(int ipinr)
 
 	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_exit(ipi_types[ipinr]);
+
+	per_cpu(pending_ipi, cpu) = false;
 }
 
 static irqreturn_t ipi_handler(int irq, void *data)
@@ -1024,10 +1028,26 @@ static irqreturn_t ipi_handler(int irq, void *data)
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
+	unsigned int cpu;
+
+	for_each_cpu(cpu, target)
+		per_cpu(pending_ipi, cpu) = true;
+
 	trace_ipi_raise(target, ipi_types[ipinr]);
 	arm64_send_ipi(target, ipinr);
 }
 
+bool cpus_has_pending_ipi(const struct cpumask *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (per_cpu(pending_ipi, cpu))
+			return true;
+	}
+	return false;
+}
+
 static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 {
 	if (!system_uses_irq_prio_masking())
-- 
2.43.0


