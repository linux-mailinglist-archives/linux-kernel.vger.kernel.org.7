Return-Path: <linux-kernel+bounces-826739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D695B8F3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604D616E739
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE2B2F0C50;
	Mon, 22 Sep 2025 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUV0M/qd"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355791F91E3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525123; cv=none; b=TH0EY4Wsv1DKJaDARxC0vZuACBRm6AZyu2mNWNjp2xw2C7CXYuirA6IJlUVsqv1ZUEOc+KtIhKBgCqSkhpOvjj6HQioxTl01JevfeibrRGaJHQa5ig81PdGrwIh6iAo06O8KaYkMDv22tHecFWh82MjV54l0CIrRVMKjpA06hG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525123; c=relaxed/simple;
	bh=d/ugOaQrlaY7PrdpD8UD3GGiibqpO+25BScz2+luv2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuqLQIohzWaW/32ZQIgit0t0FrWpTdfMqGf2ICPad2pgDFU+akA4BaAtuW8wDrXHXc4mXiy/j5W5DS7eT/leKAU6V9ExTUsKzSPgtB0FB/IL6+tgTBBzR9AMImOoItiVIky7vYhfjxz5da+S9uSbxSL6m22GNFZ2zQbOBcvwmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUV0M/qd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f38a9de0bso540590b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758525120; x=1759129920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L51uGeNa8nacgso8hnxd+eYLYxlc+LmoJqaI+35rjr4=;
        b=cUV0M/qdtAaNvJBYJJI77jqqgtkMbgL/YWIe7Elujb8BU7h5d8HC/ff4ZZNjnZOt/F
         rBOp7wyh9kFuwYu1aY6/IUWvkim3lLe3vd0fYWspan6dj/1e/npwhqXD6+W7E/dugIuV
         u/5D8SS5sveqFfJMm/UNOqGRKONSLtzgQnxyx4G6TelRRERZBHzIXD86cK9vf8smYm2s
         +c1UgRKgPCztRqtMg7hHLfZ1knwD1/3hcXgOpdQMwJXJBLBB2vZZ+KABgSdXSCV5ywkO
         V6aVLvGbnuMzQzU/NfS6OHxCTtyp9EFXv1IliXoIkWJJRzICkLxFrrbOuOl4bEB6azJn
         bSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758525120; x=1759129920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L51uGeNa8nacgso8hnxd+eYLYxlc+LmoJqaI+35rjr4=;
        b=wQX9j+1au4dfK1K09pt84QPAiHAFmfwD+Mv+UQKIp3eUQu5pqFGpNE3kxdDSUwkIgs
         mAZMvJzf/Z4wDEnWKxllxGsPWhoGX4y5/oIIMqiwO8pDxchkUskaHSxj72ZXg77sOwqC
         oczcuLrEpUJyLav5fy8PsdavYH/iiqpdv2IK/0Lt/eKt9G72MfrSKKFu1lK2vx9ag5LJ
         nrVf89i/Fd1NerEukoR1plS70Ue5WC06JAATJjEvaiT/NfkJVc35K02+b/+0ijJ4OV3E
         8U0Z71GEuderIb+l+xoMzTLc63j8zpIOEe5Qwta3Mba//EP3dmMMof6McSRN/bEJULoA
         RvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsn1nxu9/XYaH0B+BnmqqprBSoxj5ERnrEBCFEzePwY/lp9hnc0coO45sMpVFfB2KeF7/IiLRMT9awgco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gM89ofq79SecIXoJov6fcXs395FjMtptMv/LZDb9xj7lcZ93
	HLEqI+ykwHOqeXDcvDwGG2JVeJw89UVaPAwIlCIOKsRQYx3qrkK1BQRv/cmoLNIy
X-Gm-Gg: ASbGncuIbl/9SREmDASE2I1MLRF/g00wsVvErYyMwmViJpbAyptM7RosVimhGU7TKTr
	f+wih/sp3ivfacgKAYjxakMPPZ44ilrKERygYhxMktuxiQ9H11JBCuoV+0IyU92qw9yj5cDqRPX
	WwZ5R3fo6T+qvYIAZAygNyHhTJ4zpe4sYlIt8Z0dZhuzDjncFckm+ybLFeCsME/XemIUyEzWDos
	TNu4AAP+byeA15Db6H9Odg5gQeSnutjMaAqIzUOBjvxpuOz7vkBSV81BdYKgroKE1X7Ii1r6pVG
	h+FUQUFMCeS8sdEgm4U0W+HjdMwkS+Mb2i7y9ZtWGf7Et4ndildhViFEDi3D/CR43pu9eG9K2LM
	BjVvHHgyrYJlr3io4WOUj461OLd/ZeCzF+uCh
X-Google-Smtp-Source: AGHT+IGwWT3qJv0Y4pAO24DRMgTrXx/7yCgl6MFgRf/c+ull4dMi9MomeuBzlvjoE4YW64QkG7MHMA==
X-Received: by 2002:a05:6a20:e212:b0:254:b352:6479 with SMTP id adf61e73a8af0-2926e37bea9mr16802983637.32.1758525120401;
        Mon, 22 Sep 2025 00:12:00 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55149526cfsm9017341a12.36.2025.09.22.00.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:12:00 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] mtd: jedec_probe: use struct_size() helper for cfiq allocation
Date: Mon, 22 Sep 2025 12:41:37 +0530
Message-ID: <20250922071137.900508-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against performing
dynamic size calculations in the arguments of memory allocator
functions due to the risk of overflow. Such calculations can wrap
around and result in a smaller allocation than expected.

Replace the size calculation in cfiq allocation with struct_size()
helper to make the code clearer and handle overflows correctly.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/mtd/chips/jedec_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
index 23c32fe584b7..a5d1137ca5ab 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1985,7 +1985,7 @@ static int cfi_jedec_setup(struct map_info *map, struct cfi_private *cfi, int in
 
 	num_erase_regions = jedec_table[index].nr_regions;
 
-	cfi->cfiq = kmalloc(sizeof(struct cfi_ident) + num_erase_regions * 4, GFP_KERNEL);
+	cfi->cfiq = kmalloc(struct_size(cfi->cfiq, EraseRegionInfo, num_erase_regions), GFP_KERNEL);
 	if (!cfi->cfiq) {
 		//xx printk(KERN_WARNING "%s: kmalloc failed for CFI ident structure\n", map->name);
 		return 0;
-- 
2.43.0


