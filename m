Return-Path: <linux-kernel+bounces-727297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C905AB017F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FEF1C8810B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA52620FA;
	Fri, 11 Jul 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FBGt65J3"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D0279DB8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226406; cv=none; b=cDoe3cHEOT0049Fwv+np8YP+wZ94sO5V5RM9dHFrEs0LWcpwYXxchtp1+7kVntEEIacQNzUuj8l3b3xJqmrln/kvFYi11C53tH12feYC2iCTv50xj0AbmoS5vO8/EOSnsfWA3fqtswEWxJT4thEcsnIwAEBR1jc62Ky5gnMaHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226406; c=relaxed/simple;
	bh=QwvBnLJqQfFoYwAuN2yoVMdqQT4e5bphKBSJpwzQVic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5DDEuJh56mg+HxaRBU6otF3kxDUzrubNV1GPnhiatzmEfZ2anYp74kjaJxBbvdPv4QjtxyKMeT1L3UukhFl2I2Z6IgVdK0TQZcp5hdnredQALbbNCunM2jUtRBWIvCVAYk+Vdursuffk5w2Fafj552ZqovjEOjT314SCbJ7TjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FBGt65J3; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752226398;
	bh=4VedDoyhHxraF9UVEViQmMir8n4Aal15A0l3qbEAuQw=;
	h=From:Subject:Date:Message-ID;
	b=FBGt65J3EFYix4qMni0pNRlqA2cu+qYaajhsJn6+rwr2MLmkH4WcndWYF0gZTcuob
	 /DYIUiFDwHt7cTk1V43fS1wh/NlCtFnoZPvsjYqn0ERq6CEnOBcZir4Iz+jHsJiEVK
	 ZINf/fcv0HDWLKrmREAY8bm9QNc/xYpYgoT6QDIw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6870DA5200002BE7; Fri, 11 Jul 2025 17:33:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3061596291915
X-SMAIL-UIID: 117235C8C1D141D4821C350D56B4F34D-20250711-173308-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
Date: Fri, 11 Jul 2025 17:32:56 +0800
Message-ID: <20250711093257.3460-1-hdanton@sina.com>
In-Reply-To: <686d9b50.050a0220.1ffab7.0020.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 15:27:28 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=130c528c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1257428c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fe9582580000

#syz test

--- x/net/ipv4/cipso_ipv4.c
+++ y/net/ipv4/cipso_ipv4.c
@@ -1848,6 +1848,7 @@ static int cipso_v4_get_actual_opt_len(c
  * values on failure.
  *
  */
+static DEFINE_SPINLOCK(setattr_spinlock);
 int cipso_v4_sock_setattr(struct sock *sk,
 			  const struct cipso_v4_doi *doi_def,
 			  const struct netlbl_lsm_secattr *secattr,
@@ -1899,6 +1900,7 @@ int cipso_v4_sock_setattr(struct sock *s
 	kfree(buf);
 	buf = NULL;
 
+	spin_lock(&setattr_spinlock);
 	sk_inet = inet_sk(sk);
 
 	old = rcu_dereference_protected(sk_inet->inet_opt, sk_locked);
@@ -1912,6 +1914,7 @@ int cipso_v4_sock_setattr(struct sock *s
 	rcu_assign_pointer(sk_inet->inet_opt, opt);
 	if (old)
 		kfree_rcu(old, rcu);
+	spin_unlock(&setattr_spinlock);
 
 	return 0;
 
@@ -1976,9 +1979,11 @@ int cipso_v4_req_setattr(struct request_
 	buf = NULL;
 
 	req_inet = inet_rsk(req);
+	spin_lock(&setattr_spinlock);
 	opt = unrcu_pointer(xchg(&req_inet->ireq_opt, RCU_INITIALIZER(opt)));
 	if (opt)
 		kfree_rcu(opt, rcu);
+	spin_unlock(&setattr_spinlock);
 
 	return 0;
 
@@ -2000,11 +2005,15 @@ req_setattr_failure:
  */
 static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 {
-	struct ip_options_rcu *opt = rcu_dereference_protected(*opt_ptr, 1);
+	struct ip_options_rcu *opt;
 	int hdr_delta = 0;
 
-	if (!opt || opt->opt.cipso == 0)
+	spin_lock(&setattr_spinlock);
+	opt = rcu_dereference_protected(*opt_ptr, 1);
+	if (!opt || opt->opt.cipso == 0) {
+		spin_unlock(&setattr_spinlock);
 		return 0;
+	}
 	if (opt->opt.srr || opt->opt.rr || opt->opt.ts || opt->opt.router_alert) {
 		u8 cipso_len;
 		u8 cipso_off;
@@ -2040,6 +2049,7 @@ static int cipso_v4_delopt(struct ip_opt
 		hdr_delta = opt->opt.optlen;
 		kfree_rcu(opt, rcu);
 	}
+	spin_unlock(&setattr_spinlock);
 
 	return hdr_delta;
 }
--

