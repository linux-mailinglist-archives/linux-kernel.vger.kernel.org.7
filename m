Return-Path: <linux-kernel+bounces-861729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 174BFBF37E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD6434F2CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B122E0408;
	Mon, 20 Oct 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFfqv7bT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EC21F37A1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993282; cv=none; b=A/W5fj+LZ9Ha96JwAVR/l8q4HPd9J/cceJJnaoC5NkHQ+VEkEsyQsv9Ezl9123/tjJD2y4NCMSoIfBOnO+MP3fjQJ7plJ9ldSaeUWVssms2hVhf5mpH7Hh+VaM6b4ad7qDFZNT7EabL78TfzRkH7UWI3au13SR3dZ1dzXyZ33MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993282; c=relaxed/simple;
	bh=+lQWjylLhy1i02VSP0o8EBAfjzoQ3wmltcvC6mtbneM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pr+FDkDpSrTBe0x9WQH2PGWGsfofUwte0NJ4xisi0nnDzEFdC8hvjLvLEMjColDjOIB7bE3s9rVfdZ4VZnjNBBD7k7xFpTYNBOxKm2kSSfxHBPpRO56MAJPq3ELoejljiMbxwIGhtfvXT0f5Qjvcek1HfFguP7TVyjaL4w+qlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFfqv7bT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26e68904f0eso47686085ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760993280; x=1761598080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9q3clnG/Bkvn7l3sw7E6dauVwm40zMq9FQvMaqCBk4=;
        b=WFfqv7bTTXbzdsBIicTebUxp/NACVlOZ6Nw/FeB6MT5RTu8bz/IhYtwQ7IEzEUkOL/
         ZA5Mt62YfhIzsGpkDFoYrqrjsKjHYvDefjQ85mpc2TxyKgAkxTEaR5bKqR8j9NdCJcSD
         mwsK/qDxhgAoqjns7dz+YwFK1xiGtwlSSeLVdLr9Jt1v5rGGxvxg2dIK1QB6vaIXFhlb
         PM4Vo7T/c9ZmPvpMNIDHTqOtqJ1a17jnIwP+yZPN/yWKEhchAMOpmflqpaVsHFVEfuCL
         0Cd6kPx+PKqoK/JmK61s9AP4Lkzz60QcIwLEL4t0/GrYgkOqM5quA0/tkVMFkPEbAia1
         846Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993280; x=1761598080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9q3clnG/Bkvn7l3sw7E6dauVwm40zMq9FQvMaqCBk4=;
        b=mlsjas7DXXaXPsjQYtRCu/kxkbD2f0FdalLqTrldV7J+GyLfTsJ0wQLXLfmWLL5S0R
         vYf2Fyxi/RS8p4pN49JGIwMw0atmnnb/sV4cO75jOUM/TbGY3roQSYeBwhzp0JysHUU6
         k82ElqbTDek1pOzqfjXrMzUEizIZifN4DXRhaqy7xwfi5eel0tu/KlOiZUyoeO7erg03
         ZvC4+vY/zusnUkcmpkYfQw7PfYsbVc7XDW6Z7NteLuSS60TxK/7k8awhEjtapGBiXFIC
         Nnj8U0juYyt4jEmIuEUTNZrxMEL9XmCGHhA96TdZd3l6OIoNI9NyuyCdEnL3hknxpjr+
         lYkw==
X-Forwarded-Encrypted: i=1; AJvYcCVje9zsDFiFUeQ6ucmYnzbjZuTk+SU3mVMCTFimwblAnuZk5cAHHPt5F3FO9tPi76ZnKOTiaNpWTo+01fU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RiKdwUoQHuZm8t2SRVF7Bc0s5TpOVdMflVVNsTNWdsSJYkZp
	XPD+w30xsfOfUZtf8VDprImVZUQqyFKTBmRlUuBJQnSGugcmiv2KAV1d
X-Gm-Gg: ASbGncuMEpOrePH9pZzojDbw0hfAie3nJMppYp/kq5nTi6N1eDP0Dmkg8Gk83YMlp8n
	OmsZzzbedzlvFbmlkkh2JTno2NkpY95B2BbPPruTQt7uJLTcNU6My5JNg8omelzO2BgktRlWNnj
	plPCiIKiorI+YC3aGvI9esSQymFNudSaQBt49M4iD/gAqgOZjMxWQKv3YiEyboQJ7p8m6KdM6Fe
	SNwF02lxC+6X/u/4OWTgNMQq3KOW3yWU4iCGXMOpZ4Fef9QhWg62HbK+ZWHtPsz1SUTxGQhrIql
	w+CJvls2CznbgqU6Mht+HaH0zrv2DTe/PsFeXPp/qK7dIMlJa97xFpvv2AmfktHJj7oPOKPl3H3
	U5T98QIO1UTry44N9boR9HyPwAF2L+ge+FlvGnD6in5lL5kxp+PK+jngKMv3StNEl+bMPPFl7+3
	CWQBxKjd4w
X-Google-Smtp-Source: AGHT+IE5e+ebTLo/EOuOY7XEa0TXekx7W1YXHb9P048rXvUtgRAvL3w238dOjBn2L0cKSl72dYYTtQ==
X-Received: by 2002:a17:903:22c1:b0:278:704:d6d0 with SMTP id d9443c01a7336-290c9cb2666mr188482125ad.19.1760993279652;
        Mon, 20 Oct 2025 13:47:59 -0700 (PDT)
Received: from LilGuy ([2409:40c2:102c:a203:e88a:758e:c83e:2ed0])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471fdcf9sm88461725ad.91.2025.10.20.13.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:47:59 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] mm/damon/sysfs: Remove misleading todo comment in nid_show()
Date: Tue, 21 Oct 2025 02:17:13 +0000
Message-ID: <20251021021712.59017-2-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO comment in nid_show() suggested returning an error if the goal was
not using nid. However, this comment was found to be inaccurate and misleading.
This patch removes the TODO comment without changing any existing behavior.

This change follows feedback from SJ who pointed out that wiring-order
independence is expected and the function should simply show the last set value.

No functional code changes were made.

Tested with KUnit:
- Built kernel with KUnit and DAMON sysfs tests enabled.
- Executed KUnit tests:
  ./kunit.py run --kunitconfig ./mm/mm/damon/tests/.kunitconfig
- All 25 tests passed, including damon_sysfs_test_add_targets.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Suggested-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..760279092b4f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1112,7 +1112,6 @@ static ssize_t nid_show(struct kobject *kobj,
 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
 			damos_sysfs_quota_goal, kobj);

-	/* todo: return error if the goal is not using nid */

 	return sysfs_emit(buf, "%d\n", goal->nid);
 }

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
--
2.51.0


