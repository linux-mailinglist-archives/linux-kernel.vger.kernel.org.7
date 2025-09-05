Return-Path: <linux-kernel+bounces-802402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9BB4520E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E4C58413D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55E2FF172;
	Fri,  5 Sep 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RJK9eNQ8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCA27E040
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062334; cv=none; b=RmhjnhUVdjK4rpOEfyt3LqHeiKghTa9oMKeCBOIg7ttgIzja+AsS1Isb+9R70ETp/SHoaO/KkS7h8LaL1LdNF0U+dVSMSUkzgYGyJqZvy1BvvIsArYm6ysgzsXfyFM3jLcQvy6ZK8mFljnmmgQuPqz3nvWOl825LQvxrU1Fx7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062334; c=relaxed/simple;
	bh=JvX7TqkBXPSB8OitMgWG1eESIdw6g3S6GklBekHhnLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9sJtLGc7d5kRqAbLl0tdELKzluPMcQ5FHYs1D1MvvlId6a1FhhQ+XX5GDjn+h7TGDIBokvBUPL7jPebD2k9mbfe3vDBcO7pVYG0i+OWdzqDhYiKrnt/Wgs+n4FctipUWM7LHULICKfErUSqoZVRk3iv6au2rbZ/jTFxiwAxAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RJK9eNQ8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so17892285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062330; x=1757667130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4OYQnEDg2MM33An1P1417ylBBWSz1KWKHVVwtk+B0Y=;
        b=RJK9eNQ8NtG1DjQt93AMB4WCTuw0VWhar18lbJMEpGdvB0Eh3efS8NpMuxj+p9GuXq
         gcnQT0VBtfXHR2SL15funqBpFaWXP9uxrpIEbvE5seSAkhxDHQuO/R9mHZmxHHhbqmOQ
         sHyhotVjGHjDTykHs/FBSrFkqJqxGr0rf7X3BXC/WdkW/EVccFleQxwZ42yDy6p78PQQ
         dj1YMFZR68KGAeDILcxknWjlHh1o8ZdthqnT/tuQcTY+imHKG3xR2PlS5okQ01Lxqchs
         rnhFso7L2Pe86x7xeDBrS6VExKfqZx8CG/n0klM1/aq/BDvGpbpNqh9K4LQFtK+iGwQF
         3kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062330; x=1757667130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4OYQnEDg2MM33An1P1417ylBBWSz1KWKHVVwtk+B0Y=;
        b=A7sKk4SnqFKpiuBXPZ60lg9bqNE/HIhZLIwCUsZUp5ZT0CSjT7MH134v/jl0SUG6Iy
         HdbU6UvIZWgZLPmk1iCAWLzvnUiiBDF6nfu3KxuIkKv82y76v8x4hN3L3qtSjRT99Js7
         yyWC7aYgYLS07I3Jm+YU/85++pofJboyPbVJ7D4dMJnkVku2N6cww0iE9i8MlPAStb8K
         ElF/3MStLhGWg7/4bp2niDRpBpSU/eJGkaaGbnGap8Bf5KBBC9Iyh/PWeAkxlr2dOm08
         OnknbpT/OrvqhI+c6fQ5h4ddU5Y6yUIWqxmJ6IU4Ob68nkiZmArK7GAB0JdwAil6c4D5
         lDsQ==
X-Gm-Message-State: AOJu0Yw2o8d87fbhPyevJt6o5QNA7iwdmbBdMwksB7vSC0VJcWqKl47N
	D/Ph4fwHUw1gvjpy2/qK8yYUWESU+KwC3/PRPWR4i7vTBX7b0bqrqzoHqJn+eUVpLUJ8skcejGS
	H0HoQ
X-Gm-Gg: ASbGncsDpHlkMtJsNtn6tBDdPV7oi4PgSOIw/HF+PH7lEWaaRsph2pqIm18f1fzN2t+
	7mZ0QcGDGt5nGvQGc/2YQIRqg9NecOkXQQgqeyrOEfo2U8x+6K+ndS9s1RBAjw92ihH93B9iuAB
	KjXL6mORtUM8QEchxvaXyqOpo0Ils7oJHxOq9giol3YJeTf+5YW/9/2M6VNX3qMi28gZW815izk
	U+DCphRrnl5ggdd8nUu6lfxf8rSn3Iy1t21zp9hDZeHfp6M4Jsr1pON4m3pvCC+JWA1IZoGZpsW
	bquGHe4wL6augtuZIFMl25JQiDQf9JcqouDOnNVOG6bIDaQXdSIJSNSQzSRXLVinRNwsZQ0AXwR
	tlgxPy7y6WuXgDG/jrMhs+aTlE8j5Y2fNbexBFFPzVJxTJEq60kgaaVHo+Q==
X-Google-Smtp-Source: AGHT+IEqBd4ds0RW6PXStRIDBwTEDhSLakCtAA3K8GPmgNvMAMaafWSh2e4vyXdrFtjFO7ZutFqBzg==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b85550704mr189754635e9.4.1757062330275;
        Fri, 05 Sep 2025 01:52:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b940bbc0dsm166359115e9.2.2025.09.05.01.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:52:09 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] drivers/block: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 10:51:39 +0200
Message-ID: <20250905085141.93357-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085141.93357-1-marco.crivellari@suse.com>
References: <20250905085141.93357-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/block/nbd.c    | 2 +-
 drivers/block/sunvdc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7bdc7eb808ea..7738fce177fa 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -311,7 +311,7 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 		if (args) {
 			INIT_WORK(&args->work, nbd_dead_link_work);
 			args->index = nbd->index;
-			queue_work(system_wq, &args->work);
+			queue_work(system_percpu_wq, &args->work);
 		}
 	}
 	if (!nsock->dead) {
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index b5727dea15bd..442546b05df8 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1187,7 +1187,7 @@ static void vdc_ldc_reset(struct vdc_port *port)
 	}
 
 	if (port->ldc_timeout)
-		mod_delayed_work(system_wq, &port->ldc_reset_timer_work,
+		mod_delayed_work(system_percpu_wq, &port->ldc_reset_timer_work,
 			  round_jiffies(jiffies + HZ * port->ldc_timeout));
 	mod_timer(&port->vio.timer, round_jiffies(jiffies + HZ));
 	return;
-- 
2.51.0


