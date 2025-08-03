Return-Path: <linux-kernel+bounces-754478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8251B194B5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 20:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34E23AF20A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973411DF755;
	Sun,  3 Aug 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b="Gq2wAntk"
Received: from ipo7.cc.utah.edu (ipo7.cc.utah.edu [155.97.144.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A6BE65;
	Sun,  3 Aug 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.97.144.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754244392; cv=none; b=De+1b9J1FC++gYV8ORlmtPz3JXmyuj9XI7JKXEQBO3SfVexpsAxy1ZlgZ00mcN3p+cnMYTK+JeRpiveIaWZU8Q/L3wAKI2H5kWyncToZF/KoIDDiacOCQQBoXQl3zyY5d3Ei3SjDQ+1ATtBW1RNtbeIHZLd8ax1Vu9dMXl0YnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754244392; c=relaxed/simple;
	bh=1JwXp8STiCpheRabs2ETg1bUb76a8ltPNsCwVlxUIFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RaNH/6dGd8UG+DDPEwc8Miv//dutJccntV0UfmIezRe/PJNKnWUPg3dNQ21pebUV1H/oTXZ0bT72eMRC9ZwmGQ2zKirveRlSL0+5dW7WF0S6F6/6VgSi+Rgk/JUUozA29fDhFmWBpzVqydSwbFOMgO/FlbCNfZnmQ4GWAudheUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu; spf=pass smtp.mailfrom=cs.utah.edu; dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b=Gq2wAntk; arc=none smtp.client-ip=155.97.144.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.utah.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=utah.edu; i=@utah.edu; q=dns/txt; s=UniversityOfUtah;
  t=1754244390; x=1785780390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JwXp8STiCpheRabs2ETg1bUb76a8ltPNsCwVlxUIFw=;
  b=Gq2wAntk+gtekfTkyY3F0X4en6spBwLsjbryEAQi0ZAhFgzV24e9sS7/
   eK2JEIXKrjJjrri9no2Jxm10Ya4nhJgHzgTxFcx3drs79rNsEfbxpaq/P
   1ekedu1QiScA4uLftlUu1/dKhe48NUvcoAVtZbyy2MuQ0MoSNimg1tTwY
   zYJlN7ZHNf2qmK0I72k6bJxAD4/RF3eBHMtoYJrz7ctKmWoRspuPYOBiZ
   tmpV2/b/EnIae72HGmsSQ8WbJE43HoroWWRMHRtnu++4YICc0LHGZeAFp
   66ynCAhAOF1X32SJlVqvsCGpnWnLSf3h9j47JUGewtoYbvh46pOkHjYwy
   g==;
X-CSE-ConnectionGUID: utDoHAfgT9SGo0rMuZyK5w==
X-CSE-MsgGUID: NDOkl7e+TgG5+Tw5I7xwpw==
X-IronPort-AV: E=Sophos;i="6.17,258,1747720800"; 
   d="scan'208";a="399802573"
Received: from rio.cs.utah.edu (HELO mail-svr1.cs.utah.edu) ([155.98.64.241])
  by ipo7smtp.cc.utah.edu with ESMTP; 03 Aug 2025 12:06:15 -0600
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 251E230228C;
	Sun,  3 Aug 2025 12:03:51 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at cs.utah.edu
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (rio.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id unZkAccHvwO4; Sun,  3 Aug 2025 12:03:50 -0600 (MDT)
Received: from thebes.cs.utah.edu (thebes.cs.utah.edu [155.98.65.57])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id BA7F03018A8;
	Sun,  3 Aug 2025 12:03:50 -0600 (MDT)
Received: by thebes.cs.utah.edu (Postfix, from userid 1628)
	id DC8F115C2742; Sun,  3 Aug 2025 12:06:13 -0600 (MDT)
From: Soham Bagchi <soham.bagchi@utah.edu>
To: elver@google.com
Cc: akpm@linux-foundation.org,
	andreyknvl@gmail.com,
	arnd@arndb.de,
	corbet@lwn.net,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	soham.bagchi@utah.edu,
	sohambagchi@outlook.com,
	tglx@linutronix.de,
	workflows@vger.kernel.org
Subject: [PATCH v2] kcov: load acquire coverage count in user-space code
Date: Sun,  3 Aug 2025 12:05:58 -0600
Message-Id: <20250803180558.2967962-1-soham.bagchi@utah.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANpmjNPWzJZrAFT3-013GJhksK0jkB6n0HmF+h0hdoQUwGuxfA@mail.gmail.com>
References: <CANpmjNPWzJZrAFT3-013GJhksK0jkB6n0HmF+h0hdoQUwGuxfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating the KCOV documentation to use a load-acquire
operation for the first element of the shared memory
buffer between kernel-space and user-space.

The load-acquire pairs with the write memory barrier
used in kcov_move_area()

Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>
---

Changes in v2:
- note for load-acquire shifted to block comment
  in code rather than in the preceding paragraphs
---
 Documentation/dev-tools/kcov.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 6611434e2dd..40a4b500073 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -361,7 +361,12 @@ local tasks spawned by the process and the global task that handles USB bus #1:
 	 */
 	sleep(2);
 
-	n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
+        /*
+         * The load to the coverage count should be an acquire to pair with 
+         * pair with the corresponding write memory barrier (smp_wmb()) on 
+         * the kernel-side in kcov_move_area().
+         */
+	n = __atomic_load_n(&cover[0], __ATOMIC_ACQUIRE);
 	for (i = 0; i < n; i++)
 		printf("0x%lx\n", cover[i + 1]);
 	if (ioctl(fd, KCOV_DISABLE, 0))
-- 
2.34.1


