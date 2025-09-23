Return-Path: <linux-kernel+bounces-828847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4477B959E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E09A16D362
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD6145B3F;
	Tue, 23 Sep 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="bmvMIh6Q"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079C3218D6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626505; cv=none; b=Par+EYB8W4LOQz5bESQBytkfOHYLIUO/8XB20ut3F5gl4T356fAl6YPXmxWey+6pty1HMpLkqzSTSQxhtmQEOhVUBBu7Z3Xm1ihtJOHQVo87BaPYH2l/WALIl+LqnI6Fqq4BaQkALiuD2g5UqO2cZ4K8rhU+D898GZPCe50/dsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626505; c=relaxed/simple;
	bh=oRZRbtn25wG8Mfnxe8Xvi6eumdN9gT1dtlxB0ybo29I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGLZih/nk6W1Ekhg2kpUikK+Yw8i5pz9BCbF5cH+Hzz3HgCa6wuiyL3oSFY1mgPmOLpmrA2WAlXH0balSYJbSeh9gqKIzmutfS2wrMcq9glvG2M7XHavszR2m6bSkKeuzaNv56AUIR8aPrDz0oGgojKiSfCUuDocm5+sHyLZiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=bmvMIh6Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f429ea4d5so1657791b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1758626503; x=1759231303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8aCLNCj+LP+gXeguDj859ZfQMvDmgLrlXk1t4GOA0U=;
        b=bmvMIh6QimjUOM0z7jHqezFFQE+2ZNbyvK/7+QU/HXrsZYJrmbPsC79Y3Bn/O+paw8
         h2FSeWA25McEt8PZpjS197b7Lxlo6yT3vEYp0tyjM3EEuKYyenLpZnbuLbEBylWio2Cj
         ++UhvMPehz7zSksF9oQaRyirWvyFKtsXAPiMGfnDsQqvEDEH4fO8pRZ6rdSLlFrzITPG
         cRUNBJyfbQcGNJ02D58PV0imaxVY+icxWbbQN7WOe4jKqCtp4Sdi493A1gsG2lGsUoYa
         cwSVWAlKtYXGHDLMOYFH/eVe0VI9rMcwUrxrefeDOrF0CqIDUDADJ8/WGFN391qdtV+x
         LMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626503; x=1759231303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8aCLNCj+LP+gXeguDj859ZfQMvDmgLrlXk1t4GOA0U=;
        b=MReOUyniequNhv9JxdtQM5uTbKQX0DdU+LEJwEDEWaYOlGjML+GLKohZOPNmqAg+fe
         U3zn4/JUwHctI2MHlNFJh/0nPbvHYzCtVado2KcelOkUSybBPXwh531kKrTltiXqBNzj
         ac+QbvHn5jLVYinNesvt876NdWz0a2FwaLwaXuH2AA1RhGYosAX5kr8jS3s0fvS+Zs9Y
         Zo+2MC8TsLSFrx6AdrjUb+CJLu9AE4dQK1k+/HrzLPIVCAK7kU8De+Bt+uLwpHsg/Edo
         lf9HJj5q/51Umb4UpDL7SYALVgR7j7oj2oz20rnJi9RblxJ5v3EUB8bc6qoZ8VAMGnvy
         KNDQ==
X-Gm-Message-State: AOJu0YzZ/sMc+X3faojuvo6dpEZdfiIr4qf+V6mfmYGA/sxq867sKCwl
	h4YIcynVWhhytOnCklhUHpxfG7y+9lXr0ZbxPa9/gRTnDnqxPlhkc7OKFQhWU3qtOIEPfHDmWUs
	9z+du
X-Gm-Gg: ASbGnctg2zh7CNOAOvk5KzHwkZzrXqJKcmzq6nTltuSnkmNg9XTQLziziGJh1q1o4bm
	Nd7WAu5WiOOfPcJbOKeWHP+qx793lP84KQl3mGkEKrEW3YNkxaB2tD2pAeyIk0joiyF6Z8gFt0F
	VRuW7ZHy6sxSiB4kUaN1kZFWYJpJu2SnOjla6sAp5sLZDoMPOfq0A0TDJslW2Dcof6VBNqsI0JO
	4F9xjQUa8EQp3svc3fakB1obHI2oP8bx/9nCNFTzIo6GkgmaXJ8FXMth3f2FQCuJJZADig/2lFZ
	yqum5S0a5rLi09wOQaYUPy/KP4xN6WDh5ytpPY6AroJ3KwKF3lHQaP2xd/65f+fYIrH/+CM4iGH
	IcS88WnxZ6VGQBE7/Ecyn8dCSwQ==
X-Google-Smtp-Source: AGHT+IGeMmgGYBGDbCAEjEyfK/FBtgLjaMcau85i22KMrpu5feCZtDLVsrAl8PmDzawt3QD2OEIvLg==
X-Received: by 2002:a05:6a00:1783:b0:772:31e2:b80b with SMTP id d2e1a72fcca58-77f53884356mr2169770b3a.11.1758626502659;
        Tue, 23 Sep 2025 04:21:42 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e87fb4698sm12048962b3a.96.2025.09.23.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:21:41 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	hch@lst.de,
	axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] block: Update a comment of disk statistics
Date: Tue, 23 Sep 2025 19:21:36 +0800
Message-ID: <20250923112136.114359-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

From commit 074a7aca7afa ("block: move stats from disk to part0"),
we know that:

* {disk|all}_stat_*() are gone.

* disk_stat_lock/unlock() are renamed to part_stat_lock/unlock().

Therefore, outdated comments should be updated accordingly.

Fixes: 074a7aca7afa ("block: move stats from disk to part0")
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/linux/part_stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index eeeff2a04529..729415e91215 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -17,8 +17,8 @@ struct disk_stats {
 /*
  * Macros to operate on percpu disk statistics:
  *
- * {disk|part|all}_stat_{add|sub|inc|dec}() modify the stat counters and should
- * be called between disk_stat_lock() and disk_stat_unlock().
+ * part_stat_{add|sub|inc|dec}() modify the stat counters and should
+ * be called between part_stat_lock() and part_stat_unlock().
  *
  * part_stat_read() can be called at any time.
  */
-- 
2.43.0


