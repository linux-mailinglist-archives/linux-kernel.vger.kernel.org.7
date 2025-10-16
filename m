Return-Path: <linux-kernel+bounces-856365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BEBE3FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40E7B4E3C98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B53469E3;
	Thu, 16 Oct 2025 14:47:09 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8943451D4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626028; cv=none; b=q+y7i87o0QgcvVQdbrTWiWGEa1rsdODqf+jGo7NMp37bb5Q4la8EM6ORjKANNcJdnn3IWoofVFq70mvyCP2US5dJMsmY1AtBrdwVwwWB4ZwR1nhgugwCGd9/HfEDWSZCnfEMZ9bsi8BSmm7VOHPIP1vsz7jkO2eGaJXThQpDhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626028; c=relaxed/simple;
	bh=qrYx4OQbtVttMxYPNSKZyKUM/2EziepE/DMT9sZuO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkDipp+oaAqHfO27lZ8qwPopnkpZbbSw8VG2TUPfE26ONobi87cI0d/9DJUObPsgSzdMqOYrF2SAcFZ53rSd+uAElbDdJ/XD6W0MA4xaHHWrE6iQy4BFeavyl2e/WgJ41uj2WzbRGx6PrVMrTDmEQEYy0pnd/jmRYN4YjKOhSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-651c521980cso201222eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626026; x=1761230826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6FTC4pXxezWlArm57ZmRQwBfAYH7sPfczRlTm0tzCY=;
        b=KJ+EGm9BsgG/veLP+hLNS51rIoOSHDkUyxwHy7KHUrudKGUcxfvnYzSm6UCAVkk6Pu
         uBSSBZXBjHbu2ZXT0TfC8DUi8Fpeg9E9LSeLp0lh7UJpRq7V1HyeeqwAPZytmHwh1/hU
         sLImSicyMeUEiP/tGHt0fcb6Sm8hkvLdPinLETlBTTMa0lGBjvBoN9N1adLaa7p3MLrQ
         okamhjqndIBJPIt2hH8LwZC60a1CF6gP2F9ghsmkFyTmnerFBO+5dh0PGNci1XL3GYpm
         qG5TP+orTDFk/9o5UA2HHxrbIDvAy65IP23xnKzL/RjEUdoqND/fSg7YPXCuWM/nXTf8
         +olQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnB5Coeqxr5Ftd3A//00NxSq4On7FsmV8YuN6mqOhLKLieygWkVZv1s6wFfIXtOvs9ocU64eYXw9Ef1aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrR/yBxQx4mqT36TftrVD4DEu0IMIOpPJhGYfiOkOFHjKFHuW
	OFxOwfR8HMugE6Enb6EO8P1BnMLqABmeOcB4YtvMVjUkI8uMz31KdBZk
X-Gm-Gg: ASbGncuSPZBvgn+lg1FTq596VH1rX8sRrycpHvuBAnnr1XJqpovqqQLigSVCp9vXER8
	1huKiHm+0hLE7syk4K3ygZJEVO5wCDzEh3vzXIC/E647seljIYE0Pj0LHQBjpEAZPF4h7Sh0q+G
	e/60K1qaa4nEk1QqLcMLnrnUE0aUR19VdKcR7eG11G7OMrCO5tQ2Mw9JBvw9ySDq+TbzL439ww4
	cIsWodIWv1ICy+DINNoiduRvnKuxTT0IEIbSQZ82p9ZzVMmm6cA/bqIM187P6fA/NR9ZZFb7Tvo
	aE0CPNsQYZg9Qvm2EDAGaUM24q5JvoAi44V6q6RbiRAP6uPi6Q4nJhq9G9+4uGBrkQwOmJKIWvf
	H6s5MMsuxpgWXok86KpHiZiTMn2lXbkv/+y/EvANC8F7UgKvy3RSgp4LiYzR2yfjS88i9B9rsx/
	FCkaFKdfB18DoIDuHL662EF6ax/ANG1DfhRlvi6hwBeX2DiHOtovyHDFYsV1iXHXhikQI=
X-Google-Smtp-Source: AGHT+IEqY0Itcc1XjdzEUHZg7NibgLkNaNHb6IF/rm8TnzxUng5S0hLv2Izsxr0tjhoHkMDieMlXEQ==
X-Received: by 2002:a05:6808:4f0a:b0:441:fb07:c178 with SMTP id 5614622812f47-443a2ed0503mr112853b6e.8.1760626026415;
        Thu, 16 Oct 2025 07:47:06 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:06 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Roman Storozhenko <romeusmeister@gmail.com>,
	Jonathan Perry <yonch@yonch.com>
Subject: [PATCH 5/8] resctrl: Propagate CPU mask validation error via rr->err
Date: Thu, 16 Oct 2025 09:46:53 -0500
Message-ID: <20251016144656.74928-6-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016144656.74928-1-yonch@yonch.com>
References: <20251016144656.74928-1-yonch@yonch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __mon_event_count() rejects a CPU because it is not in the
domain's mask (or does not match the cacheinfo domain), it returned
-EINVAL but did not set rr->err. mon_event_count() then discarded the
return value, which made failures harder to diagnose.

Set rr->err = -EINVAL before returning in both validation checks so
the error is visible to callers and can trigger WARN_ONCE() in the
PMU .read path.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/monitor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 4076336fbba6..4d19c2ec823f 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -445,8 +445,10 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 
 	if (rr->d) {
 		/* Reading a single domain, must be on a CPU in that domain. */
-		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask)) {
+			rr->err = -EINVAL;
 			return -EINVAL;
+		}
 		if (rr->is_mbm_cntr)
 			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
 							 rr->evtid, &tval);
@@ -462,8 +464,10 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	}
 
 	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map)) {
+		rr->err = -EINVAL;
 		return -EINVAL;
+	}
 
 	/*
 	 * Legacy files must report the sum of an event across all

