Return-Path: <linux-kernel+bounces-747620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB6B135FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B96E3A1255
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E292221269;
	Mon, 28 Jul 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZdVhy4J"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405527346F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689476; cv=none; b=TPjqwc4uPZkX3V19ZFeq0YSV2dCjn7Dku9CmwMYzeMNh+kOipy/BvqwRzdmdxc6KV3KBvuqGCrqtjpGGlVHfWHH2wwwHhlIqH7EH7jTCo3DQTtNLc9qySpGGhs7Yy/rWpSSKYVdyGspG/6Wd6/H7oijXdSKiJV41nfAU2T0H6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689476; c=relaxed/simple;
	bh=kV6dvxMOHs4+43tfItDlmL7BgJ8/MdNLiDdkEt5W0ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncRfbyOOsWsOHfmIkxeuJJfQe6w8bdPexle4LtJgw/8HGAa/io9dpUJXvYqMXphrrQejqRKhTGsC6Xr4qB32X3N3u1NjRiz3B7Nkap4fbMyMSR9rSWsOEqulx3B0q02sTq2Dbazz1NF/wdU8qluMhSSsmLlYlF/lpPUHvQ3LZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZdVhy4J; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b56b1d301so2675530b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689474; x=1754294274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRsdUPAVu/X4LsPoR4wDkLBbEv6Gb6vStgXx+BM2eVY=;
        b=iZdVhy4Jo/33CTI8Fh9FJce//RUsLbmRfagmDWRSixz3qwzc+2RJOAM+4UE7W9qWjB
         lnl8NJCykAYJnuydF+VVWa4Qz+GmCXByN1J7ksAcDy8uHDkZRM9nB93otN/0ssWGTb6R
         FzRMtj28rgIQGa+0xETWzrrxPvMWGYRRcGNfQkzVLgyaL4+R7dwLaok3pnQ4NTTCZMXb
         unA9nKsvJ/FM/juRPbs3RN1T7S9N6znlzzfoIdVjkpqNV1aDkUxKnsL8wDhba3q207R2
         ZY669ibwa1yOnicA/AjndIG5nwNF5Vz+mICMikabwNRiZpYtugyYml15YYELOUT3Vp8O
         ZJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689474; x=1754294274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRsdUPAVu/X4LsPoR4wDkLBbEv6Gb6vStgXx+BM2eVY=;
        b=fRtH5UU7KASWiTXs9H3OJ9n9zmFz0MZL5JPe2rOxu9LkUNG+1wZ0bm2UCMl1WEezjr
         mDHismds3aNjX0AAMgwh3g3CMCHqYicujDNLgruJkFq/EjAwhZ3iRLA3jY0NbbKAwlBP
         CHm51tWSm1I/rVysjbaP4yLUg6TBW4W7EKiQV63vJH1byEzeg5Za2uS6ayhSn65SMkWs
         BQyWIIs4TgnI/xdH109e4ZfEnikH5kXn2O7NHAvlqOH+tHPLQi1G16u3hbqT1A3Ekg7j
         xkp70+eTEr/kojpVK9YFqHZmwxy1pRReCXRClrL/bwaer1ag32E9h6kk8iZoppn0tav0
         RHeA==
X-Gm-Message-State: AOJu0YweBWEUex0yIC/mR4e7QWpp099JwBVFimn20KFNqbu5YWwhuau/
	rWKI/52uv8qHVxrohE0gQhOLxEolVFrSJCpo+UVykoBvCtn9DjxcfdvA
X-Gm-Gg: ASbGncvlnB7ji+M9y8lokpB30yZXvkqHNWUs3M5cDGHhowQHwG9EjA9XYzKyxQQGe4Q
	x6hTRKTbfGOGhYO7a7Q72DSXNIxaUP8nnYZROmyNFdt/Tb2jIOZB9qnyjaSFi8tIVPoFWX80lJ7
	qoQYc2kWueBVv15aGDk/2e518FRnJYQCvTBnmDDan9X+O/v1cPo5U0zVcIPU71kd6gH4LVZex6a
	ZnQ3slMTZz/FtvorZQAyzaOVIhVVKMpF9uIx91fYvpF2dNmalnKrYQ54AbDZOauyKW1FObdGVNd
	goTZVvtCNGqd7kLyRvNIOwONd0RMIkuyhWrg9p3cUF+MINc+Nid3jZAFM3uhM3K/fWTJsk7NCXh
	p9oqW1dj16zmyJHVm1JPka3XzSlRaDINLwcdU4VNbVOO2QMzRxffFOTNkuGZLMnKGui0EsEw=
X-Google-Smtp-Source: AGHT+IHp4vLEDBnjd72lfZj0E1dWzjco00ieSSkMMUgjy5vx+ERVUv2Jf5ttd5tmrWROTY12QEqaXA==
X-Received: by 2002:a05:6a00:a05:b0:748:e1e4:71de with SMTP id d2e1a72fcca58-763341db8a6mr14194398b3a.14.1753689474460;
        Mon, 28 Jul 2025 00:57:54 -0700 (PDT)
Received: from CHJA7811.auth.hpicorp.net (211-21-189-75.hinet-ip.hinet.net. [211.21.189.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfe78asm4906460b3a.70.2025.07.28.00.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:57:54 -0700 (PDT)
From: Shou-Chi Chen <tuxsogi@gmail.com>
To: peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
	Shou-Chi Chen <tuxsogi@gmail.com>
Subject: [PATCH] sched/deadline: Fix typo "a entity" to "an entity" in comment
Date: Mon, 28 Jul 2025 15:57:33 +0800
Message-ID: <20250728075733.2153-1-tuxsogi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a grammatical mistake in the comment of deadline.c,
changing "a entity" to "an entity" to conform with proper English usage.

Signed-off-by: Shou-Chi Chen <tuxsogi@gmail.com>
---
 kernel/sched/deadline.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 89019a140..bf06e5dfc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -848,20 +848,20 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
 
 /*
  * Pure Earliest Deadline First (EDF) scheduling does not deal with the
- * possibility of a entity lasting more than what it declared, and thus
+ * possibility of an entity lasting more than what it declared, and thus
  * exhausting its runtime.
  *
  * Here we are interested in making runtime overrun possible, but we do
- * not want a entity which is misbehaving to affect the scheduling of all
+ * not want an entity which is misbehaving to affect the scheduling of all
  * other entities.
  * Therefore, a budgeting strategy called Constant Bandwidth Server (CBS)
  * is used, in order to confine each entity within its own bandwidth.
  *
  * This function deals exactly with that, and ensures that when the runtime
- * of a entity is replenished, its deadline is also postponed. That ensures
+ * of an entity is replenished, its deadline is also postponed. That ensures
  * the overrunning entity can't interfere with other entity in the system and
  * can't make them miss their deadlines. Reasons why this kind of overruns
- * could happen are, typically, a entity voluntarily trying to overcome its
+ * could happen are, typically, an entity voluntarily trying to overcome its
  * runtime, or it just underestimated it during sched_setattr().
  */
 static void replenish_dl_entity(struct sched_dl_entity *dl_se)
-- 
2.43.0


