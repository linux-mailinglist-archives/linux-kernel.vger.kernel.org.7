Return-Path: <linux-kernel+bounces-857180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12997BE61BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BD65E06B6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF624111D;
	Fri, 17 Oct 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwwRWecl"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD620749C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668543; cv=none; b=ZqLZomNL6RV2qv9QPFjasJIZWWtwtUXmduV6USA3bx1NPc3PWlXBR3vA3qAB9ntJ3IkjgwQZc1sowl8tXM30fWzg+F+pUU5ncV7Vifs502p7UPB4VfnlgEF0kBMqDItb7RoGrIYN/O9E57JI0rIzo5pSSTRwFg0cL/SJvOmM9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668543; c=relaxed/simple;
	bh=/Y4NkuCgmGUWUfR+kvpddk3y3FMwBwv5AcFpAd1wGhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZDQrGrldwSmlLI6knQ0Ao2UuLvC6LVypR5t+QdqNwMcE9djpJeDGvjElqoslLh++uS1OmnOAoWcXYNwpK70zNbWShRFXt5fziUQ/BqLhP3vFIxOjGCH7P2zHdqnA1tOu58XgM6ULsMUup8i0GTCzZtA5hNfrD24x0RtoKz+kVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwwRWecl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ba8d20888so1512224a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760668541; x=1761273341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HR6tnneuwvqkl6QJfT9Tg3nFbSQjiTdIH5de8jfTJRY=;
        b=kwwRWeclDz/gW7hnz8o4wyEpHi2N7008YBvDuvnWZylzlG+58cEEmlebC5AFNaSdik
         l+/bJrVqcn6oF8l7st/Lq6GUK4yuIr/XAFFh6sA9PQhjaooXjSYF0cNfaxjnW3Muf5pP
         DBY8OeeztBwalTZ60W9GHvbyHZhUDDeEuwQTBtmGGHTilVv4AI6TU2cLl02aSsMHn4Lt
         C3e9IbvEPFrQi4OO5HtKiOt+BKm8oAxAmfq6l+1n2RlvaKCzDzmpwdD5NhkzxoyWSYjr
         BCGGSiqh05HHYGzhch4L3XgvwJcge+PLZZ2tnJa8y/8kgA5bURADF+bz2JBRt3b1S6Qh
         c3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760668541; x=1761273341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR6tnneuwvqkl6QJfT9Tg3nFbSQjiTdIH5de8jfTJRY=;
        b=ggbY0kuaJqagpL18CWEub5LYFiDfuZFJp/TUPliVe8+euzuzWcV44u+BRtGgNx/w7R
         M6VVFPNQn/qnY8ynaDCwEEQH9mcNbrv5JL8hsWmpky6dCNuLS+KUEXxTxhn+LkMcMXmd
         pT75LOj/fPXuWK7qmLpxVsmkPO7sxTHKgeGpsJBR9JkNi51Eht8L2LI5Zt4igvX/UPfp
         dYSH/z8zs7CgE35Os6z0asIzJ+IWhSpxbKvq/w12s3AKdNqvnmoeSEL7+kFaHyfUFZDn
         ewhvs+ns7hBWlAB2jUN/OSHjB5twxSCBN/K9HipJ39LpcxTmObEz2OZ3UkC5QLdk8YGr
         mDwg==
X-Forwarded-Encrypted: i=1; AJvYcCVWdIrlU9apggzlwIPaCITQIqGT7qE+rObu6KUQp+S22iOxKonZhJO6N0nnB+wNfMFV4Hb5Y/VEe8jJaJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7gxegDOE6rK+0jkPgArKWixr/5lp/9M8gSJhlLli8V6jXnZM
	d/mzjgIrsTkygiUXK+sw5aX6OCUEEf1Ni6A0CcdlNQQpWSlJ+kXxTN6y
X-Gm-Gg: ASbGncvcP5Fj6rXcQJJjQACXSygZoFp/BXtmuvkTNIflQWWAG/nlBamnCbgrk+dArdj
	jqH5uZ8aigognl+sNBSOnhLe3trZu5ytFINgXxAomkZwIxXg4XBkWzfD5krbRWsDOVJL0iYIzez
	s+Z5Jec9/urjlwI6k08WdyuwkSuFcxY2TwLjEFn18yHsuALpC600l/DVRH2NWBaJsciWb4C64am
	KMGnWcAh3JCwjhqWitrFkm0J5mLtvqzqS7btgTGq+J5FQXd0QHIm/amRtIK4T3pZJUJdiuB2nGW
	UH9UqpProssLjlqkrcw9akVYNc0SX/zNnGfIaSR1VfIqG2V5zoNM4853jrszPXK8EeAa2EUrlnv
	OnujlxfSG5IXj8dGeKbGEAexvvWleBM+F5yaTPn3lzbBlMMB8L5TRVK5UicTw1PFKGrHAORGiv/
	hTh4OmX1A06CS7YN15288qvzcHxyGas0gxYAEiL6IhPw==
X-Google-Smtp-Source: AGHT+IFfYDvYZ45pW+WxgEkGA6abEIJy0OcTmO++8gLwaAe73KEPHQyTKPYzy+zuZlTY3UeOAnHp0g==
X-Received: by 2002:a17:90b:5868:b0:32d:fd14:600b with SMTP id 98e67ed59e1d1-33b9e0a4a30mr7899793a91.7.1760668540774;
        Thu, 16 Oct 2025 19:35:40 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b31703sm968972a91.15.2025.10.16.19.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:35:40 -0700 (PDT)
From: Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To: akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net,
	jhubbard@nvidia.com,
	akinobu.mita@gmail.com,
	sumanthk@linux.ibm.com,
	peterz@infradead.org,
	huang.ying.caritas@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Andrew_Su@asmedia.com.tw,
	Yd_Tseng@asmedia.com.tw,
	Ed_Huang@asmedia.com.tw,
	Cindy1_Hsu@asmedia.com.tw,
	Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw
Subject: [PATCH] kernel: resourse: Add conditional handling for ACPI device
Date: Fri, 17 Oct 2025 10:35:31 +0800
Message-Id: <20251017023531.5616-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid address conflicts and related errors, specific checks for
the ACPI device "AMDIF031" should be bypassed.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
 kernel/resource.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index b9fa2a4ce089..9ffcd5bdb62e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -177,6 +177,27 @@ static struct resource *alloc_resource(gfp_t flags)
 	return kzalloc(sizeof(struct resource), flags);
 }

+static int IgnoreResource(struct resource *tmp)
+{
+	char *pt, *name_sep;
+	char *name;
+
+	pt = kstrdup(tmp->name, GFP_KERNEL);
+	name_sep = pt;
+	if (!name_sep)
+		goto out;
+
+	name = strsep(&name_sep, ":");
+	if (strcmp(name, "AMDIF031") == 0) {
+		kfree(pt);
+		return 1;
+	}
+
+out:
+	kfree(pt);
+	return 0;
+}
+
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
@@ -202,6 +223,8 @@ static struct resource * __request_resource(struct resource *root, struct resour
 		p = &tmp->sibling;
 		if (tmp->end < start)
 			continue;
+		if (IgnoreResource(tmp))
+			continue;
 		return tmp;
 	}
 }
--
2.39.2


