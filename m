Return-Path: <linux-kernel+bounces-829395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA19EB96F60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCDA14E2FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5776280CFA;
	Tue, 23 Sep 2025 17:10:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17F277008
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647427; cv=none; b=MfrNQ9jlNc3E2Akr8zrWIOb7kJf5ULoAdtdIXMPP9sU2j/UsXqKYrQ6Ex8J+6J/Ur4alklT8sXDzOt5gtLDwK1q62+a/+DZoLiJi/kQvjRIqIlIsI9BMIQY2BKY+srG2beVJYkwlISSI5kvra9JoIi+mv2YNaDzbIupy+KOfHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647427; c=relaxed/simple;
	bh=QooaIIVUkVLqBfQHJYm+YtWViKyaB+15BcUdn5kj5kM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XpLEIfAY1ksLAjpJZ6tYHjC5HSck84yNlsazhoGbCYLxtUUMA7FuGXWbI+29z9HC5QqAzwT+vvoJ3NW9oaovMUIuOzZDaIqFy7bkj7kJkAcGjs4Bnot3u274SGu2N1y45duAoC4RBH/jLozmDbnbv2TVxG0IlNH0VgVeAMytxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88d4b38d080so523503339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758647425; x=1759252225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyEjEW0FvUQ1TaeESdEByryj9qh221cm1USXwPkZsYc=;
        b=IRb2Qy5JGR29qwpuV7ldpR9S1um2C9BMrzPOrtYfqQMfqcnay4pgOBsD73oFMBEM5C
         KK8qArNmQgplJEVDmdaZCH7N3FYlcEf1sLPsXJ1VibM07HVviMOPyb40L3KxRoW8wRqL
         qudBAFAp6jShh82x8eI+7ucUu8F14NwrAj9GVb5rFQwtbl/qTlN7s9XxKXZnR64yMdGp
         CcClAGguAbqtF5qqjT/nRFMXOmz52dOennnKcWwSc/GwXevcfciO2Zi0o/oP76U2VfPq
         4FsIvfteFWjSoWMdSU4g6PgT0PTyvWKp2YZU/a4BtgIP0OZt2wlHborDCZhRBhJIZUxk
         gweA==
X-Gm-Message-State: AOJu0Yx9ODHyJvpk9WMx0r+xnBrs7DarZCBFuQ/3ckhzNHN+qQNADYli
	zVs9gt2b5svKBh/slufsDBKybTHBJghbLo0OKfNpspT4i6ZhJqoDgWIpRVou/nL7ftRXBL5KYi6
	zwdElZW1xXgR6A/gNrb1zQgFU0HDy802f5g7fIemyfmgclNI7EUWIGF4EOXM=
X-Google-Smtp-Source: AGHT+IGAbBSIA/jNrO9HGegJvEXVVowu9Io0nRLEz/W5fEdaz38/E0lI8b5uwx427TV1809/103HDRphTnNGbHoWSeEBa7tBvXJ5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:3ec:e669:7d76 with SMTP id
 e9e14a558f8ab-42581e3e060mr54335975ab.14.1758647424845; Tue, 23 Sep 2025
 10:10:24 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:10:24 -0700
In-Reply-To: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2d480.a70a0220.1b52b.02b4.GAE@google.com>
Subject: Forwarded: [PATCH] bpf: fix NULL pointer dereference in print_reg_state()
From: syzbot <syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] bpf: fix NULL pointer dereference in print_reg_state()
Author: listout@listout.xyz

#syz test

Syzkaller reported a general protection fault due to a NULL pointer
dereference in print_reg_state() when accessing reg->map_ptr without
checking if it is NULL.

The existing code assumes reg->map_ptr is always valid before
dereferencing reg->map_ptr->name, reg->map_ptr->key_size, and
reg->map_ptr->value_size.

Fix this by adding explicit NULL checks before accessing reg->map_ptr
and its members. This prevents crashes when reg->map_ptr is NULL,
improving the robustness of the BPF verifier's verbose logging.

Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 kernel/bpf/log.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 38050f4ee400..14c0a442a85b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -715,11 +715,10 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
-	if (type_is_map_ptr(t)) {
+	if (type_is_map_ptr(t) && reg->map_ptr) {
 		if (reg->map_ptr->name[0])
 			verbose_a("map=%s", reg->map_ptr->name);
-		verbose_a("ks=%d,vs=%d",
-			  reg->map_ptr->key_size,
+		verbose_a("ks=%d,vs=%d", reg->map_ptr->key_size,
 			  reg->map_ptr->value_size);
 	}
 	if (t != SCALAR_VALUE && reg->off) {
-- 
2.51.0


