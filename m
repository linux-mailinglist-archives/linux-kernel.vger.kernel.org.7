Return-Path: <linux-kernel+bounces-805750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21735B48CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888A73C6121
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B22FE05A;
	Mon,  8 Sep 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zk6UOgwZ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21512FC025
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333445; cv=none; b=pXGvdbrV2TKx/g38i55t7YngzRN4l5fPNUOHIdLxVNuW722HcukUWFowtUUYoxR0SOz8PAG98u4zKGeXvEA0t74N5UFzDguYZ4hRRvk4HCbkTIqbNWwcGyxAcqpATcVRoCbG77V5JSHn0sxPiA2jca6X3mj/SEV7pf0Qq1QIxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333445; c=relaxed/simple;
	bh=RlZvn64TwZStE9dMS/NHdOkF+cylFHTTXjV03+Dmzw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSVUruqrQYWNYsw2upE61r3/lXx5xqDnVYHKsqeDqWhXVj/axVNVwVqsi8PDRoCSbJzQC7xG+WOxyJcPp9oBgTUCELtJ3udJ6ECZprNqa1HJY6ImKJk4/rm+WXHp14PAb0Y+3zbcuw7lnHgemGDbbAGsXwmWYUzQzVSlVdY7a6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zk6UOgwZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2749784f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333442; x=1757938242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDiCsNiASZRs1sKdsqhg3S3zKatA5gJu2ktHoc9OyZw=;
        b=zk6UOgwZ0Iy3My/RrwVLuuCoDftC2oP/kq5q1hq1KdXyxvwk+cX82TXMf1lWaWOhDD
         FxF55geJh/iS1NjgaZxy7BYj9LCVT09Dk0l+RP/nUdSY/EHo5kDdN+a+CBfVJuvdL7VE
         hn5yraNbWOy4MX78EFWm/SZaAEuX+IJXe3g+T43k88mVh/kT8ijeupLA34u3kFXAhCu7
         7oy2zfbwYlDxi/Wzx0Sw5VH+E4feSmM9S+RvoGsAT1oTCs2S8dvwDQpcv2Q2DG7+T8d+
         IgU5CL3bdTAeQg4AS4oDayeMvUHV205+HaL+VBrb8tnyc+Z4fNLd57YcjtwnANVgPoN7
         8O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333442; x=1757938242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDiCsNiASZRs1sKdsqhg3S3zKatA5gJu2ktHoc9OyZw=;
        b=iX123c3FzeOmxH45R83jbdx3eOMSVAGBsVCbFp9jRCKgpJ/Sew8Fgh4IwbSFNZaY+v
         pa4duPW/nGKjSnUQyaeZs6iBHxBC/vwpFx9bEu0F/A6JpW+5Sjik/HRYBPWebfAP3BdA
         gbKE00XaQVTmAY3eIFHv8t3rwjVE5RBDHYtOo2wBZrDsMcGmc8g2Dge7zGqcsUzImwAJ
         Mzq6q2srb92wmHKUUJZyhQkLoNpfxuKUK5rhcKwLZGkdZgLz4jiRQrYLgcf2FqBwbMXm
         k7yYgg/tr9QehyzyLx71fobxMgy9p0+PpmY7QEfrO1EsLgBut3crUtX3PEt6tHoMRNk3
         zFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/02ffoAzoK9zpd0TXYekd3vX+svDYPygxUwrXLfVWuKoXYbL9nrmySf3/ZpgMFVBByz+xvRCVjMRIt+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpY3r/CzWm6Y0l7IjA5J4WXPK8mPvuSd0ZDcHMcRFq6D1rYnN
	/366xDQ7VxgjAtn5L3dQnZbVRxRFy3Q7WwgwYrTQd8Uwwty1qX/azqmJTrRtEmBn2fw=
X-Gm-Gg: ASbGnctFj6QhoVksNS7yLDj1MHJZrTBNsngedakbukuLUy/4MVz5MmM42VR0GWe5JKV
	D0eUVSud/pUNxh5yEgTV9aLc5NJQwIaDVjv5y3N4tEfYtR0YwKlzTygD678cVtl3ZMazg10sI0a
	SzX0XOqeBBt/93wl7T7BGbcvM+MOkKojMdsWwaavIV8//pP1JsAiLSD3rk7AAmJWpyhUy+/REEE
	5hJsAD16ADQAaMkvJPMZms6wmLQUZtZspC+3H4XrY9hU7xcVfSvilvl/ffL7Zv25HjoDWXDVgWP
	F5mOT3tAMKb3iVNNXeMK1JnKLCBtc0yDLsiHbAHWR/MVFyZXKcfXpDx/QMqKUG0vLpadmaikgan
	ZWoFahcMsSotm7YFhD5ZXmDHzJvnZCbb/1efdZTv/iA==
