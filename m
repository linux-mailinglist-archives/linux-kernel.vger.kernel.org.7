Return-Path: <linux-kernel+bounces-788155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85586B38075
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E167E7C1683
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E07F283680;
	Wed, 27 Aug 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="dA4qv5BM"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27B30CD82
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292468; cv=none; b=SB60SkGpogxJAcSaM5A2n7A9C2tOPbxzYxciKOXDQsxFpawfBYXjpw5AYR5h379fLK4AvboJ2xJRJebHNhc/CKRTyifLC9Pj3DalglUdbeEhBfG38AtbopJvWkg9PTQjnx35XTKWucqCYNkov8D5/2XjrfAahuAvudV+4RKpkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292468; c=relaxed/simple;
	bh=hdF6LkoMf4VRQEF5H3s7/unZXKIC7ROymsz4wF4o6ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1DcwlRDUwB2vOrrqVm8I1d/VOuBYshAc+krQRNwz84ZnPM3W2emEuDgUtYK8rkIPRXQQWDCt0saHHWkf+qiXZb6FgZuPn6o3+OqcfqwvJILrrmNZU9eM15+tCAXM/py2HiOmy92+Z5kEFXY06HphdiJ5zuEX5h7xTKqW9nmSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=dA4qv5BM; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756292463;
	bh=lNlcXwzdELjQCxJzRSPA67T9YGSAQBMjvtNSVrIMoBo=;
	h=From:Subject:Date:Message-ID;
	b=dA4qv5BMuriCc3kGp6y4xZfeawPo8xy+8RA8eAMOVjaSU1GOjHi83bS4N+ebeyB6+
	 OAUpv5VSrWLf7hEbAaT6XgZOURmhFWoJBbMVXzACjFt8q967EHStKD/ZlEUMgCqfgW
	 p9XUI3t0+Qr9UKRHKnfd7pQnVo9k5G7Pj1PfFYzA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68AEE56700004B50; Wed, 27 Aug 2025 19:00:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3230924456929
X-SMAIL-UIID: A516C9DBB79B4CB39E32949DFE029B32-20250827-190057-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Wed, 27 Aug 2025 19:00:45 +0800
Message-ID: <20250827110046.5887-1-hdanton@sina.com>
In-Reply-To: <68ab6633.050a0220.37038e.0079.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sun, 24 Aug 2025 12:21:23 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b1c92cdf5af3 Merge branch 'net-wangxun-complete-ethtool-co..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1411b062580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
> dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14221862580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159fba34580000

#syz test

--- x/net/xfrm/xfrm_state.c
+++ y/net/xfrm/xfrm_state.c
@@ -1863,6 +1863,7 @@ static struct xfrm_state *__find_acq_cor
 		x->mark.m = m->m;
 		x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
 		xfrm_state_hold(x);
+		xfrm_state_hold(x);
 		hrtimer_start(&x->mtimer,
 			      ktime_set(net->xfrm.sysctl_acq_expires, 0),
 			      HRTIMER_MODE_REL_SOFT);
--

