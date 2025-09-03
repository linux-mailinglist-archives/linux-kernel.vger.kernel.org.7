Return-Path: <linux-kernel+bounces-797930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C98B41746
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E3480600
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A62E1C7E;
	Wed,  3 Sep 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KVKJgAgS"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C42E1C65;
	Wed,  3 Sep 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885957; cv=none; b=WDafAjO45wxFDqenVtDIdr4kBelYr7ihtgqEi7GuK0tjEILWRsHJ1op29ueSrJVSpAn7Tfhd8ePwd8iwiSGIRW2QtCjZZ5ZuZDtezOue7cx0PnGGETAnVuyAGgNIOzxgF9EYLvsKJXq7lVdRJyMbO3Dh2HJdAM2nGNr90+810aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885957; c=relaxed/simple;
	bh=J/4vRqi3AJdpwehg83I+xUR1uhChhlY3BgTR7xXzcbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chfIu6RS/PofHL35F76/Sux7gzRhUyRGfEnVQ1jkP9YYqPRSPLz18C3kDwMWUHkplEnW0MH4WpqOnZCk04QYPsRehpQy1Ghiz/ux8IpeKZPjrkQlS/Rp3LnfWFCQnjY1FyaveWiUohBZ5+Um02RA/Kjwh+0AOBZxxuWMIDKrW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KVKJgAgS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=AR
	IXlGMt16PIpWWt0ZclsjNVZ6EBzquojBnwrtblUWk=; b=KVKJgAgSQLQattdnXC
	pwQAHVguH9p7A8q1FFrKGubaKdD2wfOczoduJyId2RVsvkZ1WYmDuyEoG9yMpZ4Y
	K1tX5oW62DrADzEjTRenFoQFUeBqygCO8EamjCb8DYoPAT9MHKxr5OI0NSYciFRi
	IYFNCxnda1qz6ArYWW72WDI5g=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXDzmf87do_tBKFw--.64726S2;
	Wed, 03 Sep 2025 15:52:00 +0800 (CST)
From: liuqiangneo@163.com
To: srini@kernel.org,
	sdharia@codeaurora.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH] slimbus: messaging: Remove redundant code
Date: Wed,  3 Sep 2025 15:51:55 +0800
Message-ID: <20250903075155.135539-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXDzmf87do_tBKFw--.64726S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWry7Gr48JF1DXrWUGrWDtwb_yoWxXwb_Cr
	s0qan2g39xX3W3tr9aqr4rZrWava1fW3y09FnFvFW5K3yjkrs8Xryqvr13uw1UJFW7tFZx
	Ca1Utr1Ikr1fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbtrcPUUUUU==
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/1tbisgy9YWi38HxQYgAAsD

From: Qiang Liu <liuqiang@kylinos.cn>

Assigning txn->comp to itself has no effect.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/slimbus/messaging.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 6f01d944f9c6..27ca16f00e77 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -143,8 +143,6 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 
 		if (!txn->msg->comp)
 			txn->comp = &done;
-		else
-			txn->comp = txn->comp;
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
-- 
2.43.0


