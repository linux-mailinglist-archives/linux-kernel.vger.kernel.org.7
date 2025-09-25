Return-Path: <linux-kernel+bounces-832960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91637BA0D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A94B4A11E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC9313284;
	Thu, 25 Sep 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVPi5OGA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAA31329E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821282; cv=none; b=lIovld1ApHhxYGQ+ufKOlsc5i5yiBchAZbgZYbKSnz1QMG7U6ZydN2wxdL35t++OgntTqsAWacOmuxClXnR79D/kN6yISOn3QALlUjVQmRxGeGjnz+gGFp/PI1V7MApR3Uw4RGAwQJG2RLGJuWUBp+Ky+JbEjFyD8ZNHkFNkN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821282; c=relaxed/simple;
	bh=Ey/vlEVn2hGuantafygT1RmJNBedh5fBe1iHY8aTKB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lO+nIG1jPTjO8l0zeSQ0SLCRgBFTFXKWUQHDkn2w05lxvMqKt3OteQIRx2Eg8sK4iNnYbuvDxvokWCw48YWToVghuNjBZVJICL0FOax2Z0fE+4zjifqQplLMaMwyJladccD3jpFWd7Oilh+zGYArMb2GbOcAKs6rHbIMEQq69Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVPi5OGA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737e673so1544957a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821279; x=1759426079; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZJRZN21lnDoQyu5GEV2DjzgnLuvyUkzsih4Du1Rahc=;
        b=FVPi5OGApAy3+8Ko7eNliWTduV6hzqtQziRffiqny2z6i6adRGwZKxTwISLEQrtAqZ
         mnLiiFz/Y6VRz8xv6FSFOW0pvMGvI2if8BmGo+zOqMANDaQiVFNjF4OQ3plYyeb1sr9e
         0S4yBUoBfdPtICCYFsn7+gvw6/YtkvoQCzOhOL6agYn1SgDzyz1iHSSGE3PAJBQ2jhDT
         Fn9IBHzTWRt5j5Jr4jeD1ct3hxKeVbOTscWD57ulphIOpC8gOuCcxqblOVlVV2ygunwh
         gkmpNawHd4zOuSRLYXzpVBnc3zzCkOg5UCcHziBIIMaRqNnE6Jc8LfAcXMk9hCMJUtZp
         598g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821279; x=1759426079;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rZJRZN21lnDoQyu5GEV2DjzgnLuvyUkzsih4Du1Rahc=;
        b=SfVPNDQNkoDEZU6V1tHJR/z93ggLcbKHF0hybWfPDYY+/Bsb9mxGkOo6FAQhSNRxX3
         IvcjIH0gPrqknaEFUIDfpoaGOYWt7w6kWX+sQSd3c7bJ3+FAHJzfLWL8JKH7uGPVb7xK
         RH190FXiap+hTOx/FR96P1ZqkkZmLw3rVd2TWsWVLNvIAc1MDoD2TlGXFRfimqmEHdEL
         B9zctlqRn3M8jGZVOZKZfUAA5A0Bc4Wfe8JKYNOrV3tFDEbs/ZQ71AlBMhdWSXLBFE89
         bTlY1GFbYqzWA0tLMXJbn6Qac+JxkQJsofgxIERz6FFIEgjuUPAXUiM0Jp5LESkhU6S9
         ZzEg==
X-Forwarded-Encrypted: i=1; AJvYcCW8cXN8s2WNk3J2yNmSxaMnSsUzvMor5+tWL5OzTcZd/9Cv98T3QxXkBDrpUz2bdCJ64EeXekzZSGPNj6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qagoKOyWsBNcPQOw0QtpDDmo9SnemHoxViTUZkKxtRiciNDh
	l3MCCEnLY324jhxHgGuZW17gPE6GjXGoPTYRmmjBHlywHtsMKAl6jDT7YMcVNczUF+fJZeW11hr
	TNmvufDf/Cw==
