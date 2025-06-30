Return-Path: <linux-kernel+bounces-709915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77A5AEE4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AB63A60B5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3391145FE0;
	Mon, 30 Jun 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CH13z90B"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F0292B4A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301075; cv=none; b=YxIQjwJqq8V4knDNf5H3lbaUXIq+zKfadVYgdJ/UTzrMxMF7JczyjIYpwT91+Gb1IjDHnDjBewnmtBubPZvFuw2YHJQThaGXnYY+aU40rY65Ajf5NyFvTqC/Izn0/m+rJ0Slvuqz4qIGIE5vAZHWd1m8srBVUIm4G2Pci0fpg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301075; c=relaxed/simple;
	bh=Doa9cB8eDyI5Z1xrxS2AczpQfc902XifIn+r2jsrcp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tsyzvqxOwHpnFx3ZSO5NvCa6LL9kn8SlPJeJMNtYXN4J8UdRCFsd9kh6pDcnlcirVjT0v9xc7Q4RhmUWlZgPY/cyqhqj7sLuEq4LFdtrGJWn5gInG/W5oDlMpTpMlIoNuX7Rz+JtSrDCSGsuaRwib/bBgRor+wVn2acHCChJPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CH13z90B; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ae13e99d6so4041553b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301072; x=1751905872; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snyXUejcURnc08xpT6+/Ar5yIZrrqidtJh57u5G4u0E=;
        b=CH13z90BMNYUr+EoJzdwGphzvtXnZ1NBuAZscNfALxE1Mmq+WwkdT0odUpaOI6arEJ
         pgQENJP7ocjSBzgoxOHbUfarpxpyakIrfmQ//nXcNOfivaCuClrONhrH+TLgzeHmMxQW
         Yd0sNqdwwHWa30W6wMKJI1Q7uARXEuYKBwQaMQf+bdORCkv1FCLnJxVnQC8QzEw45GA5
         VIHsY8xjgIVBSzqOboqY3LakgU2IERzLRlsEBw/zO1zJX2+AtvGwYi2qvum5+xZ3IGas
         c6ku5xpCxDFtBQ7Qa+4SjY2Rt8KJwCfh4zM3fV4VrpubvrNBhM6lEHMfn4oaduI5axJX
         fcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301072; x=1751905872;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snyXUejcURnc08xpT6+/Ar5yIZrrqidtJh57u5G4u0E=;
        b=IK8/ssIU4aseAGPpbx2Fhyh5NMBhALW0luNfEZRH+9OhY2FuOeU7n/aMUrdUCIav1O
         6LmTVVxIk5JFvDWr3t/aSSzCZCIBN9ewfU9E36YsoQIe6Jpo+SuRkZ8Srrdv1BK6xRbE
         jYrNciTfpTm7iIYl2nYklE0JK9NSdIbD8jpQU/AwlfkRsiwRduZFDEpCjzxvtUsRFeCs
         R5TyR1yuv61rBqX6kHFxQNJdzD/ez4Uy9qs+E7zVlxVzfBJFFGaMM5hyfaut6M4Z3b45
         K0JTgFDfv66jYpXl8PauiSJUrkKSrMfqE0iuSmvIce47o5kJ52JrtU4ZFl/PYTseLAwh
         SF9g==
X-Forwarded-Encrypted: i=1; AJvYcCW0ajpE6refU5OWa1r6ynaB1Z/Zi+T9H7pWgFVqU5vc5/BMgSRnNjq/6nzOD2fMzRgHDN0xybVu86AHHSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWLoiJA8ftnh4C/niyUsKXhwYuCoCxUkct7cTQU+X9RP3/cD0
	/l9A0FEu1WQ2UsBSS5sJOoj1dlknL6MbiaPlblW6P3JKPRSoDkD3HgDreogNhSjVtTSCpiKk14d
	3a+SVayUR3A==
