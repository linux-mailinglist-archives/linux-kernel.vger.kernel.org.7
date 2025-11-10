Return-Path: <linux-kernel+bounces-893691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C54C48113
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C21234A4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D0329C78;
	Mon, 10 Nov 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy3MEheO"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BD32936C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792725; cv=none; b=A+4NYevjgbOMd9GA/6bByX44UFi9s11ObSUUs2Y1TOEBzMzuX9l0geEt4huxHRzN+91PuljSemn/AEHsTAeatTmcYMvqxS5OSkgfU5CDs03JIfK+NxskRVn4ThqtcFTbrbdcB1dKz/o6PbBo1hOe0NeOOk3fROPNXJi6/blm7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792725; c=relaxed/simple;
	bh=a5MAKHVYkyHwEXpHGaXuZpG+FT9ZL54Tfmjo5gUuPh8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/jij/2rBw/IqoPdLNH8VcrfNiymfU8DO2LTSCMTscMDArfn+MlPb3bjCyyWEe4EOiUhSlYdDn0TqauYZFQ9tDbT8fY5VMDhDdhqVQIwJVuSWIrCKdHsV9Ip4afKpv/ABNIlZqwscyJYyYnq4A3YFSsln/1O2IWfpdQjxLqKafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy3MEheO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso1825756a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792723; x=1763397523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UfdW5vQJBbw1wKbWsFdhhHcBKlPZrTKHywEKgKhNPc=;
        b=Oy3MEheO9RTVhtTIaZWJXn3lRH+6NC7xhwUKY1ik8GI7W8XfFF8fak/KmZVLqju6jd
         SVqxWM+rUUXOZlL72NaiJf7/W8KapXUzrCXzA8abISx2fIg1DWVGRXNUwOE4eluoeps7
         wfLdbRMtJ8DeAK6IRiJ608OZm/ssAjBv0qrh68iiPs8v0Wv8QrRuunMNC74jtZIrtFEx
         4JATCNcjHzcoaBFI2l50da8J6nHfplay/nygY+tOADL/20jRfx0RjnIq/1aqLAdIz7g2
         bTas8FhLA/N1wm5RQFhCt5LteVdTAC7h4hpIQ9fCDg/YWwPIYoe4uS6EchdhkWpM1nOY
         nlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792723; x=1763397523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3UfdW5vQJBbw1wKbWsFdhhHcBKlPZrTKHywEKgKhNPc=;
        b=nT+1mdY01foUL6HxaoHvlGIB4XohC4ah78OS5BZzRqM2kYHxizwjJQLhABp6MAgQ+/
         XhwF5LmlY7DcZ5knzhF+Nsg86Qrc5IwSsXfXHC6TvaNiNnPia5WjFB3zbFcBBKQdx/jS
         Q+kPftMbnfoIdvD/9k5IE6/GcrlZjaFJaQzj1Awl7s0Oiwzu9/JRsQMSMYbeMBWJ23Ir
         WmMkCTJB88LnfZhgAb2SZUwqXm6fbskuycbaQgwbjsB+KlQxLNMb840nV9E5B7o82auF
         /uSfq7Yv81AEOK+TvAzLbEDk4xnYk5ZdmyKwHAmu8F+WXwJl8Noof2HqEYaE/gFbghN/
         9eIA==
X-Forwarded-Encrypted: i=1; AJvYcCUaP8Aa3vp0uT5Ps0IfMbXA9DE0L/rchtO5tLSISazEgsRJwO7HmrMD+KZQIcJcO6wUfTGfZNzA0MG2/CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XQZr8ppOCVlU5mYV+pdLVSfCf03LTIkaXXp781mZ9wQYLrf3
	njee5bdmVZZDudqMVm9H60gouZ54GEiamXVR6NQJHNaDoEaFeqngLkoX
X-Gm-Gg: ASbGncszJQ2iGUccGS3VcCXgDstuNhemkO/And7yexUXnQLN4EI4Nzt+B7tOsLislpu
	s5O4oUDfD4zKRDDYeohTmUsrSzywrgzZarxeKdwhgltFEhRyVDFOb6YgB/kBK25iuP9S+kBcGcz
	6JpND8R7dY0MRhV4gan4FZAQgXPix5MNZCnmk7D97VDYYTqC9MOYBHVFu1YYaN+OfWSoyejNYJa
	ZqLN32BJbWhOiOjcOGhW1u0jDaFTwMYzUm4i4IMYGEHFtmQbXSJxratlAufdITVcxlBVrGJ+Ctw
	/ZC7cZUju++gGFvsU/bP8M5tBg6Y1X7ZfZuQAQD4CBnu3d9In0NadU0gwYXZdpuUYQitB2TL1e1
	8HY7vbPT3SZMo8j/5I48pl3vdoic9eEdu7BS9nitg1WlCCCO1M+pSjIlEgMdjljiuWVDxwshrnR
	jOaLUTmGlAdPv7IOTndGa/Fg==
X-Google-Smtp-Source: AGHT+IFEhL+ivOL3mJYmk2GKHVq/7v95YCugColCvVCwbEtQDJoAIyDrMPXTzpn3mUDrpnLozW3jrA==
X-Received: by 2002:a17:90b:42:b0:340:7b2e:64cc with SMTP id 98e67ed59e1d1-3436cb91daamr9486479a91.15.1762792722638;
        Mon, 10 Nov 2025 08:38:42 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c963613esm12684061b3a.1.2025.11.10.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:42 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 27/27] MAINTAINERS: add entry for KStackWatch
Date: Tue, 11 Nov 2025 00:36:22 +0800
Message-ID: <20251110163634.3686676-28-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a maintainer entry for Kernel Stack Watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..9757775de515 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13615,6 +13615,15 @@ F:	Documentation/filesystems/smb/ksmbd.rst
 F:	fs/smb/common/
 F:	fs/smb/server/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	include/linux/kstackwatch.h
+F:	include/linux/kstackwatch_types.h
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendan.higgins@linux.dev>
 M:	David Gow <davidgow@google.com>
-- 
2.43.0


