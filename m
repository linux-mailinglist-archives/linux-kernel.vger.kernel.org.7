Return-Path: <linux-kernel+bounces-861297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41139BF250B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D42BB4F46C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE7284B2E;
	Mon, 20 Oct 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znzkp6gV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF02750FA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976571; cv=none; b=e7E+jJ51S9hNbDYSW3tEoDNqDSygsfk9iRD3OklUn42ARkM3Io6NDSzrCNLxaSi3gLuT+S7HUUXYRBb20ni+QDkeu/n0BceTGT0BuMJ+2sxv6fnlTYlZqUG7/+uKjJe/PyK7dIb69iwSzmJNzkggVxJLiR6xpT+TR/axghY51rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976571; c=relaxed/simple;
	bh=2QXLP6SK3lKgJgIXqDsVNOIENOK0QQBocNMXMNGWMiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zqckht3Mkc0KaSGSfvldANt6iPkRU1f9b0MrSkGRBVZuiRONy8c9BkFWM5ETISGVPStLQeb62s8Ki+dWZcqwEcrji3jCH7ez4v3gbYBAfoNhrqmXE92XGataZO4g/9TTI6bhS2L7TK49nYi4GTcMNpo/7kyVHLZBBk4tn+zAokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znzkp6gV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47109187c32so21735565e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976566; x=1761581366; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pk8YGIw6vGecLqDCrpvEphONom+Aa8XzZmAi261ujCU=;
        b=znzkp6gV5lA60sZRuX45Pt+78DSTtLjGTOUX+bH0ckdoDB9Ei7WUai5XzBCmcuAOHr
         i0yc6WsNDE2pnejOAfCw3oj8SxTFO+eUSvKQWJi/ZGM/qDS9/T7i0y2+tSLLy+IS+gG8
         2pNEI48IqPPADzfUXLbKS5I4GhhfcODj5JWJ9R+7w6uF3jcnHunW5gwFmYdt9FChvDKJ
         BGuNJ5Bjp8Bnp53mX7z1jNrHN0aZ9ZsLEy4watOzAv2YMDGL3j8JndlLA+9o6f6kIQr1
         Fa1YcwQrQZrxzblvKJ9x+N1Eg4b7UEExB8Q4s96W/NCHGydUw0m3ultziRlPiAgF6Pix
         FSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976566; x=1761581366;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk8YGIw6vGecLqDCrpvEphONom+Aa8XzZmAi261ujCU=;
        b=po6xDVVRYfMLpBMznTGWwJ5gvyuQjN7mFz/6Tdah6OtMwiYBJKIMW1x9T/6jBIfw3z
         eStnPyFH0OrC6nTrMVSOdYPaTUr2TXOhBlyk6Y8/iBTWzkP19bUcXKSpWPiHzdEMuY/L
         7XIq+dgyId6LPq+HcXJUDquIMlARIgUamdKmNVPLal4PAnChuHN1Fyl6PcDlmOZGwDel
         Pi3MFrFgnt/ctvmZyMdG4H7x4RdLZ7r7T8vwqg9s7buBUA82gWwavTLgQ/4TZuUASHBA
         1dCPdZ3TBDvdnP5Djtc7ZoVGoVDEeMgxLQfPdP0f5C19a1YIqk0H8uq27W+HmyHKImV5
         JapQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBtTwAmIWLvK4T+E6ET5V3a7yWvG5nYQeTCVArBvZs1R1MU7fOvfG/331S3pkmeSxrYkBMmMxyFfOxMA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOodMF63HsuRkYFfBlm2D4+8G1Wxmeodly7uxL3zJIB+tZdw+o
	NtCeYHrmW0zSWUv/2G+2wVcvn5zW1KMtVCF8wMz0bSu2mpp5XKjMzv+lwXex/LCILfE=
X-Gm-Gg: ASbGncuKVHvbdW6pCj8JIKJpRMbjAYbUm5TdgMQm6/nqrpn6YypOQuwDhnRJk0lRIZz
	WLGem6c9xvAE/20K0zSw30Q7wVrAbDjB5CZ26WA1fw+3L630Q45q6qFDgwcUqBAkf1Z/zgBG6QY
	oCeJbcwQjMjNj0gTm8uQ0JOKQEFWCzySFLRk5Sq1XvrYd2FKXvchnMvehwZiXUScL/9AGtWRKMQ
	XrlqKaJoQ7JmR4Dgs9ryAugDNUSTzl7k80IUBq1LYvsQp5AkKE/njJbduwP1tS0lUbQ8Du+hnFS
	dMgOXEGpD06N2LNlfEOwNbg/jj36+iaQyPCoXGT3vgM/jNXnlX9Xzph9ZwFBISLcUnuTrqQynda
	k9WYlNOtbI22iXyVTF2a3mQ/eT33zbniB1DIjpZPjzjBXgRn4oiHaiVp1gRd/FQobQiL8ZMN1U4
	QpO7X+EmW6JA==
X-Google-Smtp-Source: AGHT+IH9ev28WRuhzDTHIVO6uset6CmxbofPJQPzPY3DjQS/+NnjZudW3Wzskkz3N9KsfAEPDlvMlQ==
X-Received: by 2002:a05:600c:828a:b0:46e:5a5b:db60 with SMTP id 5b1f17b1804b1-4711791c4eamr97032365e9.31.1760976566515;
        Mon, 20 Oct 2025 09:09:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16408067f8f.28.2025.10.20.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:09:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf jevents: Fix build when there are other json
 files in the tree
Date: Mon, 20 Oct 2025 17:08:25 +0100
Message-Id: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHle9mgC/x2MQQqEMBAEvyJzdiDJ4kL8iniQTUcnsFEyIIL49
 x32VgXVfZOiCZTG7qaGU1T2auL7jj7bUlewJHMKLgzeBcdl+UL5QMuc5eKiezWoiWPOSB5DeMc
 X2fxosOB/Pc3P8wNZXj9TagAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

I hit this issue because I'm using clangd with a json compile database.
Not sure if anyone else will actually hit this, but it's not impossible
and the fix is trivial anyway. The first commit is the fix so has a tag.
The other two commits are minor related cleanups.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (3):
      perf jevents: Fix build when there are other json files in the tree
      perf jevents: Remove unused makefile variable
      perf jevents: Suppress circular dependency warnings

 tools/perf/pmu-events/Build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
---
base-commit: ad83f3b7155db28e82de24dbaa1af2b8f5d972a3
change-id: 20251020-james-perf-fix-json-find-9ffed1e52693

Best regards,
-- 
James Clark <james.clark@linaro.org>


