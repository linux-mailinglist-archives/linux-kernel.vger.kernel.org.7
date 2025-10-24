Return-Path: <linux-kernel+bounces-868579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E55EC058C2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1623AE458
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157D30F92A;
	Fri, 24 Oct 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DBInBZjj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D230F7F7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301161; cv=none; b=b2w1g/UCDdnICX1SFuFO1/jtqHu/gY1Anrj0boVqD2JV6BGdb9oNdG27R+cTzBSE2gAXkQH9H0OWVDA2abEG6RddnXaeWFhjXa6/DR27X9Z1kzps7qOwetqXINnsbC1hVrHbRX31ihIU1ORy9mEQSGV8LUMoAQQWjRqr/NkQABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301161; c=relaxed/simple;
	bh=Lkciv/B8ZAuPwj+weT53Weglv8lWUyMUl2v4l/65Kp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCp3EVNG8PCOejEiZ1ZNfI9dBes2g/V0nkKX/GvCy+yOngq76HLXyXcuAoJGyPdeKHpWbO7lUB+m57ayb/nwnBcsRM6wwUDn+vBm/IvJq2XIfW8fXof4/XesV6C8DEV/+MgF2CZL3kYtJQ0cwf8C835/DQVsaEN2HEFGWqlx/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DBInBZjj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1653166f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761301158; x=1761905958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugmv/FKfXXvgUX6AmhpENgX/uhCwrr+UISxTLvtIUjk=;
        b=DBInBZjjHqfFjBpjORraOKH7xmhpxzjlDEhgTNjUP9Joy2pqlMagpXj6zjgxiDyv40
         Um0fbHLu4quY/OWW564vnrBz1iBXah2Vrp2lJUmrgKfnNEv9gmBrG39dWee/eRuACyBt
         arC4MJ/FMrhkluOeA3CSpYMboy9UpX8zLQBLP7hk4iB1b/X9xlObxBnWZLgWcAzkScQ2
         YgTt22i9SIZT/yb/SfTGoO3baEIBqQAGKXhnv7nh/+AlGsnVp+5xVcJDizfTZ6r3olHi
         fzBMHcU/yJXVZTQCrCwDtHiTHNlFrEPzfHicEdHlHUGMuZRJu9dedQQRlewwFBYCKGAu
         CjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301158; x=1761905958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugmv/FKfXXvgUX6AmhpENgX/uhCwrr+UISxTLvtIUjk=;
        b=Z8/8np9KZFzwQeCVXwhUt/rvRIcvabyE1C3fyQdFF5b8Eo/KtoSuYg75EvLIz4cPHj
         4ih8aGfqmMZKXKIZiMG/ahMfbaQE5FR8fJmh1KFHpuWwm+GSLkStLX9HMbEhXQRmxEmS
         pVA8+YwxxVRMzGJb+9s0ljtTWMOsWSpJcUMAOaGr4tJ61DXZF28g5HEnuKhmJgNTzkgC
         fHXyGiEi3l1p5aS9Zq5uq+0+B0lu7+36ayR7plT9xPsXJzeu/oa8dqzHB4qpDvTLLqCd
         xjClt1ZcC/4uLPHpBUO5+Z8gq6WbiqiEgemvY/dCjB13P2eB15CxlL5dmtw5w7M9af6/
         f/Rg==
X-Gm-Message-State: AOJu0YwvXdg1Z5E17P0Uw6FsjZQ6iLb0ooJWVyLsI0/uVeLsDbOcpTOw
	AjQEAL0q+S2CxXrzJSEXcBbXXVHMaYu2j0YtZLa9p7XEYMh8ACNz4FCLsDTsDtm4tpsr72ZxE9k
	Sf+ts
X-Gm-Gg: ASbGncv+tZLphSygmvTEc7iF57NFfU88bjYE5O4y/aBzuTbkb3DvVJ2/UsM1P3f69P0
	scYqUlmKXr14TgN1fG7sYy/ohsGdsVd45rrwObzFp7K8nDbskgSy4tW+e2/2UQCEEYhsBmnoUGW
	UlsJ3B+volqjPvGTsHCidUkhU2vHTVXnR+f/VvX1QLQPW4ym+fwFBHE6W8bMu5woYWopN4LDJ18
	CPaPGIF8yr5KRuyaeTpFG19jbXAyOups6c18nrWMMTMCloLX2Wh8qMWTl1/EEHCMgcER38Cznpx
	Y6lVdjPpGrMzQdnVRszTIMwQXCG9K3nv7gwLhQ8gIGzKyfKmVJbAg/j6vF57uG+uXz7QmR4sA0l
	pOnialjrPtfN5qVLDaPL2TQM+a/z5fTSBWA4LfmkdakpYj35y02Fgiq4n+G0i/LOqp2Ujpo5eTV
	zPMeduNdRQ/xjH2eFcdGawtkJu
X-Google-Smtp-Source: AGHT+IFo1e+SSCggqmiz/ZwTZcTSQJ36JzYF2JuARwEm9Wcb6K0n6uFSgCDD08HQuxUjSN8NRQwDqg==
X-Received: by 2002:a05:6000:40dd:b0:428:52d1:73ab with SMTP id ffacd0b85a97d-42852d17555mr8174618f8f.58.1761301157812;
        Fri, 24 Oct 2025 03:19:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f52aasm8372695f8f.12.2025.10.24.03.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:19:17 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/3] driver core: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 24 Oct 2025 12:19:02 +0200
Message-ID: <20251024101904.146351-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024101904.146351-1-marco.crivellari@suse.com>
References: <20251024101904.146351-1-marco.crivellari@suse.com>
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

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 13ab98e033ea..4938a132a085 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -193,7 +193,7 @@ void driver_deferred_probe_trigger(void)
 	 * Kick the re-probe thread.  It may already be scheduled, but it is
 	 * safe to kick it again.
 	 */
-	queue_work(system_unbound_wq, &deferred_probe_work);
+	queue_work(system_dfl_wq, &deferred_probe_work);
 }
 
 /**
-- 
2.51.0


