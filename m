Return-Path: <linux-kernel+bounces-849391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D6BD0027
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 09:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 322574E216B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0803321ADB7;
	Sun, 12 Oct 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsU28kTC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BC1EEA54
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760253201; cv=none; b=MqxgI73GUCPvQoJk2uWBdHlnDZ+IUifOQSwltOOdEHbOztbeJoKxYKNunowqqOarG2iCHoAfc5b2XIcYZSogSuGxUGPrPphm4i7lExif9kKrgzZ3/Mr89YI/ggbpiNs7iRy8Fm1EuQJhR3z2RCnUadXHBzGVZk8Df+JYPrXupGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760253201; c=relaxed/simple;
	bh=dq5XPpWQTqVeWFkmnGSkYSvTd/fKLsCFTZToTBBOTOw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FUlpEj0CV0FyzsL01PJHsVKmdZqqtU2AozCLqxq3vkHI0zEtiztRlzJ+3iwvLMqw5REz2AXYiCLSDZVgzHAsaVAaE5UCDa3H5XbWGDZb3bJ7yp86uJ1J8Bcl+fvCO2gRYqOnJ75tZN7JWXT+zb0rT5x/SwUwn63nxFhptep+Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsU28kTC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760253198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3dh6DzbfDhE6jtBd8N1O7na8tQoQioGI90EhyrkbVps=;
	b=fsU28kTCDVDCWfkhchLily/AVOizkwY0/7oO0znMqPViwAnoNaB23ZVIAAhc22ifEk1IXb
	bAxxIawJ1M3lPxf8cbFhV9EVWifR4amEV69DyaAl1gCE1ifw/PxbDXwFrJhaeAOF/1tGKH
	zmtfqNqCFVvqheUZrnmCMQLwXNFaabA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-qpma0IX4NPukTAhKnQ3arA-1; Sun, 12 Oct 2025 03:13:14 -0400
X-MC-Unique: qpma0IX4NPukTAhKnQ3arA-1
X-Mimecast-MFC-AGG-ID: qpma0IX4NPukTAhKnQ3arA_1760253193
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42558f501adso2285859f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 00:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760253193; x=1760857993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dh6DzbfDhE6jtBd8N1O7na8tQoQioGI90EhyrkbVps=;
        b=UOvS76GWPqZzzo519lYA/zZbi3iH9AfrsuVWjXRPkpvK8O76s69PAsYlPnHORY3fRW
         TYyOjm62CON8hJgOyxyhGSqEvPuZCHL3BX9dzlJsX3nJke4YJo5ay2EpGOnVh69Tbgqp
         mC3K0jYjmq4uu+zzaRQ1vhwfPe5d4fnjahvEz+/groBDxviwu8K6Osd895FfmxnzPy1p
         3aTsJ/x9UpdFlLGgiKJzwDFM3gq+FpKkoWbvZxQgstDhYaJ/aU1LTM+tRtLHDyj7BBBy
         HTNnmp1pvMzfWvECq3YUswRa/rgfzpQKTGaXSvbH3zYnUq3tOV8ubL+WI2WJE/ykJpjU
         nXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiuVnXFp/EUvDnu3YyVzSJfkHuLRGB/yXV7ff3jEgnf72TPDW1gp/ahMNM2MVS90ZAv5auruDi5qoVknk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsROh+BrTC3jGhpYjFzlXaA7zy2i0WhkRJksxaQiz/h6/eaDzM
	HI+KP8oIbhj4PFPuFPjBDSfQpV+lp1TjlyOCNC8VFHP+BW6TlHS1sBP3QQat8p3pyL4AE7tCv7n
	beD+iv1dQRohO0jxcczlpA5vKI61Jmon3DfmVmwhAZ3L9+/x9KXZ6yK6SjicaARGo3A==
X-Gm-Gg: ASbGnctw8A3sD/O9otTTObJw6sy5xk1tMaunPk/AejT79P4TFqs+/cTL2XKQmBEMpVH
	V/NctkCkr58W/QYZE6WzOnHgWaoYthv4kw6bMAZDoy+GNY7xwtQZabboRxPrMLACIY4iuxHPVxA
	BNXrKs8R7tV+CYDAkyRztdG7Opy3FWKXeSHbWJ/+qzfGieu9UPDGrdaFwwaAy/afoScjzIsHP9M
	begmk9QjQM8GgfeXC/GuM8eGSxk9mrkMc5nJ1Cnx0RtmmIcOX8hULBLtwRCfBcd99Qiv5WQuFDk
	VdW3tlMF2kr/ilB5lw/mnOqLIYgOFbyTEsWAVNfLaLlU
X-Received: by 2002:a05:6000:3111:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42667177d9fmr11209010f8f.14.1760253193090;
        Sun, 12 Oct 2025 00:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSnULVC4RtP3jhP2wpaC2RxEg1kofWPk7jIyzNCabwbJaYfRGXjLljv/qa0jpgkSz1lBvR3w==
X-Received: by 2002:a05:6000:3111:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42667177d9fmr11208990f8f.14.1760253192719;
        Sun, 12 Oct 2025 00:13:12 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8141sm11824513f8f.48.2025.10.12.00.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 00:13:12 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Remove unused function declarations
Date: Sun, 12 Oct 2025 10:11:30 +0300
Message-ID: <20251012071133.290225-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically four function declarations remain orphaned or duplicated.

Remove them to keep the source clean.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise.h | 3 ---
 tools/tracing/rtla/src/utils.h   | 1 -
 2 files changed, 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 895687030c0b..75de0d5c706a 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -58,8 +58,6 @@ int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
 void osnoise_report_missed_events(struct osnoise_tool *tool);
 int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
 
-int osnoise_hist_main(int argc, char *argv[]);
-int osnoise_top_main(int argc, char **argv);
 int osnoise_enable(struct osnoise_tool *tool);
 int osnoise_main(int argc, char **argv);
 int hwnoise_main(int argc, char **argv);
@@ -68,4 +66,3 @@ extern struct tool_ops timerlat_top_ops, timerlat_hist_ops;
 extern struct tool_ops osnoise_top_ops, osnoise_hist_ops;
 
 int run_tool(struct tool_ops *ops, int argc, char *argv[]);
-int hist_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index a2a6f89f342d..6086e246bd85 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -23,7 +23,6 @@ void err_msg(const char *fmt, ...);
 long parse_seconds_duration(char *val);
 void get_duration(time_t start_time, char *output, int output_size);
 
-int parse_cpu_list(char *cpu_list, char **monitored_cpus);
 long long get_llong_from_str(char *start);
 
 static inline void
-- 
2.51.0


