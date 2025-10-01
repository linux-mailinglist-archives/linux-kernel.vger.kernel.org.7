Return-Path: <linux-kernel+bounces-839333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71FBB1654
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9263C4101
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009D280CC8;
	Wed,  1 Oct 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="DdqxixZU"
Received: from mail-108-mta192.mxroute.com (mail-108-mta192.mxroute.com [136.175.108.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6D280A29
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340783; cv=none; b=IJwO26Pd76Rh516v9giiCv6xeKHQos0fN4OfG1rc7I+nj4NKMVfT8AnsmUpGpmSq0+fvN+P5OpRgb0ShbhfJQlmVedLOwIYmfxsw7aP3kMKh/UriAlWMXWBxfbNfrWVhEngT3zZV8iMUkAkgavkwU7Yk2wCdWPPwxQic2CDZVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340783; c=relaxed/simple;
	bh=0mI/h4okQ+HyV2So+OT/8LagdX/H0JhXVk8mY+GU8d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OH2KcrW4B4KmxOIz6tTWWuvdm4yTegLsi8y8wLhzBRmY1TR6Uciu4BXqHRe/7p3TUzF2LeeNsOn3pe1sb+5FNWQ+89Z8io0a30ZVfiIvf7IbPur+31utUxga9SxU/moTyYPmmLZG0/5HeHMePN5cKapE9nYtslHrOkArO0D1vC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=DdqxixZU; arc=none smtp.client-ip=136.175.108.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta192.mxroute.com (ZoneMTA) with ESMTPSA id 199a0dd1761000c244.006
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 Oct 2025 17:41:08 +0000
X-Zone-Loop: cf445973fb018db18ada26a423580c16a5f4f565f091
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=OxgAxY2TQx1e7vTImhuvFD/6erwijMNYD8jS3/Jl6wU=; b=DdqxixZUViwe
	AuPljKAPhglRcMseb0Hlg93YUeQXkDbXsO111NLK39gfpJ9yCWjAc2L0dnGLYZpk7fCPEkvA8xBDt
	v/EqLTaPNPVw60SnHzMslBtKRENLBVOutKrtolT0qS8jJUhDx/20BHa/241/eupL23YRA6jPO5AYz
	o2/ARqQkS8OMSCQ1iRmPZFwg7NeFtZLLpdAYayaMHuzeXav2D7EAEse8AzkvYkWo48CHj0/hdfYX7
	uopN0BGWPhAjI5XhHFl0Q+q7vDWxo12qEDxFypgEmZpOdjZENHfiT1oesATn7h+Osw/MaiYoGXo03
	IT3JxSSjSSoT6mjGyFoxFw==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/sysinfo: Replace sprintf with snprintf for buffer safety
Date: Wed,  1 Oct 2025 19:41:04 +0200
Message-ID: <20251001174104.192486-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Replace sprintf() with snprintf() when formatting symlink target name
to prevent potential buffer overflow. The link_to buffer is only 10
bytes, and using snprintf() ensures proper bounds checking if the
topology nesting limit value is unexpectedly large.

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/kernel/sysinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 1ea84e942bd4..33ca3e47a0e6 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -526,7 +526,7 @@ static __init int stsi_init_debugfs(void)
 	if (IS_ENABLED(CONFIG_SCHED_TOPOLOGY) && cpu_has_topology()) {
 		char link_to[10];
 
-		sprintf(link_to, "15_1_%d", topology_mnest_limit());
+		snprintf(link_to, sizeof(link_to), "15_1_%d", topology_mnest_limit());
 		debugfs_create_symlink("topology", stsi_root, link_to);
 	}
 	return 0;
-- 
2.51.0


