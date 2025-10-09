Return-Path: <linux-kernel+bounces-847475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E845BCAEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B763481D82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76072848A5;
	Thu,  9 Oct 2025 21:26:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A0284678
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045186; cv=none; b=jCgdnTlSQOBkv8rEMcauHI28R9X/UJIYxNGg48MSCGizn37rD66pV2jWAgK3ux4U5KiF4n3WujRGTM9mYleYmK6orjKWOgSGVTb86xrb9uQ4xTa++odfpKJit/UbMsX8lgyinlGP6bFLeFcg8A/4R2qozZoIzkUYOPYNYHcQOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045186; c=relaxed/simple;
	bh=TGzq0TeiPYKP0hOLSIsR/CmxMuGK54qKwNDAWkbX00E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lmlo2THHg+n2X+uz9k1n6POoLLoqwiGzztrs9qMqrDf89/N6eCnKyDMRH+owHEnWSH6XM5wb7Bpk8WFbrxE/8tMQhdzylxzns/qBliq6rV5+aOEQcdlbuZ072zPr18dZXiP0cwkzyp1tKqySSaaWDFpEb+mByDPpm1jwlZjD+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9201572ebfbso514826339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045184; x=1760649984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhbW8qB6rW7nVXNP9EUHsgAYOikSRL0hxiDRm9eT8/4=;
        b=Zb/wghRBEJU1UKRswtgDnvphv9K1QbqMlghqX66Zz9Yf6Eh2AbFjB2wgSBt8mkOeHA
         KFwWc2ICPHqT87XkIQk8Mr95oQVVd5zKHv3nzXCTJXh/HWOFbMuQDuMbn63f1PiX8+sN
         g5AiQHKvRIuOfmaWPovxmHlssw8acMu1s5VUIfSjtJwxgrlMJRzxSFXi/guwmidshHDs
         bwQ0Pq6xj+Ha9c+6j/p0SupX04sCTeszRYaTUwZOhuoD4yMusL3RFzqQOhEN8caOvrKN
         xsQf9cfIifIkUByAE5aG2cpaOpVj8f1F4XnOy8EGijnbdv328xQelo4GxqVJx3N1GI60
         mjGQ==
X-Gm-Message-State: AOJu0Yznyyr/aJmlPSUCoyLydU5TzBNPDqlCS3TJX1XAcieJ5tJVya8J
	Ks9U8Mca82Rxl+T7KgeirZgVcZOafWBD13+qVtXXnY4PnNQpAqNfJVUq3F69zPTEv3hjfpWxQkE
	3ykNbSY0eG983kvcV+KlsKTFU+w4PUnYUW5/6iBhBxv6RX9lheHAVyYVZ5qE=
X-Google-Smtp-Source: AGHT+IHGY69twGkS4WmxQz8JNhrEb8VdSJI9t/799BC0TxnAkixPOSfGREnISXFKabXsFaR4jJ1uKkdS//jwBdFwM8ZhptRAYrlx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a83:b0:93b:ac33:55ca with SMTP id
 ca18e2360f4ac-93bd198fcccmr795085139f.19.1760045183855; Thu, 09 Oct 2025
 14:26:23 -0700 (PDT)
Date: Thu, 09 Oct 2025 14:26:23 -0700
In-Reply-To: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8287f.050a0220.91a22.000d.GAE@google.com>
Subject: Forwarded: Re: [bpf?] [net?] BUG: sleeping function called from
 invalid context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [bpf?] [net?] BUG: sleeping function called from invalid context in sock_map_delete_elem
Author: listout@listout.xyz

#syz test

--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -38,10 +38,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
 	rcu_read_lock();
-	if (t->mode == NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
+	migrate_disable();
 
 	t->time_start = ktime_get_ns();
 }
@@ -51,10 +48,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 {
 	t->time_start = 0;
 
-	if (t->mode == NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
+	migrate_enable();
 	rcu_read_unlock();
 }
 

-- 
Regards,
listout

