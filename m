Return-Path: <linux-kernel+bounces-769352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8942DB26D52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F0F3AD1E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE420CCDC;
	Thu, 14 Aug 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMP08LP5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925121EB5FD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191524; cv=none; b=J7wQL4metNmzz7YZTSC/nNfw6HAjMJgpgCC31hm4i4tBLoTDK9Kk1HnQLNuw0skRxebI8MKbzadhdeXHr738gS5qFTM+yxwqxKG9Apt+B7p0nn75EjnS9yaw4tlkVG60yOd/R9nZMbEQEyXqVfHiBkUy+Iy9AhI19Iri2NLe9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191524; c=relaxed/simple;
	bh=cWHpA47p8e8QgkyRjfhStsbXjhqE7QENF1LtBEAHu7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y00rx5Suxin9PK/XOyV19TepiuGoT7Ry+3W+UroMzAlm1/5g0cJvBXV/iXxUsru5g5n4WDo8xgHE8Q+G75lwlnL65/RWhjgi5d8qcVX4/3OI/Ytoh3pzBPrNR/sAVi7JzucNj4dg+hunZeIEZAFDLFgs/qeqm/r9N4A3xkI7u/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMP08LP5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so7716115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755191521; x=1755796321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEOmhYbmmbZuNpyy36AGBb9lWDhr9LiPjyclBKHeUw4=;
        b=cMP08LP5Vu1z/zA21o1G1K4fof7B/+WYqYA8QXXMMkq9mQp5yGIFlViI9qATcnlxpM
         eY3NDUoiv5OY6r9Ly+LapdsED6ki55CC53dnUGUwGEoLqGVu+IWPopozBxMEzPnhG0eV
         2dJoJBATWWMzDAbcSHKQGLy0O9+zm8vfZqGyxwP2BkczdclZ22TDZijCZohNHSjGNVz6
         bTVB4zi+kWk6WpLwuBKnFn/unWWPTk6d4A5c2d4N8sdTsV1lVaCLwe7CTRIES5XbOm0A
         NyrQ/NUjBeiao/N5C6BGRlcmAe26r4gGE2S3bzDtDbLD/Pgfq4UWaZf1gfqmEcqVYyNI
         vgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191521; x=1755796321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEOmhYbmmbZuNpyy36AGBb9lWDhr9LiPjyclBKHeUw4=;
        b=MYvxrx1HKefTVoU0hWSNinDPXMj4y4pdmPzYP9QpIc7POLQe9B+P8lIuctIEX8l+/q
         bBoF4ltxQfsmFyosCLFY4vmTCzDNg3oJDv8D+yseR205s0yzB8rSHzgXQbXh5pR6JUsm
         vRXfyAFSSA7vtgMwI4KUS8qcX2FFdCkcaKlyh8gZZp8yQgNYvVQhk1J1Mhr70BXNMY71
         daZXFBhIWJOg7QZbZHuctcxv2oB2MmvGDcuoW9WFRJdjVWI5NSZyiaw1rVjUIE9LK6OQ
         SWC1yWM2gQj1T/TbzqdfVT/EwAT797b5AwA4DJwOMN9GD8d0vTWEh0wPaDDvrVgCYuoo
         iyrw==
X-Forwarded-Encrypted: i=1; AJvYcCUYz/RXQfDktEo5+A8Hu1Mc8FyD3X+jsvTd/13Lc7fk1uFnohd/832SI9PV4zNZ7KvqBwaRTIjU9vUkH4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECIcRXWxKpvyQJSIOkFgRqbuQ/HRZaO4L94vDA6CE9DHFGzuT
	AelRv8abXECUnOB5FXKCNtaCiDhVWOPjMCJMczllPeSkopxpU1rKtZo2EskjkOGa
X-Gm-Gg: ASbGncvSTlARZCVLY0GFILhHooPAMW/hCYJHbGRYQM/ArXIaGv0zpiGqQBoD+QG34p1
	dg3oY0YgHRd7FdRuVnai1mRKXK1kCEx+6gUtsZ4xz0Al02nBBhODPf18FznKNpWN+iAAjY+jXof
	1fc349lJAXxGWS+1VM2Tn4Ec1uHWFmVTbuirRF/6Y6zctcAPtVy52Gd3aaPkcn/Ge0C/quO7B0C
	l+zyXiAObvOS0b2rhq8wG2zi8lx4AQ/GeUg0kAazvZ/PawWQyCYu+nwQ27iiuPzh8nzL9TpHYPf
	e3GpeU+JBXqSkI7I4aaOPouKaIqtojhzL5z/QQujIRLJUbdhdheDe9RKHItczX/scxtqmbayhY4
	u96VkNaKbf3y7bhM=
X-Google-Smtp-Source: AGHT+IE9XhyoiJxNDkeztV+vPBU9i2mKI8X8ueavbAWcAwwxIPz9l9YmLwBZfHxoWjPUVpVAhCuRFw==
X-Received: by 2002:a05:600c:4e93:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-45a1b668299mr37616765e9.30.1755191520651;
        Thu, 14 Aug 2025 10:12:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b91330bf7dsm9158590f8f.28.2025.08.14.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:12:00 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/1] Add memory allocation info for cgroup oom
Date: Thu, 14 Aug 2025 10:11:57 -0700
Message-ID: <790da5ffebf18a5a1211ad8dbe4e5b4a19871408.1755190013.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755190013.git.pyyjason@gmail.com>
References: <cover.1755190013.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable show_mem for the cgroup oom case. We will have memory allocation 
information in such case for the machine.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/oom_kill.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 17650f0b516e..3ca224028396 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -465,8 +465,10 @@ static void dump_header(struct oom_control *oc)
 		pr_warn("COMPACTION is disabled!!!\n");
 
 	dump_stack();
-	if (is_memcg_oom(oc))
+	if (is_memcg_oom(oc)) {
 		mem_cgroup_print_oom_meminfo(oc->memcg);
+		show_mem();
+	}
 	else {
 		__show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, gfp_zone(oc->gfp_mask));
 		if (should_dump_unreclaim_slab())
-- 
2.47.3


