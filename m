Return-Path: <linux-kernel+bounces-805023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8BCB48318
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68600189B098
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D621B9D9;
	Mon,  8 Sep 2025 04:07:35 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6B1A3167
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304455; cv=none; b=XY1tOsQbYd2tooGX1OVyvOovE3gNwVxNUo5YXtXcxjO6LDDz+LP2ugBnJOyRKy4hO354kUuLH9iYdRnYYbP/U/9lEtSujLsp5vH4T12kuhNqmyItHfY9xb8nlU/zRTlfuMh6v9up+H2MdLXIMeQKAQRGl74JmWEB9jmT+B4mC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304455; c=relaxed/simple;
	bh=9wx1iXdmCHer+AspEUn6XJ1H/vBQn3AwQMQOzJtnSM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kqk/7tnoy4EG9cen9paEoT3HOx4NartgYVI3ZRcOHIPU8mrIMiOMRDMhkNvElIBUI+wGbM6hbnSkTXauDmax2F6VuRNTiSNf4+06wtblakWLCXn5EmyEhu4f+egOtQMsC/x0SlApsB1/Pz8fKxV8jMnCJkLyUfnpuRJhmN3TKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso24355275e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 21:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757304452; x=1757909252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=409De3dycyXy94pFQxmNYxL/WmjZWt0b3HPL18vEbd8=;
        b=sUaEdXpYbFi3U+1or4whEpzwdOzGgW0BCU5se05ne0VRBIfnUBElQugOBDXO8eqXe7
         BgddRHrSBi84S75GIAVRpcmLSuHxbg8WjUsiRofSYy5Is3qTM5eybbb4whmk6yWB41O3
         ljN+4/ENMr84bkKLAmE1Fd1zujg9V/PaXO5kjhK9APeGTkFRPrDyLWB3S5NjuBlDRfxJ
         EFyPZdblXGM4bJ5+Sd1Zj8xlubAtOIDSCVcf5cjqRhwmXATtJUvTLL4mxeey0E+ZrjH6
         bjAhhgLgDAjUb4EygxoDDGHgpWWO9bNW3AC3BhyTaEWzsHh7WUAGRorvICvUQj5XrXl+
         mahQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLZDgyaX0asQuS9kvb0RZu8G9hoq2v/k1xeW1blqw0rH0NS0hERBiBbbfBxYA71cvhO+FulU+W3BfWLRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJmEBp6/ZirecZGRswJi8l47Vm/hCYI22w/QYhnEJzuaabrpY
	IGawriKKPfFzsBmkvXgwlBoyKjlMi9kzZ6xRAxxYFEVzMjKHu6CWY+cu
X-Gm-Gg: ASbGncsvpt7K7YjLSUxJssZ7hNbd8bqiL0AUC2jitD7CXpr4bFsny+0SUqFLFx2o+MY
	MTv92CHuMpPgqnR1zKQ2z3ks2fYDAXZkPMZ7aLV+8Rz0SdcOMLLeSHayLyJxCb311xLEoz1qaaC
	ZM4+BUj9RbunN0PBRv+Xd+MTMrWrJLszx7MniCt4kiL8koKZ1PmwwrqSEtBaf2KEm9KH9PRz3mR
	cNp0xFyc1yyFF1hbhbzOKeizHxNSTJyYPp3ywikHAORI0f5EgiqfW9DOpDVRIf8ZV0KFzgLffca
	4He1/syIS9fU19bVJv6tK9n8dBE/oTE+rKxrjkvmYiSV7APxt7dkEcC0pIXD/ybPBZFi1igYUql
	Ro132J4VIe6r/zvebE3bsKITYUL8=
X-Google-Smtp-Source: AGHT+IHHc0KQu4fVuvjX8fgbXi8r9B9WeHJTzec9xAQPc3wb88MrF8wCXiddTK5zZ0XCMEdTfP3iDQ==
X-Received: by 2002:a05:600c:c8f:b0:45c:b55f:466a with SMTP id 5b1f17b1804b1-45ddde9295dmr54866415e9.15.1757304451344;
        Sun, 07 Sep 2025 21:07:31 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a04:6f00:1::ee:b:1086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm228428405e9.0.2025.09.07.21.07.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Sep 2025 21:07:31 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	Liam.Howlett@oracle.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	dev.jain@arm.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	usamaarif642@gmail.com,
	ziy@nvidia.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm: avoid processing mlocked THPs in deferred split shrinker
Date: Mon,  8 Sep 2025 12:07:13 +0800
Message-ID: <20250908040713.42960-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When a new THP is faulted in or collapsed, it is unconditionally added to
the deferred split queue. If this THP is subsequently mlocked, it remains
on the queue but is removed from the LRU and marked unevictable.

During memory reclaim, deferred_split_scan() will still pick up this large
folio. Because it's not partially mapped, it will proceed to call
thp_underused() and then attempt to split_folio() to free all zero-filled
subpages.

This is a pointless waste of CPU cycles. The folio is mlocked and
unevictable, so any attempt to reclaim memory from it via splitting is
doomed to fail.

So, let's add an early folio_test_mlocked() check to skip this case.

Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/huge_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 77f0c3417973..d2e84015d6b4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4183,6 +4183,9 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		bool underused = false;
 
 		if (!folio_test_partially_mapped(folio)) {
+			/* An mlocked folio is not a candidate for the shrinker. */
+			if (folio_test_mlocked(folio))
+				goto next;
 			underused = thp_underused(folio);
 			if (!underused)
 				goto next;
-- 
2.49.0


