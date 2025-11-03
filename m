Return-Path: <linux-kernel+bounces-882190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77764C29D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A7584E3B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBC280014;
	Mon,  3 Nov 2025 02:10:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6AF1C84AB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762135824; cv=none; b=jN1x1n6sBSa4xcDYCpYjLJ3rKlCVjLOWHCCqmWYKVstTNzSERZlz93JDag9bgzhsHjujOsPB/J9gVg/XYnzdM1/NqXw/b8jPNZgrXUBskeGhhcqcL4nOT5q1O6NpO1+iGCHOjEPhyW3uEjiqHGVmiR8IrJH5oYzbNxhiPwMtHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762135824; c=relaxed/simple;
	bh=Tcwvq1ao4QjgiJsAdrea/6MQQn8ZSdhRL/q6gmhP0pQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SJK8TW/Kr2jSx5TSQm54NLCc792thq/YSyCSv9hbBoNLGXaI3L4bPrLgwrV+PexI99Dx6jmQs+iUqisHtKMGWcLkbSbIrNbY97pl7O/KgMzMau3wkUtrc14fq+j/2b1snJjkJreZV5i8lBadz8TozumG+KnAzdL3dvg1sTkQl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4332a9ccddbso5744745ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 18:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762135822; x=1762740622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOyg/p0pt/w6/R68lfzuHXu4TW3r6yPi6hHyHMENJsc=;
        b=RLJ1r9PM7AOrtUfN5j6cejFjU4gCRkAulMB1qas55CcSuA+xFjKdngkPmiOUbLoXQs
         EykoZEpNnOqLHZGSo1uwet+O5TgqYDiKDjBD54lDyh15nzepT0HJFPmNXfJJYrxAwfID
         xo3KG44/Le11ZJT4yRkBZEQvnnE4Z7a3wV8TZlA6uJnMIMdI6Oh1HSpxACXhPJrDFfcq
         JfUSQcXGOlXjq5uRofUgqeQxlXemp2thLaS/2ZkSfxHZEPtAEPXYuuUHqnkJ5hq6JfIn
         jiiWuGTGzl+AKdquYbZCpOnK6p/EKW/ZChLIhZTUjYTRMZnNpF/PR/Mthbj7gUdXT+em
         9+9g==
X-Gm-Message-State: AOJu0YywBA99zMtSZhAbNZq4JwMcmACKilluueoVVpAlzIcoj0ZiqAMG
	bN/G0yWhnpmgJhfD/ngyCRPlrKBSxuYjNLaJriW7rLL5YAfHkDgKVxyNHR/B5U3xH2lOkH66Ywe
	zA40KotYfKiKgxI6DUKuhWgT3ezmYUo/BfSi6Gc5lHHYZzqM8lzqDDbfVmrg=
X-Google-Smtp-Source: AGHT+IH2sDIorkpbuLLyLgsvxl7RsQuJx8CwmvXdnlmCvyJUDz0f1AQTIpFtuL3vrNxFMG1cIhYVMIrRxcu4ivoqENln/Qts9Nsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:430:c542:3270 with SMTP id
 e9e14a558f8ab-4330d207c12mr165685945ab.32.1762135822143; Sun, 02 Nov 2025
 18:10:22 -0800 (PST)
Date: Sun, 02 Nov 2025 18:10:22 -0800
In-Reply-To: <6907edce.a70a0220.37351b.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69080f0e.050a0220.29fc44.002f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in
 recv_work (3)
From: syzbot <syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work (3)
Author: lizhi.xu@windriver.com

#syz test

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a853c65ac65d..215fc18115b7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1024,9 +1024,9 @@ static void recv_work(struct work_struct *work)
 	nbd_mark_nsock_dead(nbd, nsock, 1);
 	mutex_unlock(&nsock->tx_lock);
 
-	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
+	nbd_config_put(nbd);
 	kfree(args);
 }
 

