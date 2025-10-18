Return-Path: <linux-kernel+bounces-859462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34CBEDB9C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 22:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948B45E65A2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB3A2D661E;
	Sat, 18 Oct 2025 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dohBeJ7n"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68627B327
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760819927; cv=none; b=jGLCQ4DEUV2eCG7jb/04Df0HDFCnTa6MUv6c5G1oI2g4+NgGdhG3RkBWtiw/+tpGeTfjvlJHTazhuI77cnR9fn/ETcXOOs31gExzmMjkQJGxf8Ru7HHqmwtbI6TdM7YSETO5OBuvUrnNnggEygd1oPistrqkIr6BLzS6qkr3ZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760819927; c=relaxed/simple;
	bh=gXiDaLZ91cP4YS9lUPTJFUZXlsCNeyjYE1dKNW2Lj2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Df93nWugAoDJVrgY875sRBfh3BZFXwLXQChZPIIQeaO3fywnN10ByLsq9K3fV8pLBW4Mgf2eOZDuU7WC/XTS4xiJSlQ1T+K2o2gCsqryHx+wB0ntWML/3Q0S1kMpgt29tyfIzPe+jBCKDaK7ygZaHyJD5STSL8q23zVjYImaTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dohBeJ7n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47107a9928cso1751065e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760819924; x=1761424724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9i40smiRcDxizYgBMawCBNl5T4msgfFadm8b+kPK2g=;
        b=dohBeJ7nL4S2Q+Jrktq35YgWasEijVNyfNuXa9fhkjzwk7n37uc1hJxRgFPy+k8MPG
         TSCYd+i+uM777C2cs6B4b73JsgCpmSmYe/HCGlDmUvrlLhSvDbj/ADklJhOohkRS1UpD
         sN+8YGKF62AlCFgpLmxqhpZNhk79JQyB7Cw3wjyruO/ul7gc8/2q1iGLebF3GUSi0RWI
         T4/XRllU9LX+ULFXMP/a3aFolXEkizw52QrFpQyZuF8KQOnSc9/b8mfi8dyAmfe3+Tx4
         ClqNQzA15IupqB9PwsVkTaHrWlQCry+Q/0hQp4ekmoPBZoRagUpDwr+G+zkQjM8UN8rY
         JtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760819924; x=1761424724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9i40smiRcDxizYgBMawCBNl5T4msgfFadm8b+kPK2g=;
        b=wr3nnmlSxl0pSRdLRbv/VeyUpHvx2Qe+hkbbHYSZAvw0mn2lYPWcMmXSKjYHFfZ/35
         /UZvRDpetsd1EGjt6yUze9lpaCJlP1SWMXarB4AOmoZt7zovv174CSImhk/Du+RsUj1x
         bgar0neLSRsuiZtcCJwyjpsARwR12vXdUGWzd9VXp3wgOwxI3jFDiQ/PIaco5JxGP2QS
         tr4rqcClNAcrDO92M8h+Sl/raTwt5uwu1PjQ3//TnC4QjdaMC1ivUV8x3j6xBjyn9pdb
         Lk+Rr7Mna8wm7zKGTORlipbPyoBp6dKZQDplwDxUe0y50LtCx684jctzNwu++A2C0zro
         HNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+nC2UvR+a2ENd5pwTx2h+pyDd5V3Yb2UF/MS2C722qt7578MmddtS6YoFJvgqKa14c41DF/6wB83l9fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCFUTA2hmZvgnPcTxqbxxnD9iv7GkcXFHVgqajRNdxWG3QJwr
	qH9mG5MQT1FdqEcbyzVdbZG3tZD+ChJjcyn51M4aSO0CUj9hmxIp6DiL
X-Gm-Gg: ASbGncs1BV9gjqcB2mYv5gfsB1Ns6l/kNd3eM5oXO1GVNY3U5iXMGzIIgLxvAJ3zyf8
	u4tmLdVMdydHNYVHDmtA3BF0r4OPSm85jNoYw8+HZAdetQ3u62bMrGIVwRlcwkbfd7WD0B0aW3G
	qr7F1n7Q1hu82UssFPdZ9Oc6h25r8gXvpFY8w/rtlzf6lsHx7g3kJQjPQil3TU6SqHECI8dadB2
	FPLzazAUNDx3J0SEJTB1mwtDdI/4ZimQf98L6OiwnPFeiTNvhk/3CFpoJskEpxORbrBkElou3/k
	WOaw52PDL5Bk+BIsRGgEk8eyeFDGb4FIg5qGPB3YBQaCltzaPVMHhBiqvjGGDs8HzTEZblr94xA
	7yO2vZYk3VOD+7JIA8wFKl/xwDdoR5tbgBKo6+Fhm0/DXyL0WVeGZ9yasa5Yw/Jq1/Q+Ms7BY2G
	sRe7XdZ6iEIpbceuM=
X-Google-Smtp-Source: AGHT+IHI0fmt4JmUe22K1u4pN/SrFRoF9/x8jnxN9nc1hal9Xk8KmftD9LhBWGubiIcbdw640e+xFw==
X-Received: by 2002:a05:600c:3149:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4711792a696mr32181475e9.5.1760819923502;
        Sat, 18 Oct 2025 13:38:43 -0700 (PDT)
Received: from bhk ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm80372765e9.2.2025.10.18.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 13:38:43 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] blk-mq: use struct_size() in kmalloc()
Date: Sat, 18 Oct 2025 22:38:13 +0100
Message-ID: <20251018213831.260055-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change struct size calculation to use struct_size()
to align with new recommended practices[1] which quotes:
"Another common case to avoid is calculating the size of a structure with
a trailing array of others structures, as in:

header = kzalloc(sizeof(*header) + count * sizeof(*header->item),
                 GFP_KERNEL);

Instead, use the helper:

header = kzalloc(struct_size(header, item, count), GFP_KERNEL);"

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 block/blk-mq-sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e0bed16485c3..97b69fbe26f6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -466,8 +466,7 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
 	else
 		nr_tags = nr_hw_queues;
 
-	et = kmalloc(sizeof(struct elevator_tags) +
-			nr_tags * sizeof(struct blk_mq_tags *), gfp);
+	et = kmalloc(struct_size(et, tags, nr_tags), gfp);
 	if (!et)
 		return NULL;
 
-- 
2.51.1.dirty


