Return-Path: <linux-kernel+bounces-746576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DE2B12881
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED42216ACD3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9AC381BA;
	Sat, 26 Jul 2025 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UR+y3767"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68971C6FFA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753494196; cv=none; b=U2R7ew93bC4m6S4PX2n/p0/mJlLyC+miHgNZ493O45KxkeAbTrGA3cxj/HENNw7IP6OnlndVhAOAR5GYdXYn/h1pX1kZpiQoo7gnyRfg95tLR5M7pbXvtyx8NCw0+Og9r3w8bKRLe1dyM1XYipA8zqcwKu2+TjWD+zDZhofcThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753494196; c=relaxed/simple;
	bh=P8UHQiF/sMI6IYFSL2zrIFEiyoHpB0+BHRK5T8a71Nk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AOnN7T4SfoJFWCp0RgUzciJIXGIaHcyGb5NyC0vQHF+qSVO8aiEtuNf1cK052sakU7y50MnLvUte20GDSDMbkDbg99doGxikkHg7zuN8K2IAUSUp9btHmZFINVJJtk3EoSnHwkIBwEv2b4zJHqiCUPOIveAgY7Ga/4GqR7eao1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UR+y3767; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753494187; bh=JPNZq8b84nKHJmlNbduzmtFfHXdstB336+PErbJ0hTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UR+y3767RbfJ1Re6Mlu1a19WAzLdypRXytcpb9eLNbdio2FoV7395ScvPvHfAjF1c
	 V/GX2PJLn7redLzNo8/Wns2b/CUVGXXwbjFney7aGCh5ZsuH2h/6y0uCp5bHi5Ti9/
	 zUz4L7si0FlAdNq26p8LHqITLwPvdWfg9zihsbdo=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 93BA941E; Sat, 26 Jul 2025 09:36:59 +0800
X-QQ-mid: xmsmtpt1753493819t81rhy2lc
Message-ID: <tencent_C725DBBA89BB4B333C9E4B1BFA4B341B0708@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuWySbOblR2ZG2ILg33o2HN7pnekvjzwElCRasW3NbvC0FsVr6Rt
	 E0LsfqDMBdVAAcr3cL7x3ZFxly6It4Q3boeDXmV5ZgZkDjxZQiJdvk35OR1hVqT9Tqe67G30VoUG
	 x7rGt5634wp3AfTpwpJNzBpsuURSr8RHytKX37CDbjvIMHFCT0MAReME2VolU/ZpxioJf/nExGhL
	 X1ZoRaRqbzWxhcqIz9Dkf6YfLFiWDKfec1dfK2FVHkJzl2mKt0YVM+N8eJe+Av51l9YT+2epLnmA
	 wC2pM6+IrcoboofISdo+4649wlpfs/yxocdxcWHgoBgbKzGnNoi4uKdFuq+9V7+iTM+VQDBuWVvK
	 ZQ1GEAPc0+p5QRbRtx4jVt9OGDCS2lIUMl4VKjXHMeY10GnHgxoBbGVNI1GPYUMWfgHhJ9dOgqkH
	 phvGuCbet2xchNhtxmQYHTPnvcP3gXZcmKA/dMAnDcKFkIuiZelqcWp/OiwPJ0YgsIxXCuZ8TzXo
	 rDMLlHd0N9j1MWAxE0SYEcR0DhHGTDKAqX2xclAv3aJTeLbGiu8PxYG1KfwpBNH1QYS76TCUMY+r
	 T+CUBuDb0u8j3MeU+7RSwadIO1GfWwTPW0MfjlWz8HgH7COTIq1okqNdeZh9sV+Q1E1eJuXy+ILk
	 Kqq9nqAeE6sfPE+1k8zYVRDRSuum/5wNQyXEwho3bGegubbIR14frAkojssB+d/UwydBpUYCkIjw
	 6L6QaGBGykTm6SHo/iFWp2kpEL10jr/TsTvoEkLHn2kEZczJ4kMQ+mKur1VOx7djSA5SwWwcb6fX
	 HBScAbIyO8XShuGxvjCOruU2qPirkLrSXAbqHHC5g/7KQPAXod8WsCBracSDAMGp0lkJtfBXtaiM
	 Q/ujlWl4HJar2012BZc6IrhyXfJVFEetXSHzsi9VidPCVx8OpEZFEVH5Jhe7u+JYkkfXKYoAl1lK
	 V42nYRr411XZwMd3CkP5/C5m8V0YcBkcmv7SE0pLo=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
