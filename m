Return-Path: <linux-kernel+bounces-724754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A91AFF69E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014981BC30FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF22737E6;
	Thu, 10 Jul 2025 02:12:50 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75C2AE8D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113569; cv=none; b=aJBoXPxsZRuY3fIUjblmZs0hoGNGSQHUjenzAXWyMLBUKjsxvYmIho/nBll/DCUJZ4R9B5b0weEE93u3kXmSZC4nLrYpYKt5U5/s0UNMqDROjiJC2RTIAtdiCZ8w+tbw1C2SJIdp1r2n7srh2C9OHTc/ReErLfsSk6a3FfYM8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113569; c=relaxed/simple;
	bh=7smrDYN2julP/UFa/xvGeDgJzeaMtx+gQxB4e16F4Y0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VSoFDB94SfX+2BvkITATviv3goDmfE4BffuC2QzumeTfdvlRzXFhoYjDEufRlUAriyap/a7S5lOXgeaWQ3qFjMfPqzl2HYw+aA6d8C31k/kwTdc71Ah+etYQ7ZYtxXczXMb4S+rmUYNEWVvuG+dLN1WlK+SzPvBe7dMPGAnyTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d07ccc9ecso44255439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 19:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752113567; x=1752718367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPBCGiJyUWWFb06WLVxKfqVyBFCyW1GDdv+hBFqBj3k=;
        b=Mlqagex4v3kXBAbUnHLM9aMFfW7P+Vm0hQ/9TiwUX+l5EDtDgivdXvZXzxdyvBlDyx
         7cxPtj8HpbMcUfVciKa14oH4GM1Bgh2b4q2/hljJVSJVJkHgujtJkrLnLIqHb+X2w3+4
         WAUyLMzfSNAd88KHTxOFfeHVkJvEXMAHenD0oSWxmA6fDFmH/fYDQDLlf7fDH+p7giFx
         x4xCDVOj6gSwTfopaVgDzh4Y9AYU7CRbv59NEJ8wfAfwmNZd3LuEhs0Sxolg6qBeO2Ec
         Th+5q/Rb4eKEzWZLD4r9nS9cUi+pL8xYOpI6vXBcI5nOD4sScPdAOktM4pUYmwZd3T2C
         lq3g==
X-Gm-Message-State: AOJu0YxakgmxHtBWLx5JXEn8ra0UtZnKZ2CkiraiAd2v6Ux2BhJpfdg7
	NB1qLHIzrlN/7NFLd2fBXLp7jaILkFnZjc+VZQ/eRGBdBmILPS7iB7Gff7WsQWRauLHPOrfqXje
	Z8WSOG95TfiA/k1cutaeZ5xrgi1tfV8Dw0e0WWQAyyRD/JzbLKUGI7Nvh8WE=
X-Google-Smtp-Source: AGHT+IHyir9G6aghoQZomoX6PwSq6U/197j3fnDQaJLKdG3Neb7Zu7vBKKJvrnLoCc/iG/wv5+wh7Rg34dZeFRK4oYx8Vl9RekJg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1406:b0:879:4b42:1f3a with SMTP id
 ca18e2360f4ac-87968f74ac8mr107172839f.5.1752113567523; Wed, 09 Jul 2025
 19:12:47 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:12:47 -0700
In-Reply-To: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686f219f.050a0220.385921.0025.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
Author: lizhi.xu@windriver.com

#syz test

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9b471548e7ae..9b3051bf5225 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2030,6 +2030,7 @@ static void destroy_mc(struct rdma_id_private *id_priv,
 		}
 		dev_put(ndev);
 
+		printk("cma, mc: %p, %s\n", mc, __func__);
 		cancel_work_sync(&mc->iboe_join.work);
 	}
 	kfree(mc);
@@ -5106,6 +5107,7 @@ void rdma_leave_multicast(struct rdma_cm_id *id, struct sockaddr *addr)
 		spin_unlock_irq(&id_priv->lock);
 
 		WARN_ON(id_priv->cma_dev->device != id->device);
+		printk("cma, mc: %p, id: %p, %s\n", mc, id, __func__);
 		destroy_mc(id_priv, mc);
 		return;
 	}
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 6e700b974033..df3cc11b1ef9 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -272,6 +272,7 @@ static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 	case RDMA_CM_EVENT_MULTICAST_ERROR:
 		uevent->mc = (struct ucma_multicast *)
 			     event->param.ud.private_data;
+		printk("mc: %p, evt: %d, %s\n", uevent->mc, event->event, __func__);
 		uevent->resp.uid = uevent->mc->uid;
 		uevent->resp.id = uevent->mc->id;
 		break;
@@ -1486,6 +1487,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mutex_lock(&ctx->mutex);
 	ret = rdma_join_multicast(ctx->cm_id, (struct sockaddr *)&mc->addr,
 				  join_state, mc);
+	printk("ret: %d, id: %p, mc: %p, %s\n", ret, ctx->cm_id, mc, __func__);
 	mutex_unlock(&ctx->mutex);
 	if (ret)
 		goto err_xa_erase;
@@ -1504,6 +1506,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 
 err_leave_multicast:
 	mutex_lock(&ctx->mutex);
+	printk("id: %p, %s\n", ctx->cm_id, __func__);
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&ctx->mutex);
 	ucma_cleanup_mc_events(mc);

