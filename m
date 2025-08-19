Return-Path: <linux-kernel+bounces-774720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A624B2B66E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3F4E00ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2827FD40;
	Tue, 19 Aug 2025 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOOMkGGg"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892727F756
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567642; cv=none; b=GbJteY/OuBz2vPi58QgKE9OGCHcqScdhIpHjGBIzmY/6gWpKh8ASqFPzxhhoJ5iQRlMzEKB7J93Xk9Af+PQmZnzYMS1mJ0GG/A5WZwNvQY/m5Jx7ecdDCQWu+UiN/Vo8mlAC3kXI1DHxt2J8fEBQeMxkJHXVczrlPkp83UaEXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567642; c=relaxed/simple;
	bh=dReP5xDSocTLXuE6lV+2jz+6UPBQqAGaaJLrbMKD+n8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IN9fLicjRwY/bIedL0Pah7ilzQMwL2TZNVes2+ow9AR7bImgFRw6yy5V59yCCuFQZZ6Wdc8sh1GafmjJOEjm6c7wLSyzlkr6oIHQQXOH+wj3PFxQeOTBbKPKCd7/esbJShQ6YBt5jIMpAY5rE6WGdb2bsI2rKyryQeS/OoINnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOOMkGGg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f440f0so51820855ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567640; x=1756172440; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fecVTDRHORXkJ+Si5yHb8EKxcHl1U0RUsg9Sl2Llew=;
        b=VOOMkGGggulRxLX6vQEihLq0JZJIKWUPwZXJ9UfjbdW56FBdjQkXyBH4mxvGZSgYBR
         0NDE49XQu/kFsi9z9p/9SfSqITNZhZdGVeBmi89vC0BaV5uLKW3jc7mbyozyCZ0oTkKz
         sPGNU2weCB2ZqVZSUNTodteAbLrZriRDnwDG51CWpuV26stj02l83jKNq8AJFJ+2+S1V
         HvIvpqCeynjtBtu6cDmaS6p8xRneOK8lYd2KUfbSt7bMgalgATrASdMKgV3bBmqUUZzq
         ikX57M/FWJM/2T565AlxXnNrzsSyrxKh3+urIgqVDBAqMgZtmXupB91+FZYkMXOTbg8u
         xrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567640; x=1756172440;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fecVTDRHORXkJ+Si5yHb8EKxcHl1U0RUsg9Sl2Llew=;
        b=ScHw954cFQNGpyhlPBGprjC5tM6E9pZ6ZtCvSoYpivJqKVam4Ul0w2wkuAceDhoK5F
         1dn0T/JhLkYAYK9UAMPaLxyPNuZSNAhD1oiYck+aN/YtkNzKzqQacre9SReVTS8q2W2M
         g2Tj//QwxAMvXlPb8rjm1JV8GE0O8/vv8g8O/lG3OQ24pF6vmBNP09WSm+Gc5nuKaxpl
         X7f2XuOaoHxp2LsjKDosCFtYyM6TECPOp4m696Iaa2143thRdhWMG/kt5kNyTNje8enp
         GQvI/Ebl9fJgkWibUwcFHoZqQugHmz1BbMsIiip2DOr/uEEGJlT1GB5xvXyv474elIw2
         6i+w==
X-Forwarded-Encrypted: i=1; AJvYcCWVapRvdQjEXkzKU70iVXQhPX8Hp6Lu/8BGmv1xMhYLWy0pKHpEgbYAXssoBzt7W6LQwPFMLKO4RhA1YeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1F9cj2VCxZw/3UiIGobEOGJ++a++4/gAgYiSWO5yCwCDgK+qC
	Kn5C6pFfrJkaqMHCd7BzJK8p4dR2Zx4WxJjtKuXh4IgaXcSkf59uWhUlLGt9C2YHwrWDsQsYv1Y
	mQ9vnFEaNDQ==
X-Google-Smtp-Source: AGHT+IGMkP+UAP1J1Ztwnt5lueLRrYAM/WwzRYwBr/B+bGN+5hlJ2J50How5Xyv34FCbbgUYfCBsooiLdK1D
X-Received: from pllw7.prod.google.com ([2002:a17:902:7b87:b0:234:9673:1d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f86:b0:240:72e9:87bb
 with SMTP id d9443c01a7336-245e04a417fmr8203565ad.42.1755567639941; Mon, 18
 Aug 2025 18:40:39 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:41 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-12-irogers@google.com>
Subject: [PATCH v10 11/11] perf tp_pmu: Remove unnecessary check
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The "if" condition is also part of the "while" condition, remove the
"if" to reduce the amount of code.

Reported-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tp_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
index e7534a973247..eddb9807131a 100644
--- a/tools/perf/util/tp_pmu.c
+++ b/tools/perf/util/tp_pmu.c
@@ -88,8 +88,6 @@ int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
 			continue;
 
 		ret = cb(state, events_ent->d_name);
-		if (ret)
-			break;
 	}
 	close(events_dir.dirfd);
 	return ret;
-- 
2.51.0.rc1.167.g924127e9c0-goog


