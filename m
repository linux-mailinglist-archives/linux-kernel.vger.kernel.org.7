Return-Path: <linux-kernel+bounces-860132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D840BEF614
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D062E3BFED2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219E2C374B;
	Mon, 20 Oct 2025 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHYrZThN"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8C240611
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760939945; cv=none; b=tKbeFAFD1crus+pacqCTGHVRU+aFrTIkD3D0f6VdROXU6epSJ1eQKtrXNKWs000ZJuOu/X4kt+diZR2t4s9pesLlWzCOmAIbD0nt2JwIjxdJrwHuEeA+x3/H8WtGBPyax5N+em9DEtMJ96tnj9LGxY1RLkbX3rSAsPX4aTSZr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760939945; c=relaxed/simple;
	bh=9YR6zpuuBYh17jTYGfG7SF0gY2nQCz/46WAN+cYH8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEN1D2h/r84D5tPSS374JWNOuY9iCVbS5YOb2DVmzuFL8Uxe973ows7ABFIZVtKLh4h/zTep0GudL5IEOBUmF2jfSt/IgvNxfEZOUDXXr0d9IaAxWWCIYWDi3KCUTLnRhP9CFpK/fk9dEM/zJeKoXi/8SNEE4I21Mgzdn0XhPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHYrZThN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b553412a19bso2681667a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760939943; x=1761544743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jh6W7krdQiiiaYxBqeKiYxYtQ0S05p25BmbNHj4vO4Q=;
        b=KHYrZThN6+zVvlEm6SJt45K2/kxX5aoB3DmlDEfwnD9dVVZaY3RQaTMRK435q4aGCJ
         Cl+PEpjjkKtkD8oITTO2Wi0gFaUScLH6mYHa7OzRwemFKVinNPcmCtzhQEDJ+v3mEOVq
         +ga8SEEtdXRXUxQ/xzBBkHWRfJ+y/F1la+Yck2Vezhll07E7aw3l9BOZEbxfyQscb/L7
         aruDQIxRgnqVJAxCM89oVcv5Sewr+YBFceH2VP76QDxtduM9qEfMsokv+LzhG5Enns9x
         m7iKGbzygqd8F3J86/vIZ9NxtdWgHTPGqVpzbVRhIpfWpiPrBPvUGA/Ixm3LDWIUuNFv
         qdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760939943; x=1761544743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jh6W7krdQiiiaYxBqeKiYxYtQ0S05p25BmbNHj4vO4Q=;
        b=oww2hBFqsVcCpzYGSUyUvz+gxot6L5Gv6uJIjh9Qz7uw7M2TyFXo/GrWAraVTPatPR
         YEm2ac+w9NSfRJpieU5HnGcPuNFtc+dv67ny0IQVVhoHvfabCtwyv3YvbEvGLF7YyIW7
         ZdkOWFSvc9G1C8gxzqeh+vYnW5c4uwKzwZ95yBLUWYKtYViTGfAyPbgknFsUCDfVbOvr
         bbaBwOGKZTOvvG972wybmFvs2qNB4lbCZqixP1RtO1c2+ARgObYn/tOTE/EJlJsr1Ho6
         wRh/WPdbHL2IPlF9cHeWE+fRar+RQCRJ49F5OVED5ZpSAKefMfs1F5caUDZSeRUblO4y
         Yc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEKNq8FTFrGZDe+z0tK/ekY46RXBGEWGVaQcPk97dDAw7VP+ilinZC3nwLW4AaMjCwPqoAxAI737Gl3bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7vDhsGShcxd5aCjukhoFJnCoQCjpV5CNOO3c++H5xyBw5ut0
	v6hKeEOAH1fLaaCMm+cU8qF2vuVRlm0uByHqLMjU9qk3WVerPlzbylZ1
X-Gm-Gg: ASbGncvVoDYb+yt8pGZhH/8M1QHj1Y5l4bBu0Wv1qQHbMN6NUxClZMzasxiVr1ic8gg
	D0AytNZhyxsFC+vWthKZ2ZxC6qrBnoyW8CPZxdHqRx/qb0s0PTX553abV4O5b79fDuoBYAEi2lF
	hr1l8mUiolkdIIT2pBBcIH8OeyjGme5eF1BdRAdUeJRvcPOXSWGcFomq8xR1+20YGyRsx8tOJfj
	+chHfW3HHKe5G2a9EZwA2HpE48MrFWRgCJ5GbdpeLaTI9HI1KAUgoCHlAloDOSiuFMsdBDBu5Ss
	CdEW66Vjf2AQIrA0YCaDece1E3bNEQLiIjWGexllUWVwpYxrZhsDdKjvFQKTL3Hjcahz1iIXvhG
	VvT+KgGnVCQ5S/FDekJMtKCnZfvRxzSKcjOB/voAzN6NVtj3mdzZTY4k22BoG4alNtWlQVMXs5C
	Eza1qHap7R
X-Google-Smtp-Source: AGHT+IGlZYGHdGgTHh1H3IPWV/+DfKsNTbrDi5Reqk7UDbn9zs+s3vYh2q9TI7qZwuSkPn3vMBTWxw==
X-Received: by 2002:a17:902:d584:b0:275:f156:965c with SMTP id d9443c01a7336-290cb65b61dmr142564905ad.52.1760939943138;
        Sun, 19 Oct 2025 22:59:03 -0700 (PDT)
Received: from LilGuy ([2409:40c2:115f:7331:acce:2657:d834:4048])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29246fcc795sm70386805ad.30.2025.10.19.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 22:59:02 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] mm/damon/sysfs-schemes: Validate nid usage in nid_show()
Date: Mon, 20 Oct 2025 11:28:24 +0000
Message-ID: <20251020112824.144391-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nid_show() function previously returned the node ID (nid) without
verifying if the goal object of damos_sysfs_quota_goal was using a
node-based metric. This could lead to incorrect reporting when the
goal metric was unrelated to node memory.

This patch introduces a validation step to ensure that nid_show() only
returns the node ID for valid node-based metrics:
- DAMOS_QUOTA_NODE_MEM_USED_BP
- DAMOS_QUOTA_NODE_MEM_FREE_BP

For other metrics, it returns -EINVAL to prevent misleading information.

Tested with KUnit:
- Built kernel with KUnit and DAMON sysfs tests enabled.
- Executed KUnit tests:
  ./kunit.py run --kunitconfig ./mm/mm/damon/tests/.kunitconfig
- All 25 tests passed, including damon_sysfs_test_add_targets.

Based on commit 3a8660878839 ("Linux 6.18-rc1").

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 mm/damon/sysfs-schemes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..23a73b94fe53 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1112,7 +1112,16 @@ static ssize_t nid_show(struct kobject *kobj,
 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
 			damos_sysfs_quota_goal, kobj);
 
-	/* todo: return error if the goal is not using nid */
+	switch (goal->metric) {
+		case DAMOS_QUOTA_USER_INPUT:
+		case DAMOS_QUOTA_SOME_MEM_PSI_US:
+			return -EINVAL;
+		case DAMOS_QUOTA_NODE_MEM_USED_BP:
+		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
+			break;
+		default:
+			return -EINVAL;
+	}
 
 	return sysfs_emit(buf, "%d\n", goal->nid);
 }
-- 
2.51.0


