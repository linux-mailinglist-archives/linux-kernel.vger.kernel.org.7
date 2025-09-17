Return-Path: <linux-kernel+bounces-821595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0784B81B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69319624566
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9F53019C2;
	Wed, 17 Sep 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w6kZ2psm"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D82FFF9D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139102; cv=none; b=OGj/n6Y0k6BmAN3tLt4JcsbnkB9WNvB9eJntRfvuz03fgbXZyrCX39G+4V/rqjz/G5827bRYjhrm2lMfn/R7k58L2bUvw1caw5QRpftbKrzM5aU+gWRPivO+CqO7qlzgPtgKtqq9piMEDJK1laKzcrYG8/yDze9JN07bBuDdl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139102; c=relaxed/simple;
	bh=YaCTe7tvAvbh0b1M/IwTP5q+eEGK9U/Dhs+HYoFfQOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ILkNrSHY0JgK2UGQf952gLiT1jaVFQ4dPptd6Iyr1Cqa+c9hJD0Nj7Sel3b6ctur0sAzAUQPgk7js9MJByAZemLbRq6WKFXmJYsTgEtekfqDc1USc+W3NquCUmJXmlNCYuwLq+3YuPZLeeVomY+temqMDT0JMeB6sY5zZDixjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w6kZ2psm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-729540b6278so2965997b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139100; x=1758743900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ff8iQk0FPzgWQVhFkOxEf6wop7fJ/8iqGcNpfT69dcA=;
        b=w6kZ2psmpYUAw9m6s+W3xXe4v95RQ0+PvdoB2XN+h+1B1uKgeDTuB8jVWZJBIiTP6l
         qStORZImJ+UAuBQDOCBN3n9Jb0BjjPAC1GfRtQ5dvQSig8nA0Ywp89QZp7izX/YzqGLH
         IPV2zKfe3UKgiVQ4buySR4sXBHUF5I8+OGj51NwhXN4gDloX5dDxQ/Vm5LHUlo6KFajV
         45pJQnWFB0KCIeIVjLZq+wMU4AtVYkU74uPeHn6TutkSpv8Z9nh316ZGlUkSo+kCnZYo
         0QB97TUCJwr3Wb6Sz2/giQiG1/5LQZ7WoqF2QWeJjeT2K1tZceWSebmkalSpHVggo68G
         RP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139100; x=1758743900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ff8iQk0FPzgWQVhFkOxEf6wop7fJ/8iqGcNpfT69dcA=;
        b=RKU1068kT4ugdy7PmzjrhbNaru1wawAH+CmNsOzop6VfM31lXz9je8WsAp4jT10WVm
         EroMva6efOxd8TLfghWtaB9ZVAaRd8O3VzJeeGagKCNTfcd4Yt4b7k63bgtSBnIzJjHb
         VI5+xScUHXX6LA8TEyI0LmkwhInDe5tSiY1tJdlQB+z1Y3/Ed3vQuL9kvT56BTn3FG1S
         YERJuq5xJaaN2keoenKHdZ1tHJAw1j2erNrC3tCODk5LyHfDwleXiKfOxVs1BZauvKk6
         2f68306/+G2EZ+nXgJOLqXvrgQbba0iEtFp6vk61qUXM4lcDAJZAeprByUwjvJnnGCER
         JhuA==
X-Forwarded-Encrypted: i=1; AJvYcCVb/hYKp3zm5XCXKo9nu9S1rswtAbuKEdQm5uj2X328WqiOq5ZiJZPgVFlaqXmD2iP8hBjCtsuuelf9+3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNrl5dI1k+MYSVX4C2Y7xxFVL1RcgWk6aMDFcxE6B54YwOqWb
	QJ6ltxxBle/1wyqo5iafPPnrM2mihaRwggofujFo9CGnBhJZItA2/svbjO9ufbe2PPDEQgnsOSg
	gQ7vhmTIPLA==
X-Google-Smtp-Source: AGHT+IFCBl5FOhbjQY+swMvC9WLhg4anbTbvjABfmmdmioCSc+TNQepIhR3e/bBE3JHsnu8q/HRpmofN+Z6u
X-Received: from ybbby7.prod.google.com ([2002:a05:6902:1707:b0:ea4:791:2410])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:5408:b0:e97:b52:a814
 with SMTP id 3f1490d57ef6-ea5c044dd64mr3348542276.34.1758139100119; Wed, 17
 Sep 2025 12:58:20 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:06 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-9-zecheng@google.com>
Subject: [PATCH v3 08/10] perf dwarf-aux: Preserve typedefs in match_var_offset
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Since we are skipping the check_variable, we need to preserve typedefs
in match_var_offset to match the results by __die_get_real_type. Also
move the (offset == 0) branch after the is_pointer check to ensure the
correct type is used, fixing cases where an incorrect pointer type was
chosen when the access offset was 0.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b57cdc8860f0..b2189de07daf 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1395,24 +1395,24 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	Dwarf_Word size;
 	s64 offset = addr_offset - addr_type;
 
-	if (offset == 0) {
-		/* Update offset relative to the start of the variable */
-		data->offset = 0;
-		return true;
-	}
-
 	if (offset < 0)
 		return false;
 
-	if (die_get_real_type(die_mem, &data->type) == NULL)
+	if (__die_get_real_type(die_mem, &data->type) == NULL)
 		return false;
 
 	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
 		/* Get the target type of the pointer */
-		if (die_get_real_type(&data->type, &data->type) == NULL)
+		if (__die_get_real_type(&data->type, &data->type) == NULL)
 			return false;
 	}
 
+	if (offset == 0) {
+		/* Update offset relative to the start of the variable */
+		data->offset = 0;
+		return true;
+	}
+
 	if (dwarf_aggregate_size(&data->type, &size) < 0)
 		return false;
 
-- 
2.51.0.384.g4c02a37b29-goog


