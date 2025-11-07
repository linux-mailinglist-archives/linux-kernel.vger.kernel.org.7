Return-Path: <linux-kernel+bounces-889809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFCC3E958
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8043AEEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C142D594B;
	Fri,  7 Nov 2025 06:06:39 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA294280A20
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495599; cv=none; b=DghUgeyELc9Did6Tykp44MB8lU7R46ZKGiMcrNQYJQdxt+ognrbNOSkOA6yy/Nz5u3mmr5G5fispBhgK4wEHpad7J5umj38+n253dojwVsmOILmb3rVzHvhrPaB7zrDXDpG3VJB/m0Yr+g0UQc77v53rI0K3MXj4my+ZhhqGepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495599; c=relaxed/simple;
	bh=HgVq0oT1t9cHEaFHji0HruZMjTN3YRtMRnBXBfyLBlg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kefuBJl2e8IH7mMlToUErMYSWDPvN/4mnkF6BGwsCOhd+35tEgRoEmCt9Wtnkmgykzt3Y3/F4w2NoXhEbHSk8B8bAMZ6zYwCbJmGxi87RBc3KruD53tPjLpD5nMgzXubSwd5nzvnxTfEU02Let05p73y5hn41FaFLw8q/dlr6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9488163e81cso39390839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 22:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762495597; x=1763100397;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDN3jbXMKp6n46RL8k+7eZRlj05P272zWqPwWDyuhL0=;
        b=F9U0MLWLiKDyW/+VSlab9sPr2yo1Xqf2u/nItIESdR+9gaLBWTJyNN2VkgkT32NiiD
         QHCQtUnuj5gx4bnqgSrrmOYSCsFZlp3SBCX6EP7cagHJf84ItP6WjKktRXv7D9cGE5Ev
         C/DquMlV1O4uLbvo63oZfU0V+OJElwv6bdEHEhmFbys/9BWcKxUbJuPtsClAbrUWq0y8
         cV4c8ZbI9sYIXRGATa/Q5WR1RnXNfwQXnejpMHCW2PiP8oUT69jJ3u9TeDj/x6DrO+Wy
         wiuYxIqQrEEI2hcaHaPRPIVif72BoIDH7YCG248I7ZuzMD37BeArK7NQ6VjLk+PZlQZi
         MAOA==
X-Gm-Message-State: AOJu0Yxkqge3npFYGGWPnoLFf/Vz5ORdhY09sKLyLbN2kEYh4Om+jYfq
	IdDzDuq4kfChVwpBt0gA2DjYBqeQLSqN1C0oqjDlZg4UNReZNExzTQ86LChSQEVExeCQxmPJ2P+
	Fj1tLlncAFZkq3XDmmPt7G1WRwHEPKiK5A6YtQchH8rAfj1sSrZKJ/dSBNw8=
X-Google-Smtp-Source: AGHT+IHKykHftChLt/8S1sn+3TRhhzWGy+WrbZUn3csaHZfOFCXMrETwR9A/ngl852fRPOSVIdAfsMImzMMUC0fAMolaJzQS5ndP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:425:744b:52d3 with SMTP id
 e9e14a558f8ab-4335f3d0280mr34282275ab.11.1762495597073; Thu, 06 Nov 2025
 22:06:37 -0800 (PST)
Date: Thu, 06 Nov 2025 22:06:37 -0800
In-Reply-To: <6880f58e.050a0220.248954.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d8c6d.a70a0220.22f260.001e.GAE@google.com>
Subject: Forwarded: [PATCH] net: core: fix KMSAN: unint value in tipc_rcv
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] net: core: fix KMSAN: unint value in tipc_rcv
Author: hariconscious@gmail.com

#syz test

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538eb..144b02534196 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -69,6 +69,7 @@ struct sk_buff *tipc_buf_acquire(u32 size, gfp_t gfp)
 {
        struct sk_buff *skb;

+       gfp |= __GFP_ZERO;
        skb = alloc_skb_fclone(BUF_OVERHEAD + size, gfp);
        if (skb) {
                skb_reserve(skb, BUF_HEADROOM);


