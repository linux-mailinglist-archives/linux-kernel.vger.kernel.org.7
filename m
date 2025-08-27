Return-Path: <linux-kernel+bounces-787477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF3B37703
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3F01BA073D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244F1C4A2D;
	Wed, 27 Aug 2025 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tB9npTee"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7291991CB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258566; cv=none; b=CewPg/b2R3IEic1nCXNZ/jmZKjP5KckPqOkMEGw9EFeIp9oLfwmW7xdfwXc5YzN8mYvVQNgM3uG10QwTlkHA7prDGosVELnrNSf4TbRMUeFGTgwsHuhiegqlQA3jM2JQ3upefU9QvpkjqP7NbRzfE9ROoAokLy0lqiJ8YLlXIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258566; c=relaxed/simple;
	bh=JcOJ73IqDRcQQI797D6KPoH9HH2SjJMJfzKlRe1Atok=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=u7sQwDY0xzAXXwVOXgORylJF3dKRV/pllgWuidBdl3h78G/gwf4XnDUXYKGU4AMc9mlX3T6kbr5Iq56HAIgGYtHNhuYUjlKJPr9eCvHkV5WjbrXB++/je6F2n33V9VevlvrNSVbEcEWIpLaL6kDLV5HC0X5rS1VbCGqv+h0fSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tB9npTee; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1756258251; bh=WkwQC3ugskwKbRL3MsqyvOukMKasFJY8W2CrNMs2cXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tB9npTeevxTSZp922d2sOYgGQCafztmgjsrZOSPPMFl4pvwK+W3IHYd8649rlxqGH
	 FZSb995qlW1fm3ki13npxz7ShZ/2umTaiKu8n97bJXHJFVXeeYaJJtAjw8ShOPqBcr
	 8896K62W1HXyNT2dh/zxJTJmgf3Htqz1Ayt9eil4=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 7B1B9CAE; Wed, 27 Aug 2025 09:30:49 +0800
X-QQ-mid: xmsmtpt1756258249th4s99ejj
Message-ID: <tencent_B2496343B244447773976D66CD936C237A05@qq.com>
X-QQ-XMAILINFO: NQp/UN4soYLT++6q3l8MQ+IGSbzO5cA/cr/7FY/flbuQ8/hQdU4n03hLGaursV
	 3LjlK+bhi++Qs7KYvwkxq/VbJE3GdpiCOReFpYMyY0I2+10obAjb/A0q5yXAIHXDk+r1UkrSeg1A
	 kM1S5m3fHOkdpPzKSxD+CwETDvH6xc0ewNeP/rV68SQSi+hdFLh+x+u9g/J/9YrApFUcHEYe3m1m
	 jLRYcIDOOwPR5DW8ukp34Cxkb9+EETfFHo8BU9GLa7ulZ1us7gBDcndzMx9sxb8AdNaRP2NfifVX
	 gZPBXDnLDHsWXkkjvlPwyU1jfaPTGmU+7gmaYMklcw7qJzssstW/m8mjtsQZOWJCv8anmha9qM0/
	 1HSZeWGi5xYXI4ARtqO3Ney4ye7MDuwsc6txEXGvyhf8i7sNBFSwbDz9/XaXo70JBS1OHPYY9Qfw
	 8mBuHMvzmp/mUmatAYrnBReGbBzA5HnGSlfdbUsc4P/TwoUsD2Ilf7tGteTlGnqOuxuvqjNmBpry
	 cPxr7RkdZ7nTTeuNPAbHr1j03Lo6LwPHgy2/KikYD4f16Y6pCpuG10sfeVfTbcaw6i+qodEY3Yl3
	 AK4qyHXL/XP6VUQ5Qx7/wIsc0sP0FkJCK1QYxOneZBHSAexItzDvHVfTf4yeojxzraWFLHKzC2Na
	 fgRhtOW7lrxC8ucmcCF39ak/0Eg/dRVT6egNt54UpoN/BVak/UFsmlYy1aqJauJbexsh0Z9mIWE7
	 sfPBa9MiasC77TVzJs0W34N8qUS/6/vzMGmyt2OxZaEaWH0h8qrKQ7bMjk7kAUpFhkRLqoCrnSH4
	 hAGeld0mJ96WMEPwM6zO0jpNAme5OVcNOQjzm3nEIBSogD/bh0yYS3Q0ooHuvr9J4vME309/4MfR
	 FQvxboPcXFoTik9C8gEvsEFxJFb2EQb9ftE6MKk2ChAAyP20/8IuaWN02lchO2chhI6tIs7NqUu6
	 6Sn1INmez+RGa5u6nMgsQoW5zvs0n7Y2fYcFmFoHQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 09:30:50 +0800
X-OQ-MSGID: <20250827013049.303548-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ab6633.050a0220.37038e.0079.GAE@google.com>
References: <68ab6633.050a0220.37038e.0079.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..137b5b660683 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -929,10 +929,10 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
-restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			if (!xfrm_state_kern(x) &&
-			    xfrm_id_proto_match(x->id.proto, proto)) {
+			    xfrm_id_proto_match(x->id.proto, proto) &&
+			    x->km.state != XFRM_STATE_DEAD) {
 				xfrm_state_hold(x);
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
@@ -940,11 +940,9 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);
-				if (!err)
-					cnt++;
+				cnt++;
 
 				spin_lock_bh(&net->xfrm.xfrm_state_lock);
-				goto restart;
 			}
 		}
 	}


