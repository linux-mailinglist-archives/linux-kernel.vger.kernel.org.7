Return-Path: <linux-kernel+bounces-888400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF84C3AB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FFC1A45D21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3A3195FC;
	Thu,  6 Nov 2025 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U7wpaGwg"
Received: from sonic312-23.consmr.mail.gq1.yahoo.com (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADA3191BA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429812; cv=none; b=MbIljWjWwN8Hn4hT+CeFKb/RFwf1iYF5pbwokWWAltsrGzBoRoEZgLUUN/DhdTtJXmnSgzsCiEh2vMYyBjoXW14QXky4a2E1wNyzfF4sBS1w/ycV+gITqLZDLG7gCiTfRIIZjiqifRROYV8nsWPHv3FHrXAD/zPxzuirk9tgH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429812; c=relaxed/simple;
	bh=sC0i03XrfK+aAFJKa1QWFz01JSapbAfVrpNt2LQ8wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba8ZDYM+3p0UA2Pt2PPFilMWfXXyTbBRbQrFytywRjCra4ubcZWiM/tOACOP+AFidRhmwTbsbH/+nCk8a9WqVzTBrRAFWj8PPKJ57OvpKDgebTM0t2gB++hFW2oyNVQXXrnJRP+tVMVZs3qoDSLejb04U5g3s5bDe7IzKKFEx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=U7wpaGwg; arc=none smtp.client-ip=98.137.69.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429810; bh=2NqNGQgdR8dBJVHAkyaPyaTZDk61lHGGvXQ0jY/4ZXc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=U7wpaGwgpjziNtdahGvRLNIoVW+vsanisvOp2HwgC96f90aEETBOvlhkd37ADvWw89JlFIDAYl08+DAbxHXc1QmNbxUaDQHEhwpBjvzwWHQRgDXJ47gI0zAyVFfzIU1YzGGHQowV+fFZHVuO8jrbWrk1+nBWgmJpq1uvvZE+joPogi5hyClh2RiGozjmbV8fHXFTa75wFIVSyUg3/cYkuo5vKnUMqmkdSHma/WzbUrQeS9eCGPanPt1xYT7vXCj053xwFM/RhH4LFd7Fu1PSlsvabS5u9MxMWgZz1RhMolXEKqfvg4wP16Eg9Kk8PO3QJRnOkWOxshBkJawPckbmmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429810; bh=GeSTgtxwKWbxaQEszXL9Kylx03Kq8AUPIcpcd5XUEZB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rlrIM/HLP1/8vlmz+UromMf4bOtQ9nW8Mxn9QUd9o5izHVUgmVp6BezLPhGkXNRu3pn0Bgao/6sylL+jV1BWa3zQJ+kx5nH857IT2ter28Q8XD4mtYpnTQcd/QteuEuruZqpB7XsTky2By8mtJVeTHH7c0udbQV7gAnnWEvQPvkJgVYmZKiivLp40nh5g2frp9Rax8k6LoNcWlWmY29jz7nmDAjxyyyaKdY8byVfVDYftaQd6ljijZ/BTZbneZP/TyWul9MG7U3JhyrYiQ9v6Rnr/2NbxWKdn/+2rzsuoi+ypmv6/Pj9Co/DzpLWZa0WIuOg2P2pXU/OSdK8DVB/Gw==
X-YMail-OSG: FsdktGkVM1mkYImRS80awQNUrL1Xn_6foRdjk5U0qAOlkQYRm2OlO7HpY5BZ7RX
 1vJoFVqVXVt3AKcZC3_gewM9VSXnMTWLiCll29s4fyPfEITLaB8p5UKNvRQq5rPWyeLM.2Jjxveq
 75XPPoepssPXThNRbrBrq.t0omGJ.gv8rjadJy0UHKdUvNvIztAHlvTceesz.COEO.FKBvb0xfaH
 hXrYgjV0PjNsy8l1k7yP2OQOOwz1vTsBfGrvDlxM9TYcm_Gyp05UnNFGtjWbeM4pO_Z890qFCFnp
 yqpHVasSW1rshPiFBmHG7wg6SjuzXMNQq9YClQBjOlBXmq2w0.Kcl92pL.d7gFtghY5meSnucCQw
 cybcRDu7SXvNfOiG.obLze9UuL6CABRc_P8M8nIsnMVZZEsusLk76IcDhA_kiqrKig0VBlIxuNGA
 5.x91EQJ1jD1Nk6kdFG4csBp8c0Wq_ap8.0rcogDoJVkGMtrm7G2yIrfS17f.mjwIIY3wmAte4De
 GQjpbFv_4QNqAv5jDmW5bSC31poi9Gzda9jZOEgJGUOPiRyI7iMj501r0SHsU7PZ5bqinfw8cxQZ
 HAYobdzM4nLNQdU_UOQuhQY3qIiCleJC6eFqpX6uiWbO6I4yq.wT1F96o4TNFIN25CEK3k43hLFa
 mC7sOyIOA6wozhKZf03qYdCLoQ0gBXZIIMdhcH_ngrYQwg1e_xDIdmzWl0bVsb6VW22N7vMuDgks
 V5Q9WhWRkA.w_GyMjcSLREXoAp1.boeC.j0NquVFJUmnRnP9knjEWOJf6VOye3tIxLDscmxOkGKd
 Vr4OwP8oLJjCKZTYjn5GLkLdPDJ35MgjQwux5MOniwjJkdQlKoQ7jxIMsL5qdyct8o3dzCUs0Yzj
 0ZFwZTvWnALmcTbLo1k6iSlgVevzeGfC9tFMQHiL7q.L4aLVuNA9Btbfdph6FtKCheEuKXMmKp15
 2D8bQMO5Kin5rZanVPZriICUHtGl2L9HVtc2ZG6_ln3ihq6cfSPc3wpBsXhiNmEEHJ3dpVuA5Qms
 4gOyFJNm649Iyj7XbuGzKplTFr54d_JGpicC918P..Qjw0TYVAhuWfwvtFH9W5u23C9yd348dl0A
 yQAqCqaNWKBwNfJ7e8gqhzOEx_KbGVCnxNMENrhSvMqBwQmq.h44nrje60xYf9GtN1sqaeNgQtMZ
 Z8Rs2BuQM4jFxSQZ_oaNPosOea8uP2_0W.gfiT17mhDqGV5PZGSGUSA2uxk8LfNBcSzRD8Q6mEWA
 HyBaCFr.mxfbyorLqqBKBm_ZA6Q0lgOlOd6Czh7DvBQQMNNSjZ6BZCcSZHZ3NXRgL0dGObpMLlpb
 0BUJuAVvnptVErMqN9hcT4F8AYhgcAriB2cJEIFQoVI_Qc0GyhGhwXe9WvAlKAy5R7MQFinrde_E
 wCLQFJGjddjyQsdW8_4mrKe2U.q_xuXbSEfxqo6GOxyfGYMNkIRMw9Kx2LlqDGMcXEx5pN3LUqy8
 Lyat6SuY_zaIs7GJ.WI8IgISX1gsaL0OSx6I84hVWnxUuM3dv0d4Yoc8vvudp6sR4QH9C3Wa4RfH
 5VPn7Fn3MCKT_rt939PlCUkWfkgf.Uy6_wO2.4WjqC9bRyFIgrnM6Tpozfnt4JkZXMByAw9nlr0C
 aR_.HZ4g_3FCsXRRT_vyogzn_bKoGd9VQZ1oT2bddBMXaqY3WBxiu92uLduZ_qHALKr6I6BYBVWL
 R6G0E61t2bKjxKlAzTGrMMrPhZD8QLFnuzxp8OgHLeV3Y7b4N875xS8XQhByddWOFxa8DCh1ICP8
 ptdgtth9Z2_IyWgmZyMQSu5K8aypKGZQsJFukgouiCW0F..h8BEaG9GR2QjYIhFiawY.9y96jlot
 _YmMMMcyoKKF42BC68.3c4eAc8KsG4KEwf9ya6FuqNVjPqBfLza528O6qVUdD0NVnVHV6h_zAACs
 RZTtrJChNXBpzxKKcF6Qsb0xrv6m.mG2PcHPEjrMK7y_oqbRHrHUSnNNXzo.jBoRapZ.NJ8v59yt
 xBvXE7bfZSoBNsIEnI0HIqqYRSWXACw2__dwCg0qsOiUT2hgPqzERpZ8t_Wt8voBzwBZudw9qW9g
 Weii.Y6i78ikOSBqa27_EQmzvDfhpKpkcUorAqRWywp0RvJdC9d4Pw7iBHvVw3nf_oSuqZcn1P87
 KGAT0jXyMju6QnJ7VF1GLTqecQZwmhESqDhvYGxa.PQnGMWSwtnbJ7SzESNEqTKU66w9YpEhBzpp
 7hJ6mgpvgMzALk8SK75y8GzSYzoA6NZNO2KXumBIIQ3BXEHmAj1ppKTLwqHcckzmLw1IYLxplR1m
 XS6UGy9adn7UpxnyBoWU-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 7148212a-1dc7-4061-8833-5f97ad941812
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Nov 2025 11:50:10 +0000
Received: by hermes--production-bf1-58477f5468-vjcpj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2a71f3be34b9b294192b02c80d46421;
          Thu, 06 Nov 2025 11:39:58 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH 2/2] time: tick-oneshot: add missing Return: and param descriptions to  kernel-doc
