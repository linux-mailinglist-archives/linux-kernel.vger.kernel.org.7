Return-Path: <linux-kernel+bounces-823358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D174B86328
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4E65637B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F893195FE;
	Thu, 18 Sep 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmBM6LLj"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80931328D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216263; cv=none; b=m/VUj+65ljR2to8/xKeuUNOdmb051nd/ooaJTdGQbutHRVg8q8NoF2KEux9IOhfa/xj8vLk8OzLbGooEvw6oJEBQ1HH8B4yGXjzPPQykt7hsEx/GU6wuLyjFuMHTGHNmKTFxXSoOco/gPKY01TtEYPj/0gHtwyt5zNQv/SWlrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216263; c=relaxed/simple;
	bh=h+y2Um0sWiG++m2eQ4n+7CATo8zmvy0N5uykStccMxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D3dYZSVqMrRiEQ7eekVtX3PhwMwYjzWpi/zMoeI3X8/bPtmIwDwjGZR14yXp1AoTNI2Lhu1g7cOnL8fUDWfzrlTzdMCeFIPpelisgU7fdSioAiWe7WvHEcTiX1WufALh5tYQie2JALy9Br0viJR8RuZ3b1NVZzZ6aJTIjawguOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmBM6LLj; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-33103aaaea3so1161840fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758216261; x=1758821061; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsfmL0ulg/CT1LMIENsj8BUyC9tsKVtVKqCgN4jh7dI=;
        b=SmBM6LLjBSsTIGMHdNg3CmFo7TRLz0eY6MzvQeOjBhEWXwoLdLN3Qxg3NvhxT266w+
         akTZs2AkLVnHOSLwgPEslqXioU9ndl/M4jzKzN2lIc4Y9OGKVzw/e9tkxs7ps4Wpdf54
         yYEYe5i/vyPnXXYj1yuQCRPo9PlI6+t+nqUYdwdYYkMqlO39TnSL+K8mYmehrMb0n41U
         oLiJI6reecauan35sHXAXdJexCLZdCZLEJv13yG2sz2FjvggF6WKbL/uRf36zE7wNuSk
         OyI7xcJY3aYYx3ed8fd1FZH9aY98QzQFWyNCvv+YHaXVbvz8i/Msh9DS21xVDcS0Ywz/
         P/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216261; x=1758821061;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsfmL0ulg/CT1LMIENsj8BUyC9tsKVtVKqCgN4jh7dI=;
        b=wDJPWsE+5ysKZDy+aDeh/Tg3TSyXPwCvwQDdCoCsutyyf3AmU/SWdHvfnJtlTVqSTF
         DJHJTlozhLY6rpSaTfps7uClMgGOjpVT5L8vTBT3FIvpwyWmWIJlL63eJVJDxfXOkjkU
         43n9mB4+7GMNSLNELNC30wpqdDJEZXehrWvBgmD+duJ3qOwjER7PAliCls9UJ+pmPgU/
         Ar7HVX2+3nD3Zg1NdyM4loqp+l2kOH8n3MtO7KRtOU081nrcCuRFcTHIPq70D2biBG+0
         R2gQQZOtZl3sz8F5Z108fY9u5UU1mIXCipGv3Sk3mDSBrlIyYDL0cUyul8xKEUWJqy8z
         EUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWfHVmdaVUqUaU6aFFUwopy9v6kakqyO9/x9LOSrSnoKqS0TWztcyCOaL2sJ/cX8kv2s3ODLiXin1/TAJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8QP2tivyG/YA8XQdNCa0yIQZlWx0yWw+9vrBNuyMX7+EjWOA
	RXFF11m/1x/CcHdHX2OSvrVaxkV6HmGQcTMiHb+znHh7D5S1sopbdKwOxbgPgUw1IVNikt3H5B9
	sXqzjs/2/qQ==
X-Google-Smtp-Source: AGHT+IGWB/VXAS3RnF6arcEmZeiuRWFqDcSNYAyDvKYDCL+F0KRVx4cJ1GKjg8GNB3EYMyo2OmRye3CO7CG7
X-Received: from oablc18.prod.google.com ([2002:a05:6871:4192:b0:332:c618:867f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d88d:b0:31d:8edc:3d1a
 with SMTP id 586e51a60fabf-33bb38a30ebmr282005fac.7.1758216260804; Thu, 18
 Sep 2025 10:24:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:24:16 -0700
In-Reply-To: <20250918172416.1247940-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918172416.1247940-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918172416.1247940-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf build-id: Ensure snprintf string is empty when
 size is 0
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

The string result of build_id__snprintf is unconditionally used in
places like dsos__fprintf_buildid_cb. If the build id has size 0 then
this creates a use of uninitialized memory. Add null termination for
the size 0 case.

A similar fix was written by Jiri Olsa in commit 6311951d4f8f ("perf
tools: Initialize output buffer in build_id__sprintf") but lost in the
transition to snprintf.

Fixes: fccaaf6fbbc5 ("perf build-id: Change sprintf functions to snprintf")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bf7f3268b9a2..35505a1ffd11 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -86,6 +86,13 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
 {
 	size_t offs = 0;
 
+	if (build_id->size == 0) {
+		/* Ensure bf is always \0 terminated. */
+		if (bf_size > 0)
+			bf[0] = '\0';
+		return 0;
+	}
+
 	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
 		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
 
-- 
2.51.0.470.ga7dc726c21-goog


