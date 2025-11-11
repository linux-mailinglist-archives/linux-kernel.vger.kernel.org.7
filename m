Return-Path: <linux-kernel+bounces-894612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B915FC4B6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734053BB1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1134A78C;
	Tue, 11 Nov 2025 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMcx3RBm"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE234CFCC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833890; cv=none; b=ry9oZyROp3PUZtNMutCZg2tHvutdqXo6KEhXNhJ5kDs0Io3uuS8FK4fOpo1tAsgmmuTq5IUKwaWH2kZa+flpNA4kLOm/RP7dUmXi/3Nc3w0+igAEXW9GxdMg1/N9RboE1aEL5pxSp0MPJCFB/eg+Jj7e3wkVu8dZ6jpp/IzLWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833890; c=relaxed/simple;
	bh=QjO8gSjusfZ0mPendJr0+QHEFToVhbHiU4PqR4DkANY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jWPDvYYqsY21+PjfO6jTmKMOZhNfTliTNCeoG0k5xcjcpwPVwheWkbm2XkRmAJ0aATmGGwvyshf6Ei4H0hcpejnw1iFsFlgp18jQ7HoRCn7fyPlTUN81+cgSIg++u6DX+be6FXmjwk9l77JLoPT8Vp1UmRd9cXZmkQGz6a4qOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMcx3RBm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f3710070so70937725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833888; x=1763438688; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=pMcx3RBmxGyfJ/3RiYYYLiJT8SzYYWyA7VRce7MTus/vfpdebkBR8w5vTOWeFdkEEL
         XeZsfEZpTauXhVBuCxNr7pwMo//fDgjHZ7zAJJfmx6gGrkYDb7BeAH3Il8YxwRLwSild
         3F4odrOywosmQlNH3IENXyx3wYen/ir8DfnNZE1/bNXAmL6+aCkulBRBRylwyaw57YEB
         Zc+SJdezoNsDwtEa6s/rvbMhiViDntVLg1arY57jhJkLgNArvImSnhmIMpJf13VhMqlt
         CHzg9sbx5ggk/s22/XVXMQyjkXL9pgoEeClh8D9hAIzMPWuZCu3T1JyAlo4U2D3eCv7N
         t3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833888; x=1763438688;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=B4QFFG23xlLMyMkY3qNqjLMKtKzVPqfTr9TbEHGdXrx5y2et3tW6mhHJxo/sO5/Vas
         1aHphBkTI0g3cqe4Py81NTtZT5jzp+4SK+51dH5GtEAhD8W5TmGSrN6yeCnEFUJ1TmsU
         ad2tbLZ785c3IqNvwV/LgvAfb37LK6z70FMcbjZRTvdCMWKFJfi8tnJsIajA40S+T5aM
         f2aKOyXLwnYU+EzijIJbmj/N/WxTR7FraPA41CI2cE0WDT+DS9JPvj+u3Tbh9Zl9kHX2
         bh52n4VsNOXL4qOTUe6vB6e4zyivhBjP97oajwJ/atYyoxJp51Vz7X0yU1z2RBMOJMZZ
         Obcg==
X-Forwarded-Encrypted: i=1; AJvYcCWaY6PRYMjfo+cGrFdVo9n3aUrcarcHe7WAYytr3GSEq4GefZ69d3ez9T6hSmFoLrNWGoeD5+e2eIxF/Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWU94VHHhaMVFAjBVnc+wmmRLZdK1Pg8CoPQMF0VIyD2wYEDhp
	f+9hwXPgNOiWy3fw2W2ApO1VgIpoHoSAVNjB7zisvDvgpSJuTUNoHYaRvNTySzVnSmAuRqPuTs6
	py5aJZBv8Gw==
X-Google-Smtp-Source: AGHT+IHnQHwE7ZVnLqbv4sMxN6fuUu9/VHBggmkrVxMIdeFVE3Yq6GszmnnFYMuvX5r+GV9wJ+cLh3U9USGv
X-Received: from dycoh8.prod.google.com ([2002:a05:7301:da08:b0:2a4:6ae0:3502])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e947:b0:295:543a:f7e3
 with SMTP id d9443c01a7336-297e564cc94mr135808275ad.27.1762833888290; Mon, 10
 Nov 2025 20:04:48 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:11 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-13-irogers@google.com>
Subject: [PATCH v3 12/18] perf test stat: Ignore failures in Default[234] metricgroups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The Default[234] metric groups may contain unsupported legacy
events. Allow those metric groups to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index c6d61a4ac3e7..1400880ec01f 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -37,6 +37,9 @@ do
       then
         err=2 # Skip
       fi
+    elif [[ "$m" == @(Default2|Default3|Default4) ]]
+    then
+      echo "Ignoring failures in $m that may contain unsupported legacy events"
     else
       echo "Metric group $m failed"
       echo $result
-- 
2.51.2.1041.gc1ab5b90ca-goog


