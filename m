Return-Path: <linux-kernel+bounces-672240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B23ACCCB4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 20:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B0F7A4B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B05288C0E;
	Tue,  3 Jun 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afQCS+m0"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6A2853E0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974601; cv=none; b=hKCuTaXz1ty17oJO2fZ7084E8BA1Yzr/tt+9hZtH115R+JuoPbmKINSF5zHwCiEanKstOAUUpAcUxwtA1RiKx9JRm2L7xuNbE/XZr03rfMLll761U61/tm2vUUF1azyx+m3Lwd29C50XZUvESvkQAPlMwI4qyDGClRwt8EiTgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974601; c=relaxed/simple;
	bh=zzlz0XiaHl9k5I5nTOV3bt+4IyFgiGwUBoM8qCzc6d4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fwAd2MytXqx4sNd2sNahefZ7tismiQ/vgLD9Wg3VoX5YKlxTeMaS+5vuoJA1fHOxEC3G90w9moIDhLQGaWX+uyyRvKjRnl9EsVR0K6ayyDm/aKamgAbVwEj8b1j8+3JFDmafrA055FoCsN0qRlwpwoqXqzJPEm8TbkEINzy5e+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afQCS+m0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234b133b428so41325805ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748974599; x=1749579399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dlaUJQBmuGJwNHdjlVkIdQC8DooPW/OGsJq5Qkj2en0=;
        b=afQCS+m0fjrTXuEvT0NFk9IqG8Zgbc9ZE4OV/A/IRPb7yaaNQ/Jmcc79yjpjH2kO9b
         0dY0oOURUOmmngCUnxa1I64cGNNDrKb1c8jYlTrlsErtTkON5zARPe0QRurbQKNAc4so
         Y4aLBkese4+fLCQAajkgAjui4Ax4Gj2xAz4UzHwYrr34/4a3RSsWdhjZTqya0sU2K8DM
         Nf7wjL/S0wfvdF7mZL+iu70yCNuVmSej09IOdWBXLj9kO6/REtTKngTi/uiSxvDz6L2f
         5tpwRpNnkaDHL2vPrfaoetGPARag+Pa6OWF85KO+0o46tY/efsyYPKgYAKEr7t7xrbU3
         9pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748974599; x=1749579399;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlaUJQBmuGJwNHdjlVkIdQC8DooPW/OGsJq5Qkj2en0=;
        b=hfJ/5VboBoUESIR4qYUCNhVuOGd2IitA9J7eVje8N8EqLmpIPvbQbxcBU3nBnxAQLT
         BFWg7lOKjthO+u6dnbuBzzJ9922ULKY50dMEvr+Af3aSxxkudRcAgde2nDQIyhGVq1Q4
         nLSUaz9zADVmdLj5ychNMGs+bW2SiqcOz+ym6KDpy18DfvcKcl57NvMMYMk+NNynu3RU
         9DQAf4HIf9riEu8vKnL0GmcNCxouPb0G+CvTFOqyHwczURz/ylK1+3NDvRfCi/x8eajg
         W0gbsbYrDwHmgyyF9y4b/m6RBDNx0Kcb+QduHNyY7MyeAngjNXnrEhzYoRzqR8Bcmgi4
         S/1Q==
X-Gm-Message-State: AOJu0YzVhqu6JlXODWOr93qwD/fkJDkOe5IZkPV0dJBJjfzeZAA6y1H3
	2iTLZWe1bXGALUk9JmoaNYMEH6hvBLVbtOPsLv4EjTaTYiJMmLEsGyWJ5kCRJJ5LfYsfIyKvOy3
	NrAqnWD6ObxkwpXL9DE8Gt3tCNJmX16Xu7cui5o5My4JgJjZ+P+SV5NXQPDMj+C/rhWEMeQ08FV
	oMgCT8/Mtaxn+pf2PLDqNhru9sdlYMr2h69dJFI8d1guxP
X-Google-Smtp-Source: AGHT+IGzo+5jSA0iizSd6Tn3gQ4e3xsellXfHop9mUoZhgA5AqQTUoYuEgJH3L+6oxVBfetYe8qPhwiqW9c=
X-Received: from plblg15.prod.google.com ([2002:a17:902:fb8f:b0:220:d81a:8975])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f611:b0:224:76f:9e4a
 with SMTP id d9443c01a7336-235291f59aamr292314915ad.14.1748974599152; Tue, 03
 Jun 2025 11:16:39 -0700 (PDT)
Date: Tue,  3 Jun 2025 11:15:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603181634.1362626-1-ctshao@google.com>
Subject: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	weilin.wang@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It gives useful info on knowing which PMUs are reserved by this process.
Also add config which would be useful.
Testing cycles:

  $ ./perf stat -e cycles &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    3081
  perf_event_attr.type:   0
  perf_event_attr.config: 0

Testing L1-dcache-load-misses:

  $ ./perf stat -e L1-dcache-load-misses &
  $ cat /proc/`pidof perf`/fdinfo/3
  pos:    0
  flags:  02000002
  mnt_id: 16
  ino:    1072
  perf_event_attr.type:   3
  perf_event_attr.config: 65536

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v4:
  Removed the first patch in v3 since it is merged.
  Retested to make sure the patch still work.

v3: lore.kernel.org/20241106003007.2112584-2-ctshao@google.com

 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95e703891b24..bad563692d63 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -56,6 +56,7 @@
 #include <linux/buildid.h>
 #include <linux/task_work.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/seq_file.h>

 #include "internal.h"

@@ -7077,6 +7078,14 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	return 0;
 }

+static void perf_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct perf_event *event = f->private_data;
+
+	seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
+	seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long long)event->attr.config);
+}
+
 static const struct file_operations perf_fops = {
 	.release		= perf_release,
 	.read			= perf_read,
@@ -7085,6 +7094,7 @@ static const struct file_operations perf_fops = {
 	.compat_ioctl		= perf_compat_ioctl,
 	.mmap			= perf_mmap,
 	.fasync			= perf_fasync,
+	.show_fdinfo		= perf_show_fdinfo,
 };

 /*
--
2.49.0.1204.g71687c7c1d-goog


