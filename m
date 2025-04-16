Return-Path: <linux-kernel+bounces-603596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D6A889F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B717B428
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE720288C90;
	Mon, 14 Apr 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWPBeeSb"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAB274677
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652367; cv=none; b=E8b27ik4A0C4hoHDCz4Ztnyvi06gCiJivV0dHPJmr7ytmpLkonaboMtYJ45d6dYSE8tisr+/0LiEw+33rnM2fAMtSNSgcGuRdU3lq3gfPCztcUqIKy8EiImTBgEMS+pd6LplXv5TY6O8IeseF7hcYu2Sv16esXZCObaKTa75oII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652367; c=relaxed/simple;
	bh=BG3cptmdu19bcMThD7NA8lSfN1+Pt2oTQaKk/y8dL1A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nEpxqvUDEZRfTJay6I/ae69yGEP4FtRzC+d+vvXSBRKLkDu2I2Id28TDnfHJxhzbk9bTw0uq67M2Vp3YO5ldTVnysvVq02pQhfq6p+iqwcUSLHgfnfxC6Ay91DiGA3mupBe4ehcZ2SQEgjrpNb6Fax14vZy0H4VQtWj7uwcKFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWPBeeSb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22651aca434so36558565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652365; x=1745257165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7950JDAftF3WK1K3IHlXMlo7VBEmV/ZzEp3V/TzSc1I=;
        b=pWPBeeSbQwvD9lcQwgjBReQPHzgvZfW9OJrHTnvOp8KOSsGgcyW/LTD4vJ8XELaajj
         rrfEiJQtUdK+5773uWwPVjBkFCwIO6SH0XzBhtTPhg7Jy5stOUFP/Js7teVjPKwQa3dv
         DyW6foec7LpxbRP/enawMlrw5DZdAvUjx1789rvNvYY1xU0y+SD4+5obH9aC6AqgVJX4
         qaI8+9vsVVwfujxNzemvONEL329HoLn8KV1Wz2ClCul2BokYEjMtE16rrSrndCQqYzge
         xfg+k+uMaVIfvMc52VHjV4ZJIRdlgy2WXqKzOGQ1kTjtqd58S8G/jdCcATexjAlsHdEy
         zk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652365; x=1745257165;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7950JDAftF3WK1K3IHlXMlo7VBEmV/ZzEp3V/TzSc1I=;
        b=QGRmyAWW+HrSjfBD8UZ+mBH6Nx58qPTQEBdq+JIBcJla8bFUdXqeUNu5S/3sELog9M
         kUv05DqxgRp4x6MVBc/XWLamo6TmMYj99mvn0+9mZalBsgilpi6zOu7km4M3YsMFSc32
         PEwvzN1KOjFu63eidHYGkRI2EfubO9F5Ccf1IkezFtFn5UKEanNleufuN0Y5CkJ5x+D3
         axpDDWuXo0i/yLUpVnjz5vM/1sETf6uk5DNSwjeFQD+UHC7IOtQgldChGi13fdVPNvVP
         +3Ii/3kpBktuRk52HUEygLJczP1b+cJiz5akQ5AUtj1sax8E7CtuZCWYG+EY0UBzReYh
         /lhg==
X-Gm-Message-State: AOJu0YwnpUMz+KLPkmbwwWv44F3BeIXnKti8dQwqBFnXt5G4QQaLJ34j
	j+XxISQJvziQebJda7ON9DCI+EF1VQjxx03xtBkbEaZrYXXFWFCEDhfDNom6o/veuXKQnbXSIzM
	9mDMAW3lo36WTjN68fFYOwiag8kptu8L1wqOWXwHRezmhkXkeQlFixALrnF3JkUGi1KhqDSUdiL
	hCvbYCiv3axW0nmCHK0HkmuJtrgMdxaqs+Qv2AcWd7
X-Google-Smtp-Source: AGHT+IH1p8VV9GA+2/0n7svkfNRofRqo/IgobaiRkPAO9uHauKMovWFaKwDcD1yp7RJEITfCn6jE3AhcyZs=
X-Received: from pldy12.prod.google.com ([2002:a17:902:cacc:b0:226:453a:f2db])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e947:b0:220:fb23:48df
 with SMTP id d9443c01a7336-22bea5013d9mr187970925ad.36.1744652365084; Mon, 14
 Apr 2025 10:39:25 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:38:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414173921.2905822-1-ctshao@google.com>
Subject: [PATCH v4] perf report: Skip unsupported new event types
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dvyukov@google.com, ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`perf report` currently halts with an error when encountering
unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
This patch modifies the behavior to skip these samples and continue
processing the remaining events. Additionally, stops reporting if the
new event size is not 8-byte aligned.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 60fb9997ea0d..ba32f8461a4b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct perf_session *session,
 	if (session->header.needs_swap)
 		event_swap(event, evlist__sample_id_all(evlist));
 
-	if (event->header.type >= PERF_RECORD_HEADER_MAX)
-		return -EINVAL;
+	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
+		/* perf should not support unaligned event, stop here. */
+		if (event->header.size % sizeof(u64))
+			return -EINVAL;
+
+		/* This perf is outdated and does not support the latest event type. */
+		ui__warning("Unsupported type %u, please considering update perf.\n",
+			    event->header.type);
+		/* Skip unsupported event by returning its size. */
+		return event->header.size;
+	}
 
 	events_stats__inc(&evlist->stats, event->header.type);
 
-- 
2.49.0.604.gff1f9ca942-goog


