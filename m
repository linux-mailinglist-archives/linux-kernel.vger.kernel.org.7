Return-Path: <linux-kernel+bounces-778211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF87B2E29F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9183B92F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9AC3277BA;
	Wed, 20 Aug 2025 16:45:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE3277CB4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708326; cv=none; b=UzfMYns7N2Wx3sZHW/3UcBuyfGnD0G4/3XCdzIBvorGWkmtdOXy22baSX8OlDnyEt7ywHWp5Dy6XNcZGJsgNvXe5cnghQlb/NLBE736lbMb0sj94rFDz8L96EJ190sGstkI3/4Fwcj4vMXK22B0YQ2IzPUJPYi6csiUxb+TwLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708326; c=relaxed/simple;
	bh=p6TEcklRwc/AqeN3sKEpCGAp5YWeSF2bs6/5w/eA2R0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N+RWY8r5S+nb87Q2J5N2q1NLQKeFSEW0T48aRN0oiF0rDWMhUOd8r0xu0hsLJJf75q1rFqpAv7bQ1KcKMjrZNMLxPhJgAFwD9Qd0vuw/5ISUjeusagKvj6tZaKB6MrY/XgFd9CablPyU0B+IpSshRTI3U/6KNyJgpNAih/UZx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-884328d81aaso14746839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708324; x=1756313124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LLGaF+JtT5jZH1qfh8k2A9qIccxEi+SdfwN5K1wyg=;
        b=GPfTNFWLAdNfGsGZDK4KbkeCK1pWfVJOW8tooNc0IxdKzZmTuSV1mcg+JG+em9n26a
         66D7tGyZ0o75ZZv/cK7QLDcHIBi7EyBGXYFUGpXhezHf8Iw0KQGuXufGO3RmDRzr/D51
         oaLPfCujhbn+7gApqmdwG9lZhAM6QfxKbSz9o/F+WOVpTUZo6sviuZzdGxvXLRFG6RFG
         Evv5YI4FU8Tyavt8hp4ozLqIIAuUEfBs6MwHo04HuoIB52or+/IZAgL2ITsOqOfVta1y
         Ya/EspsQuOI5w5wdOjNC61IHCLPG6TAmpwxqKZsPpQOZ55m/y0yISOS2FTS5GzF5wvSe
         XIMg==
X-Gm-Message-State: AOJu0YzglolZhkFd+xVK3dqXlRpGYDz0uM2somMsHNli7YPROmVaEsAV
	4yzRD1GY/KXJ5kf96GxhlZoIhMfqa5V2ZCQIKaceuchzuXPrLGrdEeLkjfToyg/FRu7tKOCI9KH
	PYftvF6p9s1u3V1KjVO5UuxAXAMq2Nh/WbnM1tfGBD34MeP8WpFkJApC8pZE=
X-Google-Smtp-Source: AGHT+IG0YbHE7fa+JXaY0acFxxc8EIVyYbU8tgD7QGpPMq8HQb3VU6hiLkrok5TCQz7Rjf/nXzn51Vm9DHY0LURcthYitNYCILJR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4f0d:b0:883:ee57:93b7 with SMTP id
 ca18e2360f4ac-886b31d09e2mr52883439f.0.1755708323995; Wed, 20 Aug 2025
 09:45:23 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:45:23 -0700
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a5fba3.050a0220.3d78fd.0007.GAE@google.com>
Subject: Forwarded: Test for a81f2759d022496b40ab
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for a81f2759d022496b40ab
Author: syoshida@redhat.com

#syz test

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index b87b6a6fe070..979fe4084f86 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -63,8 +63,12 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	skb_push(skb, ETH_HLEN);
 	skb_reset_mac_header(skb);
 	if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
-	    protocol == htons(ETH_P_HSR))
+	    protocol == htons(ETH_P_HSR)) {
+		if (skb->len < ETH_HLEN + HSR_HLEN)
+			goto finish_pass;
+
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+	}
 	skb_reset_mac_len(skb);
 
 	/* Only the frames received over the interlink port will assign a


