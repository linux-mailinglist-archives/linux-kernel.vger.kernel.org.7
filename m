Return-Path: <linux-kernel+bounces-872365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588CC10675
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567AF565854
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CC32C92A;
	Mon, 27 Oct 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D924BZvu"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B832BF52
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591197; cv=none; b=OhPV/ch1UOlz6FOu0JQtChf+hwWw7Iqv2D8aTenWlZBKiVxCMQBXeuVvx/25cUYc5ma1WqG0ePUo11o1HvK/0sR/k8jDUKDqXVkLDgbmYcid+KUwgIBTCvYdzyy6sS3llZ2FopH8FlJBDIRrbVXAtWKWtTUwTXdQJvjVYj2wRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591197; c=relaxed/simple;
	bh=KSrjpQWLlo7qWoMgoEVcWwI9goWqizR40Dk6Uu+ddaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ay3zyUxQMNAsyrShrAFo3wMT8b3Vnqjpo3sD7EFH/A5pF8KvmQMkgwqmBWdBLfHzX0SyG5Epho5hkqwuWDYcz7/Bb6yxhxJgYs/hRcqthm+s+nNKRMTiWRf29j3fGvGRKLIzNbgD6ylJWFFz2uvfu4icivpriWJEusD9SCnNaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D924BZvu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso4167633b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761591193; x=1762195993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bk6bvsNBoenChOVDp2tPi0ck6pdyly1ce3AeV7V51LI=;
        b=D924BZvu/c/ZAtsuMbZ8eA4pqzapf0K4Jfz+UJ3FARVSJEiDOO/XGX3ZJozktNDL05
         JpuYbW5QzyzTK4HZ1LUlcgYZZ6TK56+hVv4zF4wrUpxxbFMWU6BY4P10IUrlfx3X+blX
         OTKgZGL3d4s7zwKP7GuMj4J0UQykMArE9oCDUCDvZt7FCcIr6quwZhP+/o5CsVZK5e0z
         HdHbBALIITdgE7BdIi7M1C8G7JyGR22Rrq4yqIsacMDAjjF4sFcvj8dn+0j70NQMChQ/
         9AtIkQ0GelSIlpzrW7KW127M0Ody1ytL3SQPs+Zeoqj5nRLhlNXY9FSHSWf3TNxCC1Ch
         d+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761591193; x=1762195993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bk6bvsNBoenChOVDp2tPi0ck6pdyly1ce3AeV7V51LI=;
        b=P9Pg5I9sYp4ysjWPy5R2TUxhgPlXdc+hV2E1UZETZyESYOvBFaGdBjAcTNW7pczzYu
         0ZQndxIOJlP+Ji+cxaOV8VCplAKJgsWvUFIxuTU1g/oVqxqm+nvz1vNRJ61gnheW5s9M
         xdcUF2UxZf4SLMKJGYJERlHdOsGV56YoqofLAHdVnNYbwNuC0buokNbP6jBf+2Q55pT+
         50MEI/fK/ARBKIw5Lfs74IugamEnHA7Kiv91ZMKIDUvYQwhu6Z2/uIhKuZEEZMMAqAX6
         2x9JOfvYtEFWYGxMO1cY0EBsRL0rjnYS2Xc5hRSVBODFAOcgGxwV6yn+p5Yg/jx9eWDA
         ddJA==
X-Gm-Message-State: AOJu0Ywg2hnF62y0IkXawpnOCvqHKl13u6h5/FfhZ2YMsXFLr0cgzKqa
	7BFMQBVUkj6NIwo5sq+8sLN3UNPMuFlvIJYLJ0QYlCa49ljDhQht/5cdTom0Zw==
X-Gm-Gg: ASbGncvSKhA/b2LbcDS7Xg9dExpGAQ9vzfm73KmrE4eaVzLufqs19QfFbn+baYwddVC
	4wYA0u0CRPMxCRtU0MX10ms5ZQG+RpfCMhbkOAtDo50h1apnd4Z3CLjsX2TGxLduF6QX4J5/1Iw
	UbvXYhi/eyfW8YYKfNMs0EbhB1p3S1CuNuEWrouaRZ/PXxzJXgdyacI67F7MY2bT5e1Xuc8ikCC
	LWzZ8mleiNFbZpx+aPh4v0iWxdVsUuPdoI9f6NwHWFCGfgSHoC/aoSTCPbMdVjorJszQP4IudEd
	pSIMKq+uyC20wRbyl9Rc768n95Zt7pT9w0Nth6fORYo6IgGB3nfdl4UYvmBcNt/TVl9qkVBwApF
	C4LdEX4vqBvyzQ9oolEG3rsqHytl2gYJF14J8E2W8vDrezbNu1oefON91KVzDU7XZGxB/i5Q2EY
	iNF2/yR5o4XT085ZoFmen//CM/erehVtXRgeW1+CtfhBpCGWwl0sVuD0HjJIFcMtfhd2M=
X-Google-Smtp-Source: AGHT+IHtqBwQ88KSxBNo7XbFYWJmfdhMBzGzf7xaGwOOctLHUUO38sOxlwfjnVVZAa5qjo4IBiY99Q==
X-Received: by 2002:a05:6a00:21ca:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7a441c2fa3cmr1122645b3a.16.1761591193121;
        Mon, 27 Oct 2025 11:53:13 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:88a3:d9a1:52ff:2597])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414035ecesm9023093b3a.27.2025.10.27.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:53:12 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: add a missing device_alias in the feature table
Date: Mon, 27 Oct 2025 11:53:07 -0700
Message-ID: <20251027185307.3680345-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Add a missing "device_alias" feature into the feature table to show it
properly in print_sb_state().

Fixes: 8cc4e257ec20 ("mkfs.f2fs: add device aliasing feature")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 include/f2fs_fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 6f3f83a..88a854a 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -2022,6 +2022,7 @@ struct feature feature_table[] = {					\
 	{ "casefold",			F2FS_FEATURE_CASEFOLD,		1}, \
 	{ "compression",		F2FS_FEATURE_COMPRESSION,	1}, \
 	{ "ro",				F2FS_FEATURE_RO,		1}, \
+	{ "device_alias",		F2FS_FEATURE_DEVICE_ALIAS,	0}, \
 	{ NULL,				0x0,				0}, \
 };
 
-- 
2.51.1.838.g19442a804e-goog


