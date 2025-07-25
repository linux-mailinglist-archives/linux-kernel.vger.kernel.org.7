Return-Path: <linux-kernel+bounces-745398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AFBB1195E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC511CE20B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4E2288D5;
	Fri, 25 Jul 2025 07:47:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4231F582F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429641; cv=none; b=XKdL/TjXziIjjglPeJRRC/vf9x7ENWC7w1SR1EAaaEmVbxy7pv+u8fql+fSdUnCLgzBd+Il5o638VWiUEhUPeVt3wmxWXlShmy0a0sUptbMZm/B0LTY0piVj4WZZf89Pgs3Qws8rbm38+GnOlT3SqFRskSeU8Vr5YAQsQC5RyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429641; c=relaxed/simple;
	bh=8ngk64fa6FkvmUq2CM0GJ+Ox+uQSwrPzsdk/GC4hxqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Dw8/lf0zHnB/lf4MfumtLWNM7eE/qlHMoOSbC0AR5Oaiu2zvXtW2Oe6sMqeP+xWoFdZwgEMUdSEJoyJBkCM8ZTOducPoT3h+TnLLtO115M1iTOHCnqN9kr/lQsgGC/DBE2wWtXs/m/8TQ0kAZY8/+aE4zp7XkjBTvMnykwc9Vx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c306a1b38so184134439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429639; x=1754034439;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJSl+eIQF8BpKc2MZsJf/Bs1fdUt7/D3YqcKYlW+EGI=;
        b=DDR51qMRwmxV2rZfCaMaa7qrKjceTkW4gaej+utLPwgHsFPHNp31ex8Z5diupCO/XO
         sGwyGctw1e7VEwKlMouBWI0Rssp4JzZLKubH3id95yTxBOYrUM+KpyVKQoG1hEygjggl
         HO1nCUByW7RGJodqfVLVzCJg5BnzEhECeu/MELicp4HMgmmyTKKOL7YfZvOq5KWGr0Td
         2eNKBvh085lvfqncHKPxpS22C4sYzgyEGqrbqncedkASVJcdTuIJdxHTdRaOzVs8pRp9
         MMkZzofFPo6J/22UqYnGIMY5mDbMEsDRcJy1w8hfQ6qLgkoHkUR7LL5wWNXe1W1f3TQd
         BDOA==
X-Gm-Message-State: AOJu0YxLBikL28rdGMhdWzNhAu2QcQ+/rNhCbe+Oo9sj2j60ZoMZj10q
	k4E2ZfjnhlCrQY25wlVwosidlp1NCQThf7NMNaXN87A4Zd266XvYorlcyLk+vTpL3ha7vQAUlh/
	DtNR9g1CdQ4vxrp1lERLufZPR5ydLEasxlz/rbEJpAT95FCWmARVq0IcsYy0=
X-Google-Smtp-Source: AGHT+IFA68EyJflJs4YnJWA/6fBAC9J+D0ODiWbp9NJ78cOoatryVjaiUB1hGj2m+UilPL1+fm++ozJSpD9z2T1lZJlkIjJ8fUEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c06:b0:3e2:aadb:2be8 with SMTP id
 e9e14a558f8ab-3e3c531027emr10949785ab.15.1753429639499; Fri, 25 Jul 2025
 00:47:19 -0700 (PDT)
Date: Fri, 25 Jul 2025 00:47:19 -0700
In-Reply-To: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68833687.a00a0220.2f88df.0040.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
Author: lizhi.xu@windriver.com

#syz test

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 6e700b974033..89c444c6f317 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -109,6 +109,7 @@ struct ucma_multicast {
 	u8			join_state;
 	struct list_head	list;
 	struct sockaddr_storage	addr;
+	atomic_t		ref;
 };
 
 struct ucma_event {
@@ -257,6 +258,12 @@ static void ucma_copy_ud_event(struct ib_device *device,
 	dst->qkey = src->qkey;
 }
 
+static void ucma_put_mc(struct ucma_multicast *mc)
+{
+	if (mc && atomic_dec_and_test(&mc->ref))
+		kfree(mc);
+}
+
 static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 					     struct rdma_cm_event *event)
 {
@@ -274,6 +281,7 @@ static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 			     event->param.ud.private_data;
 		uevent->resp.uid = uevent->mc->uid;
 		uevent->resp.id = uevent->mc->id;
+		ucma_put_mc(uevent->mc);
 		break;
 	default:
 		uevent->resp.uid = ctx->uid;
@@ -1471,6 +1479,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mc->ctx = ctx;
 	mc->join_state = join_state;
 	mc->uid = cmd->uid;
+	atomic_set(&mc->ref, 1);
 	memcpy(&mc->addr, addr, cmd->addr_size);
 
 	xa_lock(&multicast_table);
@@ -1489,6 +1498,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mutex_unlock(&ctx->mutex);
 	if (ret)
 		goto err_xa_erase;
+	atomic_inc(&mc->ref);
 
 	resp.id = mc->id;
 	if (copy_to_user(u64_to_user_ptr(cmd->response),
@@ -1513,7 +1523,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	__xa_erase(&multicast_table, mc->id);
 err_free_mc:
 	xa_unlock(&multicast_table);
-	kfree(mc);
+	ucma_put_mc(mc);
 err_put_ctx:
 	ucma_put_ctx(ctx);
 	return ret;

