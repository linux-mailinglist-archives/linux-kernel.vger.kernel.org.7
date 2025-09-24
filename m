Return-Path: <linux-kernel+bounces-830357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04221B99766
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B1C325583
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819F2E03EB;
	Wed, 24 Sep 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="osO0L8AN"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CA2E03FE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710475; cv=none; b=Ip5WrCvfadGZGdi7vqJLECdSS1AovpDKyEc9pbZDcMTkSOS8HguWmLvajA7gQRGskEXiAZJNWB5DGDYb07tRWPOE7qlHiSTMWvkxDw7E8AmfBxggH/IYSiMkewiI61UwvnZZd0b5xS+INO8heLY6sJ+t96/+XO/Kty9fBbZAgE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710475; c=relaxed/simple;
	bh=1H+KP6xdQeece81TQUVKSu/FtXaWffp8iOYQeqt78+k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hTwyeL2+nMS56UEjE+s09lUa0QrGGbudVfw+4GLD6eBaxf3IL/6PA1BrqlsQJ4Vi5a46E+68+HMisShqpCRjuCvrTVAFUSifpCIiyfPaJ2obaKkMuXnyFepspliboa1IQvk9Ivw1nFvGxhj0U04e2X0WuXW2sJepIU3OkbIMiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=osO0L8AN; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758710464; bh=yH+zRMwSYRfAXBnVsZ76Ku+lX98Yek4WwiKV6coyWfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osO0L8ANaoPNZ7WSTAXcgUq+7G8bJzLYrVIYNXLW3mjOQa25QajSfl36mk8YoSakS
	 bpL2GZRG6Uc2AQur6nvj/5hlVCUaZeQIKsVZEIHUF2rJOu+P9d5CTr4M7nEeEnU/Xc
	 7tCd5hMPKigVCv2Sp/S8BtWm4NYg0H1ltjvokfYo=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id A41ACE3A; Wed, 24 Sep 2025 18:41:01 +0800
X-QQ-mid: xmsmtpt1758710461tpoacvd63
Message-ID: <tencent_97B86EC86EF2CC8B67CDC6C3D2D9C6754906@qq.com>
X-QQ-XMAILINFO: MlXsX2Sd3i6tC5h4E8/2z6xGOnJgkiJNaKkcf4VB2hs0FUZjidfV+FXPD4CMlH
	 oqZP0IuDUHrvkDo9F45hB9PoQ6tHnjSMKKQIPYHO6iG0uTOZnda3TGgdg90IY2rXzDqEtFvCYxB5
	 3S5NVyiapE0lOIuZ9s+3/4o1Ok3775SOt/MJt9lOwTmQOV6qEc5vImYyDLNHSR5BYbyCreuramdY
	 tXn9OegKaRAKIhYxT50JHwLPEjDy1KASsvE6NDurmL5cc4uP0YMqIFyFfFwJ1nJZH337cGFp5018
	 2YASRxdTD8keWcbbcGDag9tJnM/7MVYc6OoBjvjmhq0RtR5WVJXwslgNaY92jPKM7WmvPIKoPYVF
	 eoDNUB1Fc85BjTKJpj1GXYQCWXkakWvuWMVHSBx3LD9E/kCUaZZ0578QPq72l/CpFI8kfMtVMVSM
	 z/ZSLaxH+Ydhs/AqmrzrBZSKVbYXSST95bvQWefp5lS1x/wt6bQS9QnSoSzcPL7DXq1KQwoey6kE
	 G8qaYVFtqIpiR87DYCgLl8XO2rXFv6ZY/uMLt/m2qntadyzM5YS6MLecQNKEzLS7zYAaC5VOOoHd
	 sxFl/p+8rFV6e3nw8jXExbaokwU2Hv5Mhzpuf2e3Bw4mqo7qw2dHvhU3UKN9gczbJ9QgoK85DyZC
	 NkEdWXAH3mUyLdconCSbH2kUp7PLaeat7JnQF941RMLfuD+0JQD6OMNZnsU3L01saOvlCJeHJxcV
	 PMPAJV95vgFYxVihmiZXV2UjHCGwbPhFMqv+GGWErf6dCFVtbgcwJ0k+8eYatn/AQV2fcX5zN/cR
	 Xo0zLOxT1bjEHDcksvNT+RphYgwXGc1Lu2AZylO63SdRQfK2rvTrntVM/rMPOsIcXVuLd55kKZrQ
	 yJXyMg0d9e4zupEPthVWYd3q+F4iyQeE6xwhyYS8xsnJuoB4B8hfF1BO5h8pNjMUWxd9XQqDsXrK
	 7z+9Mfp74BFVNgyi3fil/t4UiJwf3bdWj/p5kYU0jZkBWi/2D1jOrkb4ipvRquiMjOl7lL0b/FHc
	 CtYK2yhr8sWN1vlOhEsaWP3ICL/14YrWBwrTHT2j8ncuLCFH8G
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in namespace_unlock
Date: Wed, 24 Sep 2025 18:41:00 +0800
X-OQ-MSGID: <20250924104059.1500707-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
References: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/namespace.c b/fs/namespace.c
index ac1aedafe05e..c22febeda1ac 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4134,7 +4134,6 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		emptied_ns = new_ns;
-		namespace_unlock();
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
diff --git a/kernel/fork.c b/kernel/fork.c
index e9a7fb5c3e49..a0b8eeeb1d27 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2349,7 +2349,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (need_futex_hash_allocate_default(clone_flags)) {
 		retval = futex_hash_allocate_default();
 		if (retval)
-			goto bad_fork_core_free;
+			goto bad_fork_cancel_cgroup;
 		/*
 		 * If we fail beyond this point we don't free the allocated
 		 * futex hash map. We assume that another thread will be created


