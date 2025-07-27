Return-Path: <linux-kernel+bounces-747210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B3B130FB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC21897D81
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464B223316;
	Sun, 27 Jul 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="lxFlbycy"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09C2222D0
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638014; cv=none; b=fCLHYxxfpsV8eRO0E1yuNGGn1rD3mMsxDv9t5/8YS0849T/omtWwg5ErNaTi+mYd3GKUUnTU3OhfNdRYjnJigDeEio3WqX2xboc3/8aykSxY2brd9gJDEe0fXtyLqDLaASQFJ0Q2VOLl4aH/ycuOWL64zcwRFTwb6sTQFn6VDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638014; c=relaxed/simple;
	bh=I3xew8je8GRIx1/aB/St3V1iUJkyLvLXJlWO4o8KLoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsL6pR79Yp/jSdMjktAqK2yaRSM7O0VtflMuC/twmQUejLK/xMZ+6CzwMulha+F0T8oGeR11YOqedV3UlJMIgnPrTd0x7pMoDdboZ1N+OcdgggXti8KK9znFUMTU3Lv4XXU0ffX4UEkNcKi5w9DLlyyXdYHAHl/0EfT4GgG2yJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=lxFlbycy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so4598888a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753638012; x=1754242812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=lxFlbycyswdGpqoDnPZPmOsjsvoeQGvgNzxax9g4mnfl+UMgVHDalOOILEt6AddsRz
         JmIhqV/5tlTPAC1zza/saSaGC1f0JbLpydX1Rk8xFpMRmOeUvRZYYqMhJyT5zDaOfiQN
         0eoYkVjz+sKU94+ULjM4TbV+qlJBJljif4Uk+4OwE8+SD6eFC/Ms6/02pplppeSmF24K
         eRmmqlII5Xi0PgySKm5KREB3dXKMSGmG6HFu81YLn1ctXxt6TYq2Y1zDiZbI7ZKu1ObZ
         1JGdVQSP0sbqC2GEWx/DL6LYrBkCmmTynv4s2deaNBgTqUg4HOiYOytg+9g/rrrzjS/U
         kvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638012; x=1754242812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=js9rQNJf9dd4uZBvLlFfD7OaWA9bg9oTOXh4ywFn1iCAWnyS8j5x/cVzwhTTSi5Ohp
         S6I0s/DqAd+DIXrBK76qE1bZgzDyaXm0mgVVqqsstjmrZB+G9FBY7racos9lCr43sSFb
         tB1g1BL3fgsUdJWLMkJZaAeUFgAtdvIGkmN5roxYiFA/y/KcNBXlOz1IJnhGDLOaaUR0
         HUQmpLAdoaaCHgt6yX0qNeiMJXwdwVdFcdp+FJqd43P2C+k8AT07J1utRCthh0v3CCdL
         8f6PPH4wSuAw5gcbaVXJ1qEgw1SlbakoJDx3eCYpX1FOQP65s3hFjCAjk5y6ymyqY4b0
         0ZBw==
X-Forwarded-Encrypted: i=1; AJvYcCUTABbxJB3EughZ4iNMLoDxp92lbLaY0XJzISYylsw1/sP0ftbDDsYXqh1xt7PhS5PntySqQmSdLzPBDQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMmib1FMiGX04XLyxcubA6BgVLqqpB+qXVyl1/IUoXDmdOVHA
	BEHBvy/Sod5HI3wW+Q6lRXHmrvlCvnUvIsOqQtngwhK260nf7LFtuZu54GKZ9rx6sJo=
X-Gm-Gg: ASbGncuPRZ3DbdtacnbFM0OX8a4n6kn5rkPqu3Lzn9CX0m3WRzbJQqZAXbS/wpsqEhA
	v/mD1m3CMJq+gkMo7VaGb2/J1ZzSmb1G/gZYGvnX6jlRjugJg8b/nTmxBtryYcROay3hFEGlkHB
	JRFhDlMOJvqCCKRskxZSmJOYemiBtx8TZzn/Q9/SYCFNTp8gm+FQ2+fnbLVVQU2ZuwGyJL0uqkF
	qJhz+66Ukdt+OWWJjS7AMBK4x0TtbRwpcHrF73QeMaqzvuHVSThFxFO9eKQgtaZCaPUKMg1UqMg
	M3nfq9Uvd8+PrmdubQx4d+rK6/yVbZrxBmdiKu5p7/IYr6TtF0YzednzoVDQZu4XhTBsx8JTLV+
	QhOVkCXA=
X-Google-Smtp-Source: AGHT+IGDb43ROyBpxntRgNLuY/5vvT4SEpSM2eziMLcTMsmIiZVG0+L6EZVmEl313ywHGdOopIdS/Q==
X-Received: by 2002:a17:90b:5865:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-31e77a00959mr13499760a91.20.1753638011909;
        Sun, 27 Jul 2025 10:40:11 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8350b724sm3924224a91.23.2025.07.27.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:40:10 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 2/3] blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
Date: Mon, 28 Jul 2025 01:39:58 +0800
Message-Id: <20250727173959.160835-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727173959.160835-1-yizhou.tang@shopee.com>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the current implementation, the last_issue and last_comp members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Therefore, eliminate the ambiguity here.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 30886d44f6cd..eb8037bae0bd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -85,8 +85,8 @@ struct rq_wb {
 	u64 sync_issue;
 	void *sync_cookie;
 
-	unsigned long last_issue;		/* last non-throttled issue */
-	unsigned long last_comp;		/* last non-throttled comp */
+	unsigned long last_issue;	/* issue time of last read rq */
+	unsigned long last_comp;	/* completion time of last read rq */
 	unsigned long min_lat_nsec;
 	struct rq_qos rqos;
 	struct rq_wait rq_wait[WBT_NUM_RWQ];
-- 
2.25.1


