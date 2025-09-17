Return-Path: <linux-kernel+bounces-821596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE1B81B32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4141C001FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A713054EA;
	Wed, 17 Sep 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgUMSkOW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AF280CE5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139103; cv=none; b=El/T5fhiL7oy3FX4MvgJi7trvAWjb84dZkcQyTWy9hhy0E+MJyzB0BFarFqjLc73CqsyoRAx70DEWeNnR41wEQydCkIA9i9JA18NBS9YiJuJ2KbAHrRFDawOXqEH2aX4W+rf4WDHzaynSFhC5eSX3qIBsNQGGDBJuTPjxviAmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139103; c=relaxed/simple;
	bh=0lWzt9RO+8jsRK3poX0e6qyYY2f7EOwhvwqUc9lYhdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=avDgspfT9sg767QOpph+1KC6VzwjLXhHC9p4LmgT5deSazS10z3O3cpEbney3Kme+bt4dyk4+iQFVLjvn9YMNfJMJu+tPhwCAgYTZb4ysbQfdK8SOgtct10epclRWh565F0pRECwheJ2Op4ee8SLywMXrP85fWAytaFTAUceLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgUMSkOW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-72396ac948eso3004337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139101; x=1758743901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DHlI9Ihi3mnPuz7nsW2r0i9Vkc+j3chUUZTsmP0Lc=;
        b=EgUMSkOW4m0qQ4FP9uhV7svX09AA2YpwpyxdptZ3cGPie6aQAyryGp/8VXZzLQ7SNO
         yEVABSmKLl0Lm4306zpUAcNB/PM4qE77BG0LBK4DawJuYfLDu77qWB2iXCdtskN02+c6
         26nk7G3jzjSWRNBmvnstBE19rnnrNViB7s9xmCXPtESKpVLqVTkr3ncv+hzEjxWn88Ny
         b5Tq8jdCRHAi3TQpfbiB3AzMYsKLA/hkAAlyaBTu2lT6ExOuDdLHR0rJxJAAMXSWjY7X
         C1lD9Hi2cnHWUYT3kt0ZtCR0jM3AJO4rmt4OJYZJjKVuFryf8KJLOKsCMTQmzeM1Phxi
         hCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139101; x=1758743901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DHlI9Ihi3mnPuz7nsW2r0i9Vkc+j3chUUZTsmP0Lc=;
        b=KmFanX1b0yXUBsYW54Z6lXbX1n71BP4shNgeftSURqjqOX0NhVeNXA/jmC6ZnKCrOD
         S12rE4ZVry6Toui0KE5B7EQ5XS6rbDtjMhzaxNZZMYK057az66+HBLpsPB1kvJoohvpY
         /VGkQzy79z89fu3rYfviIwmUr7Y5GqPK6ita7P3qenxK0lNAYtjZ/sxeQW01Tl1Uy40X
         AhdstEGnRRUaA41xEPyyrBiCcQ8P7ecydOsX3gSw8xrsShMwLkc3M2k4s7vjx32t3vJD
         YFHDGtnpjwffTCb3mm4onAcciTbVSRWMVZtpZllI1uol6oURsylyYPNt0Lw8e/4CHu30
         vmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHO2jZiACuHoyvMQjqI/sCFkiBDscsg9y0LgU2gmahnzb6W7vc2je0cyupuvwtPesWuY3DzinI0Ylaor0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LnMKJ2KNWfEPwYKt8g/Ee3bkGFbqaOii8ikwC0AdpIQqRsWf
	0Ej4on4/mKhFGLkS6ipIuxPon1fyPF2IoPDEAdWVrtgiMzoQSPYjemkCim8sFR/4L5YQ4jqyYQd
	nNrfTJp81Rg==
X-Google-Smtp-Source: AGHT+IEwbYCWP2bNi/CnkWrXxccCC22yUDESZA7PFDkENPsFEF4nWCL7Y9MLRk9ACZV2PmfW8TTOgQwRgw6k
X-Received: from ywbbg13.prod.google.com ([2002:a05:690c:30d:b0:722:83d1:81db])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:d0b:b0:734:81fb:8ba0
 with SMTP id 00721157ae682-7389129df2fmr29782737b3.19.1758139101185; Wed, 17
 Sep 2025 12:58:21 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:07 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-10-zecheng@google.com>
Subject: [PATCH v3 09/10] perf annotate: Improve type comparison from
 different scopes
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
index 7e4c045d0f4d..51765bd36c47 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1622,7 +1622,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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
2.51.0.384.g4c02a37b29-goog


