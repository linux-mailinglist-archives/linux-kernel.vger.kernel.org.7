Return-Path: <linux-kernel+bounces-785468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E42B34B30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B913E7B41FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B042882BE;
	Mon, 25 Aug 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEMSaSgQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A1287516
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151664; cv=none; b=mrAw9SqTehqwWfAdj16OBkm90z+I6XfCbk0FWFAZ0CwVmbSi32uCDQnr7YP4YopZwlvPOPaVeg2Rluo5pXEatQJ6vsWUULwyF2nAHV9PCMFrmtVrMFU3Sb5nM33FHv/DSdxVv8maJq0JqQdwrA+Zu1PDNX05gYYR7sfF6kBiZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151664; c=relaxed/simple;
	bh=0hlHTRP1yVsFXOFJ9v7fqEQ/OHU/6+5iPoegs4eQJR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VeCvi6TlyM68IlUO0ufvDG42Ms289yvgwDTyNJ5d+6KNybySOOJ3pJ/+/Q1fGirhkOYY5UyjdhkHeHZ+3AMal/D2ZuVsuaOPWieVSSO8xGoJ8honJi5eqyfz6MviARIaf4nVWxVUg8zywny5xz/+tnB2nmQht6CUiafH2ua3VmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEMSaSgQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e950f1d3da5so6236384276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151662; x=1756756462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj3ECBFIkXwltOmsxtndB3bFhJdncz9FtgQQsX8vKck=;
        b=nEMSaSgQYNsg7I+sJwW6bImFotJE+7XVthk1JtGfAqZkvc7mqJqaU6ZQZd9kWsk36+
         Gzmw6AvnCGz+LZawyV3HEvZnTw5nXsm/B/bqROhTlGGp5ZyGFTkmG3a4Kg6z+eubgRiP
         cibqwUs/08o6TZfbFHr/ucsPjPaf1l+3X7Tco6Bjp/jWy5J4YSwpeDgxhrLx+ptt5Q03
         8XCbWbFtGO7bu+3Jg0RALUjPcLM9MoSeUtNgubjIN/6+l9nH0WTiUwklDoLXvvyv66XD
         w5WA2HkdUzu9NRqxSM02QQVnB7i/fh2OGtgU0n/Qwq2T8wPSSDtkTMW8gfaVRj7S1ygt
         bAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151662; x=1756756462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj3ECBFIkXwltOmsxtndB3bFhJdncz9FtgQQsX8vKck=;
        b=GqUQtVbV2LF3nyuRDPP22LwRp7YqkEicJpLKvO8j+IDg9IwsRb4/LxXxeE4T7SlwKU
         +9Vsf9LYspk11Yn6kG3yzJGi0d+aOw+tn303fcIkgnZnoblBV043cTWJG/leWAzvusH5
         xFrXhTGcB5g6vnhAl85xlcenGyeeiIVoi3ApYmUwjD5rsijIjlYY0pneAkgbHLk8HgPi
         jWWNYBXJI5cgla2J+bLvh+n6eqbUkWQAPfYT7iEayhx8VFa1dV2riJvO/Y8ivBMH826R
         XtrN49Wsc/sIdOy+MKTmV2dHaoLhvjTZQMh+uxNjcx9pLU/mxFNWmKHVSCxri9+MAvtg
         64dg==
X-Forwarded-Encrypted: i=1; AJvYcCWc5RoT9ZrXMlIWSArv17AKu86dbZ6eou06KVCMYSiKdvLEQ15zVncyiEeR3U0pvubiba7Ifrq01QUOuMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1trdwhZ22LdwtRDlsmUcd6JgiUGqUQcQ6RU0XwvGKIcucQVv
	nadFtYJRIMI44wDQ6DKl8pUR8Ht3P1D0ucK/fWmDUGn1noaEm022XO5JRLz5xAOgtW6elOzXKdE
	g2f/6iMA7Lw==
X-Google-Smtp-Source: AGHT+IEQ4x08m51q3f4ROW1dfPnwzpdZaP43CoBKHPlNIyWix7VHWuwLfgDemBS55AdCXnYoagdO17MPXuUa
X-Received: from ybep18.prod.google.com ([2002:a25:f452:0:b0:e95:1a0b:9140])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:c11:b0:e95:1c68:7d08
 with SMTP id 3f1490d57ef6-e951c68836bmr12498205276.17.1756151661718; Mon, 25
 Aug 2025 12:54:21 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:54:03 +0000
In-Reply-To: <20250825195412.223077-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825195412.223077-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195412.223077-2-zecheng@google.com>
Subject: [PATCH v2 01/10] perf dwarf-aux: Use signed variable types in match_var_offset
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

match_var_offset compares address offsets to determine if an access
falls within a variable's bounds. The offsets involved for those
relative to base registers from DW_OP_breg can be negative.

The current implementation uses unsigned types (u64) for these offsets,
which rejects almost all negative values.

Change the signature of match_var_offset to use signed types (s64). This
ensures correct behavior when addr_offset or addr_type are negative.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 559c953ca172..920054425578 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1388,18 +1388,19 @@ struct find_var_data {
 #define DWARF_OP_DIRECT_REGS  32
 
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
-			     u64 addr_offset, u64 addr_type, bool is_pointer)
+			     s64 addr_offset, s64 addr_type, bool is_pointer)
 {
 	Dwarf_Die type_die;
 	Dwarf_Word size;
+	s64 offset = addr_offset - addr_type;
 
-	if (addr_offset == addr_type) {
+	if (offset == 0) {
 		/* Update offset relative to the start of the variable */
 		data->offset = 0;
 		return true;
 	}
 
-	if (addr_offset < addr_type)
+	if (offset < 0)
 		return false;
 
 	if (die_get_real_type(die_mem, &type_die) == NULL)
@@ -1414,11 +1415,11 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	if (dwarf_aggregate_size(&type_die, &size) < 0)
 		return false;
 
-	if (addr_offset >= addr_type + size)
+	if ((u64)offset >= size)
 		return false;
 
 	/* Update offset relative to the start of the variable */
-	data->offset = addr_offset - addr_type;
+	data->offset = offset;
 	return true;
 }
 
-- 
2.51.0.261.g7ce5a0a67e-goog


