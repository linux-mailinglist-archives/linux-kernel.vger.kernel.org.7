Return-Path: <linux-kernel+bounces-752856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6915B17BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7547F5A2A54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F7B1917F4;
	Fri,  1 Aug 2025 04:12:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F4123AD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021549; cv=none; b=bUuJWlOuIU/l5/NVI/BOgroKVqTchgLyABWwZ3wbXU+KZ4pryLC4e2sB4IZUNAzPnrXyQRMK/92ftfgvm5rzt4bzD6GoSicXs4HvbwgkkqgZjdstFtcR0pv8szH1gjn2UNjGvt0jF28ApdqzQJ07X2+gKSTDatzCQpYb+HASpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021549; c=relaxed/simple;
	bh=X3ZW+CVKJDBje2ybWlF2jbyXBI+zp4eKl0l0NYGEUg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usj1SHJlVA93FWniuzpKSvPHLWNHozh+2HkronAOcttj+86fNW0P/8SNf4FdfLVtkWiOziqPTTVaenMxNLaRUjfnxQj/ktN7nmobqS3pS0LiAvbzKSL+WIxwXFGAwXwybPffxFvf3USBiXgvew4Ltt5ZfSUhW0CDlWMEwZ5ycTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5712kxa93018683;
	Thu, 31 Jul 2025 21:12:20 -0700
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4888hggs5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 31 Jul 2025 21:12:19 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 31 Jul 2025 21:12:19 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Thu, 31 Jul 2025 21:12:18 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com>
CC: <agruenba@redhat.com>, <gfs2@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] gfs2: Correct use of trans
Date: Fri, 1 Aug 2025 12:12:17 +0800
Message-ID: <20250801041217.2797470-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <688bb19a.a00a0220.26d0e1.004d.GAE@google.com>
References: <688bb19a.a00a0220.26d0e1.004d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6AKnE0Qre4-fFrcLAatfJWU3Tj02qJaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAyNyBTYWx0ZWRfX/hcqcDqSj9Bb
 D/Nfj0I5PrXHq7jbISUncjCKw+X1RdtYRhUxa1hrpfvUax37LJe5sGz07jf3qW8WwtPbryxAiTK
 BgQ+aYw2xDRRb8EiLC1zwhLm0D6t1QiDcrXySG1k7ZHUNDtaOnTe6PDohHO8eyzm8P6TLvvU3OY
 w6i8yeAFgck+EsMd6Zk4OXGqJMqox/QRc4HXWZipIcesxHRrmVch3AEVhDcu4TcaTSBczhyGFLq
 yCdxnovsWEf2p1B2bqaidY5tLB96JfnKMi1TrWxUDsYwZiNoY7TJfEGkqi4EEOJm+XK8IIrfWWF
 +o4lxg6eETJyDNNuC1WiJQHRTBm5McbsOFlu42B6eyi4exxIbJrmfHR4mdlQTHr0j77ApIXFbqD
 C2x0ou4z
X-Proofpoint-GUID: 6AKnE0Qre4-fFrcLAatfJWU3Tj02qJaq
X-Authority-Analysis: v=2.4 cv=SreQ6OO0 c=1 sm=1 tr=0 ts=688c3ea4 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=syFJ5H-42f-uVwpxyO0A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507210000 definitions=main-2507310086

There are too many factors interfering with current->journal_info(for
example: dirty inode, write jdata batch, etc.). When trans begins, the
current->journal_info is set to a new value, but when trans ends, it is
set to NULL.

When revoking a trans, use the trans in bufdata directly.

Fixes: 75f2b879aeb3 ("GFS2: Merge revoke adding functions")
Reported-by: syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f2b9fe431c853e793948
Tested-by: syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/gfs2/trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 075f7e9abe47..d1a34f928a18 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -314,7 +314,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 
 void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 {
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = bd->bd_tr;
 
 	BUG_ON(!list_empty(&bd->bd_list));
 	gfs2_add_revoke(sdp, bd);
-- 
2.43.0


