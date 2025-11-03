Return-Path: <linux-kernel+bounces-882332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2FBC2A343
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4DA3B1E70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0633296BC3;
	Mon,  3 Nov 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Jhn+ka9K"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A74266581
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151886; cv=none; b=UCHxG7EWoGpFC7ICt3p2kifVMk6tDttW5MPseeTzPUHIDPT2lqiaC/P9UvyPgC1l/qJyzV44bdlpcNRgKu/0zkN8qebngDHNCrACTCyeVoa4WviscHNm+4GlHog/IJW1oyMSG6t4C5Zlba4UXOK14GtFGFS2bdEIWxJDdjdBx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151886; c=relaxed/simple;
	bh=4aglrJL59adAqF1Wlfr3wfM0tQSoHETQpMw62HmaduY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MezspaBmIR8F+gkELAbBCYJH2VBZfHYulHCPTd1+us07n8SkTVwJiCwH8yr4GRLs47zl5DnqtJ3O8xC7aFVSr09QVQbRfYXWekXHy3vU6D4OIP9kY2rceAd1heWcoMFR5dgHfFpbr3yYFGQIpOx6ZfeM6lw15bSaDKqtO1SDYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Jhn+ka9K; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151837;
	bh=WufCdDOpzfL/WfQ3htR6pHmHReVaZ+8ySuuRY7Lmf9g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Jhn+ka9KF2GqVfy8UT6BZeggDNwBTvacwDomz0ES6MU/OWsEGhAnKLqQsfaS9yoay
	 kUWVruh1xRyLXEEvR12LDo7trq7o76UNZlL0/Q7ZjynOVqGfWwOi0auNdumANxGWqX
	 mwxNJtvzNNBpZMnPAjWUcINIvBly/6XNiB15gegA=
X-QQ-mid: zesmtpgz4t1762151833ta166cf88
X-QQ-Originating-IP: TtKN50SrsQQtnRe964P7y1PWjWRY3Au23BninVfQwPk=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:36:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4954036096720726581
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 1/4] kexec: Fix uninitialized struct kimage *image pointer
Date: Mon,  3 Nov 2025 14:34:37 +0800
Message-Id: <20251103063440.1681657-2-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251103063440.1681657-1-maqianga@uniontech.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NK5CQ9Y7aNjz+Za4Lz7LPEgSZ3KILfmMXVUdkwjsODIA2MwnTS0Z+GoN
	bQsCLLSbhnJJ4VCdqPX0NQZl6Yq42/yVpq7eVo73GJVaXCxoQEXEj1PdnORZl9ZdHMQQ/Cf
	3UA6Pj7CAHdTAPnv5XajZLFuiGMB2wAmoH+w0scrTHahAPJ00E/57AOAYnU1HQStYK4K0cu
	xQBg9jk2MFqV8TU1E6kZ309JvyCWEJetG5eXnEG0nzgmfQSgr0TjHreDvXTD51Ug5dFMEY2
	J3VO1fv8p2Yf+KdZ3NTbVSipTB1H1TDbNbv1nJergx1FMbLXpwIQUnQ3yASgzoCvl7Pox8p
	RW/KvT6vOAHlwp2dGBvAv7pMVsrCGcrrqq2dRAZLQQq4fdYFrEXrzfkWbfWFv6vUx6rmspf
	3CT6Pd61kpyzPofFznIq4IAB9Kuzaapf1aEkzpmcweq/LpXtmmvQcC4D/S61rmxPtEyCVog
	EHPzJAMI3vnjWahekv11tpeUfga0xnH0H0+dqHS8ZTcBlcu+CDnfM1VwXA45CYCknt7OtcZ
	YwozrhPAC9lLcOvByedso3BQwBGeDmKVXoxIYrMK1/ERnl8rP+CBRA2Rrt+z4x2EqygnGaj
	lLytxyjfTwafgGBoOkkY9Pp18kH1eScPITvi4uo+S0GPXnvEF4xF+AUaRV4mcJmrcB3tUAr
	/plWWgz9XMaQf2aJN9KIRpUY/6bATKJ7ng1gDDU8lNIhCWETCSUG9+teJ7sBvslt6CudyUP
	Y+e1TIBOslzpNk5YFNKRVsV0yYp2cpLzrecOgWWKLhBFxYLV8DC8TSF7DN/+4qe/m+LCAWi
	Hy5BLWxQv3acD1JOTpKZn2LTnVgcx2yuZqtIZoZJKxRYEHObsPk36KVqP5fsjtXoLS+HBpY
	O40pKIKJRmgEGLo8NCbcXKBoaQmfrN6n8OwWczYWgYpR9iLYGFhAiRlYg2T1yuNZnc7bhEY
	JFwpHaAwx8xiEcJJa2nUPm8pXX+swVh28AEMUivIFeWaOLNxZGBBaoYp73sg9iDJTw5BwOH
	BbQ2sLPqfMUDk3FDRm3GXP1/4WeaAEFcj2R7ac8w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

The image is initialized to NULL. Then, after calling kimage_alloc_init,
we can directly goto 'out' because at this time, the kimage_free will
determine whether image is a NULL pointer.

This can also prepare for the subsequent patch's kexec_core_dbg_print
to be reset to zero in kimage_free.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 28008e3d462e..9bb1f2b6b268 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	unsigned long i;
 	int ret;
 
+	image = NULL;
+
 	/*
 	 * Because we write directly to the reserved memory region when loading
 	 * crash kernels we need a serialization here to prevent multiple crash
@@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
 	if (ret)
-		goto out_unlock;
+		goto out;
 
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
-- 
2.20.1


