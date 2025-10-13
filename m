Return-Path: <linux-kernel+bounces-851166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E79BD5AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6AF420CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49862D8DA3;
	Mon, 13 Oct 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CK+DZNfS"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4202D77F1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379389; cv=none; b=jgv1iKSUhdjJ6QLuO4OBXwGON+P+7TvCY9nY1zSxapr0T78N5EeO37a7xNq0kWqG0uRO3h6fnChzvAWqS+Lo67AhtcKQ3szV28vU3bhvnhQ9gb43QXYE9R4p/70cwWOvOsoCOUFcIr8WL17Z7pwz5rk7fonxsJhLSmDY7Yr+4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379389; c=relaxed/simple;
	bh=3BrbxhGE4yqjfkMIrwpUID8JM2NrZJ3o8ooF589Xsjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cX7HeI8cztxMX/Zet+ZFKKbqp/CLHQ3pwaV2Sq5udNFUoSMuXGtFjWQJs+GFIyjzZBkWhwcItZH0nMMo+NAy0/mdXO2+1yDTlqFLQgMfVjWn9E846bQMUDn1Vkkm68YVOLQM9RlmRD5XciTTXNfVInwbDHjMSlm4Ysq8ljF0UNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CK+DZNfS; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-87ae13cc97cso2718344785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379386; x=1760984186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKOoHqMAU4k1gwIwyn/I5QYGpjwICe+6Dwq5OwyxdxA=;
        b=CK+DZNfSZVyu6Ohnb8WjbASIux5ClzkoIvA9BXrQpMv5qe6v3nW4fTXG8F9az0XMWI
         fzayDqYNZ/1ctAmrt596lPGQLV86Jlkf+Z9qWTFirEeZyU8L9VySSRRpwGvZIiQ3SG+y
         HTM7CiGA9s0nrgsIeXCTWxz0A8ND0Dmt+eL/12RSicEZtfLoQSwrm7HPAI/cCOh4/ESl
         T59b4WCFMsh7jWrDm7UiK1o1uaCyKVLpne0m6w3P8TQCzMjB8c8NEwWmugI0Me1BmlSR
         Odxcd0VjXXulQgIJ7O5s6xbBfGo6WLHSiBL4w4lrbXHqXpAPPvT7BVk+TvPaLQfLKEgf
         U5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379386; x=1760984186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKOoHqMAU4k1gwIwyn/I5QYGpjwICe+6Dwq5OwyxdxA=;
        b=CdeIgCVp2K53QGREwnJ80WWtmhb0duBaqtfDN0qclwmqMBCnjJxiwPxRbEs4dAnchE
         3laRp70ohU2n8fsGaBWtrKGnzMXtVdMfnzCm2w5M3NhtU1QPIkcTz8ac8pN5kTc6rPDH
         h+pR4xzfF6IgXwSCSGQID8A5Q5KZp8SsfeTJdslDncPnYUwJrFLMc7zaPoe6Sl77mdlX
         nu6tEpBYKvaqFlR9wyF+nyieqg/cOBpPC7d5cpO7WZQT9gaZqtiKHi2YHkw21IaZnls5
         W4NN/d2vftRxoO5I2e+P9x6nuGp6sGhENXsJqMd3JQajSJL9jDdP2cBgci3AJWhLA77J
         I0BA==
X-Forwarded-Encrypted: i=1; AJvYcCVy8urcXwpoRMaL8jJCFVm6L/DCIW2RJxp/ypwz/kOWYUUpYVGYA+4bVQYfUSRoB9up8sDwU6eOw82p+iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpihhK/zgNJsN3cINf9hRbSCTXtM1zyPx7G7OSHUwGoIEf0Gkj
	U0WjpG6QUJ6YiVX+hfwuoaVEyfQPjvl4BellTwxXqZ2tAqwtlRARjyGwprHBsiHjMHdlEIvbwKJ
	yL7+YJ9lN4A==
X-Google-Smtp-Source: AGHT+IFtj5TmlV8iuUhz1jUNMXRrn+Em++O/km8PRo7zhXilShSzUHGovoDLR+AuQa9habqMXi0sBvR21TrE
X-Received: from qknsw10.prod.google.com ([2002:a05:620a:4bca:b0:865:eaed:1168])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1917:b0:7e3:397c:8c24
 with SMTP id af79cd13be357-883521dc1a0mr2886568285a.48.1760379385985; Mon, 13
 Oct 2025 11:16:25 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:16:05 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-9-zecheng@google.com>
Subject: [PATCH v4 8/9] perf annotate: Improve type comparison from different scopes
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

When comparing types from different scopes, first compare their type
offsets. A larger offset means the field belongs to an outer
(enclosing) struct. This helps resolve cases where a pointer is found
in an inner scope, but a struct containing that pointer exists in an
outer scope. Previously, is_better_type would prefer the pointer type,
but the struct type is actually more complete and should be chosen.

Prefer types from outer scopes when is_better_type cannot determine
a better type. This sometimes helps pick a more complete type.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate-data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4b08331b9dd3..4b510eb29a5f 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1629,7 +1629,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 				pr_debug_dtp("type_offset=%#x\n", type_offset);
 			}
 
-			if (!found || is_better_type(type_die, &mem_die)) {
+			if (!found || dloc->type_offset < type_offset ||
+				(dloc->type_offset == type_offset &&
+				 !is_better_type(&mem_die, type_die))) {
 				*type_die = mem_die;
 				dloc->type_offset = type_offset;
 				found = true;
-- 
2.51.0.788.g6d19910ace-goog


