Return-Path: <linux-kernel+bounces-761414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9DB1F9C8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 13:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767BB1790E5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B7248F4B;
	Sun, 10 Aug 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqwz7ETC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7E1AF0AF;
	Sun, 10 Aug 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754825440; cv=none; b=EWsZzHyMRhFChPpjyTfCGlsZrUe3tjieeNRTKsATGcyxd1kF5l+imIBYL/IByMDPQdPCnf9sOSb7yhVHTF8E2eh6boyp9O33/H6tEEzEvHb/XgoBnal04EyKWeuVRSkcwsFp/lcVI3k/bzXc3XpStqmG2UCNW+jrGEzPhQRKanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754825440; c=relaxed/simple;
	bh=hQFUiJVkuiVnyTmM+Fv5SEJ+oeDwsytX/0vH1GdXtNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1sImK5/92vWijJr1vFopjveMWplZm8NIBB+Kt3F8VxCTWT2KLCA9kyvtuPzWYGYgZxMoBxlpVSg4hhDD9flqKjpWyUMu+DrUq5qZFKKAI/qXpzS//wzVLJnLSUqwJdyXwSJWa1Np75HUKIuUHE4ReFZmgf8OkY9HZ78voHLHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqwz7ETC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24099fade34so25017275ad.0;
        Sun, 10 Aug 2025 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754825438; x=1755430238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SHl5buntrPd4REBXQ/H/Xwm8L4W6B7MQuY5lUwVZl88=;
        b=iqwz7ETCGNLG307H5PccICa0I6MfeCfnEwVBBiwv6EFmPll82goBNkYGjsNfBYZ5nm
         OySdI00WkWHWREMQ8XMLuxSnGavMEj+cRFRyFN167g5Sw8oIBB/LEvHQ+bk5oTRKYdpQ
         XDKyvK+0H38BY4vFkRdWciQpob6HTproToHpj4NVgEBJJUZ9dfwwOxlEM0f/yef08Daw
         SW4OsVqVkuGKislbasG+ZFN10M3+oZcyHR8SwwxRwH6QpUHKz8TfBeflku/8Ki9m88z9
         zGMGbw8WN4xwktFjNnHySSaIyCpoj+iQ09nYpoYqQxZ8L7hu+k9DTHJ4sgDeVAKkjr0y
         LIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754825438; x=1755430238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHl5buntrPd4REBXQ/H/Xwm8L4W6B7MQuY5lUwVZl88=;
        b=Cqnfq8fWXU1M/CV2ioxVyCqSawCPrKVKWLx58rQ4/UxxZ3jl2/pN6pJK9edrLNHnqj
         Llzsi52AVw+1MNmxRZdiJmVv7DP79VhkQQXwKm3n19bQZ/0V63Qx+JSOFBVe6iPDuGd2
         r0Lh/IYehEzTDOAo7mE5ktvDSf7dDr4J4tH38DO6ya4ku1OgOBh0KyEeeGEZNVOIYxVN
         Lr0i6szOaUROBCHyDcD8sYasgDZ0Leke4Bytym/LcH2rXie6vNZ97mjXqBuGyCnUAnVJ
         RfLQdzj404lGYiWph7s+swWsk3DAeIgTRkeFXdWgigHyWFLDFxESd1UX3Fmh7dDbjiBS
         DI+g==
X-Forwarded-Encrypted: i=1; AJvYcCVWShNn5xnw2qiw9EGvoVxlKHPgIxVZuYNKKkwBI9wb9ojAwMTc9nxZaH4tP6Ml87ENCLXI8p3GxV1/le4E@vger.kernel.org, AJvYcCWoLIfUceWIXTl/VwvPOPt9X0yjD1CsBo5AxpNbhZtQTZ5mA2jwQf6/EZyKGqh5qe8pKp4PnAviDmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhU5zx2Vn/B2eK3L9zxI0wrcs+46CE+xwbnABM689ualCm1hta
	EzhRNd/9czQ5SlERUVfo6wjQEs+KEkGL2vtuBFgQkbvxXvaghVUdlCBO
