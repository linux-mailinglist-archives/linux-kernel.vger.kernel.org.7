Return-Path: <linux-kernel+bounces-878576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFBC210D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069591AA1AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810923655F4;
	Thu, 30 Oct 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a7RXwf1u"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3723D7E3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839278; cv=none; b=gUeHAIufc5BTYrzK6PdoOPpPSWLdC7NF8Wzt/0zFPiHH0LwP0AH1SNVcc7etNRxpDtijmvcCVLEg4Tb4C0MEO7KPyo8a5vFfZYOaCezVzwVBU+36jmm7HKPhBi7y6D66yI6z6vT9Q2mJHk4TSG40NZWKakF7TctCBkXjkBXCWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839278; c=relaxed/simple;
	bh=rZ5kBwXxvaDt2BMbcVF0+veZbJzLSOJtP3lgRZMOnz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky90OqTwfuV7XcIK8n0TBR6mTtYRT/pgcLCg9zqwfLCpV9BUuEpwH+9Bh9miRuf2Tny0k5bVV8ydRSwEttlaoEci9wwp+PN82uMYDTfSaH4TJA5S7k9qU47WoLK5a0VzNIUxl5Y24hz74iVDdHS0U7agcso8J5f76iB4GW2kvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a7RXwf1u; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427084a641aso1009561f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839275; x=1762444075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKjLkJX2ivVfrTT2riKqUS+oMXr5sjkkm9myJlL5OtQ=;
        b=a7RXwf1unOg68jpKCn9x/k+2salVh/g0WirsNygnnD7SRef6+p8gCUVI/O7ZCkrNnS
         MRW2UljlQJFqmt5Gz5lldtqN5LrgVK6HoDxP/vVE6ORXaxLKpYQCtohInHG7zUz7Pl/m
         I5nkyQlBm/lH3AGEg4bmh1jfP9vCPMbIowBsnS2mMLCijjX035/N1q+/injn4p4Iihau
         79IrbaT68xHsdZPEiFqgYQMb7YSqsovKUnb0OgkE3a+jpbDv+tCb1ZZaoQnZ0c9cTYPH
         u6K4GF02LIB2TeCACzQwdFq9Dhqp+tQgY9JPu8Rgs5VP5cl9nzju0nAtBUkjs0fFUVpX
         ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839275; x=1762444075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKjLkJX2ivVfrTT2riKqUS+oMXr5sjkkm9myJlL5OtQ=;
        b=bNAwOGy0qWa2tb3fr50t3bX1GkW4qAznMYSm7UjAn3vJc0HxszvVun4jNNpxmPdeKz
         Puwt8hhNsZeMAGEdIq50S3tUN5Hurze6OXBwwVya3FPRT+y+z8eIr0EvVh3tlmK2y4iB
         nDSOvckYgWZ4xzh+7D5I5s6cp/BCbmmq0InY0fRYIxkp6sTwJrqxuw4rbyVaYpnDEQqT
         J8t1uD8ldywghNOnGZYPacrlQiRuZLwiylmIm9os+0q2z/M3Yf2lApmIJMVNPIN6dk7J
         LwA/ICu7tCNqWZ0G4GCBK53tOu14j8unXQ4nBmq93A812vJyvp/Ur/S5cDBUzf88VmsT
         vIQA==
X-Gm-Message-State: AOJu0YyRxuV3H3uMx+viiFZEsuJkoRJ17/K9NRdCI1GhiAp6kfMaDsAc
	Z4Zxs8/UKZMnnWJYRHC/BYObMiyAbqoBxvgQvhUIFrITQ/P9H7oqA8kVxuNPH1WFNJLREMdx3qY
	jq7rz
X-Gm-Gg: ASbGncvT3pVr0zj3nheHAPfojtdw83lJeExBSJJZnSAwAz/o2ajUlMvRpauM3Fn9y2H
	CB48hZFaeeaEOvEPhHTCWA14oMVHyaslcKEDj6U9R35mqF3bTkOLevpOOU2AzuMH6MritzrJzTJ
	2yHf3Zh+YjCzBCbod88vVFDnQcEw5+Q0zANXjSw8RJosxK3i802HUkxn7NIKVDeWrnvUdWQx6xe
	nOSmw2/DRb7jEY23Q6qloWjUzPjbkIFaMn7M3hY/wl8kvGd8/frgWmAGGsgDTT6KhmwqxBEW8km
	xOgnZy51iUJbvplOwi1KF4jsM2SkU7m94BXGHP6KBnlskCmtgIe0dQDPSu6f7y9vaNx5tm2kaYh
	9YT5zgcTQa/VcfM2WJ5cFIbPZ0j9528FFLd9Lx/WT9ZMQ2wdan2+hg3iSMBQ+SDS8grAD++I8k3
	qnxNW/A6mM4R2zLnH9hF6nq0woVw==
X-Google-Smtp-Source: AGHT+IE5s+Lf9wcOpZOtCH5Tt/5Y2/EehbblVu3uT0e68kjERO0vfqRCRcYIbE+J21bs7leTY3ELdw==
X-Received: by 2002:a05:6000:186c:b0:429:b703:ad97 with SMTP id ffacd0b85a97d-429bd6de678mr15906f8f.57.1761839274731;
        Thu, 30 Oct 2025 08:47:54 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:54 -0700 (PDT)
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
Subject: [PATCH 2/5] ACPI: OSL: replace use of system_wq with system_percpu_wq
Date: Thu, 30 Oct 2025 16:47:36 +0100
Message-ID: <20251030154739.262582-3-marco.crivellari@suse.com>
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

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5ff343096ece..a79a5d47bdb8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -398,7 +398,7 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 	list_del_rcu(&map->list);
 
 	INIT_RCU_WORK(&map->track.rwork, acpi_os_map_remove);
-	queue_rcu_work(system_wq, &map->track.rwork);
+	queue_rcu_work(system_percpu_wq, &map->track.rwork);
 }
 
 /**
-- 
2.51.0


