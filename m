Return-Path: <linux-kernel+bounces-891372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1367AC428DF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89E74349488
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF770290DBB;
	Sat,  8 Nov 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB6e38km"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03212B9B9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762587522; cv=none; b=OZE1BvzXywqAlDl0LIAvIgS3Oq3CLU3eYMq670aU1t7V3rZWNEwrO7+qk/acrmmSC1fxv2M/ChotqHUgm+A2rVHntNvE1JxgKdmeWjtlOEIJzrb2xmeytCPEewUHqQwY4mpgIZxfb13ZT6udZzaJP0Yfevud+T0uxqmC5/i6Les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762587522; c=relaxed/simple;
	bh=1CkgvVTSSfKzBA1eFnAdmk0Y2AxMZ9rFI++vJRtCnJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gx4KvHvPEHpM49OARZhlrCK+HEJL8R9uLtP2RSLvh62ZM//SGjtJmdA42Id3Jh57QKt+143gknYhYDuR7rl/x8qMpTSqkcudCM2Wmrt6li5FxXbxU+CMBX8EOSsc1A7H2IdPtodvAsOqGKENzdid3IE0FNOEHRIvaXeR21D3UaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB6e38km; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7af73974a4bso973712b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 23:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762587520; x=1763192320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoOb3TbAUUNKT9sDKFHD/7aRa79NJLaBtFYmNoGN1wk=;
        b=MB6e38kmQu+PRal0z0S43uHVEQ+C1CxmyEoE4bXJvNIJdbl4rSTTU220kT3vNM9kDR
         C0+JF2ybIK29/vqDU9kaa4Onj5CDEGqsu63nyRgJkwpYTH13bRRN3b2TYk2qnZKsofur
         VHMzUka9SroYgUlTZHQFt45Liwojf85UDuIAVK9RtRmh5hLjNaAnEOpLB7z7hGe1rVvV
         apO0jREPtP4cB1/GveQ11E4H5nIDYB+Zf+GXYgAxsrbJBDEpTqDHg03y+W1TyTXe403G
         Hc/OE14F0i5nvX8y4eVxodM4u8n6H+KaxJpnzvF4Zy/roBWangeDF9lu9i6EkGydoEby
         pWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762587520; x=1763192320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoOb3TbAUUNKT9sDKFHD/7aRa79NJLaBtFYmNoGN1wk=;
        b=DwgLXftEuqdAry2MUFNddOtMzdcNsvnp/lkf5aUqhzppC0lmNlheK9gF0FDmeAD1Tg
         zpv2BMEGe0YjuSSavxPvO55c77CwXar3SgHC7525McpBt6ut1KhO1JfIjrEC0mxLNQRA
         KY8CT0qADbs9rUfepKhOjfyaC2K+GgyzjhXXpC6nrQgNd4HvZqjeOKivUokLpPQdrl+w
         k+QIVF3z3XtH1Oyfj1N3WVkRoIQGNGz3Tsa5ZWySbngGGwTs/u9cSyKWQJ6eK8QnClV6
         EJ1qxjlRZT7vKO0gKGnBxzxmDt4/3DxNFLVnC5uulF9h5iHrrJu7l2sFfC/BTVmaVZxm
         MHBA==
X-Forwarded-Encrypted: i=1; AJvYcCUnuPWRKy57sjV1YJCSlf6ucy7Gjcc31K3liTq7N+gkJATf/OjKZ8YdKXtIt3kN8pPPSb/Vw31+NXoqYF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQETukAgKRSKoT7qhPqNDBaT/dv9RrAeo3Auge1GMueMOHPY2F
	O7x/b50z1V58nmoP2T1gHqu8APICOSIer2JkUyOvBOmuyo8hFfILqmg=
X-Gm-Gg: ASbGncvOWJ0Tkh0FZNKPul9oLidDDdw+M6vN32T8Le+mB6s74vlnBtMphhF8D9KZke5
	xjmkZUdqke83/VRNfNVq+L7HQCOu+VnQWdx1LoP9fPVfBJt/VjaRdqGEVHobszcZtIjxJMcKNHN
	NqurXFWMBvo8OqLDpf/NkEX+VE6L1Kx6I+C4OM10eKhP6wsyWAg9zqTNDDP6VWPjPA3qdV6Qoje
	b2l6Ez9SrYAuf+Rf0YVuuPg5vwxoKnkFxw2WWE85OTaOdFCBg8dUD9LrXMLUZGrLD6U52IIciUl
	m+4ZUeskLIL4jlMjuLBBxyGXydmvZWcEhh1DpBbPOf5ted4jMTikN7MdAY9Wep6i17Hdkkw8Vhq
	a+USN2FwgWYG5oZScumOTR1qygbXgXsCw+3rHIJgDyu7xDyXFYVOZ8lN2Hl/1P4hoTIPTyx+s7h
	qt6BfP8L3TqpVi1iL3t1U=
X-Google-Smtp-Source: AGHT+IHlgj5fuUW3LP9hSNQQUhVmJVfJWH0yykBG6dmD+P1+HhFRV8Fr5qUlOGFCWZUoY7PoIN5OmA==
X-Received: by 2002:a17:90b:3d87:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-3436acc06a5mr2507541a91.14.1762587519961;
        Fri, 07 Nov 2025 23:38:39 -0800 (PST)
Received: from localhost.localdomain ([14.155.51.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68aa1edsm11362607a91.1.2025.11.07.23.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 23:38:39 -0800 (PST)
From: Linwei Wang <wanix1988@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Linwei Wang <wanix1988@gmail.com>
Subject: [PATCH] sched/fair: remove redundant se initialization in unthrottle_cfs_rq
Date: Sat,  8 Nov 2025 15:38:29 +0800
Message-Id: <20251108073829.7594-1-wanix1988@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In unthrottle_cfs_rq(), the variable 'se' is initialized at
declaration (line 6024) but then immediately reassigned at line 6039
after an early return check. This redundant initialization is
wasteful, especially when the function returns early at line 6037.

Remove the redundant initialization and only assign 'se' when it's
actually needed, avoiding unnecessary memory access and improving
code clarity.

Signed-off-by: Linwei Wang <wanix1988@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..67cbb809b9a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6021,7 +6021,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se;
 
 	/*
 	 * It's possible we are called with !runtime_remaining due to things
-- 
2.39.5


