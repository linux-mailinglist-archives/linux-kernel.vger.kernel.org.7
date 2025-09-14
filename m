Return-Path: <linux-kernel+bounces-815791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2EB56B25
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A71E17BC2E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573912E7F04;
	Sun, 14 Sep 2025 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6gCMLKU"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05702E8E05
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873528; cv=none; b=n2qGKYJT1jnJjTkub5G/o+jswiTTV4Na8lKo+6KB9H6MIRPVZz/iKBtWKmoA74rxuKrT83EgEW415JIuITxgMBHbDSdYPe6O652lukHZYMg6abNppoTtNvFLPTuWdjzQRQgTCxyEbfUuNZj0ONdyGm9PcaQZ2a/OtfcE8NxrE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873528; c=relaxed/simple;
	bh=/lWVvuqK7ZPO8OlTvbP03ml/m9hkltI7r5Lnp5abMlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SCmdJCYEMirkRKSdKIMV7sYXxKXD2AQFI+QH3GgFerKUiu1C50gZbMECjXdntWhtZajIOpVOw9OpmGBBJNJO/OgFV5ZXUZ+A5uGFup38xIXmjii2v6rkEejqP2xoYm68VOvdPJsYOgqkOamwhVI2RUX3dp+zVHUTchpGxFAjt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6gCMLKU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24ced7cfa07so37543585ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873526; x=1758478326; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYSFwqlAy6DXlbte7Dca09XDOUDeXcrwb6x4Txuv9Fo=;
        b=W6gCMLKUf1Qdm0m8sZSIvC6nlStPHkMem3QGkMeeU/Jyn0BZIb+fvOMieAe2nP8Lct
         4i8YONekC7OySn9xo4aHCYd5t/D4MkOhXhqsZWnFMVHZIY0svCcsXj9XlYmgWeIRKklj
         uOaZVw37+qBD7I1Q+2ORHQwtzjoI1mn1JBqPs3sEE6jAKuMk90qf3Jyx2pNhzb3vbGcj
         PiKtjrre9fwcRdS2nJU20t3vC7mRWXnPcbg2Bj8Ot4ZLQmTuQ5wdI89Ehb+UR9nOGkPp
         VMSgY+aH56YJ8Pdqb73hmJSFhfCLDANoMsKmw2nIBPKe/sPs3mfsmftvc+sHRpn3HlDS
         e1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873526; x=1758478326;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYSFwqlAy6DXlbte7Dca09XDOUDeXcrwb6x4Txuv9Fo=;
        b=JKjgPsDJQ9Z0wa5PXmNrjygpF66lbv79bW8dj4SrleUnuQoK30gRMeD/jNWfB6zfDt
         iCe43OfGsuI4obaph4uDLreEqTx3X6g2FpjnpkCwAGTk3S1VYdqNDS3u3B0h4rq8T/QR
         UVtl5bKDahMIWjYLyutE83UFhKu5Nivsfk+WyO7Si7tzL7+GbrV5gZVIgfS0FTmwT+/w
         YRQ2z90w2+FH58f8nugSmra+xxDdu837I2/SNcDd621obR/J432DdooHvTg7Ia+tnxvM
         FGhPD44gzQ6/xiqr9b7hvKbigwXHCV7weu6tfvrOTsrxSr6x1OY1mfWzsFmD+rhgNLbY
         xn6A==
X-Forwarded-Encrypted: i=1; AJvYcCW3zYYREVmdAAX9/Ob30ufjlZGX/gEjEtxxPsd2zzr1NcWWqGd5cbwsYjiOEj2I3dVcreUDbOJz1bdk3V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9vm1j33iCUyIS1q07EXlV05d9Qxk5U39iYK8PR1a5ciYdLH+
	ZX63YFYPP8/kZEDSGw2jKxR0O8Ob2vf9qHe6qw68YDjMkqBSStlHTgoAz5NqrTRsNMaldJoA47N
	/Hzg++cI4HQ==
X-Google-Smtp-Source: AGHT+IEEErKdREcN8hd/P7bK3uoM7X5PVPYZyYex0CAoLECSrtA99Rqt2eeKZc9BNuOL1rvt04CzwP6Ktni/
X-Received: from plsl15.prod.google.com ([2002:a17:903:244f:b0:25b:db75:cd39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1590:b0:24e:af92:70c2
 with SMTP id d9443c01a7336-25d24ea0302mr124377165ad.24.1757873526082; Sun, 14
 Sep 2025 11:12:06 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:21 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-22-irogers@google.com>
Subject: [PATCH v4 21/21] perf test: Make stat grep more robust
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

If no cycles event is found by grep don't fail the grep.
Tweak the reg-exp to allow cpu-cycles on ARM.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 8a100a7f2dc1..45041827745d 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -196,7 +196,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "cycles/[uH]*|  cycles[:uH]*  " -c || true)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.51.0.384.g4c02a37b29-goog