X-Google-Smtp-Source: AGHT+IGz1oH3TfOQS+/zUwmogW/iQf07DIVKWwzOt8XqoFkcJMlsJxa37ObpxrZTlL/YgE3N5wyuzdCY9GOy
X-Received: from pgbfq8.prod.google.com ([2002:a05:6a02:2988:b0:b57:d1da:e3a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7e82:b0:2ef:4635:4fff
 with SMTP id adf61e73a8af0-2ef46a02466mr1777934637.26.1758821279368; Thu, 25
 Sep 2025 10:27:59 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:35 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-10-irogers@google.com>
Subject: [PATCH v2 09/10] perf vendor events intel: Update sapphirerapids
 events to v1.35
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update sapphirerapids events to v1.35 released in:
https://github.com/intel/perfmon/commit/94ed947d7b5966e50a685118f69e8942976=
ec397
https://github.com/intel/perfmon/commit/9d993957a2a8fc1d4f843013c979a413141=
e9839

Also adds cpu_cstate_c0 and cpu_cstate_c6 metrics.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sapphirerapids/cache.json        | 63 +++++++++++++++++++
 .../arch/x86/sapphirerapids/spr-metrics.json  | 12 ++++
 .../arch/x86/sapphirerapids/uncore-cache.json | 11 ++++
 .../x86/sapphirerapids/uncore-memory.json     | 22 +++++++
 .../arch/x86/sapphirerapids/uncore-power.json |  2 -
 6 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 3a15a0f75b96..3938555d661e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.00,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-8F,v1.30,sapphirerapids,core
+GenuineIntel-6-8F,v1.35,sapphirerapids,core
 GenuineIntel-6-AF,v1.11,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index a30af5140e6c..c66324d41a89 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -1,4 +1,67 @@
 [
+    {
+        "BriefDescription": "Hit snoop reply with data, line invalidated."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.I_FWD_FE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated: removed from this core's cache, after the dat=
a is forwarded back to the requestor and indicating the data was found unmo=
dified in the (FE) Forward or Exclusive State in this cores caches cache.  =
A single snoop response from the core counts on all hyperthreads of the cor=
e.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "HitM snoop reply with data, line invalidated.=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.I_FWD_M",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated: removed from this core's caches, after the da=
ta is forwarded back to the requestor, and indicating the data was found mo=
dified(M) in this cores caches cache (aka HitM response).  A single snoop r=
esponse from the core counts on all hyperthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Hit snoop reply without sending the data, lin=
e invalidated.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.I_HIT_FSE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated in this core's caches without forwarded back t=
o the requestor. The line was in Forward, Shared or Exclusive (FSE) state i=
n this cores caches.  A single snoop response from the core counts on all h=
yperthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Line not found snoop reply",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.MISS",
+        "PublicDescription": "Counts responses to snoops indicating that t=
he data was not found (IHitI) in this core's caches. A single snoop respons=
e from the core counts on all hyperthreads of the Core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Hit snoop reply with data, line kept in Share=
d state.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.S_FWD_FE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne may be kept on this core in the (S)hared state, after the data is forwar=
ded back to the requestor, initially the data was found in the cache in the=
 (FS) Forward or Shared state.  A single snoop response from the core count=
s on all hyperthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "HitM snoop reply with data, line kept in Shar=
ed state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.S_FWD_M",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne may be kept on this core in the (S)hared state, after the data is forwar=
ded back to the requestor, initially the data was found in the cache in the=
 (M)odified state.  A single snoop response from the core counts on all hyp=
erthreads of the core.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Hit snoop reply without sending the data, lin=
e kept in Shared state.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "CORE_SNOOP_RESPONSE.S_HIT_FSE",
+        "PublicDescription": "Counts responses to snoops indicating the li=
ne was kept on this core in the (S)hared state, and that the data was found=
 unmodified but not forwarded back to the requestor, initially the data was=
 found in the cache in the (FSE) Forward, Shared state or Exclusive state. =
 A single snoop response from the core counts on all hyperthreads of the co=
re.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "L1D.HWPF_MISS",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 8a18d6e01ef4..b6a28227a58a 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -39,6 +39,18 @@
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
     },
+    {
+        "BriefDescription": "The average number of cores that are in cstat=
e C0 as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0 / UNC_P_CLOCKT=
ICKS * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c0"
+    },
+    {
+        "BriefDescription": "The average number of cores are in cstate C6 =
as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6 / UNC_P_CLOCKT=
ICKS * #num_packages",
+        "MetricGroup": "cpu_cstate",
+        "MetricName": "cpu_cstate_c6"
+    },
     {
         "BriefDescription": "CPU operating frequency (in GHz)",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
index a38db3e253f2..1bdda3c3ccbf 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
@@ -311,6 +311,17 @@
         "UMask": "0x2",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xaf",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_NONLOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Distress signal asserted : DPT Remote : Coun=
ts the number of cycles either the local or incoming distress signals are a=
sserted. : Dynamic Prefetch Throttle received by this tile",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
index 90f61c9511fc..30044177ccf8 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
@@ -3129,6 +3129,28 @@
         "PublicDescription": "Clock-Enabled Self-Refresh : Counts the numb=
er of cycles when the iMC is in self-refresh and the iMC still has a clock.=
  This happens in some package C-states.  For example, the PCU may ask the =
iMC to enter self-refresh even though some of the cores are still processin=
g.  One use of this is for Monroe technology.  Self-refresh is required dur=
ing package C3 and C6, but there is no clock in the iMC at this time, so it=
 is not possible to count these cases.",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Throttle Cycles for Rank 0 : Counts the numb=
er of cycles while the iMC is being throttled by either thermal constraints=
 or by the PCU throttling.  It is not possible to distinguish between the t=
wo.  This can be filtered by rank.  If multiple ranks are selected and are =
being throttled at the same time, the counter will only increment by 1. : T=
hermal throttling is performed per DIMM.  We support 3 DIMMs per channel.  =
This ID allows us to filter by ID.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Throttle Cycles for Rank 0 : Counts the numb=
er of cycles while the iMC is being throttled by either thermal constraints=
 or by the PCU throttling.  It is not possible to distinguish between the t=
wo.  This can be filtered by rank.  If multiple ranks are selected and are =
being throttled at the same time, the counter will only increment by 1.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Precharge due to read, write, underfill, or P=
GT.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
index 9482ddaea4d1..71c35b165a3e 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-power.json
@@ -178,7 +178,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C0 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
         "Unit": "PCU"
@@ -198,7 +197,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Number of cores in C6 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
         "Unit": "PCU"
--=20
2.51.0.536.g15c5d4f767-goog


