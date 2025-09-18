Return-Path: <linux-kernel+bounces-797177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29CB40CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C581A88130
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB5334DCCF;
	Tue,  2 Sep 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4SkIzYB"
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286434DCCA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837079; cv=none; b=AE8pMWvhWkUUA6YuVS4/2YjJvbLbQ0smHCFMUHMlbHeZgpQjqBbktA9xULP8EzPv+uhgT1JNnzDci5IV/xGp/ifNa0pcWU8mPuPv1JD2+1hmJEllH0TGoSC1jGDsMtLtwPnfq69wpniQroS9Ab60UET7RvI48bPmRxlrQ2GNIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837079; c=relaxed/simple;
	bh=SW0b26VMfjHwsZ9uitQCtKd1Xk3hYByNXZLW5ZTvqTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R8m7uhshX+gmIMn8WTyr/0ZmIDHP2DTIuFlUq08XZi7hRGaq53QLiSiP9zYF5YKx1/inTEH8cLtZnCNt95ltR6SslGGcsmAKh0kQyl3rAUoxv7/JJTjgZAWWaXtbf3sBfpT5bvDpMAYKPICK12QUuhKfPG/V5S73UcAqN+Z7VmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4SkIzYB; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-61e3dc3be5fso1254654eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756837077; x=1757441877; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fJ6F2Zo1Rl5YqU+YLRmyxNhHYiro+j86SsEqve7WLE=;
        b=H4SkIzYBkepxl0Vrr6ntlofUbKOUz5Seal7sbYGtuZ2y0w0PBlDswffzNd99pc9/Gu
         k4E0ygXuHJx6TQlKPrAPH3WIkB4RWw0F4Z2/f0i+BzJ1fVroYcyXEzVzvdqPDzLgNpz1
         B+97BfSlRZxVg2y6zP2k9N4jQe7E7vetIYZe7hMh5GuR1jXcyr2tKs+BoQ2ggySfwhPy
         kMrtQbCnN+5VsrnChfoibnGwfnHkL8WZA/OHIob4bLbp7I38quHj5qdIvxBmBSiQCG7E
         hgvbQUIbK6/5U9VCz8UQt7O4Zto6upfnLgaCV1N1qxmJyhrLHAofIaGCl9pDBba5/YX9
         g+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837077; x=1757441877;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fJ6F2Zo1Rl5YqU+YLRmyxNhHYiro+j86SsEqve7WLE=;
        b=D/8VhHddWP+4jayRHYGweCqw/ctutri/KeDJC8KTpoKsBqGwBm27R+4IbkFbf5hSk4
         yHBng8TR+R0oggF4JCB7c5C0hbbBGT3bibwEtKtSTZW615mnc/M/grScqjf9OUVhJI1Y
         7bRzG3853GWi7EEEgJNnRaQgu3fitRxPPT0QBrbO2XwKY6FR+buJ1jxMjDGR+VmZ0wnK
         P5lRRMhyoYjtfWAIWbVzWlQkdqtx6psZX5rNntMdZOSBlxqAIVZPKwB4rrFn1Vyg+M1C
         Vj7PT2PgqQxH4Iupi/Ftbsxk2p131IblW48iUvjNSBTuG8KJyrRIrG748jR0EPNEyOyD
         1quQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHpFxDjJHZ6Vd2UwcGbAySlFS84r9vnZITRbz/VcyHyDh3tvz+Vw7b6XggVmK11OiZ0pBjJSO2tWgpWuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPnFA19BN5mlfz6JDXyHCejJP34YaMaEeMF5oRCAoj2kSj0is
	MLQDjYq86YvEto7E/PBE6eCjV2RwVTx+0D0DQzAxJ6sdTDregnzOp6DE1/XbgJ6W+kaEfD8iLPx
	+r8e0Y2hAnQ==
X-Google-Smtp-Source: AGHT+IEdTO+xqdEcvEbC6ccVCFQ9YfFZThHAwhuqZuFa4L5/g5yckG2owGfEDKDo1c1TEd1HPgbX3g81Z3qM
X-Received: from oabpd23.prod.google.com ([2002:a05:6870:1f17:b0:302:431d:f0cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:ad03:b0:30b:a81d:b56
 with SMTP id 586e51a60fabf-319633c847cmr6153004fac.38.1756837077033; Tue, 02
 Sep 2025 11:17:57 -0700 (PDT)
Date: Tue,  2 Sep 2025 11:17:12 -0700
In-Reply-To: <20250902181713.309797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902181713.309797-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250902181713.309797-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf bpf-utils: Constify bpil_array_desc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Howard Chu <howardchu95@gmail.com>, song@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

The array's contents is a compile time constant. Constify to make the
code more intention revealing and avoid unintended errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-utils.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
index 80b1d2b3729b..64a558344696 100644
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -20,7 +20,7 @@ struct bpil_array_desc {
 				 */
 };
 
-static struct bpil_array_desc bpil_array_desc[] = {
+static const struct bpil_array_desc bpil_array_desc[] = {
 	[PERF_BPIL_JITED_INSNS] = {
 		offsetof(struct bpf_prog_info, jited_prog_insns),
 		offsetof(struct bpf_prog_info, jited_prog_len),
@@ -129,12 +129,10 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 
 	/* step 2: calculate total size of all arrays */
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		bool include_array = (arrays & (1UL << i)) > 0;
-		struct bpil_array_desc *desc;
 		__u32 count, size;
 
-		desc = bpil_array_desc + i;
-
 		/* kernel is too old to support this field */
 		if (info_len < desc->array_offset + sizeof(__u32) ||
 		    info_len < desc->count_offset + sizeof(__u32) ||
@@ -163,13 +161,12 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 	ptr = info_linear->data;
 
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u32 count, size;
 
 		if ((arrays & (1UL << i)) == 0)
 			continue;
 
-		desc  = bpil_array_desc + i;
 		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
 		size  = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
 		bpf_prog_info_set_offset_u32(&info_linear->info,
@@ -192,13 +189,12 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 
 	/* step 6: verify the data */
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u32 v1, v2;
 
 		if ((arrays & (1UL << i)) == 0)
 			continue;
 
-		desc = bpil_array_desc + i;
 		v1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
 		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
 						   desc->count_offset);
@@ -224,13 +220,12 @@ void bpil_addr_to_offs(struct perf_bpil *info_linear)
 	int i;
 
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u64 addr, offs;
 
 		if ((info_linear->arrays & (1UL << i)) == 0)
 			continue;
 
-		desc = bpil_array_desc + i;
 		addr = bpf_prog_info_read_offset_u64(&info_linear->info,
 						     desc->array_offset);
 		offs = addr - ptr_to_u64(info_linear->data);
@@ -244,13 +239,12 @@ void bpil_offs_to_addr(struct perf_bpil *info_linear)
 	int i;
 
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
-		struct bpil_array_desc *desc;
+		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u64 addr, offs;
 
 		if ((info_linear->arrays & (1UL << i)) == 0)
 			continue;
 
-		desc = bpil_array_desc + i;
 		offs = bpf_prog_info_read_offset_u64(&info_linear->info,
 						     desc->array_offset);
 		addr = offs + ptr_to_u64(info_linear->data);
-- 
2.51.0.355.g5224444f11-goog


