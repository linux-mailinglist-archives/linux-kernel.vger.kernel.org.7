Return-Path: <linux-kernel+bounces-894360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA18C49D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E653A7A97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45634D3BF;
	Tue, 11 Nov 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LgLTiwFb"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110934D3A4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819915; cv=none; b=Ir1Wt5HaoHeRDvQnCy4khVSGiUMM9g0z3z0EdJp4cW0Nf+wVUpTpVmp4bA3em+Z6RWcp6IKS8iuf4JgwStyc2mfz5f/MSghrdSJaVwK7c8T24rAlZ24rjv2wFv85+V1M1iJCKmjZDf78Pm7xs6tVO1CAUAPdlhhubavE6+iZKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819915; c=relaxed/simple;
	bh=M/o+tNjBg8kd2glUPJ9rxubqTpnzTjDu8acVwJL/t74=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=deJKdfbvFnDCIL56V4qh2Q9vSCaPbIFJgR9U/SEhm5zWrhpe39TXKVstSqzXxWjq5DTMP+7svP1ByEOv1YjGpzC/9cSut0OHCYXQFL2IJCcZ2CKYm3SsenkNAbwa66M17Loi8R7F2TbRI0QB4c/VKFVjTUtZwTbTxoJP9zNQ8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LgLTiwFb; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762819609; bh=rscG9XiPnMZ5n7T4CtDsYNq8s0itVJzT7Nu81C7Ra7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LgLTiwFby1oczD5F7skLkFkzeH5Lk2DQaDEPSDqGrY37cdeSP86MtGfxQiHHgP95A
	 irDAw5B8i45aO2vYSYR8AMrUBBClAydXDtLXR6ZlxTXjwg6I7qp1AtxBeOffyhhYl6
	 9u9+L+PMfTjXlj0iil6ydae4wovv3qrzbBSpA+4s=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 1AFA04B8; Tue, 11 Nov 2025 08:06:47 +0800
X-QQ-mid: xmsmtpt1762819607th3pa9h50
Message-ID: <tencent_56925ADDFB5DC999044FF38DF625928D8507@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+Zo1hBOkJ0ZcXc2/gzM2iAzAkIchK5rXKZXhXvUVQppjs6C68c8
	 SFf5uvrw7dPbz6qtGXW7sDLMMGZ2KLIqtnoHlrVoK+VazQfKNSR2ru0lMzAuIGoxve0XKeEaUuah
	 I08irSy4cMFx8WllvxqlZ3MO+61yNPZiO0qf/ScKi0pYeTV1RhPvomJ9hqhQRQn4HcV35yc02cJ1
	 hlhKJgCfKzdmUDhIHXnv2gdoU7mFpQQSsftYbetk/Wcqfo7MbvOLTurfgGPmamAXpzaak353iNXZ
	 K38JnAmwHuYDtCgttOg04eMlYksLMPY7LIK6WfXoKA4iP7SnTH62zTA6DT/GVEizahh+TN1a2yfP
	 V+G56VMlGnow/rmdSxPLd/SLgLFrDsrC1LANxf08NQjP79oYHSlwjJl90tYnUaQ2n3c0NM91CiHw
	 fMxSniD/JUPF+vdV2wRTC0R/Xjj6WBruO75kUPrQxefc10F9CRkeMaQ9pzlrBWdAZyhDL6NbgY49
	 DxdeaJ1uxGuUi7axLwxT4DqS/qhRrLJpwhE4sZslYDgMuN1o+MzHNZ0juev6S+47Mq3O1BigvL/4
	 tit/Zgdjnb6zyMrm1ulIRblbleAL/9MTC5nDq0khv/nftwuYMUx5etbBcJJd5eh5Z46yLCXFNtup
	 P7wtJ3aQ5Kqc7Awv2Wikpybuyua3DCTDcQWeKSwHNmTsuOlhq4ppjZcgAKkvSjnk5yS7gALov2Dy
	 bR3ixJssIrL0YiuTE8IRkwtmmT/HcyCjuKlifgZeBl5c+1PYZ5QzCZE9bmAlfib5sggg/scccf8N
	 CCYUSGh94xVeggITWY7sQvTHgo9vDqEyGP0EdfZyp+/ZMknFcjUdBbHvp9QXHrSX8dxfUFHHaszh
	 Zv8NUr5EAlFzLMaDznoEyHqPnM3Tti0LzQoaWh1cEz77bVRQckqpyMDhmC0RMVh/htv25D/ICHl8
	 4Iauvin97cjaXh+Oy79Tyyf6XTrR1wkrZCcXiQ4UgUj8dOeKWozDBGgp3kaGQ+
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3932ccb896e06f7414c9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] memory leak in ni_add_subrecord
Date: Tue, 11 Nov 2025 08:06:48 +0800
X-OQ-MSGID: <20251111000647.1643318-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <69122a96.a70a0220.22f260.00fe.GAE@google.com>
References: <69122a96.a70a0220.22f260.00fe.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..a557e3ec0d4c 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1015,9 +1015,9 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 
 out2:
 	ni_remove_mi(ni, mi);
-	mi_put(mi);
 
 out1:
+	mi_put(mi);
 	ntfs_mark_rec_free(sbi, rno, is_mft);
 
 out:


