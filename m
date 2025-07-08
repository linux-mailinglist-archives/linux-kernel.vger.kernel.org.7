Return-Path: <linux-kernel+bounces-722042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9FAFD3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4505D3A35E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCAF2E541E;
	Tue,  8 Jul 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmqkU9GJ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142E20296E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993797; cv=none; b=ZiLzYUY/ScZURlSAV/cMxh/t0y756qyfJ7JAChF7NxaAhm2jd/Zoh3yBugD+N7/icYc4U2Go2gm4WW8qfkDSAWRyHE8AQYpquLWVpm1DQmqdqg+ZlWRE/6W2+C25V7uNIJNF1DoOw30CWDn4o1uR7OI0u+8WEkUYARq4e+kc5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993797; c=relaxed/simple;
	bh=AhbBIgHkLNVCNMm17JJi+tNpziBECUFPFNFEnQtPCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf57SAsZx8YLf0jUW9oo1okRMGNupVxS5utJ961jxH/kLbKG8XYQF3bk8Hlz7BnW9zsW11ePCN7DIJZ4ffUoYElsP2XxnPOcmopHAj2TPovmq1za9GldPxGItQiUsvflm1IacZDndYrHg6YThtDgXSEM+i5XgbbZfw9ZZsccXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RmqkU9GJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a51481a598so2628616f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751993794; x=1752598594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hs2oYF3e3J4FN8zRTDauoaC2/4C3r7PLe1ATMwxGhY=;
        b=RmqkU9GJoeX8AjJbOHuI3JPL+kt4RkpakDzQMZmox+UPwNFohoB+bdATPfUeU1jmoa
         E8A1tmEm/58tism8trtIavlC8DVoynMs85NAmKQ7B62ujESYc9WBdt6bwPLDQYRySzaj
         KA6QqhR9DVdEJIELtqTJ0YTnvEq8/jGpgfjG+ZHSpOfHZH+KyfPHKOBPtH+DYyzezp5H
         P3gCeZosbSUts5vcZ8DzF152TVL20Ca9i+ULyrorGG0qDqSOlVUvoIviUQNprplBiDdT
         afPbQAnjoaKbU4n6/CzMDhRObJqdsige+AmjiyQ4wPppaLzqWR/o/o86EcKKwB5VOxvI
         gnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993794; x=1752598594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hs2oYF3e3J4FN8zRTDauoaC2/4C3r7PLe1ATMwxGhY=;
        b=aMFNb8fvEFEMEH7Clf1Ml0mUZZD9zjAvslXTfj+9UM12FCc0ub0A+jrTa6gAhlmoVe
         VqlT6cFnkvSW19G+iGfQQjBvOiiOvl5Wm/mHRbGJ+mYQ03JHncjJRnAUL7u8DdgLx5BD
         VKzDUWRsRfAuYknawAVjnUek3J0BnwAbDiuFZI6akTcaKmSMCArgeu6x26B6na43B6aY
         mvL9sHbc1C++D9M1uv1XjBr/Fl+tswnC0IGurBzdr7BVlnOaHRPK0Bsp2Q96hXuZaCTL
         e2Kp7jzud7bL6Z4Pby0Q2gl3MEb9c4I/PthOpEJHzb7UKOz1CGjUlrWulvPBKTpwx/TD
         EDqg==
X-Forwarded-Encrypted: i=1; AJvYcCXkwh8f5fMQ6upBodPl5Ub4JJpv20TyDmu9RRPD1voXkwJwxZcFhZf74x6zqKiffkmOWF7Ak0x9Qob/Yxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRai90RrXztwDpKJ9aAZsEA+s13pn0FzK4oi8n6P7PPJ+ndim
	/1bA/PRtSzM+p2yh3Timeb3291tfbtUj/8aNOWc6fUcLl8WyCPwQJBbDpoObnVqbg9c=
X-Gm-Gg: ASbGncuCmrPpIQ4MJR5Z/4p7CAgowndHUIq7weDfNvLH08kLbV0C4F7ef4Dut4XuQ7M
	q9Bn3QuBJhCwjZKBHRMc8X6CvjZXTugbBLfIUIxV9h/bcLojS2H10yx6HBY+d+ZWotJJuMj5zO5
	EqjIlDbVfQmhcRqniaf5noi0N8ZOBKW/fvo584ACz7EUHxs1lWPhJuqfxxL/baUNg0na75WCWBv
	uwVdJ5JQMUbrTPdw2p5tThUomkreS4xIAbtXsosO/Tfq7mGI+lfkImPiPc9bmbHDzEs/2Bz2LCp
	q0b23aqUmWr14fUn2s9azP2cy6voxad7uYP2GJllukRxfIrG1D3JsYrgCKNepULODk/Psxk=
X-Google-Smtp-Source: AGHT+IGVR8h+iqDXFVtFVuUgLLbZaH5cTpE0x0yO/RQ3cy1MfYVihe/jtDd59Qwn59KARKeKcep5zA==
X-Received: by 2002:a05:6000:4308:b0:3a6:e1bd:6102 with SMTP id ffacd0b85a97d-3b4970429fdmr12405783f8f.49.1751993794131;
        Tue, 08 Jul 2025 09:56:34 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:2a4a:c4af:2315:5f08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d51sm27295965e9.29.2025.07.08.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:33 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	dhaval@gianis.ca,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 1/6] sched/fair: Use protect_slice() instead of direct comparison
Date: Tue,  8 Jul 2025 18:56:25 +0200
Message-ID: <20250708165630.1948751-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708165630.1948751-1-vincent.guittot@linaro.org>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the test by the relevant protect_slice() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dhaval Giani (AMD) <dhaval@gianis.ca>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e2963efe800..43712403ec98 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1161,7 +1161,7 @@ static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity
 	if (!sched_feat(PREEMPT_SHORT))
 		return false;
 
-	if (curr->vlag == curr->deadline)
+	if (protect_slice(curr))
 		return false;
 
 	return !entity_eligible(cfs_rq, curr);
-- 
2.43.0


