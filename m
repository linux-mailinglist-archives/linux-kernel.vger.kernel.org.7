Return-Path: <linux-kernel+bounces-864592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0B7BFB217
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62BBA4FA4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5073128A4;
	Wed, 22 Oct 2025 09:20:42 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27B2F99AA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124841; cv=none; b=cHl+yibpfYtZZ8MyAOx18E2C6ECA8LwyscIISCzjyFtCu14Kk2dQQm4kWuGHMkoX3MM7Fbow5lbHfHcaofYV98DnTHJ11ZV4mV3PsuUQ3Xj0KI7PrWxnr0lHe7PPKIg5we0PqEby1REHJx1R/IA+kZhS+NwWnLKHA1VDiz2LxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124841; c=relaxed/simple;
	bh=og81uqBUgz5EaG+0WapXOEXJIvjR7PWSLxAz2EYeLUQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EwGnNlmWGUDxqTgPQuwHrzrg9gXVoW5lnbbgd9lxn+x/Z8ohWtzZtlvyUbVLuLr5cipL+cuQbrCfXFnUB5u9//5fN8bD2+BWC6ildc95NY7DkH6u+B4L0LVw+hDZwQqNr2nwNqkFmONsUUkidLHWAiG2NHEYXtFpYXSMK5uPkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d082fc3dso136093185ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124839; x=1761729639;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90yOoCa4BFbTwgoSk02jTAOXOk2iWof/2nKMp5Vf6Ik=;
        b=GfVH45Q7huoCdv/cM9fHFzT4H7uTz5JGpJB5i6x7W8vDxC8nnukrqHlX3uMXWyREvo
         uwTfp7IAwHv5LqYZOc/9THb/2BIcyKy20cF9cLEZXFEyaw3GtFs+mIBRuwfNDvVIwcs+
         BDNzTGhu/BpNMDAUmTGmPUJuf3tVYn40sHK1f4+Oh0wsDNCo3pZb10Lw/qIAO7fscEvX
         EHYF7v5N6XaKKk8drI6DqpK1mhJ2eLGnRYSRNCrPTf09T8I0xhiHrN18KwVNgLdfLlO8
         ktPrvhbCjy8y4eYIPLNhlE0C/lyQuHcTlKcRhMSAD5vpLSmssUrX/rwdcWQ6DF0R1IhF
         6eJg==
X-Gm-Message-State: AOJu0YxqwyDPaj7Vd3c+quOBr7xrvsaPpWoy+jUwpMbwrP39hO//J7xS
	5BujF9ycTqAe0JcZkTdskOoe6xC64VlX9PZ+kPuIM5CJFTWksWjArbvZgkUh4KpAABuwz+4Prtb
	TLnJjv4TqcC4Ei+dqEcle2mv96nAnfAbUwZ4G5aO0bg4chRTUdhmahT/S6Zw=
X-Google-Smtp-Source: AGHT+IGkDxoOO6lpPsVpOkkn94G2nfNDVd5taDUKuKUIWaLso8AozHBW11IPAI0h7dBtIv3uSjpSDPEZUL4noZnieXdhMFsEZDz1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2218:b0:431:b1fe:147f with SMTP id
 e9e14a558f8ab-431b1fe1670mr68989245ab.18.1761124839647; Wed, 22 Oct 2025
 02:20:39 -0700 (PDT)
Date: Wed, 22 Oct 2025 02:20:39 -0700
In-Reply-To: <68f659cd.050a0220.91a22.044c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8a1e7.050a0220.346f24.003c.GAE@google.com>
Subject: Forwarded: Test patch for KMSAN: uninit-value in sctp_inq_pop
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test patch for KMSAN: uninit-value in sctp_inq_pop
Author: vnranganath.20@gmail.com

#syz test

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..8c0a5e23bbb9 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -120,7 +120,9 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
  /* The assumption is that we are safe to process the chunks
  * at this time.
  */
-
+ chunk = kzalloc(sizeof(*chunk), gfp);
+ if (!chunk)
+ return NULL;
  chunk = queue->in_progress;
  if (chunk) {
  /* There is a packet that we have been working on.

