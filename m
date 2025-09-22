Return-Path: <linux-kernel+bounces-826945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F08B8FB36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930C73B9993
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245C32857CF;
	Mon, 22 Sep 2025 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdtwv/jb"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF693224D6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532255; cv=none; b=soObkTrvNIHpzGgSzmOxdCskB1LGSr/s2aHileSwsc3vd5CFwS9XoN4l2CFiniO0Bq722WgeKkpElugQvqBUazJmh+fHv+uFqwy2ZQY0x7cUug4ENs2WwlDOQLZhNn9h8jl7BlrjUNvuwkip/AAG1De9iwB59b9t8O7sBN8V/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532255; c=relaxed/simple;
	bh=gUrGUJakgPzosFGigVs6XaFTjxgLzYgllr06uUiM3u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Urw8bJNmAE7bAAe/tSkoGtesr5RO9DdVJn20v1PXMjP8Y285IcmX+fiFClI8P88VsFRypxgZrfHt6wvBDTxBQXaJ5qOAgdlSzzvCl0cbirN5AVF2diWyL2JQVEFR9P+ZfTJbEmxFNs2KNGHYXmQiX5rWubul36QL8FEzi20ShDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdtwv/jb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f35113821so614241b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758532253; x=1759137053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6Be5B7JgVJk/GLRraqIJqx9p+yxvWVlj/0uensJ0pg=;
        b=Bdtwv/jb+axa4NiIm3Jk7Nwq4zlmmkovLnfbbxnLUzLCNI0NijgdR5SD0x7U3/sk1v
         XkKoPVkD+gSgB2K1xdaGag+e7qcpW/1zPRggZV5iR5K8KQGxy5T5kVNE7E2QYL7YQOk+
         qBjNKS9NalgQs7Jm8S10Zt8PUEPTg2yFc9phzf9UPH7vSAUoBTvNsWo35SjtJ9FO10Ga
         VZr2SHjtnySamWueRP6pChFocV6eTuZWDUhyRazMDPZUlzrbqHNwcbh/AEmYufxJ/klj
         HjEebdQAMJ0Ai54CsQGRGfmdxspOdcSkHr49kwT4/VX9CImF/J91EIm8yCQJRkPCxOsp
         g96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532253; x=1759137053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6Be5B7JgVJk/GLRraqIJqx9p+yxvWVlj/0uensJ0pg=;
        b=TzJ8JYs7BjaG5rHxTDbOYwm9417MxPURqsIfXn/fOA4+RtrOmYugwH2fJBDPIKO7pW
         10rwZSie8XFG2GVI6IgLfpLf91+S3R8LFHCj4OdAzt2VKkjpz+m2srimcGsEYY1RVzLw
         JGew5xydtGpDFcTqsDZy23GDcTnpg1lxXuf1Gx/lkifXke8NFB0tmvExzoKhYpL6r2UL
         bq8YrPhXoNc9Oi1nsXFf9JYlYiFk5czgjobnHzA2dJCOzs3NFG8do5DJaDFuIatilSU/
         V4YyqDNb8Lmn8VjWws3oGKO8mFVfJq+ifYWpcluKpxPzVIsDJDmk6vkVAjOGqqZanQYn
         W16g==
X-Gm-Message-State: AOJu0Yx4snxm4QJ+cqk8kBM7kmbpcV3ksahOMFMYcVNBDxKzYonAQZYy
	S9s9Xt+Jw50FBamjf/C3dew3OkGLDwZ/h2brScX/TFtyTzPXDEHqF+fB
X-Gm-Gg: ASbGncuBD5hSf25yNij5iOq6ZkYUW2HNwwCTvllGb9a5d3JwXtiTU+srg3yeJuxl5Ta
	fpUiRUWvQyimxU+cYM2nG6D7g+f2qUhKXO3p6REPWCfipLd4jX7j4Dzt1kg70OWhRt2et3JLYq8
	lDk1Jx+uSt/6PzmceVie8J8a9YPfWhVxZ+eQ0RgB/s7oEDZ1p3zPSSHVcha95z2fyAw0fvPfoMW
	sxsGo+NXiRDLoWWkejVoACRSn8q4TxdjSxyf15K0Hz4WvBsefpZZADXRuDgvQxuNzvmywz0MwEA
	Y3BHIxkAEhxuSsYfxyhSLxpYqglsT5ykDDtPkFK6H8Chsc2KHKF9Z6WRlCS4LvovWozWT+HkHqb
	eAjxCtFqJBXUe8mAJzQo7yCX1
X-Google-Smtp-Source: AGHT+IGOJce+qqy9vWaSkzQ7B5SitoIzZV0BK+drOi40fTRQuov+y43GMyhTFnomgzYjfXxBRox77g==
X-Received: by 2002:a05:6a00:340d:b0:77e:543e:3f3e with SMTP id d2e1a72fcca58-77e543e4318mr12853674b3a.3.1758532253047;
        Mon, 22 Sep 2025 02:10:53 -0700 (PDT)
Received: from archlinux ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4190cc8dsm1393548b3a.2.2025.09.22.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:10:52 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH 1/2] selftests/acct: add cleanup for leftover process_log binary
Date: Mon, 22 Sep 2025 14:40:41 +0530
Message-ID: <20250922091042.149117-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kselftests generate temporary binaries that are not tracked
by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove process_log
during `make kselftest-clean`.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/acct/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
index 7e025099cf65..16eb97079e63 100644
--- a/tools/testing/selftests/acct/Makefile
+++ b/tools/testing/selftests/acct/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := acct_syscall
 CFLAGS += -Wall
+EXTRA_CLEAN := process_log
 
-include ../lib.mk
\ No newline at end of file
+include ../lib.mk
-- 
2.51.0


