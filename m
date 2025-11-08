Return-Path: <linux-kernel+bounces-891366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A1FC428B7
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6334B432
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9412D6621;
	Sat,  8 Nov 2025 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KBducc7w"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602D1E0DD9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762585517; cv=none; b=nNnU99A6KkbVRrwTu/PF1CvEJLQA2j3hQog7yo+5udCaAlLXjXT2XDUxgAoBqKqIiY7lzY9+bSqt3ait8rKJTlaV5UGp58NFmuzi4bzNvwq6J0aKz0ST+eRjqM/yUhS23yczpLpoO6bKtKnYYFytbs9SX0OOiq2I4gTAnxs7LSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762585517; c=relaxed/simple;
	bh=Fus31b+zbEluw+Vw4831GaElenCzjsrl/wGfdMZVdTs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hQ+HlWZOiVfjU+qSME9Uj6BQgL3Tyo2OKfkMBUtYRlGXS+m2b0y/aPVRqwDrfqI3f3C8pqulqT2UlYiMUVZSUCMSAN7kk+ZEYyEmHH0dFI5i79sChFqEjhFIfrpJjK3QAbSNepZJl6Ar1EyjY8ThrKyqFzFOpKGzkaEWQRVuAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KBducc7w; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762585509; bh=M3vFI/Rl3bBFlsGMCJt6jeXCRg44ZM0LPNmdeSjInU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KBducc7wwCdSN/w28/VG20g9LFA2Wae0Z/n27V4JiFbAoo8X22+aYrIecs+bdWs0j
	 oh66Yx3A3uE78x46aWjh7/TjLqPvYKZi01bCLHjXCndv9iwL/EElK5SjhUABwBKw8X
	 c+YtzfIuIgX7AVdpDLO+G+Y6nkjPgPOnUiuc7jSA=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 1478D082; Sat, 08 Nov 2025 15:05:07 +0800
X-QQ-mid: xmsmtpt1762585507tq3kffjk3
Message-ID: <tencent_AAB95DC599174FA90DA725958DDE1219DD07@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLE/ZnwyeDVSdaVsiwMwJgx2Xy1YddZzVqLQ6ddiDqPyWzSc41g4
	 djkzMR9BuSIoAt4iau7TN+Y9PIXe4Iz77Ohkdktf33Fk2391hCuhCVaPvP6WgwQUu8qpfCWrmsxA
	 TAjpTVBaGIj5YulGnCpALd5/4oZRtQ8PBAZhyziy5sLWpxlXn9Xo26vM4RvLgd7DNxyXyEVNwfcX
	 fqy11IkImrm79UVkcwrB8bxmSKFGgKVRsiKgLaGXEzQ3OZSWV6PjOsUq0h41jT+MHfZL+sA3q7Ew
	 AJOBs1em4c25BqGJE4kASmYMz3qm9BRIvO4fns0P/76RniWAWV1arji1IMie50BYfzRPAMDt5xnT
	 WdKfj8XusT7jGJ1SLp+/4f2QmaQvvD/SWe7k4JGZbb4sLxl5vPO+S0hJUDnqAkckyWKaV3fPxfvr
	 7HC31AOEpFz2A0hP+bDtA9RLmwBeswCaQALSShO7TpWa74MK0YLo4msEYuJ4SNfpTal7g67jQfuy
	 +HKem5cG01Kk4wBWVlDMHzRSXGcuaPwpxeRgV+owhuw9RCdUTjxvGqoP7eliVeSlQgxHB0mPZOrP
	 f2SpbjX0aSNrxGIUc7HskWBPKq7SFnZGDxdXCqqI5ed7ROb8kT6cr7g0hJJ2VjoeFBaujkIv9mGQ
	 LAtJ4t5EW2hu1K8hZ1G9sKT0zmc+pWTZDGXQ9f491PXxHhtv6nf58j7IHdWBnVsEIB856sC01KuN
	 Rs+z/ZMkRiCiTlQ5y4VBUYSvKvmr93JU2pQYgrF1DO/eNNmgibwddzA9dhybAZCDCS6Vp3Cx/tHE
	 TwRUJ+jDffoGp7siPa/5+yaM3+68j8aOMme5TpXxGREezLRo7C7qfYS29l4leN2oEivflLsKeOJO
	 IriaMTmo5Biggg2mQreGiWtvkKGq3/OP/UrbEYNbyDaWCJAGdUMmkh+mA1QjrcRlLCLqAPxlhEHE
	 xXf9moVazjR8+qs7ccQGWbq1o37S5fafbo106UDA8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] memory leak in gfs2_trans_begin (2)
Date: Sat,  8 Nov 2025 15:05:08 +0800
X-OQ-MSGID: <20251108070507.174173-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <690da013.a70a0220.22f260.0025.GAE@google.com>
References: <690da013.a70a0220.22f260.0025.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 115c4ac457e9..7bba7951dbdb 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1169,11 +1169,13 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	 * never queued onto any of the ail lists. Here we add it to
 	 * ail1 just so that ail_drain() will find and free it.
 	 */
-	spin_lock(&sdp->sd_ail_lock);
-	if (tr && list_empty(&tr->tr_list))
-		list_add(&tr->tr_list, &sdp->sd_ail1_list);
-	spin_unlock(&sdp->sd_ail_lock);
-	tr = NULL;
+	if (gfs2_withdrawing(sdp)) {
+		spin_lock(&sdp->sd_ail_lock);
+		if (tr && list_empty(&tr->tr_list))
+			list_add(&tr->tr_list, &sdp->sd_ail1_list);
+		spin_unlock(&sdp->sd_ail_lock);
+		tr = NULL;
+	}
 	goto out_end;
 }
 


