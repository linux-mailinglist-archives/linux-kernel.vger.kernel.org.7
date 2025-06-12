Return-Path: <linux-kernel+bounces-682765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B8AD644B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 02:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A218189F1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1F224244;
	Thu, 12 Jun 2025 00:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yk6DENmD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720920DD7D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686577; cv=none; b=o09WXlu4kEO9J6emmpz8q/wvkmawShkziieeWoUBh5f/dispiMyPD/Mfdsc/CNbDgK2VLnPGB9606dYfH+eo2oOtUxYQ7sS50kfCTMhdtn660t1M8iZGJJIFeOSBO7tbpaG6AsnPXAOFSFsjEVDYHgH9onkgzwAWHNjDbOOPNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686577; c=relaxed/simple;
	bh=mN7bVRM5kNACOxx1RfZz6LRCvon5svBw1Arzelez5rE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Wf/yMjbw3fSv8oAIjl7cfdVmqjN58HmqDZDk9esrFPHOhRvEHk7UGkSgdLuLhYHJdOe/MXAaSXbPdqmAfq9U1NLNCXOQzVtdQEu1ZS79B/JiO1UpWP3HiCLMiQfdNPPTxY6PsmLYkpgiasRw+0yMDnQjV4HLm3lzyX3kRtY5qKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yk6DENmD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311e7337f26so281134a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686576; x=1750291376; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bto2Opb1v2y0rCsIlj8RMvNXICnNZbRswbGy09dnYBo=;
        b=yk6DENmDaiyaNv2aqrp7PaSjxEAIgy8h5hjnhNsxb3BAelC/HjSDlPP4G5hynh1N6I
         ADohusefWt3BKPNyDnbQI6PpfB13TXkxQ14MXq+DdJv2s6CPGeF2XJwoIyWkRD8pcOEi
         HsDKdgyI/y7d7JDFjt+jKkOwPnjg/9/i2CshzS6RPq5Od/4dV7JZhAn5dYUM68uBERmH
         yy8Skh5FyHV0FFts0maKEv/ZmFfpD5GBk6uXUXDUuBzpATXgprCkDfXNla7NzvaiEmNX
         Ek7TxnE4zDKx2QYTcoO0CmZZ10HKTQ+o/ljWjVKwXlxkVodXRWucSbY60IGfIgJR3sNU
         cXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686576; x=1750291376;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bto2Opb1v2y0rCsIlj8RMvNXICnNZbRswbGy09dnYBo=;
        b=jgeGuxkjEVBcwk1m2E5YSVFDE4MkOS08bgulRxyZYI7cfT/ox5AjQBcvn3vlITiJia
         Ni05kYEua+EaEyq2Qtdkuo/mKOEEDMo/fY6WLaCcrIwQ1VBX/igb933aFCpgo/YMjIqB
         5vKslRRHcygaO7IspO+Kdh9y1NG+ZznxxVf8eRiwGk17IfaCP39ZJe0KMgIjtBOIXcKF
         P40RCRn3D0huNhlfMxQOamx89mEZaxHDkwiamEecFyPkrCxeLXMJ5P85pTVlvdEG5zcg
         eBhIf1rrPy57wZ7fcP61R3e9tNG0fgFdGoZ/BE7rFloWeNLKvZn1OkIyjXvCcFV7Bd2Y
         V19A==
X-Forwarded-Encrypted: i=1; AJvYcCWkkSjj9Z6kWp2+z7b7FrmSGydWttamI0/fL/bkO3b1DHtKtSoCdP7Tl4Bg4d2Bh0lM0x0x6GFYpHvBkPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaib/LipKoTE572E69GphZsNbsPV46YVS2kOI2EzWx0b7Su95f
	J00o9Jjp/V6vJ62aPUJFEXIr2TKLdvo7SJi8GCW4z+YP0roD9IhONAHkZwX4TH83UzpNNWP6KZ7
	cSwbBY7ZV+Q==
X-Google-Smtp-Source: AGHT+IG1fP3iriSV/ko3/EVSrMSY9pUJr3/OnkGRCQh9DyMdYQhL6aWOGv76IQXa//9uwLYIVsLWXeLChjHE
X-Received: from pjbmw9.prod.google.com ([2002:a17:90b:4d09:b0:2ff:84e6:b2bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a85:b0:311:f30b:c18
 with SMTP id 98e67ed59e1d1-313af0f8588mr7201630a91.4.1749686575608; Wed, 11
 Jun 2025 17:02:55 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:23 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-15-irogers@google.com>
Subject: [PATCH v1 14/15] perf vendor events: Update SkylakeX events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.36 to v1.37.

Bring in the event updates v1.37:
https://github.com/intel/perfmon/commit/6ee8e4cadda8b6954bd84236e20fab95e34=
5578f

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv            | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 54c2cfb0af9c..2d9699efff58 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -33,7 +33,7 @@ GenuineIntel-6-8F,v1.28,sapphirerapids,core
 GenuineIntel-6-AF,v1.11,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
-GenuineIntel-6-55-[01234],v1.36,skylakex,core
+GenuineIntel-6-55-[01234],v1.37,skylakex,core
 GenuineIntel-6-86,v1.23,snowridgex,core
 GenuineIntel-6-8[CD],v1.17,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/skylakex/pipeline.json
index 3dd296ab4d78..9a1349527b66 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
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
--=20
2.50.0.rc1.591.g9c95f17f64-goog