X-Google-Smtp-Source: AGHT+IFQNxKXrJQzVCW9oR3JUAP0kidJ+nKwqeIrS71VvovYT9ZZT1i5Bsg2RSFE1Ay121YKDuKZgXb6fpRo
X-Received: from pgww9-n2.prod.google.com ([2002:a05:6a02:2c89:20b0:b31:c7e5:6665])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3942:b0:21f:4027:b9ed
 with SMTP id adf61e73a8af0-222c9916bfcmr324459637.1.1751301072535; Mon, 30
 Jun 2025 09:31:12 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:49 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-5-irogers@google.com>
Subject: [PATCH v2 04/15] perf vendor events: Update CascadelakeX events
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.23 to v1.25.

Bring in the event updates v1.25:
https://github.com/intel/perfmon/commit/86f146e15626b0fd3b032cab4538cafaaf2=
d0635
https://github.com/intel/perfmon/commit/fef03ffc333ae44d1e9d695b4e67e5bbb44=
29729

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/cascadelakex/floating-point.json    | 6 +++---
 tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json   | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
index 1c709983b65f..3ef6f00f1135 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
@@ -111,7 +111,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xCF",
         "EventName": "FP_ARITH_INST_RETIRED2.128BIT_PACKED_BF16",
-        "PublicDescription": "Counts once for each Intel AVX-512 computati=
onal 512-bit packed BFloat16 floating-point instruction retired. Applies to=
 the ZMM based VDPBF16PS instruction.  Each count represents 64 computation=
 operations. This event is only supported on products formerly named Cooper=
 Lake and is not supported on products formerly named Cascade Lake.",
+        "PublicDescription": "Counts once for each Intel AVX-512 computati=
onal 128-bit packed BFloat16 floating-point instruction retired. Applies to=
 the XMM based VDPBF16PS instruction. Each count represents 16 computation =
operations. This event is only supported on products formerly named Cooper =
Lake and is not supported on products formerly named Cascade Lake.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -120,7 +120,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xCF",
         "EventName": "FP_ARITH_INST_RETIRED2.256BIT_PACKED_BF16",
-        "PublicDescription": "Counts once for each Intel AVX-512 computati=
onal 128-bit packed BFloat16 floating-point instruction retired. Applies to=
 the XMM based VDPBF16PS instruction. Each count represents 16 computation =
operations. This event is only supported on products formerly named Cooper =
Lake and is not supported on products formerly named Cascade Lake.",
+        "PublicDescription": "Counts once for each Intel AVX-512 computati=
onal 256-bit packed BFloat16 floating-point instruction retired. Applies to=
 the YMM based VDPBF16PS instruction.  Each count represents 32 computation=
 operations. This event is only supported on products formerly named Cooper=
 Lake and is not supported on products formerly named Cascade Lake.",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -129,7 +129,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xCF",
         "EventName": "FP_ARITH_INST_RETIRED2.512BIT_PACKED_BF16",
-        "PublicDescription": "Counts once for each Intel AVX-512 computati=
onal 256-bit packed BFloat16 floating-point instruction retired. Applies to=
 the YMM based VDPBF16PS instruction.  Each count represents 32 computation=
 operations. This event is only supported on products formerly named Cooper=
 Lake and is not supported on products formerly named Cascade Lake.",
+        "PublicDescription": "Counts once for each Intel AVX-512 computati=
onal 512-bit packed BFloat16 floating-point instruction retired. Applies to=
 the ZMM based VDPBF16PS instruction.  Each count represents 64 computation=
 operations. This event is only supported on products formerly named Cooper=
 Lake and is not supported on products formerly named Cascade Lake.",
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
index 3dd296ab4d78..9a1349527b66 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
@@ -542,7 +542,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.SW_PF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index b2db2bb658ce..9a60e95a2e15 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -6,7 +6,7 @@ GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
 GenuineIntel-6-4F,v23,broadwellx,core
-GenuineIntel-6-55-[56789ABCDEF],v1.23,cascadelakex,core
+GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.00,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.11,emeraldrapids,core
--=20
2.50.0.727.gbf7dc18ff4-goog