Date: Sat, 26 Jul 2025 09:36:54 +0800
X-OQ-MSGID: <20250726013653.833938-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
References: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 6e700b974033..7fa02963a309 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -109,6 +109,7 @@ struct ucma_multicast {
 	u8			join_state;
 	struct list_head	list;
 	struct sockaddr_storage	addr;
+	atomic_t		ref;
 };
 
 struct ucma_event {
@@ -257,6 +258,17 @@ static void ucma_copy_ud_event(struct ib_device *device,
 	dst->qkey = src->qkey;
 }
 
+static bool ucma_get_mc(struct ucma_multicast *mc)
+{
+	return mc && atomic_inc_not_zero(&mc->ref);
+}
+
+static void ucma_put_mc(struct ucma_multicast *mc)
+{
+	if (mc && atomic_dec_and_test(&mc->ref))
+		kfree(mc);
+}
+
 static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 					     struct rdma_cm_event *event)
 {
@@ -272,9 +284,12 @@ static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 	case RDMA_CM_EVENT_MULTICAST_ERROR:
 		uevent->mc = (struct ucma_multicast *)
 			     event->param.ud.private_data;
-		uevent->resp.uid = uevent->mc->uid;
-		uevent->resp.id = uevent->mc->id;
-		break;
+		if (ucma_get_mc(uevent->mc)) {
+			uevent->resp.uid = uevent->mc->uid;
+			uevent->resp.id = uevent->mc->id;
+			ucma_put_mc(uevent->mc);
+			break;
+		}
 	default:
 		uevent->resp.uid = ctx->uid;
 		uevent->resp.id = ctx->id;
@@ -498,7 +513,7 @@ static void ucma_cleanup_multicast(struct ucma_context *ctx)
 		 * lock on the reader and this is enough serialization
 		 */
 		__xa_erase(&multicast_table, mc->id);
-		kfree(mc);
+		ucma_put_mc(mc);
 	}
 	xa_unlock(&multicast_table);
 }
@@ -1471,6 +1486,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mc->ctx = ctx;
 	mc->join_state = join_state;
 	mc->uid = cmd->uid;
+	atomic_set(&mc->ref, 1);
 	memcpy(&mc->addr, addr, cmd->addr_size);
 
 	xa_lock(&multicast_table);
@@ -1490,6 +1506,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	if (ret)
 		goto err_xa_erase;
 
+	ucma_get_mc(mc);
 	resp.id = mc->id;
 	if (copy_to_user(u64_to_user_ptr(cmd->response),
 			 &resp, sizeof(resp))) {
@@ -1506,6 +1523,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mutex_lock(&ctx->mutex);
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&ctx->mutex);
+	ucma_put_mc(mc);
 	ucma_cleanup_mc_events(mc);
 err_xa_erase:
 	xa_lock(&multicast_table);
@@ -1513,7 +1531,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	__xa_erase(&multicast_table, mc->id);
 err_free_mc:
 	xa_unlock(&multicast_table);
-	kfree(mc);
+	ucma_put_mc(mc);
 err_put_ctx:
 	ucma_put_ctx(ctx);
 	return ret;
@@ -1599,7 +1617,7 @@ static ssize_t ucma_leave_multicast(struct ucma_file *file,
 
 	ucma_put_ctx(mc->ctx);
 	resp.events_reported = mc->events_reported;
-	kfree(mc);
+	ucma_put_mc(mc);
 
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp)))


