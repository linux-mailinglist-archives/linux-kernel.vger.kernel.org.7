Return-Path: <linux-kernel+bounces-851165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1238BD5AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBB434F1C58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320182D7DF9;
	Mon, 13 Oct 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9PW0g43"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42A2D6E6A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379387; cv=none; b=I1F3/Xgr3YfBeS9z5ucGaWaW5FvXzOd0eA1w2qaNBMv0jJkNmCYhj165S2cgoMGawYVfHLOdSmVIZHvtZBAjrp/mTz4yvopd1hmbuxWO/55xWUJ5VPSZXihq6Des33vNK0FH454BoPbFf3Q3KdPauiaKTyMnZk5qKIQYX2gLyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379387; c=relaxed/simple;
	bh=ryWqvrtpoI8zwr5POQ8nx6hMsPTafW2LqQ4qX80CymM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vD9aijmMD3eMvX5eAzLZadh9oqzTwTHpGxYTqOKCwaNZsVpqjKiAaJ36vj0jpkiv+x1MsFYB/3BEWX+9GMwDkCFSVXn0ZyG82xh0TVAYqxneqeP+7af7+RyMIZaAJG6hjP2QXLt6ldxxhwmvkI3PV3RDDHEdWJNVfdh2VuGVk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9PW0g43; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-780e7b8460bso85976347b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379385; x=1760984185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yerxi3Sb9FrMPViGFoPF1bYtDZcJCUN3klWtfA5sPKw=;
        b=R9PW0g43JZMZ+xBgP8SAhO6/q7BCmfVHmm2zmaJFufE4drusqbWHA6DCyU8EyQn/ks
         t6+jvqnOMZBaEJbnIOU0c7LKEOEKeX2k6OXzAaoJI9nwOs74D8huIJQfWAJGU9/mbahS
         Y+UIGyVs1r9NYxgVXKTgWTPx6GjM4edRPDTs8d9yXxAZMKyAm2+dnS+jHDJjcWSuZPS3
         E2duimmRUR6lUJVcfSPlzUKgVRL8wfpC9xoqUAB8t9AwODIxTuEMHWRDNLjri1AIPWxb
         hEXsCtdfE4U9sLSl5t64+lvYMKz45UMAwLk53tSKqjzguA3uIJ47Glb1bwENQ8QE4TjC
         eOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379385; x=1760984185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yerxi3Sb9FrMPViGFoPF1bYtDZcJCUN3klWtfA5sPKw=;
        b=XWi62zmuxmMxNgnbY1KoHWoUI1ZpEIhGpERylAOVIwpCVPyk9tIjnQHJSfkQL82K5c
         B+pV0tBNDg+fzdq38GmzlmRyXIprDNHw/TiDy8CSTjbUC51V6C4MmlixOIzu+i2Jfinl
         hYQnMTkyc/SZZA4NHBRJQLxBXJsiUcjRdyfqbpOK05tDK83y5FKX+Q8ZdzY+Qkxn65Rc
         UDizuAtVJadtRN2MZyNJMWSpzZd9eg8TDTsLGYhrDc1Dnv441SwU3RK2n0lJq5+sBLtW
         G5PmQRjTyyovmHA+U3DR1+0ud287Fvqtv2eVTQgQ1vpoqA1YWWZmVj6YoIKXgIFn3FUa
         8tmw==
X-Forwarded-Encrypted: i=1; AJvYcCXJkhvh/bHH48CPpZEA/vqY9A6bk0lY30XeXZnKucSrrXmuZZ2JhuFPy04vrZuAclLVlECbBkfytI5Izs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmjbRAhcMrBMMcmb8lOFV15cpK3OUmPVDF2WnIVkrtpddGNca0
	tmAO6dUuVBc0rIGRU99raOMJaGaThfnsKTV7Hdd9FPLQgkxhKgkl67TAycQbi1snKFJbGcqixu3
	xvZgB/CUHPQ==
X-Google-Smtp-Source: AGHT+IH8wNTHsKtdr+Ws5rHHvJKzhFXtFqipPxtDdHXZpOw0LksXCSiXUW1mP4kDR0TY9JA/NdxF8VkMUyOx
X-Received: from ybbdf8.prod.google.com ([2002:a05:6902:e08:b0:eb8:89e0:b8a8])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a53:ef11:0:b0:63c:bebc:5e67
 with SMTP id 956f58d0204a3-63ccb8d834amr16628011d50.33.1760379384861; Mon, 13
 Oct 2025 11:16:24 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:16:04 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-8-zecheng@google.com>
Subject: [PATCH v4 7/9] perf dwarf-aux: Preserve typedefs in match_var_offset
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
2.51.0.788.g6d19910ace-goog


