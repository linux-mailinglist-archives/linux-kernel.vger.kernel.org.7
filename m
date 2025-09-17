Return-Path: <linux-kernel+bounces-821196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B93B80B19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F933B034C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3133FC83;
	Wed, 17 Sep 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bBEXHGcw"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266B33EE1D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123552; cv=none; b=pz35eb0TeUK9/XvkylQIPbblg9HBiqkLB03WzjJPj9PCrIW6puRwfvUAffCYt8vDdBcN2Bp21zRIFoXrS1uC9xjaz1cFoZCxgw/IqdcSZCojEsCdbdGWPkuXBOuGyqCq7cwsfhNA9z1aOEMTy8lxtX5lISKbtYZCHm5SXggyv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123552; c=relaxed/simple;
	bh=UKI0GMrIrFld4692U92NbL9P6hnzaYrAgSVS+6kT4NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChgryWOpveC1BcYU9EiMp4Rl3RhBw0XzJSRNgvqSBH645oEAWBk6KuHRwZ4ibzDRBuKJeBYjVgRjFGzA0OBUyxvvsVdoLeCECE4JVWg4EEBJEOxDqN1boRes0trdYWLE4qum5iGYshc99cNehPppr901NwSNzOFXWZ6DKpAtcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bBEXHGcw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ec4d6ba12eso1577449f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123548; x=1758728348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVZVmy10Hzps3+n7t5S3fBRU0IFzjHVdjlxkyI552mE=;
        b=bBEXHGcwmargVZqO4A5K8KgcV/LT1vvWQaH63VnLJm/8INegfwQkLs0XHm4yQxTr3Y
         SJMrMQFpLGbM1tXqlrn7CANE+3o3ajxn2o+P48MeBByTNLv+M69TDVnymbDY53QgatHr
         evYYEFmLrQ/+CUB1H5QFND97qT0GW3joGtegHYgBoONT1Z47bFYldzvDG28buJYW+9Gn
         3af2zje7THCSallZcDtNwOsgJYUi4BcTjJu+HeJpAqS38XiR86Hvr6KYeci8Yf0Q1B8R
         YCC6XXl3tqQuwcp3mvexWmpqsVGU5Sn0UfFoHDOtGVQf7NyLWEPTtt7rrPqmCUpMvS2/
         iYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123548; x=1758728348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVZVmy10Hzps3+n7t5S3fBRU0IFzjHVdjlxkyI552mE=;
        b=GA2TykdmA06GtTui394ICYVPpfGm8axFPZTAZpwqpWoK2ak37oVjpskOE02eFX/Fe2
         LbPhHZT6imXF2uAd7oZ5wpVKUly/ep4KWdMXFeTL3kMRKXqWzehSZNKA0FmUBpOW/fYe
         QjhCNUo210C5f2xgaDY5Msh74w4usIT/fFGEe0R7d9YdlLDFZ7nBx6kHsd2UVfLJuaqZ
         v0WOtT2JSSJPT24cWLeDKMvAA7S04eSQ5YDvraU49cp8hQVIa02p7+0Mo9s0AzSLQ1kT
         lWAeXBTHbkNkG/iy/zR87kJcYdUqUkWIo8xXjp/6CMG9vfsAJmffe10TIxrwzq+AyYEh
         0sdg==
X-Gm-Message-State: AOJu0YzbjB+drKRl+H04i1UU0WN+Dtjw2kSb0dac1wdkKcRvUBjitfSS
	CVQWSViIv0tZA/8ZjgYtrNOmS8DJPUALE3OEmILm6+6NuEZ0m2ewZnT6iT4C0kGYmHvBYkpDett
	To/ukQIs=
X-Gm-Gg: ASbGncvy0+enmQunPjudUk5d/Ufpm+CoTkvG3A2v0VrHrtI2Q+PBnP3QumMm9NJOqjk
	fxTU3DLwFnNDvLi2nAe7+pohEGS3K3UtbSzQogY99viJ2dSXcX2sulnlF9Z089dRPEWkUlO62NM
	rT/RJJj2JaOdH07hBUrZc/Jqg38S2WMgcbXcdiWYo41phtPnph+DQKQImhOmPr+hzeKmZP6OLXM
	pse/AVdbGk6opUcUhoKoO/GHeZ8/4IiqMtWX3kLktFME7/DHwkVOKoGMrKiYZ5mCyQOfz2coLCP
	nXT70sZo6pVDUN1MeFLITgYqr8yCz12rPgvI2JNV5gUgNJ+IwsHKOPtQiTkwjOtAc9Ey4FaThYI
	vnnr7SyRk669FMN7WK0xKAwCv1Xgmcm8MGuY5zKlva60Vrt0=
X-Google-Smtp-Source: AGHT+IFZkFyB8wLD1suxu+q9rNVi45peL0SKj0VLllUK4PJZNrtdqFLmgjE0enuXhQVI0UYmVz1X+g==
X-Received: by 2002:a05:6000:18a7:b0:3e7:ff32:1ab with SMTP id ffacd0b85a97d-3ecdfa4d27amr2496111f8f.50.1758123548077;
        Wed, 17 Sep 2025 08:39:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:07 -0700 (PDT)
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
Subject: [PATCH v2 3/3] s390: replace use of system_wq with system_dfl_wq
Date: Wed, 17 Sep 2025 17:38:59 +0200
Message-ID: <20250917153859.363593-4-marco.crivellari@suse.com>
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

system_wq is a per-CPU worqueue (replaced by system_percpu_wq), but the
current code does not benefit from it. Because of that, system_wq has been
replaced by system_dfl_wq, the new unbound workqueue.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 arch/s390/kernel/hiperdispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index e7b66d046e8d..2507bc3f7757 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
 		return 0;
 	if (hd_online_cores <= hd_entitled_cores)
 		return 0;
-	mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
+	mod_delayed_work(system_dfl_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
 	hd_update_capacities();
 	return 1;
 }
-- 
2.51.0


