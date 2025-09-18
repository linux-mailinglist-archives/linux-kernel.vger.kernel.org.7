Return-Path: <linux-kernel+bounces-823394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75FB864EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457C01CC453E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB7D25A2AE;
	Thu, 18 Sep 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtYPalkO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77282459CF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217548; cv=none; b=QbpUXAgZnsBusAX0cFNjnquwQ99rTmvYgE5ImfYw8hMUir/qQAAxKOnbNxjdiQ/PYxtd/W0Eofj3hkZSiBpku2ZRR49dhbfBHotez2cFeIkKO4QIh2TQXRkBkzBQlFhbThMMpdINTqPLh0MFMrInTo20xiynPv1yk1CCzy6GwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217548; c=relaxed/simple;
	bh=z4fi6tr5q775b7ZogXo3+OMmDpn+hHFejBmCQssY1Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1dYnl6MaDy3zQK0IuWfw7wd+t3Ce1VdQWBXraMZQiqvACg7Vlqj8Jj//l9ARTrjDCxsfaCd2AXUOmaAAhpkr50cW7PFU+a7EFB4CvNkShhwYWXJ/xQtaF8jUTLI5caXlUwYy8Gd4kUom+GqxE6dMevn0vxmDDuroUm94TWc7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtYPalkO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77d37d71967so894296b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758217546; x=1758822346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd8J6zc6d0XOboiy3w4ytNv/wLGIoS7FaedxQjksC+c=;
        b=QtYPalkObuK36pBDL9iVfpKoP01dK3qOo+tONN+P926fY5RVmx05H3xGJWXm0IdwnM
         HMLKtMfWc4LOSWRd1VTh+Q89xKSTQa1soECMIc5E+r7JO3j5fBLEsNpOeo9t9V7lBkM7
         rsvinqFcqF2SIJV6yH2la07vaO30c/oRb4oVjtNB8wMPzChXVUQkPjvr2SlZxCbDsR/J
         EJGBh65N6T54ZfZaQgqeLlCUzFq0/9nVo9N5IZmPQqr7ZPl1oa8XGyL1q+CGTgW49xr5
         121S2MqIxG3m+E0E06+pBmOD4y1h0TA/7aZS5lKqjva/6LmVL6GwFidUHT3KhTcbcXeG
         yqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758217546; x=1758822346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cd8J6zc6d0XOboiy3w4ytNv/wLGIoS7FaedxQjksC+c=;
        b=dvJe9wNjqyEK747smsQ/5Oj+YR1MaIjWRqD+4DBn0kNu1iMPGIC9/Cg7w75XqBbdy+
         2usG3LUnsngJGiHtT6O6NzhvwttOOiZwK8dkyJTVINCD+hMFovTvg15clbcY37YwCkCt
         fBiND38o/lo9dXdDtC1s3c10xa/YHiMTZ4yq2mFqZZ/gRqojENMWdNZtW1F1bz2Z/qTA
         yYh5Idp0gmjmlho9drREd/Qe1cikLPT4THHhO18830vt3Tr5i9cLIbJX6+9uuswMm8sn
         pns4FP3jvzXpZwKXrWHv3zvHk2TB71CwbTQu4qcQGgXKQWaHDY0R2wAOJVnFreKlHDy+
         RUZw==
X-Forwarded-Encrypted: i=1; AJvYcCXi+/s9UYbrurPTzg7gEFzM6DavDwwGnIPwfdeo2JZjhj8WlSkpr+M4ecteH9gSR1USBRgCyOvyO7rw+EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMfFqv8z/HVIK+87+xzG1a6dYxUvn41KcWVknM/Lyl+ThNw71C
	f+6mISLn73cW5b/IypPCQsXYoxo8PON+fdA8xFeZp/nNnPJZB4J5tWtU
X-Gm-Gg: ASbGnct1VX1ymIDZS+KWCO2GrqLCJHcAhFP5V+62vrAs3dCRlOdGt7YNbFeOESzMY5w
	H1U7U99EFATVvinRWtan8ZbLIJiFnxP5Fi62tYQcRCqhHvD4BExidoo/lPIrPh9nqXCp0Mow4yF
	5OenLOascEkWjhQeF7mbwKCD85pr3Te0bHQn6ATfGqZllV45LPg3lNH8AUc3hcyEyFtdYMN4LFg
	iqGFTNVTR31ch/Pg4nyTvg3D0Z1rn+e6paG0TSumVRUEG5gXkxRyL2zhLDsGX1Gsu9ax5XyLEJL
	ZnjeB4W2mw1CFehqO5yrpywfhbd74Le3G6Ukpk1L2ATo+VxeRsPld0q2T7uvweM09lv5rXlZnwL
	zOoec2rrYQOm1okVQ+rawNECqVbypsMMRcJJncvwSqA==
X-Google-Smtp-Source: AGHT+IFh/ztgMpAqjwhJWgVmQzwD0/HLyiKJTGmOOzgeN3hRgqomZDAlgPXqicFibQjBvGoROi5d/Q==
X-Received: by 2002:a05:6a20:728f:b0:243:b92d:72c1 with SMTP id adf61e73a8af0-28429d8d70fmr7373610637.0.1758217545766;
        Thu, 18 Sep 2025 10:45:45 -0700 (PDT)
Received: from muxbit.. ([2401:4900:1cb8:2c41:4cd2:6b0b:66a7:bdd9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5517282443sm170727a12.33.2025.09.18.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:45:45 -0700 (PDT)
From: Manish Kumar <manish1588@gmail.com>
To: david@redhat.com
Cc: osalvador@suse.de,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Manish Kumar <manish1588@gmail.com>
Subject: [PATCH] mm/memory_hotplug: fix typo 'esecially' -> 'especially'
Date: Thu, 18 Sep 2025 23:15:28 +0530
Message-ID: <20250918174528.90879-1-manish1588@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Manish Kumar <manish1588@gmail.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b1caedbade5b..c4436a247ab4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -976,7 +976,7 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
  *    effectively unused by the kernel, yet they account to "present pages".
  *    Fortunately, these allocations are comparatively small in relevant setups
  *    (e.g., fraction of system memory).
- * b) Some hotplugged memory blocks in virtualized environments, esecially
+ * b) Some hotplugged memory blocks in virtualized environments, especially
  *    hotplugged by virtio-mem, look like they are completely present, however,
  *    only parts of the memory block are actually currently usable.
  *    "present pages" is an upper limit that can get reached at runtime. As
-- 
2.43.0


