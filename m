Return-Path: <linux-kernel+bounces-861298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF0BF2511
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69121884ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F82286400;
	Mon, 20 Oct 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eObcZTdW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55963283FCF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976572; cv=none; b=RMYr+5Ik33MI5zraW+D7Uw3hNPyMhGS05d7tplHJWXNUfJPw/3tc0wgMzGut/LUgtYKWpOLK3EaTP5qgVyy8UGoS/A7wpjZ6VJsYq+D0T54nwv3+4HFJiYnWHPz06y7z1y7ogIc/stzMTduKpAN6C8ujf2Faag1o2I4jB2lQ87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976572; c=relaxed/simple;
	bh=9aleKV3jYb4lyA7qIzUxHQD4EriPvhEU/NjvOR+A/n4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4uV/x/cXCUISyzOUbVyGIvlg2r+vAqvPEudseVPdRYL/rFbHgVmM47hx6sFd57MZAkWRqn4vVLxRfy43xLFBg0/7WjDFN2hQUFWBJdgoxDOJ98ZPx3UHWV7rHgX/3DBsWwHJELTUWg7ekk+blD6P6zpSJ9H/R321Ls0pW1Jufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eObcZTdW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42421b1514fso2853250f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976568; x=1761581368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKgUJxK4ZSlmx1ToeoOvB+8Hg63ofocFdJXNrvPPt2g=;
        b=eObcZTdW6GXt109UhrrGYWlqd2zuCyE2eNKXDgguVEGzkPFQyzyAxCHhyBTu77rsGb
         cDVXtS/9O9wRb3qn4HLFZFXEqimsoAX3J58Wp7IdxuIACeKINtupy9bhgW4txIbKcxP9
         291NG74vFVJJ/X+jSNhb0FEiX8fDY0POwKHkbPiW5PdwSFXn8hYpenoSDSurwHJP31Go
         GeygvXh4evy2EynJmieqJQENk2DzuyHrtDY7v1DP8h6fJiDvk3KSb45ebwo2JaEjQUTt
         dl65GkC787cRTfwddnTdDvT6j7TqqebU2zL/mm6YUE8UEXFKosJtTqGn7XMK2D8hFvI0
         zAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976568; x=1761581368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKgUJxK4ZSlmx1ToeoOvB+8Hg63ofocFdJXNrvPPt2g=;
        b=eQUF28TJJ+H9282rrpHOUms//Q0ozQEoczjwQ+e964ypvACD9TQNkBvJpFmPq2Mu92
         FPk8Wb0DVwHkPKVrDyv0HZWhyD3mo/AeZgiUYY6kBX6sxIE5dmUsXLEpbuI0xBlP4JeW
         DUepht0E46G9M6E0dOzrZeZ2ccX+ivqCQjShEfIEbqx93a+8RvBE26JCT9ZiWSeE6qIK
         muud2GjRSW19eJugPfqwrXxmgy4LlFkPiOgKxbcE+phoyGEiUGoR6fd7nlKbG6OFVz7B
         El5ihb8hbRQy8Wsx+cVvVT1qA1Mh9yMhEVMuSTmB/JRrqeeg2YRNcFQlseeFET3Vu41f
         SGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyutg/VBr69uGzix06EloU9xOSVJi88YbnjvbIvbE0u58sGIGjvsaZoRH+AWkmJ4ri+OnopXWZiD1aZHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTNQ7HhB+F+n8vZ8KKukxLDAVhoi/12NNe002WoLhcZ/9eT1K
	Yal6tjm3S2lG+Mf7n5mcBWbeKAppD0J3qMahD+sZ6BVetF2lgYXCWtK29JtuI6ywjs4=
X-Gm-Gg: ASbGnctUZYPaxj3NS+YrrSnZNYTaUQxuE5iCxATrPS0pd5PIy8uSioQ0+56thFLlRvm
	NTQhBexW9D9Xx6trSQovaW2GRkh0/Vw6gVuBGsSzLlkfNAfi+bPscHTTwgbLafgcxHfgOTUx5GH
	H7i12Nc3ngyJkagHPzu2PTzR7JfrmvSE0G2M9/XZ4hQto5N2DdLQx1aBevZhfFDNx3P/2smXCCg
	WZxZXri6diGgmgNQ1bjel32WwRISdaOpFjCvNEQ10PUaSTuY1MXfRxlRcjgPK4hYsyqS9j6QqrO
	MnFg7kS8ZksYcMHHgQSDzd+v3A4OVzXLbDoi0ootyjh/alxUuuwIu8pPn91WSCQtunA2J5s0T8W
	WZXSMxd/uCdJbOEx0glzCJiHQRjnRDaQ4TC0S1Mm9k0blzsJEK9Vsusuy+pk4TqIXwNTaRCqqqU
	s8ih8CPrJmNg==
X-Google-Smtp-Source: AGHT+IEphAXj5jrvC/vtHwqvcbcjL58pZTHjVIB8i8Gu48livdnLEA/6pKhx9fzVcD5EDbknNu8zIQ==
X-Received: by 2002:a05:6000:2911:b0:426:fec1:a58e with SMTP id ffacd0b85a97d-42704e0e681mr10197504f8f.53.1760976568568;
        Mon, 20 Oct 2025 09:09:28 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16408067f8f.28.2025.10.20.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:09:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 20 Oct 2025 17:08:27 +0100
Subject: [PATCH 2/3] perf jevents: Remove unused makefile variable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-james-perf-fix-json-find-v1-2-627b938ccf0d@linaro.org>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
In-Reply-To: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

JDIR is unused since commit 4bb55de4ff03 ("perf jevents: Support copying
the source json files to OUTPUT"), remove it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/pmu-events/Build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index ee8ba74f82de..c5e2d5f13766 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,5 +1,4 @@
 pmu-events-y	+= pmu-events.o
-JDIR		=  pmu-events/arch/$(SRCARCH)
 JSON		=  $(shell find pmu-events/arch -name '*.json' -o -name '*.csv')
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\

-- 
2.34.1


