Return-Path: <linux-kernel+bounces-775795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9013B2C4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABD6E4E17FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529142C11FB;
	Tue, 19 Aug 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XCMHq7+G"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B2274668
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609065; cv=none; b=ZGJtOas1Im+PkefkVGrzlAWrvpjEVPVMKuixXy36w4BDTKP4pZInmJSrsXx8tu3mjNoTqYrn1oc6r613L2S3j2UMRAxqTsrxgd+6rG2ppyI3b6sVubLgE0RBNqgr63YgQuqoZ0h1EC7qwh7lpWN+pZoXUOiQXXy60i1E2xCnWlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609065; c=relaxed/simple;
	bh=SvuVfLJJUgGCyFpNOx6xfd5J9ZntWq430wvUWQfcXsA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MkkW/YbZxB1rj+0WCaaYuFjv7T1W7F+h3u6wlqY66zbKnH2VE3CfVWPNJ8Mtoq5ExJPdQK7zpWhfK6TQ4BhpZu7u6ZyJunfMhay+69R8ngA4qfZAOD/O8aym02x+ejzTWg0i2/8KgzqeAFEzW079fsCLTyYqOD78uzuFVGpeX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XCMHq7+G; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755609054; bh=Ydd/Iuwxj8h1QG2GOOzLj8mXKZc1TunpmoocdoJ44RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCMHq7+GGRRKNt25dP2qyG+1JranL3kn7LgSs2P7SVXCHcOU9P7OYRtuV+Tguuqvt
	 xw5XkWQnHKBGMwG1TMMhNx5TDEBGvmmD8H/xbiULTERVlJxdjCi+LqO26AEQ5YpGiB
	 yz6x8PQlFCL08/DrSu3LRyRPwGoR+6jRFl49+Ero=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 26736002; Tue, 19 Aug 2025 21:09:39 +0800
X-QQ-mid: xmsmtpt1755608979thdeuq7vr
Message-ID: <tencent_D3EE1B172523BACABBF633209E3D1BF84B08@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jsekG+eUzIBt6QLgzigGHuyj1sN5mrclkKBkaszum4bJH9vAdmc
	 7Ja+zB+A7zEH4qUhN1FcvYt+5m/vxQnO+rMK3c5VPlAjrORkBgMZQyc9JWnn29srEezK/jMO++37
	 MTm49XnQaonIIyh2/2SmeFtuZhJZachvh86+iqRG7essngTHiA+MtRCBg2XsFQBD4yjdUEd5WepW
	 qLDdp+CcSU5JRg31Elpun48Oy1J851CpR7rPvGPCKt1ZymEna3GwyT/dhcskGglGvgNUN8+Ce88r
	 1EFOEo+MB1wWGmv4HFWBmcO79AWxMcHDq6dMUzk2+N1H1S5UCkH8WWJyOc8zdSjr2on83iNc/oAj
	 y059csd/3IxasCQXzmffyoz6L+lvhD6HuX8+1AzD494oM4wuJTGan3jZqytHdVTqhIaiClKq1wCw
	 gSlj2VFw6WnHHUUTGA+Fe5XL6Ch5t+UxR2FsZnE5gWnm81HuaFMaTKEc7K76a2T0l8ugMDeJIF4v
	 1BXlbGIJjT8gw5jVMC5YRiJmPnMNZgHsA0T3lSXeLzAKd7Uzf8Df+9aMtqTDeMCUOqXT5y1lOaJi
	 CUPXh+3pL0VBXPw/XL3r49VIZEz0Xp+EPS7P25kuMrEn34eq6oSJW4Ikze9rybxPYTFyrHMHkble
	 jXS95wAdbRw3EcFtP1m8GmB9pDiKbgZfhamHz3rePIUi4ENAN8lKH3T12GkAW8SeELFbg3zIsRZL
	 raFqiFZc0tBUxW7G0rA7EbUg8uxPRTZ9hh54dHI9vcp1rfHN0XptTCKxg4ORrwM5y1rmhwQneA+s
	 99m8MgOR54Bbyh3vyN6LtPzn1LlLmUkyMmejCCoOlayB1nS2SOa3woVTN7puaztO/8EmVz8cmkDQ
	 9BPazotzeme/QSXwH8Bj5VtfFwSqROAn7aR7UoHbbWHwT0LVXM+aYvyV0zYAnS559iBc/iyfMWL1
	 9osmz3efdSCYRdX8FsEOK1nX5evGJg
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_evict_inode (2)
Date: Tue, 19 Aug 2025 21:09:30 +0800
X-OQ-MSGID: <20250819130929.1243560-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a46146.050a0220.e29e5.00c2.GAE@google.com>
References: <68a46146.050a0220.e29e5.00c2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..6c4f78f473fb 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1281,6 +1281,9 @@ static void ocfs2_clear_inode(struct inode *inode)
 	 * the journal is flushed before journal shutdown. Thus it is safe to
 	 * have inodes get cleaned up after journal shutdown.
 	 */
+	if (!osb->journal)
+		return;
+
 	jbd2_journal_release_jbd_inode(osb->journal->j_journal,
 				       &oi->ip_jinode);
 }


