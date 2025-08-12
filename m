Return-Path: <linux-kernel+bounces-763767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD1AB21A11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78914271DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1F2D46DD;
	Tue, 12 Aug 2025 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hvcXZkdT"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93061F9EC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961732; cv=none; b=uh6quNASHLPPdfIKJP5Kcse1cT0mZJAPTN3bEQPM2wEDRWdx2DP86XvL3XauAHadgcYxaYA20iYmnJVtOQ1yyu/R2PkII9EAMlEv3ust73XuJgrjYMMguiu9Z2xexcy25kcF/ePcY1yqNP42sOmKTO7o1sWIx2JKSvQiqxrJngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961732; c=relaxed/simple;
	bh=Wa2zWjbImjinCq8OySA1AFJGgbUE2t9XwOj9UB4lBcc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Bwfvv16DJEUKYVeqaah3LJktmsOspE7VEcIJtnfO9UWxy5ew4poYKMQvGwdgsC8Q0hRcNwzH/SVnPuqpzXeuNxx3fKIbF9PmdOMQgUTjKefsuVewwkiJQgjFTWY3JTZXR4Prn520HJj0/eXT4YjDhdg/tOtVdzL+W5Y3R1OuP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hvcXZkdT; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1754961416; bh=dch7BKcV7CxmpUlT9CFHxvA3oAprvE5QIwvwM0QNv+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hvcXZkdTDdDlHd8WDNs5Z9xYmJCyepn0GGznYw7Z85agHNrd0VJwJPacPrleG16AP
	 EErq9fobYnQlclJ/tx4rQsW3GYNnQlufqJEo9S7sdwyZPm2vL7LIUMoYGKWIcKj8Kw
	 v84d7vzWHG//qjJLqliBv3t14dlcwn4Eiq5V6+5w=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 4369B81C; Tue, 12 Aug 2025 09:16:54 +0800
X-QQ-mid: xmsmtpt1754961414tulka1w03
Message-ID: <tencent_9292DCC668099DAEC36EDE0CA4A7EE46DB06@qq.com>
X-QQ-XMAILINFO: Ny9b0zP53WzJRuxz68d3fiJuvFHwfDGJCINd5Kri2HYYXHaBXtaNKQm8RDuEQQ
	 KS0PURwRN2RE2rJ0mG+zPABgfou2zDHBe3xcbIOxhufZEAVDMjcxJ3XnNbz33p6BK7b4hm6tJW17
	 +hdZ+/oY2wyJa1IkuVVpYrMuVZeS15hQOzx2ToXkc66WT67I5QxDwjZckK+/5f+qU/uM2byZumpT
	 POZLTAz2stOgMACAMbkjBNl72emNjWD9zxgj3wfb94JhYROGmi4LDp4T3sVdL2jncuRwp5UAK1VB
	 UdV030/dJm0Sfgp2YDSJXkNMko4eqmdKtZDoG4mpcJPfQvxgkmoQgziVniUuedrovpc+CxAVTExe
	 ymq/Dq82gycSxsF0s+cfrg0YP4MnlcQkUZPOPnJVzY5pfKk95ey2GQsWZ2KgbElOsWbzPK6yvPan
	 Ip400uHolg7LZ+JsvuggEv87jLfjyrc96Ca8oTnPt4KQdxv9FhZuRiRaL3jkQEgnSaKhUWbMLQNR
	 YrGy/O2MvaPCijFZk2UwXTn8WTveqNilRgatqVVvRJ8YDq7WqXAYZs17M7gHa1Utj3LY27Dz8deU
	 vrKShkDdOpPO7U3h2Ig20Cf5k/dalIVVo9SLsRhQvH2Qk8E9v4xVQxsx68rBO9q/dnqLLc7gNa7L
	 9i57/zQ8NADwYGovyJ7Gc9Hd+KM/N31us5ZhHfGwgmi6McvR2J6emRkTZnFFu9lNYtrrnB0Tuy6d
	 4evtgnjPN8D+81uVpUog3oZqM5Q34Cp4pwnj1Q0yPknt+G26olvVzyNx3kCu5DQjMq915dvQpUtp
	 y/imw76RwKB8qIkMv+Ch0Jx1r1HDNsVHcSuehl5+4sreZUgpBidkQlnm84sgnWyMmyPKXq3gjuSa
	 /FOIi9E8/iIwL7bFeHyiprlHBWxLX1X56Io56mGVtax0DgXzZ2DOz/ZF2QMNr3ZHfqAiF6K2dR
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
Date: Tue, 12 Aug 2025 09:16:44 +0800
X-OQ-MSGID: <20250812011643.1336710-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <689a3d93.050a0220.7f033.0100.GAE@google.com>
References: <689a3d93.050a0220.7f033.0100.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a8339ed52404..dcf7cfb9ba6b 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1917,6 +1917,7 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 
 			f = rcu_access_pointer(new->pub.beacon_ies);
 			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			RCU_INIT_POINTER(new->pub.beacon_ies, NULL);
 			return false;
 		}
 


