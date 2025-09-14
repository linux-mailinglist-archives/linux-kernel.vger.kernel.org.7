Return-Path: <linux-kernel+bounces-815786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25BFB56B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D33BF142
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D62E6CC2;
	Sun, 14 Sep 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/+dDghz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885742E612E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873519; cv=none; b=pc2TtKF/2kXAQeI5xTJlb/2K5CKg/8FYJ/imjf6LtlikNBibr95GYVDKebv4PwfKrHnsOGRpc9n98/zRvZkRG9ofg7q/WOQACIEj3ZrsRbEx1C88PMY/qPAzoPXpIXwlr1XCqXg8G/ahbdrrMm70b0DR18F/0Y0do+iprmNWq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873519; c=relaxed/simple;
	bh=ljI0WTUYOuJFrnJBziodRTXhC0o8YtCEikX70wIWVdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TPbwqgZK/Dfmqya7lGPO7n33cRghI9cxn0ZthCBLdEP53exJq/9kooUkZEruQoeyWYMY5X3wj4PKnad87tq5nxhjIWS3EOfcJYo7l0RrQ0sXoZvdKEu72mn9HWUH/PscPFOWE2ckdSO3dnzO3fGd0094Y81k1KBCZTAIvvvlubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/+dDghz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e43b0f038so274123a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873517; x=1758478317; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cszoCuCF/4pJ27efpqxPpEc9IoYBZusH2U1UEnIjtyY=;
        b=z/+dDghzMv/PHsPKe3ey0ynoflELVXTzq1fRkk7aFbKu0Ndbi8+bLtubBqq3Dib45L
         CRyZaDyuz/Iqrol1ksH4ZXXtFH7J5c4d4SaA0HZ27O3/6yzFLPHyd9daU0IDZFK5AjH7
         LkBENj4XBGtXiUHkpaN+DjFSHoBghay/5F0wdsMVlMntp3ufdS9QuA7hCDBR99phxDx2
         DLhG4XauYBAE9g+v9O60dsJAusGYcTaxEVfAIZtvOZjUHWIFbrAppsvsbyoehblg7+/2
         Mg+056tFyPC93/i+vK/J1shPUiBQWnj2Ub7FnKRpHBUsPIRA6UkHdbaGEd3P+tmCQX4A
         Y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873517; x=1758478317;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cszoCuCF/4pJ27efpqxPpEc9IoYBZusH2U1UEnIjtyY=;
        b=CtHSRd39v2ubj8nmLwx9FSewrHCF1fCiBxPTSC2bUPhfc07hw8vWZmSTVxjna8GrGY
         j+z4pLkECqsZ/XrucrlVw6f/duVyto0CxP/NIvFcCgF5jPBSyBGaTqFvfsQKIh/YW4DQ
         zUliQyUvbdkRZoFL3De9aVnKJECA8v6EUqoxpKnNxbT67HPaZ/ScleppQXs3C+KS1/Av
         4mUPPxHu6tp0UxSjWjRI0ZyH9yqlgcAgOayCs3YSIbn5ioXsY0v5YGu4I2vf732KlyET
         QjZkN1/ZOZvAFaGINbElts5ms5rVbdl5E/HR3bfygsiEM5NjmwVzKTmUoAYPWTuKEVQ8
         LCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiREsDcCtR6oFidahVz5jWc12HFfi6QtzjdszD6YVN+GYxHfk5u5jNu7CcVdwJpQnO6KBjA89KYDmrtdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IMqR+kJsRF5JWjhl6i3Gio2vyHc6Cyd3XBayU4b33lB528zO
	sIwKmC6mNTkxf1c58MLLSvEh12JuE/orKqhZBQygBuaIhRmSF9PLCeiqnbqI2sNxOsWsMUTS29F
	8+URAxBmXCQ==
X-Google-Smtp-Source: AGHT+IFOWE0dHH6/DPzHfcurS//5mAYhaRLp8T8QI8OCJte54DrklhIzwzjTyHhmS/wBztTimb1vUq4Y01Ng
X-Received: from plbd3.prod.google.com ([2002:a17:902:f143:b0:246:727:7f8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4c:b0:263:d6b5:fbe1
 with SMTP id d9443c01a7336-263d6b60724mr38223545ad.55.1757873516786; Sun, 14
 Sep 2025 11:11:56 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:16 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-17-irogers@google.com>
Subject: [PATCH v4 16/21] perf record: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8e289f352fc8..d29a3bec1a5f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4346,9 +4346,13 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		err = parse_event(rec->evlist, "cycles:P");
-		if (err)
+		struct evlist *def_evlist = evlist__new_default();
+
+		if (!def_evlist)
 			goto out;
+
+		evlist__splice_list_tail(rec->evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
-- 
2.51.0.384.g4c02a37b29-goog


