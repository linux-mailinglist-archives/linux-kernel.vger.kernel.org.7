Return-Path: <linux-kernel+bounces-821195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDBDB80B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74E74A30EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B233FC71;
	Wed, 17 Sep 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FMWpqQNR"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949B33DC9F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123551; cv=none; b=cEOPDLYVCbq4e8BPFCTwgRpUpYtMd7shpqrcHfM7bZQeI13wyGli80U1ASY7JJAvaMIspeg6Wx1qAwa1eGGvjTzgeGWB30zxdUr2b73h+Ka53Qj3GqRQkULYBVUi5HBq0RH4bmbnsnEql6TvUoIcx54Tgjwza1UE7xUSbEdZpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123551; c=relaxed/simple;
	bh=PFpgUHub9Fmrzg3KWGWHTh2JxvycLlcMGTk6OArN/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvgIWSkYbQdhqbVRKvubJ295JnPoY0YhpTkeNQ/cJStIy1xd2fgQWk3gDljmc7laaII6zd8etPEkCkkLrc651QNCy+5p4TxA4Zas13cTvWm6XnFkihmmcVfVH4fP54rNfkCWJ2ivK0unA5TwZ0R4YeRwlRa6XdbQgZ/VlCJ86B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FMWpqQNR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e7636aa65fso6273827f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123547; x=1758728347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugO1a/jnTXgfFN8ZtCaUDxIdkHkZGhM95Bkr0uu7zSk=;
        b=FMWpqQNRw1flZ8OPXoYkB4mcVE60DDpesxCaq8U7p1UszGFufAuXoDiuXgtVs1EncV
         37o2Q6b3k6s/rulDZX9SIodBuDWPr+n7Hkyi6SZfhMCP6nVYf1Z8jEoGkpQ/LX5Fydbc
         DHKMr0FzqVqDVdSnMlRSHhhZuLCYxhyHPEsr25cfX78yKZe0s12oDo5TgKwUXOzcizx4
         oJAP3BWHa0vc4aQ8tXPeUJC9I5lRBimFC36a7+EOs68SKVBvnsfgyMoKY8yQEv2dG0tU
         pVlNQTkiDs17U3pwJkQX4olokxnWiicg4LR30Xc196S8KBfO08v657Pu0Mr3z+8Hhlwo
         wxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123547; x=1758728347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugO1a/jnTXgfFN8ZtCaUDxIdkHkZGhM95Bkr0uu7zSk=;
        b=Dflxv0DnNV0NKZxDEjySZHqEeMulq1gsgR613UCKsL7+L3+WKz3znoHwmOzwfhvMZI
         d7iFTyuadyQFrCSQbeahmBVlH5KjDIRNHHDKOrNfSZ4GRqnpfrUjOHMCLymDc0hRZAQx
         NvESxFvdq5fdoKYiXZw54Yvcd1mJ5JjPkK+6rSijba52NOuoq9GKx7QT6tn2etC4Go0E
         jXsOuVl0Zul71qvQtzeKBPEtmxD4wl4bp1GxeDF8ajVhuNxgditz4u2fsfOE8kFaEmB+
         KUgXcCkNJfNE143+N36N0lu7+2L5oqHm4mDVQ5UFVHZPd8YSQGEM4pdY/XgClXYazxd5
         unnQ==
X-Gm-Message-State: AOJu0YxUP3s1orAUYmb36YmvU/H6QRFpfzBUENgEvZ0hz9seZMlD3AYG
	VH5IyPH8mZfWovrKf2asxbKks5CZX0igQo8ipOdjSwFgsS8MkEvsMjSctqC7Gu+RhRLZCVt7Qhq
	+ZDv85GU=
X-Gm-Gg: ASbGncv790udTq38vP2A7l39UZcmoIO1zslnX8ghaWf+x6dTY1TNGMYaJude5k9NNss
	qytRgK0aomJ3Ro7FGRJ4sk4gYAS2kCTeMDrWnpxrCtfiPsg6+rcF4zF8eaFBhN+oFHZ2GNIsikG
	EXw4WEkXbrl+zZ1cPa3x4bIlscx7rpnk65HLlEARIsY62Bheb49mdUkb1kMxYVxHGt/KwgD79Pe
	dCblJfbSpf/KleqX05FOLxP0z5FirJUpMpb1vno+H1wdBlinK5kKZr+7kgsOheqj7bt022T1+3W
	g04hoTtBbRLCmUWN3NVDD5KnqGL9zX+6Pr4037H6pTskjotY5VRk/t+9XcnE0wynkR4TdnRYANu
	JuxQdAPV4ofxZnkgLebABj9aFTC7GWxugRNICjAjl+5knrIs=
X-Google-Smtp-Source: AGHT+IHD0ub/VA5RULYt1DM+OOxESsrSpInjb6TmYIn+FbY5msblQCDfU0OY3if9oubO64NJi4LszA==
X-Received: by 2002:a05:6000:40c8:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-3ecdf9b5961mr2081818f8f.6.1758123547162;
        Wed, 17 Sep 2025 08:39:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:06 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 2/3] s390/diag324: replace use of system_wq with system_percpu_wq
Date: Wed, 17 Sep 2025 17:38:58 +0200
Message-ID: <20250917153859.363593-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917153859.363593-1-marco.crivellari@suse.com>
References: <20250917153859.363593-1-marco.crivellari@suse.com>
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

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by renaming system_wq to system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 arch/s390/kernel/diag/diag324.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/diag/diag324.c b/arch/s390/kernel/diag/diag324.c
index 7fa4c0b7eb6c..f0a8b4841fb9 100644
--- a/arch/s390/kernel/diag/diag324.c
+++ b/arch/s390/kernel/diag/diag324.c
@@ -116,7 +116,7 @@ static void pibwork_handler(struct work_struct *work)
 	mutex_lock(&pibmutex);
 	timedout = ktime_add_ns(data->expire, PIBWORK_DELAY);
 	if (ktime_before(ktime_get(), timedout)) {
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		goto out;
 	}
 	vfree(data->pib);
@@ -174,7 +174,7 @@ long diag324_pibbuf(unsigned long arg)
 		pib_update(data);
 		data->sequence++;
 		data->expire = ktime_add_ns(ktime_get(), tod_to_ns(data->pib->intv));
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		first = false;
 	}
 	rc = data->rc;
-- 
2.51.0


