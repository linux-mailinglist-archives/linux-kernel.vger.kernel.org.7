Return-Path: <linux-kernel+bounces-663622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B22AC4AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D64E3BD86D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703224A05B;
	Tue, 27 May 2025 09:00:30 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 650001E3DF2;
	Tue, 27 May 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336429; cv=none; b=XkSNi8Mbj4PvXxQd69Pscjcv0SBj4r5KrH/cFV9e8vnK/EJV4P//yy8nem+Wic4YRs/6kpxzw0MXPGFusRPej0W1a33ljYq99KxWZB/51pXeTumT94CTSODke9MvEa2cvjRm+BzGc+cinAdjuoH9eId4c3HRFeGI/0jXT4336UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336429; c=relaxed/simple;
	bh=tL84/JEk3fGYe0J2AHNPmrBOPB2tidkYygqtLOngpAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljt+6jczCZtnurFJRO3mFlIeZ1XI5P6s4pp5vdyYEH9j8n25ZLZr4BavTrbb3RmpPF/ZMqOAOK9UrDiDsHnuQQOSh8iFn4iusObDV0Pt4D5IdqcdGD46AGwoKW4XvjoX1F9mH/9KyRmjHVauuW/WApQzZyWTrSnU/2y1Rz8wT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id DCA856018E58D;
	Tue, 27 May 2025 17:00:19 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: mikulas@artax.karlin.mff.cuni.cz,
	sandeen@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] hpfs: Replace simple_strtoul with kstrtoint in hpfs_parse_param
Date: Tue, 27 May 2025 17:00:08 +0800
Message-Id: <20250527090007.1768305-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kstrtoint() is better because simple_strtoul() ignores overflow and the
type of 'timeshift' is 'int' rather than 'unsigned long'. Using kstrtoint()
is more concise too.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/hpfs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 27567920abe4..8c594939ea80 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -404,15 +404,11 @@ static int hpfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_timeshift:
 		{
-			int m = 1;
 			char *rhs = param->string;
 			int timeshift;
 
-			if (*rhs == '-') m = -1;
-			if (*rhs == '+' || *rhs == '-') rhs++;
-			timeshift = simple_strtoul(rhs, &rhs, 0) * m;
-			if (*rhs)
-					return -EINVAL;
+			if (kstrtoint(rhs, 0, &timeshift))
+				return -EINVAL;
 			ctx->timeshift = timeshift;
 			break;
 		}
-- 
2.30.2


