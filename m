Return-Path: <linux-kernel+bounces-826150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE7B8DA70
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B87418997C9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7D2580EC;
	Sun, 21 Sep 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uT9fxVBh"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14022EE5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758456017; cv=none; b=H4j/Fo5HDfynSmCEaYMjJXuNoWeEyaKfuHmy9SF3jawbH2cxk6ga3sPJIQQhhpn7QiznPF/caFMi7w1dJoktH+3llQRHRh8zKax93etOGedeTvuh1213Wj+MITeL/xyqOoKLfjnuXrUJTC1EieCkQnZGxJqWsqEdAvSofZ/2MTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758456017; c=relaxed/simple;
	bh=jtlr3CzskCMgRQIyf5Z/jOncrmxpl1QpXBVZm1auUpU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Vmh+16vhKF/3Bniv10MI9cadRcj5ltoHYPbMlJJClDZ8IsBqNs8VN1QCGQYIVuDAH6A+zwbwoI9Fm6Bm1/iCYxAnE55HkzPi+9FMwNYDjmwuBvYHplHZDn+HxJxPdoSg+lgGtNbBrys38/VS2d58xUV3OCertgIhWKZXl6bV1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uT9fxVBh; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758455707; bh=syTZ2ErbqcBrv/fo3/fTPOQN1vuhv6P6yicAX6Yb/CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uT9fxVBhPOe3+CroVotqcZfe4HBoS7C8yZr3rU8w1+zH0NemBe9dJ2T/gGHOZrYuE
	 l4C8k/hsaKaQMrfl0aO6NwBE1NTd9qJa/3EXZRt6BJcPh6WZMgX0b7kEyE1DGF6X13
	 Tg3q7zLaShkOb/A79wEUghvs6IiuDrpiBLYcbmks=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id DC4A022D; Sun, 21 Sep 2025 19:55:04 +0800
X-QQ-mid: xmsmtpt1758455704tvwcz3291
Message-ID: <tencent_B8E8A6ED9ECC6C7B5E6F6C2F6D6DE096E40A@qq.com>
X-QQ-XMAILINFO: MQ9y3o0o22FxQvAtsx36tzL/VtX+M0FnlUtjndPkaEh+5SkkGaN1onmE3Zni0g
	 fEecmBc74vgOmePVYkDo6cxh0vUcwdHIr3rFteKKUKnQywrJxHHKTadgCTYPAuiCUTNJu3Opji7h
	 TIhPnYXsY0aTIM9PhMazkeWfWn9/W93VGTRrBXL+eSPCNgoRf2m/U45l2exo4pT/KA1S85j/eohc
	 N84+wSAYt2oXbPr3xDkonthMbo097mzs0lOB9GBEr9rCNOiKoXE2toiOmQaiQzVuKC/ljkA19A8U
	 rOEa2rFPVz2EE0UDzRSpIKabcIlnj8MY/9Y9FRE8FiY2U5bfacd68awp3Dj4QU9vMUWCyq/Fg+DH
	 vTRqyWTNmr4Yu7XrFiSxl4RpwGq2KtrDwxSwMlGDfGxgeQoYcDz33qz9MeHkL3FZwkahaY2CmCt6
	 nVFORixjKY2HkW8z5sOttFZe8c8Dm9PL74rZjO+2dCi5lLa+NelKfZYrv+9MhxA+SfNKxS45DWY7
	 JdwTA2eRIrQggwpEQmuwvZjVrqxS5UEmALvuy9v8Pe3FQ3pYC0msaZNYoablEU/jeRiWrPudb+F1
	 OYEkUDrgIODyjlt3oUmAUIO9Pwa8vPTm010UmpKmBCn2Q97NgUbu0PmZ4+KFdlTIi82zewLHy38q
	 LZDPDP2NksYwSz7YDY5a34BkFG1bVpyf0Hi6gMlvOdw2Ce/wkrPG2y88Ko/iVUFQ+WDzgIZbdhag
	 HJ1eVOpFoaf0ZI8maEBxg1WDF5FbXKZ6UVDmJf/2jLnUMzbI3nMsMcfAI5g+mSOGQYwU7EbZ9IiJ
	 UBQ0yG4EAZyFC7yGP7VXxdWUiGBhECoJIGpsyrjDrW7y/oii7gcXRqnEh25qxFaQA8HqPbpZwcv7
	 OmDkVDipQCwRL6JiTVksToeVgRNwndbm4IEkD+NGKZ9CiqocYrkoPBBqZmmDBizJRVP+Nk1uu17Q
	 Nv+gF0MiENcFKjuXgS+2bEsUqt3/wl2L9OiWPkQWo+kBl/oJ+EytzPB8CNeKWApeborOy1OBUbth
	 bn95466g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
Date: Sun, 21 Sep 2025 19:55:00 +0800
X-OQ-MSGID: <20250921115459.2581977-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
References: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
index 14b90d1c64dc..023c72e589a7 100644
--- a/drivers/comedi/drivers/c6xdigio.c
+++ b/drivers/comedi/drivers/c6xdigio.c
@@ -242,8 +242,10 @@ static int c6xdigio_attach(struct comedi_device *dev,
 	int ret;
 
 	ret = comedi_request_region(dev, it->options[0], 0x03);
-	if (ret)
+	if (ret) {
+		dev->driver = NULL;
 		return ret;
+	}
 
 	ret = comedi_alloc_subdevices(dev, 2);
 	if (ret)


