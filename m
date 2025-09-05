Return-Path: <linux-kernel+bounces-802417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E7B45234
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E4F17BBEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5603002B2;
	Fri,  5 Sep 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="drVz4iOY"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917727EFF1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062597; cv=none; b=ayAWOFTAMKAb9DHZMbFcHaZHSPxR8HWvyR3inaNt0ahg7yKLyDKfyEHHpvSqJZEdwUtGlU3sxsn7FiQCfMt9rg48nenIG8NeEFis/6QfJ7Vwn4R/c+boX+3gTQ4CO3AGCqUoi9cmDMM/RNcbzeXUrhm/RP97C6FOt4vVnHDS9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062597; c=relaxed/simple;
	bh=+T8NOI6Zv4wcxfohTwV1+3xnH7VfvfWZyIpyrCQB4GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxsUWOSp8K/UO6HOWCbIx4DIrtZm/WZ/6e/ALe3G141suwuyOu2xHA9Di6OjEFUw49NMRHenVVAoXfZmC1ZSC5tXmzfGOKDSOdhDSPgXWPAgt8CAucF51uBE3A70PgRdrChAamM0fj5ir6UzZrpw4zmtfXClDVu6InDqn3AAhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=drVz4iOY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so1390326f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062594; x=1757667394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGB+Qhk7R+OYFlkgwfQcrSKwGrnqjIMBZvbPxHWeZM0=;
        b=drVz4iOYS8qtwlKY0YbRg4GRTeMWcZ+emVqA4oxl0mGZ5yNHnDnS6hENcsyMxFN8nJ
         JZvUrSv3MttN3emTIOlLvdiGxxkQ9q71OTPN3bWbu7JhF+/+UeY/UBLRodJWb8eJpXhR
         /0jXFcrnolvgKcVccxSi7aeexhhAWVAWE+O7gsPRg9HzJNKDS4Qt5CG9UJ8F6LkvGrZZ
         3K/wJIYpJxysbMWvSjb7DJX9ChuSbs+RStITTCXPLFD0OvzPc6Prj2cwEv6g4KsBFfuO
         TmzUP/jW/vYVfj4jV5oQ9MyLq0KhvzBHh4Jn/9zkks1OcTyT8FU17KNCrKnGujDnWW7X
         ybGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062594; x=1757667394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGB+Qhk7R+OYFlkgwfQcrSKwGrnqjIMBZvbPxHWeZM0=;
        b=kQTE8B+vJJWoNZIpzT1fWWdgoC64t/F2O+VBEPAxOBAzI6TH/z9Vjh8VheB2t6L4Yk
         0fvlvzVu49E64kOyxMve1vbKQNBFVAvYA011F66Zz3XVq/a7E2znE+6Ub3psli6CpRVI
         oEL1EDZAUiHL63jv1gulMoIbRAsvUdJ2avKt2GurXQC9P0SvipkQ8vNWJ6RbgEwlmV7r
         8x4V1YRZNJsWg0ANy24I9s909xiVD5w765Yet2rAHyE/+iBngLtjYgyvH+ohiVdiJX+O
         D2SzRuJ0//WE/a8cTg2XqrVwMmRIVdsPh6TB8To5Fv44yeezucOc221TDsQp28gXfylj
         f1Ew==
X-Gm-Message-State: AOJu0YxEUmjN7V9sp1s/H3GIuOchyV4RMn2JodtgeTT/ZmkBIlJW1HLB
	3iLygSh6S/n2Qt/BAhIamkVFc6EvsG2ddCcF5obWCrfLOCNe2H/w6EaXnAFrzkUAicitBpt/VVY
	2mkSS
X-Gm-Gg: ASbGncvPxGagNfOdJRoGmAenYTCtJfjPr/sZS/G8zApJxYcUTerr+TghdosMyIv+0sl
	OV/Afag3T1mkbzcGwET0tcpC3FT5HcGgcvEVli/z7QhCUxV+HJ3uKwnwixYBvZ1kdABHWEZJPri
	B4j1A5b9DRFjgq7KT/KIT+MHEFdpKYnC4xptc2rKciUSIhIxI/RNlmVdIJybqIXjRdp2saYKJtV
	o3y7rPOhJ5SOgCkqZ6gt6iG4tZBPKIOVh7Oan+hqBcZ/KvuXVMl0jbaCQ4QF5g5SIDb+9arBdeW
	JUECCR9mrslYDIwyecutOyhmJ4T16PA92lTJq/vo1fsvB1BsXxWEnDEy7v0xUbpRrDHAGKbC7Re
	NsfkSTeZj3h2NMNXxTLX3kno9QBSFJie9HZozzWgaMaFwi9sbJI0pawLbDw==
X-Google-Smtp-Source: AGHT+IGsa0rp5MHa6kNBT4cj8hGWuR9YR74ee3KpeGkEs3kQ8djeneHdrXuQs+57ETnPU8KAwAJ6hw==
X-Received: by 2002:a05:6000:2305:b0:3e4:bd77:df12 with SMTP id ffacd0b85a97d-3e4bd77e146mr269918f8f.18.1757062594051;
        Fri, 05 Sep 2025 01:56:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3da13041bcasm14617492f8f.35.2025.09.05.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:56:33 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/1] closure: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 10:56:25 +0200
Message-ID: <20250905085625.97367-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085625.97367-1-marco.crivellari@suse.com>
References: <20250905085625.97367-1-marco.crivellari@suse.com>
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
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 include/linux/closure.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index 880fe85e35e9..959b3c584254 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -58,7 +58,7 @@
  * bio2->bi_endio = foo_endio;
  * bio_submit(bio2);
  *
- * continue_at(cl, complete_some_read, system_wq);
+ * continue_at(cl, complete_some_read, system_percpu_wq);
  *
  * If closure's refcount started at 0, complete_some_read() could run before the
  * second bio was submitted - which is almost always not what you want! More
-- 
2.51.0


