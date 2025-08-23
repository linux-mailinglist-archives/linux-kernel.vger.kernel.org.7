Return-Path: <linux-kernel+bounces-782878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF2B3264B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564B91B63981
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0781E9B31;
	Sat, 23 Aug 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rFt8cvLq"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363A1E520B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914027; cv=none; b=F9mPAQjB59WJMPG0oEG8eUY7VEuVZBbO+cqugjBFnTh9mnIliXXfQ9OMiAXwFaoB8vXdbemFmeiAbgfxnlabnmEp+SiO3CPUm+IT85lKrvvwwASK4HYhFj/YI7sHpJmUlNjDh3Wrkp/k2yaY7FLRNhzQSF/ABcvqrH7zjkkWg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914027; c=relaxed/simple;
	bh=7t0e3jRbi6YWyLTFXcniYdSJwn4C6ilwi0fdIXq+n1Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TDaurwd3Fyzkt55Bfn9lcMVUFMVTlzExH6BZkyxS0Lr7/s484TjuOOlZvRSzU77Z6JtLe7TpDDI0MVvxRU30I7yFk97Tohs23BoX6cjcy99rX98Lv37nSVzUC9lIYxE1jo1a+BO0L7zb6+CHnn8/XKOR0+hXjmni2jGAOqqvSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rFt8cvLq; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755914021; bh=Bhjbjl1XmoxFCl6VXorur+MFrEbFoojgEAGMZ1ax57s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rFt8cvLqxLvVKnEoA1I39O5SLTCZboIVaDS/YDTvtikjW9a2FXJWXFjGS3QN3zQZQ
	 4J4KNnBk/7Hs7DbwxrRmHIMJmiZBRr2gWMkZqw4mqsV5uECggICmcdto8oGI1qLfR0
	 zkRIUDLnKPy0gjLiT292aD0Z3APkm5SYcqtcUPRE=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id D672C4D5; Sat, 23 Aug 2025 09:53:39 +0800
X-QQ-mid: xmsmtpt1755914019t8h8za9hz
Message-ID: <tencent_FC33559E331B7F4BA91BB62522BA1CBB8C08@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+tzJZf6CmQ1I2q0Y825byZF3DvrBFJIhOVc5ouQP6+VJNER27PP
	 oi68vvsQjBwiermXtCPR9wKCEwVn2a2WZrKEnRMgyn87wXVIB4bHq114WNfrbSZpkGBaU2M4tRsW
	 0ly3S/Ac1YCvEUYYGJRm20Cs1E4vvx6PQQ6DDoBjSKIBRzmQ0WXNqCtaoTGVgU07w8crvT1o8lMm
	 vwSonuCoTsXzlIT0mOada730a7Vx1KB7SNK6QEmJVqPEiebzLuS8UNTYrlO8M+ffw5+H194cBTdw
	 9Z/UTQSJFHbk4ZM9Q71zTuzQOH1HrnQcf6+05lDvmTuzmX+WC9kxspc4QrbWAQujrwBV5JS0De3f
	 Ry1LJ7/RxpmLr0XqVnj/yzTWzbcnp3Py8/S26sXYVPImfhU2Uxa6BYzN7QCXIBWpX0Ve6MR4qVnV
	 tptToGhHXWd6dOWUsdW8kJRYETWwubb9o4rEgwcU5YkjCOTvQfvmG7l0FdydvA51wV/ovGI6TW+S
	 6YRZpCqWk7sI7F3HPpiNPgJTtE6o3XgSAv72gxYKxWublM8aVw0lsbzC7IB6z8YXe9gg1Fm43KnZ
	 kAkTn5g6OoJXAM/AxbuPF1g3ug6bp6n+QeQHV/sUMoMTB87QidzPOTnktEhhBRWKA8tQi0UnaS0+
	 7HJnGASig8YukwlO2J9s1fOJcRKFPjyBCy+y5hFl9Bp1SksaRrsT4LGRentnAl1ad8B/Y0zGft9W
	 r5Yns8S2VlgHhVvMKqQnMXBi0Za0eMQZfZfPY7XrZI46GtVZND1Lo6OJ6H3Yxtq6DiutT/hVKLGc
	 3laPdCZ04IwgBSdpK+V8AC9PvBqyv2O34NQhlHJtgtc6jff1v0OHm4wE+guPe3c2bNbdKUsMONHB
	 7iKLK0oV3j3UCWHySAH14jpf/Zf3DXOoPa4xPo/dmZhjc9sF1UXUhopclXaKCD6SCgQneYsx6OPX
	 mHRvtPWo5KnjW3q03TKnKS171tWU5Vk4vAAZBauII2SBrzPleSBToEwfo0Ub+22whh41M2xIPlRw
	 Wgv+qKMg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	dhavale@google.com,
	jefflexu@linux.alibaba.com,
	lihongbo22@huawei.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	xiang@kernel.org,
	zbestahu@gmail.com
Subject: [PATCH] erofs: Prohibit access to excessive algorithmformat
Date: Sat, 23 Aug 2025 09:53:37 +0800
X-OQ-MSGID: <20250823015336.2652882-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
References: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syz reported a global-out-of-bounds Read in z_erofs_decompress_queue.

OOB occurs in z_erofs_decompress_queue() because algorithmformat is too
large.

Added relevant checks when registering pcluster.

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/erofs/zdata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2d73297003d2..085fa0685a57 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -762,6 +762,10 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 	pcl->from_meta = map->m_flags & EROFS_MAP_META;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
+	if (pcl->algorithmformat >= Z_EROFS_COMPRESSION_MAX) {
+		err = -EINVAL;
+		goto out;
+	}
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
@@ -796,6 +800,7 @@ static int z_erofs_register_pcluster(struct z_erofs_frontend *fe)
 
 err_out:
 	mutex_unlock(&pcl->lock);
+out:
 	z_erofs_free_pcluster(pcl);
 	return err;
 }
-- 
2.43.0


