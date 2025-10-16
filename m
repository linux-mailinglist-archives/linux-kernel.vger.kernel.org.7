Return-Path: <linux-kernel+bounces-856419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52ABE420C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE035886B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4573469EE;
	Thu, 16 Oct 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/hTt3uq"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C75343D9E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627247; cv=none; b=lPwmEeb+Xh1gMrPUAOEuSFmGjZQJ8i/YQOEAepuAbOxJaD7oypXNjOMtNemjHCrgLWTSbdc8rwXd6U6IYEIcC1+HeOYXJTvVmW7opYHT29hb4zOUJJ/uFv+OKnH8yClCqAvm1KWNF1dUsO8wUxPEU5iC5D6F6jsO4tE2DbWzw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627247; c=relaxed/simple;
	bh=4Kv+Q//f68Xkwsporcq2AyDXgJ8e4LcpwNVEwpp7yDk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=WxD64EciNGxh6gDvO0/JyamkJF0yWY7VhkUk2DD3ohAW8JQaAHkvBg4aD2u31dGa3KAqZllf/xOonqxqLY6dW8L9TAnWIcCZu2RZTuR2Kzgjvltkknub6SkLremB44cELXl38egQAmHo4HxUXCSzUfFj9Jj4zQa+pjT3N+hxK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/hTt3uq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28bd8b3fa67so8991805ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760627245; x=1761232045; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kqpf0Fu0OCWR1YlBKGJvnIsofgUkQfFS/TDp/NjRK2I=;
        b=j/hTt3uqt/b4DdHBKWPKsfW1yFJVG049GvAkag/t/rLtpcv2N4SknuSvkYV5TRiAMy
         wYVljTuI4yc6rRw0xVbDPPrCE3XoxIoJ4/dhCl3k5sAAYsOukic7+7rrtBVY0QWA77BY
         dO69E+iqRhhANnp52nE4PfIs45f9rHLPhln8E1oMIprZPL1+F81Nz2pjEbThcRrIRL1c
         4BgjFBXJPkPqOVQ76+QVRyjfE2TgfcjmEI58rz0jBB+KJL4jtuBE4jmbGdkU9yhiF3ZT
         G1p2WCJyr7CFJUbFPa2yEb1QYlJw3OopufHhp7HK2Ls8jEbXUlAT/azdaSUHKyYI/OsS
         du2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627245; x=1761232045;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kqpf0Fu0OCWR1YlBKGJvnIsofgUkQfFS/TDp/NjRK2I=;
        b=uZwkSbSzC1S0LbXZN0w/4Q5xEeYRoarVwjHFTtCiHFiF3kvNgN47SVnEcFSH7p1BJj
         bOURHwGdLgtWvu9IEt8wLXDoJlP67RXmrdubLfMVJwfu3deJdE1asxWdZS3lJhdTtANA
         tanLfphEfSiCYa8xVDUIZyhDfR02S/x8OzVRh/vz5mL5nJqlYGf7+2j3YEH81O6X2NqH
         K03UUbeyYQ659qz6CKuq/3F/P2XVmCL7jhMwiJ5fol97W4gtwo7njrxvVE3V/fFpY6m3
         Wv5AA/zFen2Gnw96WKpqH3uI5tBOj9vjsO4l801as399nuBPlDzWDvjXxqX5CazV8zF3
         92Gg==
X-Forwarded-Encrypted: i=1; AJvYcCV8jXxf3oggrxzq6x3eAFhtUe/RTFYvYPj0O4ss6CJvedws8QVuC9aRAhCOtUSeBPDwtvAJBoubh3+9U2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0rHDcguGLbJOTxPzkiGn0RgHx17eT1y96vWJ/2rR+VBmXICm
	QXdAj9zNvDQK0ISR7dKTQIkbF5LU4qcGtJWplsiwNnheoBTl7mkJ5/CuyKKKwVAhm0lhA6rrAeK
	SwUjlzhLnjQ==
X-Google-Smtp-Source: AGHT+IHqYPhC2qOdi+vpE2OyTisfl6js/3CJd2u9/Vb8VK0aQflkqpoBI99mXrkhamaij8CCRoww5vvQZ8Ow
X-Received: from plma24.prod.google.com ([2002:a17:902:7d98:b0:290:28e2:ce55])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:290:533b:25c9
 with SMTP id d9443c01a7336-290c9c8ae4dmr3441075ad.2.1760627244753; Thu, 16
 Oct 2025 08:07:24 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:07:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251016150718.2778187-1-irogers@google.com>
Subject: [PATCH v1] perf stat bperf cgroup: Increase MAX_EVENTS from 32 to 1024
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The MAX_EVENTS value ensured a counted loop presumably to satisfy the
BPF verifier. It is possible to go past 32 events when gathering
uncore events. Increase the amount to 1024 as that should provide some
amount of headroom.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 57cab7647a9a..18ab4d9b49ff 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -7,7 +7,7 @@
 #include <bpf/bpf_core_read.h>
 
 #define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
-#define MAX_EVENTS  32  // max events per cgroup: arbitrary
+#define MAX_EVENTS  1024  // max events per cgroup: arbitrary
 
 // NOTE: many of map and global data will be modified before loading
 //       from the userspace (perf tool) using the skeleton helpers.
-- 
2.51.0.788.g6d19910ace-goog


