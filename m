Return-Path: <linux-kernel+bounces-752604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA6B177CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63F31C219C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87B2571D8;
	Thu, 31 Jul 2025 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiaAxa8O"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988502222A9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996062; cv=none; b=C0s676bTOqTkwCniACjk+YQJzShGw9rPM86HMAJWI9XZUJJIfHvpooZjxc7q0ewq9r4+xs1XctE6eXH0BrzsPPCjyh3629edKc5ZWi895Jz+R/aL6SVjYzLrfQ0FEFqn0IXIkE34LrmcRP+gaTvl9dQuywxTmxb+zNaeEzvfoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996062; c=relaxed/simple;
	bh=NuznBOivsDuTg4wdSZyNNrC9hNG2lQz8th2T6wKyRYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkYYkIRa02lHBo9c5UQxxH6rUn5PjLMpgwY5tvajqV28DVhBlicJY9paDO6RrCHP3uNOduJmgmhHjRNN31iysOWN/w7BHCWsSba0M4H5Q7Du6lZ9yU516RWAzczQwrjmcOvVODY8qkNxga2bKkZwgwCup1mwwjFmfNoDNLbhr6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiaAxa8O; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71b5279714cso7700827b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996059; x=1754600859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys/9FFyQ9hB8hcspnWH+yLefcO8HOj7bglv0EmfT7S0=;
        b=MiaAxa8ODHktQFV60OUwm2ZJT20WKvS7ehkRoGbEeQFoV8utfHsdkvLd3p+MD+HEHz
         WX49imsHU8Nn++YeG8Zt5kr+UtCFJcWo1jtKNT+BkKQ1iX/S4lzWXy+DccxxWrnXGUSa
         /Nt8RweNxoa2FvTLRngBQFBvp0NaO6SkFK8UKY0ntFer0CvvxcOLgvVurnTEwX45PPkh
         IhPXjhoeMC7gL3he+Ff3m2kIRmHk1JX3Ho9AlT9EO32Fk9qPH1cOwqUyXZc+LaUQNiqW
         EqMC69dymQE6oPhsB3KaG+H4m6HGUNoNm/ROeP/4/YYrW5xPPIioCf8j9Yl1RydAA8nN
         4bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996059; x=1754600859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ys/9FFyQ9hB8hcspnWH+yLefcO8HOj7bglv0EmfT7S0=;
        b=kQqh5Bd3m2XWDiWdkjHLEztGUnBwp42JEASwIf6zi4UkPz+bdvnsL/hw45NBg3/Ckv
         Jj997ELe7oYEgey4dpXRR9X+fASAlWU5HsGF9esccLmv/qGKgEr0tbXgRlJ/8dwGLx4r
         FgTGsrrW2YDEKyrELIqp3sKaYpDcDR03424u+Rqy7QhWV4zqdQTnXkOP4QskXh+brcai
         8qPtiRWh05Xe7eKVErxoQSY1oxpN333QD6WlWwq6tzJsuMErpDR9xxPkBxdUz3IAGTQZ
         k1UoFy1r5Gl0Yo8TKzlHqGPU0LOtXsRqCv171MBSmVaaITO0Nj724HSkO0E79Wshm5sR
         U0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0adxLkW3ZNxfizTqKxdJTHIOORGciVlWdF1d2cPh6FbUbtgd4KZ8xSc05XrTPne3rs4b6DKahQOeCir0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lI187bE03fAyJXgIZgDC+bBXUdxsI4MkzFqpsMMdlSEsozQK
	Y+gJ+lrWVdZdKsSCIoSAxUCPVSnkEUc30tn68zFPtHLT9+h7WFzjwTKa
X-Gm-Gg: ASbGnct/4OIqMBOyp5ljZEzLlD4oAp2z1iAMosC3SycE+VSO+UwS2jZU0BKg6DB54la
	KjCefm8B1lLoZMfFMQzkS1lBlAA6MP76b0zZ2dmPSUHqUtqM+waAu9oIyKxZA8Z3jvdJI0+BB9J
	qCLhTIWG+oCekM68qP00fMYGHbQ37uPIbYh4UHWC2mYRVuq3d7Jq3F5gEZBZmnzVoYJhbR0toyL
	ZmaX6trpdBCu+0KjuWil7NvMQxFBM9IzqYZx/16mGwpUDuC7snwbHpWw7xPrH+bBg1PtP9TMXuk
	jkxqaWrvC7cW1WJkNTBMPAijx24IyECHCp0miKdCZg+I9UL05l0u59/1/AsFMSJ9PYnf8n48oz+
	xUNpHf+5AmEwQb8OTtibw4g==
X-Google-Smtp-Source: AGHT+IEMI4Rge8h7u3jlBR8l6CqYjTTPAtN94om3FOQ2i4u9MwmNuiAviKSmWcF0hf66oLb+CK8DIw==
X-Received: by 2002:a05:690c:3581:b0:70e:1771:c165 with SMTP id 00721157ae682-71b6d7f8699mr2349177b3.29.1753996059192;
        Thu, 31 Jul 2025 14:07:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a59e009sm5975527b3.53.2025.07.31.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:07:38 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Ying Huang <ying.huang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v2] mempolicy: Clarify what zone reclaim means
Date: Thu, 31 Jul 2025 14:07:37 -0700
Message-ID: <20250731210738.1451854-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
memory. Contrary to its user-facing name, it is internally referred to as
"node_reclaim_mode".

This can be confusing. But because we cannot change the name of the API since
it has been in place since at least 2.6, let's try to be more explicit about
what the behavior of this API is. 

Change the description to clarify what zone reclaim entails, and be explicit
about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
past already [1] [2].

[1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
[2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/uapi/linux/mempolicy.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..6c9c9385ff89 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -66,10 +66,16 @@ enum {
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
 
 /*
+ * Enabling zone reclaim means the page allocator will attempt to fulfill
+ * the allocation request on the current node by triggering reclaim and
+ * trying to shrink the current node.
+ * Fallback allocations on the next candidates in the zonelist are considered
+ * zone when reclaim fails to free up enough memory in the current node/zone.
+ *
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
  * ABI.  New bits are OK, but existing bits can never change.
  */
-#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
+#define RECLAIM_ZONE	(1<<0)	/* Enable zone reclaim */
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
 

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.47.3

