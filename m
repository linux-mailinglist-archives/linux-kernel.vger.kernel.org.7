Return-Path: <linux-kernel+bounces-889498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53FC3DC93
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C118914F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6734F49E;
	Thu,  6 Nov 2025 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BekpuqQn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FE341AD8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470945; cv=none; b=P4T7TiJDdJYZZUUKl/aysnBmPm1xPenIgIceq9Tn1eJwe00znf7szkkP+8TuIofOdl6u7I8fhRjqzJuVBatFia/xM/Uwt5FW2XIuPLESQAXnPG4Z8N9K9A8w8ycMGHm9i2GP5IGSUQHDX6b0YkboYhm84L1YXW9hggcRuiXqLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470945; c=relaxed/simple;
	bh=goAJRIvcXmArqjtsnCnAKiuCo6RWRhzBbuO89gkopnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=COQPR3s3H6i4MMEI3f3RrUkH4ruav4c+lCiCBZHQnE7GaUkdtlImWP6zuNlX02LegiODC95giR/M7FyugHsv/rPQFRektmOcBkHS54fESv5WKKSA4RNFiM0rnqNww9CwFbFCd4mghebiToHcoENcLQ1Je+LNj7MEG3sgEiR3Igw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BekpuqQn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295915934bfso2305745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470943; x=1763075743; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=BekpuqQnqK4aaGV7k0MAlGonnpLEFf4PJzyV8opYVhRoVbT0A0UG8vmQf/c66j1uSc
         fGLo1Kcf5SlFIsk99qNidk60eLdmXQHmxMx9C3d+HkSR961rxCXTxrX/EQSp8z0OzlJN
         z7iXe/dGJy7Nsch5WNPNI5xSGGuxujaUEr7ONtr5bZB2PsZFhR3UzPV6MNLs7sXxfxUk
         b7LVeAJ15azM1G/PI8tgxS+RO2B/WulGQdvE0+2R52aYS3U2N3Ed83Mas9p26iykfeZK
         SuJo1cyYW7DkWGzKG0xqHgW19TNPP8OLp7WWpfdMN2I9nJ8VUrHgmtFj9KrSvmFRNHM+
         PpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470943; x=1763075743;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kfrvj9SxzyHWG3QRMI04WWVn93aXW9NO85HAoMrUfM=;
        b=X36R3MlSEc5OKwUBjQDNrE9f/TYJVM+1KYHHuookrdzlIBZpEtVJWq3f5UNhAYscls
         jSguwont9vklD+jgJm7d2+qdcp8mqtTG7H4DI1KhcoeKFBOKFN4ZH6PlgtLGPJAXbyuq
         N53zVCWkPs9uXJu/MzSRM3tDkELOBekSdHGw4Ei5e7gnaVsNWrsVCHHbYtrh37JsoWDl
         MaZplip5CtfVI1QPXBUoAZx2JmNzn0sYRgugQN7ZnbqCa7ulQ3kdZJ5s/TB4hzWQ8N/5
         PiBAtgNoQeBNC6/xlcXuZ4EdgsXlMC5Ce8UiJDmCXMg1h3K8Jxx8OusW8Oz/TQ40DM5Y
         reOw==
X-Forwarded-Encrypted: i=1; AJvYcCVwz/lwKo3JJsHSBj7vFVqUZblBcG2m/8emIXxL33bC20BIJRJw0loPvZw8eb9bY6sPcdgD3KVpEy3I60I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAa+GQKUfeZF1FoaxGCyU9W+gxsZaQ6QIbloKRMeioXm9HXFa
	CfJALaWrPtdCv9oab67skSrQFvlaUpVtv6URbYzQiwDWLOxiXPDvxH4TlbJXDZ1vVq5Vjcg6bx/
	zDF/BqMEwEA==
X-Google-Smtp-Source: AGHT+IFma2NJzvhRXHMld0BT31zupRS7KxCsW4oTcuOFZWocvzaqYwh5cLgtfxBZt5czA5+dCdaoj9K7WdG3
X-Received: from dlf6.prod.google.com ([2002:a05:7022:406:b0:119:b185:ea6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f791:b0:295:571b:64cd
 with SMTP id d9443c01a7336-297c047bd71mr15118375ad.52.1762470943106; Thu, 06
 Nov 2025 15:15:43 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:52 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-3-irogers@google.com>
Subject: [PATCH v2 02/18] perf expr: Add #target_cpu literal
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

For CPU nanoseconds a lot of the stat-shadow metrics use either
task-clock or cpu-clock, the latter being used when
target__has_cpu. Add a #target_cpu literal so that json metrics can
perform the same test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7fda0ff89c16..4df56f2b283d 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -409,6 +409,9 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	} else if (!strcmp("#core_wide", literal)) {
 		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
 			? 1.0 : 0.0;
+	} else if (!strcmp("#target_cpu", literal)) {
+		result = (ctx->system_wide || ctx->user_requested_cpu_list)
+			? 1.0 : 0.0;
 	} else {
 		pr_err("Unrecognized literal '%s'", literal);
 	}
-- 
2.51.2.1041.gc1ab5b90ca-goog


