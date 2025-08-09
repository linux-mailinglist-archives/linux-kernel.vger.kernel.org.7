Return-Path: <linux-kernel+bounces-761123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F46B1F4AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2F62329A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790227FD52;
	Sat,  9 Aug 2025 13:04:56 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B3275B0A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754744695; cv=none; b=lQcAsNF2Gn5lkhXR5GaNiVbREK5GjCcs79abqTTA/ssQDndeTFR+1v6XMOTi/R/lwmkGTv0E3OHFJrlHgl9jqa6BTELMK9ol4HUTgAqauqFoBJ+OTXA6AXS4lzw/MoHVkK43HAwELzNw56s1Yg/hD4G+ns15PnQjff2ns8kgEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754744695; c=relaxed/simple;
	bh=tGpi0w11HTJSv8+vaMNftX3CbkyNObcOdG9bdmdrEVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RElA9xpjo0lDS+I5Tm/KNyl6sTqpYSJH3xC4p5jd1/wnCdNllmrzWhNWBGG6+8YHX3xdyq6dT4N0mb+w+Z+STgBUsEETtVuxKYpL+oY/JcvHlSq1kCSnL8PyURgC9U+JW9PS3xoehuuLyquyalbY3S7Po6fLS8tRalxPbuus+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.45])
	by gateway (Coremail) with SMTP id _____8BxrnJoR5do_zM9AQ--.52258S3;
	Sat, 09 Aug 2025 21:04:40 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.45])
	by front1 (Coremail) with SMTP id qMiowJAxleRfR5doOXY+AA--.38152S2;
	Sat, 09 Aug 2025 21:04:38 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] sched/deadline: Fix dl_server_stopped()
Date: Sat,  9 Aug 2025 21:04:19 +0800
Message-ID: <20250809130419.1980742-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxleRfR5doOXY+AA--.38152S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw17Cw15uF13Aw47XF1fAFc_yoWkZFX_G3
	4rZr1xGr10qrs8uwsrZ3y8ZrySqayjq3Z8J3WkWayFka4xJ3s8A34jgF1fX345GryfAF9x
	JwnIgan3Zr12kosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
introduces dl_server_stopped(). But it is obvious that dl_server_stopped()
should return true if dl_se->dl_server_active is 0.

Fixes: cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
I found that after commit cccb45d7c429 ("sched/deadline: Less agressive
dl_server handling") there is always a message "sched: DL replenish lagged
too much" after boot. Then I found this bug, but unfortunately this patch
cannot wipe the message.
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b3..bb813afe5b08 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1611,7 +1611,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 {
 	if (!dl_se->dl_server_active)
-		return false;
+		return true;
 
 	if (dl_se->dl_server_idle) {
 		dl_server_stop(dl_se);
-- 
2.47.3


