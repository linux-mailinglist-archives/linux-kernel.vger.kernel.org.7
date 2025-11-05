Return-Path: <linux-kernel+bounces-886921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CA1C36FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D5768044D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE98310777;
	Wed,  5 Nov 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LO5u0mXX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C025E469
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360070; cv=none; b=PV2ympTb8TgKHkjQ7f7qiRsH5M+bKIJbXsK9ziJKXf/xvwamNCYa57aj6u6pb3JAuRKgdxTd1D/VEvVVxGyRJwSk/GdqCIKQfnOqJpUjfXIE+QutAwK9AC3UIv0yukUPln+toxP4bOIi0ObBrrDJ+ZwUQ8ozzk+YZ5bK97OKy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360070; c=relaxed/simple;
	bh=ScYFsi+CQ2znfz+Ybc9cX2mvEmOBus4QcA5+jXyJO4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSDjIku/SmVxo9mhciKIzgczMJtc7dAKh4K+JNow5LMxNaWQ1gmLPvK+xraWoFQvFwJWZxdFCRlfEB+e54MLMrFhQIzE6TrvAGBwSAiiDRtPfKRvqUGJE4tzUJMtthkVdFbzvAx6i2fAIUYVQirnCpxeo5pahrU4PWajToVctAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LO5u0mXX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477549b3082so18784875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762360065; x=1762964865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPja7sf7hTqS15KwtFLZrtw6wHJoXtgzrlY7dcNk5wY=;
        b=LO5u0mXXPgpGzWJ/ZlQanQb41npsPnM7rqiJgdHrjx+d0J5slOTJIHPJGXcQkESwP0
         HvA24CiFH2l0Jd/+JC1NF31kuOKaYM32VFXp8hB6gyNvZjey+7JEEprTlNEDbi12OROz
         y5CTQjUHdcOC5iXQCC0LEIxS2pafd/huBU2i8muo2mc81pvrQU0CuFWKe5m/KvY7MkJ6
         anbEYFhdUdWNjooSSXjsUvEVjEKT+1Lxr7FBoVHfpLL1cp6Gmst30D+8Vq2p//Edvfnr
         G5Fx6EpAvWgRHfLkBzPDDDtfwC0z94OL9kH5eZLD2l729mNM6wSW1tz84deNJ8sZTsoG
         qe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360065; x=1762964865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPja7sf7hTqS15KwtFLZrtw6wHJoXtgzrlY7dcNk5wY=;
        b=wSSWwPdkqfdZNnaYA32kgmL3a57/13Hw5QWDZVoXR13bGtt90Ka+UGSOlEr2bU6b0I
         sT3arLGN1q4vcSItmTP6o5gD9GhzUokcVj8YwwAxIjXyGeUL96sU55HFDhXj7mbssdjn
         aEuvcyyp8d5dibT5pUvdroiD/jO8PgQNsNyWDc0v1iCZ9mLidv3s974nR/EVgryQQ7BI
         vm/k3cYTVb+Bs3OcGMXduMXM91JbI5UppvsOOG8p7iu1J1/hKCqD248ESF44xiOxnWZD
         GkTklDKrnHJXWOrOXsnqGjelh/glAgfR68n7NmG1l9HGkNCcWSWGyZZUX9zktnzs8RKq
         wMJA==
X-Gm-Message-State: AOJu0Yz5De77wW90s5HfOalIroNjUl8yKx3UoMiDjJPeqr0y1Ujtqq17
	H6RfyA62Gx1jUHfIDTHcRKlqMQfA6R1dz8p5RAb5tmrta/QmUWfihxkpHm1TF25Uwp6QbMO0m8i
	/qEOF
X-Gm-Gg: ASbGncu8hn5yl4CdA3CERcDPDazHqfrtldNTyWkVAtYCZ0ZsxQNZ4b+GQIu9XWs1jVx
	egZmsvS2BBEbZdsI2ZbHDwxtYQjaXTb/Y2X+rQtviqPBVPFrwhofC9w8w5reRJVGSBqbw3g+Obd
	D9nJaC6tDTF0XMrm6K7rtTH3zQYVNFqC7MfKgdqxY028krK+b/UQwkCWAdzzmilrjtZBBwDg7qh
	iyJGka1+pQ+saBMZmAa6dxubo/ZDwBRhO415b3V1QDAv6WCvVczauBmkJSU4XRDtRaqZNgrG8L9
	LknaJ946nnHF7e7ZA76kS2/cN5925mq5qDno1vIqQfD9OmNbYc7g0vji2COy/nzyN/Tp5wvmoMG
	JVgupcg4Pdrc3MCOJjMfTd42Pr+otql72mlvCCrOAUStXGR5AruErB8yozhbSm2Zc6c+derVDS0
	H95FxzKyJW5bBHaE/5ixCn8Ic=
X-Google-Smtp-Source: AGHT+IEfCYki37HXIu7pIIWRGgwPvbyC4maoBsPjyr/idkvFdo2OcoNGGQjYZ+hklJH1J0DTrM799g==
X-Received: by 2002:a05:600c:4e48:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-4775cdacf79mr29064435e9.5.1762360065114;
        Wed, 05 Nov 2025 08:27:45 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdee965sm57114305e9.17.2025.11.05.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:27:44 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH] thunderbolt: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 17:27:36 +0100
Message-ID: <20251105162736.320591-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the old behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/thunderbolt/tb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 4a94cb406bdf..7a3f76a852de 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2636,7 +2636,7 @@ static int tb_alloc_dp_bandwidth(struct tb_tunnel *tunnel, int *requested_up,
 				 * the 10s already expired and we should
 				 * give the reserved back to others).
 				 */
-				mod_delayed_work(system_wq, &group->release_work,
+				mod_delayed_work(system_percpu_wq, &group->release_work,
 					msecs_to_jiffies(TB_RELEASE_BW_TIMEOUT));
 			}
 		}
-- 
2.51.1


