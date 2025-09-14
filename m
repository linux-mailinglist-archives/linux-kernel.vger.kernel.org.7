Return-Path: <linux-kernel+bounces-815794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9C0B56B2E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C3416A5BC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409E1917F0;
	Sun, 14 Sep 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSoBuB1c"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E484A3E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874107; cv=none; b=bEYA6zyRrMhkEhZhynGiKcFINVw/ET0qI7mtk7QrNh8whJpOKkTN08/Py7355aTRv3QG9njeff9RXJjbqhNbLczLTwHCoumE6M0rj8R7E4fwy7z7zfwJwwzApuS2vATTUUiogluaWHJu1G93/0pQ9Mg3/ixWnhOoAtmNxKfwSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874107; c=relaxed/simple;
	bh=GsAIYc4aavaEsHeHft1wPWlWNFRL8pkAWYVQqnWXhD0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=pZx2W1kPcwUJ+It7h/DfcuckaeJayAZ2v6EfuVQ/cAjx2phI3CZaebXwcTzTDpaMHLCvxVAg3M60sNZqpPOAtoeFN0PmpLsjwsU4ONZqfcceG8KpEIOKFwfoC6u7sMnm6n8g3yIFUuBICwlQpvbGA8iWMdg1jDXSsYaCl9za4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSoBuB1c; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4e796ad413so4636818a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874105; x=1758478905; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1j/v+twDt0ZUaShb07DVO0ufp1ep8m6kkLq8qghy74=;
        b=sSoBuB1cLXdC3qbJK+9oztD0vzRbSyvebxOrisHER3kV2Z+mKVQihXvE93XqMRtjvy
         UVd0LTB0xwdNpziWfCaF6Evg6+KkTMQKUr9j9CeLHcThyTUCfSbntlsEl68BXF4Y0HDh
         moiI269Og5reu1QQzDHwzxCQoMqEjjF7PU5EBPSZJkPPOSRpDOVDCcAEIyd2Ce+x8GGb
         YIsv0LaJmttNUm+3jfjHYkuwXZsIZT8izPnLbtBvz9QPr96lDFJyKjCPPnahGsbjebQY
         ldBqlOlUss+MEbvyRyjJ5yISsw7lSHTGVGJfVWXghPtB40KqSXv+JXn6fr0GIkm/vydX
         k2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874105; x=1758478905;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1j/v+twDt0ZUaShb07DVO0ufp1ep8m6kkLq8qghy74=;
        b=gDl0HZUwjtaybOaN/CU1aDJ7nm7lX3SR1wXchl/Jmpj6ID8pEtLN73shCYCJCpAd+e
         3MFDaT5rs4NojiDOw4qaY/JO8XHaEC1mI7uE7p8TbikMl9T++HPjo05acyNS1xKmZrU+
         cWLlvhQsz4IzZr7uKHejqRXOrPOjusbEoz5ydA8+tvRG9tUKgbD23wobep68muRY0FBh
         aUhz683yG1o5HKJmenIl98HgaufUlo1acXhWF/PMcqbdwQ5CecAYOd5YROT2eLfpc8Y+
         ubhce+nhBsuxYx9i3Qn/0NP6Sbl0No/DgVpdrXEzZM7IhP2huwufoFS5sv0zF5pEqT/j
         VBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWArTcK5DpYADIG5mS8v0lNgQjUOjCce3v4sdA0u/QZgzsTxNeY6jGx+UPoivGu7px3F+i+3nKgC/H6qWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZ4QvXyOE/8775vKkPo+Zgodh11/0Ok7DbelvWihRxq3V3Ski
	Jh8V2j5OSpwexiTxqCWUrqzFLFjew2RZNlEyGcoD/Kse060Di+bl2FqRtELSk1WrBusqP1d07oK
	CYASTM9AgZA==
X-Google-Smtp-Source: AGHT+IFACbFgKBKlPscCXxu2FJpvWOu17SDKIWI7vglqGTGg8uhPIjaxhMCTv1EV7riOiN0nLCXS4urRqJZU
X-Received: from pjwx7.prod.google.com ([2002:a17:90a:c2c7:b0:327:d54a:8c93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528d:b0:32e:358d:6678
 with SMTP id 98e67ed59e1d1-32e358d6fb4mr2881411a91.4.1757874105483; Sun, 14
 Sep 2025 11:21:45 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:21:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182140.1958530-1-irogers@google.com>
Subject: [PATCH v1] perf test: Stat std output don't fail metric only
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When running on a hypervisor the expected IPC metric may be missing as
the events may fail to be read. Don't expect metric output for this
test to avoid it failing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 6fee67693ba7..ec41f24299d9 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -90,7 +90,11 @@ function commachecker()
 		}
 	done < "${stat_output}"
 
-	[ $metric_only -eq 1 ] && exit 1
+	if [ $metric_only -ne 1 ]
+	then
+		echo "Missing metric only output in:"
+		cat "${stat_output}"
+	fi
 	return 0
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


