Return-Path: <linux-kernel+bounces-815083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE032B55F27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5AAC45FF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B32E8B97;
	Sat, 13 Sep 2025 07:36:11 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787E1A23BE
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757748970; cv=none; b=OBQCE9aGnYXF1KWDWscVkQfxsgGbMpKgLRtunG4GErgHDZTB1KFi2lS0kLjcWVwKv8whw9QLN9om7/KgUXQyGcikAMyQfQTIgxsDXFNFgNDNM/0gesbS1hIryQxLtmaP+U0d3BEF3NoqfPApa8fEMUj2gvtCf/gKeDZO5MSGAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757748970; c=relaxed/simple;
	bh=2C5qV/d0ko9TxMsLPa8nIqn+7K8XkQcrTCLfqvO1qzk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a98+FSMR/yEoCsD4RXl89WfRd2OUZnqa3QKPAfI4oKTnIzOh9/1I/5pqfs0d7pnPfPv3gqNOV1FZV/pJrP/5g9V+QW8QZvEdcEzeBmkcRl1O/Lnmv+rUdm0qGRoeryojfai+oeef8aWoBeDWCg3VwMj9CvoFHoT2vEdqxvOKROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-401eba8efecso37283635ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757748968; x=1758353768;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sbpfr7EO0S0KvsoVRszztOQMrRz5i4KzMAXRhoLwBbs=;
        b=fAcYZBTKjoFqg/hwKIPeId6+VVHxotTCZWd8eQ8PANKzW0ufKvsoY7IILgN7BngJAM
         J7VGF2fZBMCorbebrTkncfh2ZEahBuwzWxV2kyzLK3rWuQtKOjFTJrMhMb08T+4mJWpz
         hWfGUk7XjZezgDVP8O/Rekf9eQqCkK+mNmpXOQZOWPNU/fEtQiX4cVbq+wq+PVDXpgqK
         6JT/JC6OMj7ayKvhGruklVwNSIuLofi43P0L8ccjUq2OOWHXC6wGpSezyFmgs1Ox3y5M
         egIoYzWRYd8vJu5sUdzJqyEoJVGU5DwdnOua536jXsQt8A1w+XNFnUDjsfgjkQHNDumC
         GHMg==
X-Gm-Message-State: AOJu0YzDkWkL39hxydtYKmczu5tyGmNDzRRe+KVWASobPBKQy5Qqhl0n
	ZpNe7bSe1fJg/wQ4f40ZwUHyKoXh7iL7CQNSIiICghN3N8kntK3IaxyuzQGci08fGqjeG70t6Ky
	Cnb0KyeLix9HfYotctwejkCwrWCwcYfr5y9MRXOKTijCDAqGirFRTLpHagvI=
X-Google-Smtp-Source: AGHT+IEpPE8ezRL3EAuipZnOxqVaCaidPdO15kzSYV59AQGTqK5Mwg5hcOkOV7l7mEhBu9xRoTBnitkyqhWBQS/QT6+2vZIr8Ydy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c9:b0:420:11bf:d5e with SMTP id
 e9e14a558f8ab-420cabb6b81mr77188375ab.6.1757748968353; Sat, 13 Sep 2025
 00:36:08 -0700 (PDT)
Date: Sat, 13 Sep 2025 00:36:08 -0700
In-Reply-To: <68b87c9f.050a0220.3db4df.01fa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c51ee8.050a0220.2ff435.0370.GAE@google.com>
Subject: Forwarded: [PATCH] x86/mm/pat: fix oob error
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] x86/mm/pat: fix oob error
Author: chandna.linuxkernel@gmail.com

Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
---
 arch/x86/mm/pat/set_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76f91c9..944e6a912fc6 100644
#syz test

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -305,6 +305,9 @@ static inline unsigned long fix_addr(unsigned long addr)
 
 static unsigned long __cpa_addr(struct cpa_data *cpa, unsigned long idx)
 {
+	if (WARN_ON_ONCE(!cpa->pages || !cpa->pages[idx]))
+		return 0;
+
 	if (cpa->flags & CPA_PAGES_ARRAY) {
 		struct page *page = cpa->pages[idx];
 
-- 
2.51.0


