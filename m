Return-Path: <linux-kernel+bounces-868546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C1C056F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAD91AA2C53
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761130DD09;
	Fri, 24 Oct 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZwaYodZl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94230C63E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299541; cv=none; b=nvzrv2fG1qFq2OpzA0yRZTQUQ7u8wF1BDWpwuCKgyUTdfnmf1Twz35bQ/bCE/2JjuGJ6DU4pmL0vrkMQT7V5fkCLqD4Kjj6bGSonmmN0IdjvzuBxGj1ct5NwtM1ANULcnr7BoiD5XROc0gZCdPvhikjoCfj6FNRKMJTxRdaORkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299541; c=relaxed/simple;
	bh=HPUYsFiqxKAXZMUXJGm2P4ah1g8qjFd+qqL3B85O7Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5kw+QWCPmmjd29HhhTk5ca1JmQaINKIPrji9SyOfCu8ZdNFEP/Sr9BW9cT0VQydO7lteucIxYe3VctVL0ZavFnzDzqltF45PqkAY3UjlPDYe5xfrawthbxH81EcmJ+H5ieJ8SAJ4L2jVO6pyJAXj5sG6pbP4sA9WB53+BSPce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZwaYodZl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so9634655e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761299537; x=1761904337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB2JNLaaiAn3pH3zpI/FXAb8vE+Bng5cZSPLjc8q0bE=;
        b=ZwaYodZlOorf6gOSEI27pzqXNQIALYCz6OTqqnO4P0azZ/iU//fe2ZCZC/3yDrVJzF
         NscSrjlvSkesNBfVe3XYaxCpFFAavqgBWKZyxAY36eQaJNXxDsgzFjYIe3JWQHbG4/i4
         2o9lSt5TUUmUDbYlIYEYyKhPH8j1SbrCabvp5eEGr2NMm8iUYKz5AvusypANFNXM0lNq
         go3JduaW4lrKYGjv6KMKaUeHADKOIDEe0BuWC4eGVmhtgKSVNZY8HqZU76dEy52tN/7r
         w6sZW7DxirxjQ0XB6jdovE84mVEp5y264H2R7WFh6F2wCRNYciL9t/DNconofEUXRY1o
         VztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299537; x=1761904337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB2JNLaaiAn3pH3zpI/FXAb8vE+Bng5cZSPLjc8q0bE=;
        b=maMB1lAVhc3gLDsmnFFcNQejLd9MOW6xuCEtL3xobo10sLMxbY05UD8F7J0uEZ/56n
         +bFwK98kgSGWoia5VDDGsUBq0c/WH6TcxpoOKkuOwm0OXjli4iilcn9cncHZyWqPSBGD
         1bJqu2mcRFGjgxn8iYu4zZjCO0JZlqqvd9tK6KpTBYZ2j3XRKAClrtV7DfOkUu3OYVUM
         I6QBT+E8Byh2Yx6CqAzFQPyclO/N6A2z5Z/asP0HwG+/GTpps7lAvAPpGBufGUqDu+zw
         Wcu1GrfkCBwrEJrAn5Va1+UjZv+6dbqCcYtlLPRk/DrzyNNCwqiJJi9dcP4K6HxS6IG0
         j7eQ==
X-Gm-Message-State: AOJu0YzyHfxOeTGNLhLq78R0taHTgVYHtFjFJ2IEi9iUWIKo8yHKJxJ1
	XwMOFwZGGaOmPs0qnvogm+da9tWSW2b2/hvANio/GwXz6TKN5WJfAhcSKxFGSVd1835SzuBVAFW
	iHZfU
X-Gm-Gg: ASbGncsp8Hyb3S+T0JUDx8hA1vFQej1PpgaDvIEoRCQ8c1eXkdTjg0RImylOTSJShMM
	72BYBBZmy1S367JecyOMvGkKqe25A83X4ZyW7xOBC7pKLBM8XiH9MAin6OvKakkUhiOepj8DRcn
	VSpA6PEgTxte6zlpwkHKrjcbr2gS/oTYbAADEg1OsB3GqTp/xyLeJiOktCisSk4AR9iDFfz15zA
	sOwVOFZnpBR1h75Jpw1R18t77GgOP4vX67w6jpNl2/y5HN55td0mPv75A1ia/dKLhp6H8jYumE+
	/hbIJlep9XYzNh+rJruawTWRXmp4c/txAyPpoOg6rOgJKCmShb/BtuJXUc/RPfzbOfZGF7I0tIy
	hZFksg5TkAEv72Lk5CtsQ5PYoLMVvkpyY+B8iixxlSHWC6p3mpUgLX7fLE1sjU65F3V6NoF/ikx
	m33S57Rx28k6lMHkX0aRi3XYz0
X-Google-Smtp-Source: AGHT+IG9UrAVJY9k+lxCOX2VOATViY8kr0GIMVcZrOkxf6lTmiRwzoVcbu2hrw9RPBg1Zg3p5iG0BA==
X-Received: by 2002:a05:600c:4448:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47117912b0dmr203107995e9.31.1761299537249;
        Fri, 24 Oct 2025 02:52:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57b7sm8402376f8f.16.2025.10.24.02.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:52:17 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH 1/2] accel/ivpu: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 24 Oct 2025 11:52:04 +0200
Message-ID: <20251024095205.123123-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024095205.123123-1-marco.crivellari@suse.com>
References: <20251024095205.123123-1-marco.crivellari@suse.com>
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
 drivers/accel/ivpu/ivpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 475ddc94f1cf..ffa2ba7cafe2 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -186,7 +186,7 @@ void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
 	if (atomic_cmpxchg(&vdev->pm->reset_pending, 0, 1) == 0) {
 		ivpu_hw_diagnose_failure(vdev);
 		ivpu_hw_irq_disable(vdev); /* Disable IRQ early to protect from IRQ storm */
-		queue_work(system_unbound_wq, &vdev->pm->recovery_work);
+		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
 	}
 }
 
-- 
2.51.0


