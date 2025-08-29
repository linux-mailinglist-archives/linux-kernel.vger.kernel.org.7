Return-Path: <linux-kernel+bounces-791046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDAEB3B175
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C2398212F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6C2550D0;
	Fri, 29 Aug 2025 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyKtlH9+"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E00253B71
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436869; cv=none; b=FYYl5R/wxoxRJiAlCIrcQsHbprCSWTv1qUC66mI218sDd9SY3SCdriMOdGgrCvobvczl3I10RdhsjbO2EA7OgmNqk1pDSFbVHKRxkg1FD+IMeNxXdHKSHyZtcOEwsUTmhfl3e0EameMd5v84AVagEgZVHHGf81J/VWpgKsW99cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436869; c=relaxed/simple;
	bh=mvK/PV04tjW1I5Iw9kLq2VEIUkQXS41ViqzoKNrB2sE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=s2/0FqZVVGBOAZF/D+ePXCrdaiC0jQKRJLaU/fKWdm87xCu/Fes4E8Q18xHgdcZJZ+w5nMqfDNwNlaaeVpqLrMaqcQRx60o8a/fraAKBo9gKGzm+mdd+OL7Hk3NTu0NNX5/p6lcMBQ5jLdig7q7YdSMq19UDeIV1qTl+BI4Ffv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyKtlH9+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581c62faso22360465ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436868; x=1757041668; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2+LKUGuiZnKRHudSSVQ03215Sw1VGb8XqCbcRcD/4M=;
        b=PyKtlH9+krvllDuBAPDaaHp4AJR+rGSpHxtN7syUEap/EzvAteQF+KDFq4gNIdkbtq
         QR6Kt8Hc/iWaUBBF26sP1I3sQja36ON172kTN8twN+nAHZosT6hIfx509zgJuRgpA2nj
         vxFwjJUbfyTXbG8J/6M0yz6EcveZg2TnWFR6CCYLoiFxX6GdBhCIVsTEqdH1piKUfK/0
         JfTfL7F78s5gZaSUptH2TwlBhj1B2qXegF3ZgXIOEB5VHPdcgc+ndGL8dm4Jwflyz2ok
         yDoVUjFFRLRm+Ar+ylx5YJ6BBfnXD52wXdEusruNqFbAAe+Twj5bbsiOYzi61X/j3d9P
         kFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436868; x=1757041668;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2+LKUGuiZnKRHudSSVQ03215Sw1VGb8XqCbcRcD/4M=;
        b=IXAfwblF63zkvmJMaRfLrx46iDWhm45ric3+0a1EZE8X5SAMCdFvfjOS2mbZXnKJvC
         +r9gtyzZLodnqePwcVADiF8IQeY/r84dMNV+/8LqhGmvSUUhtZvuA1dLx5GhPyspTkLf
         Lb7lVdiH6T7cSXyFF1sabF18SdEnvHSapZ57OuPHFHUid70j3sQnQ5lWSPxLb750RUhF
         c+lIJiwD1JLBj8wPLCppzvzEhWB5GZ6HRzSVuTxyeELRzLUopddjuDGne3rnEeeJvfTB
         InmMPTLKiX/W/vZWKfBBCDQM+PoS9OxFU+Uk8FNPKBwKbOFEtM9CF4Fc7CCGU1+4c4ed
         Rfnw==
X-Forwarded-Encrypted: i=1; AJvYcCXWWnm2j16+VNJT2Afe/taod3FKhqOdnIzlMjDqALuXyxtSWRBhhXH7PJ0ZYIBgCljLqZ6jQBxzWSPkd24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXIbJIGqKR6sHdBBnxFcCxVvWvi+l8eNc0LrQxFWl46m1koHG
	hKj/64qkDuNBi6OohIns6cuBYSpFpN7gKqtOPpXY45MlngM961LqRYRn7eZZS6qlYKBGqMm/36x
	KRvZuHWDM/w==
X-Google-Smtp-Source: AGHT+IEroOEo3hGTKFAfP0Od+3SOyQkeBBe0t3oUNE1ihXwHPekCxy+kGUzb2H7xFpNLQerzUDJtr5nhJ85s
X-Received: from plgo17.prod.google.com ([2002:a17:902:d4d1:b0:240:2ee5:24be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a84:b0:246:2ab3:fd7d
 with SMTP id d9443c01a7336-2462ee5d672mr347754085ad.25.1756436867866; Thu, 28
 Aug 2025 20:07:47 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:23 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-10-irogers@google.com>
Subject: [PATCH v5 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one. Ensure the
PMUs differ for hybrid systems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 69aec4661a13..7978ca7ef16c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -498,7 +498,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name and
+                                 e.pmu == x.pmu for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.51.0.318.gd7df087d1a-goog


