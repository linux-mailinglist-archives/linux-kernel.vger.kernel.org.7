Return-Path: <linux-kernel+bounces-734232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC0B07EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15207B1F98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0402D5A08;
	Wed, 16 Jul 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="neSvIKmE"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712D29C35F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696922; cv=none; b=da/T1Xx0j76udXcDPdIG3VdjDpLxzZIH+Rb1z5JygqxznEd1z5yTmxK8FJzXYzQq39VGJD53M0Q6g+SwKqCpjxErHhovdEw7u5IFKhQVgceSF3R5fnDysEcUeAaiY0qjROaFmyymTbMqf7S1+AMlWPc1vDq1585HuZ12PG1HGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696922; c=relaxed/simple;
	bh=yk5WicchXH7kEqMOOINlnmBRjpljp2ExxBrZz1eU5C0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pHFBzdjU9P98Zpi9Tn7uqSsRiZYwylOiapkKaoVYCkNl7209VzZJIxc1e+B737dEnWnzIDa9PQYPmU68Ht+01hX+S+vq+9mqMgqTtjs69nI5JaG55aNR/I6VqBAAUjtPp1d7S7rvFpyGI5SN2Spg8dYMC1jbG+U2okD5B0Wkxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=neSvIKmE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23632fd6248so1465095ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752696920; x=1753301720; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YYyU2vUox54cPmAD4uAW1jDEZGoCp+ay+KflLB/XBk=;
        b=neSvIKmEXgIS4vgRUJlHfFJ5T6UvcP83Lqf87IcnfXe7NsbogVQviZYYUSY3PTjQAl
         7MKb9Ul8IX63ThgDaYmztsrxOshzxJPCd+8j2seauTeuiJFhYRsrDA2Tf0y7v1rCriwt
         65ia+8gKjXfZdY9VpXKbA5jlaTOToDAJgd1+Jfbf8BxR1PjDNI/p1e3VRMjOISCpJzPW
         qThTeFasgFqkdD3GLfmEtlvsHIq+zVsWAlGk3vxgVrGDgr0n44HjL+HcZ10jL6kl7KCq
         0surh6dgcAQbvyafcrmEXytz69pWNhUTrimudc/cofjsu5J3r6Q88o/cLyd/24NApoxM
         bS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752696920; x=1753301720;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YYyU2vUox54cPmAD4uAW1jDEZGoCp+ay+KflLB/XBk=;
        b=iV49h2Iq4HNHC6QxFBpvUVNj6kNsaMkCagmRVFNg5qxrZZ8u/ZMUIsx5dcYNetaK9R
         K9mFPBTU4lSX2THVKhaye60kWl2RZ4ENgpa5qcQUnyPboHpmihKklkaxr2ML0VsCQrrl
         1T3V4W3mOqSzwSiyaJq7cvioOXlJAvgi1QpRiMpPTrSoB5fGmxfdHjK5+gmBx1JdDaSR
         /zBhH7HKKCMB1XyfRGRjLAlRXkK5/P2lpIGClorIXD4KWIe7KOIgQSxx0zbFCh5xjQ89
         LqhoBJxCtyjpkgjZi55soOnvigdp6wehPtVRN83Jy1nqkSO5kDv8DsBECO6QjgG6vBOg
         fiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXbKzBgsU5JjRT0/Bfmkonv7+A1Q4ne/7YmhOyIYds4PC4TG9wdAf/iizRFXf1w+tYFtP/LZAqRhHHDEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Z0NC/ctHH1+PrRsP9J5ct1wDG9q/aqU6QSgZxLcGQKXpaPdC
	W2VrSAfabXc4LlfWwJm2nYT+cPa9NTrJPmQZ9XenXpDNC0TcS7fA3NtC2PanIDkrwCO2SZQlvAJ
	Ovt0UyTR23g==
X-Google-Smtp-Source: AGHT+IF2/o25FtyKc/XTsOKj5KROC/6FcP6im+HJw/qUwUwO5SOkEl4lT++Lng6HVPPF9BMgiZ7ByCYHnojJ
X-Received: from plcx19.prod.google.com ([2002:a17:903:d3:b0:236:6f45:7ec1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fb0:b0:229:1619:ab58
 with SMTP id d9443c01a7336-23e25770d12mr57910505ad.43.1752696920221; Wed, 16
 Jul 2025 13:15:20 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:15:12 -0700
In-Reply-To: <20250716201512.792052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716201512.792052-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716201512.792052-3-irogers@google.com>
Subject: [PATCH v1 3/3] perf ui scripts: Switch FILENAME_MAX to NAME_MAX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FILENAME_MAX is the same as PATH_MAX (4kb) in glibc rather than
NAME_MAX's 255. Switch to using NAME_MAX and ensure the '\0' is
accounted for in the path's buffer size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/scripts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 2d04ece833aa..1e8c2c2f952d 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -94,7 +94,7 @@ static int check_ev_match(int dir_fd, const char *scriptname, struct perf_sessio
 	FILE *fp;
 
 	{
-		char filename[FILENAME_MAX + 5];
+		char filename[NAME_MAX + 5];
 		int fd;
 
 		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
-- 
2.50.0.727.gbf7dc18ff4-goog


