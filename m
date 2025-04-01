Return-Path: <linux-kernel+bounces-584012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34035A78241
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A62188243A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8164B228C9D;
	Tue,  1 Apr 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNsK088E"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2EB21A446
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531968; cv=none; b=IBZurXSsl1MPJxkunISIKr1BJ0+tzCvWwnhw0lIBUyyQ3vr5uVXbHAmlds5+R6TKbDyiMy/y0x8ZuHcRC6dabCqBuB63AT8bAkBKgBiV8ZtdzMdzU1y+jbiF8ih/s6rnErVBRSykGq4DrVtIZoK/RnZ3A6GQwro+ZWNAUpyaq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531968; c=relaxed/simple;
	bh=VYAhgSHR8CjW8YATc0oZ3XPUiaGVjv/5MYlkyFYu2lI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jSGhwZbq6a16OG5e0SA5u3beiMsMx+HisbrIHh6CbNOCwKIpHk74PUmuU2HbCpbNGCTMPq8g3bmS+2HlRL+WbJYzuQyuW9fxabJE+oJYY+eXvMpTTgq3jYms8iZq7/kif2/iKlWICXWFpKu5hTIyy1GAppEpTputuGjpk0j1tcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNsK088E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30566e34290so1226104a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531966; x=1744136766; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GhpEMZc+Go5hXkRH+5nn2InkEe+78BeHi9RfDz0OEg=;
        b=yNsK088EKqqT5DybR6+96tfxYTjYd+kg3GsYH4iRO66jQYzz9moDQss1mYH5f7xbhj
         8COoRraqrwBAeRMmwkAG58TaN/mIiKGvw5ldZG8RfPsfTFiZTHu8w0MsS13qt4UR+VeZ
         LJkOPH6gkT7ahKPSEdYibxM0Jzc5xjfVOvATp6H6UBTK8xNoOB7U654twqBmUtsBb4uB
         ocf+B2uy3SfNI/SSIp0QpAQ5w8q63JCpTe5mJ/JlgaMP/vb8CqG1IDRC5GN1rSLaTiWI
         mYj7nY5m6CscEQUHjatr+JjA8FdmdC+zlr5a4p5NRacZt9rOMCB288pOPHXfNLf9zrB6
         Ywhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531966; x=1744136766;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GhpEMZc+Go5hXkRH+5nn2InkEe+78BeHi9RfDz0OEg=;
        b=LO/n4psH3N+jrDLx8J8UcWywlgvToNZnmlYxNhsARC6gOhml2fm4pCIrlns3DdKLKY
         9dB0O5OAzokahE6CUKuXJy5sltjeEr+aolv8twj6siLTvZtLJVvg0uXaY/A+oQIuy+Ig
         Kt+IE6QhPMWvmG1+HLm8ytjPwLdVDZeP66OoD6zwqJdzz61VMa3w5szEzNHxoHsP0kHX
         bKqVR4NOaTeOTIHDlc/r7JrnfWlEcUrnSOIJW5bA48B765pZ4YNfabFN+cNtXYU9yxKb
         4vDBduMiLxNo+IW9NNcfV7TZ59z9sW9PkS26Y9eFI9iOB6pQ6z3+/EGkd1Jxo/pksVM5
         ZUyg==
X-Forwarded-Encrypted: i=1; AJvYcCVzSRD0utLpD/WdOKHcARF7yCawGZG1KgSAT6mbImRUpnfymgXF/fiBkIJkdRir42Xsh9KUFcFhyF4p9/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+FzehjSK0haTURatMxfRxGSVQb9PdJ2BPKljU0lucZR9h0nT
	fILKWQ52vVBw6ljtc9SkOAwFZ+101Kn0n94Ebj3t+oud8rQrlNK52UglYmO5z8D+dYipKqmfA6I
	K7BqMqw==
X-Google-Smtp-Source: AGHT+IH28uehI5+J49TPsEd9NihvXOguO0Bih1z8y7KT4XeqjB74B1qbmMSKwRKZHS/+SGf0DQUxAQTZmWKE
X-Received: from pjbqn13.prod.google.com ([2002:a17:90b:3d4d:b0:2e9:38ea:ca0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53d0:b0:2ee:8430:b831
 with SMTP id 98e67ed59e1d1-30531f715eamr22653376a91.2.1743531966013; Tue, 01
 Apr 2025 11:26:06 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:42 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-45-irogers@google.com>
Subject: [PATCH v1 44/48] perf zlib: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 78d2297c1b67..d30597701fd1 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -44,7 +44,7 @@ int gzip_decompress_to_file(const char *input, int output_fd)
 		goto out_unmap;
 
 	zs.next_in = ptr;
-	zs.avail_in = stbuf.st_size;
+	zs.avail_in = (uInt)stbuf.st_size;
 
 	do {
 		zs.next_out = buf;
-- 
2.49.0.504.g3bcea36a83-goog


