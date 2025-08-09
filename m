Return-Path: <linux-kernel+bounces-760999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4735B1F2D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AE03BBC13
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30D279789;
	Sat,  9 Aug 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LrP0P6Vv"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A0221540
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724310; cv=none; b=W/QFWJPt2pFmhJyPCdjpYppqOvgmj2QhVIrcTQ4C1Gp3QU6A/DXAfDum9Yb10FVGeGcR2Jw2FoMwhc2d6/ss19s8He05XPwdXO+CsMvEwuRLWm4iBJ2ZQgf0ekHTdU+qX7fPg51B+DcGozLj8jOV8eVi9mU1TdzWyYZCMSatfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724310; c=relaxed/simple;
	bh=HOmJX4ji3giEVlfFpEkxPSZFM4plg+An5rtW6LDYiEY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ChSI5e6QrqoqwapE/3UzMknbBRLRbJyMVYz4aIYK8FHJbiTNsRU8BKSGOHo51Khu4xmTSDEMB8up0TzrJuRUX/IuHRUibhmc2i0mNPt3cQkExmaiUtVqYZP17eOU/9JY168LMolLVNcepNH/KAbfed0vyBWlDPyv0m0Nx3VZmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LrP0P6Vv; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1754723994; bh=bGrgxIatoWkoS6oLLAJ0J+/7z2z/7Te1k4YRKsz/Vzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LrP0P6Vvbi9u7A9t0zvACORt5lkSfrR2mwCnEd9YgAMvG9PCPuluMfePF8GrcvudS
	 bO++jDXnBcF7Q0lzt2qGUfVGunu1NgKbr82ziLwrt3l3Agt23ZrG+R/gvLoximO3vU
	 z9MBubh+Twttt55KOPurQKWBwBEzyX8TTMlgeAn0=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
	id 4F435A8C; Sat, 09 Aug 2025 15:19:52 +0800
X-QQ-mid: xmsmtpt1754723992tops742bz
Message-ID: <tencent_941BCB257DBA68BBC933969E511B584B9408@qq.com>
X-QQ-XMAILINFO: N13olRN0jpmHSBXxkEd9alNquZCLeQXz7ITwOEWmGBLtrabk1Ro1HZ/JlI+aFl
	 ANBZ3aMqCybBCBGwmZ5ucev9a4Gcsf6A3GUQ6rCbjHeeNW/w7utW7vgnJ9fw3mUMr7Ngr6Vr+jZQ
	 W3TX+ZTaVOOqtFLcJqfrgaa8HqtJJa3eK/3I67T+gnpnDseQMqNFEqzvhRV7cx6a5TwIr4XzjIyE
	 nnyYBnCkoFgv6YPM9oQ86q5Xe0JROCJBMkvGejhT+M2n/x1egDRocccitXMyEw5PgilSAz6a8gEF
	 rAsT6QeDnZcby5T2LZr3nPD5HSFQnAJzMhJqhuvtT3+nFahNaRybIBlDvtmGUnfzet9sKa5BeK4C
	 FCbNqNcVzMO+qMcMTQA+QHEG1BySH1erzJKRN28XBMe135X9uvmyTEFiE7gL5wbhF5hRlt9mCqY2
	 Tek7wRl+h6CVOoo5o2tumHc5CK3H9MWLWsj2IfaaSOTZZYeRWA/iG+E6oPFtyYdsMJdlZIkcFYzT
	 V7lkEOryTl7QNsWKVvQZclSZGtY14Cn1Al9MOJ8j6YRUa+Jqp4gT7kbJHJJnFnaLc9ppEdpOOovA
	 AqiP3eSFbxllbrPN+U+64C3RQasi1/gbkNHZN2C3MBH4zAk6+mH4DPAXjel6UQWq+yVm5vK6GSCy
	 jtkOoRx0U7jRhyO4Q+++nK2IogZGQ3cwrD9QS/psVe9pvD/iGM0LhuDXvYgMj14HQZ3Eb2BNmaTe
	 Q1RxTJXQ06V+GAr6chNLBhVTFJUvubDwCO5bwUH0ZzIkr4WKtIUBI0Q6qaLK1A54EUAWQJ7sNN6x
	 nQ1efX4WG2y4CvhPBWEceMlg892h5Ica1NQqqQuWbifzHNhzNNNw/CYUSDyqgg36AvXNdfTU5BRD
	 PYZCuIRNUutFrmiTLJosKfyjsrYkfeehewRaG6ROGqFvyX/2NfW9736E24d3yVjlkztW3uBVdu
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e8bcd7ee3db6cb5cb875@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KMSAN: kernel-infoleak in rng_recvmsg
Date: Sat,  9 Aug 2025 15:19:45 +0800
X-OQ-MSGID: <20250809071944.173583-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <6895b041.050a0220.7f033.0058.GAE@google.com>
References: <6895b041.050a0220.7f033.0058.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index c24d4ff2b4a8..9e9e069f55af 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -107,7 +107,7 @@ int jent_hash_time(void *hash_state, __u64 time, u8 *addtl,
 {
 	struct shash_desc *hash_state_desc = (struct shash_desc *)hash_state;
 	SHASH_DESC_ON_STACK(desc, hash_state_desc->tfm);
-	u8 intermediary[SHA3_256_DIGEST_SIZE];
+	u8 intermediary[SHA3_256_DIGEST_SIZE] = { 0 };
 	__u64 j = 0;
 	int ret;
 


