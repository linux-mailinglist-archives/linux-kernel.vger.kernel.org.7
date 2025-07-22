Return-Path: <linux-kernel+bounces-740058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD669B0CF23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E82B3AF4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2441805B;
	Tue, 22 Jul 2025 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvlcyMGk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EDB640
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148096; cv=none; b=eQOMhf6joOu7ARSTtVknzNA6yha2xHPE9Jm+QICkIPB24fkOvt3vmeLVdqDi8tgiaZ6HHRspOrZz7d2c1fBfxn64IxtE0Vt1hTIjkdug8s/xP5yToNVayeUbGoIClYVaWn6G29nzXIYxhFnh3bXjWpYQ/6YBms0aacOHP2FKtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148096; c=relaxed/simple;
	bh=ml+CruI2TrPMvJL6Ve9QrgFk1hQk6xyzgZpDd4Hsx9k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NNCuI1MHEd4nUkXUFgBpOIJfFCB8Qvz0dQd3Og4kY3i8TbhJvhgCKdZ/95UFu+FvmDYw5zKWVWMyu2jNhHGfxrUOuBLvtuq5758IUHtfoJYFRnvQNxv7NYIaCj8oVBnmoiZuAZJYqlK53X/RXUXtA++FvZxU4pYfbBVAaMpJ6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvlcyMGk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso5767908a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753148094; x=1753752894; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QX1c9/Mh/EGaQrrI9AS/O0cONZegTS8Gy7pO7vmBK3s=;
        b=MvlcyMGkvguZyE/HX2S3tFptEZmfdf6um0/FPqZHi8UMivcsnUEi554qlrqwNVihUA
         xuZE15yOrxj6NGIcNs8E2aZtIPeH/PZeAKyUECUZMiV6+GCqt+uNIMqvNfqZjKGr9zcd
         yfDAknww3QNBPAXAalZr5TdhZM3DzPPfbOVgHbvmUMAuOPQYzqAtR6qyY2Yo8CUW5KUi
         8J7FcJiY9tZMmI/8Y32oEUWXFDIW3eKfHVp6jcEnEw5u8iMtN0stAJVb9EscxiNqSrJ1
         E9SNUROma8V0OcmmFYMocQQRRNN33B+CtT8T5kZgu8Tgqv7QFmtXT59hzr2ZAqWbiYfF
         BAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148094; x=1753752894;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QX1c9/Mh/EGaQrrI9AS/O0cONZegTS8Gy7pO7vmBK3s=;
        b=W05PpF02H6tswGERnn7utVEE6w3kWdkgIQIKg+5J70i1BnDB5bG//D54xiNKmcqDx0
         58Vw7QWMbB9wmeIOvYcxAFojBJXvdurWrA5m0xqh8j6MZGXutqfMv2sw4DT53/jZpPC9
         5u2dAzuDhRe4GtVXWCWm14HtkkEIp+Qpi14JBg/G4StvzKswXyH0PA/rtAdQIekIYULp
         EF+FhLUL46K4CUloP/xRgnw3P+UYvRcSTBTlsH7eRmV7vhM429J2DRiwuhVbcU7XKIxu
         xmO0gTknVqHxiFJ13WUN6O9+zFavE0MSEnSFA/KVpn6bLBPirV6nmhW1hLWDsy8dvtme
         GuTA==
X-Forwarded-Encrypted: i=1; AJvYcCVEchDv/mydaoWWvtsiMysXy9TN1wadfkqf5T1QOntTCVcMxS4Z8oZNoDQ1L75sHnstnNEPiaA9lFSRG1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLg7+5T8xe8b2bM9r3DX4emJDmR55uNqxn88gCx15squF2lh1
	IO/wA3l0phW4pvJnjT10R04P0hSkD7VY+7YLw36Rj/4AZsQSzXj6spNlYa4FdC/gaTkV7UgkrNe
	diLRN94dxvw==
X-Google-Smtp-Source: AGHT+IFuiYRn2c2rkf0K51zFEPQoIVUZo3CfbVzecU8nFOP9As6coBCa/SJWHmxy0MbELM4WWmNrSHBrySJ6
X-Received: from pjuj4.prod.google.com ([2002:a17:90a:d004:b0:313:242b:1773])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:310:8d4a:a246
 with SMTP id 98e67ed59e1d1-31c9e6e515cmr29689084a91.1.1753148093986; Mon, 21
 Jul 2025 18:34:53 -0700 (PDT)
Date: Mon, 21 Jul 2025 18:34:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722013449.146233-1-irogers@google.com>
Subject: [PATCH v1] perf pfm: Don't force loading of all PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Force loading all PMUs adds significant cost because DRM and other
PMUs are loaded, it should also not be required if the pmus__
functions are used.

Tested by run perf test, in particular the pfm related tests. Also
`perf list` is identical before and after.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pfm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 0dacc133ed39..e89395814e88 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -47,10 +47,6 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 	p_orig = p = strdup(str);
 	if (!p)
 		return -1;
-	/*
-	 * force loading of the PMU list
-	 */
-	perf_pmus__scan(NULL);
 
 	for (q = p; strsep(&p, ",{}"); q = p) {
 		sep = p ? str + (p - p_orig - 1) : "";
-- 
2.50.0.727.gbf7dc18ff4-goog


