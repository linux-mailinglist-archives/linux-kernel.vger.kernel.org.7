Return-Path: <linux-kernel+bounces-780309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA9B3004B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A2A5A4DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C82E06E4;
	Thu, 21 Aug 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLH6AIb8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52012E03E8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794312; cv=none; b=FTGR4C04NYjbrRE/L74UJZyKEH7Zz+rKdEE5HtlI6ubehoV80mn1cWByg+DSisYp29x+NWophVAOjRhgAjWYKWyyqKPDfkA0CzmTnsGnwg5YH38G8LVRsyrnliEYh7G+GdFprHlwOlsnWAaWux1CrparMWEOkYJFW+L+Kcjb+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794312; c=relaxed/simple;
	bh=8n1sV62Nfazy06tMYoFP1zPSTaaez+AvZXx0FOsaOao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rnOdnGy1FIQFqEBKpekrDFJrmZvsVBbNygzkBJkm+JcZzFCERmqgyOePRI3htqw7mc9v3u8Y5yvdan57tI2XWqVKVFNXNUWcAM2J9zixTqRFngxdVu8wi379zxnIXsm2fwWxdXp+QZ+GNCR0Sv/r0m+pLZKoUw+n9GaPdgaB2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLH6AIb8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324f2d61681so1100255a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794310; x=1756399110; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUbXtlHAwgGqqJx9+B1gHsCORD+CThrnBxlTMp4vr6o=;
        b=MLH6AIb8TBJAtYXywWGfcAhiNB0/0JPrFpbFlvXpXtc4z1OPaaWjTcUl+wKTs+ADh4
         FaLq4POAYL7oh2RHHoUHwFaAgwQXvrQSNMIfpCPqxJ6+ThOKGfthY0Mwk+t7x6rwxWY6
         0DfmmRAm9OuYG6zjxySTzfddLllUe56KNpGqmZL1vcAQfBhGQaB7I1vfRq46mMKGFp3j
         JqNlLwdtTwOvzdD7G9EXAvzO58kkP6FEEBd8yph3Vj6ZQnuuiu+TMGfsAzgvpxavHOge
         esnEkCTXieqFcdYHA5cg4VAHFETvcbwotNdl6c20Iz3Bo34h7QUEGcNozFr6gnPsPKNr
         Xamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794310; x=1756399110;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUbXtlHAwgGqqJx9+B1gHsCORD+CThrnBxlTMp4vr6o=;
        b=oUza46Uvl8qT59VFezaxdWieYNbg42YL4uNvpuCAD4QXeokDaw4lxtW/XNA6KVH7r4
         V9yoeIdt0mhbcUskA7mMKw1lIIbXPb+o0Q8d++UJZcGwnpmcgumh0pS+hKJiChXYonUS
         K2WYwIY0YUw9lzOvJ5YjWrkq5rdFykqfjqEbTLOrFq2UJ+OYXG0MHzV1mS6tkkB9Q/LN
         mwkbYgXDe4cX5je+0wbEhKIdJAqG786UVQUdKuad42FlEE45sWdxikzj6wDgkHI9DxUd
         VVcMXglYXQzYv34IJmcd6Q/iHvl8+XzpbuK1gykZeBIbUjduUEx1safYq1fpu8vA8ohK
         NZlw==
X-Forwarded-Encrypted: i=1; AJvYcCUxvHXvdwC4+CkVb4GIR72EAhAxfGEGqFURF0wG/6CZCX96MpKQqHCXvewYxtnbCWS0kXskneTI6V/oa+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wtioVbEOhB1SWfowVr+z7ZvX/p9spYo78s1sQK2qQCJYwV6a
	aIce/j6MfTUcw1WG0IiK/ztHCAmdj+8E69Ce83KNZWzYCRw7LfeRp1LzWMnThHx2Jtu5ymhPyTb
	fNh89s2x8JQ==
X-Google-Smtp-Source: AGHT+IFC0FPH58EcxYNCNsDlbFVM2eQ7zXRysU3PWwwtUJGNFehDhJ+ieRWR9RCSFQjUoENWksgGJ4sctYWc
X-Received: from pjvb16.prod.google.com ([2002:a17:90a:d890:b0:31e:c1fb:dbb2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2644:b0:31f:335d:3424
 with SMTP id 98e67ed59e1d1-32517c23cfcmr166650a91.27.1755794310098; Thu, 21
 Aug 2025 09:38:30 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:15 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-2-irogers@google.com>
Subject: [PATCH v2 1/5] perf disasm: Avoid undefined behavior in incrementing NULL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Incrementing NULL is undefined behavior and triggers ubsan during the
perf annotate test. Split a compound statement over two lines to avoid
this.

Fixes: 98f69a573c66 ("perf annotate: Split out util/disasm.c")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index b1e4919d016f..e257bd918c89 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -390,13 +390,16 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * skip over possible up to 2 operands to get to address, e.g.:
 	 * tbnz	 w0, #26, ffff0000083cd190 <security_file_permission+0xd0>
 	 */
-	if (c++ != NULL) {
+	if (c != NULL) {
+		c++;
 		ops->target.addr = strtoull(c, NULL, 16);
 		if (!ops->target.addr) {
 			c = strchr(c, ',');
 			c = validate_comma(c, ops);
-			if (c++ != NULL)
+			if (c != NULL) {
+				c++;
 				ops->target.addr = strtoull(c, NULL, 16);
+			}
 		}
 	} else {
 		ops->target.addr = strtoull(ops->raw, NULL, 16);
-- 
2.51.0.rc1.193.gad69d77794-goog


