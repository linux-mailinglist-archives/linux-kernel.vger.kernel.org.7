Return-Path: <linux-kernel+bounces-891424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1049C42A16
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667863B356A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0F2C3276;
	Sat,  8 Nov 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gwRVQBHj"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD2221277
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762593521; cv=none; b=KtAg5/A6ffgU2KxgLfneznza+K2FsPLG/xSabANJ0JrcUov5s4yVGgfYP3rZCgh8RZfht648TODvTqbQFxmvFqVDyj161S6q1vvd+zpQGVsUsydBcbDYyL+nRgJLKJ1u33z3To1xEaskRB1lRj8UiK/TeDD3yxBDGlopuWu9GAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762593521; c=relaxed/simple;
	bh=vwxPj0qmsd2XfW/0p1zp/rMKjm0aBYdKiGQHICjFWxY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RYJo/BdyQDz+Ezp+HilBeBEvyQ5y6GVmELoeOEpKut5HXpF3yApNuSVeJrOo3sKlE2YDofySxEQH5yZRFw4u0mkuxMr6ra8W76RN6MEb8X5gWtghhuBSiZ3QVuHvvy+OZVkafAdzYHzQpiwr1PhApzWP9xGH7xC+fL8Z7mwLb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gwRVQBHj; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762593212; bh=+d/GUdTLj/k/68/9fjMg/ar3VsfHIcBRzhZyB/gtU1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwRVQBHjiZl0Q1upTOsAkN/Zs7rnDeaqU2iGA+zOcZGE+ZfY/epo1zGnbrOLxL7UJ
	 BXcDFpO38gBS4DaueYhWagXYk+Mrgdu2bYnOF5d0kp29mxJ+k28YjQ5AVMc2KheIq4
	 7Ai5ZwDMVvHg9U5ycJPks9iKxT/gVtZVZ7IB2/mQ=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 35DB0A1C; Sat, 08 Nov 2025 17:13:29 +0800
X-QQ-mid: xmsmtpt1762593209t6y0gza6o
Message-ID: <tencent_522CB56DC89514EA26EF8ACCAC784A6F540A@qq.com>
X-QQ-XMAILINFO: MMwjR1C73eIsakOfV1Mj6orxiUZ/SeGZ7scsjRajOZwzIhhI63fSyehWc+XcX6
	 b8rv8fLrYx/qYwIIMcHewC9ZF3kjJ88Cq7Vabh806VOSVR/MOtGVWOj8TjHkJpXcYmFBARPwkHPO
	 oZxLj8L76p9jCYbSB6nd3jyrogyDLVfOdPvW4iX0uIrISzSSTvtN8eJeyvdz/pO+NBpzveo1bmnY
	 Jv2+DOBUCld3l561IXZt8a4ASILrI63ofpAoQTmYx+jbhElDWqaEO8kjYoe1MLQYikwzjrzIPyMn
	 qd6SfZ4wVWKS+d7w2VabEP7b0Wkm16tvWkjAHSmAxETZ9GW4i3DKSR0jfWXXewsv2MdTLC1A6RHL
	 agh3l9GJyvq7kM/YXzcRdGlhJHskItkE2EGmBrBq91y0pjhA2S+EYoCzFAlVAVoduSPDaRp9+RpY
	 HTSe1c40Z55BLSe/1ewYqDwi13sjiPri30tCf6+z3vFu/0giLwrGgBqYFImTB2YE7Rv+2u/3dMOI
	 Z92L78LMniaC9h2w41LU9+Ov8OFt7+Tjt/fRfWMiRmLz4XHKmoPOCqmGCtiYPx0kzX8CT8cPN8eU
	 URxWMczjK1MAWs1NuchbFHXeFVaIbKfbKxL+G5WY0qSwnnTIytWE5tU1hg4faiRD59eTcOhNSGbJ
	 OomDM2ty36OWVVh7W+H+FZyHmQZ+ncvXV0zY/fc/u9N3agM/i/GacmfYshGSwB5yPP7EljU8i4PO
	 WBNuZOMQs3bw7lCh3K95ajVojGwNh/+mlcvDFUkuUcJyJm6JZZRbuYpXdFuDG1x8Vj3+Nc+nGvDr
	 f8UySqQlgEYZ3X3ckDcASyk9YqPAKG+/ecUfObbiX9qFq/DOFCOgvDS1W5qiqAHmc01Vdz8ISkvJ
	 tI3GvpnM13V+1pt+eVAOJEq1lfyRsmwN1bHVV1LPGAZHgyxR1+TuLcqjiJEzgjpqABxcu+4kDvgs
	 3qVGQH3kxkTaYBhsf8k/xswU8MZaskMhYMQY77Zh+u/uUmo3bHuwjJqs1Rt10yZ+h0FIsej8I4VC
	 1FNYIc0A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] gfs2: Fix memory leak in gfs2_trans_begin
Date: Sat,  8 Nov 2025 17:13:30 +0800
X-OQ-MSGID: <20251108091329.295183-2-eadavis@qq.com>
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

According to log [1], a "bad magic number" was found when checking the
metatype, which caused gfs2 withdraw.

The root cause of the problem is: log flush treats non-delayed withdraw
as withdraw, resulting in no one reclaiming the memory of transaction.
See the call stack below for details.

	CPU1					CPU2
	====					====
gfs2_meta_buffer()
gfs2_metatype_check()
gfs2_metatype_check_i()
gfs2_metatype_check_ii()		gfs2_log_flush()
gfs2_withdraw()				tr = sdp->sd_log_tr
signal_our_withdraw()			sdp->sd_log_tr = NULL
gfs2_ail_drain()			goto out_withdraw
spin_unlock(&sdp->sd_ail_lock)    	trans_drain()
					spin_lock(&sdp->sd_ail_lock)
					list_add(&tr->tr_list, &sdp->sd_ail1_list)
					tr = NULL
					goto out_end

The original text suggests adding a delayed withdraw check to handle
transaction cases to avoid similar memory leaks.

syzbot reported:
[1]
gfs2: fsid=syz:syz.0: fatal: invalid metadata block - bh = 9381 (bad magic number), function = gfs2_meta_buffer, file = fs/gfs2/meta_io.c, line = 499

[2]
BUG: memory leak
unreferenced object 0xffff888126cf1000 (size 144):
  backtrace (crc f56b339f):
    gfs2_trans_begin+0x29/0xa0 fs/gfs2/trans.c:115
    alloc_dinode fs/gfs2/inode.c:418 [inline]
    gfs2_create_inode+0xca0/0x1890 fs/gfs2/inode.c:807


Fixes: f5456b5d67cf ("gfs2: Clean up revokes on normal withdraws")
Reported-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=63ba84f14f62e61a5fd0
Tested-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/gfs2/log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

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
 
-- 
2.43.0