X-Gm-Gg: ASbGnctskRJRfCSuRgZ6paEOqgA94SzxEHyn1VSEln4bRiyFXW/CwXkuKBDuN55NwL6
	GlerrP+y82bZyM3wXiDSIuNhu+iWBEJicI1B62HmyR9UMVxOEPPz0XY9hi8vedLMWTRyKhP0ahO
	gV3zZdlype0h9q1n+4dtuPAQm9/UCH0AWx1h8A+kKisfdyraqtIMUOtuLvrQU04posoFf/OtEfM
	5kLOtTdoqtsS4AH9ujm7x7dKWtYHAqs/uQY+o+ZypAXyY4+dRU3b6bwsDT9cHSMxcn73m8RbqB+
	zL+yZHD+g0bM02OetkXBQajH/FdpwfVhLco4xFu8wp7cC68/YpuO2XSuSgzMtsstBii85xTrFiP
	EYe7zoT+sb091AsmV+hc4w5SJb5Kb4Ky4jwN3zw4/yu5lGSUNR/Ttz3PZwjxg
X-Google-Smtp-Source: AGHT+IEddxsLOd/KSWuIkQ8MPbH9RPfw7fHsY7z+FeE8UayyoT0bDzrRE1sn5q+TZ+gTV5c17FWunQ==
X-Received: by 2002:a17:903:41c7:b0:242:b315:ddaf with SMTP id d9443c01a7336-242c1fdc0a3mr168124875ad.7.1754825438182;
        Sun, 10 Aug 2025 04:30:38 -0700 (PDT)
Received: from shubham-HP-Pavilion-Laptop-15-eg3xxx.. ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5934sm247615075ad.21.2025.08.10.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 04:30:37 -0700 (PDT)
From: Shubham Sharma <slopixelz@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	corbet@lwn.net,
	msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubham Sharma <slopixelz@gmail.com>
Subject: [PATCH] docs: device-mapper :Fix typos in delay.rst and vdo-design.rst
Date: Sun, 10 Aug 2025 17:00:08 +0530
Message-ID: <20250810113008.27381-1-slopixelz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the following typos in device-mapper documentation:
- explicitely -> explicitly
- approriate -> appropriate

Signed-off-by: Shubham Sharma <slopixelz@gmail.com>
---
 Documentation/admin-guide/device-mapper/delay.rst      | 2 +-
 Documentation/admin-guide/device-mapper/vdo-design.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/delay.rst b/Documentation/admin-guide/device-mapper/delay.rst
index 4d667228e744..982136160d6f 100644
--- a/Documentation/admin-guide/device-mapper/delay.rst
+++ b/Documentation/admin-guide/device-mapper/delay.rst
@@ -18,7 +18,7 @@ Table line has to either have 3, 6 or 9 arguments:
    to write and flush operations on optionally different write_device with
    optionally different sector offset
 
-9: same as 6 arguments plus define flush_offset and flush_delay explicitely
+9: same as 6 arguments plus define flush_offset and flush_delay explicitly
    on/with optionally different flush_device/flush_offset.
 
 Offsets are specified in sectors.
diff --git a/Documentation/admin-guide/device-mapper/vdo-design.rst b/Documentation/admin-guide/device-mapper/vdo-design.rst
index 3cd59decbec0..faa0ecd4a5ae 100644
--- a/Documentation/admin-guide/device-mapper/vdo-design.rst
+++ b/Documentation/admin-guide/device-mapper/vdo-design.rst
@@ -600,7 +600,7 @@ lock and return itself to the pool.
 All storage within vdo is managed as 4KB blocks, but it can accept writes
 as small as 512 bytes. Processing a write that is smaller than 4K requires
 a read-modify-write operation that reads the relevant 4K block, copies the
-new data over the approriate sectors of the block, and then launches a
+new data over the appropriate sectors of the block, and then launches a
 write operation for the modified data block. The read and write stages of
 this operation are nearly identical to the normal read and write
 operations, and a single data_vio is used throughout this operation.
-- 
2.43.0


