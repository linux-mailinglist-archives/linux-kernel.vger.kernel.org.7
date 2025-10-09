Return-Path: <linux-kernel+bounces-846183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E03BC7389
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA6B3BCEAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F31C84CB;
	Thu,  9 Oct 2025 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="baSP7tn9"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECD1AF0B6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977474; cv=none; b=l+RxOz2KKWyilG7XWHUbJ2+vMf5hgfypZDaZ444x58DdpxFysCYDxkYpAvETZXApDb1JXCeoGExjeSMqKX0fWFJWNwJ2iDBELmbI4HmvA26j1z5V1Bnp1pg6+dF4V9mAJpEVL5gZa6Qg3WPn5Akhx3yhbzDTWTmCJNn2ozUPsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977474; c=relaxed/simple;
	bh=VDddatv5dq423IkyZCSEyyXUWO7YhAagJ+vJ3rzLFZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=il1hgqOxwdJn3HbPrJFXljcqRdRCP1pQpeOAsNHSFDRVGrxB+64EtCByroN07hMSziYTMPC9HjdCngWpmQ1jzR4F208ZBZSBEYiWlVqxl7VkYvD+2PZNa1DcauZgeofs+MKSKXoPYE56pYjKBkEIAG2K37ZvGRzwkVLfwPetIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=baSP7tn9; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5991R0Jg3097912;
	Thu, 9 Oct 2025 02:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=7uLHF87dgPdA/ljJoureq9HOYFYAAzO7jSWnsb4+NQs=; b=
	baSP7tn9yHm1D9WccEfgbdc+9XPrt59XiqU4AwEwj6Y31hsdxIEaSI8hccUvK9yb
	gcU4GaWkTUV4FbQ6zbgzZS7IDKaIU1XxjEdARKFY+eTGNxMwEYLonOdhe6Zdn1sY
	2lKPai5JZ+4L8I0kqjUwErnEAvefnb2mamLn/Hl98O3s2VJ8q7ah7EJypNUw8/Pv
	REuWcox1xOJ8v/Je9bSTNngoGvZalzVbTuh4ia3fpgaGYzY0C8U4IbHShAREVWsf
	H1lMCeNZFZ3gJ4eGS8exBK2SRVi/huuOKj3RRkv4qzyrTHaXuGzhZVzxa3Y3GJZv
	8a50tK4ngVrZB8Jux6o0cw==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49nx2yr9gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 Oct 2025 02:37:37 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Wed, 8 Oct 2025 19:37:35 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Wed, 8 Oct 2025 19:37:34 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com>
CC: <almaz.alexandrovich@paragon-software.com>, <linux-kernel@vger.kernel.org>,
        <ntfs3@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] ntfs3: avoid memcpy size warning
Date: Thu, 9 Oct 2025 10:37:33 +0800
Message-ID: <20251009023733.3705264-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68e2ff91.050a0220.2c17c1.003a.GAE@google.com>
References: <68e2ff91.050a0220.2c17c1.003a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Wd8BqkhX c=1 sm=1 tr=0 ts=68e71ff1 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=AYuD0LD_d_6AQDQsYOYA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDAxMyBTYWx0ZWRfXw799xZqGUQfk
 QAV8McLoP0tJSs/EGkDBV2hMmHe/X7WlidE2w4Uqq8k7/uC+v3OskJxzQ3gLIscGFg74Ed62R+z
 EF3IT2elgfGomdyBIsXadEla48OpE8vAKVJQDvcKaNWYp/LsO59t+TsIAl/00FRg7xTLnIjNZbh
 /DFailRGqwFyS00dWM/gLdgqLFDuS3HnV7NSosSlB+EYn41tdvnTT0kwj9QLHW/M8qiTz2VXSWo
 GdlsvMjEKfX0Y7Qd6sx2i8GjglFYXjBJgNb3IG/Xb3q+6TgIJPPMe6zrjudGSE2rAPIbpY/H2pT
 yEiR/qjIXVhN/m8vUQy2qdh/OJm3JGtouwgA+X3YY4Y0HQL0r+Ybukuxj/2lzB4wtAgbAMQLDo9
 RQnuUmh3Duc1yMy23YemsH4YoElxAw==
X-Proofpoint-GUID: kaXkLIxvIN0y4-pHBnfopchwZvkTqXNQ
X-Proofpoint-ORIG-GUID: kaXkLIxvIN0y4-pHBnfopchwZvkTqXNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510090013

There are more entries after the structure, use unsafe_memcpy() to avoid
this warning.

syzbot reported:
memcpy: detected field-spanning write (size 3656) of single field "hdr1" at fs/ntfs3/index.c:1927 (size 16)
Call Trace:
 indx_insert_entry+0x1a0/0x460 fs/ntfs3/index.c:1996
 ni_add_name+0x4dd/0x820 fs/ntfs3/frecord.c:2995
 ni_rename+0x98/0x170 fs/ntfs3/frecord.c:3026
 ntfs_rename+0xab9/0xf00 fs/ntfs3/namei.c:332

Reported-by: syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3a1878433bc1cb97b42a
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/ntfs3/index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6d1bf890929d..7157cfd70fdc 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1924,7 +1924,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
-		memcpy(hdr1, hdr1_saved, used1);
+		unsafe_memcpy(hdr1, hdr1_saved, used1,
+			      "There are entries after the structure");
 		indx_write(indx, ni, n1, 0);
 	}
 
-- 
2.43.0


