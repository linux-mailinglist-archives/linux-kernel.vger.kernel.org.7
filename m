Return-Path: <linux-kernel+bounces-897564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE4AC53744
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 078C4508446
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59513340275;
	Wed, 12 Nov 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XxsBS7Fr"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DD340280
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961245; cv=none; b=iUFv66aiYjvtKVf9ni5hxeL8lQPMBLFUNbqYcdsnkmYJoHqqe5sN0bx3aFZ1io9VhGRRY+7f71U8kLZqltCSVkeAQa1z0KFKyleoe0ptMZ1y8F2XOgDZX0VQBphhCDcfkUtPOAijNa6pztfQOFo9TWmcoXjx8660cTzK+7DUkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961245; c=relaxed/simple;
	bh=VAf9wpwLdFuwdJpuNho2pHTkgpx9BHPUjBC59ZfKTdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T6js524T+bdhMNOeV3FVtRJO7k2bLfHd/1MA9VAsu79ZEtvS6QrzxPBfnKmDuXbTL9vDnXs27O2SKAzx2DCHv2GfSQhuEHF9KVaTDXoVlt91JKibXJfbf36n15YScP59baYw98semH2/GtRrRoAo3lnA08Jszb3pjjZlgUMiodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XxsBS7Fr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so7712565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762961240; x=1763566040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKp1cFO/l4kJI/jhk3RgE06PL5VA9waBtAK0XhKNcUc=;
        b=XxsBS7FrfOW/aoBI1U2TC9JHcyryyKzvcLtJ/tH4UThgxLJwyer7bGIpekKLycuOI4
         oP6WJl2ARB1//93spDUd7VlZ0JTJ2CoIyKBsphr+CDlakBPXN3bIgteT7lTWia8q6Z0d
         OqjD39kiUHHg6qn6u30TZLepD9aaHK9kqpPPydOxN4viEBhGJ+FyByxPjS0lG1oCU5mZ
         VTA/I7DA/l1e9nvs2Je/na9Gppk+5tT1UADnXkrFwP0qvGnly0kXdlJRA5YlQIXn/g3N
         vrKSuEVljhWt3uccmnKUh9JA9rDBqaY/r5cjSLk8PBSllN4FyqmWCuXR4JcwcmLMYzRt
         Wb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961240; x=1763566040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKp1cFO/l4kJI/jhk3RgE06PL5VA9waBtAK0XhKNcUc=;
        b=IwFgu38KBdLrsMMsF0wq2hKYFUzBpDrYacccnN/nTooutMUbXwwqNKx1ScF4E4g4kL
         Vh9lneO4I+mQLXABeGVFCzIYJz3YNqPFieMDboiudJgu2B3exSmXgcsdZ7CSQhy2do1J
         TfR6W4OY5IXAWiws9U2kGsxQcjr/mwQiRrHEBYZ6qkwtccxBD1/oqZt84ZeA2er7rnb+
         EYYVotvkjHcwck4A782j6urxy6IbZODGo4kLzLgFTbfkjiGsUHVOibxNe43Kzkhjc/ay
         iIV/urz9aN36Hg5KBIkJTsh9iGcm8J+W+Vpv8rM2c5TSvA3X/wczA2br+EG3FK2XEIfr
         4gkQ==
X-Gm-Message-State: AOJu0Yw0Nm+m2J75cIS9GobbistqXMCmjgdMbilrGpdYzl+gX/QcDVXq
	kqLyUnbuPtS5O+TX17ppRT56mxKD01mLzBUJ1KfcRqpaJ+g4HTY+GDzMA0phIyC+AVRdzEAy8+q
	WlggL
X-Gm-Gg: ASbGncvzHmW1TSiLq9og8TYskADn4wD9pyFwEz/WpJhFNP6JYhIoYTscU8WwKp5Rtaf
	02GEKsg6eHLA0uBSz2tf0IkVBKxiSbnemJ5NADy9e3zR+34FE7bxDLXmzHEQ8Cl1BDdaSjNrme0
	QyyX0sEBwuyip2AVANhnaN+YoxEqeHx3moLnkb4RSlVrjrBAdltBsRPeNwA8w3/Vt7slffbXQmG
	p74Ok+7wOzszlR1htXmKn9lUZstzjARCPsQtB3jv11Pjh6zZDyHtvw904hoNJz4qTsI75cHW7Nr
	AmdvuM99yqz27GpkYcjCO+BOBOZW4bI+FQwa/Oqo9G35+b8RcEqwyl5+aKztWYSfdLtk0hSTyo/
	LxIZzaTJfl1KaeZ4BOlKl9YwTSEify5Yu//sfQmxOQC0pTQG9P+QBuqBwDjWZYVS0+Zud9MIzBG
	VKIuzEbg5G0XxUpU3unzPQeko=
X-Google-Smtp-Source: AGHT+IGJDzp472j+ES/v0X7H84Lp+WJADwCYyhy//upPyzsZ3GUwGusELn85wplGIz/TwgjaOTnnmg==
X-Received: by 2002:a05:600c:4f51:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-477872bc0cfmr34221415e9.4.1762961240486;
        Wed, 12 Nov 2025 07:27:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32c1ad2bsm23318030f8f.6.2025.11.12.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:27:20 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] greybus: add WQ_PERCPU to alloc_workqueue users
Date: Wed, 12 Nov 2025 16:27:10 +0100
Message-ID: <20251112152710.207577-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
Changes in v2:
- updated commit log removing two paragraph not strictly related to
  the work.

- subject changed removing "drivers/" before the actual prefix.
---
 drivers/greybus/operation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 54ccc434a1f7..7e12ffb2dd60 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -1238,7 +1238,7 @@ int __init gb_operation_init(void)
 		goto err_destroy_message_cache;
 
 	gb_operation_completion_wq = alloc_workqueue("greybus_completion",
-						     0, 0);
+						     WQ_PERCPU, 0);
 	if (!gb_operation_completion_wq)
 		goto err_destroy_operation_cache;
 
-- 
2.51.1


