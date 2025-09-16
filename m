Return-Path: <linux-kernel+bounces-818083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB1B58C70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E34E16E7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE812475D0;
	Tue, 16 Sep 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PHjyQRzu"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1D1991B6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993947; cv=none; b=iihrIZLW6IPUlpFE2zFIYyuEvz5K2B+eKyBH8YajW6gUIVMsFtP65BPq/OxbFhC2T+4NJO5Bf/yyPVK7yaJjM3u/ujmlD+DqEpiBRJshiuIKRCrJdn7w4cVmks09z0c4zBi+GiCRPW5ddL+3lRN/ry+s+KfHwqZ8mBOVS+JOe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993947; c=relaxed/simple;
	bh=R/9GZtcvWp50aAU0VpUM55NnzaTQ3Trq9Kix4uh3rIQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NBnn4Jt7tZMSkZIaR/mo8DGiiYz/gyUgrJ4EePHoCLGcRXnNYwVDris6Tzwv3b5dQFUZzMkMDblsIdYczltndrWAKPHAOsf6/MCW7wWm7KKvhuFMqgZXcmVZM8NBuaY4PlI8IraGeLXkoKSVK69LCuZ5bywqNCLFLZvrD9pKvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PHjyQRzu; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757993632; bh=sOHB6JBh5qY4vkc/QyXitu9HNNCg3xKZEkocCsvppAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHjyQRzuoyRMCKAnb6/AMQPoFx3Gx+1C7u0I/Y+nQ7hW2REzMXFojyPgI9fShxdRW
	 INYCq6GAdkQqwlTh+4keyCa6XInyq1GZe7rArfr0mEznfuEbMMS3pz85mkh3UNXm1s
	 xI1FKwmnTFqD8gUjxjiYDZVoTqQVcZHAYZqYOylQ=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 8730EE0C; Tue, 16 Sep 2025 11:33:51 +0800
X-QQ-mid: xmsmtpt1757993631t79kirocj
Message-ID: <tencent_9F73836FE96783BC44575767376BC6CFB305@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQFJqLIF9jumMd8J7sD8hgsjSgt0nVzhP9bK6QbmVe7PmJSU9KQN
	 TDThab84RLTJ90D/LKers96YiPa3cVs73XrB6LQBy7PwpqcKVqov2Qj4eZWSWHHU9L0GWWqNXf1o
	 hVdgO2W6tZqzvXrOXkosQFNRbQXN/99RiankzNUwW27fxhM6kTBBVnnAXgbj2Vd4ouyTqUuKQQrZ
	 NJHisrMtDNGFbABSKQqIeyoFpqr0lSm64UiiIJn9HZst4NP8bJuzKy9WI9PZ6htuwMUV41HeHldp
	 iZRJp4pIxrbbN73I5QaMQ/Vck+F1iaHchMo5B/6j+kqcgnD+lSbF0ushufTS/VfieC6A2whH7F2I
	 rGiSgZE9ayj5Xk2VBM8FAHVb+Kj2en7XegDO6fUd8HnFssabOweF4o1H6mQFDKx8X1B6e1ojrFrJ
	 RgQMzFUk8W0Eun9NbB10EsW1KaFZnqyCEpT7OJ0pp/M1mqqAjBTXkvN4AxzHUMeTZAKxpeYkNJK/
	 grUEd8XU1JzlrjohWS8KLxXDSGccfTrHpQ+uR4DS53nNAiqQK4RKJ70Nd9hIWqanrYkwZynoGnuT
	 Ey72ZWQveMnUVXze031Bahp35uX1sCYXJoHxpSBJcLfTgxmwVxznz5gJFgxfVMkbnK8tfkJWT4Aa
	 relDKXAjSmgLxyDUiwxMaQVgLX2zc16KYFT5WajVoooki7xAh8O+01z3UIGqoX6er1sVZmUhPC7y
	 2+pY1Px7k+wJxH8XXcp1BJc6/Wa0qhTpwDyjqwaAnhzKptngDbsoBctNvqQEKz4gDvwNF40cLI6x
	 LfLQIXdmI0UGl4a0nREZomo0hxC6K9hXfgzP4M01B1KyZgMcelrg09v+RLpLOB4lqCFs0Nxhe35K
	 SM5WTeHBt3E0nC3P8+Uir9wWzCdSOcovONDcbeIP2n4U1E++nO58eeJalmA90UiESzknTtp3Cf/C
	 XQaV2OYfTsQvrlkVV0GBP8oOy/zTEY
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_set_size
Date: Tue, 16 Sep 2025 11:33:50 +0800
X-OQ-MSGID: <20250916033349.3122634-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68c8583d.050a0220.2ff435.03a1.GAE@google.com>
References: <68c8583d.050a0220.2ff435.03a1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..180cd984339b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -472,6 +472,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		/* Records in $Extend are not a files or general directories. */
 		inode->i_op = &ntfs_file_inode_operations;
 		mode = S_IFREG;
+		init_rwsem(&ni->file.run_lock);
 	} else {
 		err = -EINVAL;
 		goto out;


