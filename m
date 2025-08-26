Return-Path: <linux-kernel+bounces-786404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C71B35952
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB217AAE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1482304BB8;
	Tue, 26 Aug 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KRkAbXXv"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D24288CA6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201664; cv=none; b=cEtJaFSDK2aI2VDY+k7/z3dH5tU2p9ATqRPLGacZrpS2U7QbYgdBWsJmAmNB0aNvtLUUatLHhauY4NGujX1ym1S7jdXARjUYxbazs0YmR+IFq3WOPtYANYqjgQU15IAouaHl7ywKB7OzHKpWb7Wup6XCvh3MrJqCVAc/U7QDZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201664; c=relaxed/simple;
	bh=Dvyw4L5YkTf4Cs6iL3mVRadK6ps+Ubvow2Gpk4VTmT0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lyYc+/YuDtS4BW8o65ORYkPErxU9JL/XySzYimsvmcw2BuDGlkA+cGuT2kKLsRJLcjUglxsbIDbwZoBFCOpAkYrgWh+VBNJtqPYPxndrkayTKAKrZCDIBp6KNSX1XIvEfoRCco7nAd3J3mg1bON2EpaFZ63Lf1HhTBWjqDeowRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KRkAbXXv; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1756201650; bh=kgGjSxHutqo1KcuV4l83yqC9WrC1QC6nySfChO+fZTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRkAbXXvY1vn/DM0kJvnMxCxomBH8XEo5126Nr5eshBcIgFaiMwHN5P3MMubTcdAR
	 x5ziEV/3GaCZ+tyYsiJjvxKKu6R5sQueZT42FLd3ujpzN70wNRvQ+CQL6wQyz44pno
	 F9/HsR5zS+7Fq2CMoa8idljaiJgTzInbNc9v+bdU=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id A542FC8F; Tue, 26 Aug 2025 17:41:20 +0800
X-QQ-mid: xmsmtpt1756201280tfo2pafp7
Message-ID: <tencent_4D33BD9E141B044B6F1BD425FEBA00BB1D08@qq.com>
X-QQ-XMAILINFO: MZg/qcWmVFFrA3COacdJ5fJUkNec1tN9T/xf2J3Wmt5FeuCusAkNpdaonDD2A8
	 ihXJGxFBKJj/ZOSn9L5DjcL39SKWsovsqlnTI800UiMRNwp7KMEl4C4rvwwgK+9FdVsZI98uZuG5
	 SLY8rYFcXmYIfV8xuLljn/h6sQ2zMxhaNCUoADchqcPCoObeENFDHH3nDpafUpv0BbYTRmoNmxDl
	 i9Qt9KcOoqJCrIPEaWNjKQ1JhIyYCqOOfHFoeM/uQoLcmd3FWMLnL/FCSG+zt8HcHiUjptSpKnat
	 hTVOPZXd0l7xyNWe92SUVxjp/92fE87mqCKS2NTVZtMBqnVevWf/COrPEAcMapu3/nhI1/gKq5rz
	 eK/bz3yGJ9BO2Dz6P0TeUWcC/QwfmihriGZa2z/9nc7NJZ4hfN1OURplvtkYwi1sqDOza0o0S9Nv
	 xcIyk+GGhyW5+nIyW6oPpaBNOnbGI6tqjMMsyRmlZ+p/pDVoUkzv6AWRR2bGhtzl9lMtqS49yfZw
	 V4uxvIjVzGt38jKukpSaPAp36KncSLOn5dJrVFP1/5WGdZv300FfIx3vxAe9M2V3HyKZgtfCrnab
	 WWLfrcllfss7ccQzX/N6KDYYooxlpeIIzN8sx9xKeEIHSh42TwkOljtHoPuIl4RX2/QlOaeEu6vq
	 wAvHsaqmUxwBeldisIm2GZaerrIkGxlhKhDeZkQrMaQsIwqbCX4PK/uiFp7CCcq7tG08o7tsuv+f
	 Lh+LbNarSHa6S/kvV9rZhMQLKxGKWKnvJi1KCrc2qio9mYFDBFfmArninRVVIz+wAdy0b564xNHe
	 sgExPMlUQ6OUs8YXGk5OhoedBkQnLK0G5+y2S6gSgVE8ZoiROXGQbAVvn1hfvocVRwoiXGzEVZE0
	 ba2hJNvGw5EePlh1R26hBiO1v3U5pA7A2NA8ct1HC52QoYbQ+V9aXxL7fIBwedKicqZYmjbie2ZM
	 dUSn+wvMrW8OGmwxRbyv78cX3SGgwW
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Tue, 26 Aug 2025 17:41:20 +0800
X-OQ-MSGID: <20250826094119.4174202-2-eadavis@qq.com>
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
index 78fcbb89cf32..b8b4843f9c6d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -932,7 +932,8 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			if (!xfrm_state_kern(x) &&
-			    xfrm_id_proto_match(x->id.proto, proto)) {
+			    xfrm_id_proto_match(x->id.proto, proto) &&
+			    x->km.state != XFRM_STATE_DEAD) {
 				xfrm_state_hold(x);
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 


