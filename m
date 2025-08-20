Return-Path: <linux-kernel+bounces-778379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7794BB2E4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9631BA812A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B025A347;
	Wed, 20 Aug 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIA+OD/K"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF519644B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713751; cv=none; b=h+Y1xhGugze1oAd1WDHLGJ5JV0fl1OGJvSMlau2v9AVb0w4s5++KraI2EceH03A0IN+fhcHfctz77oO0KCjumBOYLGzbIREs924oS/vKMVcNGd6bs2O9veqZxwZsq47hyTwCPhnqhVVf4riz7D3QnHdiPbbdDZ2rf9m1fpOA2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713751; c=relaxed/simple;
	bh=ow1Qw+on3HTRx8k09dTJ12Igc+cMQW7OI0onnAYExBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sF+w50j4MnztOKDn0Yjdw52RNDU3ycjlyZEtjtS2d1CPymlw+FfZcq2oCLPAwZB7L6Lyvw8+9SBJLyDW7kBHxdsWFBg+7wiPwwZSsH/pGDBx+PkL0FU+cC7gjNIlGFl07Vzuor9mf5QhqjqqaGVF9LyYhhHGeosWUh96dGApY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIA+OD/K; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e94ea56725aso171821276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755713749; x=1756318549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96wUse0ygeqtfCpROkv1ZZ3hcmMnQRg2Z+H6dp5krQs=;
        b=OIA+OD/KFNNP0A/OR+kYQUgW+7G7Xt+iezcyXveWoieYbNbHP0Nhrgp3J8sw87d2Fv
         d0uR146/QdgnE0+QIfXeRH2/StqlWz40mgMZ9sg6L3jDlzqNk2VnVtbp5aF0K5AEWZHE
         CHUp1RX+fgkFSmz77/FJKhPNm3y/BuJ0y1CmPLWMNNnIRd5tT05lolNEklkLfN47O5B9
         H/e0wubPHOaV8GY4nB3vr/a0B9hmKGgOazP+XX/kHWJUr60pQO0JAmZc4ca/tnOmG0MB
         wycqjVbjmcc7LTXvWufeDthAwkjBIhz8Cqoi5DX0D8oMdYFdp/JC9//Z9eQKTzckWGo5
         rimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713749; x=1756318549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96wUse0ygeqtfCpROkv1ZZ3hcmMnQRg2Z+H6dp5krQs=;
        b=Wu13eNL1Zb5klz/am0R6yQi2TZTFS4ZrLUDF/PeKm4VCfmNeFvGVXFYVocj+RDikSp
         1QH793A2PHaR2NfhT3hOOVi5lcbNDiq036quNbkeoA486KX98oXx6ezE6kqSu0PptW1u
         HzFN7S02xLVuvVB/XVB8QpucmxAoYD+n4/NAe8hvLrmpq8gJiNiQQjAISMR0PPXJ0/Pl
         mlrKdk7RpMaLTxhBL23CTlhoMeObYCt8CM55Sn7d8wm+VvTQXhnMWenMpmPU7FMZ4sqL
         C/aoLmfor++b7qnoxyaiaTHRzM7cflfnptSH96huSNrOc8aPSIbUoI9j7RArkU9aEnCH
         uqAg==
X-Forwarded-Encrypted: i=1; AJvYcCWzo0xQ7WwRJyxjBsOksHaqncgmy5dkYCMpyywzm5oKnOS7+vCNUhOiNz6qWJpjvE6js3+psAuYB/TgZMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3z7CUhos83IGw05zSHlausb4PcRYp//mdAiIUm8DVoS5zNiyN
	V+q3k7MGPoFUZ6YAWlItSMME0H9e1iSCyALeVifQwVreVWTqA5U7ZABz
X-Gm-Gg: ASbGncv0dspKbJm9fBeGGzxrmZH2A6mKu2Dc04SfdNS5KaEhsojJt2HDzda89m91RpL
	nfYChELz2yzqMnF36HPZaRhYwcTl8O8l6iIFbQq61Lvr1e/OlW6Xkf4BeM/uGPcIucErdh/Zd77
	/VKkDea4FyXXY3IXiasH9N3MTI+wvv91fLybbH9uds9SbSMNChMEbVEFQhQL3oYR68Zo1pPiDzN
	RR04UGdJgXILoXzJ1gglXbLxpfQAdQL65KheDnw/pJwOPONTYaiYjO1/XQ1YSJ8APF7eUPpTyto
	tcFGnqwRRhIpwStYb6Gb3hbhmzwZBRYyiq7auJfdzIquUtuZPAa9cMARPdl10QsIC/JNh/ETHLh
	IoHUCmmqSLQ==
X-Google-Smtp-Source: AGHT+IGXLlrycdZVZJcRoezmANRufsGVW3BlL+gThG3xVwVx9OCUap0alwdRq2H2BAG3+kdMLH28kg==
X-Received: by 2002:a05:6902:4081:b0:e93:4e74:598c with SMTP id 3f1490d57ef6-e94f64e4be5mr4684998276.10.1755713748597;
        Wed, 20 Aug 2025 11:15:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ea90ed28sm1641937276.11.2025.08.20.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:15:48 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	herbert@gondor.apana.org.au,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zswap: reduce the size of the compression buffer to a single page
Date: Wed, 20 Aug 2025 11:15:47 -0700
Message-ID: <20250820181547.3794167-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce the compression buffer size from 2 * PAGE_SIZE to only one page,
as the compression output (in the success case) should not exceed the
length of the input.

In the past, Chengming tried to reduce the compression buffer size, but
ran into issues with the LZO algorithm (see [2]). Herbert Xu reported
that the issue has been fixed (see [3]). Now we should have the
guarantee that compressors' output should not exceed one page in the
success case, and the algorithm will just report failure otherwise.

With this patch, we save one page per cpu (per compression algorithm).

[1]: https://lore.kernel.org/linux-mm/20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com/
[2]: https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.com/
[3]: https://lore.kernel.org/linux-mm/aKUmyl5gUFCdXGn-@gondor.apana.org.au/

Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1f1ac043a2d9..5dd282c5b626 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -833,7 +833,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	u8 *buffer = NULL;
 	int ret;
 
-	buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	buffer = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
 	if (!buffer) {
 		ret = -ENOMEM;
 		goto fail;
@@ -960,12 +960,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
 
-	/*
-	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
-	 * and hardware-accelerators may won't check the dst buffer size, so
-	 * giving the dst buffer with enough length to avoid buffer overflow.
-	 */
-	sg_init_one(&output, dst, PAGE_SIZE * 2);
+	sg_init_one(&output, dst, PAGE_SIZE);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
 
 	/*

base-commit: c0e3b3f33ba7b767368de4afabaf7c1ddfdc3872
-- 
2.47.3


