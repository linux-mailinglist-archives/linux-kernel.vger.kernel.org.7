Return-Path: <linux-kernel+bounces-878575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB4CC210D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EF11AA173F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D23655CE;
	Thu, 30 Oct 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PDSQpdEv"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2642D3A7C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839277; cv=none; b=nd6sTGwJkP4egIfq2sJs0+Hnc8PiAMnvn2PPQUeYy0awZdgTgONi+m/Qpnms6uxNNS5DBB0kPTptSqMOA+cBlhS0oSRXV6AP27uyO6XEsnpwYxFtPIIwIyIUZKl+kZKXdYKZ4sQbNUACa4ilMCQ0tzBBQCU3JriIcFjj9Sp6abk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839277; c=relaxed/simple;
	bh=/7LsG64oWK7wGZDkhEcwZF7KCXXElgpetNi9oy+Oo9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhAK9191CrNX/UK7YFXOhooHPfWFERjGfDJ8b3V70S4Q0D1eIiawjOtCjlqHAddTqJhI3iuOQT5r7DuWGlLP+ueD42P9BxTLVrUK+jrkL+NN34ncTxfEByp4+qHd5f+sBZbqjFmu4e+TVnKrRrhqs+6yOtc8Q8E4fKvs5i+H3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PDSQpdEv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4283be7df63so623085f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839274; x=1762444074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94J6pOSo9Nuw6aebkUjzuSFc2ureh881e+PTgGeW2qs=;
        b=PDSQpdEv9Va+o2beBQso0UH6T1ZDsLE5Vseo4p+/4PczU/zft4iLM1fkTeziawf1yU
         BLgs1Xf8cH5gZPJ1wb18Z2eu7CAD6PbtHroDHrV7jl6lXRGSLT9DFpsg4FTqGm66mZyp
         LiBdX3AbuvwDlhJzYk0SpSfwXs7/Mu0obPRkAKPqPc503vM3qpr+1e2Qow4ZJ0Kem8zz
         gr+XNbOWfqHnM/bDabMfZzYlQWaODEvlgddQRY9ld2kpGoFTdimH23uLzn4q/u7LJD8M
         0SzVzioD3DnZuJkcVp6U0r4lhOu8ZEauDcTvf1n4psRUBlWTH8KMVjhsO0yoKGNPgGFV
         x39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839274; x=1762444074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94J6pOSo9Nuw6aebkUjzuSFc2ureh881e+PTgGeW2qs=;
        b=Xnn2Se3jPNmlGHpzPWLS2dBBW5t0eLgJJulSv4KulxLhTlliH+MHbZZysjC/r80Ynz
         ThzE+Q0bFDW6ItBznyYp5kcE1rvSQ4BukfuLJ9xvr5IRRZnaE+SgIotpDSrndf2SLQgC
         3HECCZpXRswdzsEo/bNx25zrmlikooq8dH/3inOExaNrStZCOHez8zoJglXwZCplsfmL
         TGYwBaWK8GdX3PvsaJkJqDB0Tq/NSZwwvjdVXf85YeXpKnMihVgROoPLt039CB+MfIX+
         z5UKgZKeF1nkiXdy+NuSSQ9TUJkIJo951sfTms8wdB9tDfnzJ7kiAjygZdanAGplpBJP
         us2A==
X-Gm-Message-State: AOJu0YwBUB+crPq9frEGF9zbgrc657rTKvRC6C4RrgjdtS9GLsRR+wdO
	qKa8RIwsk1fp+2o+s7BTQBxrR2CML7qKCMy4DIWjXoJieB7Fv2YVGwWeG67hOT615tEEfDRfgxd
	WVUfy
X-Gm-Gg: ASbGncs9hR3B8rqbn9UnVGWfk4htWtvrQCEwFpjiENaGKgrMfEXxlFt2p5GvSiaIG2a
	d5b3eDA2nnfCP3sZMHYXpqvcpK0xPETvIlet8KoU8teFIELxVZYHM030FaonTTqV2fc8qIZqpy6
	S6xkTkhiSqV+nexMdCOWr0yaQO1O/M1/kPKDYfyPJP51XVIZ3ROJn0dFitHExECBATaKrF/rwkC
	Otest+XeJdc2VC+iTcfRvfuRpoRssPNHpALbWsQJpLqqBVGbsLxDTtTYckG7rEJar7vEHduQ+gU
	9aS4iosgOMJwl1mOdXpCRspfUdUWtYyQJAFN8koA804aklYWTOX3crO5dwTd6XwJKyED9gRaYBa
	mfYumyXyduzjnr/bYO5YEQzzHt9jBtFabVobj0btCiJ/rBdQ5texQJMI25kW549ZmKIaaL//TOK
	4dcoJRMUdcqw/O/BLqDJVe2tZxTQ==
X-Google-Smtp-Source: AGHT+IHmDqkqWJ4cBL6EIyssI/vAVsIRgr+fKOw3ABPhay5rVVbLQ0/kllfx5VmeHkJX+iBkkymQXg==
X-Received: by 2002:a5d:64e4:0:b0:429:927e:f2d with SMTP id ffacd0b85a97d-429bd69fd97mr30084f8f.38.1761839273935;
        Thu, 30 Oct 2025 08:47:53 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:53 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 1/5] ACPI: scan: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 30 Oct 2025 16:47:35 +0100
Message-ID: <20251030154739.262582-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030154739.262582-1-marco.crivellari@suse.com>
References: <20251030154739.262582-1-marco.crivellari@suse.com>
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

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ef16d58b2949..e0c0b5a50d26 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2397,7 +2397,7 @@ static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 	 * initial enumeration of devices is complete, put it into the unbound
 	 * workqueue.
 	 */
-	queue_work(system_unbound_wq, &cdw->work);
+	queue_work(system_dfl_wq, &cdw->work);
 
 	return true;
 }
-- 
2.51.0


