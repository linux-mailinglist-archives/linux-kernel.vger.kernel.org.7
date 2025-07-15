Return-Path: <linux-kernel+bounces-732062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD82B06162
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73031C43D34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6651E98E6;
	Tue, 15 Jul 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJwAzbcG"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9B20AF87
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589809; cv=none; b=nkXEP2QnGLvNuyjJEDGrPdMj1d7TJDhyGjRpohCy/P4Ko0kOPtVkv1Rz7GHzHzuWR7zj9JoPw6HcUJje9ehqZHfQxuoMPwnI/NoT6oEkW0mDYM90iwbTSyDyI/Uwz9e/b7K9mYAnrjJNgzIfWGS7PLvaTcRiFe1VOfavs1nqk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589809; c=relaxed/simple;
	bh=mW9VAE2TJjvxLq6UzQzdZhUmSE1Tuy6bfCbsUPXOfhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYlZDs1mVRoVapPVIoFND3H3O63VX5spehoqfNHG7/RAOiWpXjVcJkMWAD5QNZDZv2RntxZG7jxasE3Z7upGY8Ozvr0EaXc8eS3RisE7lHhGJibtsxzg0naXKXKCIK7gZHZdPm8B9im8fG+vrvOWlG4+dKu3yOo+O/QOJnqYnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJwAzbcG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ea292956so51954145ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752589807; x=1753194607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqcUPxb6xdqWPY4cjaM3T6PJEbwEKQ6EYUQxE3AEwh4=;
        b=aJwAzbcGFFzfhz3GlYWrpL5hq+2AB2iXdNHTE/mlozVYOh+6VA6etD39UOtQ9efnRk
         iejF0jmcxOqpJi312V9eXsYyoNZzwqh+tqc5aOUfOezvH6c6x6FQry+ygwl4uQEP+fwE
         NTJIb6DUbS1DpVeqygXAMcjR5YBgDKEwhqhFuXM9/ywJpaHyjmg1oG2hv5U6pFQ3ka7I
         FsNNqkIdFZLvkJWUf48FBVMkiBG3/BUL0rrVWfYqch9dZvimuv2Dt13XxV2OiuKbMZ2s
         +Yea19EQXNe/gZ/hgKeLA9s7tsY8V06GvEZnxTgv66+yoF8oR+2+gq8pKySlCoSYiFGi
         B+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589807; x=1753194607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqcUPxb6xdqWPY4cjaM3T6PJEbwEKQ6EYUQxE3AEwh4=;
        b=hTqMmNCBV5pIEHP0lpyLglAz+BykaJbSG620dxnSbys5GEi/9SoUymJ+kdSiW0x+d9
         RU3Kn9/CUAy28p4wdsWlv20KKScMFroO5NaBdc31uHX6kKo6MG7DsMxUS5L4HqUzJn6g
         g2WQcpHdz4XfYjiFartWabMnJJFcEbEU5WhXyR0P72Hk+K0GW+2v30PbnVCmWqk6+S2B
         TI1bWEGq8w0p5qsKmWAWJu4O1l60VUgJssZEEpLiqjTy5H0fBIgJ4kQm4kDMBN2QgLYd
         jBelvox6+UHYEdXquQAolx4uvtV1yauqi6/a7+6rlYDQPX3/F9+Bx8FbHlzWA+ktA+i3
         j9ig==
X-Gm-Message-State: AOJu0Yz0yNGBkRw3AKxPu5wOgGcss6ZhM7h/f9+9J2ulG5gIsuWi1NP7
	55hIzDh8vGwyPvQJu0a/RCw4MyOz3l+l4JrO4ZdtpXMEti9YmbFl/mnnIVw+TQQv5A==
X-Gm-Gg: ASbGnct+fIi3EkEjWFKy06LSWciuCMSOi39kcbBjxxZPi3fKtYtphtQPQZyxOS7cBy6
	5p1wxbNU5WtZiQQ9CybD0i/VuB98MXLVW6dPWIhZAp82tKhCig7/RxZJkDM0lA5f1ncWtWYvMUE
	jLqJTx0FPqeZ6nveMfWkXPu2+yY3CX+0elkD133ai6CByIn3wZTSB61QlvG3UpgsY61V9zuKz5L
	3tN0jvIXAeMimlSBGOL3xMqdBC6lc1Ad4anB5TMyW2ZtFzJqIAUGAceBVjk5ZmZfD3SwmFbz3Vb
	CVPUFmLW7pXX97mRzWHinnPSV9389VOYpcKFl7Cc/q6sNz37j8U+B0dPLRphJmu6iF+ijPscKeB
	Tj1D2qHMBx+ajSUwjKwI+eBpW1h2n9uqNfgP4Vbxe5oTdhXIiyG+Rl352PPUigA==
X-Google-Smtp-Source: AGHT+IFPzy7sGURmn9vPvdxhyT9WZDJz5+UOP5GT6PKA151WE249+Q17RQgcQ054fmCgChTU1P/c8Q==
X-Received: by 2002:a17:902:d58c:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23dee1e84c4mr244786125ad.18.1752589806766;
        Tue, 15 Jul 2025 07:30:06 -0700 (PDT)
Received: from max-MacBookPro.. (36-237-135-199.dynamic-ip.hinet.net. [36.237.135.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad268sm110515795ad.77.2025.07.15.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:30:06 -0700 (PDT)
From: "Meng-Shao.Liu" <sau525@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	"Meng-Shao.Liu" <sau525@gmail.com>
Subject: [PATCH 1/2] samples/kobject: fix path comment
Date: Tue, 15 Jul 2025 22:30:01 +0800
Message-ID: <20250715143001.27407-1-sau525@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introductory comment still says the example creates
/sys/kernel/kobject-example, but the code actually creates
/sys/kernel/kobject_example.

Update both comments to reflect the actual sysfs paths. Also,
fix "tree"->"three" typo in kset-example.c.

Signed-off-by: Meng-Shao.Liu <sau525@gmail.com>
---
 samples/kobject/kobject-example.c | 2 +-
 samples/kobject/kset-example.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index c9c3db197..e6d7fc18e 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -13,7 +13,7 @@
 
 /*
  * This module shows how to create a simple subdirectory in sysfs called
- * /sys/kernel/kobject-example  In that directory, 3 files are created:
+ * /sys/kernel/kobject_example  In that directory, 3 files are created:
  * "foo", "baz", and "bar".  If an integer is written to these files, it can be
  * later read out of it.
  */
diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 552d7e363..579ce1502 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -14,8 +14,8 @@
 
 /*
  * This module shows how to create a kset in sysfs called
- * /sys/kernel/kset-example
- * Then tree kobjects are created and assigned to this kset, "foo", "baz",
+ * /sys/kernel/kset_example
+ * Then three kobjects are created and assigned to this kset, "foo", "baz",
  * and "bar".  In those kobjects, attributes of the same name are also
  * created and if an integer is written to these files, it can be later
  * read out of it.
-- 
2.43.0


