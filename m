Return-Path: <linux-kernel+bounces-744011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8A4B106DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EE6165FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F412252286;
	Thu, 24 Jul 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Rq4LW8Z5"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3523C8A4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350441; cv=none; b=ejxxQ9wMVjO4YRa7aeHs/uHZ4QdRvpLuKwm4x85dyFnM5d4fT56CNxSZ4AxiX/rrSUeUqS3z5a+zHexhaBEUFdX9+0yzspxQYAIvO4AQDHFH08L0NP9w9puLNM+mLneKNtpl4UELI/+IO22Ah9kkic/AL+3FqJ9495GVoaRjtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350441; c=relaxed/simple;
	bh=bQf6hjht4zeUtI5sUMuPEbI+zFKOq0bHzvFparNqgFU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IadScERQoiC7Y3+djqx+yD+fe3m9XSarNFDviaxjI1uG4V47dxdRE0qzaaSy13GKBqHrILtsslvwXFB1DG+oEBEgfFbWhLDg3sDsjfJUDTRfdPkN3Qz00QIkNRlXray/JQuDHoKDLxQb76a+GmxlHXmNZYd+l9F4KRGabMMX50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Rq4LW8Z5; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753350427; bh=oPFz/oq0nb8y00xssg8hSYvjF9CeFkWsQfge10Zo7f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rq4LW8Z5viNOl3E2eKQw32DoWBIHZmnghTo184d5W+XdQ7mkI9GT0rVooJBjL8J+I
	 PApTBRPaMnxaE+snvbcaQ2O64orf5ATbp5urv3OnaCi2I9RjyNOdUqsIvCaBJgvnWv
	 B2eKVtCuLM9HVTdMdqFe8SlT2L0ZX/4e5LVLnkao=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A3883E56; Thu, 24 Jul 2025 17:40:56 +0800
X-QQ-mid: xmsmtpt1753350056tms0y5l84
Message-ID: <tencent_71A2963037984AD4740F774567DC3C213609@qq.com>
X-QQ-XMAILINFO: OOyEews/EdUgCLC/x5/jQeMyQcEDdMCL1yOUsROp9pkDwPQCkR73SDo+N0PoLb
	 6BEIAI+tTyVOxrDtRlkL+rdqW4gyrGDJqT/pkGT+sgTBOAXZAOkGHTzfjl8jKHpDBmqywd6s0+vi
	 jmvAM0QBr5N3LiX7il6azS0ukmlNq1C/ZD/VdWEqAQWQrPyCj/mcehqEBM6OmaJq7U5TXfkox8nD
	 nKIZmaWwIVqXz8pSp7n0HmzQJWoPU0Jnm/VhVdFeeSi8Tg4xZabmhQoTmzqKinxWVjx1c9lhkjfu
	 kBIfREMt45T2tuo7aqORosssbEWN1xmQVhtTOQK1EoD3QWq+qyOHjPk+mlmnKK6uQfrXU7jkPIPp
	 6yWoTnw2JN2TGZfT2/FopQFgicChjvKWM07AbH7Lo5KcTMG4sfShMMJbfpeGhkYWlYuMUx4GL9kp
	 gSf1w2YYp6ehNv/a1AOk1YnKZn4XrMgE2BJe2EOM2IqoUBWGL7tw4BCUgq9/6aCdVCoN/Cq9K7wv
	 8zDfRotT6GLe+YF54f7pk9xvBAWK7FjC/hLepm+KfA3pJ+YyhS8q7VcT17czm2KwqCOZG/14rjNY
	 oCZNdmWeFQw0WQnzpo/F1hZBDBUdXvlp7aZOseQruAQQtEInytPp1TkOulrCqSaqjQkvQo3unJQp
	 DQBbPcbyTT1r4cXIdmpu6azCk1iPuo/F1eg8KH3MB6YfNbx0n5IPcpNbtx5bEGCR1s+uzAY4SbMQ
	 UWxDEMDuNVqEJ38j+UEpzeTpvV4B0SxZIMRshVq0fEMbwgO7IHXKOVlN3+gG5PufMxG2CkONoB7W
	 slUu8v9r7sHQYpUFpWnPPdPAiXHLUKcdYoH7938xwI3BYXG++rLeVgWhZmpDin1aqUbRFYz2nd7H
	 oApOEg+N+JsDyuWgXhVR2aAzFmC4iHxI90Q7majqULAJ12kRpcy/7WE+DhpyTMBnGcIp+8b6ghVR
	 4xNcg5qvCTUZQMtZyFotDTpc1tpcO/
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
Date: Thu, 24 Jul 2025 17:40:57 +0800
X-OQ-MSGID: <20250724094056.463928-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68811963.050a0220.248954.0005.GAE@google.com>
References: <68811963.050a0220.248954.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..763b6209a198 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -208,7 +208,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	}
 	hfs_bnode_write_u16(node, offsetof(struct hfs_bnode_desc, num_recs), node->num_recs);
 
-	if (rec_off == end_off)
+	if (rec_off <= end_off)
 		goto skip;
 	size = fd->keylength + fd->entrylength;
 