Date: Thu,  6 Nov 2025 12:39:38 +0100
Message-ID: <20251106113938.34693-3-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
References: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions in kernel/time/tick-oneshot.c were missing parameter
and return value descriptions in their kernel-doc comments. This caused
warnings during doc generation.

Update the kernel-doc blocks to include detailed @param and
Return: descriptions for better clarity and to fix kernel-doc warnings.
No functional code changes are made.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 kernel/time/tick-oneshot.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 5e2c2c26b3cc..ffee943d796d 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -19,6 +19,10 @@
 
 /**
  * tick_program_event - program the CPU local timer device for the next event
+ * @expires: the time at which the next timer event should occur
+ * @force: flag to force reprograming even if the event time hasn't changed
+ *
+ * Return: 0 on success, negative error code on failure
  */
 int tick_program_event(ktime_t expires, int force)
 {
@@ -57,6 +61,13 @@ void tick_resume_oneshot(void)
 
 /**
  * tick_setup_oneshot - setup the event device for oneshot mode (hres or nohz)
+ * @newdev: Pointer to the clock event device to configure
+ * @handler: Function to be called when the event device triggers an interrupt
+ * @next_event: Initial expiry time for the next event (in ktime)
+ *
+ * Configures the specified clock event device for onshot mode,
+ * assigns the given handler as its event callback, and programs
+ * the device to trigger at the specified next event time.
  */
 void tick_setup_oneshot(struct clock_event_device *newdev,
 			void (*handler)(struct clock_event_device *),
@@ -69,6 +80,10 @@ void tick_setup_oneshot(struct clock_event_device *newdev,
 
 /**
  * tick_switch_to_oneshot - switch to oneshot mode
+ * @handler: function to call when an event occurs on the tick device
+ *
+ * Return: 0 on success, -EINVAL if the tick device is not present,
+ *         not functional, or does not support oneshot mode.
  */
 int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 {
@@ -101,7 +116,7 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 /**
  * tick_oneshot_mode_active - check whether the system is in oneshot mode
  *
- * returns 1 when either nohz or highres are enabled. otherwise 0.
+ * Return: 1 when either nohz or highres are enabled, otherwise 0.
  */
 int tick_oneshot_mode_active(void)
 {
@@ -120,6 +135,9 @@ int tick_oneshot_mode_active(void)
  * tick_init_highres - switch to high resolution mode
  *
  * Called with interrupts disabled.
+ *
+ * Return: 0 on success, -EINVAL if the tick device cannot switch
+ *         to oneshot/high-resolution mode.
  */
 int tick_init_highres(void)
 {
-- 
2.43.0