X-Google-Smtp-Source: AGHT+IGup4M0n2CrqLFC4Hs6XW/mujDw6sj7WjnSz4nJ6/Xw6zsOjT1bf160w3/O739Ldk3nE+fTew==
X-Received: by 2002:a05:6000:178e:b0:3ca:4b59:2715 with SMTP id ffacd0b85a97d-3e642da55b8mr5784667f8f.20.1757333441854;
        Mon, 08 Sep 2025 05:10:41 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Sep 2025 13:10:19 +0100
Subject: [PATCH 2/4] perf arm-spe: Downsample all sample types equally
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-james-perf-spe-period-v1-2-7ccd805af461@linaro.org>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The various sample types that are generated are based on the same SPE
sample, just placed into different sample type bins. The same sample can
be in multiple bins if it has flags set that cause it to be.

Currently we're only applying the --itrace interval downsampling to the
instruction bin, which means that the sample would appear in one bin but
not another if it was skipped due to downsampling. I don't thing anyone
would want or expect this, so make this behave consistently by applying
the downsampling before generating any sample.

You might argue that the "instructions" interval type doesn't make sense
to apply to "memory" sample types because it would be skipping every n
memory samples, rather than every n instructions. But the downsampling
was already not an instruction interval even for the instruction
samples. SPE has a hardware based sampling interval, and the instruction
interval was just a convenient way to specify further downsampling. This
is hinted at in the warning message shown for intervals greater than 1.

This makes SPE diverge from trace technologies like Intel PT and Arm
Coresight. In those cases instruction samples can be reduced but all
branches are still emitted. This makes sense there, because branches
form a complete execution history, and asking to skip branches every n
instructions doesn't really make sense. But for SPE, as mentioned above,
downsampling the instruction samples already wasn't consistent with
trace technologies so we ended up with some middle ground that had no
benefit. Now it's possible to reduce the volume of samples in all groups
and samples won't be missing from one group but present in another.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index b33a0a170ef8..4c81518a033a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -62,7 +62,6 @@ struct arm_spe {
 	u8				sample_remote_access;
 	u8				sample_memory;
 	u8				sample_instructions;
-	u64				instructions_sample_period;
 
 	u64				l1d_miss_id;
 	u64				l1d_access_id;
@@ -101,7 +100,7 @@ struct arm_spe_queue {
 	u64				time;
 	u64				timestamp;
 	struct thread			*thread;
-	u64				period_instructions;
+	u64				sample_count;
 	u32				flags;
 	struct branch_stack		*last_branch;
 };
@@ -228,7 +227,6 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
 	speq->pid = -1;
 	speq->tid = -1;
 	speq->cpu = -1;
-	speq->period_instructions = 0;
 
 	/* params set */
 	params.get_trace = arm_spe_get_trace;
@@ -352,7 +350,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
 	sample->pid = speq->pid;
 	sample->tid = speq->tid;
-	sample->period = 1;
+	sample->period = spe->synth_opts.period;
 	sample->cpu = speq->cpu;
 	sample->simd_flags = arm_spe__synth_simd_flags(record);
 
@@ -527,14 +525,6 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	struct perf_sample sample;
 	int ret;
 
-	/*
-	 * Handles perf instruction sampling period.
-	 */
-	speq->period_instructions++;
-	if (speq->period_instructions < spe->instructions_sample_period)
-		return 0;
-	speq->period_instructions = 0;
-
 	perf_sample__init(&sample, /*all=*/true);
 	arm_spe_prep_sample(spe, speq, event, &sample);
 
@@ -543,7 +533,6 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.addr = record->to_ip;
 	sample.phys_addr = record->phys_addr;
 	sample.data_src = data_src;
-	sample.period = spe->instructions_sample_period;
 	sample.weight = record->latency;
 	sample.flags = speq->flags;
 	sample.branch_stack = speq->last_branch;
@@ -929,6 +918,14 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	u64 data_src;
 	int err;
 
+	/*
+	 * Discard all samples until period is reached
+	 */
+	speq->sample_count++;
+	if (speq->sample_count < spe->synth_opts.period)
+		return 0;
+	speq->sample_count = 0;
+
 	arm_spe__sample_flags(speq);
 	data_src = arm_spe__synth_data_source(speq, record);
 
@@ -1628,6 +1625,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.exclude_guest = evsel->core.attr.exclude_guest;
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
+	attr.sample_period = spe->synth_opts.period;
 
 	/* create new id val to be a fixed offset from evsel id */
 	id = evsel->core.id[0] + 1000000000;
@@ -1754,8 +1752,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 
 		spe->sample_instructions = true;
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
-		attr.sample_period = spe->synth_opts.period;
-		spe->instructions_sample_period = attr.sample_period;
+
 		err = perf_session__deliver_synth_attr_event(session, &attr, id);
 		if (err)
 			return err;

-- 
2.34.1


