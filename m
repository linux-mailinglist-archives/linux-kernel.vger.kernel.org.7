Return-Path: <linux-kernel+bounces-748919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1FAB14798
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52864E38DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74A2367D9;
	Tue, 29 Jul 2025 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXMsHkyM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F622D4C3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767250; cv=none; b=CIeldhgUxA4SlZ+qFDareKv6oSPMO/bqRsO3cL/6wI8KK7FLRjzly5AF59z0RvrPz7h2iVI1yac2Z2+AqpXpsI4NUqUtvfzdfxaZ3pzuMkqo3+pvc1ca0umjEMOSYABcSR2jqswsvaekyk4hegnhr3zcD/JY0D8sZKzn6QsOTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767250; c=relaxed/simple;
	bh=407w8iJwHF65aYeYyY26wEE5YIVGSOKIEr2PIFVDYMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmqcwIOdXLQiLnA8S4ww2ysmU31jeWb6xoKTyoiWNuk5qqL4Fm7HwHAWEVhwBrxEZ9yi7pnCcMQ0o7x/GfO2BjwYTxt4ryHAHVjKglUbt9BPb/3DIEMKkNtA1F5sd+pFtHRvd05YhpzOiMC/U/8E6Na2RibMGmFsba0nbQhLom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXMsHkyM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23602481460so52715795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753767248; x=1754372048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8xL4Yrb+0IGFRYrAfHaHCJY7vgDKKICkeDH3Pk+l+o=;
        b=DXMsHkyMrMB2p5AQXOOXXVIVvUR1ihaaDrfPGr3MkbmTfVkwcjMelR6qpzog5iSYA3
         +3d21+xQVHSC/t7R/nsSI0oT4Pd3QGtKG6BgSdxj8W3QABd5B6OahCMU44f9tRmQT7uD
         tbfDYEzIW55+7ADKnGn545/bxj9isfazIc2Sirpo9QVSwF0jNL3HIfliFAbbRREChYo/
         mm/O5pdeoyHSlyU7+r1OmJiKgO+Qp+hFlu88RyhVajdOiSXX6VWh6KETkHFWNurgSWiE
         Pd/ah5z52S2JPvisY675Ne6yF6Lcpa5KWGli1iPHAT2djaUxBuAFSlNHh2m5lLs6+Nzq
         JrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767248; x=1754372048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8xL4Yrb+0IGFRYrAfHaHCJY7vgDKKICkeDH3Pk+l+o=;
        b=IiGBctBpvzJhEXLrtI6cskybOa7LRZGVyDZIQwdxh9m0jY9po2JYoLWUVlVzZztZFb
         IUGd9u+JM0jEVq4JL2J3rF+rAVTTkPILDHbNNe0eCt21+zmsyvMMXP8Z3rc43OXPhGB7
         Qxo4RfXqtQmkN8rU265tzY1pH5T4P0MuBg6zlcBLAv0/6HNJYtpOmN3GCWvk46jsmZ3q
         3VR1MeeVF3+9uatRCVPHod55xSTqEMXG2H+9dNm8mEzqUCiARJVxlBu7zawqbwJ0FwDm
         6hhVXMpS8N2MNqGCW05hmK/cUuv8oaGq1j5utPOZ3aWT9ITtlgsIFoz7OLFzCrbjRThF
         vCnA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2yULdJ3u9QnHs0AYGBrOw2R5KTFWTag+Hm4j01VOvnLcrcMI+meZVCtbQ6V/qyHh5cQAboREjvSlO4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzsy0aGRLmrXQwqvQBf0ZRLRJ/SU5LjF1wFp/55PSZ6LDil9/
	rXsM7be/nQWKPZaHqlijwpEdHgSzBMhpRuvMS2qLIHNd3dQPbCXyDYM4
X-Gm-Gg: ASbGncvtlnOu3S/mUCI/FsJ+ZYE1Om4xWxtbUzIJS0s6N9boPqFSGbiUU79oN1aV+5k
	cbZarsB9iwZX4O3XVJhhe8q0kRkXDMNuIFMViec+SGiNUVjqg1bBh3yIRc52pi3bmSby+ObjVt8
	C05dumOwrVVs1SHaqUXiLKcrGlZzUbAGfpzktplQ7y9ASdpXVjtPgQX0yBnN2I/hyZvhHzpQ8yj
	jSnFRZP1fleQoqfW7NmAV9XCdF4YRoGiv39r1MUIVTXx8HU1I7jgA59EwGRoeQjvCjKltco6H1p
	b4DgOnfMJ+lxXEimfrBYs5dt1yNExi0M9Vcl3A+Ptt1EFmVX2/tyeAvrEdxGkXNWwwVT7JaxXvq
	vJRqixF+jZqjUcP9C1u2f90niOsxzrA==
X-Google-Smtp-Source: AGHT+IGViqHw3UAn0Jijm3ozP0ydhC4t4Hj6GjIEoXTf5RsE/+YsmXg5Yr2FXjHy15EhU7Bar+Z45g==
X-Received: by 2002:a17:903:b8b:b0:23d:dd04:28e5 with SMTP id d9443c01a7336-23fb31254cfmr201529785ad.34.1753767247926;
        Mon, 28 Jul 2025 22:34:07 -0700 (PDT)
Received: from archlinux ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2404d3f6241sm21364745ad.122.2025.07.28.22.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:34:07 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] tsacct: Remove unused macro definition
Date: Tue, 29 Jul 2025 11:03:59 +0530
Message-ID: <20250729053359.49258-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MB macro was defined in tsacct.c but never used, leading to a compiler
warning. This patch removes the unused definition to clean up the code and
suppress the warning.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 kernel/tsacct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 16b283f9d831..0fd7ef291454 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -83,7 +83,6 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 #ifdef CONFIG_TASK_XACCT
 
 #define KB 1024
-#define MB (1024*KB)
 #define KB_MASK (~(KB-1))
 /*
  * fill in extended accounting fields
@@ -119,7 +118,6 @@ void xacct_add_tsk(struct taskstats *stats, struct task_struct *p)
 #endif
 }
 #undef KB
-#undef MB
 
 static void __acct_update_integrals(struct task_struct *tsk,
 				    u64 utime, u64 stime)
-- 
2.50.1


