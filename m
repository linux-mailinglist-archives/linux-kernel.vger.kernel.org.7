Return-Path: <linux-kernel+bounces-744403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6ADB10C73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A6E164DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF92E7BC8;
	Thu, 24 Jul 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gW9AcyqK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1202E54B4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365396; cv=none; b=nGi2rDUx/W1WdVdWLN6HjQRRRgxEeWScUbuBMmXUbvSwVohgrGtPytvX7CSLldvgyeuNTvjU5jILeIAG2ZsbtvqnMuqj2edLQv5swPaYvIS02y9lOSuiGaXQhVEBTd/1nnygWoJPkY9Mqlc0DCdjRrW9v2PB/zOlad7SUKlM8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365396; c=relaxed/simple;
	bh=lInkchUokjBe+FHAH3BxBiq6Y7tXF29NidQLxKe+PNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVjB7PyOiKrulKZk6aJ1OPfj//RQqzzQuzol0hM6QvO1KoL3R2rwtm4DbxVhYmgF//NIhLfv+Tzq6PxwJ3dEuFYfuQm9erOrD/nxNNcF+5dW9HSYHs7+E6zwqfLkr5ZbtPa47GcwUptElHKhDQl8Bodeugeaj8tmRBrJK0ju4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gW9AcyqK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso7181785e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365392; x=1753970192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl7MPjMQQR9YynEjNt+gG293fesASKmyZt5GnlBVdKk=;
        b=gW9AcyqKuSMhUqviT/CaEES5gWyFk0OxnCjCR0DV8Rfx02S0IQgPMd6CCa6dOcVh30
         63+5SGga433jpyLCKRIXeF4x+RONQMfgfnRhuEXYSrdOc15P7ZP6knymrDIPSnlOXUbc
         zFBeJYEvIP+0Q6l8vESKKOH7mvgMS3go6yHjeswsqDv5pCRNkBsMaFUpGolOHFcK9KIp
         B6bRuQK/BFUJdswR5pSmYLkG3M9hemjwfzoAjOdEICNheo8uqwkwqNhLV8X2BZObm5mV
         YQDLMYBBmiQ1th6CMa1aSDiOzN50Af38DcFCS6QDL1+4TAlQC9tZri6Kb23R6heF4d/x
         wrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365392; x=1753970192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl7MPjMQQR9YynEjNt+gG293fesASKmyZt5GnlBVdKk=;
        b=Uf+Ua3yaquKBylOeJLs3etWBu4wxm6y9C5kXvuLwAst7VQ+e7/Ut/khoLqIzskCUPM
         iBAMrIOs79J4qQhF5/NGOjk2yh/2T75fhvyezZZtgbk+CcVduMTvKNTkRUFQZVxOTW8y
         wJ9EjoZrSMmzjZIfDhEmDHosMo/cWtKTwm7IfKkOTDUTOM+a9KAtQ+2LBG5pk6SPUOZi
         wNxJgv48e5gsFJhqMEnwBquLdifySbyMOusksN3hNUBHR2FTbygzBWtYmHHMKG0IGx8D
         PxD3y7zYv/BzRxyEjLpZ6l+UOY6LB1L6AKIwSb2SgI+v4KsaHNLlQvD5I/SBrImgeRu0
         /GkQ==
X-Gm-Message-State: AOJu0YyBo36eNnR9DNivBnEZCFJ/oa9uZW+aucnR5/d0wyokErDHPo77
	6BgcirkfkA3XujE1p0f9CnUo5me/LfoGY03cHIfwM0PJH6ruVvww1a+jPGO1N012c8C25j8TzIL
	vRmY3UEE=
X-Gm-Gg: ASbGncsp5fqyGpvSsfzE/qKMbb2I2f92MEARp/cDvu2OsIMz5OV6KevD4SXlautOzGx
	NvFvssEmLKvrF7z/rKoWN+x+/+Rd2x5yFDa52zme2+RVcyVe4G/kOSZvb+vXkGBkXp+OSXvbBsK
	gXZTPOYEG0OKqcrfRcIQIh9PFWzrbU7UI+BZAOJSyxzxbwmTp0Wa4zll4PT7t+8fIHDYyIRcF4Y
	OUmbY5tet1beZN5iDg9OXMSbNFaczGTJA+k+dNn8Z+q0alMvoL29H33wBAe/4JfXkT7ml6/Znfa
	c2AMD00BybUbQufIdekSixwy57nzZyoQiUVzm/J9Nt6i1SW+4/H6dIofffJQE/5ZB7JeAHoXmI7
	FG5Z2XuntxtQNwpxLyzyRgKm63yEDoDQbhU/VUGUa9FHXIjCYhJx0nkLqWDDcHkEVVzyzGE4bWY
	uBnOMOpBlGGdr4
X-Google-Smtp-Source: AGHT+IHonQ82jnLO0p5HYq/pDMzB+6N1t6DWFVzcA1CVX2U3nXqH6sJ8SaBoH0rb44h0xr8LW+w4sw==
X-Received: by 2002:a05:600c:6992:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-45868c99c85mr63756925e9.12.1753365392038;
        Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
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
Subject: [RFC][PATCH v2 11/29] sched/core: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:54 +0300
Message-ID: <20250724135512.518487-12-eugen.hristev@linaro.org>
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
 - runqueues

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2343f5691c54..18ba6c1e174f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -67,6 +67,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/kmemdump.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -119,6 +120,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+KMEMDUMP_VAR_CORE(runqueues, sizeof(runqueues));
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
-- 
2.43.0


