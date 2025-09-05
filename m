Return-Path: <linux-kernel+bounces-802490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC12B452C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA14C1894506
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708163093C9;
	Fri,  5 Sep 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M4cJcCJM"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0F27F727
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063490; cv=none; b=B7jAn1Ur1fNEUYpcPP6rVl2hW+oZTQAsgsAMnNyc2aQ6cKvyTJjn3ZbsUTN7VMGV0jZPHsqP959KM4b10+VSET6woS6m5qMwociv9+TOklVc+Xhdo72z1Swl6CAY15JLjoeYieR8eaXEcTWKyLlBhmluFL/Xpup0WzGTzPeeyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063490; c=relaxed/simple;
	bh=7hp29WZApu8Ab5sYyeGmPsaeQgNEr/ZilL3/+0dTZn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+sQBRk7/eGDt/9gKsFOMMdz0UkHVD3XsWR1WmFu3F1JE7uZCt8TVlm2hhHakSs2OCsMeATM1eS1kZ7Y3BF7V/ql0Pd8rYPUCdWKyR1GiKmnw4PxU2qcGqazD/nsNHoOeaEt5pF0sZafTBk+f6t96QPfGjGOsFj/Orm+G2lAe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M4cJcCJM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1714696f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063487; x=1757668287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgKKuFAHaammkc6CXNFK+x9sGajTKOHAMeSBsTj2M64=;
        b=M4cJcCJMq4+Sj+BZPPPR92el2M4hJhW3JyxEdxaiA1KXzNWeSHIkC9r6r2xtcZIqAx
         9NkPlXWA9k8b3O982BJZIMhaNxt4uXYkDcRbsYKjiOpVCvbFBpa2kgHsiIXVLgMhL93X
         tZEdZRpVCcHmXeFUpqo/kne/DZIHRotOogNmafV6KkDmb2Gw/jpDYfxedbi1R+Vtv5T0
         vmd3DP1Q+EGZbHPLxE1y4sKLdM9vYF5TsQ5LcOhcZ6+vM1c+/5WjxqNdiKfbssPbbYWe
         Vw3AngC8s2zkcHDo35TKJ0tnp1vZlIa+ajE9CuXfwJagxOen5uHjNqhYYxX/8fRWZ9kw
         esjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063487; x=1757668287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgKKuFAHaammkc6CXNFK+x9sGajTKOHAMeSBsTj2M64=;
        b=jz2X/dwNGNh9L8VSDLKRVMUzf3265880e4dw4ROh75qyAnbw8qox8+alnR9mnjIyfi
         r6ECnrAC5H+zT6QamiQ4Vdc+w0aA6YmzYLejOhbiFhoyiD9myZXVzmJg2O8+kfn3p02D
         jb1hdc1qtjyyHFDRMpx3myUeKHW95cc7FgY4cT/GFapBHgjBbBY8wa++PkmvwCIZyvGt
         La77ohcQVjSJpdIiH5dt/Ahd9S/5uhA/b1Uiw1UVy09hiFBlBLGW5ut5EfBTDbAW4Dd4
         Ex3LR/xQ2ygID/8uCaI9zh/9YvPPCRWoeNw+KPl1YeVRqVMgnlvjwgwz0a+EZEFEm/0g
         IzLg==
X-Gm-Message-State: AOJu0YyZSiM1/q870fWoDrlql8/g9WGjfkwl1TIXf3FX43ym2UdVjiSS
	YNzdZoTGm+lgYW7fWJgVF+BZ73Hh37YEvOvMnLHwkRBCnb9vmcguBSl5FQbGOeBfX439/PKF8Np
	msFaO16M=
X-Gm-Gg: ASbGncvnrugSolhl68tsN79CAd53tbcG01CDaRqT/6BEpUPp0foGHJNthPcHNE3NAqR
	G0ASW6pzpse629HeLhOApEUPkaXYMcjLyiryUR0G7cO3XUdVzKEufsPtzutGGkp2imAkg799P/N
	T/hOo4aUd2kclYMwMAVA7fMmA1ZGXBBT/MZPvdWJypWpTFELmrePDXP16oh7i44QxY4L9Am4omz
	bKb4RyCj8fwfYFCgUu7wgjyZgInTOGFYVHJhPWK9AWM3oLgdhIQYk2auJ+lewBtp+fmcWJ+OX2h
	w1+/L0nDJh6mq1cHNVizy0gH5DBVI/f2zGEiLCUtYOqnI58hL+7fRJ31qiHDi23n4XIL+JcqqmM
	3tXdC+TgbhK4Dv4h2n+V+HWGkX8nLjS/UhlAzng8pHvHu3eZ+eKeQS6tvmw==
X-Google-Smtp-Source: AGHT+IFQ5XJUeGx9CKd8Pth1oj/FhIQxkV3goyaYuRTX0J82Qb7dzk6BbaCJfXZh9ldarO88Th/HXA==
X-Received: by 2002:a05:6000:3110:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-3d1de4bc2e1mr17957248f8f.39.1757063486683;
        Fri, 05 Sep 2025 02:11:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98e77231sm146839215e9.12.2025.09.05.02.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:11:26 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/1] umh: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:11:16 +0200
Message-ID: <20250905091116.110314-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091116.110314-1-marco.crivellari@suse.com>
References: <20250905091116.110314-1-marco.crivellari@suse.com>
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
 kernel/umh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index b4da45a3a7cf..cda899327952 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -430,7 +430,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
 	sub_info->wait = wait;
 
-	queue_work(system_unbound_wq, &sub_info->work);
+	queue_work(system_dfl_wq, &sub_info->work);
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
-- 
2.51.0


