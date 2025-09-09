Return-Path: <linux-kernel+bounces-806946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F978B49DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60216444312
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB6819C540;
	Tue,  9 Sep 2025 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wCCn50xd"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF6156661
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377031; cv=none; b=qAD4gxnrTXGzSqtYbOLsrbhhNbiRTI3lhSpJqfnA+/9wFbVwhaflQ9YYYULVSP9PJ7lXVnHw4XCyciS4ViMzijZoMuaRggKLAt1XATsTtJAIjL04TDUGvk17kzcVERQifaFmEw8aRuUEZ5ai2URe4lptwOhnS4/n9KQe6hnToCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377031; c=relaxed/simple;
	bh=IoX4hIEVKCoABQx4yHzFSXY1x2jGQmdY4VNnVGCjkfo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mOrASljCk1dOynD7jcyO7i0yRA/8rfWVPaUIWNZSjivdycG4qI7rTrxmdQHmg2Y89ek2hT7j3SBV0AntTPEZytTQW+M6dXyCfeZ+xi7fHxoaNB2nkGeJVTNqVlC3+YMnTs0pZO1qu2aIYAfAEzLnQEui3Z2c4wBD/hWujPtrFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wCCn50xd; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757377025; bh=VeImF+XGbwpjSMw69GVoEDl6t9Mml9cfVbwWLDS8hVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wCCn50xdUoF5HFFRFzUBKMnGJ4bXmTORGiwihzP0Om1bfVxDYPjxBsv7b81vWrSTN
	 jcQPbBETsuJPPQ7P8bJU/MVpBhosUjFmAlubXG6ZLJp7d6k3ca/jcJAqVfjMExGe1h
	 ClzONFWWXxvxEzQcqPRnbPgzFwGLy2cFeuUARej0=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 2B512238; Tue, 09 Sep 2025 08:10:53 +0800
X-QQ-mid: xmsmtpt1757376653tyl355y9s
Message-ID: <tencent_31282D116C4C9408EAF6ED0ECC4478466E0A@qq.com>
X-QQ-XMAILINFO: Mvz9QCyGvUHYZLcjfYY2JsQGyREKVVHZ9ror43ig8QkVpT8gXHMDbEnZ10SEpF
	 Ab9eZOEMTpcXPOLwE8t2HrH7xUdj4clFZhaJSfvtbddGUphwKAGGsHSfkPaAgxzTl3IrmwgGsXNZ
	 5mciYqPApvqX2iEzCwy2719qfNQRmakDBuWvSX3DIshtImWSKN5u0CgRUcel/q3mH6GDahGu3rGb
	 ru9RyS2FWFlWYJy3IviJN6WfzCN7HQ8Tnvt1w3pW8+Yjf62ZgqnSFQ4m+wewYa0YkQ4A/renUWDK
	 lu+ron8c4DDZJFtHeAblvf1+WOFrOJJOkWATI2zGlo7FwTIG7VIrDEfGnnSAdpZza1RIXbdR4+6c
	 Uk9B4FMDyegf1nXhzYB2ktL6C6UpKRKHNissll/FpqFWoV8nYS9llxLWvS5H6kJNlaWDEb0uxk+L
	 ulxqxH7zPaZPN8u1DjwXFuteI2dpEpxdm70J5TowWPZd119hQzuWQFxaTeF1UTcWYVlkur29qhAA
	 QUaQ1OtyxkB/EBah3pK0bPNgMePppfKLTC4jb3m3WEUuXtKV2yQMyCXXDu14pjoAg8cINd7Uh+b5
	 D8FnABaLPhDSmDOF9jjmtyDK7KZJclAxpasI83yjsqI+kAALgUmBse+nsvQOQMBV5dg4PbEd1qiC
	 vi+5sVf5M3FXL91GyP1ZSVSzuuOa3uOmHlmVW7VHMvGnH0wxsShwucwwaH1/jScpadKCtMpKuwov
	 LZU+nGYgoemxkzPXg8EhbnDy71LOHgmmdWVBbKXXd8KVytTTtwBXiTBm3nLdEZCtF115yYNxxRTQ
	 kI/d3vYM/USVmtCyzaxspDQl5Yy8ubbbut1hbmEiApYyoDKrQXPTJ5CxnMONcTUXjP6uYT8ucK5I
	 gJ8Fmzr/rXrhbhMUQAYSnJppHqIMLAVf49IMTiLBUfcpqMK8hG7TK1PgEwyGQSMQMwEroruNfQQg
	 kFj91ptBk=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] general protection fault in vc_deallocate
Date: Tue,  9 Sep 2025 08:10:53 +0800
X-OQ-MSGID: <20250909001052.2717447-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68bf244a.050a0220.192772.0882.GAE@google.com>
References: <68bf244a.050a0220.192772.0882.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 1d9abcfac4c9..6e0089b85c27 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1341,10 +1341,10 @@ struct vc_data *vc_deallocate(unsigned int currcons)
 		vc_uniscr_set(vc, NULL);
 		kfree(vc->vc_screenbuf);
 		vc_cons[currcons].d = NULL;
-	}
-	if (vc->vc_saved_screen != NULL) {
-		kfree(vc->vc_saved_screen);
-		vc->vc_saved_screen = NULL;
+		if (vc->vc_saved_screen != NULL) {
+			kfree(vc->vc_saved_screen);
+			vc->vc_saved_screen = NULL;
+		}
 	}
 	return vc;
 }


