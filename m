Return-Path: <linux-kernel+bounces-664751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281AAC6019
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 05:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4337F1BC210F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 03:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFF1FF1C7;
	Wed, 28 May 2025 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z3920srW"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AB1E9906
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402814; cv=none; b=XwGGqdAM8SPxNF6zOCF73fTX812ES2HH524RvxUVqTCH14htzgvEsy4BIIWm/1zr+UqM8aHMXOrXdPpkq912iC0tXfu8gsqFgkODRq6vS1z1uVdRcCWTlri5uJb4F6o0lSxoMYQVyuSn9Y8rvXeeY3GSjPCA7xuAPG84588ViOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402814; c=relaxed/simple;
	bh=yjTPsKSxmbyVi0xYc8waeGT8wUg8QG5YQf9FdsD3qXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EUXhMKJnEBhj6s7ygi8YXS7UJJhizHRNZDxveXy5dzTcVF6CobDlr+if1vECA/GKffl0hbnOPbJgngU/mnVsOjhIYqbwXGYkGRhwqv1X+ZXptnJ/6bgGWVzI3gjdUSDUAQjYDGliDYqtEXNzKDrc1BlvGdBUfyPzFpPmNAWtJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z3920srW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742a969a4d0so3268434b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 20:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402813; x=1749007613; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZAHNOEi1GDiBdM9uSQlMPb9/h/uXsjvJd4PLbv+ikw=;
        b=Z3920srWuZ4exNdOXKZ/EZs6esEzLbSJUHEBiF0EMTgCcRr0Dh2lb4gKRNcyuGwRsJ
         koZS/eEdXUACZ9M9CniwbQhQuVK181iaNHg/ZFfQOiulq4dXRKSlKnmjx2t2J1CYyCFq
         s/MoxBy7XPxpXzxdlrEWD1gGheOMVm8L5DiiiyD8LgOfbbQCANRilMI1pK2KKJPHWZ5P
         t3Co+KIuL3JlettMPyRXXmXd76bEaY8BqPM1/IQFr83UnGEykcKJRPbwSNliPEygECvR
         frefzHPL8u/80u/gFA5Rb9+EWchmQQJXfUbLtQynnfXEoZ94uh6yGIolG1HGMF8PeMqm
         rBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402813; x=1749007613;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZAHNOEi1GDiBdM9uSQlMPb9/h/uXsjvJd4PLbv+ikw=;
        b=cjn516DQBTt+tV+WhsQDMbY9nXRo8UTBkIkQDqEnNBtH0ojB32rCRINttRla5d8DrU
         hVbQyqg0AZj6yOJAM6knbufxNGXwF+SFeS6BwKSMgWFgcn1iOo6XJxHazmWnNqtt1hty
         tEpBv5CZvXkr1I+wBqmZfc52Ca56ouJaE03MKRcX/zqdBROnRFQxwFtzxeIOL94I2LX3
         t7fK9a4GnvypUBtVUQ2xD6j9kZbVGY7DeXhMIqTc9C9UUHsuhQWCVZhEmLkQqGH/7ALB
         AvCcy5uSwUnFA5Q4zSJ3KGTZgMLEPLOfR5rh7/f4bpN6RD1yZf5qAWxBZnbL9qKfjFGE
         M1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCX5JCkR/MzVB8xClCP8hVsbZK2kY+EQcukDMczWuQn4TYcbmaSDY9BI3uHKB4tHRjwYo8NIpPakZA0bFcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFra3Rry+ZuRXQpBJK+FuY9oWlV6i8vmqRfg+6nraAVsR7UoRK
	9aXPBy0TSKXwWCfy+rmvr/+/5SrPSSoeeyIw5CVMePEDM/ReK1PCEXKwepSrePcWEhsl1hwZRYI
	c17nRZ0ClyQ==
X-Google-Smtp-Source: AGHT+IFHNdbunybiDC1c15s08f0AHDldblug++nnZKfibi8krDlpSwQGpmfT98+ER5+JgXKf2Eu1056F7el4
X-Received: from pfbcr6.prod.google.com ([2002:a05:6a00:f06:b0:740:b40b:d298])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c2:b0:736:450c:fa54
 with SMTP id d2e1a72fcca58-745fde9e1c5mr21632802b3a.6.1748402812580; Tue, 27
 May 2025 20:26:52 -0700 (PDT)
Date: Tue, 27 May 2025 20:26:36 -0700
In-Reply-To: <20250528032637.198960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528032637.198960-7-irogers@google.com>
Subject: [PATCH v2 6/7] perf test trace_summary: Skip --bpf-summary tests if
 no libbpf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If perf is built without libbpf (e.g. NO_LIBBPF=1) then the
--bpf-summary perf trace tests will fail. Skip the tests as this is
expected behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 49766524dc21..f9bb7f9388be 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -53,6 +53,12 @@ test_perf_trace "-as --summary-mode=thread --no-bpf-summary"
 # summary only for system wide - total summary mode
 test_perf_trace "-as --summary-mode=total --no-bpf-summary"
 
+if ! perf check feature -q bpf; then
+    echo "Skip --bpf-summary tests as perf built without libbpf"
+    rm -f ${OUTPUT}
+    exit 2
+fi
+
 # summary only for system wide - per-thread summary with BPF
 test_perf_trace "-as --summary-mode=thread --bpf-summary"
 
-- 
2.49.0.1238.gf8c92423fb-goog


