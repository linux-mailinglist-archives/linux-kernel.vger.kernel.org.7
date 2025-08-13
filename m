Return-Path: <linux-kernel+bounces-766763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6DB24ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA532880C76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09552EACE3;
	Wed, 13 Aug 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBEVIFyG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E12EA491
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092356; cv=none; b=BKqWn2QppzZc9YxoxZ3VRKHdBLyIt31JGS9/4n5vNwL/aoGPk6wRn18RHExlO6HVIhVa12806g66pxSe1AA+WZFax16l3lPMYkwx/y9BJQoO35oBt5yEHSNhl2xJY5y31mgA3aAq+mmthfOU4mDQwsC7K3lyUMmVxU/V5+jvNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092356; c=relaxed/simple;
	bh=BSquri1ehPvo/7d5c+a4YTv4dM4257Xit2wsucmaE4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+JpxZDld0dmZAFW0iAXoKmiAG7EA0nLsFGfMGczLy6rR3ZGiCHQybSh6qM9eAehSGexd3u81JBa8TBXVcyOD7pdO+rI6wEDzFH2t59tbpQ6dMjO5N+txRe1fJLLFbK883bmLBbM5Iql+DEsnUwQBfWMWIdw87jFROLtzxAUezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBEVIFyG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so61483735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092353; x=1755697153; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXRTSxaBDiamZdLryvWgDWimTgP/dkmICkmflBjhYNk=;
        b=IBEVIFyGCN+2VJ5uRjo5cQr/O0fYF5TZkCykgYqvV1jgcW0N5FTfKeGN8D1nAXKNZe
         h4OIH9wIqz0ZcKTr7nHHYJg3R0AoodJ5nYYyT0VGM8cNqU1KhlhH8VMHfY64xv1oXucC
         ZqWWAyHlSEMK+hGdP7X3FnDuPExXdplFWOGvyzYmZfAQbzhfWjLXXYdZnMV9qGApND5Q
         5XIqrlX/k0j7UTfoL2TeXy2jXujCO4gkSUBgbwoN/Tqzu3Dm57ZmNClPljqV98aghlUM
         0ev3s/kOfUIVLxO6Brs0KvtNVazP/WOYfg5k6u5hJM4KbPviSvOoQBQ3kV4AOoVQUIvb
         Ieaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092353; x=1755697153;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXRTSxaBDiamZdLryvWgDWimTgP/dkmICkmflBjhYNk=;
        b=Nl8IEOTe1sUprYu6/KNgXflydSd8XtDOdqhK697NBNg7HffI0RhDEz9aCDydnbCFAT
         suNJTE5CqSeXQ/YPnU0JbZkwP3XZAlHvHholeqcWFYAc08DY3tGTIepSgzjEwBxBFBYr
         8Eq715Mbw9p6mfMV8xjeR4iUtYzSKSJ6lSqu2/rDdtlV821lMdtj11MPYtH4bMoGpXZ3
         2OS1gA308kFmud8ddxO8YjzQzmoi4H9FUDIjZP+NZ1OqpZxnhXzNLIovrvAAlnYEwUNW
         2XDWKJxJduUDlS9kPcfpXVCaaGyClSbqPzh0ksR9NyZWYKJSZgCxxPkHeAteHt4xa5U1
         /XhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1XVZiFEUELCV7i+3DtUbik/zgPk/eb/7w1mfFZe75BxeqjyrVBUgxcVPNIjuzntxIOtQZBPfaArBnLYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMVdBxr5NlEnUdqknnbUq8vbC8RDUZMwXD14X8mBk8hQaz1sGm
	NiiSkKmdWT/q9GjeIEeA+0tFSfCmYAhCwCpYL0A3PEpFW43snXiFir5i1TX7xEnEJkY=
X-Gm-Gg: ASbGncvIZRnwEZK5sFVYYjFwU5e+fz9J5W3JGYgvEAEZN95wGzqI+bEIQ5NTCAqHvRi
	BieWMXWLXunGEp+g2sDpZ6434yFfaJ3vWBnqpLTuvJI79R1MKiaaiH88vf5NLUtUatIIoi6Spu0
	Q8UlFHDGx3pIvryLK6nvQNhf8tCMFxM59aaD8eEPkSVj5xKM3VvEXsUryc+PAF9GOMjN/qeTVOY
	ULmQheKXhVFqDRKIuF9lrXs4LImGT82YpXsuhR/rGxcsINE4QGMkQzRORrap4bvKcoHp0uQT7o8
	8jOs1oahJZzIJLcKH2LN1/MGec8FM2NieUw62JCpm1IRxwVWqLfa9DuOfOAqG2nDPmAFWoZ8/l7
	yWb3/wLL3x87wiAKZpejB1olzRc0EsHw=
X-Google-Smtp-Source: AGHT+IG3udgDaAlwh+lrjjXU3BJxo4TAd0E1NhlNY+y0CX1dG832Sh7haHOGucTAmj0XC09O9jxQYA==
X-Received: by 2002:a05:600c:310d:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45a1659a26amr32940525e9.4.1755092352977;
        Wed, 13 Aug 2025 06:39:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a596280sm2559145e9.28.2025.08.13.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:39:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf test: Extend branch stack sampling test for arm64
 BRBE
Date: Wed, 13 Aug 2025 14:38:48 +0100
Message-Id: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGiVnGgC/x3MTQqAIBBA4avErBtQK4quEi00x5qgH5yIILx70
 vJbvPeCUGQS6IsXIt0sfOwZuixgWuw+E7LPBqNMozqtcbUbCbroCC+SC0NjjfIh+LaqIVdnpMD
 PfxzGlD41g06cYQAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
 Adam Young <admiyo@os.amperecomputing.com>, Will Deacon <will@kernel.org>, 
 German Gomez <german.gomez@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Refactor and add some extra tests for all platforms which were useful
when developing and testing the BRBE (Branch Buffer Extension) driver
[1]. Then lastly extend the test for new features which are BRBE
specific.

Tested on the Arm FVP RevC model [2] and Intel Raptor Lake.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58074a0fce66
[2]: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (3):
      perf test: Refactor brstack test
      perf test: Add syscall and address tests to brstack test
      perf test: Extend branch stack sampling test for Arm64 BRBE

 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/shell/test_brstack.sh | 106 ++++++++++++++++++++++++++++++---
 tools/perf/tests/tests.h               |   1 +
 tools/perf/tests/workloads/Build       |   2 +
 tools/perf/tests/workloads/traploop.c  |  31 ++++++++++
 5 files changed, 132 insertions(+), 9 deletions(-)
---
base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
change-id: 20250811-james-brbe-test-f5a20dffd734

Best regards,
-- 
James Clark <james.clark@linaro.org>


