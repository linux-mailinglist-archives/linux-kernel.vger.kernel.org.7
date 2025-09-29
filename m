Return-Path: <linux-kernel+bounces-836800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF85FBAA975
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9832E3C6DED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CA238D32;
	Mon, 29 Sep 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIDoQLYU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C852BAF9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759177319; cv=none; b=Lz0X9VJvcGTcu4mxKCMPH3ICfyJ2B41YFHJMjpmGZTJigq0FbrfL6JPMHZBzex+Ce07JEtwEPGqX5sEKLxZear2kuV9Rt/7tFxhdLjyfJ623lAzh2nKPP+/VeSXW3P6BiJmYCiWDsl38/oXPLe2cHzepiW6dzpwsubXePbF0Dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759177319; c=relaxed/simple;
	bh=AHO80p8Di+a+w7CL0BoyKTlvRPT1Y34mEXqPM2Obgs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0JsmnsYNB1J/pU0Fstzm0iQbjcIBYtfG0mGJ5pTwj9QU62VM8LX6j1Hzuv8jhJiERyRe2oBPAnigNlB0A8Hw3+jRiG2/faPT19e03/FiW9l1aU9yAxxuMGXp4WbirCmuusSsyHn/cIs0U8Wpx82hfNA4TWEPPmg+lvssLKlp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIDoQLYU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782023ca359so2546117b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759177317; x=1759782117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2sm/vRhjsyfLR7g1OTpoheSk+lSLNpkJYuUCogkU54=;
        b=mIDoQLYUKTg8ajm9FDdqFFHNXmoWRNYpKkEPJ0xZtrDyIpNgAIYEQuKiIhC2apKsF7
         vRJHLVHlj1BAYspnzFzQr7BDHwdrB7nTOZrFsJbjp2aj3B3s/o1UEs8hxUCzg7Y/2o3d
         sXpqLfgnJPIQCVTfY8fxgZM0TByXIPtK8BsYpmTo1kL/LrKHsrc+4wRZuZOZ78q3RXaa
         4aqJDm/O4AE6TUYMi5P6LdfInJP3wBjYcyx8K3LZTkBXByOdxQEBe7YcNpbgmkPAGiMM
         4VmyRNvOTPcL154gQroC6yrLrPnk5+50EvUEVCZyONqhZdWoA1cagmUJMkxkvrNmhcxe
         jpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759177317; x=1759782117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2sm/vRhjsyfLR7g1OTpoheSk+lSLNpkJYuUCogkU54=;
        b=Bh9KxDD2JX1+4eEKu3ILswkm+Zat5DH1gQMXbHfVxhlcxB8j4MItlL9BIZPjdHO4IL
         Qqf+4/1bJnVzMRB52ZZXkywAcsCP5QDw1VCi3pI7hgcYwLyUO14V2sChjvmBjNnWjoum
         6bzYpjYOMN8kMOJofaoua+IgfCeOcJt3rK5Oq1Uef6R7RTozTA04HhvjD0sn45NJm9of
         O8wHb7Y9ygRFAUVG5y1Z/E0rboeQND58FWeu7GqN4ygjRu9N6taTK7XO6mKKgHI6xyzM
         F58orWkMo4Sa9OFqIG4/iWts41tmV/dPIDtpskNSMGBsC+A187TH3UiSgnjD7ZK4k/1B
         JcLQ==
X-Gm-Message-State: AOJu0YzYcCpR6iW+SGDnZxXJKUFXC9J3Md1lebL0EUvzfAFSTaDqGdx1
	fAS8j0VMsJ1D0OwEyfycJGgvfwxnI+bE/XpEuvcOkKeZSjNoa8kG7YD95ybo+Q==
X-Gm-Gg: ASbGncsbkf1roc5DbAtiUZwGoc6xovK7u2y5NE1rF1QyfUG1hiJnBpWRHLmOJwqDlcR
	pzvKv9756Oe2dTYA5CgDqjBrI5z1moK+If2dMdWWn+OU9TqsewvPlhSdEz+HD4/HzqsaZ2kaOO8
	X9boZgZANhJPFSok2rkqNm7GSL6hMh8ppovrl76tYAzDk0ZOLnp3sz9jGN1j99+SUZNw6ft4n5J
	XTRn7mmW+1NDNXGHp46pPkGnGgolm3eLe+WLQmVlwcoBXoAyeqICulxPKGGKHZpi3mNyKVuoDMt
	JGdhm+EPBMl9iKlOy8UdpLZW68ZDNqXA86VXWMxvt3x7ask+mobM3hGDYGuvShCAA9xh8oO8A+0
	KOBmcXGy5LEGZ+guRCBXxfXDEaLsddRt5VfcN3UM4r7xzds+U7pHuhw/lsR4xbjaHslMCleQQw4
	8P/C0EfGnnn+WwKwSCVotmexEePoeBw5NhrWQ=
X-Google-Smtp-Source: AGHT+IEdVlb4qOYCZymoh3CgEoyRLCFD1N86KzkJdDtLXrCSDr2EYOIbGHKmT9oEVBeoLU6KMtggEQ==
X-Received: by 2002:a05:6a20:a11c:b0:2f9:dc8d:d2a2 with SMTP id adf61e73a8af0-2f9dc8dd60emr15418044637.2.1759177317351;
        Mon, 29 Sep 2025 13:21:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:34c3:b64f:90cb:9625])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a2c45sm11843310a12.45.2025.09.29.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:21:56 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs-tools: remove unnecessary alignment for blocks_for_ssa
Date: Mon, 29 Sep 2025 13:21:52 -0700
Message-ID: <20250929202152.2984080-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

total_valid_blks_available is already a multiple of c.blks_per_seg.
So, we don't need an additional alignment adjustment.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
v2: add ASSERT() to ensure total_valid_blks_available is a multiple of
    c.blks_per_seg
---
 mkfs/f2fs_format.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b98976c..6deb671 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -497,11 +497,12 @@ static int f2fs_prepare_super_block(void)
 			get_sb(segment_count_nat))) *
 			c.blks_per_seg;
 
-	if (c.feature & F2FS_FEATURE_RO)
+	if (c.feature & F2FS_FEATURE_RO) {
 		blocks_for_ssa = 0;
-	else
-		blocks_for_ssa = total_valid_blks_available /
-				c.blks_per_seg + 1;
+	} else {
+		ASSERT((total_valid_blks_available % c.blks_per_seg) == 0);
+		blocks_for_ssa = total_valid_blks_available / c.blks_per_seg;
+	}
 
 	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
 
-- 
2.51.0.570.gb178f27e6d-goog


