Return-Path: <linux-kernel+bounces-698315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887DAE405D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DA916DC8A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C2248F40;
	Mon, 23 Jun 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vzHQd/nt"
Received: from outbound.pv.icloud.com (p-west1-cluster2-host11-snip4-1.eps.apple.com [57.103.64.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B92459F1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681901; cv=none; b=Tdy03OJKsPhHOJdg1FVLvIHnIRW4pVL04r3w5U2MS9Zh78y5M4kGE1ZFgMGSuBGpFS0uQAID3USqJEVDZQbdbX+55RdICf7JGZhiNv6WAkA1w2tRzk9AVTv0gYohAbxAKxryd6FARLSSOBKZi2wnEY93OJOmzbdQgZUFtkoF7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681901; c=relaxed/simple;
	bh=fkwjlgmRRs46qzcBjCAqAA9El9cLBiccykLVz3LbkvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AP6hVxG/CO38zjlby0TPem9n4Use8mxMIang0xRtUkC7s6++SyO6Z58aiY8vIjJReLmTra646zi2PjjLvlsGFsPjrW93uL8QMx+M7ndRmFB9xa58h4ubyJhG236JEY3aPQDaI2UU6s3/5xwzHPvs1zfBffshrM4VB37mMVz6+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vzHQd/nt; arc=none smtp.client-ip=57.103.64.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 0231C180377A;
	Mon, 23 Jun 2025 12:31:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=NHgxlTzvgc5QNV7cJrvxK2AUxsXCg2hdL0DYremg4GU=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=vzHQd/ntnLd5RGHoLoDaLBAFMHWMs5uqVmwQWP2VWMObvDJj7g6i5RO99L7djyucQu1u9Hhk701mwNrorg6eYtWmKNuo7S0JekuK8+m9EcQ9thbVfsnWbQXRAKEnQWAA+KSKXt84GrPOrqTS8TVmVN6JsKdwt0fVpL0kTpn98xo18yo3oS+IuwZIWv48Y5GDy4fZI0nehbg6FVT5Gb6/eRrjTuzfCFCUFIjbb0mpvjJ30URQQhnhFquRaQ85mgminXabHb0R1s7fmQwZHVvcnPTrxIiS1xld0kpoXyyew5FppAHBOSLTFBgcAW6TnO+hyKnHScDfId0cc3yX83y1YQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 69D5318000C0;
	Mon, 23 Jun 2025 12:31:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 23 Jun 2025 20:31:16 +0800
Subject: [PATCH 1/4] Bluetooth: hci_sock: Reset cookie to zero in
 hci_sock_free_cookie()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-bt_cleanup-v1-1-5d3d171e3822@oss.qualcomm.com>
References: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
In-Reply-To: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NSBTYWx0ZWRfXx04nththdni4
 oDtmNzzKPh7cqGrgzbxUUsP7DAvXAajI3fS8bmYuzkNiYccD5cy6J5CtSaiMf++3a+pCC0TMi0w
 WkhWZLHaDdlnMdlmkNQkjX4MQDgVg/Bcyd2zsMNzOGrYbZwSxLdvCYRRn7ZXVWjPcGyb0i+GT3Z
 TLqRQVhrFwEWg6hWVrvaHKMPrqSV++rhBjKMcT1e4dZ5XFjbj8TZDXqAyup0mBut8vOFgE1GYGQ
 JcKqWCELsrDPqnS4xzH3uL4J8iD5HOQTluqUauY65pZlOrvbAPwI1dqnBznxSp63Y6D64N8vw=
X-Proofpoint-ORIG-GUID: m6KzkSG0Oj9PaEL_VXDLV5ePqEXbUK9x
X-Proofpoint-GUID: m6KzkSG0Oj9PaEL_VXDLV5ePqEXbUK9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506230075

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Reset cookie value to 0 instead of 0xffffffff in hci_sock_free_cookie()
since:
0         :  means cookie has not been assigned yet
0xffffffff:  means cookie assignment failure

Also fix generating cookie failure with usage shown below:
hci_sock_gen_cookie(sk)   // generate cookie
hci_sock_free_cookie(sk)  // free cookie
hci_sock_gen_cookie(sk)   // Can't generate cookie any more

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 428ee5c7de7ea32fea08a2ebcf57e30dee59e3fa..fc866759910d95f40f159cfd63710f4c5e519dfd 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -118,7 +118,7 @@ static void hci_sock_free_cookie(struct sock *sk)
 	int id = hci_pi(sk)->cookie;
 
 	if (id) {
-		hci_pi(sk)->cookie = 0xffffffff;
+		hci_pi(sk)->cookie = 0;
 		ida_free(&sock_cookie_ida, id);
 	}
 }

-- 
2.34.1


