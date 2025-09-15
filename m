Return-Path: <linux-kernel+bounces-817068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C24B57D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE13B4EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459B131B81B;
	Mon, 15 Sep 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On20A5Sz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7430E823
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943648; cv=none; b=d4X+IJmvHyDgRk3N1h+nIRlc9puuVvORVjJATgoCyLiP0fdPpf+KPwmMPHe61mN0pz3muVhddRvq9sZA8sgfHCEQUMxy0XupJ7pMcQbLBh0UlQYx2thUmtW8nEQsVeH1crROYz2h0kUv4EJioOqmmRlle84xzW/jMU8dqQxTudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943648; c=relaxed/simple;
	bh=Cid1o0yI6anA0oMjfZ5dvYwhgQOAZ2ZDCkuXoquLJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQU3Wa4jH3WBEosek6HXtX0Ka/dPU+utcV64997W+OTpPgyUg12hBlUml5rcW76+6voANlA5hjNioCH17G9hdpK0zmO7RVX0lTiaiYX61++0TQ4WfX+QUMo65eYflaccPxpDx9+m03yz1vyIMPwXTLAEjT77ZvSd3fzLwJQZ6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On20A5Sz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f716e25d9so4335260e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943645; x=1758548445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4jfcSPGUvol/n8ObJSFwltbXIiILhsqpfoN+DLL7zw=;
        b=On20A5Sz6Kr3N5KAu+PLbgEqNZq43zhMJUzSLugqxPOspsM5iv4iQQW9ZKF99jVPEC
         h4scfo5WZh++nLYt4NzbtxYSbAjdvAuqycuyOFwPk2BghlB92ppNdMlz3ZtUzQOtpWAh
         qjA13zt3b2HCVZPdveIS1GIS1J4NigHA7SLTWl0fjR3QvnY/svNWh+cJXigvuy9G1zKl
         8EWzh20alACYgcfnNcZ4ICrkV8d3u1qByZfKqoPx8Q9oOozhxUqix+brC6udLUct5a5Z
         toapcq0jEnHmzh0syWMruPdX4bu/2sItRy+i/07MkY9x44cTi/Ub1aiVZB2UMTDprIQh
         hLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943645; x=1758548445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4jfcSPGUvol/n8ObJSFwltbXIiILhsqpfoN+DLL7zw=;
        b=U0Kt3oNN3+IJTdGrgNdTMvG3Hd0elEOKdySDSqc2YBgJegPg5nKUo01flP9EcOlcRf
         J1e/MIW3uOZ7Gv3AqTL9Eh0XTPhYQMFv1FwY+2MG+Pc/7VzNkRT7M46DBjE9CuJmb23K
         zLA/c3QiNbFbtOly2lpH4S+4eR7vqV6u6pGbKLVHxNrAlv6oZe560gTYACyZyvHQnmpU
         8Ri7imJENf5p9SB9tR0A1nqjxFWVUPgWBdwSI3k+hhpL9APQfSLm4snHC7RhN+z44svX
         R0kPkt3i4b1sE6CK6hBBpe6cIwb9xFGur78SWA/6112E12SxTAg8+GIwVrYV3UjyTuPg
         M6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWyD4Z2RwjZYCO+67ZNO4guDR1bKWaoSQivQutvHQjGfTvnBXxzBdIeckxBMndkQWmhyg6JUYrAHfPXdiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObK8BfZUt8DjHOMsmLG9L4WIMwJMX4yLiH9z5XaBOlbapnFqg
	8mGwoXEdUlvNLWA/2D6kpRDZ3iXq3WRNb/H6LC1UiwwL/lZxdtSfo6XF
X-Gm-Gg: ASbGncv8C5Y8/JEVPbct51LjQuorzTYmEQI/+cylKd/7hHi8znZHXjN8Kb6Qk8O8Xjs
	fPx1zJ9YxLbqT3V7vgx3wBAYwz4ejWjoZRmrlmrf/n76w4l+GCnXZhw0HmZH71RAfcppRfy8NZK
	bR4/P3YRGmH0UMhhsdnWQh1PVvVGEntEAByNuw2UvFxhP9TrIKbol1q/SapoRkbw6wTVDFdKWJz
	WsYf2+aoWMBC4cRYgiNWUicBTJYGdN3gETSU4IAHtpVrmFFziEqIBtu6ok4sq2Ww84r0fh13bsi
	Br2nK45DZHPgAfTWx7JfH2dEDv3BJ0laCa+/YbGfEbLnTIgW+6YGvq2zj433M0fYSmHZ6oVAySg
	gLhMw0rg5zJEODGgc
X-Google-Smtp-Source: AGHT+IFfFqmM0jy7ylbFqglRpgiY5qZFquoCe9bp4TcomMhze69RBptnZFzQntvLjkxDYXF3stX3XA==
X-Received: by 2002:a05:6512:3c8a:b0:55f:64b9:3ab4 with SMTP id 2adb3069b0e04-5704ca47523mr3450667e87.23.1757943644794;
        Mon, 15 Sep 2025 06:40:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:44 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 02/10] lib/test_vmalloc: Remove xfail condition check
Date: Mon, 15 Sep 2025 15:40:32 +0200
Message-ID: <20250915134041.151462-3-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test marked with "xfail = true" is expected to fail but that
does not mean it is predetermined to fail. Remove "xfail" condition
check for tests which pass successfully.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index aae5f4910aff..6521c05c7816 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -500,7 +500,7 @@ static int test_func(void *private)
 		for (j = 0; j < test_repeat_count; j++) {
 			ret = test_case_array[index].test_func();
 
-			if (!ret && !test_case_array[index].xfail)
+			if (!ret)
 				t->data[index].test_passed++;
 			else if (ret && test_case_array[index].xfail)
 				t->data[index].test_xfailed++;
-- 
2.47.3


