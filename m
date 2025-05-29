Return-Path: <linux-kernel+bounces-666467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 976CAAC7735
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3564E1229
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01B2550AD;
	Thu, 29 May 2025 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wogGTUHN"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06761254846
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493614; cv=none; b=EoRJ/o0oGyGqIrmmb00UL+rOKuaGknVZJ3mIYoX/y3tIBO0JIKCEwZYQrE8yKQnmcXPBRahYDcFK4jO1rxlKcgsxHbNQLsBCU6E0CwD8tdycTWxoJVgZ2tutAoBJHXxtNJrvr/LCS+TbwuShnv/i+P4bdlm7zu+2PRVEy44gs2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493614; c=relaxed/simple;
	bh=cjf2fdD0rE5LRjT1VfJDou3dEpA6ok2BqEt1s5yCE/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EeSH3uWsU+x06neKUEo2yY2OGL3pPtystKW70HM5LH1CzW/575uTWI37R+4FUf0PzyEzC7/ip2FvSjXFPXKHNdBgEKIJdEcUdD4eKLsp9M0G90Y8oxTzd5bPZLMSMcnEwzCPBMAv+xjNi7xjG3AFa8XtqNEyYw4Dsel1aCSmjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wogGTUHN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394792f83cso390377b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493612; x=1749098412; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9aS71aJOPEt1sm6kO8E07x1jFtf8Q1JUjXvJGHfQ3qA=;
        b=wogGTUHNrDIU+iVL94US5lFwyK4mGKJPQYMB+HQC8ui+QVv+9LpvzqnK7ksHnvWhz7
         gxRXD3rRXmaI2vh6XVhk7m9im0103Yzvv5Z6rb+acnChjBi+vd6cCPZ4mqMBOyyb28dL
         jeZRdX/FirD2KqGtk2fzrcQaCbfwPGEYkn3dA5Bk141uytbQq8VEaeHNDSrtWCxBjFoo
         k+uS72788HUwV7IFEfgp9qHURLivTxgmXQMExO0aPsFNUzyzXaJ7paYODlqgxJ2T86Ci
         UGCs2Vgbxc2vFiNMiXgBZcCTABqQEuxr5Phn9SgGlHZT+Zuy1yh5BxY6nTSYzGyfq9S2
         PlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493612; x=1749098412;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aS71aJOPEt1sm6kO8E07x1jFtf8Q1JUjXvJGHfQ3qA=;
        b=WrOuFnJxIj+cBGqQH8X0Op3btR9P5s01caxKfHuP481wEkPCij75eedAL3KtLOK5p2
         7swdB1hiUgen2IhbSI61csEt1cqOjfJm6AJIl9ygcoS51xI8+CwwYoKRbEnobqKr5VDV
         1ZOYfJIWq+S6+dOsh1IRyzV1ig6fDMGzQF1sDJ/NUFmeK6WYkewsYODIHiHXDXtTKixe
         Ld4VifezJaFfu2fvsYiKTBtBlse+oHBTbP1qrPZBRzsGSjH39EwNDR66faO5K9Nxuiaf
         KvYSpspM28peUteMHMYBIvBZyNDreGt2ZiNZQMBJ3pmd81i4M6XUO6CSTSMeqzOy5SFk
         Ow3A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6R2bAUTzlpEkLau1vZguew9fGgUi9lWJjMqqs/EQEIi+AoCEELAk77fUiZjdSvAZ2d3dhjd0fc7iMYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3L8zB0iYR0EcvTNZzgcoHbXO9H6dw2JO6kEGLuKGvRwUau73x
	Vag8Dbo6ygVDcDFOcmH22/3eFB0quGGEnkgIlh462ZLlx0P0wDuO3qv1ZVANQPsDFmyUq5ekD+H
	IIeT3whAdJQ==
X-Google-Smtp-Source: AGHT+IFlKCkEqX1XRqJjw3YEn4vn41KmuiPbLqe3e6dAoMnichsXHqoCMaXHDL0e/0IqWUt2otPig48NXi89
X-Received: from pfbik10.prod.google.com ([2002:a05:6a00:8d0a:b0:746:fd4c:1fcf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4654:b0:736:4e67:d631
 with SMTP id d2e1a72fcca58-747b0e79bacmr1311000b3a.23.1748493612073; Wed, 28
 May 2025 21:40:12 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:39 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-4-irogers@google.com>
Subject: [PATCH v4 03/24] perf build-id: Truncate to avoid overflowing the
 build_id data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Warning when the build_id data would be overflowed would lead to
memory corruption, switch to truncation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e763e8d99a43..5bc2040bdd0d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -951,7 +951,10 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size)
 {
-	WARN_ON(size > BUILD_ID_SIZE);
+	if (size > BUILD_ID_SIZE) {
+		pr_debug("Truncating build_id size from %zd\n", size);
+		size = BUILD_ID_SIZE;
+	}
 	memcpy(bid->data, data, size);
 	bid->size = size;
 }
-- 
2.49.0.1204.g71687c7c1d-goog


