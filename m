Return-Path: <linux-kernel+bounces-776918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F79B2D2F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6390A7240FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A06E24418E;
	Wed, 20 Aug 2025 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFYs9N5x"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428C23B61A;
	Wed, 20 Aug 2025 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664182; cv=none; b=kzYnvHCotvqNdz7zgPTacw2cUFoklN7KOnl/CzB+Jt3IGHdLw02TZSkrcxOGwIrLyb0vMBTq+Ui9YWEQeFWcKF+ZzJf2y2ecvZiqu8AmBqarbYQVmeW0W0pqvlx8/79Dl7SC6NHXFdzfOJmDymWkMSH/K1G5nmVuOsDAGaWCaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664182; c=relaxed/simple;
	bh=LS6eu4y80ZkjO8n1yQxxcyxmL2M70DHTrJlqAImuvkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=up1p9xGiWhSOGOShI0/dUE6FAkc8uICjnNxRTettLUUG+iqDGTmH3NlVWLecbxT+1nbrsjkypf4HSHKxVjgRVKChek+BRgrZdV8eFg+xgDnsQu8jUF4kshqNWmYtwNOfIKsd1Fn0NShVIhrEHKGJTZGDhufzEUb7ZqpuhjoLO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFYs9N5x; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so549013b3a.0;
        Tue, 19 Aug 2025 21:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664180; x=1756268980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYdMpU8vMjvK2DOSIHRQXqU5/Lf0GAx2OK6XP3SZnEs=;
        b=gFYs9N5x/JXx95yx7npH7Pahpph5WtxMPJwSbtU1U5t3245rVeO3YkkwyIwHK8D6/h
         fa7grlGiDkGicB1UjvZlQHcReLcUK19na1Vbubh3ulwSuT1DH9shNM24hban5OcXtp9t
         DncFTUtA25Yelnj+Hi5eZSkuZWrdjTo7RaYTCEONeWmhkI6i5s/Y9Nnw081nkrDYyp0y
         8jY8PWfw6fURTspV6kijW7lRgDFV7CfnLamrXhHRzvCN3O8eEVEhJMXq5ty9gXnflzRr
         fzm6BEkpfPgMhaGRvr5pYRpG91Rz5b+cQHgz7EOT9+V3LpSDK82AbghYkEHWNoOJGOf3
         aEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664180; x=1756268980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYdMpU8vMjvK2DOSIHRQXqU5/Lf0GAx2OK6XP3SZnEs=;
        b=Y66HiZlKarPl/o9J3CVlzBK6KsvD61kBB4I2Ta2Pn7Md/hVq6pMzFeZLR6HlO778R5
         mUKGAtjd6Sy5Wnz/EUlW/LH8qFKb1eHTcwgKpR5IiGHHNt76/oYBzLJJZjA1U3l0u5hf
         /kpCZqvHeNCtc04Pt6eUjEwjTnyfrLYoo9r/cQSOhq5D5NyuIHqAJIkoMKQ+Ih1vNl3h
         VRfCpqhkotcSq+50ttRDVn42N8z5EjjshYKqrh1eV2METEMI72ZI2HFeIj4QJA4zjJOQ
         rTCir2zw/guNbqV4zXktbdXdPnYMijrxwQ6o60rgghTNQeBOA5YVZShinNsDiBOnnvSB
         uAOg==
X-Forwarded-Encrypted: i=1; AJvYcCUwFVd27d9K2rRXd4R5CjyyeQ+gM+q57L+fKsFjx77Jc6TGdsfZUIOXjsGjR0NxEVUzltrb7CqiYU0=@vger.kernel.org, AJvYcCV3BY4f5KswDYdY6YVMNa7keAqeicLW23tUZh9LzS0eEzPItiLjtEaX/cM63Q1g7hz16DjpBUvrRWZl/gBE@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfisqTVxWNB+l/u5jZxrMDObZ2KiRGvVEhsxayFnP1F416HEs
	Qc/HzovRdL8tyAbHiTQyTcE48n0n/Ix8PgsOEXBYbSohamHvi9UopIKS/D7+7gdQjqY=
X-Gm-Gg: ASbGncsVc/WUo6Srd150W+vikoXeCC3ofSPqSoglzYcmsCuWhsQwBLgPTT3cfrDNEI0
	qmvHCjkq7FGErmBvggbe1NrRdcAMnedgTDLpTZm6oCJLxMdVSkTXe2mj93hQBpUBn/nog6brF0p
	CuxbRCzCTyMgt/UUYxVeylhgnr3T6WoZX9yPhpIxaWrC5LKT67j4qpjF7iqPZpeOJKFt+A1IHLi
	q4KugD3BWT5dK6kwiEqFSW7f5SoMRc0mZIyfUe4VgEMYKUDc3RzIXxcTT6kR0mMcrDDXppluHwr
	zeye1k5lCnkZRN8sm6WTdOjKo2E5fu1ChJbrquYRgCAy+5XzQuDaVfBznegNNdx4xuSuE6qHDD+
	sdM0/1zDif2NoGgBMhsjdF6XXVVd7Cp1Bm2Tk0vAnDKylh1tWPA==
X-Google-Smtp-Source: AGHT+IHF+rjqgbLfRW+bQuDEElr4xApCdVU0xbOq6N+xH763334TwG5tSwmdgIyqdHYlkb8aoiMetA==
X-Received: by 2002:a05:6a00:14c5:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-76e8d6163f6mr2099243b3a.6.1755664180252;
        Tue, 19 Aug 2025 21:29:40 -0700 (PDT)
Received: from localhost.localdomain ([202.164.136.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d5513fcsm3939537b3a.111.2025.08.19.21.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:29:39 -0700 (PDT)
Received: (nullmailer pid 63721 invoked by uid 1000);
	Wed, 20 Aug 2025 04:28:12 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: skhan@linuxfoundation.org
Cc: corbet@lwn.net, alexander.deucher@amd.com, christian.koenig@amd.com, linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH] ktest: fix typo in comment
Date: Wed, 20 Aug 2025 04:24:45 +0000
Message-ID: <20250820042444.63439-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "usefull" to "useful" in xapic_ipi_test comment.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
Hi,

Submitted as part of LFX Linux Kernel Mentorship (LKMP) task.
Thank you for your time and review.

Thanks,
Kathara

 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 35cb9de54a82..d7abf9a91b65 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -17,7 +17,7 @@
  * amongst the available numa nodes on the machine.
  *
  * Migration is a command line option. When used on non-numa machines will 
- * exit with error. Test is still usefull on non-numa for testing IPIs.
+ * exit with error. Test is still useful on non-numa for testing IPIs.
  */
 #include <getopt.h>
 #include <pthread.h>
-- 
2.47.2


