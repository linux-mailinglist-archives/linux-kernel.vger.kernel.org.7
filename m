Return-Path: <linux-kernel+bounces-845817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E8BC6367
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBFCC4E8EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD62BFC60;
	Wed,  8 Oct 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0MiJAIu"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30768248898
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946094; cv=none; b=WuzRXKTdQkSpgSpcigJD8HpwOPPu5XNsdxwYaU78aZPsgm7LZJIt3Sli8lbr+8lu2BatUN9LyP5u6cwkoiNDyl8YnbBdokf4rScWdlYeO582HoJWOquQZ6Ovk2qeITFXLfs1EnR/ABBhjLt3gcgoOj7LyQd2hKyzHtS15gCkF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946094; c=relaxed/simple;
	bh=1WUetKlauk9q6CO44k+lrfotpDff1uajdkaAQjZEFho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmXraLfQN6/0D/2Z93xYfiM52q9KX03m/iRGqy82/PfEv6q+b8TKvnkDiP1foJKkO5NkrRQr0qUl6DfuFsBDwe5zkqWRaXNcuPpKj3iDx3pK1Ri7JNQJpHVMWj2z6MHwf85Lm/ykxL2HSaMEKRlLfTdmlZIXYGA2oT9kCRm8e7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0MiJAIu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so127097e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759946091; x=1760550891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+NzArl50yruflBXWfUivTM4ljt6tZKIzBIR3VQtiao=;
        b=b0MiJAIukEvddyaG2XlhpEpgP6izOP2i5tlCjkPqtS5Jjbwb3GrDLK5N/Sjw4IbTKC
         gFvanMiJO80EBoo9BC84mk65l7k+enB/w1/ZqcwrxC8Gi/AkrDnbwUvM8W05bfpkbtXi
         nrwNa1p1CRhUbq5SJ6sLbGpVtKyx2T1CWGfHIAM9xBp7ul4r0CHd0dqerTYA/ROFOMl+
         q6PbPkOL8rfvOS9JglHM2oGDWdON1oX5R8ffnlIedmRIsrIqJ6IuolRPHfgschJygzeK
         P/7Q4sev30KPHCPU76QIax8p0xy7fq4V6FZxD5xKZzRRH1dY7nUDG0WowHnItSFA2JP8
         WUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759946091; x=1760550891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+NzArl50yruflBXWfUivTM4ljt6tZKIzBIR3VQtiao=;
        b=MaE5Cf9lvNT7fcavZBrMdy157gNeVkabmu8uYa38HeeR4LTcz10p1O2z3Qjsjydbsb
         r47XiL3Vr2FNvMoMgfSghdsV9O4UyMA6lPgLnLi71yqIfgfNJn6ZwGCNgEglZZ0i3gmH
         3RA4mHkddU4ckYUibyJzBTczIPnwWHPCyJOTPN89lIFgWGY7jC/+gmAN6ncKYabq5Qaz
         EIloxs6tbzYOYocEBaKlzOG5LDZIB+sEIMTvq5AxlRaTy4ubErQ7s/WoNAYaGsvtICnX
         ztcZCvIkRWN2tOjclSGOqOnsQ+nejCdj8qE/fE/C69M5lRxMbhfxpwq/2+CQMhxAWIR8
         b7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsB9KKMlqJ3x7POyDRbAGC4G2YSqSVo0v3TDEYkUCf5FDapYl3bQTGWtHBha3s6uATEJ9pqmNjtLdzNsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cl3cdIQ0piW/waOVRczokWihR7SOjdf0ulTeIwNp+2pAbp4O
	7H5Px2VCYOtGE4BFbX6KOHmcDbWHeCYZUXwWV/IdHzfckwz2L3a/1ph9
X-Gm-Gg: ASbGncskPE9GzDujWbqSEWuvPJjErpArv8J6Ro1XiidlNEDHL2wzcsUBQsT6m9u7+wb
	ilLXjrPUyl0XOMOaJNfoO4CuCZcN7M3NP0yc9ven3SQjdr8BP5oNUYnP6IRfUDxDQw6LBOYDWGp
	JVUak9QRE0Oi5KCFBlzOgfUq0mx7SXjvvwBHVobqZngpchS56cCSBq+aa2gNgTutVH0tcgsb7Bi
	1DR8xYHZa3caeuSE/dhyndoyceNJ1PbG46FeJrQAGopYLgNFJasK7HV6FjOoqbBEnVrKNaXuk7/
	G1ZUdLWcm2TebPew2caez6CNJUtaJsMJ77/9KfNtA2ocKZ42IAWEUD13KDN9e+9bbU+KWJqLN8+
	GWsFXHGdFcO0vehBoC3THgrh+hsG9vO3wZrSh8OGG5t6UENqw9Rw=
X-Google-Smtp-Source: AGHT+IHM0NlTwwUD2u4rFj4QdyCJdyEFBmUvYHEYRI/8BI361StlcHHVYHMrg98b5LX7XSOPdJfm6w==
X-Received: by 2002:a05:6512:15a5:b0:580:e43b:a3b9 with SMTP id 2adb3069b0e04-5906d88a399mr1136485e87.18.1759946090902;
        Wed, 08 Oct 2025 10:54:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e010sm204634e87.64.2025.10.08.10.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:54:50 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	LKML <linux-kernel@vger.kernel.org>,
	DMML <dm-devel@lists.linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] dm-ebs: Mark full buffer dirty even on partial write
Date: Wed,  8 Oct 2025 19:54:48 +0200
Message-ID: <20251008175448.342614-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing a read-modify-write(RMW) operation, any modification
to a buffered block must cause the entire buffer to be marked dirty.

Marking only a subrange as dirty is incorrect because the underlying
device block size(ubs) defines the minimum read/write granularity. A
lower device can perform I/O only on regions which are fully aligned
and sized to ubs.

This change ensures that write-back operations always occur in full
ubs-sized chunks, matching the intended emulation semantics of the
EBS target.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/md/dm-ebs-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index 6abb31ca9662..b354e74a670e 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -103,7 +103,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, enum req_op op, struct bio_vec *bv,
 			} else {
 				flush_dcache_page(bv->bv_page);
 				memcpy(ba, pa, cur_len);
-				dm_bufio_mark_partial_buffer_dirty(b, buf_off, buf_off + cur_len);
+				dm_bufio_mark_buffer_dirty(b);
 			}
 
 			dm_bufio_release(b);
-- 
2.47.3


