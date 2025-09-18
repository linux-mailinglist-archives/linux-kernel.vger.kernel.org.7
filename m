Return-Path: <linux-kernel+bounces-823357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC2B86325
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB9E563388
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32807315D5D;
	Thu, 18 Sep 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoNs9W3X"
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D118264A72
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216261; cv=none; b=NGEE9q0VzLS74j/NhX/zqB4lBg+46M7FnQKmeDd2SoKoSdItmSSgLtHYqD7Xud6n6N5RslH8pZLkc0IvZ6eP2TwwPJ9YDySzqP+tcat6UJY1GcdeSt34PdXm2MeGZVfD9HtCPl0Pxx+BBKYkRtp1PAcU7b03mWkO+0FauViYl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216261; c=relaxed/simple;
	bh=vaDWT20s/LC9UNltIDvKjeDjNkntHPYzNahjuA8L3NM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=eEErgOyhqiu81gkr15lpiooXQYMW8cLluH0k1rmBBzX+uv43fRzF6h6UlsBHLLxoU8TWBeOxcF369DbqhXGE+mtciXOSHmJYgt508nqbzxqeZgwyGoYuQ9+AEJ7hLobXariJiq6VuAIt4GmD0ccltzZU5G13lleANNdbudnPHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoNs9W3X; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-435de7f86aeso971447b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758216259; x=1758821059; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rGc1GlAUI6MGVyw1McNVC1ua5PKAdc6aMJbTizQeuf4=;
        b=hoNs9W3X/PXR33hzWAy2zWYyF9Z5SxhuEysNp37TeLCILlzlI1rg1lmgjhrS6HFv1d
         6rmHVnvrzFkDj7bNqLYTzOMdZXJlV3uzpBWaq5U/1UNIJlDSzrtusCUGROZmrDC9RAmv
         lcdfUDbwO0S4u6H6k2KWLVR7kAisiUFF/D3h180KgOwEGhygdn42T/ygY/MK0HFopKJP
         FQ+6RQovzNKzsBau/LL38bIo66ECN5L6eNa3TTk0MT1Skgj29V96XDEWoen6P06Msp8a
         5MT6HbpYEUfOJc9249Glcu4EZanQAJpCOfkX52lTOjWxQRVWHdu4sx8u+qLmBTX5i7Mt
         j+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216259; x=1758821059;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGc1GlAUI6MGVyw1McNVC1ua5PKAdc6aMJbTizQeuf4=;
        b=JNzhUNY7FKwp48TO0oRmjefmg9bhgfcmXDmJ0+bB4a5w7rNIQvfHN7VU2maxzDn+Ps
         prThg8APK/tUIrDQtNqywZNJR61fy80ieqsaTon97jMQbT864tZrnyB83ixEKLmaFns2
         +nbSJgJjZATsffzSgrKCUDNbkEaZDudGDw18mOSnMyst5bt6QCnmWbuskpH+/yMUnoPN
         A12KLBBExqkLA64hB+lnNEH2KahXJBB3vL1jUA+yJ8/7Kx+lAXqoAbmood9C4Knz/s/m
         F7NUweTev77RH9G/yRiXrMnY+1iGJ547v1xJgzB6EW+3t/vCJY+TeidDTvEYwC36zWPu
         3uXA==
X-Forwarded-Encrypted: i=1; AJvYcCWBVkqFdoZLO877Rfv1Ro+X35V0S+FhTjgwxm652OKzh9fV9rmv9TRhjlul48KlKu9PYrKQDOCgSMEDqDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPhC60vk15XhjORaprmorA7iGV3094Zuw3DTg2NX3IiT25z8g
	8q/4CuJdfvUMfOZibmM9d1KrEjC2mL+RvBMIjJ7jY75I64/KFWEPNFIGsE9MDjB2I4nsj4FjnY1
	2n6GwnmMU5w==
X-Google-Smtp-Source: AGHT+IGacugtWxHcctIggiAC3tjIbV92hwu7pngoJJJFA6GiBta/P4RS3r1fXotqF9c2rBzq6XOtMZchSPZC
X-Received: from oabpp22.prod.google.com ([2002:a05:6870:9d16:b0:331:9a49:4dbe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:4484:b0:438:9303:acee
 with SMTP id 5614622812f47-43d6c245512mr95512b6e.30.1758216259014; Thu, 18
 Sep 2025 10:24:19 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:24:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918172416.1247940-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf evsel: Ensure the fallback message is always
 written to
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The fallback message is unconditionally printed in places like
record__open. If no fallback is attempted this can lead to printing
uninitialized data, crashes, etc.

Fixes: c0a54341c0e8 ("perf evsel: Introduce event fallback method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 477cddf08c5c..814ef6f6b32a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3565,7 +3565,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 
 		/* If event has exclude user then don't exclude kernel. */
 		if (evsel->core.attr.exclude_user)
-			return false;
+			goto no_fallback;
 
 		/* Is there already the separator in the name. */
 		if (strchr(name, '/') ||
@@ -3573,7 +3573,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 			sep = "";
 
 		if (asprintf(&new_name, "%s%su", name, sep) < 0)
-			return false;
+			goto no_fallback;
 
 		free(evsel->name);
 		evsel->name = new_name;
@@ -3596,17 +3596,19 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 			sep = "";
 
 		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
-			return false;
+			goto no_fallback;
 
 		free(evsel->name);
 		evsel->name = new_name;
 		/* Apple M1 requires exclude_guest */
-		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
+		scnprintf(msg, msgsize, "Trying to fall back to excluding guest samples");
 		evsel->core.attr.exclude_guest = 1;
 
 		return true;
 	}
-
+no_fallback:
+	scnprintf(msg, msgsize, "No fallback found for '%s' for error %d",
+		  evsel__name(evsel), err);
 	return false;
 }
 
-- 
2.51.0.470.ga7dc726c21-goog


