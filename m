Return-Path: <linux-kernel+bounces-802445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849CAB45278
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53171899AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D330CDAF;
	Fri,  5 Sep 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MQ6ZgIuv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563527BF7E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062985; cv=none; b=fNnOVqSD27EEBzzpYiq+ZB2X6Dajr6BVsB2Vfxgy+TuXr2SykLdSTADWlUPuURu1vSZfzhd0/7XW4t2chAVyqoyL64aQ9FgG3QHNt9uuo30tqO2LbPADys0DgFFkBZ6v05VPhRGUnUZgS5mOBO0PzmhbTranN3RCOXAyLAObmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062985; c=relaxed/simple;
	bh=VaAvxpmvWpcIRNYfIuBLuLBDWVBAraDDL2Dkr33I3Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5B+69f2FTUYZI94Bmdxy1vQ5DaW18IvD0agyb4d2eYFbGf9i+F1KFl1kzlRvGfL34VqByyCyegof/ISD1S4EBGtX+aLguy8KhZRZT1i7XvIjeH6/kTn5n7jW77EJFZ4zl/c6dYoOEiP+cUO3pMC5eLgPDq77eyTiSssd+X5ILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MQ6ZgIuv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso7482825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062982; x=1757667782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt/BTMnZjbckMMcIPhoa5XW7IR0P0ZrQGAwnv9I0YWM=;
        b=MQ6ZgIuvqyn4wYzMaFqInMzUR18fRIKPXaHdiIbE59jEnnttwgLehx2cvveZdZlYxI
         wXM5Sa2rfGGUL4n6OZtgSLrI0wYXGM5W7D0d3yj58Ub5902B2uCEAL2TOabOkdqDXUYu
         8n92A7Y/lxnmFCdKQrALU3aqHQ9uTBfmvvUkSio0XhYCWj0+BOKbiY3qtNaOOMMsYAnl
         n326mcTkxviT+IXAn+niLhbl/Qz0xWmym/dMDe52513uje5vRwzsNlcZ/j/nHUkAX+LC
         D7+Bb5bETitnppHf6gp9gAMg1F1Dkw8qLIwmULTL8JPrYvbP2PqDfFRXXTgphjvsB12a
         IkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062982; x=1757667782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt/BTMnZjbckMMcIPhoa5XW7IR0P0ZrQGAwnv9I0YWM=;
        b=BnkXGJiJti7c+gd8l/9NFKS65ntp6bV7NoDm2JWxB/oes3RIDYDx4TsylUB+lOgmJO
         1kRVv+QGJoCC4DvCt1PpyeJ7JeL/jkT+x/BsbOwVqmz3XLju8tDU7CgkakeiweXA9eqU
         b13J4BiCHMmRY5VGNqgpNrQdMUf2mUrsv5ZfHPTc4V7xsVQ3MCYNvHrzb/wLiBUhJf+F
         DpP0mNS52s4c3E2v7LoNkNWw0/TgS1FlcUdmm3vXahIzbPiO/aoYiGTu9vy0+Ntr2nyx
         7vzTH/rNyJT0+NLl79bONhg5Gp+li9Z79fcHuWvyu/l2auk2ArYvEomntlUjq4/b4Uyi
         f/Rw==
X-Gm-Message-State: AOJu0YztPbxVIQmmrHmqcIf6hDzsOHttqilIpOkbntvQcYNMoCTdugbl
	uIbWwatpfSwEnGF1U5fGaO5m8DD8oSfiVeGAa5gwpM47K2RndT1EX6Bu19ei7pvyISipU4MS7Zn
	z2QGH
X-Gm-Gg: ASbGncsl9SqCRFJs/t8zwruKRX33np5LtKx4yjrYRlg+abhBR+KOoIzGmqtcqjL5jMq
	P9y/VBp6CckzMDMISlsSWBgXz7E68F4LddGif6lEupPLdsG9SI2vME3IuAWSA41ChyC5uvVL9Yh
	S1FLTgqoch3x4ZGHqZWiMiawI4lCMn1AebEM2HLOvHpiQPBRpt/PQYxS0Djal0Z0APabCL1KnPI
	hLFdKDTvyLHnGouswpoOfrJdoaJ5la00wgEElQmCDiXoO/G6eN/t/plbFxdPkaJvXCsdmDmGBdP
	YzSOjZxzKh11KePuuqwMf3d4TRyOgYxV0Cbi/KUIyl8G2BVOin5AJvFQkYjKp0phyqcPF3Xtwpu
	6hMcCno/qlr+jjZGG12kARXPtXOt3DcTQDXpBNoCTZqE/fwQ=
X-Google-Smtp-Source: AGHT+IG24LG76Z8S7qjGz27+3F1ALNcnbEoV9/XxGeTDwaPVM8Afb0DdvYFTxZIXBCPoWwayYgKRDQ==
X-Received: by 2002:a05:600c:3153:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-45b85570cffmr189956765e9.23.1757062981863;
        Fri, 05 Sep 2025 02:03:01 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d66b013b7dsm19653105f8f.28.2025.09.05.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:03:01 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/2] io_uring: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:02:40 +0200
Message-ID: <20250905090240.102790-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090240.102790-1-marco.crivellari@suse.com>
References: <20250905090240.102790-1-marco.crivellari@suse.com>
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
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 2a6ead3c7d36..74972ecf2045 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2983,7 +2983,7 @@ static __cold void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 
 	INIT_WORK(&ctx->exit_work, io_ring_exit_work);
 	/*
-	 * Use system_unbound_wq to avoid spawning tons of event kworkers
+	 * Use system_dfl_wq to avoid spawning tons of event kworkers
 	 * if we're exiting a ton of rings at the same time. It just adds
 	 * noise and overhead, there's no discernable change in runtime
 	 * over using system_percpu_wq.
-- 
2.51.0


