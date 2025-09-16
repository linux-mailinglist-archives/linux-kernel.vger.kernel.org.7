Return-Path: <linux-kernel+bounces-819082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24FB59B18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D02A3035
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8C3376B7;
	Tue, 16 Sep 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2vdxwJm"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2F33A034
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034657; cv=none; b=ItNRjhbdWdq52Xj4nZN4fLR7xVVKHHpbvdGdFTYiCt6yzoYk/eD6Ml5DVBl1bzdRoFM9D0rKjBDRZzWjfOsBu9coio/uenE9wTlqOTRIXVpoa+eeF5P1gW2JYk/WYRnNv9IMTGwdMtdm4hDld8Nv+R+4rNITZepy7CtR8Uc5c0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034657; c=relaxed/simple;
	bh=8palloZvosHrIgHRGThUtWJIYbk78Nd31FUAB6PjsBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXAQrnWiwo8VVUsrZlA1qzzebLqpfJXeYpETHb1406R62kr7vHv0LHCYgH8FxFE3NwkSTQyLpl5HifLMjhQ8fnleMWxYAkS43jMEO1URYQ41fxZpNIEcCjzRHko1lY1CxSdNlApJnt29ckBNBPaEszrLWl9+sqESBSCSp18xIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2vdxwJm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772627dd50aso7321407b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034655; x=1758639455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhPFazCfoeMydP8mh5h0YOREkSkQ/yfL4yFrVQbtIJk=;
        b=I2vdxwJm+js/OvxkMDblnnUDptNtPRVY0dWKzio/LEPnMkNJ7nKsFiaC66ztEVJ6T0
         LtIWhWrg4QvMG3zXNgJP7eA9aSBSwGudlQtgwVkHFJg9Aq2pBPr5OHX1KQ0VWBNxTxA2
         gri2kPbQ3Om7llIw3mNqeTFNZHDe2dJFRBSE9AIP1uu/IxXpjEF77AZiFI3UF9t6sxcJ
         FqJ0J5w+XoSRGXkqdJjF4tuDsufV2BkJYyzVN5P226TCduRsnFkkZd1oYIBlaMAceL0e
         plxbIbOd/H3wG8s53I+5N6bT3CjQ83/woad15fwLGJ/0asC/w0XLszVA2Un48jXPtqHi
         wbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034655; x=1758639455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhPFazCfoeMydP8mh5h0YOREkSkQ/yfL4yFrVQbtIJk=;
        b=O+aapQXYcqxYx4X5nlcdGmRQBT8xZd6w/U6N0ekO5bpOG2xTIhTXJX2gG9KxbwCACL
         ZijbwaKLX+fNk+xAfTuouq7fwsictGNFLEKKm4MQbuOxohsMSnSpCO4ZCPT72TcwgPI7
         uBh8EMc27nG0UeQIWBoGWHNP9MvfKI2xqiUr31AuWPJyg/lci12d9k67so6FOQoUuFNR
         O649q+sMUKEQvC7s3Djt/ilVNgHqvxdbtRRxifnxjzviQUeuaZGIuJalLV3E+zubLh4N
         wBijfXzzyuCFej/9dQzP88Xq7gII13UN7f9NPlrF5EXMqlwpLJ++w2FTTvr078suQj44
         GVkg==
X-Forwarded-Encrypted: i=1; AJvYcCWPnwCm1FqdITu0vvks9JGA+bupgge3QXrfsknLKK2toc4Rl4+tuVDrBGwNVvm6rjK6OM/Hg906nm28IZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/F2N9a7GZbvtbNeVJTrbIHDPqSXCOrqMSo8q7tlRF9oWf63E+
	35CshwXy4SmkDvf/OTVZ7thlG1oE6Vzdz2WdUuj+oCXRicmar+MdXQLW
X-Gm-Gg: ASbGncvjzw5uVDxOQv78SihvOXF9oANsM6jUA5ThfzbTaDDtPTsFuXmxxKiwU9/HeTW
	z53T9qdMvNeelTIXtUSW3L6SIvRToNRvxosuGyi8LYKjMPngB+F8/jpqEzXh3ac62DMfa7wwNCo
	n2i+uj75eJqRfjOjifc2XyAw8Vth5PnS3qCe8NgD9Be5AmuL4hljqlbXITxJ2j5wIsR6ZPN/BN1
	4h6Tzgs5UJW4fWd6kr5rkyJhc7YBr4JOb7uJLeEH6dG+BAUoe6CTqCRdMo9o7AfOEUDyuwcBr/p
	bJzdstyKNq3HB22uEVW1rIiBgk4P3POBhH4J/B4HxdGLCEemm8IRzkJo1Pgv/2Po/8fD/H2G1au
	2dpaXfwU/j/MDeTPv11Z3Sy8=
X-Google-Smtp-Source: AGHT+IE70dT64itvjVNcN+FspZAaHywtKEf5DdHLD2RGP4yJ8tS/2lNgczMINmrv9xvEqDqg18WQaw==
X-Received: by 2002:a17:902:c945:b0:267:c172:971a with SMTP id d9443c01a7336-267d15d7bb4mr43532905ad.18.1758034655035;
        Tue, 16 Sep 2025 07:57:35 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:6d43:6fc3:26a2:6645])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267a5b097f6sm48728095ad.11.2025.09.16.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:57:34 -0700 (PDT)
From: lgs201920130244@gmail.com
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nam Cao <namcao@kernel.org>,
	Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guangshuo Li <202321181@mail.sdu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: vDSO: check kcalloc() result in init_vdso
Date: Tue, 16 Sep 2025 22:57:10 +0800
Message-ID: <20250916145710.2994663-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <202321181@mail.sdu.edu.cn>

Add a NULL-pointer check after the kcalloc() call in init_vdso(). If
allocation fails, return -ENOMEM to prevent a possible dereference of
vdso_info.code_mapping.pages when it is NULL.

Fixes: 2ed119aef60d ("LoongArch: Set correct size for vDSO code mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <202321181@mail.sdu.edu.cn>
---
 arch/loongarch/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 10cf1608c7b3..da7a7922fb24 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -53,7 +53,8 @@ static int __init init_vdso(void)
 	vdso_info.size = PAGE_ALIGN(vdso_end - vdso_start);
 	vdso_info.code_mapping.pages =
 		kcalloc(vdso_info.size / PAGE_SIZE, sizeof(struct page *), GFP_KERNEL);
-
+	if (!vdso_info.code_mapping.pages)
+		return -ENOMEM;
 	pfn = __phys_to_pfn(__pa_symbol(vdso_info.vdso));
 	for (i = 0; i < vdso_info.size / PAGE_SIZE; i++)
 		vdso_info.code_mapping.pages[i] = pfn_to_page(pfn + i);
-- 
2.43.0


